classdef NNxMLP_FeatureImportance_CV < ConcreteElement
	%NNxMLP_FeatureImportance_CV provides the importance of features across all folds for multi-layer perceptron (MLP) using shuffled feature method.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% Neural Network Feature Importance for Multi-Layer Perceptron with Cross-Validation (NNxMLP_FeatureImportance_CV)
	%  assesses the importance of features across all folds by measuring the increase in model error when the feature values are randomly shuffled. 
	% The feature importance score for each feature is then averaged across all folds. 
	% It applies a template to all folds of NNxMLP_FeatureImportance for setting up the parameters of the permutation method, 
	%  such as a user-defined confidence interval, and adjusts for multiple comparisons with the Bonferroni correction.
	%
	% NNxMLP_FeatureImportance_CV methods (constructor):
	%  NNxMLP_FeatureImportance_CV - constructor
	%
	% NNxMLP_FeatureImportance_CV methods:
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
	% NNxMLP_FeatureImportance_CV methods (display):
	%  tostring - string with information about the neural network feature importace for multi-layer perceptron
	%  disp - displays information about the neural network feature importace for multi-layer perceptron
	%  tree - displays the tree of the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportance_CV methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network feature importace for multi-layer perceptron are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportance_CV methods (save/load, Static):
	%  save - saves BRAPH2 neural network feature importace for multi-layer perceptron as b2 file
	%  load - loads a BRAPH2 neural network feature importace for multi-layer perceptron from a b2 file
	%
	% NNxMLP_FeatureImportance_CV method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportance_CV method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportance_CV methods (inspection, Static):
	%  getClass - returns the class of the neural network feature importace for multi-layer perceptron
	%  getSubclasses - returns all subclasses of NNxMLP_FeatureImportance_CV
	%  getProps - returns the property list of the neural network feature importace for multi-layer perceptron
	%  getPropNumber - returns the property number of the neural network feature importace for multi-layer perceptron
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
	% NNxMLP_FeatureImportance_CV methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNxMLP_FeatureImportance_CV methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNxMLP_FeatureImportance_CV methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNxMLP_FeatureImportance_CV methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNxMLP_FeatureImportance_CV; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNxMLP_FeatureImportance_CV constants</a>.
	%
	%
	% See also NNxMLP_FeatureImportance, NNClassifierMLP_CrossValidation, NNRegressorMLP_CrossValidation.
	
	properties (Constant) % properties
		NNCV = ConcreteElement.getPropNumber() + 1;
		NNCV_TAG = 'NNCV';
		NNCV_CATEGORY = Category.DATA;
		NNCV_FORMAT = Format.ITEM;
		
		FI_TEMPLATE = ConcreteElement.getPropNumber() + 2;
		FI_TEMPLATE_TAG = 'FI_TEMPLATE';
		FI_TEMPLATE_CATEGORY = Category.PARAMETER;
		FI_TEMPLATE_FORMAT = Format.ITEM;
		
		FI_LIST = ConcreteElement.getPropNumber() + 3;
		FI_LIST_TAG = 'FI_LIST';
		FI_LIST_CATEGORY = Category.RESULT;
		FI_LIST_FORMAT = Format.ITEMLIST;
		
		P = ConcreteElement.getPropNumber() + 4;
		P_TAG = 'P';
		P_CATEGORY = Category.PARAMETER;
		P_FORMAT = Format.SCALAR;
		
		PERM_SEEDS = ConcreteElement.getPropNumber() + 5;
		PERM_SEEDS_TAG = 'PERM_SEEDS';
		PERM_SEEDS_CATEGORY = Category.RESULT;
		PERM_SEEDS_FORMAT = Format.RVECTOR;
		
		APPLY_BONFERRONI = ConcreteElement.getPropNumber() + 6;
		APPLY_BONFERRONI_TAG = 'APPLY_BONFERRONI';
		APPLY_BONFERRONI_CATEGORY = Category.PARAMETER;
		APPLY_BONFERRONI_FORMAT = Format.LOGICAL;
		
		APPLY_CONFIDENCE_INTERVALS = ConcreteElement.getPropNumber() + 7;
		APPLY_CONFIDENCE_INTERVALS_TAG = 'APPLY_CONFIDENCE_INTERVALS';
		APPLY_CONFIDENCE_INTERVALS_CATEGORY = Category.PARAMETER;
		APPLY_CONFIDENCE_INTERVALS_FORMAT = Format.LOGICAL;
		
		VERBOSE = ConcreteElement.getPropNumber() + 8;
		VERBOSE_TAG = 'VERBOSE';
		VERBOSE_CATEGORY = Category.METADATA;
		VERBOSE_FORMAT = Format.LOGICAL;
		
		SIG_LEVEL = ConcreteElement.getPropNumber() + 9;
		SIG_LEVEL_TAG = 'SIG_LEVEL';
		SIG_LEVEL_CATEGORY = Category.PARAMETER;
		SIG_LEVEL_FORMAT = Format.SCALAR;
		
		WAITBAR = ConcreteElement.getPropNumber() + 10;
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = Category.GUI;
		WAITBAR_FORMAT = Format.LOGICAL;
		
		INTERRUPTIBLE = ConcreteElement.getPropNumber() + 11;
		INTERRUPTIBLE_TAG = 'INTERRUPTIBLE';
		INTERRUPTIBLE_CATEGORY = Category.GUI;
		INTERRUPTIBLE_FORMAT = Format.SCALAR;
		
		AV_FEATURE_IMPORTANCE = ConcreteElement.getPropNumber() + 12;
		AV_FEATURE_IMPORTANCE_TAG = 'AV_FEATURE_IMPORTANCE';
		AV_FEATURE_IMPORTANCE_CATEGORY = Category.RESULT;
		AV_FEATURE_IMPORTANCE_FORMAT = Format.CELL;
		
		RESHAPED_AV_FEATURE_IMPORTANCE = ConcreteElement.getPropNumber() + 13;
		RESHAPED_AV_FEATURE_IMPORTANCE_TAG = 'RESHAPED_AV_FEATURE_IMPORTANCE';
		RESHAPED_AV_FEATURE_IMPORTANCE_CATEGORY = Category.RESULT;
		RESHAPED_AV_FEATURE_IMPORTANCE_FORMAT = Format.CELL;
		
		MAP_TO_CELL = ConcreteElement.getPropNumber() + 14;
		MAP_TO_CELL_TAG = 'MAP_TO_CELL';
		MAP_TO_CELL_CATEGORY = Category.QUERY;
		MAP_TO_CELL_FORMAT = Format.EMPTY;
		
		COUNT_ELEMENTS = ConcreteElement.getPropNumber() + 15;
		COUNT_ELEMENTS_TAG = 'COUNT_ELEMENTS';
		COUNT_ELEMENTS_CATEGORY = Category.QUERY;
		COUNT_ELEMENTS_FORMAT = Format.EMPTY;
		
		FLATTEN_CELL = ConcreteElement.getPropNumber() + 16;
		FLATTEN_CELL_TAG = 'FLATTEN_CELL';
		FLATTEN_CELL_CATEGORY = Category.QUERY;
		FLATTEN_CELL_FORMAT = Format.EMPTY;
	end
	methods % constructor
		function nnficv = NNxMLP_FeatureImportance_CV(varargin)
			%NNxMLP_FeatureImportance_CV() creates a neural network feature importace for multi-layer perceptron.
			%
			% NNxMLP_FeatureImportance_CV(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNxMLP_FeatureImportance_CV(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			nnficv = nnficv@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function nnficv_class = getClass()
			%GETCLASS returns the class of the neural network feature importace for multi-layer perceptron.
			%
			% CLASS = NNxMLP_FeatureImportance_CV.GETCLASS() returns the class 'NNxMLP_FeatureImportance_CV'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNFICV.GETCLASS() returns the class of the neural network feature importace for multi-layer perceptron NNFICV.
			%  CLASS = Element.GETCLASS(NNFICV) returns the class of 'NNFICV'.
			%  CLASS = Element.GETCLASS('NNxMLP_FeatureImportance_CV') returns 'NNxMLP_FeatureImportance_CV'.
			%
			% Note that the Element.GETCLASS(NNFICV) and Element.GETCLASS('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			
			nnficv_class = 'NNxMLP_FeatureImportance_CV';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network feature importace for multi-layer perceptron.
			%
			% LIST = NNxMLP_FeatureImportance_CV.GETSUBCLASSES() returns all subclasses of 'NNxMLP_FeatureImportance_CV'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNFICV.GETSUBCLASSES() returns all subclasses of the neural network feature importace for multi-layer perceptron NNFICV.
			%  LIST = Element.GETSUBCLASSES(NNFICV) returns all subclasses of 'NNFICV'.
			%  LIST = Element.GETSUBCLASSES('NNxMLP_FeatureImportance_CV') returns all subclasses of 'NNxMLP_FeatureImportance_CV'.
			%
			% Note that the Element.GETSUBCLASSES(NNFICV) and Element.GETSUBCLASSES('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNxMLP_FeatureImportance_CV', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network feature importace for multi-layer perceptron.
			%
			% PROPS = NNxMLP_FeatureImportance_CV.GETPROPS() returns the property list of neural network feature importace for multi-layer perceptron
			%  as a row vector.
			%
			% PROPS = NNxMLP_FeatureImportance_CV.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNFICV.GETPROPS([CATEGORY]) returns the property list of the neural network feature importace for multi-layer perceptron NNFICV.
			%  PROPS = Element.GETPROPS(NNFICV[, CATEGORY]) returns the property list of 'NNFICV'.
			%  PROPS = Element.GETPROPS('NNxMLP_FeatureImportance_CV'[, CATEGORY]) returns the property list of 'NNxMLP_FeatureImportance_CV'.
			%
			% Note that the Element.GETPROPS(NNFICV) and Element.GETPROPS('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						NNxMLP_FeatureImportance_CV.NNCV ...
						NNxMLP_FeatureImportance_CV.FI_TEMPLATE ...
						NNxMLP_FeatureImportance_CV.FI_LIST ...
						NNxMLP_FeatureImportance_CV.P ...
						NNxMLP_FeatureImportance_CV.PERM_SEEDS ...
						NNxMLP_FeatureImportance_CV.APPLY_BONFERRONI ...
						NNxMLP_FeatureImportance_CV.APPLY_CONFIDENCE_INTERVALS ...
						NNxMLP_FeatureImportance_CV.VERBOSE ...
						NNxMLP_FeatureImportance_CV.SIG_LEVEL ...
						NNxMLP_FeatureImportance_CV.WAITBAR ...
						NNxMLP_FeatureImportance_CV.INTERRUPTIBLE ...
						NNxMLP_FeatureImportance_CV.AV_FEATURE_IMPORTANCE ...
						NNxMLP_FeatureImportance_CV.RESHAPED_AV_FEATURE_IMPORTANCE ...
						NNxMLP_FeatureImportance_CV.MAP_TO_CELL ...
						NNxMLP_FeatureImportance_CV.COUNT_ELEMENTS ...
						NNxMLP_FeatureImportance_CV.FLATTEN_CELL ...
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
						NNxMLP_FeatureImportance_CV.VERBOSE ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						NNxMLP_FeatureImportance_CV.FI_TEMPLATE ...
						NNxMLP_FeatureImportance_CV.P ...
						NNxMLP_FeatureImportance_CV.APPLY_BONFERRONI ...
						NNxMLP_FeatureImportance_CV.APPLY_CONFIDENCE_INTERVALS ...
						NNxMLP_FeatureImportance_CV.SIG_LEVEL ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						NNxMLP_FeatureImportance_CV.NNCV ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						NNxMLP_FeatureImportance_CV.FI_LIST ...
						NNxMLP_FeatureImportance_CV.PERM_SEEDS ...
						NNxMLP_FeatureImportance_CV.AV_FEATURE_IMPORTANCE ...
						NNxMLP_FeatureImportance_CV.RESHAPED_AV_FEATURE_IMPORTANCE ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						NNxMLP_FeatureImportance_CV.MAP_TO_CELL ...
						NNxMLP_FeatureImportance_CV.COUNT_ELEMENTS ...
						NNxMLP_FeatureImportance_CV.FLATTEN_CELL ...
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
						NNxMLP_FeatureImportance_CV.WAITBAR ...
						NNxMLP_FeatureImportance_CV.INTERRUPTIBLE ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network feature importace for multi-layer perceptron.
			%
			% N = NNxMLP_FeatureImportance_CV.GETPROPNUMBER() returns the property number of neural network feature importace for multi-layer perceptron.
			%
			% N = NNxMLP_FeatureImportance_CV.GETPROPNUMBER(CATEGORY) returns the property number of neural network feature importace for multi-layer perceptron
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNFICV.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network feature importace for multi-layer perceptron NNFICV.
			%  N = Element.GETPROPNUMBER(NNFICV) returns the property number of 'NNFICV'.
			%  N = Element.GETPROPNUMBER('NNxMLP_FeatureImportance_CV') returns the property number of 'NNxMLP_FeatureImportance_CV'.
			%
			% Note that the Element.GETPROPNUMBER(NNFICV) and Element.GETPROPNUMBER('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNxMLP_FeatureImportance_CV.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network feature importace for multi-layer perceptron/error.
			%
			% CHECK = NNxMLP_FeatureImportance_CV.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFICV.EXISTSPROP(PROP) checks whether PROP exists for NNFICV.
			%  CHECK = Element.EXISTSPROP(NNFICV, PROP) checks whether PROP exists for NNFICV.
			%  CHECK = Element.EXISTSPROP(NNxMLP_FeatureImportance_CV, PROP) checks whether PROP exists for NNxMLP_FeatureImportance_CV.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportance_CV:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFICV.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNFICV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance_CV:WrongInput]
			%  Element.EXISTSPROP(NNFICV, PROP) throws error if PROP does NOT exist for NNFICV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance_CV:WrongInput]
			%  Element.EXISTSPROP(NNxMLP_FeatureImportance_CV, PROP) throws error if PROP does NOT exist for NNxMLP_FeatureImportance_CV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance_CV:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNFICV) and Element.EXISTSPROP('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNxMLP_FeatureImportance_CV.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_FeatureImportance_CV:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_FeatureImportance_CV:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNxMLP_FeatureImportance_CV.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network feature importace for multi-layer perceptron/error.
			%
			% CHECK = NNxMLP_FeatureImportance_CV.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFICV.EXISTSTAG(TAG) checks whether TAG exists for NNFICV.
			%  CHECK = Element.EXISTSTAG(NNFICV, TAG) checks whether TAG exists for NNFICV.
			%  CHECK = Element.EXISTSTAG(NNxMLP_FeatureImportance_CV, TAG) checks whether TAG exists for NNxMLP_FeatureImportance_CV.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportance_CV:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFICV.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNFICV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance_CV:WrongInput]
			%  Element.EXISTSTAG(NNFICV, TAG) throws error if TAG does NOT exist for NNFICV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance_CV:WrongInput]
			%  Element.EXISTSTAG(NNxMLP_FeatureImportance_CV, TAG) throws error if TAG does NOT exist for NNxMLP_FeatureImportance_CV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance_CV:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNFICV) and Element.EXISTSTAG('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnxmlp_featureimportance_cv_tag_list = cellfun(@(x) NNxMLP_FeatureImportance_CV.getPropTag(x), num2cell(NNxMLP_FeatureImportance_CV.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnxmlp_featureimportance_cv_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_FeatureImportance_CV:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_FeatureImportance_CV:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNxMLP_FeatureImportance_CV.'] ...
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
			%  PROPERTY = NNFICV.GETPROPPROP(POINTER) returns property number of POINTER of NNFICV.
			%  PROPERTY = Element.GETPROPPROP(NNxMLP_FeatureImportance_CV, POINTER) returns property number of POINTER of NNxMLP_FeatureImportance_CV.
			%  PROPERTY = NNFICV.GETPROPPROP(NNxMLP_FeatureImportance_CV, POINTER) returns property number of POINTER of NNxMLP_FeatureImportance_CV.
			%
			% Note that the Element.GETPROPPROP(NNFICV) and Element.GETPROPPROP('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnxmlp_featureimportance_cv_tag_list = cellfun(@(x) NNxMLP_FeatureImportance_CV.getPropTag(x), num2cell(NNxMLP_FeatureImportance_CV.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnxmlp_featureimportance_cv_tag_list)); % tag = pointer
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
			%  TAG = NNFICV.GETPROPTAG(POINTER) returns tag of POINTER of NNFICV.
			%  TAG = Element.GETPROPTAG(NNxMLP_FeatureImportance_CV, POINTER) returns tag of POINTER of NNxMLP_FeatureImportance_CV.
			%  TAG = NNFICV.GETPROPTAG(NNxMLP_FeatureImportance_CV, POINTER) returns tag of POINTER of NNxMLP_FeatureImportance_CV.
			%
			% Note that the Element.GETPROPTAG(NNFICV) and Element.GETPROPTAG('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNxMLP_FeatureImportance_CV.NNCV
						tag = NNxMLP_FeatureImportance_CV.NNCV_TAG;
					case NNxMLP_FeatureImportance_CV.FI_TEMPLATE
						tag = NNxMLP_FeatureImportance_CV.FI_TEMPLATE_TAG;
					case NNxMLP_FeatureImportance_CV.FI_LIST
						tag = NNxMLP_FeatureImportance_CV.FI_LIST_TAG;
					case NNxMLP_FeatureImportance_CV.P
						tag = NNxMLP_FeatureImportance_CV.P_TAG;
					case NNxMLP_FeatureImportance_CV.PERM_SEEDS
						tag = NNxMLP_FeatureImportance_CV.PERM_SEEDS_TAG;
					case NNxMLP_FeatureImportance_CV.APPLY_BONFERRONI
						tag = NNxMLP_FeatureImportance_CV.APPLY_BONFERRONI_TAG;
					case NNxMLP_FeatureImportance_CV.APPLY_CONFIDENCE_INTERVALS
						tag = NNxMLP_FeatureImportance_CV.APPLY_CONFIDENCE_INTERVALS_TAG;
					case NNxMLP_FeatureImportance_CV.VERBOSE
						tag = NNxMLP_FeatureImportance_CV.VERBOSE_TAG;
					case NNxMLP_FeatureImportance_CV.SIG_LEVEL
						tag = NNxMLP_FeatureImportance_CV.SIG_LEVEL_TAG;
					case NNxMLP_FeatureImportance_CV.WAITBAR
						tag = NNxMLP_FeatureImportance_CV.WAITBAR_TAG;
					case NNxMLP_FeatureImportance_CV.INTERRUPTIBLE
						tag = NNxMLP_FeatureImportance_CV.INTERRUPTIBLE_TAG;
					case NNxMLP_FeatureImportance_CV.AV_FEATURE_IMPORTANCE
						tag = NNxMLP_FeatureImportance_CV.AV_FEATURE_IMPORTANCE_TAG;
					case NNxMLP_FeatureImportance_CV.RESHAPED_AV_FEATURE_IMPORTANCE
						tag = NNxMLP_FeatureImportance_CV.RESHAPED_AV_FEATURE_IMPORTANCE_TAG;
					case NNxMLP_FeatureImportance_CV.MAP_TO_CELL
						tag = NNxMLP_FeatureImportance_CV.MAP_TO_CELL_TAG;
					case NNxMLP_FeatureImportance_CV.COUNT_ELEMENTS
						tag = NNxMLP_FeatureImportance_CV.COUNT_ELEMENTS_TAG;
					case NNxMLP_FeatureImportance_CV.FLATTEN_CELL
						tag = NNxMLP_FeatureImportance_CV.FLATTEN_CELL_TAG;
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
			%  CATEGORY = NNFICV.GETPROPCATEGORY(POINTER) returns category of POINTER of NNFICV.
			%  CATEGORY = Element.GETPROPCATEGORY(NNxMLP_FeatureImportance_CV, POINTER) returns category of POINTER of NNxMLP_FeatureImportance_CV.
			%  CATEGORY = NNFICV.GETPROPCATEGORY(NNxMLP_FeatureImportance_CV, POINTER) returns category of POINTER of NNxMLP_FeatureImportance_CV.
			%
			% Note that the Element.GETPROPCATEGORY(NNFICV) and Element.GETPROPCATEGORY('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportance_CV.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportance_CV.NNCV
					prop_category = NNxMLP_FeatureImportance_CV.NNCV_CATEGORY;
				case NNxMLP_FeatureImportance_CV.FI_TEMPLATE
					prop_category = NNxMLP_FeatureImportance_CV.FI_TEMPLATE_CATEGORY;
				case NNxMLP_FeatureImportance_CV.FI_LIST
					prop_category = NNxMLP_FeatureImportance_CV.FI_LIST_CATEGORY;
				case NNxMLP_FeatureImportance_CV.P
					prop_category = NNxMLP_FeatureImportance_CV.P_CATEGORY;
				case NNxMLP_FeatureImportance_CV.PERM_SEEDS
					prop_category = NNxMLP_FeatureImportance_CV.PERM_SEEDS_CATEGORY;
				case NNxMLP_FeatureImportance_CV.APPLY_BONFERRONI
					prop_category = NNxMLP_FeatureImportance_CV.APPLY_BONFERRONI_CATEGORY;
				case NNxMLP_FeatureImportance_CV.APPLY_CONFIDENCE_INTERVALS
					prop_category = NNxMLP_FeatureImportance_CV.APPLY_CONFIDENCE_INTERVALS_CATEGORY;
				case NNxMLP_FeatureImportance_CV.VERBOSE
					prop_category = NNxMLP_FeatureImportance_CV.VERBOSE_CATEGORY;
				case NNxMLP_FeatureImportance_CV.SIG_LEVEL
					prop_category = NNxMLP_FeatureImportance_CV.SIG_LEVEL_CATEGORY;
				case NNxMLP_FeatureImportance_CV.WAITBAR
					prop_category = NNxMLP_FeatureImportance_CV.WAITBAR_CATEGORY;
				case NNxMLP_FeatureImportance_CV.INTERRUPTIBLE
					prop_category = NNxMLP_FeatureImportance_CV.INTERRUPTIBLE_CATEGORY;
				case NNxMLP_FeatureImportance_CV.AV_FEATURE_IMPORTANCE
					prop_category = NNxMLP_FeatureImportance_CV.AV_FEATURE_IMPORTANCE_CATEGORY;
				case NNxMLP_FeatureImportance_CV.RESHAPED_AV_FEATURE_IMPORTANCE
					prop_category = NNxMLP_FeatureImportance_CV.RESHAPED_AV_FEATURE_IMPORTANCE_CATEGORY;
				case NNxMLP_FeatureImportance_CV.MAP_TO_CELL
					prop_category = NNxMLP_FeatureImportance_CV.MAP_TO_CELL_CATEGORY;
				case NNxMLP_FeatureImportance_CV.COUNT_ELEMENTS
					prop_category = NNxMLP_FeatureImportance_CV.COUNT_ELEMENTS_CATEGORY;
				case NNxMLP_FeatureImportance_CV.FLATTEN_CELL
					prop_category = NNxMLP_FeatureImportance_CV.FLATTEN_CELL_CATEGORY;
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
			%  FORMAT = NNFICV.GETPROPFORMAT(POINTER) returns format of POINTER of NNFICV.
			%  FORMAT = Element.GETPROPFORMAT(NNxMLP_FeatureImportance_CV, POINTER) returns format of POINTER of NNxMLP_FeatureImportance_CV.
			%  FORMAT = NNFICV.GETPROPFORMAT(NNxMLP_FeatureImportance_CV, POINTER) returns format of POINTER of NNxMLP_FeatureImportance_CV.
			%
			% Note that the Element.GETPROPFORMAT(NNFICV) and Element.GETPROPFORMAT('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportance_CV.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportance_CV.NNCV
					prop_format = NNxMLP_FeatureImportance_CV.NNCV_FORMAT;
				case NNxMLP_FeatureImportance_CV.FI_TEMPLATE
					prop_format = NNxMLP_FeatureImportance_CV.FI_TEMPLATE_FORMAT;
				case NNxMLP_FeatureImportance_CV.FI_LIST
					prop_format = NNxMLP_FeatureImportance_CV.FI_LIST_FORMAT;
				case NNxMLP_FeatureImportance_CV.P
					prop_format = NNxMLP_FeatureImportance_CV.P_FORMAT;
				case NNxMLP_FeatureImportance_CV.PERM_SEEDS
					prop_format = NNxMLP_FeatureImportance_CV.PERM_SEEDS_FORMAT;
				case NNxMLP_FeatureImportance_CV.APPLY_BONFERRONI
					prop_format = NNxMLP_FeatureImportance_CV.APPLY_BONFERRONI_FORMAT;
				case NNxMLP_FeatureImportance_CV.APPLY_CONFIDENCE_INTERVALS
					prop_format = NNxMLP_FeatureImportance_CV.APPLY_CONFIDENCE_INTERVALS_FORMAT;
				case NNxMLP_FeatureImportance_CV.VERBOSE
					prop_format = NNxMLP_FeatureImportance_CV.VERBOSE_FORMAT;
				case NNxMLP_FeatureImportance_CV.SIG_LEVEL
					prop_format = NNxMLP_FeatureImportance_CV.SIG_LEVEL_FORMAT;
				case NNxMLP_FeatureImportance_CV.WAITBAR
					prop_format = NNxMLP_FeatureImportance_CV.WAITBAR_FORMAT;
				case NNxMLP_FeatureImportance_CV.INTERRUPTIBLE
					prop_format = NNxMLP_FeatureImportance_CV.INTERRUPTIBLE_FORMAT;
				case NNxMLP_FeatureImportance_CV.AV_FEATURE_IMPORTANCE
					prop_format = NNxMLP_FeatureImportance_CV.AV_FEATURE_IMPORTANCE_FORMAT;
				case NNxMLP_FeatureImportance_CV.RESHAPED_AV_FEATURE_IMPORTANCE
					prop_format = NNxMLP_FeatureImportance_CV.RESHAPED_AV_FEATURE_IMPORTANCE_FORMAT;
				case NNxMLP_FeatureImportance_CV.MAP_TO_CELL
					prop_format = NNxMLP_FeatureImportance_CV.MAP_TO_CELL_FORMAT;
				case NNxMLP_FeatureImportance_CV.COUNT_ELEMENTS
					prop_format = NNxMLP_FeatureImportance_CV.COUNT_ELEMENTS_FORMAT;
				case NNxMLP_FeatureImportance_CV.FLATTEN_CELL
					prop_format = NNxMLP_FeatureImportance_CV.FLATTEN_CELL_FORMAT;
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
			%  DESCRIPTION = NNFICV.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNFICV.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNxMLP_FeatureImportance_CV, POINTER) returns description of POINTER of NNxMLP_FeatureImportance_CV.
			%  DESCRIPTION = NNFICV.GETPROPDESCRIPTION(NNxMLP_FeatureImportance_CV, POINTER) returns description of POINTER of NNxMLP_FeatureImportance_CV.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNFICV) and Element.GETPROPDESCRIPTION('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportance_CV.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportance_CV.NNCV
					prop_description = 'NNCV (data, item) is the neural network cross validation to be tested on feature importance.';
				case NNxMLP_FeatureImportance_CV.FI_TEMPLATE
					prop_description = 'FI_TEMPLATE (parameter, item) is the feature importance template to set all feature importance analysis and visualization parameters.';
				case NNxMLP_FeatureImportance_CV.FI_LIST
					prop_description = 'FI_LIST (result, itemlist) contains a list of feature importance analysis for all folds.';
				case NNxMLP_FeatureImportance_CV.P
					prop_description = 'P (parameter, scalar) is the permutation number that determines the statistical significance of the features. ';
				case NNxMLP_FeatureImportance_CV.PERM_SEEDS
					prop_description = 'PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.';
				case NNxMLP_FeatureImportance_CV.APPLY_BONFERRONI
					prop_description = 'APPLY_BONFERRONI (parameter, logical) determines whether to apply bonferroni correction.';
				case NNxMLP_FeatureImportance_CV.APPLY_CONFIDENCE_INTERVALS
					prop_description = 'APPLY_CONFIDENCE_INTERVALS (parameter, logical) determines whether to apply user-defined percent confidence interval.';
				case NNxMLP_FeatureImportance_CV.VERBOSE
					prop_description = 'VERBOSE (metadata, logical) is an indicator to display permutation progress information.';
				case NNxMLP_FeatureImportance_CV.SIG_LEVEL
					prop_description = 'SIG_LEVEL (parameter, scalar) determines the significant level.';
				case NNxMLP_FeatureImportance_CV.WAITBAR
					prop_description = 'WAITBAR (gui, logical) determines whether to show the waitbar.';
				case NNxMLP_FeatureImportance_CV.INTERRUPTIBLE
					prop_description = 'INTERRUPTIBLE (gui, scalar) sets whether the permutation computation is interruptible for multitasking.';
				case NNxMLP_FeatureImportance_CV.AV_FEATURE_IMPORTANCE
					prop_description = 'AV_FEATURE_IMPORTANCE (result, cell) is determined by applying bonferroni correction for the permutation and obtaining the value by the average of the permutation number times of shuffled loss, which then in trun are divided by base loss for normalizaiton.';
				case NNxMLP_FeatureImportance_CV.RESHAPED_AV_FEATURE_IMPORTANCE
					prop_description = 'RESHAPED_AV_FEATURE_IMPORTANCE (result, cell) reshapes the cell of feature importances with the input data.';
				case NNxMLP_FeatureImportance_CV.MAP_TO_CELL
					prop_description = 'MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.';
				case NNxMLP_FeatureImportance_CV.COUNT_ELEMENTS
					prop_description = 'COUNT_ELEMENTS (query, empty) counts the total number of elements within a nested cell array.';
				case NNxMLP_FeatureImportance_CV.FLATTEN_CELL
					prop_description = 'FLATTEN_CELL (query, empty) flattens a cell array into to a single vector.';
				case NNxMLP_FeatureImportance_CV.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the neural network feature importance for cross validation.';
				case NNxMLP_FeatureImportance_CV.NAME
					prop_description = 'NAME (constant, string) is the name of the neural network feature importance for cross validation.';
				case NNxMLP_FeatureImportance_CV.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the neural network feature importance for cross validation.';
				case NNxMLP_FeatureImportance_CV.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the neural network feature importance for cross validation.';
				case NNxMLP_FeatureImportance_CV.ID
					prop_description = 'ID (data, string) is a few-letter code of the neural network feature importance for cross validation.';
				case NNxMLP_FeatureImportance_CV.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the neural network feature importance for cross validation.';
				case NNxMLP_FeatureImportance_CV.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the neural network feature importance for cross validation.';
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
			%  SETTINGS = NNFICV.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNFICV.
			%  SETTINGS = Element.GETPROPSETTINGS(NNxMLP_FeatureImportance_CV, POINTER) returns settings of POINTER of NNxMLP_FeatureImportance_CV.
			%  SETTINGS = NNFICV.GETPROPSETTINGS(NNxMLP_FeatureImportance_CV, POINTER) returns settings of POINTER of NNxMLP_FeatureImportance_CV.
			%
			% Note that the Element.GETPROPSETTINGS(NNFICV) and Element.GETPROPSETTINGS('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportance_CV.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportance_CV.NNCV
					prop_settings = 'NNCrossValidation';
				case NNxMLP_FeatureImportance_CV.FI_TEMPLATE
					prop_settings = 'NNxMLP_FeatureImportance';
				case NNxMLP_FeatureImportance_CV.FI_LIST
					prop_settings = 'NNxMLP_FeatureImportance';
				case NNxMLP_FeatureImportance_CV.P
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNxMLP_FeatureImportance_CV.PERM_SEEDS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case NNxMLP_FeatureImportance_CV.APPLY_BONFERRONI
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNxMLP_FeatureImportance_CV.APPLY_CONFIDENCE_INTERVALS
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNxMLP_FeatureImportance_CV.VERBOSE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNxMLP_FeatureImportance_CV.SIG_LEVEL
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNxMLP_FeatureImportance_CV.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNxMLP_FeatureImportance_CV.INTERRUPTIBLE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNxMLP_FeatureImportance_CV.AV_FEATURE_IMPORTANCE
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNxMLP_FeatureImportance_CV.RESHAPED_AV_FEATURE_IMPORTANCE
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNxMLP_FeatureImportance_CV.MAP_TO_CELL
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case NNxMLP_FeatureImportance_CV.COUNT_ELEMENTS
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case NNxMLP_FeatureImportance_CV.FLATTEN_CELL
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case NNxMLP_FeatureImportance_CV.TEMPLATE
					prop_settings = 'NNxMLP_FeatureImportance_CV';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportance_CV.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportance_CV.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFICV.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNFICV.
			%  DEFAULT = Element.GETPROPDEFAULT(NNxMLP_FeatureImportance_CV, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportance_CV.
			%  DEFAULT = NNFICV.GETPROPDEFAULT(NNxMLP_FeatureImportance_CV, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportance_CV.
			%
			% Note that the Element.GETPROPDEFAULT(NNFICV) and Element.GETPROPDEFAULT('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNxMLP_FeatureImportance_CV.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportance_CV.NNCV
					prop_default = Format.getFormatDefault(Format.ITEM, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.FI_TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.FI_LIST
					prop_default = Format.getFormatDefault(Format.ITEMLIST, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.P
					prop_default = 1e+2;
				case NNxMLP_FeatureImportance_CV.PERM_SEEDS
					prop_default = Format.getFormatDefault(Format.RVECTOR, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.APPLY_BONFERRONI
					prop_default = true;
				case NNxMLP_FeatureImportance_CV.APPLY_CONFIDENCE_INTERVALS
					prop_default = true;
				case NNxMLP_FeatureImportance_CV.VERBOSE
					prop_default = false;
				case NNxMLP_FeatureImportance_CV.SIG_LEVEL
					prop_default = 0.05;
				case NNxMLP_FeatureImportance_CV.WAITBAR
					prop_default = true;
				case NNxMLP_FeatureImportance_CV.INTERRUPTIBLE
					prop_default = .001;
				case NNxMLP_FeatureImportance_CV.AV_FEATURE_IMPORTANCE
					prop_default = Format.getFormatDefault(Format.CELL, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.RESHAPED_AV_FEATURE_IMPORTANCE
					prop_default = Format.getFormatDefault(Format.CELL, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.MAP_TO_CELL
					prop_default = Format.getFormatDefault(Format.EMPTY, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.COUNT_ELEMENTS
					prop_default = Format.getFormatDefault(Format.EMPTY, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.FLATTEN_CELL
					prop_default = Format.getFormatDefault(Format.EMPTY, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.ELCLASS
					prop_default = 'NNxMLP_FeatureImportance_CV';
				case NNxMLP_FeatureImportance_CV.NAME
					prop_default = 'Feature Importace for Multi-layer Perceptron';
				case NNxMLP_FeatureImportance_CV.DESCRIPTION
					prop_default = 'Neural Network Feature Importance for Multi-Layer Perceptron with Cross-Validation (NNxMLP_FeatureImportance_CV) assesses the importance of features across all folds by measuring the increase in model error when the feature values are randomly shuffled. The feature importance score for each feature is then averaged across all folds. It applies a template to all folds of NNxMLP_FeatureImportance for setting up the parameters of the permutation method, such as a user-defined confidence interval, and adjusts for multiple comparisons with the Bonferroni correction.';
				case NNxMLP_FeatureImportance_CV.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.ID
					prop_default = 'NNxMLP_FeatureImportance_CV ID';
				case NNxMLP_FeatureImportance_CV.LABEL
					prop_default = 'NNxMLP_FeatureImportance_CV label';
				case NNxMLP_FeatureImportance_CV.NOTES
					prop_default = 'NNxMLP_FeatureImportance_CV notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportance_CV.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportance_CV.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFICV.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNFICV.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportance_CV, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportance_CV.
			%  DEFAULT = NNFICV.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportance_CV, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportance_CV.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNFICV) and Element.GETPROPDEFAULTCONDITIONED('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNxMLP_FeatureImportance_CV.getPropProp(pointer);
			
			prop_default = NNxMLP_FeatureImportance_CV.conditioning(prop, NNxMLP_FeatureImportance_CV.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNFICV.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNFICV.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNFICV.
			%  CHECK = Element.CHECKPROP(NNxMLP_FeatureImportance_CV, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportance_CV.
			%  CHECK = NNFICV.CHECKPROP(NNxMLP_FeatureImportance_CV, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportance_CV.
			% 
			% NNFICV.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNxMLP_FeatureImportance_CV:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNFICV.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNFICV.
			%   Error id: €BRAPH2.STR€:NNxMLP_FeatureImportance_CV:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNxMLP_FeatureImportance_CV, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportance_CV.
			%   Error id: €BRAPH2.STR€:NNxMLP_FeatureImportance_CV:€BRAPH2.WRONG_INPUT€
			%  NNFICV.CHECKPROP(NNxMLP_FeatureImportance_CV, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportance_CV.
			%   Error id: €BRAPH2.STR€:NNxMLP_FeatureImportance_CV:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(NNFICV) and Element.CHECKPROP('NNxMLP_FeatureImportance_CV')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNxMLP_FeatureImportance_CV.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportance_CV.NNCV % __NNxMLP_FeatureImportance_CV.NNCV__
					check = Format.checkFormat(Format.ITEM, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.FI_TEMPLATE % __NNxMLP_FeatureImportance_CV.FI_TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.FI_LIST % __NNxMLP_FeatureImportance_CV.FI_LIST__
					check = Format.checkFormat(Format.ITEMLIST, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.P % __NNxMLP_FeatureImportance_CV.P__
					check = Format.checkFormat(Format.SCALAR, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
					if check
						check = value > 0 && value == round(value);
					end
				case NNxMLP_FeatureImportance_CV.PERM_SEEDS % __NNxMLP_FeatureImportance_CV.PERM_SEEDS__
					check = Format.checkFormat(Format.RVECTOR, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.APPLY_BONFERRONI % __NNxMLP_FeatureImportance_CV.APPLY_BONFERRONI__
					check = Format.checkFormat(Format.LOGICAL, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.APPLY_CONFIDENCE_INTERVALS % __NNxMLP_FeatureImportance_CV.APPLY_CONFIDENCE_INTERVALS__
					check = Format.checkFormat(Format.LOGICAL, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.VERBOSE % __NNxMLP_FeatureImportance_CV.VERBOSE__
					check = Format.checkFormat(Format.LOGICAL, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.SIG_LEVEL % __NNxMLP_FeatureImportance_CV.SIG_LEVEL__
					check = Format.checkFormat(Format.SCALAR, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.WAITBAR % __NNxMLP_FeatureImportance_CV.WAITBAR__
					check = Format.checkFormat(Format.LOGICAL, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.INTERRUPTIBLE % __NNxMLP_FeatureImportance_CV.INTERRUPTIBLE__
					check = Format.checkFormat(Format.SCALAR, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.AV_FEATURE_IMPORTANCE % __NNxMLP_FeatureImportance_CV.AV_FEATURE_IMPORTANCE__
					check = Format.checkFormat(Format.CELL, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.RESHAPED_AV_FEATURE_IMPORTANCE % __NNxMLP_FeatureImportance_CV.RESHAPED_AV_FEATURE_IMPORTANCE__
					check = Format.checkFormat(Format.CELL, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.MAP_TO_CELL % __NNxMLP_FeatureImportance_CV.MAP_TO_CELL__
					check = Format.checkFormat(Format.EMPTY, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.COUNT_ELEMENTS % __NNxMLP_FeatureImportance_CV.COUNT_ELEMENTS__
					check = Format.checkFormat(Format.EMPTY, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.FLATTEN_CELL % __NNxMLP_FeatureImportance_CV.FLATTEN_CELL__
					check = Format.checkFormat(Format.EMPTY, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportance_CV.TEMPLATE % __NNxMLP_FeatureImportance_CV.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNxMLP_FeatureImportance_CV.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_FeatureImportance_CV:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_FeatureImportance_CV:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNxMLP_FeatureImportance_CV.getPropTag(prop) ' (' NNxMLP_FeatureImportance_CV.getFormatTag(NNxMLP_FeatureImportance_CV.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(nnficv, prop)
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
				case NNxMLP_FeatureImportance_CV.P % __NNxMLP_FeatureImportance_CV.P__
					nnficv.memorize('FI_TEMPLATE').set('P', nnficv.getCallback('P'));
					
				case NNxMLP_FeatureImportance_CV.APPLY_BONFERRONI % __NNxMLP_FeatureImportance_CV.APPLY_BONFERRONI__
					nnficv.memorize('FI_TEMPLATE').set('APPLY_BONFERRONI', nnficv.getCallback('APPLY_BONFERRONI'));
					
				case NNxMLP_FeatureImportance_CV.APPLY_CONFIDENCE_INTERVALS % __NNxMLP_FeatureImportance_CV.APPLY_CONFIDENCE_INTERVALS__
					nnficv.memorize('FI_TEMPLATE').set('APPLY_CONFIDENCE_INTERVALS', nnficv.getCallback('APPLY_CONFIDENCE_INTERVALS'));
					
				case NNxMLP_FeatureImportance_CV.SIG_LEVEL % __NNxMLP_FeatureImportance_CV.SIG_LEVEL__
					nnficv.memorize('FI_TEMPLATE').set('SIG_LEVEL', nnficv.getCallback('SIG_LEVEL'));
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						postset@ConcreteElement(nnficv, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nnficv, prop, varargin)
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
				case NNxMLP_FeatureImportance_CV.FI_LIST % __NNxMLP_FeatureImportance_CV.FI_LIST__
					rng_settings_ = rng(); rng(nnficv.getPropSeed(NNxMLP_FeatureImportance_CV.FI_LIST), 'twister')
					
					if ~isa(nnficv.getr('FI_TEMPLATE'), 'NoValue')
					    fi_template = nnficv.get('FI_TEMPLATE');
					else
					    fi_template = NNxMLP_FeatureImportance( ...
					        'P', nnficv.get('P'), ...
					        'APPLY_BONFERRONI', nnficv.get('APPLY_BONFERRONI'), ...
					        'APPLY_CONFIDENCE_INTERVALS', nnficv.get('APPLY_CONFIDENCE_INTERVALS'), ...
					        'SIG_LEVEL', nnficv.get('SIG_LEVEL'));
					end
					
					d_list = nnficv.get('NNCV').get('D_LIST');
					nn_list = nnficv.get('NNCV').get('NN_LIST');
					for i = 1:length(d_list)
					    fi = fi_template.copy();
					    d = d_list{i};
					    nn = nn_list{i};
					    fi.set('TEMPLATE', fi_template, 'D', d, 'NN', nn);
					    fi_list{i} = fi;
					end
					value = fi_list;
					
					rng(rng_settings_)
					
				case NNxMLP_FeatureImportance_CV.PERM_SEEDS % __NNxMLP_FeatureImportance_CV.PERM_SEEDS__
					rng_settings_ = rng(); rng(nnficv.getPropSeed(NNxMLP_FeatureImportance_CV.PERM_SEEDS), 'twister')
					
					value = randi(intmax('uint32'), 1, nnfi.get('P'));
					
					rng(rng_settings_)
					
				case NNxMLP_FeatureImportance_CV.AV_FEATURE_IMPORTANCE % __NNxMLP_FeatureImportance_CV.AV_FEATURE_IMPORTANCE__
					rng_settings_ = rng(); rng(nnficv.getPropSeed(NNxMLP_FeatureImportance_CV.AV_FEATURE_IMPORTANCE), 'twister')
					
					fi_list = nnficv.memorize('FI_LIST');
					fi_value_list = cellfun(@(fi) cell2mat(fi.memorize('FEATURE_IMPORTANCE')'), fi_list, 'UniformOutput', false);
					
					value = {mean(cell2mat(fi_value_list'), 1)};
					
					rng(rng_settings_)
					
				case NNxMLP_FeatureImportance_CV.RESHAPED_AV_FEATURE_IMPORTANCE % __NNxMLP_FeatureImportance_CV.RESHAPED_AV_FEATURE_IMPORTANCE__
					rng_settings_ = rng(); rng(nnficv.getPropSeed(NNxMLP_FeatureImportance_CV.RESHAPED_AV_FEATURE_IMPORTANCE), 'twister')
					
					cell1 = nnficv.get('AV_FEATURE_IMPORTANCE');
					datasets = nnficv.get('NNCV').get('D_LIST');
					cell2 = datasets{1}.get('DP_DICT').get('IT', 1).get('INPUT');
					if ~isequal(numel(cell1), numel(cell2)) 
					    cell1 = nnficv.get('MAP_TO_CELL', cell2mat(cell1), cell2);
					end
					
					value = cell1;
					
					rng(rng_settings_)
					
				case NNxMLP_FeatureImportance_CV.MAP_TO_CELL % __NNxMLP_FeatureImportance_CV.MAP_TO_CELL__
					if isempty(varargin)
					    value = {};
					    return
					end
					vector = varargin{1};
					cell_template = varargin{2};
					mappedCellArray = cell_template;
					index = 1;
					for i = 1:numel(cell_template)
					    cellData = cell_template{i};
					    if iscell(cellData)
					        % Map the vector to nested cell arrays recursively
					        numElements = nnficv.get('COUNT_ELEMENTS', cellData);
					        nestedVector = vector(index:index + numElements - 1);
					        mappedCellArray{i} = nnficv.get('MAP_TO_CELL', nestedVector, cellData);
					        index = index + numElements;
					    else
					        % Assign elements from the vector to cells
					        numElements = numel(cellData);
					        mappedCellArray{i} = reshape(vector(index:index + numElements - 1), size(cellData));
					        index = index + numElements;
					    end
					end
					
					value = mappedCellArray;
					
				case NNxMLP_FeatureImportance_CV.COUNT_ELEMENTS % __NNxMLP_FeatureImportance_CV.COUNT_ELEMENTS__
					if isempty(varargin)
					    value = {};
					    return
					end
					cell_data = varargin{1};
					count = 0;
					for i = 1:numel(cell_data)
					    if iscell(cell_data{i})
					        count = count + nnficv.get('COUNT_ELEMENTS', cell_data{i});
					    else
					        count = count + numel(cell_data{i});
					    end
					end
					
					value = count;
					
				case NNxMLP_FeatureImportance_CV.FLATTEN_CELL % __NNxMLP_FeatureImportance_CV.FLATTEN_CELL__
					if isempty(varargin)
					    value = {};
					    return
					end
					cell_input = varargin{1};
					flattened_input = [];
					while ~isempty(cell_input)
					    currentData = cell_input{end};  % Get the last element from the stack
					    cell_input = cell_input(1:end-1);   % Remove the last element
					
					    if iscell(currentData)
					        % If it's a cell array, add its contents to the stack
					        cell_input = [cell_input currentData{:}];
					    else
					        % If it's numeric or other data, append it to the vector
					        flattened_input = [currentData(:); flattened_input];
					    end
					end
					value = flattened_input;
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(nnficv, prop, varargin{:});
					else
						value = calculateValue@Element(nnficv, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(nnficv, prop, varargin)
			%GETPANELPROP returns a prop panel.
			%
			% PR = GETPANELPROP(EL, PROP) returns the panel of prop PROP.
			%
			% PR = GETPANELPROP(EL, PROP, 'Name', Value, ...) sets the properties 
			%  of the panel prop.
			%
			% See also PanelProp, PanelPropAlpha, PanelPropCell, PanelPropClass,
			%  PanelPropClassList, PanelPropColor, PanelPropHandle,
			%  PanelPropHandleList, PanelPropIDict, PanelPropItem, PanelPropLine,
			%  PanelPropItemList, PanelPropLogical, PanelPropMarker, PanelPropMatrix,
			%  PanelPropNet, PanelPropOption, PanelPropScalar, PanelPropSize,
			%  PanelPropString, PanelPropStringList.
			
			switch prop
				case NNxMLP_FeatureImportance_CV.FI_TEMPLATE % __NNxMLP_FeatureImportance_CV.FI_TEMPLATE__
					pr = PanelPropItem('EL', nnficv, 'PROP', NNxMLP_FeatureImportance_CV.FI_TEMPLATE, ...
					    'BUTTON_TEXT', ['FEATURE IMPORTANCE TEMPLATE (' nnficv.get('FI_TEMPLATE').getClass() ')'], ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(nnficv, prop, varargin{:});
					
			end
		end
	end
end
