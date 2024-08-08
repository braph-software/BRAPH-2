classdef NNCrossValidation < ConcreteElement
	%NNCrossValidation is a process for evaluating a neural network model using cross-validation.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A cross-validation (NNCrossValidation) is a process that facilitates the evaluation of neural network models using cross-validation. 
	%  It involves splitting a dataset into multiple subsets (folds), training the model on some folds while validating on others, and then repeating the process for all combinations of folds. 
	%  This helps in assessing the generalization performance of the model and detecting overfitting.
	% 
	% To train all the neural networks for all folds, use: nncv.get('TRAIN')
	%
	% NNCrossValidation methods (constructor):
	%  NNCrossValidation - constructor
	%
	% NNCrossValidation methods:
	%  set - sets values of a property
	%  check - checks the values of all properties
	%  getr - returns the raw value of a property
	%  get - returns the value of a property
	%  memorize - returns the value of a property and memorizes it
	%             (for RESULT, QUERY, and EVANESCENT properties)
	%  getPropSeed - returns the seed of a property
	%  isLocked - returns whether a property is locked
	%  lock - locks unreversibly a property
	%  isChecked - returns whether a property is checked
	%  checked - sets a property to checked
	%  unchecked - sets a property to NOT checked
	%
	% NNCrossValidation methods (display):
	%  tostring - string with information about the neural network cross-validation
	%  disp - displays information about the neural network cross-validation
	%  tree - displays the tree of the neural network cross-validation
	%
	% NNCrossValidation methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network cross-validation are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network cross-validation
	%
	% NNCrossValidation methods (save/load, Static):
	%  save - saves BRAPH2 neural network cross-validation as b2 file
	%  load - loads a BRAPH2 neural network cross-validation from a b2 file
	%
	% NNCrossValidation method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network cross-validation
	%
	% NNCrossValidation method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network cross-validation
	%
	% NNCrossValidation methods (inspection, Static):
	%  getClass - returns the class of the neural network cross-validation
	%  getSubclasses - returns all subclasses of NNCrossValidation
	%  getProps - returns the property list of the neural network cross-validation
	%  getPropNumber - returns the property number of the neural network cross-validation
	%  existsProp - checks whether property exists/error
	%  existsTag - checks whether tag exists/error
	%  getPropProp - returns the property number of a property
	%  getPropTag - returns the tag of a property
	%  getPropCategory - returns the category of a property
	%  getPropFormat - returns the format of a property
	%  getPropDescription - returns the description of a property
	%  getPropSettings - returns the settings of a property
	%  getPropDefault - returns the default value of a property
	%  getPropDefaultConditioned - returns the conditioned default value of a property
	%  checkProp - checks whether a value has the correct format/error
	%
	% NNCrossValidation methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNCrossValidation methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNCrossValidation methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNCrossValidation methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatTag - returns the tag of a format
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNCrossValidation; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNCrossValidation constants</a>.
	%
	%
	% See also NNDataset, NNEvaluator, NNBase.
	
	properties (Constant) % properties
		WAITBAR = ConcreteElement.getPropNumber() + 1;
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = Category.GUI;
		WAITBAR_FORMAT = Format.LOGICAL;
		
		KFOLDS = ConcreteElement.getPropNumber() + 2;
		KFOLDS_TAG = 'KFOLDS';
		KFOLDS_CATEGORY = Category.DATA;
		KFOLDS_FORMAT = Format.SCALAR;
		
		SPLIT = ConcreteElement.getPropNumber() + 3;
		SPLIT_TAG = 'SPLIT';
		SPLIT_CATEGORY = Category.DATA;
		SPLIT_FORMAT = Format.CELL;
		
		D = ConcreteElement.getPropNumber() + 4;
		D_TAG = 'D';
		D_CATEGORY = Category.DATA;
		D_FORMAT = Format.ITEMLIST;
		
		NN_TEMPLATE = ConcreteElement.getPropNumber() + 5;
		NN_TEMPLATE_TAG = 'NN_TEMPLATE';
		NN_TEMPLATE_CATEGORY = Category.PARAMETER;
		NN_TEMPLATE_FORMAT = Format.ITEM;
		
		NNEVALUATOR_TEMPLATE = ConcreteElement.getPropNumber() + 6;
		NNEVALUATOR_TEMPLATE_TAG = 'NNEVALUATOR_TEMPLATE';
		NNEVALUATOR_TEMPLATE_CATEGORY = Category.PARAMETER;
		NNEVALUATOR_TEMPLATE_FORMAT = Format.ITEM;
		
		DSP = ConcreteElement.getPropNumber() + 7;
		DSP_TAG = 'DSP';
		DSP_CATEGORY = Category.RESULT;
		DSP_FORMAT = Format.ITEMLIST;
		
		DCO = ConcreteElement.getPropNumber() + 8;
		DCO_TAG = 'DCO';
		DCO_CATEGORY = Category.RESULT;
		DCO_FORMAT = Format.ITEMLIST;
		
		D_LIST = ConcreteElement.getPropNumber() + 9;
		D_LIST_TAG = 'D_LIST';
		D_LIST_CATEGORY = Category.RESULT;
		D_LIST_FORMAT = Format.ITEMLIST;
		
		D_LIST_IT = ConcreteElement.getPropNumber() + 10;
		D_LIST_IT_TAG = 'D_LIST_IT';
		D_LIST_IT_CATEGORY = Category.QUERY;
		D_LIST_IT_FORMAT = Format.ITEM;
		
		NN_LIST = ConcreteElement.getPropNumber() + 11;
		NN_LIST_TAG = 'NN_LIST';
		NN_LIST_CATEGORY = Category.RESULT;
		NN_LIST_FORMAT = Format.ITEMLIST;
		
		NN_LIST_IT = ConcreteElement.getPropNumber() + 12;
		NN_LIST_IT_TAG = 'NN_LIST_IT';
		NN_LIST_IT_CATEGORY = Category.QUERY;
		NN_LIST_IT_FORMAT = Format.ITEM;
		
		EVALUATOR_LIST = ConcreteElement.getPropNumber() + 13;
		EVALUATOR_LIST_TAG = 'EVALUATOR_LIST';
		EVALUATOR_LIST_CATEGORY = Category.RESULT;
		EVALUATOR_LIST_FORMAT = Format.ITEMLIST;
		
		EVALUATOR_LIST_IT = ConcreteElement.getPropNumber() + 14;
		EVALUATOR_LIST_IT_TAG = 'EVALUATOR_LIST_IT';
		EVALUATOR_LIST_IT_CATEGORY = Category.QUERY;
		EVALUATOR_LIST_IT_FORMAT = Format.ITEM;
		
		EPOCHS = ConcreteElement.getPropNumber() + 15;
		EPOCHS_TAG = 'EPOCHS';
		EPOCHS_CATEGORY = Category.PARAMETER;
		EPOCHS_FORMAT = Format.SCALAR;
		
		BATCH = ConcreteElement.getPropNumber() + 16;
		BATCH_TAG = 'BATCH';
		BATCH_CATEGORY = Category.PARAMETER;
		BATCH_FORMAT = Format.SCALAR;
		
		SHUFFLE = ConcreteElement.getPropNumber() + 17;
		SHUFFLE_TAG = 'SHUFFLE';
		SHUFFLE_CATEGORY = Category.PARAMETER;
		SHUFFLE_FORMAT = Format.OPTION;
		
		SOLVER = ConcreteElement.getPropNumber() + 18;
		SOLVER_TAG = 'SOLVER';
		SOLVER_CATEGORY = Category.PARAMETER;
		SOLVER_FORMAT = Format.OPTION;
		
		VERBOSE = ConcreteElement.getPropNumber() + 19;
		VERBOSE_TAG = 'VERBOSE';
		VERBOSE_CATEGORY = Category.METADATA;
		VERBOSE_FORMAT = Format.LOGICAL;
		
		PLOT_TRAINING = ConcreteElement.getPropNumber() + 20;
		PLOT_TRAINING_TAG = 'PLOT_TRAINING';
		PLOT_TRAINING_CATEGORY = Category.METADATA;
		PLOT_TRAINING_FORMAT = Format.OPTION;
		
		TRAIN = ConcreteElement.getPropNumber() + 21;
		TRAIN_TAG = 'TRAIN';
		TRAIN_CATEGORY = Category.QUERY;
		TRAIN_FORMAT = Format.EMPTY;
	end
	methods % constructor
		function nncv = NNCrossValidation(varargin)
			%NNCrossValidation() creates a neural network cross-validation.
			%
			% NNCrossValidation(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNCrossValidation(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			nncv = nncv@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function nncv_class = getClass()
			%GETCLASS returns the class of the neural network cross-validation.
			%
			% CLASS = NNCrossValidation.GETCLASS() returns the class 'NNCrossValidation'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNCV.GETCLASS() returns the class of the neural network cross-validation NNCV.
			%  CLASS = Element.GETCLASS(NNCV) returns the class of 'NNCV'.
			%  CLASS = Element.GETCLASS('NNCrossValidation') returns 'NNCrossValidation'.
			%
			% Note that the Element.GETCLASS(NNCV) and Element.GETCLASS('NNCrossValidation')
			%  are less computationally efficient.
			
			nncv_class = 'NNCrossValidation';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network cross-validation.
			%
			% LIST = NNCrossValidation.GETSUBCLASSES() returns all subclasses of 'NNCrossValidation'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNCV.GETSUBCLASSES() returns all subclasses of the neural network cross-validation NNCV.
			%  LIST = Element.GETSUBCLASSES(NNCV) returns all subclasses of 'NNCV'.
			%  LIST = Element.GETSUBCLASSES('NNCrossValidation') returns all subclasses of 'NNCrossValidation'.
			%
			% Note that the Element.GETSUBCLASSES(NNCV) and Element.GETSUBCLASSES('NNCrossValidation')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNCrossValidation', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network cross-validation.
			%
			% PROPS = NNCrossValidation.GETPROPS() returns the property list of neural network cross-validation
			%  as a row vector.
			%
			% PROPS = NNCrossValidation.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNCV.GETPROPS([CATEGORY]) returns the property list of the neural network cross-validation NNCV.
			%  PROPS = Element.GETPROPS(NNCV[, CATEGORY]) returns the property list of 'NNCV'.
			%  PROPS = Element.GETPROPS('NNCrossValidation'[, CATEGORY]) returns the property list of 'NNCrossValidation'.
			%
			% Note that the Element.GETPROPS(NNCV) and Element.GETPROPS('NNCrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						NNCrossValidation.WAITBAR ...
						NNCrossValidation.KFOLDS ...
						NNCrossValidation.SPLIT ...
						NNCrossValidation.D ...
						NNCrossValidation.NN_TEMPLATE ...
						NNCrossValidation.NNEVALUATOR_TEMPLATE ...
						NNCrossValidation.DSP ...
						NNCrossValidation.DCO ...
						NNCrossValidation.D_LIST ...
						NNCrossValidation.D_LIST_IT ...
						NNCrossValidation.NN_LIST ...
						NNCrossValidation.NN_LIST_IT ...
						NNCrossValidation.EVALUATOR_LIST ...
						NNCrossValidation.EVALUATOR_LIST_IT ...
						NNCrossValidation.EPOCHS ...
						NNCrossValidation.BATCH ...
						NNCrossValidation.SHUFFLE ...
						NNCrossValidation.SOLVER ...
						NNCrossValidation.VERBOSE ...
						NNCrossValidation.PLOT_TRAINING ...
						NNCrossValidation.TRAIN ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						NNCrossValidation.VERBOSE ...
						NNCrossValidation.PLOT_TRAINING ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						NNCrossValidation.NN_TEMPLATE ...
						NNCrossValidation.NNEVALUATOR_TEMPLATE ...
						NNCrossValidation.EPOCHS ...
						NNCrossValidation.BATCH ...
						NNCrossValidation.SHUFFLE ...
						NNCrossValidation.SOLVER ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						NNCrossValidation.KFOLDS ...
						NNCrossValidation.SPLIT ...
						NNCrossValidation.D ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						NNCrossValidation.DSP ...
						NNCrossValidation.DCO ...
						NNCrossValidation.D_LIST ...
						NNCrossValidation.NN_LIST ...
						NNCrossValidation.EVALUATOR_LIST ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						NNCrossValidation.D_LIST_IT ...
						NNCrossValidation.NN_LIST_IT ...
						NNCrossValidation.EVALUATOR_LIST_IT ...
						NNCrossValidation.TRAIN ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						NNCrossValidation.WAITBAR ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network cross-validation.
			%
			% N = NNCrossValidation.GETPROPNUMBER() returns the property number of neural network cross-validation.
			%
			% N = NNCrossValidation.GETPROPNUMBER(CATEGORY) returns the property number of neural network cross-validation
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNCV.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network cross-validation NNCV.
			%  N = Element.GETPROPNUMBER(NNCV) returns the property number of 'NNCV'.
			%  N = Element.GETPROPNUMBER('NNCrossValidation') returns the property number of 'NNCrossValidation'.
			%
			% Note that the Element.GETPROPNUMBER(NNCV) and Element.GETPROPNUMBER('NNCrossValidation')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNCrossValidation.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network cross-validation/error.
			%
			% CHECK = NNCrossValidation.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNCV.EXISTSPROP(PROP) checks whether PROP exists for NNCV.
			%  CHECK = Element.EXISTSPROP(NNCV, PROP) checks whether PROP exists for NNCV.
			%  CHECK = Element.EXISTSPROP(NNCrossValidation, PROP) checks whether PROP exists for NNCrossValidation.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNCrossValidation:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNCV.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNCrossValidation:WrongInput]
			%  Element.EXISTSPROP(NNCV, PROP) throws error if PROP does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNCrossValidation:WrongInput]
			%  Element.EXISTSPROP(NNCrossValidation, PROP) throws error if PROP does NOT exist for NNCrossValidation.
			%   Error id: [BRAPH2:NNCrossValidation:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNCV) and Element.EXISTSPROP('NNCrossValidation')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNCrossValidation.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNCrossValidation:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNCrossValidation:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNCrossValidation.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network cross-validation/error.
			%
			% CHECK = NNCrossValidation.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNCV.EXISTSTAG(TAG) checks whether TAG exists for NNCV.
			%  CHECK = Element.EXISTSTAG(NNCV, TAG) checks whether TAG exists for NNCV.
			%  CHECK = Element.EXISTSTAG(NNCrossValidation, TAG) checks whether TAG exists for NNCrossValidation.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNCrossValidation:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNCV.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNCrossValidation:WrongInput]
			%  Element.EXISTSTAG(NNCV, TAG) throws error if TAG does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNCrossValidation:WrongInput]
			%  Element.EXISTSTAG(NNCrossValidation, TAG) throws error if TAG does NOT exist for NNCrossValidation.
			%   Error id: [BRAPH2:NNCrossValidation:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNCV) and Element.EXISTSTAG('NNCrossValidation')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nncrossvalidation_tag_list = cellfun(@(x) NNCrossValidation.getPropTag(x), num2cell(NNCrossValidation.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nncrossvalidation_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNCrossValidation:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNCrossValidation:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNCrossValidation.'] ...
					)
			end
		end
		function prop = getPropProp(pointer)
			%GETPROPPROP returns the property number of a property.
			%
			% PROP = Element.GETPROPPROP(PROP) returns PROP, i.e., the 
			%  property number of the property PROP.
			%
			% PROP = Element.GETPROPPROP(TAG) returns the property number 
			%  of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PROPERTY = NNCV.GETPROPPROP(POINTER) returns property number of POINTER of NNCV.
			%  PROPERTY = Element.GETPROPPROP(NNCrossValidation, POINTER) returns property number of POINTER of NNCrossValidation.
			%  PROPERTY = NNCV.GETPROPPROP(NNCrossValidation, POINTER) returns property number of POINTER of NNCrossValidation.
			%
			% Note that the Element.GETPROPPROP(NNCV) and Element.GETPROPPROP('NNCrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nncrossvalidation_tag_list = cellfun(@(x) NNCrossValidation.getPropTag(x), num2cell(NNCrossValidation.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nncrossvalidation_tag_list)); % tag = pointer
			else % numeric
				prop = pointer;
			end
		end
		function tag = getPropTag(pointer)
			%GETPROPTAG returns the tag of a property.
			%
			% TAG = Element.GETPROPTAG(PROP) returns the tag TAG of the 
			%  property PROP.
			%
			% TAG = Element.GETPROPTAG(TAG) returns TAG, i.e. the tag of 
			%  the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  TAG = NNCV.GETPROPTAG(POINTER) returns tag of POINTER of NNCV.
			%  TAG = Element.GETPROPTAG(NNCrossValidation, POINTER) returns tag of POINTER of NNCrossValidation.
			%  TAG = NNCV.GETPROPTAG(NNCrossValidation, POINTER) returns tag of POINTER of NNCrossValidation.
			%
			% Note that the Element.GETPROPTAG(NNCV) and Element.GETPROPTAG('NNCrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNCrossValidation.WAITBAR
						tag = NNCrossValidation.WAITBAR_TAG;
					case NNCrossValidation.KFOLDS
						tag = NNCrossValidation.KFOLDS_TAG;
					case NNCrossValidation.SPLIT
						tag = NNCrossValidation.SPLIT_TAG;
					case NNCrossValidation.D
						tag = NNCrossValidation.D_TAG;
					case NNCrossValidation.NN_TEMPLATE
						tag = NNCrossValidation.NN_TEMPLATE_TAG;
					case NNCrossValidation.NNEVALUATOR_TEMPLATE
						tag = NNCrossValidation.NNEVALUATOR_TEMPLATE_TAG;
					case NNCrossValidation.DSP
						tag = NNCrossValidation.DSP_TAG;
					case NNCrossValidation.DCO
						tag = NNCrossValidation.DCO_TAG;
					case NNCrossValidation.D_LIST
						tag = NNCrossValidation.D_LIST_TAG;
					case NNCrossValidation.D_LIST_IT
						tag = NNCrossValidation.D_LIST_IT_TAG;
					case NNCrossValidation.NN_LIST
						tag = NNCrossValidation.NN_LIST_TAG;
					case NNCrossValidation.NN_LIST_IT
						tag = NNCrossValidation.NN_LIST_IT_TAG;
					case NNCrossValidation.EVALUATOR_LIST
						tag = NNCrossValidation.EVALUATOR_LIST_TAG;
					case NNCrossValidation.EVALUATOR_LIST_IT
						tag = NNCrossValidation.EVALUATOR_LIST_IT_TAG;
					case NNCrossValidation.EPOCHS
						tag = NNCrossValidation.EPOCHS_TAG;
					case NNCrossValidation.BATCH
						tag = NNCrossValidation.BATCH_TAG;
					case NNCrossValidation.SHUFFLE
						tag = NNCrossValidation.SHUFFLE_TAG;
					case NNCrossValidation.SOLVER
						tag = NNCrossValidation.SOLVER_TAG;
					case NNCrossValidation.VERBOSE
						tag = NNCrossValidation.VERBOSE_TAG;
					case NNCrossValidation.PLOT_TRAINING
						tag = NNCrossValidation.PLOT_TRAINING_TAG;
					case NNCrossValidation.TRAIN
						tag = NNCrossValidation.TRAIN_TAG;
					otherwise
						tag = getPropTag@ConcreteElement(prop);
				end
			end
		end
		function prop_category = getPropCategory(pointer)
			%GETPROPCATEGORY returns the category of a property.
			%
			% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the category of the
			%  property PROP.
			%
			% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the category of the
			%  property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CATEGORY = NNCV.GETPROPCATEGORY(POINTER) returns category of POINTER of NNCV.
			%  CATEGORY = Element.GETPROPCATEGORY(NNCrossValidation, POINTER) returns category of POINTER of NNCrossValidation.
			%  CATEGORY = NNCV.GETPROPCATEGORY(NNCrossValidation, POINTER) returns category of POINTER of NNCrossValidation.
			%
			% Note that the Element.GETPROPCATEGORY(NNCV) and Element.GETPROPCATEGORY('NNCrossValidation')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNCrossValidation.getPropProp(pointer);
			
			switch prop
				case NNCrossValidation.WAITBAR
					prop_category = NNCrossValidation.WAITBAR_CATEGORY;
				case NNCrossValidation.KFOLDS
					prop_category = NNCrossValidation.KFOLDS_CATEGORY;
				case NNCrossValidation.SPLIT
					prop_category = NNCrossValidation.SPLIT_CATEGORY;
				case NNCrossValidation.D
					prop_category = NNCrossValidation.D_CATEGORY;
				case NNCrossValidation.NN_TEMPLATE
					prop_category = NNCrossValidation.NN_TEMPLATE_CATEGORY;
				case NNCrossValidation.NNEVALUATOR_TEMPLATE
					prop_category = NNCrossValidation.NNEVALUATOR_TEMPLATE_CATEGORY;
				case NNCrossValidation.DSP
					prop_category = NNCrossValidation.DSP_CATEGORY;
				case NNCrossValidation.DCO
					prop_category = NNCrossValidation.DCO_CATEGORY;
				case NNCrossValidation.D_LIST
					prop_category = NNCrossValidation.D_LIST_CATEGORY;
				case NNCrossValidation.D_LIST_IT
					prop_category = NNCrossValidation.D_LIST_IT_CATEGORY;
				case NNCrossValidation.NN_LIST
					prop_category = NNCrossValidation.NN_LIST_CATEGORY;
				case NNCrossValidation.NN_LIST_IT
					prop_category = NNCrossValidation.NN_LIST_IT_CATEGORY;
				case NNCrossValidation.EVALUATOR_LIST
					prop_category = NNCrossValidation.EVALUATOR_LIST_CATEGORY;
				case NNCrossValidation.EVALUATOR_LIST_IT
					prop_category = NNCrossValidation.EVALUATOR_LIST_IT_CATEGORY;
				case NNCrossValidation.EPOCHS
					prop_category = NNCrossValidation.EPOCHS_CATEGORY;
				case NNCrossValidation.BATCH
					prop_category = NNCrossValidation.BATCH_CATEGORY;
				case NNCrossValidation.SHUFFLE
					prop_category = NNCrossValidation.SHUFFLE_CATEGORY;
				case NNCrossValidation.SOLVER
					prop_category = NNCrossValidation.SOLVER_CATEGORY;
				case NNCrossValidation.VERBOSE
					prop_category = NNCrossValidation.VERBOSE_CATEGORY;
				case NNCrossValidation.PLOT_TRAINING
					prop_category = NNCrossValidation.PLOT_TRAINING_CATEGORY;
				case NNCrossValidation.TRAIN
					prop_category = NNCrossValidation.TRAIN_CATEGORY;
				otherwise
					prop_category = getPropCategory@ConcreteElement(prop);
			end
		end
		function prop_format = getPropFormat(pointer)
			%GETPROPFORMAT returns the format of a property.
			%
			% FORMAT = Element.GETPROPFORMAT(PROP) returns the
			%  format of the property PROP.
			%
			% FORMAT = Element.GETPROPFORMAT(TAG) returns the
			%  format of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  FORMAT = NNCV.GETPROPFORMAT(POINTER) returns format of POINTER of NNCV.
			%  FORMAT = Element.GETPROPFORMAT(NNCrossValidation, POINTER) returns format of POINTER of NNCrossValidation.
			%  FORMAT = NNCV.GETPROPFORMAT(NNCrossValidation, POINTER) returns format of POINTER of NNCrossValidation.
			%
			% Note that the Element.GETPROPFORMAT(NNCV) and Element.GETPROPFORMAT('NNCrossValidation')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNCrossValidation.getPropProp(pointer);
			
			switch prop
				case NNCrossValidation.WAITBAR
					prop_format = NNCrossValidation.WAITBAR_FORMAT;
				case NNCrossValidation.KFOLDS
					prop_format = NNCrossValidation.KFOLDS_FORMAT;
				case NNCrossValidation.SPLIT
					prop_format = NNCrossValidation.SPLIT_FORMAT;
				case NNCrossValidation.D
					prop_format = NNCrossValidation.D_FORMAT;
				case NNCrossValidation.NN_TEMPLATE
					prop_format = NNCrossValidation.NN_TEMPLATE_FORMAT;
				case NNCrossValidation.NNEVALUATOR_TEMPLATE
					prop_format = NNCrossValidation.NNEVALUATOR_TEMPLATE_FORMAT;
				case NNCrossValidation.DSP
					prop_format = NNCrossValidation.DSP_FORMAT;
				case NNCrossValidation.DCO
					prop_format = NNCrossValidation.DCO_FORMAT;
				case NNCrossValidation.D_LIST
					prop_format = NNCrossValidation.D_LIST_FORMAT;
				case NNCrossValidation.D_LIST_IT
					prop_format = NNCrossValidation.D_LIST_IT_FORMAT;
				case NNCrossValidation.NN_LIST
					prop_format = NNCrossValidation.NN_LIST_FORMAT;
				case NNCrossValidation.NN_LIST_IT
					prop_format = NNCrossValidation.NN_LIST_IT_FORMAT;
				case NNCrossValidation.EVALUATOR_LIST
					prop_format = NNCrossValidation.EVALUATOR_LIST_FORMAT;
				case NNCrossValidation.EVALUATOR_LIST_IT
					prop_format = NNCrossValidation.EVALUATOR_LIST_IT_FORMAT;
				case NNCrossValidation.EPOCHS
					prop_format = NNCrossValidation.EPOCHS_FORMAT;
				case NNCrossValidation.BATCH
					prop_format = NNCrossValidation.BATCH_FORMAT;
				case NNCrossValidation.SHUFFLE
					prop_format = NNCrossValidation.SHUFFLE_FORMAT;
				case NNCrossValidation.SOLVER
					prop_format = NNCrossValidation.SOLVER_FORMAT;
				case NNCrossValidation.VERBOSE
					prop_format = NNCrossValidation.VERBOSE_FORMAT;
				case NNCrossValidation.PLOT_TRAINING
					prop_format = NNCrossValidation.PLOT_TRAINING_FORMAT;
				case NNCrossValidation.TRAIN
					prop_format = NNCrossValidation.TRAIN_FORMAT;
				otherwise
					prop_format = getPropFormat@ConcreteElement(prop);
			end
		end
		function prop_description = getPropDescription(pointer)
			%GETPROPDESCRIPTION returns the description of a property.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(PROP) returns the
			%  description of the property PROP.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(TAG) returns the
			%  description of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DESCRIPTION = NNCV.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNCV.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNCrossValidation, POINTER) returns description of POINTER of NNCrossValidation.
			%  DESCRIPTION = NNCV.GETPROPDESCRIPTION(NNCrossValidation, POINTER) returns description of POINTER of NNCrossValidation.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNCV) and Element.GETPROPDESCRIPTION('NNCrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNCrossValidation.getPropProp(pointer);
			
			switch prop
				case NNCrossValidation.WAITBAR
					prop_description = 'WAITBAR (gui, logical) detemines whether to show the waitbar.';
				case NNCrossValidation.KFOLDS
					prop_description = 'KFOLDS (data, scalar) is the number of folds.';
				case NNCrossValidation.SPLIT
					prop_description = 'SPLIT (data, cell) is a cell containing the ratio numbers or the vectors stating which datapoints belong to the splitted neural network datasets.';
				case NNCrossValidation.D
					prop_description = 'D (data, itemlist) is the datasets from groups to be cross-validated.';
				case NNCrossValidation.NN_TEMPLATE
					prop_description = 'NN_TEMPLATE (parameter, item) is the neural network template to set all neural network parameters.';
				case NNCrossValidation.NNEVALUATOR_TEMPLATE
					prop_description = 'NNEVALUATOR_TEMPLATE (parameter, item) is the neural network evaluator template to set all evalutor parameters.';
				case NNCrossValidation.DSP
					prop_description = 'DSP (result, itemlist) is a list of dataset splitter that splits the dataset per group.';
				case NNCrossValidation.DCO
					prop_description = 'DCO (result, itemlist) is a list of dataset combiners that combines the datasets per fold.';
				case NNCrossValidation.D_LIST
					prop_description = 'D_LIST (result, itemlist) contains the split datasets corresponding to the k folds.';
				case NNCrossValidation.D_LIST_IT
					prop_description = 'D_LIST_IT (query, item) returns a dataset at a specified index in the itemlist of splitted neural network datasets.';
				case NNCrossValidation.NN_LIST
					prop_description = 'NN_LIST (result, itemlist) contains the neural network models corresponding to the k folds.';
				case NNCrossValidation.NN_LIST_IT
					prop_description = 'NN_LIST_IT (query, item) returns a neural networks model at a specified index in the itemlist of splitted neural network datasets.';
				case NNCrossValidation.EVALUATOR_LIST
					prop_description = 'EVALUATOR_LIST (result, itemlist) contains the evaluators corresponding to the k folds.';
				case NNCrossValidation.EVALUATOR_LIST_IT
					prop_description = 'EVALUATOR_LIST_IT (query, item) returns a neural networks evaluator at a specified index in the itemlist of splitted neural network datasets.';
				case NNCrossValidation.EPOCHS
					prop_description = 'EPOCHS (parameter, scalar) is the maximum number of epochs.';
				case NNCrossValidation.BATCH
					prop_description = 'BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.';
				case NNCrossValidation.SHUFFLE
					prop_description = 'SHUFFLE (parameter, option) is an option for data shuffling.';
				case NNCrossValidation.SOLVER
					prop_description = 'SOLVER (parameter, option) is an option for the solver.';
				case NNCrossValidation.VERBOSE
					prop_description = 'VERBOSE (metadata, logical) is an indicator to display training progress information.';
				case NNCrossValidation.PLOT_TRAINING
					prop_description = 'PLOT_TRAINING (metadata, option) determines whether to plot the training progress.';
				case NNCrossValidation.TRAIN
					prop_description = 'TRAIN (query, empty) trains all neural network models for all folds.';
				case NNCrossValidation.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the element to evaluate a neural network model using cross-validation.';
				case NNCrossValidation.NAME
					prop_description = 'NAME (constant, string) is the name of the element to evaluate a neural network model using cross-validation.';
				case NNCrossValidation.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the element to evaluate a neural network model using cross-validation.';
				case NNCrossValidation.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the element to evaluate a neural network model using cross-validation.';
				case NNCrossValidation.ID
					prop_description = 'ID (data, string) is a few-letter code of the element to evaluate a neural network model using cross-validation.';
				case NNCrossValidation.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the element to evaluate a neural network model using cross-validation.';
				case NNCrossValidation.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the evaluating neural network model using cross-validation.';
				otherwise
					prop_description = getPropDescription@ConcreteElement(prop);
			end
		end
		function prop_settings = getPropSettings(pointer)
			%GETPROPSETTINGS returns the settings of a property.
			%
			% SETTINGS = Element.GETPROPSETTINGS(PROP) returns the
			%  settings of the property PROP.
			%
			% SETTINGS = Element.GETPROPSETTINGS(TAG) returns the
			%  settings of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SETTINGS = NNCV.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNCV.
			%  SETTINGS = Element.GETPROPSETTINGS(NNCrossValidation, POINTER) returns settings of POINTER of NNCrossValidation.
			%  SETTINGS = NNCV.GETPROPSETTINGS(NNCrossValidation, POINTER) returns settings of POINTER of NNCrossValidation.
			%
			% Note that the Element.GETPROPSETTINGS(NNCV) and Element.GETPROPSETTINGS('NNCrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNCrossValidation.getPropProp(pointer);
			
			switch prop
				case NNCrossValidation.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNCrossValidation.KFOLDS
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNCrossValidation.SPLIT
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNCrossValidation.D
					prop_settings = 'NNDataset';
				case NNCrossValidation.NN_TEMPLATE
					prop_settings = 'NNBase';
				case NNCrossValidation.NNEVALUATOR_TEMPLATE
					prop_settings = 'NNEvaluator';
				case NNCrossValidation.DSP
					prop_settings = 'NNDatasetSplit';
				case NNCrossValidation.DCO
					prop_settings = 'NNDatasetCombine';
				case NNCrossValidation.D_LIST
					prop_settings = Format.getFormatSettings(Format.ITEMLIST);
				case NNCrossValidation.D_LIST_IT
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case NNCrossValidation.NN_LIST
					prop_settings = Format.getFormatSettings(Format.ITEMLIST);
				case NNCrossValidation.NN_LIST_IT
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case NNCrossValidation.EVALUATOR_LIST
					prop_settings = Format.getFormatSettings(Format.ITEMLIST);
				case NNCrossValidation.EVALUATOR_LIST_IT
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case NNCrossValidation.EPOCHS
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNCrossValidation.BATCH
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNCrossValidation.SHUFFLE
					prop_settings = {'once' 'never' 'every-epoch'};
				case NNCrossValidation.SOLVER
					prop_settings = {'adam' 'sgdm' 'rmsprop'};
				case NNCrossValidation.VERBOSE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNCrossValidation.PLOT_TRAINING
					prop_settings = {'none' 'training-progress'};
				case NNCrossValidation.TRAIN
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case NNCrossValidation.TEMPLATE
					prop_settings = 'NNCrossValidation';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNCrossValidation.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNCrossValidation.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNCV.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNCV.
			%  DEFAULT = Element.GETPROPDEFAULT(NNCrossValidation, POINTER) returns the default value of POINTER of NNCrossValidation.
			%  DEFAULT = NNCV.GETPROPDEFAULT(NNCrossValidation, POINTER) returns the default value of POINTER of NNCrossValidation.
			%
			% Note that the Element.GETPROPDEFAULT(NNCV) and Element.GETPROPDEFAULT('NNCrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNCrossValidation.getPropProp(pointer);
			
			switch prop
				case NNCrossValidation.WAITBAR
					prop_default = true;
				case NNCrossValidation.KFOLDS
					prop_default = 5;
				case NNCrossValidation.SPLIT
					prop_default = Format.getFormatDefault(Format.CELL, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.D
					prop_default = Format.getFormatDefault(Format.ITEMLIST, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.NN_TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.NNEVALUATOR_TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.DSP
					prop_default = Format.getFormatDefault(Format.ITEMLIST, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.DCO
					prop_default = Format.getFormatDefault(Format.ITEMLIST, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.D_LIST
					prop_default = Format.getFormatDefault(Format.ITEMLIST, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.D_LIST_IT
					prop_default = Format.getFormatDefault(Format.ITEM, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.NN_LIST
					prop_default = Format.getFormatDefault(Format.ITEMLIST, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.NN_LIST_IT
					prop_default = Format.getFormatDefault(Format.ITEM, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.EVALUATOR_LIST
					prop_default = Format.getFormatDefault(Format.ITEMLIST, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.EVALUATOR_LIST_IT
					prop_default = Format.getFormatDefault(Format.ITEM, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.EPOCHS
					prop_default = 20;
				case NNCrossValidation.BATCH
					prop_default = 8;
				case NNCrossValidation.SHUFFLE
					prop_default = Format.getFormatDefault(Format.OPTION, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.SOLVER
					prop_default = Format.getFormatDefault(Format.OPTION, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.VERBOSE
					prop_default = false;
				case NNCrossValidation.PLOT_TRAINING
					prop_default = Format.getFormatDefault(Format.OPTION, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.TRAIN
					prop_default = Format.getFormatDefault(Format.EMPTY, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.ELCLASS
					prop_default = 'NNCrossValidation';
				case NNCrossValidation.NAME
					prop_default = 'Neural Network Cross-Validation';
				case NNCrossValidation.DESCRIPTION
					prop_default = 'A cross-validation (NNCrossValidation) is a process that facilitates the evaluation of neural network models using cross-validation. It involves splitting a dataset into multiple subsets (folds), training the model on some folds while validating on others, and then repeating the process for all combinations of folds. This helps in assessing the generalization performance of the model and detecting overfitting.';
				case NNCrossValidation.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.ID
					prop_default = 'NNCrossValidation ID';
				case NNCrossValidation.LABEL
					prop_default = 'NNCrossValidation label';
				case NNCrossValidation.NOTES
					prop_default = 'NNCrossValidation notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNCrossValidation.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNCrossValidation.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNCV.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNCV.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNCrossValidation, POINTER) returns the conditioned default value of POINTER of NNCrossValidation.
			%  DEFAULT = NNCV.GETPROPDEFAULTCONDITIONED(NNCrossValidation, POINTER) returns the conditioned default value of POINTER of NNCrossValidation.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNCV) and Element.GETPROPDEFAULTCONDITIONED('NNCrossValidation')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNCrossValidation.getPropProp(pointer);
			
			prop_default = NNCrossValidation.conditioning(prop, NNCrossValidation.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNCV.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNCV.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNCV.
			%  CHECK = Element.CHECKPROP(NNCrossValidation, PROP, VALUE) checks VALUE format for PROP of NNCrossValidation.
			%  CHECK = NNCV.CHECKPROP(NNCrossValidation, PROP, VALUE) checks VALUE format for PROP of NNCrossValidation.
			% 
			% NNCV.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNCrossValidation:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNCV.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNCV.
			%   Error id: €BRAPH2.STR€:NNCrossValidation:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNCrossValidation, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNCrossValidation.
			%   Error id: €BRAPH2.STR€:NNCrossValidation:€BRAPH2.WRONG_INPUT€
			%  NNCV.CHECKPROP(NNCrossValidation, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNCrossValidation.
			%   Error id: €BRAPH2.STR€:NNCrossValidation:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(NNCV) and Element.CHECKPROP('NNCrossValidation')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNCrossValidation.getPropProp(pointer);
			
			switch prop
				case NNCrossValidation.WAITBAR % __NNCrossValidation.WAITBAR__
					check = Format.checkFormat(Format.LOGICAL, value, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.KFOLDS % __NNCrossValidation.KFOLDS__
					check = Format.checkFormat(Format.SCALAR, value, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.SPLIT % __NNCrossValidation.SPLIT__
					check = Format.checkFormat(Format.CELL, value, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.D % __NNCrossValidation.D__
					check = Format.checkFormat(Format.ITEMLIST, value, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.NN_TEMPLATE % __NNCrossValidation.NN_TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.NNEVALUATOR_TEMPLATE % __NNCrossValidation.NNEVALUATOR_TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.DSP % __NNCrossValidation.DSP__
					check = Format.checkFormat(Format.ITEMLIST, value, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.DCO % __NNCrossValidation.DCO__
					check = Format.checkFormat(Format.ITEMLIST, value, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.D_LIST % __NNCrossValidation.D_LIST__
					check = Format.checkFormat(Format.ITEMLIST, value, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.D_LIST_IT % __NNCrossValidation.D_LIST_IT__
					check = Format.checkFormat(Format.ITEM, value, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.NN_LIST % __NNCrossValidation.NN_LIST__
					check = Format.checkFormat(Format.ITEMLIST, value, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.NN_LIST_IT % __NNCrossValidation.NN_LIST_IT__
					check = Format.checkFormat(Format.ITEM, value, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.EVALUATOR_LIST % __NNCrossValidation.EVALUATOR_LIST__
					check = Format.checkFormat(Format.ITEMLIST, value, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.EVALUATOR_LIST_IT % __NNCrossValidation.EVALUATOR_LIST_IT__
					check = Format.checkFormat(Format.ITEM, value, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.EPOCHS % __NNCrossValidation.EPOCHS__
					check = Format.checkFormat(Format.SCALAR, value, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.BATCH % __NNCrossValidation.BATCH__
					check = Format.checkFormat(Format.SCALAR, value, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.SHUFFLE % __NNCrossValidation.SHUFFLE__
					check = Format.checkFormat(Format.OPTION, value, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.SOLVER % __NNCrossValidation.SOLVER__
					check = Format.checkFormat(Format.OPTION, value, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.VERBOSE % __NNCrossValidation.VERBOSE__
					check = Format.checkFormat(Format.LOGICAL, value, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.PLOT_TRAINING % __NNCrossValidation.PLOT_TRAINING__
					check = Format.checkFormat(Format.OPTION, value, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.TRAIN % __NNCrossValidation.TRAIN__
					check = Format.checkFormat(Format.EMPTY, value, NNCrossValidation.getPropSettings(prop));
				case NNCrossValidation.TEMPLATE % __NNCrossValidation.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNCrossValidation.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNCrossValidation:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNCrossValidation:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNCrossValidation.getPropTag(prop) ' (' NNCrossValidation.getFormatTag(NNCrossValidation.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(nncv, prop)
			%POSTSET postprocessing after a prop has been set.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing after PROP has been set. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% This postprocessing occurs only when PROP is set.
			%
			% See also conditioning, preset, checkProp, postprocessing, calculateValue,
			%  checkValue.
			
			switch prop
				case NNCrossValidation.KFOLDS % __NNCrossValidation.KFOLDS__
					kfolds = nncv.get('KFOLDS');
					nncv.set('SPLIT', repmat({1 / kfolds}, 1, kfolds));
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						postset@ConcreteElement(nncv, prop);
					end
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(nncv, prop)
			%POSTPROCESSING postprocessesing after setting.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing of PROP after setting. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% The postprocessing of all properties occurs each time set is called.
			%
			% See also conditioning, preset, checkProp, postset, calculateValue,
			%  checkValue.
			
			switch prop
				case NNCrossValidation.SPLIT % __NNCrossValidation.SPLIT__
					kfolds = nncv.get('KFOLDS');
					split = nncv.get('SPLIT');
					d = nncv.get('D');
					if isempty(split) && length(d) > 0 && d{1}.get('DP_DICT').get('LENGTH') > kfolds
					    nncv.set('SPLIT', repmat({1 / kfolds}, 1, kfolds));
					end
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						postprocessing@ConcreteElement(nncv, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nncv, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with Category.RESULT,
			%  Category.QUERY, and Category.EVANESCENT. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  Category.QUERY.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case NNCrossValidation.DSP % __NNCrossValidation.DSP__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNCrossValidation.DSP), 'twister')
					
					d_list = nncv.get('D');
					value = cellfun(@(d) NNDatasetSplit('D', d, 'SPLIT', nncv.get('SPLIT')), d_list, 'UniformOutput', false);
					
					rng(rng_settings_)
					
				case NNCrossValidation.DCO % __NNCrossValidation.DCO__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNCrossValidation.DCO), 'twister')
					
					dsp_list = nncv.get('DSP');
					if length(dsp_list) == 0
					    value = {};
					else
					    kfolds = nncv.get('KFOLDS');
					    for i = 1:1:kfolds
					        d_splitted_list = cellfun(@(dsp) dsp.get('D_LIST_IT', i), dsp_list, 'UniformOutput', false);
					        dp_dict = IndexedDictionary(...
					            'IT_CLASS', d_splitted_list{1}.get('DP_CLASS'), ...
					            'IT_LIST',  d_splitted_list ...
					            );
					        value{i} = NNDatasetCombine('D_LIST', d_splitted_list);
					    end
					    value = value';
					end
					
					rng(rng_settings_)
					
				case NNCrossValidation.D_LIST % __NNCrossValidation.D_LIST__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNCrossValidation.D_LIST), 'twister')
					
					dco_list = nncv.get('DCO');
					if length(dco_list) == 0
					    value = {};
					else
					    value = cellfun(@(dco) dco.get('D'), dco_list, 'UniformOutput', false);
					end
					
					rng(rng_settings_)
					
				case NNCrossValidation.D_LIST_IT % __NNCrossValidation.D_LIST_IT__
					% d = nncv.get('D_LIST_IT', index) returns the NNDataset at the specified 
					%  index from the D_LIST property.
					if isempty(varargin)
					    value = NNDataset();
					    return
					end
					index = varargin{1};
					
					d_list = nncv.get('D_LIST');
					
					value = d_list{index};
					
				case NNCrossValidation.NN_LIST_IT % __NNCrossValidation.NN_LIST_IT__
					% nn = nncv.get('NN_LIST_IT', index) returns the NNBase at the specified 
					%  index from the NN_LIST property.
					if isempty(varargin)
					    value = NNBase();
					    return
					end
					index = varargin{1};
					
					nn_list = nncv.get('NN_LIST');
					
					value = nn_list{index};
					
				case NNCrossValidation.EVALUATOR_LIST_IT % __NNCrossValidation.EVALUATOR_LIST_IT__
					% nne = nncv.get('EVALUATOR_LIST_IT', index) returns the NNEvaluator at the specified 
					%  index from the EVALUATOR_LIST property.
					if isempty(varargin)
					    value = NNEvaluator();
					    return
					end
					index = varargin{1};
					
					nne_list = nncv.get('EVALUATOR_LIST');
					
					value = nne_list{index};
					
				case NNCrossValidation.TRAIN % __NNCrossValidation.TRAIN__
					nn_list = nncv.memorize('NN_LIST');
					wb = braph2waitbar(nncv.get('WAITBAR'), 0, ['Train neural networks for all folds ...']);
					for i = 1:1:length(nn_list)
					     braph2waitbar(wb, i / length(nn_list), ['Train neural network model ' num2str(i) ' of ' num2str(length(nn_list)) ' ...'])
					    nn_list{i}.memorize('MODEL');
					end
					braph2waitbar(wb, 'close')
					value = [];
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(nncv, prop, varargin{:});
					else
						value = calculateValue@Element(nncv, prop, varargin{:});
					end
			end
			
		end
	end
end
