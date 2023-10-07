classdef NNBase < ConcreteElement
	%NNBase comprises a neural network model with a dataset.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Neural Network Base (NNBase) comprises a neural network model with a specific dataset.
	%  Instances of this class should not be created. Use one of its subclasses instead.
	% 
	% Its subclasses need to implement the props MODEL, INPUTS and TARGETS.
	%  Each subclass is typically optimized to work with the subclasses of NNDataPoint in the prop DP_CLASSES.
	% 
	% To train a neural network nn use: nn.get('TRAIN')
	% To obtain the prediction on a dataset D use: predictions = nn.get('PREDICT', D)
	%
	% NNBase methods (constructor):
	%  NNBase - constructor
	%
	% NNBase methods:
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
	% NNBase methods (display):
	%  tostring - string with information about the neural network
	%  disp - displays information about the neural network
	%  tree - displays the tree of the neural network
	%
	% NNBase methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network
	%
	% NNBase methods (save/load, Static):
	%  save - saves BRAPH2 neural network as b2 file
	%  load - loads a BRAPH2 neural network from a b2 file
	%
	% NNBase method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network
	%
	% NNBase method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network
	%
	% NNBase methods (inspection, Static):
	%  getClass - returns the class of the neural network
	%  getSubclasses - returns all subclasses of NNBase
	%  getProps - returns the property list of the neural network
	%  getPropNumber - returns the property number of the neural network
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
	% NNBase methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNBase methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNBase methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNBase methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNBase; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNBase constants</a>.
	%
	%
	% See also NNDataPoint, NNDataset, NNEvaluator.
	
	properties (Constant) % properties
		D = ConcreteElement.getPropNumber() + 1;
		D_TAG = 'D';
		D_CATEGORY = Category.DATA;
		D_FORMAT = Format.ITEM;
		
		DP_CLASSES = ConcreteElement.getPropNumber() + 2;
		DP_CLASSES_TAG = 'DP_CLASSES';
		DP_CLASSES_CATEGORY = Category.PARAMETER;
		DP_CLASSES_FORMAT = Format.CLASSLIST;
		
		EPOCHS = ConcreteElement.getPropNumber() + 3;
		EPOCHS_TAG = 'EPOCHS';
		EPOCHS_CATEGORY = Category.PARAMETER;
		EPOCHS_FORMAT = Format.SCALAR;
		
		BATCH = ConcreteElement.getPropNumber() + 4;
		BATCH_TAG = 'BATCH';
		BATCH_CATEGORY = Category.PARAMETER;
		BATCH_FORMAT = Format.SCALAR;
		
		SHUFFLE = ConcreteElement.getPropNumber() + 5;
		SHUFFLE_TAG = 'SHUFFLE';
		SHUFFLE_CATEGORY = Category.PARAMETER;
		SHUFFLE_FORMAT = Format.OPTION;
		
		SOLVER = ConcreteElement.getPropNumber() + 6;
		SOLVER_TAG = 'SOLVER';
		SOLVER_CATEGORY = Category.PARAMETER;
		SOLVER_FORMAT = Format.OPTION;
		
		MODEL = ConcreteElement.getPropNumber() + 7;
		MODEL_TAG = 'MODEL';
		MODEL_CATEGORY = Category.RESULT;
		MODEL_FORMAT = Format.NET;
		
		INPUTS = ConcreteElement.getPropNumber() + 8;
		INPUTS_TAG = 'INPUTS';
		INPUTS_CATEGORY = Category.QUERY;
		INPUTS_FORMAT = Format.CELL;
		
		TARGETS = ConcreteElement.getPropNumber() + 9;
		TARGETS_TAG = 'TARGETS';
		TARGETS_CATEGORY = Category.QUERY;
		TARGETS_FORMAT = Format.CELL;
		
		TRAIN = ConcreteElement.getPropNumber() + 10;
		TRAIN_TAG = 'TRAIN';
		TRAIN_CATEGORY = Category.QUERY;
		TRAIN_FORMAT = Format.EMPTY;
		
		VERBOSE = ConcreteElement.getPropNumber() + 11;
		VERBOSE_TAG = 'VERBOSE';
		VERBOSE_CATEGORY = Category.METADATA;
		VERBOSE_FORMAT = Format.LOGICAL;
		
		PLOT_TRAINING = ConcreteElement.getPropNumber() + 12;
		PLOT_TRAINING_TAG = 'PLOT_TRAINING';
		PLOT_TRAINING_CATEGORY = Category.METADATA;
		PLOT_TRAINING_FORMAT = Format.OPTION;
		
		PREDICT = ConcreteElement.getPropNumber() + 13;
		PREDICT_TAG = 'PREDICT';
		PREDICT_CATEGORY = Category.QUERY;
		PREDICT_FORMAT = Format.CELL;
	end
	methods % constructor
		function nn = NNBase(varargin)
			%NNBase() creates a neural network.
			%
			% NNBase(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNBase(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			nn = nn@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function nn_class = getClass()
			%GETCLASS returns the class of the neural network.
			%
			% CLASS = NNBase.GETCLASS() returns the class 'NNBase'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NN.GETCLASS() returns the class of the neural network NN.
			%  CLASS = Element.GETCLASS(NN) returns the class of 'NN'.
			%  CLASS = Element.GETCLASS('NNBase') returns 'NNBase'.
			%
			% Note that the Element.GETCLASS(NN) and Element.GETCLASS('NNBase')
			%  are less computationally efficient.
			
			nn_class = 'NNBase';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network.
			%
			% LIST = NNBase.GETSUBCLASSES() returns all subclasses of 'NNBase'.
			%
			% Alternative forms to call this method are:
			%  LIST = NN.GETSUBCLASSES() returns all subclasses of the neural network NN.
			%  LIST = Element.GETSUBCLASSES(NN) returns all subclasses of 'NN'.
			%  LIST = Element.GETSUBCLASSES('NNBase') returns all subclasses of 'NNBase'.
			%
			% Note that the Element.GETSUBCLASSES(NN) and Element.GETSUBCLASSES('NNBase')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNBase', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network.
			%
			% PROPS = NNBase.GETPROPS() returns the property list of neural network
			%  as a row vector.
			%
			% PROPS = NNBase.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NN.GETPROPS([CATEGORY]) returns the property list of the neural network NN.
			%  PROPS = Element.GETPROPS(NN[, CATEGORY]) returns the property list of 'NN'.
			%  PROPS = Element.GETPROPS('NNBase'[, CATEGORY]) returns the property list of 'NNBase'.
			%
			% Note that the Element.GETPROPS(NN) and Element.GETPROPS('NNBase')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						NNBase.D ...
						NNBase.DP_CLASSES ...
						NNBase.EPOCHS ...
						NNBase.BATCH ...
						NNBase.SHUFFLE ...
						NNBase.SOLVER ...
						NNBase.MODEL ...
						NNBase.INPUTS ...
						NNBase.TARGETS ...
						NNBase.TRAIN ...
						NNBase.VERBOSE ...
						NNBase.PLOT_TRAINING ...
						NNBase.PREDICT ...
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
						NNBase.VERBOSE ...
						NNBase.PLOT_TRAINING ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						NNBase.DP_CLASSES ...
						NNBase.EPOCHS ...
						NNBase.BATCH ...
						NNBase.SHUFFLE ...
						NNBase.SOLVER ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						NNBase.D ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						NNBase.MODEL ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						NNBase.INPUTS ...
						NNBase.TARGETS ...
						NNBase.TRAIN ...
						NNBase.PREDICT ...
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
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network.
			%
			% N = NNBase.GETPROPNUMBER() returns the property number of neural network.
			%
			% N = NNBase.GETPROPNUMBER(CATEGORY) returns the property number of neural network
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NN.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network NN.
			%  N = Element.GETPROPNUMBER(NN) returns the property number of 'NN'.
			%  N = Element.GETPROPNUMBER('NNBase') returns the property number of 'NNBase'.
			%
			% Note that the Element.GETPROPNUMBER(NN) and Element.GETPROPNUMBER('NNBase')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNBase.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network/error.
			%
			% CHECK = NNBase.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NN.EXISTSPROP(PROP) checks whether PROP exists for NN.
			%  CHECK = Element.EXISTSPROP(NN, PROP) checks whether PROP exists for NN.
			%  CHECK = Element.EXISTSPROP(NNBase, PROP) checks whether PROP exists for NNBase.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNBase:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NN.EXISTSPROP(PROP) throws error if PROP does NOT exist for NN.
			%   Error id: [BRAPH2:NNBase:WrongInput]
			%  Element.EXISTSPROP(NN, PROP) throws error if PROP does NOT exist for NN.
			%   Error id: [BRAPH2:NNBase:WrongInput]
			%  Element.EXISTSPROP(NNBase, PROP) throws error if PROP does NOT exist for NNBase.
			%   Error id: [BRAPH2:NNBase:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NN) and Element.EXISTSPROP('NNBase')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNBase.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNBase:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNBase:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNBase.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network/error.
			%
			% CHECK = NNBase.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NN.EXISTSTAG(TAG) checks whether TAG exists for NN.
			%  CHECK = Element.EXISTSTAG(NN, TAG) checks whether TAG exists for NN.
			%  CHECK = Element.EXISTSTAG(NNBase, TAG) checks whether TAG exists for NNBase.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNBase:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NN.EXISTSTAG(TAG) throws error if TAG does NOT exist for NN.
			%   Error id: [BRAPH2:NNBase:WrongInput]
			%  Element.EXISTSTAG(NN, TAG) throws error if TAG does NOT exist for NN.
			%   Error id: [BRAPH2:NNBase:WrongInput]
			%  Element.EXISTSTAG(NNBase, TAG) throws error if TAG does NOT exist for NNBase.
			%   Error id: [BRAPH2:NNBase:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NN) and Element.EXISTSTAG('NNBase')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnbase_tag_list = cellfun(@(x) NNBase.getPropTag(x), num2cell(NNBase.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnbase_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNBase:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNBase:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNBase.'] ...
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
			%  PROPERTY = NN.GETPROPPROP(POINTER) returns property number of POINTER of NN.
			%  PROPERTY = Element.GETPROPPROP(NNBase, POINTER) returns property number of POINTER of NNBase.
			%  PROPERTY = NN.GETPROPPROP(NNBase, POINTER) returns property number of POINTER of NNBase.
			%
			% Note that the Element.GETPROPPROP(NN) and Element.GETPROPPROP('NNBase')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnbase_tag_list = cellfun(@(x) NNBase.getPropTag(x), num2cell(NNBase.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnbase_tag_list)); % tag = pointer
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
			%  TAG = NN.GETPROPTAG(POINTER) returns tag of POINTER of NN.
			%  TAG = Element.GETPROPTAG(NNBase, POINTER) returns tag of POINTER of NNBase.
			%  TAG = NN.GETPROPTAG(NNBase, POINTER) returns tag of POINTER of NNBase.
			%
			% Note that the Element.GETPROPTAG(NN) and Element.GETPROPTAG('NNBase')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNBase.D
						tag = NNBase.D_TAG;
					case NNBase.DP_CLASSES
						tag = NNBase.DP_CLASSES_TAG;
					case NNBase.EPOCHS
						tag = NNBase.EPOCHS_TAG;
					case NNBase.BATCH
						tag = NNBase.BATCH_TAG;
					case NNBase.SHUFFLE
						tag = NNBase.SHUFFLE_TAG;
					case NNBase.SOLVER
						tag = NNBase.SOLVER_TAG;
					case NNBase.MODEL
						tag = NNBase.MODEL_TAG;
					case NNBase.INPUTS
						tag = NNBase.INPUTS_TAG;
					case NNBase.TARGETS
						tag = NNBase.TARGETS_TAG;
					case NNBase.TRAIN
						tag = NNBase.TRAIN_TAG;
					case NNBase.VERBOSE
						tag = NNBase.VERBOSE_TAG;
					case NNBase.PLOT_TRAINING
						tag = NNBase.PLOT_TRAINING_TAG;
					case NNBase.PREDICT
						tag = NNBase.PREDICT_TAG;
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
			%  CATEGORY = NN.GETPROPCATEGORY(POINTER) returns category of POINTER of NN.
			%  CATEGORY = Element.GETPROPCATEGORY(NNBase, POINTER) returns category of POINTER of NNBase.
			%  CATEGORY = NN.GETPROPCATEGORY(NNBase, POINTER) returns category of POINTER of NNBase.
			%
			% Note that the Element.GETPROPCATEGORY(NN) and Element.GETPROPCATEGORY('NNBase')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNBase.getPropProp(pointer);
			
			switch prop
				case NNBase.D
					prop_category = NNBase.D_CATEGORY;
				case NNBase.DP_CLASSES
					prop_category = NNBase.DP_CLASSES_CATEGORY;
				case NNBase.EPOCHS
					prop_category = NNBase.EPOCHS_CATEGORY;
				case NNBase.BATCH
					prop_category = NNBase.BATCH_CATEGORY;
				case NNBase.SHUFFLE
					prop_category = NNBase.SHUFFLE_CATEGORY;
				case NNBase.SOLVER
					prop_category = NNBase.SOLVER_CATEGORY;
				case NNBase.MODEL
					prop_category = NNBase.MODEL_CATEGORY;
				case NNBase.INPUTS
					prop_category = NNBase.INPUTS_CATEGORY;
				case NNBase.TARGETS
					prop_category = NNBase.TARGETS_CATEGORY;
				case NNBase.TRAIN
					prop_category = NNBase.TRAIN_CATEGORY;
				case NNBase.VERBOSE
					prop_category = NNBase.VERBOSE_CATEGORY;
				case NNBase.PLOT_TRAINING
					prop_category = NNBase.PLOT_TRAINING_CATEGORY;
				case NNBase.PREDICT
					prop_category = NNBase.PREDICT_CATEGORY;
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
			%  FORMAT = NN.GETPROPFORMAT(POINTER) returns format of POINTER of NN.
			%  FORMAT = Element.GETPROPFORMAT(NNBase, POINTER) returns format of POINTER of NNBase.
			%  FORMAT = NN.GETPROPFORMAT(NNBase, POINTER) returns format of POINTER of NNBase.
			%
			% Note that the Element.GETPROPFORMAT(NN) and Element.GETPROPFORMAT('NNBase')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNBase.getPropProp(pointer);
			
			switch prop
				case NNBase.D
					prop_format = NNBase.D_FORMAT;
				case NNBase.DP_CLASSES
					prop_format = NNBase.DP_CLASSES_FORMAT;
				case NNBase.EPOCHS
					prop_format = NNBase.EPOCHS_FORMAT;
				case NNBase.BATCH
					prop_format = NNBase.BATCH_FORMAT;
				case NNBase.SHUFFLE
					prop_format = NNBase.SHUFFLE_FORMAT;
				case NNBase.SOLVER
					prop_format = NNBase.SOLVER_FORMAT;
				case NNBase.MODEL
					prop_format = NNBase.MODEL_FORMAT;
				case NNBase.INPUTS
					prop_format = NNBase.INPUTS_FORMAT;
				case NNBase.TARGETS
					prop_format = NNBase.TARGETS_FORMAT;
				case NNBase.TRAIN
					prop_format = NNBase.TRAIN_FORMAT;
				case NNBase.VERBOSE
					prop_format = NNBase.VERBOSE_FORMAT;
				case NNBase.PLOT_TRAINING
					prop_format = NNBase.PLOT_TRAINING_FORMAT;
				case NNBase.PREDICT
					prop_format = NNBase.PREDICT_FORMAT;
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
			%  DESCRIPTION = NN.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NN.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNBase, POINTER) returns description of POINTER of NNBase.
			%  DESCRIPTION = NN.GETPROPDESCRIPTION(NNBase, POINTER) returns description of POINTER of NNBase.
			%
			% Note that the Element.GETPROPDESCRIPTION(NN) and Element.GETPROPDESCRIPTION('NNBase')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNBase.getPropProp(pointer);
			
			switch prop
				case NNBase.D
					prop_description = 'D (data, item) is the dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.';
				case NNBase.DP_CLASSES
					prop_description = 'DP_CLASSES (parameter, classlist) is the list of compatible data points.';
				case NNBase.EPOCHS
					prop_description = 'EPOCHS (parameter, scalar) is the maximum number of epochs.';
				case NNBase.BATCH
					prop_description = 'BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.';
				case NNBase.SHUFFLE
					prop_description = 'SHUFFLE (parameter, option) is an option for data shuffling.';
				case NNBase.SOLVER
					prop_description = 'SOLVER (parameter, option) is an option for the solver.';
				case NNBase.MODEL
					prop_description = 'MODEL (result, net) is a trained neural network model with the given dataset.';
				case NNBase.INPUTS
					prop_description = 'INPUTS (query, cell) constructs the cell array of the data.';
				case NNBase.TARGETS
					prop_description = 'TARGETS (query, cell) constructs the cell array of the targets.';
				case NNBase.TRAIN
					prop_description = 'TRAIN (query, empty) trains the neural network model with the given dataset.';
				case NNBase.VERBOSE
					prop_description = 'VERBOSE (metadata, logical) is an indicator to display training progress information.';
				case NNBase.PLOT_TRAINING
					prop_description = 'PLOT_TRAINING (metadata, option) determines whether to plot the training progress.';
				case NNBase.PREDICT
					prop_description = 'PREDICT (query, cell) returns the predictions of the trained neural network for a dataset.';
				case NNBase.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the neural network base.';
				case NNBase.NAME
					prop_description = 'NAME (constant, string) is the name of the neural network base.';
				case NNBase.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the neural network base.';
				case NNBase.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the neural network base.';
				case NNBase.ID
					prop_description = 'ID (data, string) is a few-letter code for the neural network base.';
				case NNBase.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the neural network base.';
				case NNBase.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the neural network base.';
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
			%  SETTINGS = NN.GETPROPSETTINGS(POINTER) returns settings of POINTER of NN.
			%  SETTINGS = Element.GETPROPSETTINGS(NNBase, POINTER) returns settings of POINTER of NNBase.
			%  SETTINGS = NN.GETPROPSETTINGS(NNBase, POINTER) returns settings of POINTER of NNBase.
			%
			% Note that the Element.GETPROPSETTINGS(NN) and Element.GETPROPSETTINGS('NNBase')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNBase.getPropProp(pointer);
			
			switch prop
				case NNBase.D
					prop_settings = 'NNDataset';
				case NNBase.DP_CLASSES
					prop_settings = Format.getFormatSettings(Format.CLASSLIST);
				case NNBase.EPOCHS
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNBase.BATCH
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNBase.SHUFFLE
					prop_settings = {'once' 'never' 'every-epoch'};
				case NNBase.SOLVER
					prop_settings = {'adam' 'sgdm' 'rmsprop'};
				case NNBase.MODEL
					prop_settings = Format.getFormatSettings(Format.NET);
				case NNBase.INPUTS
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNBase.TARGETS
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNBase.TRAIN
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case NNBase.VERBOSE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNBase.PLOT_TRAINING
					prop_settings = {'none' 'training-progress'};
				case NNBase.PREDICT
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNBase.TEMPLATE
					prop_settings = 'NNBase';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNBase.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNBase.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NN.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NN.
			%  DEFAULT = Element.GETPROPDEFAULT(NNBase, POINTER) returns the default value of POINTER of NNBase.
			%  DEFAULT = NN.GETPROPDEFAULT(NNBase, POINTER) returns the default value of POINTER of NNBase.
			%
			% Note that the Element.GETPROPDEFAULT(NN) and Element.GETPROPDEFAULT('NNBase')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNBase.getPropProp(pointer);
			
			switch prop
				case NNBase.D
					prop_default = NNDataset('DP_CLASS', 'NNDataPoint');
				case NNBase.DP_CLASSES
					prop_default = {'NNDataPoint'};
				case NNBase.EPOCHS
					prop_default = 20;
				case NNBase.BATCH
					prop_default = 8;
				case NNBase.SHUFFLE
					prop_default = Format.getFormatDefault(Format.OPTION, NNBase.getPropSettings(prop));
				case NNBase.SOLVER
					prop_default = Format.getFormatDefault(Format.OPTION, NNBase.getPropSettings(prop));
				case NNBase.MODEL
					prop_default = Format.getFormatDefault(Format.NET, NNBase.getPropSettings(prop));
				case NNBase.INPUTS
					prop_default = Format.getFormatDefault(Format.CELL, NNBase.getPropSettings(prop));
				case NNBase.TARGETS
					prop_default = Format.getFormatDefault(Format.CELL, NNBase.getPropSettings(prop));
				case NNBase.TRAIN
					prop_default = Format.getFormatDefault(Format.EMPTY, NNBase.getPropSettings(prop));
				case NNBase.VERBOSE
					prop_default = false;
				case NNBase.PLOT_TRAINING
					prop_default = Format.getFormatDefault(Format.OPTION, NNBase.getPropSettings(prop));
				case NNBase.PREDICT
					prop_default = Format.getFormatDefault(Format.CELL, NNBase.getPropSettings(prop));
				case NNBase.ELCLASS
					prop_default = 'NNBase';
				case NNBase.NAME
					prop_default = 'Neural Network Base ';
				case NNBase.DESCRIPTION
					prop_default = 'A Neural Network Base (NNBase) comprises a neural network model with a specific dataset. Instances of this class should not be created. Use one of its subclasses instead. Its subclasses need to implement the props MODEL, INPUTS and TARGETS.';
				case NNBase.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNBase.getPropSettings(prop));
				case NNBase.ID
					prop_default = 'NNBase ID';
				case NNBase.LABEL
					prop_default = 'NNBase label';
				case NNBase.NOTES
					prop_default = 'NNBase notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNBase.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNBase.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NN.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NN.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNBase, POINTER) returns the conditioned default value of POINTER of NNBase.
			%  DEFAULT = NN.GETPROPDEFAULTCONDITIONED(NNBase, POINTER) returns the conditioned default value of POINTER of NNBase.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NN) and Element.GETPROPDEFAULTCONDITIONED('NNBase')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNBase.getPropProp(pointer);
			
			prop_default = NNBase.conditioning(prop, NNBase.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NN.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NN.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NN.
			%  CHECK = Element.CHECKPROP(NNBase, PROP, VALUE) checks VALUE format for PROP of NNBase.
			%  CHECK = NN.CHECKPROP(NNBase, PROP, VALUE) checks VALUE format for PROP of NNBase.
			% 
			% NN.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNBase:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NN.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NN.
			%   Error id: €BRAPH2.STR€:NNBase:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNBase, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNBase.
			%   Error id: €BRAPH2.STR€:NNBase:€BRAPH2.WRONG_INPUT€
			%  NN.CHECKPROP(NNBase, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNBase.
			%   Error id: €BRAPH2.STR€:NNBase:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(NN) and Element.CHECKPROP('NNBase')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNBase.getPropProp(pointer);
			
			switch prop
				case NNBase.D % __NNBase.D__
					check = Format.checkFormat(Format.ITEM, value, NNBase.getPropSettings(prop));
				case NNBase.DP_CLASSES % __NNBase.DP_CLASSES__
					check = Format.checkFormat(Format.CLASSLIST, value, NNBase.getPropSettings(prop));
				case NNBase.EPOCHS % __NNBase.EPOCHS__
					check = Format.checkFormat(Format.SCALAR, value, NNBase.getPropSettings(prop));
				case NNBase.BATCH % __NNBase.BATCH__
					check = Format.checkFormat(Format.SCALAR, value, NNBase.getPropSettings(prop));
				case NNBase.SHUFFLE % __NNBase.SHUFFLE__
					check = Format.checkFormat(Format.OPTION, value, NNBase.getPropSettings(prop));
				case NNBase.SOLVER % __NNBase.SOLVER__
					check = Format.checkFormat(Format.OPTION, value, NNBase.getPropSettings(prop));
				case NNBase.MODEL % __NNBase.MODEL__
					check = Format.checkFormat(Format.NET, value, NNBase.getPropSettings(prop));
				case NNBase.INPUTS % __NNBase.INPUTS__
					check = Format.checkFormat(Format.CELL, value, NNBase.getPropSettings(prop));
				case NNBase.TARGETS % __NNBase.TARGETS__
					check = Format.checkFormat(Format.CELL, value, NNBase.getPropSettings(prop));
				case NNBase.TRAIN % __NNBase.TRAIN__
					check = Format.checkFormat(Format.EMPTY, value, NNBase.getPropSettings(prop));
				case NNBase.VERBOSE % __NNBase.VERBOSE__
					check = Format.checkFormat(Format.LOGICAL, value, NNBase.getPropSettings(prop));
				case NNBase.PLOT_TRAINING % __NNBase.PLOT_TRAINING__
					check = Format.checkFormat(Format.OPTION, value, NNBase.getPropSettings(prop));
				case NNBase.PREDICT % __NNBase.PREDICT__
					check = Format.checkFormat(Format.CELL, value, NNBase.getPropSettings(prop));
				case NNBase.TEMPLATE % __NNBase.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNBase.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNBase:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNBase:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNBase.getPropTag(prop) ' (' NNBase.getFormatTag(NNBase.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nn, prop, varargin)
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
				case NNBase.MODEL % __NNBase.MODEL__
					rng_settings_ = rng(); rng(nn.getPropSeed(NNBase.MODEL), 'twister')
					
					value = network();
					
					rng(rng_settings_)
					
				case NNBase.INPUTS % __NNBase.INPUTS__
					% inputs = nn.get('inputs', D) returns a cell array with the
					%  inputs for all data points in dataset D.
					value = {};
					
				case NNBase.TARGETS % __NNBase.TARGETS__
					% targets = nn.get('PREDICT', D) returns a cell array with the
					%  targets for all data points in dataset D.
					value = {};
					
				case NNBase.TRAIN % __NNBase.TRAIN__
					nn.memorize('MODEL');
					value = [];
					
				case NNBase.PREDICT % __NNBase.PREDICT__
					% PREDICTIONS = nn.get('PREDICT', D) returns a cell array with the
					%  predictions for all data points in dataset D.
					if isempty(varargin)
					    value = {};
					    return
					end
					
					d = varargin{1};
					inputs = nn.get('INPUTS', d);
					if isempty(cell2mat(inputs))
					    predictions = {};
					else
					    net = nn.get('MODEL');
					    predictions = {net.predict(cell2mat(inputs))};
					end
					value = predictions;
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(nn, prop, varargin{:});
					else
						value = calculateValue@Element(nn, prop, varargin{:});
					end
			end
			
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(nn, prop, value)
			%CHECKVALUE checks the value of a property after it is set/calculated.
			%
			% [CHECK, MSG] = CHECKVALUE(EL, PROP, VALUE) checks the value
			%  of the property PROP after it is set/calculated. This function by
			%  default returns a CHECK = true and MSG = '. It should be implemented in
			%  the subclasses of Element when needed.
			%
			% See also conditioning, preset, checkProp, postset, postprocessing,
			%  calculateValue.
			
			check = true;
			msg = ['Error while checking ' tostring(nn) ' ' nn.getPropTag(prop) '.'];
			
			switch prop
				case NNBase.D % __NNBase.D__
					check = ismember(value.get('DP_CLASS'), nn.get('DP_CLASSES'));
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						[check, msg] = checkValue@ConcreteElement(nn, prop, value);
					end
			end
		end
	end
end
