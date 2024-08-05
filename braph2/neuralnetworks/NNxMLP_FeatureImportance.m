classdef NNxMLP_FeatureImportance < ConcreteElement
	%NNxMLP_FeatureImportance provides feature importance analysis for multi-layer perceptron (MLP) using shuffled feature method.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A neural network feature importace for multi-layer perceptron (NNxMLP_FeatureImportance) 
	%  assesses the importance of features by measuring the increase in model error when the feature values are randomly shuffled. 
	% It introduces the permutation method to establish the significance of each feature (or composite features) by comparing the 
	%  original model loss to the distribution of losses obtained from several shuffled iterations, providing a robust statistical 
	%  analysis of feature importance using a user-defined confidence interval and adjusting for multiple comparisons with the Bonferroni correction.
	%
	% NNxMLP_FeatureImportance methods (constructor):
	%  NNxMLP_FeatureImportance - constructor
	%
	% NNxMLP_FeatureImportance methods:
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
	% NNxMLP_FeatureImportance methods (display):
	%  tostring - string with information about the neural network feature importace for multi-layer perceptron
	%  disp - displays information about the neural network feature importace for multi-layer perceptron
	%  tree - displays the tree of the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportance methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network feature importace for multi-layer perceptron are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportance methods (save/load, Static):
	%  save - saves BRAPH2 neural network feature importace for multi-layer perceptron as b2 file
	%  load - loads a BRAPH2 neural network feature importace for multi-layer perceptron from a b2 file
	%
	% NNxMLP_FeatureImportance method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportance method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportance methods (inspection, Static):
	%  getClass - returns the class of the neural network feature importace for multi-layer perceptron
	%  getSubclasses - returns all subclasses of NNxMLP_FeatureImportance
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
	% NNxMLP_FeatureImportance methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNxMLP_FeatureImportance methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNxMLP_FeatureImportance methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNxMLP_FeatureImportance methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNxMLP_FeatureImportance; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNxMLP_FeatureImportance constants</a>.
	%
	%
	% See also NNDataset, NNDataPoint_Shuffled, NNRegressorMLP, NNClassifierMLP.
	
	properties (Constant) % properties
		D = ConcreteElement.getPropNumber() + 1;
		D_TAG = 'D';
		D_CATEGORY = Category.DATA;
		D_FORMAT = Format.ITEM;
		
		NN = ConcreteElement.getPropNumber() + 2;
		NN_TAG = 'NN';
		NN_CATEGORY = Category.DATA;
		NN_FORMAT = Format.ITEM;
		
		P = ConcreteElement.getPropNumber() + 3;
		P_TAG = 'P';
		P_CATEGORY = Category.PARAMETER;
		P_FORMAT = Format.SCALAR;
		
		PERM_SEEDS = ConcreteElement.getPropNumber() + 4;
		PERM_SEEDS_TAG = 'PERM_SEEDS';
		PERM_SEEDS_CATEGORY = Category.RESULT;
		PERM_SEEDS_FORMAT = Format.RVECTOR;
		
		APPLY_BONFERRONI = ConcreteElement.getPropNumber() + 5;
		APPLY_BONFERRONI_TAG = 'APPLY_BONFERRONI';
		APPLY_BONFERRONI_CATEGORY = Category.PARAMETER;
		APPLY_BONFERRONI_FORMAT = Format.LOGICAL;
		
		APPLY_CONFIDENCE_INTERVALS = ConcreteElement.getPropNumber() + 6;
		APPLY_CONFIDENCE_INTERVALS_TAG = 'APPLY_CONFIDENCE_INTERVALS';
		APPLY_CONFIDENCE_INTERVALS_CATEGORY = Category.PARAMETER;
		APPLY_CONFIDENCE_INTERVALS_FORMAT = Format.LOGICAL;
		
		VERBOSE = ConcreteElement.getPropNumber() + 7;
		VERBOSE_TAG = 'VERBOSE';
		VERBOSE_CATEGORY = Category.METADATA;
		VERBOSE_FORMAT = Format.LOGICAL;
		
		SIG_LEVEL = ConcreteElement.getPropNumber() + 8;
		SIG_LEVEL_TAG = 'SIG_LEVEL';
		SIG_LEVEL_CATEGORY = Category.PARAMETER;
		SIG_LEVEL_FORMAT = Format.SCALAR;
		
		WAITBAR = ConcreteElement.getPropNumber() + 9;
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = Category.GUI;
		WAITBAR_FORMAT = Format.LOGICAL;
		
		INTERRUPTIBLE = ConcreteElement.getPropNumber() + 10;
		INTERRUPTIBLE_TAG = 'INTERRUPTIBLE';
		INTERRUPTIBLE_CATEGORY = Category.GUI;
		INTERRUPTIBLE_FORMAT = Format.SCALAR;
		
		COMP_FEATURE_INDICES = ConcreteElement.getPropNumber() + 11;
		COMP_FEATURE_INDICES_TAG = 'COMP_FEATURE_INDICES';
		COMP_FEATURE_INDICES_CATEGORY = Category.RESULT;
		COMP_FEATURE_INDICES_FORMAT = Format.CELL;
		
		BASELINE_INPUTS = ConcreteElement.getPropNumber() + 12;
		BASELINE_INPUTS_TAG = 'BASELINE_INPUTS';
		BASELINE_INPUTS_CATEGORY = Category.RESULT;
		BASELINE_INPUTS_FORMAT = Format.CELL;
		
		D_SHUFFLED = ConcreteElement.getPropNumber() + 13;
		D_SHUFFLED_TAG = 'D_SHUFFLED';
		D_SHUFFLED_CATEGORY = Category.QUERY;
		D_SHUFFLED_FORMAT = Format.ITEM;
		
		BASELINE_LOSS = ConcreteElement.getPropNumber() + 14;
		BASELINE_LOSS_TAG = 'BASELINE_LOSS';
		BASELINE_LOSS_CATEGORY = Category.RESULT;
		BASELINE_LOSS_FORMAT = Format.SCALAR;
		
		SHUFFLED_LOSS = ConcreteElement.getPropNumber() + 15;
		SHUFFLED_LOSS_TAG = 'SHUFFLED_LOSS';
		SHUFFLED_LOSS_CATEGORY = Category.QUERY;
		SHUFFLED_LOSS_FORMAT = Format.CELL;
		
		PERM_SHUFFLED_LOSS = ConcreteElement.getPropNumber() + 16;
		PERM_SHUFFLED_LOSS_TAG = 'PERM_SHUFFLED_LOSS';
		PERM_SHUFFLED_LOSS_CATEGORY = Category.RESULT;
		PERM_SHUFFLED_LOSS_FORMAT = Format.CELL;
		
		CONFIDENCE_INTERVALS = ConcreteElement.getPropNumber() + 17;
		CONFIDENCE_INTERVALS_TAG = 'CONFIDENCE_INTERVALS';
		CONFIDENCE_INTERVALS_CATEGORY = Category.QUERY;
		CONFIDENCE_INTERVALS_FORMAT = Format.RVECTOR;
		
		STAT_SIG_MASK = ConcreteElement.getPropNumber() + 18;
		STAT_SIG_MASK_TAG = 'STAT_SIG_MASK';
		STAT_SIG_MASK_CATEGORY = Category.RESULT;
		STAT_SIG_MASK_FORMAT = Format.CELL;
		
		FEATURE_IMPORTANCE = ConcreteElement.getPropNumber() + 19;
		FEATURE_IMPORTANCE_TAG = 'FEATURE_IMPORTANCE';
		FEATURE_IMPORTANCE_CATEGORY = Category.RESULT;
		FEATURE_IMPORTANCE_FORMAT = Format.CELL;
		
		RESHAPED_FEATURE_IMPORTANCE = ConcreteElement.getPropNumber() + 20;
		RESHAPED_FEATURE_IMPORTANCE_TAG = 'RESHAPED_FEATURE_IMPORTANCE';
		RESHAPED_FEATURE_IMPORTANCE_CATEGORY = Category.QUERY;
		RESHAPED_FEATURE_IMPORTANCE_FORMAT = Format.EMPTY;
		
		MAP_TO_CELL = ConcreteElement.getPropNumber() + 21;
		MAP_TO_CELL_TAG = 'MAP_TO_CELL';
		MAP_TO_CELL_CATEGORY = Category.QUERY;
		MAP_TO_CELL_FORMAT = Format.EMPTY;
		
		COUNT_ELEMENTS = ConcreteElement.getPropNumber() + 22;
		COUNT_ELEMENTS_TAG = 'COUNT_ELEMENTS';
		COUNT_ELEMENTS_CATEGORY = Category.QUERY;
		COUNT_ELEMENTS_FORMAT = Format.EMPTY;
		
		FLATTEN_CELL = ConcreteElement.getPropNumber() + 23;
		FLATTEN_CELL_TAG = 'FLATTEN_CELL';
		FLATTEN_CELL_CATEGORY = Category.QUERY;
		FLATTEN_CELL_FORMAT = Format.EMPTY;
	end
	methods % constructor
		function nnfi = NNxMLP_FeatureImportance(varargin)
			%NNxMLP_FeatureImportance() creates a neural network feature importace for multi-layer perceptron.
			%
			% NNxMLP_FeatureImportance(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNxMLP_FeatureImportance(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			nnfi = nnfi@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function nnfi_class = getClass()
			%GETCLASS returns the class of the neural network feature importace for multi-layer perceptron.
			%
			% CLASS = NNxMLP_FeatureImportance.GETCLASS() returns the class 'NNxMLP_FeatureImportance'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNFI.GETCLASS() returns the class of the neural network feature importace for multi-layer perceptron NNFI.
			%  CLASS = Element.GETCLASS(NNFI) returns the class of 'NNFI'.
			%  CLASS = Element.GETCLASS('NNxMLP_FeatureImportance') returns 'NNxMLP_FeatureImportance'.
			%
			% Note that the Element.GETCLASS(NNFI) and Element.GETCLASS('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			
			nnfi_class = 'NNxMLP_FeatureImportance';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network feature importace for multi-layer perceptron.
			%
			% LIST = NNxMLP_FeatureImportance.GETSUBCLASSES() returns all subclasses of 'NNxMLP_FeatureImportance'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNFI.GETSUBCLASSES() returns all subclasses of the neural network feature importace for multi-layer perceptron NNFI.
			%  LIST = Element.GETSUBCLASSES(NNFI) returns all subclasses of 'NNFI'.
			%  LIST = Element.GETSUBCLASSES('NNxMLP_FeatureImportance') returns all subclasses of 'NNxMLP_FeatureImportance'.
			%
			% Note that the Element.GETSUBCLASSES(NNFI) and Element.GETSUBCLASSES('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNxMLP_FeatureImportance', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network feature importace for multi-layer perceptron.
			%
			% PROPS = NNxMLP_FeatureImportance.GETPROPS() returns the property list of neural network feature importace for multi-layer perceptron
			%  as a row vector.
			%
			% PROPS = NNxMLP_FeatureImportance.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNFI.GETPROPS([CATEGORY]) returns the property list of the neural network feature importace for multi-layer perceptron NNFI.
			%  PROPS = Element.GETPROPS(NNFI[, CATEGORY]) returns the property list of 'NNFI'.
			%  PROPS = Element.GETPROPS('NNxMLP_FeatureImportance'[, CATEGORY]) returns the property list of 'NNxMLP_FeatureImportance'.
			%
			% Note that the Element.GETPROPS(NNFI) and Element.GETPROPS('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						NNxMLP_FeatureImportance.D ...
						NNxMLP_FeatureImportance.NN ...
						NNxMLP_FeatureImportance.P ...
						NNxMLP_FeatureImportance.PERM_SEEDS ...
						NNxMLP_FeatureImportance.APPLY_BONFERRONI ...
						NNxMLP_FeatureImportance.APPLY_CONFIDENCE_INTERVALS ...
						NNxMLP_FeatureImportance.VERBOSE ...
						NNxMLP_FeatureImportance.SIG_LEVEL ...
						NNxMLP_FeatureImportance.WAITBAR ...
						NNxMLP_FeatureImportance.INTERRUPTIBLE ...
						NNxMLP_FeatureImportance.COMP_FEATURE_INDICES ...
						NNxMLP_FeatureImportance.BASELINE_INPUTS ...
						NNxMLP_FeatureImportance.D_SHUFFLED ...
						NNxMLP_FeatureImportance.BASELINE_LOSS ...
						NNxMLP_FeatureImportance.SHUFFLED_LOSS ...
						NNxMLP_FeatureImportance.PERM_SHUFFLED_LOSS ...
						NNxMLP_FeatureImportance.CONFIDENCE_INTERVALS ...
						NNxMLP_FeatureImportance.STAT_SIG_MASK ...
						NNxMLP_FeatureImportance.FEATURE_IMPORTANCE ...
						NNxMLP_FeatureImportance.RESHAPED_FEATURE_IMPORTANCE ...
						NNxMLP_FeatureImportance.MAP_TO_CELL ...
						NNxMLP_FeatureImportance.COUNT_ELEMENTS ...
						NNxMLP_FeatureImportance.FLATTEN_CELL ...
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
						NNxMLP_FeatureImportance.VERBOSE ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						NNxMLP_FeatureImportance.P ...
						NNxMLP_FeatureImportance.APPLY_BONFERRONI ...
						NNxMLP_FeatureImportance.APPLY_CONFIDENCE_INTERVALS ...
						NNxMLP_FeatureImportance.SIG_LEVEL ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						NNxMLP_FeatureImportance.D ...
						NNxMLP_FeatureImportance.NN ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						NNxMLP_FeatureImportance.PERM_SEEDS ...
						NNxMLP_FeatureImportance.COMP_FEATURE_INDICES ...
						NNxMLP_FeatureImportance.BASELINE_INPUTS ...
						NNxMLP_FeatureImportance.BASELINE_LOSS ...
						NNxMLP_FeatureImportance.PERM_SHUFFLED_LOSS ...
						NNxMLP_FeatureImportance.STAT_SIG_MASK ...
						NNxMLP_FeatureImportance.FEATURE_IMPORTANCE ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						NNxMLP_FeatureImportance.D_SHUFFLED ...
						NNxMLP_FeatureImportance.SHUFFLED_LOSS ...
						NNxMLP_FeatureImportance.CONFIDENCE_INTERVALS ...
						NNxMLP_FeatureImportance.RESHAPED_FEATURE_IMPORTANCE ...
						NNxMLP_FeatureImportance.MAP_TO_CELL ...
						NNxMLP_FeatureImportance.COUNT_ELEMENTS ...
						NNxMLP_FeatureImportance.FLATTEN_CELL ...
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
						NNxMLP_FeatureImportance.WAITBAR ...
						NNxMLP_FeatureImportance.INTERRUPTIBLE ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network feature importace for multi-layer perceptron.
			%
			% N = NNxMLP_FeatureImportance.GETPROPNUMBER() returns the property number of neural network feature importace for multi-layer perceptron.
			%
			% N = NNxMLP_FeatureImportance.GETPROPNUMBER(CATEGORY) returns the property number of neural network feature importace for multi-layer perceptron
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNFI.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network feature importace for multi-layer perceptron NNFI.
			%  N = Element.GETPROPNUMBER(NNFI) returns the property number of 'NNFI'.
			%  N = Element.GETPROPNUMBER('NNxMLP_FeatureImportance') returns the property number of 'NNxMLP_FeatureImportance'.
			%
			% Note that the Element.GETPROPNUMBER(NNFI) and Element.GETPROPNUMBER('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNxMLP_FeatureImportance.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network feature importace for multi-layer perceptron/error.
			%
			% CHECK = NNxMLP_FeatureImportance.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFI.EXISTSPROP(PROP) checks whether PROP exists for NNFI.
			%  CHECK = Element.EXISTSPROP(NNFI, PROP) checks whether PROP exists for NNFI.
			%  CHECK = Element.EXISTSPROP(NNxMLP_FeatureImportance, PROP) checks whether PROP exists for NNxMLP_FeatureImportance.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportance:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFI.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNFI.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance:WrongInput]
			%  Element.EXISTSPROP(NNFI, PROP) throws error if PROP does NOT exist for NNFI.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance:WrongInput]
			%  Element.EXISTSPROP(NNxMLP_FeatureImportance, PROP) throws error if PROP does NOT exist for NNxMLP_FeatureImportance.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNFI) and Element.EXISTSPROP('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNxMLP_FeatureImportance.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_FeatureImportance:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_FeatureImportance:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNxMLP_FeatureImportance.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network feature importace for multi-layer perceptron/error.
			%
			% CHECK = NNxMLP_FeatureImportance.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFI.EXISTSTAG(TAG) checks whether TAG exists for NNFI.
			%  CHECK = Element.EXISTSTAG(NNFI, TAG) checks whether TAG exists for NNFI.
			%  CHECK = Element.EXISTSTAG(NNxMLP_FeatureImportance, TAG) checks whether TAG exists for NNxMLP_FeatureImportance.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportance:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFI.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNFI.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance:WrongInput]
			%  Element.EXISTSTAG(NNFI, TAG) throws error if TAG does NOT exist for NNFI.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance:WrongInput]
			%  Element.EXISTSTAG(NNxMLP_FeatureImportance, TAG) throws error if TAG does NOT exist for NNxMLP_FeatureImportance.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportance:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNFI) and Element.EXISTSTAG('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnxmlp_featureimportance_tag_list = cellfun(@(x) NNxMLP_FeatureImportance.getPropTag(x), num2cell(NNxMLP_FeatureImportance.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnxmlp_featureimportance_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_FeatureImportance:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_FeatureImportance:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNxMLP_FeatureImportance.'] ...
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
			%  PROPERTY = NNFI.GETPROPPROP(POINTER) returns property number of POINTER of NNFI.
			%  PROPERTY = Element.GETPROPPROP(NNxMLP_FeatureImportance, POINTER) returns property number of POINTER of NNxMLP_FeatureImportance.
			%  PROPERTY = NNFI.GETPROPPROP(NNxMLP_FeatureImportance, POINTER) returns property number of POINTER of NNxMLP_FeatureImportance.
			%
			% Note that the Element.GETPROPPROP(NNFI) and Element.GETPROPPROP('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnxmlp_featureimportance_tag_list = cellfun(@(x) NNxMLP_FeatureImportance.getPropTag(x), num2cell(NNxMLP_FeatureImportance.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnxmlp_featureimportance_tag_list)); % tag = pointer
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
			%  TAG = NNFI.GETPROPTAG(POINTER) returns tag of POINTER of NNFI.
			%  TAG = Element.GETPROPTAG(NNxMLP_FeatureImportance, POINTER) returns tag of POINTER of NNxMLP_FeatureImportance.
			%  TAG = NNFI.GETPROPTAG(NNxMLP_FeatureImportance, POINTER) returns tag of POINTER of NNxMLP_FeatureImportance.
			%
			% Note that the Element.GETPROPTAG(NNFI) and Element.GETPROPTAG('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNxMLP_FeatureImportance.D
						tag = NNxMLP_FeatureImportance.D_TAG;
					case NNxMLP_FeatureImportance.NN
						tag = NNxMLP_FeatureImportance.NN_TAG;
					case NNxMLP_FeatureImportance.P
						tag = NNxMLP_FeatureImportance.P_TAG;
					case NNxMLP_FeatureImportance.PERM_SEEDS
						tag = NNxMLP_FeatureImportance.PERM_SEEDS_TAG;
					case NNxMLP_FeatureImportance.APPLY_BONFERRONI
						tag = NNxMLP_FeatureImportance.APPLY_BONFERRONI_TAG;
					case NNxMLP_FeatureImportance.APPLY_CONFIDENCE_INTERVALS
						tag = NNxMLP_FeatureImportance.APPLY_CONFIDENCE_INTERVALS_TAG;
					case NNxMLP_FeatureImportance.VERBOSE
						tag = NNxMLP_FeatureImportance.VERBOSE_TAG;
					case NNxMLP_FeatureImportance.SIG_LEVEL
						tag = NNxMLP_FeatureImportance.SIG_LEVEL_TAG;
					case NNxMLP_FeatureImportance.WAITBAR
						tag = NNxMLP_FeatureImportance.WAITBAR_TAG;
					case NNxMLP_FeatureImportance.INTERRUPTIBLE
						tag = NNxMLP_FeatureImportance.INTERRUPTIBLE_TAG;
					case NNxMLP_FeatureImportance.COMP_FEATURE_INDICES
						tag = NNxMLP_FeatureImportance.COMP_FEATURE_INDICES_TAG;
					case NNxMLP_FeatureImportance.BASELINE_INPUTS
						tag = NNxMLP_FeatureImportance.BASELINE_INPUTS_TAG;
					case NNxMLP_FeatureImportance.D_SHUFFLED
						tag = NNxMLP_FeatureImportance.D_SHUFFLED_TAG;
					case NNxMLP_FeatureImportance.BASELINE_LOSS
						tag = NNxMLP_FeatureImportance.BASELINE_LOSS_TAG;
					case NNxMLP_FeatureImportance.SHUFFLED_LOSS
						tag = NNxMLP_FeatureImportance.SHUFFLED_LOSS_TAG;
					case NNxMLP_FeatureImportance.PERM_SHUFFLED_LOSS
						tag = NNxMLP_FeatureImportance.PERM_SHUFFLED_LOSS_TAG;
					case NNxMLP_FeatureImportance.CONFIDENCE_INTERVALS
						tag = NNxMLP_FeatureImportance.CONFIDENCE_INTERVALS_TAG;
					case NNxMLP_FeatureImportance.STAT_SIG_MASK
						tag = NNxMLP_FeatureImportance.STAT_SIG_MASK_TAG;
					case NNxMLP_FeatureImportance.FEATURE_IMPORTANCE
						tag = NNxMLP_FeatureImportance.FEATURE_IMPORTANCE_TAG;
					case NNxMLP_FeatureImportance.RESHAPED_FEATURE_IMPORTANCE
						tag = NNxMLP_FeatureImportance.RESHAPED_FEATURE_IMPORTANCE_TAG;
					case NNxMLP_FeatureImportance.MAP_TO_CELL
						tag = NNxMLP_FeatureImportance.MAP_TO_CELL_TAG;
					case NNxMLP_FeatureImportance.COUNT_ELEMENTS
						tag = NNxMLP_FeatureImportance.COUNT_ELEMENTS_TAG;
					case NNxMLP_FeatureImportance.FLATTEN_CELL
						tag = NNxMLP_FeatureImportance.FLATTEN_CELL_TAG;
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
			%  CATEGORY = NNFI.GETPROPCATEGORY(POINTER) returns category of POINTER of NNFI.
			%  CATEGORY = Element.GETPROPCATEGORY(NNxMLP_FeatureImportance, POINTER) returns category of POINTER of NNxMLP_FeatureImportance.
			%  CATEGORY = NNFI.GETPROPCATEGORY(NNxMLP_FeatureImportance, POINTER) returns category of POINTER of NNxMLP_FeatureImportance.
			%
			% Note that the Element.GETPROPCATEGORY(NNFI) and Element.GETPROPCATEGORY('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportance.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportance.D
					prop_category = NNxMLP_FeatureImportance.D_CATEGORY;
				case NNxMLP_FeatureImportance.NN
					prop_category = NNxMLP_FeatureImportance.NN_CATEGORY;
				case NNxMLP_FeatureImportance.P
					prop_category = NNxMLP_FeatureImportance.P_CATEGORY;
				case NNxMLP_FeatureImportance.PERM_SEEDS
					prop_category = NNxMLP_FeatureImportance.PERM_SEEDS_CATEGORY;
				case NNxMLP_FeatureImportance.APPLY_BONFERRONI
					prop_category = NNxMLP_FeatureImportance.APPLY_BONFERRONI_CATEGORY;
				case NNxMLP_FeatureImportance.APPLY_CONFIDENCE_INTERVALS
					prop_category = NNxMLP_FeatureImportance.APPLY_CONFIDENCE_INTERVALS_CATEGORY;
				case NNxMLP_FeatureImportance.VERBOSE
					prop_category = NNxMLP_FeatureImportance.VERBOSE_CATEGORY;
				case NNxMLP_FeatureImportance.SIG_LEVEL
					prop_category = NNxMLP_FeatureImportance.SIG_LEVEL_CATEGORY;
				case NNxMLP_FeatureImportance.WAITBAR
					prop_category = NNxMLP_FeatureImportance.WAITBAR_CATEGORY;
				case NNxMLP_FeatureImportance.INTERRUPTIBLE
					prop_category = NNxMLP_FeatureImportance.INTERRUPTIBLE_CATEGORY;
				case NNxMLP_FeatureImportance.COMP_FEATURE_INDICES
					prop_category = NNxMLP_FeatureImportance.COMP_FEATURE_INDICES_CATEGORY;
				case NNxMLP_FeatureImportance.BASELINE_INPUTS
					prop_category = NNxMLP_FeatureImportance.BASELINE_INPUTS_CATEGORY;
				case NNxMLP_FeatureImportance.D_SHUFFLED
					prop_category = NNxMLP_FeatureImportance.D_SHUFFLED_CATEGORY;
				case NNxMLP_FeatureImportance.BASELINE_LOSS
					prop_category = NNxMLP_FeatureImportance.BASELINE_LOSS_CATEGORY;
				case NNxMLP_FeatureImportance.SHUFFLED_LOSS
					prop_category = NNxMLP_FeatureImportance.SHUFFLED_LOSS_CATEGORY;
				case NNxMLP_FeatureImportance.PERM_SHUFFLED_LOSS
					prop_category = NNxMLP_FeatureImportance.PERM_SHUFFLED_LOSS_CATEGORY;
				case NNxMLP_FeatureImportance.CONFIDENCE_INTERVALS
					prop_category = NNxMLP_FeatureImportance.CONFIDENCE_INTERVALS_CATEGORY;
				case NNxMLP_FeatureImportance.STAT_SIG_MASK
					prop_category = NNxMLP_FeatureImportance.STAT_SIG_MASK_CATEGORY;
				case NNxMLP_FeatureImportance.FEATURE_IMPORTANCE
					prop_category = NNxMLP_FeatureImportance.FEATURE_IMPORTANCE_CATEGORY;
				case NNxMLP_FeatureImportance.RESHAPED_FEATURE_IMPORTANCE
					prop_category = NNxMLP_FeatureImportance.RESHAPED_FEATURE_IMPORTANCE_CATEGORY;
				case NNxMLP_FeatureImportance.MAP_TO_CELL
					prop_category = NNxMLP_FeatureImportance.MAP_TO_CELL_CATEGORY;
				case NNxMLP_FeatureImportance.COUNT_ELEMENTS
					prop_category = NNxMLP_FeatureImportance.COUNT_ELEMENTS_CATEGORY;
				case NNxMLP_FeatureImportance.FLATTEN_CELL
					prop_category = NNxMLP_FeatureImportance.FLATTEN_CELL_CATEGORY;
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
			%  FORMAT = NNFI.GETPROPFORMAT(POINTER) returns format of POINTER of NNFI.
			%  FORMAT = Element.GETPROPFORMAT(NNxMLP_FeatureImportance, POINTER) returns format of POINTER of NNxMLP_FeatureImportance.
			%  FORMAT = NNFI.GETPROPFORMAT(NNxMLP_FeatureImportance, POINTER) returns format of POINTER of NNxMLP_FeatureImportance.
			%
			% Note that the Element.GETPROPFORMAT(NNFI) and Element.GETPROPFORMAT('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportance.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportance.D
					prop_format = NNxMLP_FeatureImportance.D_FORMAT;
				case NNxMLP_FeatureImportance.NN
					prop_format = NNxMLP_FeatureImportance.NN_FORMAT;
				case NNxMLP_FeatureImportance.P
					prop_format = NNxMLP_FeatureImportance.P_FORMAT;
				case NNxMLP_FeatureImportance.PERM_SEEDS
					prop_format = NNxMLP_FeatureImportance.PERM_SEEDS_FORMAT;
				case NNxMLP_FeatureImportance.APPLY_BONFERRONI
					prop_format = NNxMLP_FeatureImportance.APPLY_BONFERRONI_FORMAT;
				case NNxMLP_FeatureImportance.APPLY_CONFIDENCE_INTERVALS
					prop_format = NNxMLP_FeatureImportance.APPLY_CONFIDENCE_INTERVALS_FORMAT;
				case NNxMLP_FeatureImportance.VERBOSE
					prop_format = NNxMLP_FeatureImportance.VERBOSE_FORMAT;
				case NNxMLP_FeatureImportance.SIG_LEVEL
					prop_format = NNxMLP_FeatureImportance.SIG_LEVEL_FORMAT;
				case NNxMLP_FeatureImportance.WAITBAR
					prop_format = NNxMLP_FeatureImportance.WAITBAR_FORMAT;
				case NNxMLP_FeatureImportance.INTERRUPTIBLE
					prop_format = NNxMLP_FeatureImportance.INTERRUPTIBLE_FORMAT;
				case NNxMLP_FeatureImportance.COMP_FEATURE_INDICES
					prop_format = NNxMLP_FeatureImportance.COMP_FEATURE_INDICES_FORMAT;
				case NNxMLP_FeatureImportance.BASELINE_INPUTS
					prop_format = NNxMLP_FeatureImportance.BASELINE_INPUTS_FORMAT;
				case NNxMLP_FeatureImportance.D_SHUFFLED
					prop_format = NNxMLP_FeatureImportance.D_SHUFFLED_FORMAT;
				case NNxMLP_FeatureImportance.BASELINE_LOSS
					prop_format = NNxMLP_FeatureImportance.BASELINE_LOSS_FORMAT;
				case NNxMLP_FeatureImportance.SHUFFLED_LOSS
					prop_format = NNxMLP_FeatureImportance.SHUFFLED_LOSS_FORMAT;
				case NNxMLP_FeatureImportance.PERM_SHUFFLED_LOSS
					prop_format = NNxMLP_FeatureImportance.PERM_SHUFFLED_LOSS_FORMAT;
				case NNxMLP_FeatureImportance.CONFIDENCE_INTERVALS
					prop_format = NNxMLP_FeatureImportance.CONFIDENCE_INTERVALS_FORMAT;
				case NNxMLP_FeatureImportance.STAT_SIG_MASK
					prop_format = NNxMLP_FeatureImportance.STAT_SIG_MASK_FORMAT;
				case NNxMLP_FeatureImportance.FEATURE_IMPORTANCE
					prop_format = NNxMLP_FeatureImportance.FEATURE_IMPORTANCE_FORMAT;
				case NNxMLP_FeatureImportance.RESHAPED_FEATURE_IMPORTANCE
					prop_format = NNxMLP_FeatureImportance.RESHAPED_FEATURE_IMPORTANCE_FORMAT;
				case NNxMLP_FeatureImportance.MAP_TO_CELL
					prop_format = NNxMLP_FeatureImportance.MAP_TO_CELL_FORMAT;
				case NNxMLP_FeatureImportance.COUNT_ELEMENTS
					prop_format = NNxMLP_FeatureImportance.COUNT_ELEMENTS_FORMAT;
				case NNxMLP_FeatureImportance.FLATTEN_CELL
					prop_format = NNxMLP_FeatureImportance.FLATTEN_CELL_FORMAT;
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
			%  DESCRIPTION = NNFI.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNFI.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNxMLP_FeatureImportance, POINTER) returns description of POINTER of NNxMLP_FeatureImportance.
			%  DESCRIPTION = NNFI.GETPROPDESCRIPTION(NNxMLP_FeatureImportance, POINTER) returns description of POINTER of NNxMLP_FeatureImportance.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNFI) and Element.GETPROPDESCRIPTION('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportance.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportance.D
					prop_description = 'D (data, item) is the NN dataset to be tested on feature importance.';
				case NNxMLP_FeatureImportance.NN
					prop_description = 'NN (data, item) contains a trained neural network multi-layer perceptron classifier or regressor.';
				case NNxMLP_FeatureImportance.P
					prop_description = 'P (parameter, scalar) is the permutation number that determines the statistical significance of the features. ';
				case NNxMLP_FeatureImportance.PERM_SEEDS
					prop_description = 'PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.';
				case NNxMLP_FeatureImportance.APPLY_BONFERRONI
					prop_description = 'APPLY_BONFERRONI (parameter, logical) determines whether to apply Bonferroni correction.';
				case NNxMLP_FeatureImportance.APPLY_CONFIDENCE_INTERVALS
					prop_description = 'APPLY_CONFIDENCE_INTERVALS (parameter, logical) determines whether to apply user-defined percent confidence interval.';
				case NNxMLP_FeatureImportance.VERBOSE
					prop_description = 'VERBOSE (metadata, logical) is an indicator to display permutation progress information.';
				case NNxMLP_FeatureImportance.SIG_LEVEL
					prop_description = 'SIG_LEVEL (parameter, scalar) determines the significant level.';
				case NNxMLP_FeatureImportance.WAITBAR
					prop_description = 'WAITBAR (gui, logical) determines whether to show the waitbar.';
				case NNxMLP_FeatureImportance.INTERRUPTIBLE
					prop_description = 'INTERRUPTIBLE (gui, scalar) sets whether the permutation computation is interruptible for multitasking.';
				case NNxMLP_FeatureImportance.COMP_FEATURE_INDICES
					prop_description = 'COMP_FEATURE_INDICES (result, cell) provides the indices of combined features, represented as a cell array containing sets of feature indices, such as {[1], [2], [3]} or {[1, 2], [2, 3], [1, 3]}.';
				case NNxMLP_FeatureImportance.BASELINE_INPUTS
					prop_description = 'BASELINE_INPUTS (result, cell) retrieves the input data to be shuffled.';
				case NNxMLP_FeatureImportance.D_SHUFFLED
					prop_description = 'D_SHUFFLED (query, item) generates a shuffled version of the dataset where the features of given indexes are replaced with random values drawn from a distribution with the same mean and standard deviation as the orginal ones.';
				case NNxMLP_FeatureImportance.BASELINE_LOSS
					prop_description = 'BASELINE_LOSS (result, scalar) is the loss value obtained from original dataset, acting as a baseline loss value for evaluating the feature importance.';
				case NNxMLP_FeatureImportance.SHUFFLED_LOSS
					prop_description = 'SHUFFLED_LOSS (query, cell) is the loss value obtained from shuffled datasets.';
				case NNxMLP_FeatureImportance.PERM_SHUFFLED_LOSS
					prop_description = 'PERM_SHUFFLED_LOSS (result, cell) is the permutation test for obtaining shuffled loss for a number of times in order to establish confidence interval.';
				case NNxMLP_FeatureImportance.CONFIDENCE_INTERVALS
					prop_description = 'CONFIDENCE_INTERVALS (query, rvector) derives the 95 percent of confidence interval for the permuation of shuffled loss values.';
				case NNxMLP_FeatureImportance.STAT_SIG_MASK
					prop_description = 'STAT_SIG_MASK (result, cell) provides the statistical significance mask for composite features indicating which composite features has significant contribution.';
				case NNxMLP_FeatureImportance.FEATURE_IMPORTANCE
					prop_description = 'FEATURE_IMPORTANCE (result, cell) is determined by applying Bonferroni correction for the permutation and obtaining the value by the average of the permutation number times of shuffled loss, which then in trun are divided by base loss for normalizaiton.';
				case NNxMLP_FeatureImportance.RESHAPED_FEATURE_IMPORTANCE
					prop_description = 'RESHAPED_FEATURE_IMPORTANCE (query, empty) reshapes the cell of feature importances with the input data.';
				case NNxMLP_FeatureImportance.MAP_TO_CELL
					prop_description = 'MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.';
				case NNxMLP_FeatureImportance.COUNT_ELEMENTS
					prop_description = 'COUNT_ELEMENTS (query, empty) counts the total number of elements within a nested cell array.';
				case NNxMLP_FeatureImportance.FLATTEN_CELL
					prop_description = 'FLATTEN_CELL (query, empty) flattens a cell array into to a single vector.';
				case NNxMLP_FeatureImportance.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the feature importance analysis.';
				case NNxMLP_FeatureImportance.NAME
					prop_description = 'NAME (constant, string) is the name of the feature importance analysis.';
				case NNxMLP_FeatureImportance.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the feature importance analysis.';
				case NNxMLP_FeatureImportance.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the feature importance analysis.';
				case NNxMLP_FeatureImportance.ID
					prop_description = 'ID (data, string) is a few-letter code of the feature importance analysis.';
				case NNxMLP_FeatureImportance.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the feature importance analysis.';
				case NNxMLP_FeatureImportance.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the feature importance analysis.';
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
			%  SETTINGS = NNFI.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNFI.
			%  SETTINGS = Element.GETPROPSETTINGS(NNxMLP_FeatureImportance, POINTER) returns settings of POINTER of NNxMLP_FeatureImportance.
			%  SETTINGS = NNFI.GETPROPSETTINGS(NNxMLP_FeatureImportance, POINTER) returns settings of POINTER of NNxMLP_FeatureImportance.
			%
			% Note that the Element.GETPROPSETTINGS(NNFI) and Element.GETPROPSETTINGS('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportance.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportance.D
					prop_settings = 'NNDataset';
				case NNxMLP_FeatureImportance.NN
					prop_settings = 'NNBase';
				case NNxMLP_FeatureImportance.P
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNxMLP_FeatureImportance.PERM_SEEDS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case NNxMLP_FeatureImportance.APPLY_BONFERRONI
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNxMLP_FeatureImportance.APPLY_CONFIDENCE_INTERVALS
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNxMLP_FeatureImportance.VERBOSE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNxMLP_FeatureImportance.SIG_LEVEL
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNxMLP_FeatureImportance.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNxMLP_FeatureImportance.INTERRUPTIBLE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNxMLP_FeatureImportance.COMP_FEATURE_INDICES
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNxMLP_FeatureImportance.BASELINE_INPUTS
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNxMLP_FeatureImportance.D_SHUFFLED
					prop_settings = 'NNDataset';
				case NNxMLP_FeatureImportance.BASELINE_LOSS
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNxMLP_FeatureImportance.SHUFFLED_LOSS
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNxMLP_FeatureImportance.PERM_SHUFFLED_LOSS
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNxMLP_FeatureImportance.CONFIDENCE_INTERVALS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case NNxMLP_FeatureImportance.STAT_SIG_MASK
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNxMLP_FeatureImportance.FEATURE_IMPORTANCE
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNxMLP_FeatureImportance.RESHAPED_FEATURE_IMPORTANCE
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case NNxMLP_FeatureImportance.MAP_TO_CELL
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case NNxMLP_FeatureImportance.COUNT_ELEMENTS
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case NNxMLP_FeatureImportance.FLATTEN_CELL
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case NNxMLP_FeatureImportance.TEMPLATE
					prop_settings = 'NNxMLP_FeatureImportance';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportance.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportance.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFI.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNFI.
			%  DEFAULT = Element.GETPROPDEFAULT(NNxMLP_FeatureImportance, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportance.
			%  DEFAULT = NNFI.GETPROPDEFAULT(NNxMLP_FeatureImportance, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportance.
			%
			% Note that the Element.GETPROPDEFAULT(NNFI) and Element.GETPROPDEFAULT('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNxMLP_FeatureImportance.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportance.D
					prop_default = Format.getFormatDefault(Format.ITEM, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.NN
					prop_default = Format.getFormatDefault(Format.ITEM, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.P
					prop_default = 1e+2;
				case NNxMLP_FeatureImportance.PERM_SEEDS
					prop_default = Format.getFormatDefault(Format.RVECTOR, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.APPLY_BONFERRONI
					prop_default = true;
				case NNxMLP_FeatureImportance.APPLY_CONFIDENCE_INTERVALS
					prop_default = true;
				case NNxMLP_FeatureImportance.VERBOSE
					prop_default = false;
				case NNxMLP_FeatureImportance.SIG_LEVEL
					prop_default = 0.05;
				case NNxMLP_FeatureImportance.WAITBAR
					prop_default = true;
				case NNxMLP_FeatureImportance.INTERRUPTIBLE
					prop_default = .001;
				case NNxMLP_FeatureImportance.COMP_FEATURE_INDICES
					prop_default = Format.getFormatDefault(Format.CELL, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.BASELINE_INPUTS
					prop_default = Format.getFormatDefault(Format.CELL, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.D_SHUFFLED
					prop_default = Format.getFormatDefault(Format.ITEM, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.BASELINE_LOSS
					prop_default = Format.getFormatDefault(Format.SCALAR, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.SHUFFLED_LOSS
					prop_default = Format.getFormatDefault(Format.CELL, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.PERM_SHUFFLED_LOSS
					prop_default = Format.getFormatDefault(Format.CELL, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.CONFIDENCE_INTERVALS
					prop_default = Format.getFormatDefault(Format.RVECTOR, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.STAT_SIG_MASK
					prop_default = Format.getFormatDefault(Format.CELL, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.FEATURE_IMPORTANCE
					prop_default = Format.getFormatDefault(Format.CELL, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.RESHAPED_FEATURE_IMPORTANCE
					prop_default = Format.getFormatDefault(Format.EMPTY, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.MAP_TO_CELL
					prop_default = Format.getFormatDefault(Format.EMPTY, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.COUNT_ELEMENTS
					prop_default = Format.getFormatDefault(Format.EMPTY, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.FLATTEN_CELL
					prop_default = Format.getFormatDefault(Format.EMPTY, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.ELCLASS
					prop_default = 'NNxMLP_FeatureImportance';
				case NNxMLP_FeatureImportance.NAME
					prop_default = 'Neural Network Feature Importace for Multi-layer Perceptron';
				case NNxMLP_FeatureImportance.DESCRIPTION
					prop_default = 'A neural network feature importace for multi-layer perceptron (NNxMLP_FeatureImportance) assesses the importance of features by measuring the increase in model error when the feature values are randomly shuffled. It introduces the permutation method to establish the significance of each feature (or composite features) by comparing the original model loss to the distribution of losses obtained from several shuffled iterations, providing a robust statistical analysis of feature importance using a user-defined confidence interval and adjusting for multiple comparisons with the Bonferroni correction.';
				case NNxMLP_FeatureImportance.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.ID
					prop_default = 'NNxMLP_FeatureImportance ID';
				case NNxMLP_FeatureImportance.LABEL
					prop_default = 'NNxMLP_FeatureImportance label';
				case NNxMLP_FeatureImportance.NOTES
					prop_default = 'NNxMLP_FeatureImportance notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportance.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportance.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFI.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNFI.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportance, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportance.
			%  DEFAULT = NNFI.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportance, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportance.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNFI) and Element.GETPROPDEFAULTCONDITIONED('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNxMLP_FeatureImportance.getPropProp(pointer);
			
			prop_default = NNxMLP_FeatureImportance.conditioning(prop, NNxMLP_FeatureImportance.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNFI.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNFI.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNFI.
			%  CHECK = Element.CHECKPROP(NNxMLP_FeatureImportance, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportance.
			%  CHECK = NNFI.CHECKPROP(NNxMLP_FeatureImportance, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportance.
			% 
			% NNFI.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNxMLP_FeatureImportance:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNFI.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNFI.
			%   Error id: €BRAPH2.STR€:NNxMLP_FeatureImportance:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNxMLP_FeatureImportance, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportance.
			%   Error id: €BRAPH2.STR€:NNxMLP_FeatureImportance:€BRAPH2.WRONG_INPUT€
			%  NNFI.CHECKPROP(NNxMLP_FeatureImportance, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportance.
			%   Error id: €BRAPH2.STR€:NNxMLP_FeatureImportance:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(NNFI) and Element.CHECKPROP('NNxMLP_FeatureImportance')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNxMLP_FeatureImportance.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportance.D % __NNxMLP_FeatureImportance.D__
					check = Format.checkFormat(Format.ITEM, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.NN % __NNxMLP_FeatureImportance.NN__
					check = Format.checkFormat(Format.ITEM, value, NNxMLP_FeatureImportance.getPropSettings(prop));
					if check
						check = any(strcmp(value.get('ELCLASS'), {'NNClassifierMLP', 'NNRegressorMLP'}));
					end
				case NNxMLP_FeatureImportance.P % __NNxMLP_FeatureImportance.P__
					check = Format.checkFormat(Format.SCALAR, value, NNxMLP_FeatureImportance.getPropSettings(prop));
					if check
						check = value > 0 && value == round(value);
					end
				case NNxMLP_FeatureImportance.PERM_SEEDS % __NNxMLP_FeatureImportance.PERM_SEEDS__
					check = Format.checkFormat(Format.RVECTOR, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.APPLY_BONFERRONI % __NNxMLP_FeatureImportance.APPLY_BONFERRONI__
					check = Format.checkFormat(Format.LOGICAL, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.APPLY_CONFIDENCE_INTERVALS % __NNxMLP_FeatureImportance.APPLY_CONFIDENCE_INTERVALS__
					check = Format.checkFormat(Format.LOGICAL, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.VERBOSE % __NNxMLP_FeatureImportance.VERBOSE__
					check = Format.checkFormat(Format.LOGICAL, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.SIG_LEVEL % __NNxMLP_FeatureImportance.SIG_LEVEL__
					check = Format.checkFormat(Format.SCALAR, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.WAITBAR % __NNxMLP_FeatureImportance.WAITBAR__
					check = Format.checkFormat(Format.LOGICAL, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.INTERRUPTIBLE % __NNxMLP_FeatureImportance.INTERRUPTIBLE__
					check = Format.checkFormat(Format.SCALAR, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.COMP_FEATURE_INDICES % __NNxMLP_FeatureImportance.COMP_FEATURE_INDICES__
					check = Format.checkFormat(Format.CELL, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.BASELINE_INPUTS % __NNxMLP_FeatureImportance.BASELINE_INPUTS__
					check = Format.checkFormat(Format.CELL, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.D_SHUFFLED % __NNxMLP_FeatureImportance.D_SHUFFLED__
					check = Format.checkFormat(Format.ITEM, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.BASELINE_LOSS % __NNxMLP_FeatureImportance.BASELINE_LOSS__
					check = Format.checkFormat(Format.SCALAR, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.SHUFFLED_LOSS % __NNxMLP_FeatureImportance.SHUFFLED_LOSS__
					check = Format.checkFormat(Format.CELL, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.PERM_SHUFFLED_LOSS % __NNxMLP_FeatureImportance.PERM_SHUFFLED_LOSS__
					check = Format.checkFormat(Format.CELL, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.CONFIDENCE_INTERVALS % __NNxMLP_FeatureImportance.CONFIDENCE_INTERVALS__
					check = Format.checkFormat(Format.RVECTOR, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.STAT_SIG_MASK % __NNxMLP_FeatureImportance.STAT_SIG_MASK__
					check = Format.checkFormat(Format.CELL, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.FEATURE_IMPORTANCE % __NNxMLP_FeatureImportance.FEATURE_IMPORTANCE__
					check = Format.checkFormat(Format.CELL, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.RESHAPED_FEATURE_IMPORTANCE % __NNxMLP_FeatureImportance.RESHAPED_FEATURE_IMPORTANCE__
					check = Format.checkFormat(Format.EMPTY, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.MAP_TO_CELL % __NNxMLP_FeatureImportance.MAP_TO_CELL__
					check = Format.checkFormat(Format.EMPTY, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.COUNT_ELEMENTS % __NNxMLP_FeatureImportance.COUNT_ELEMENTS__
					check = Format.checkFormat(Format.EMPTY, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.FLATTEN_CELL % __NNxMLP_FeatureImportance.FLATTEN_CELL__
					check = Format.checkFormat(Format.EMPTY, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				case NNxMLP_FeatureImportance.TEMPLATE % __NNxMLP_FeatureImportance.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNxMLP_FeatureImportance.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_FeatureImportance:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_FeatureImportance:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNxMLP_FeatureImportance.getPropTag(prop) ' (' NNxMLP_FeatureImportance.getFormatTag(NNxMLP_FeatureImportance.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nnfi, prop, varargin)
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
				case NNxMLP_FeatureImportance.PERM_SEEDS % __NNxMLP_FeatureImportance.PERM_SEEDS__
					rng_settings_ = rng(); rng(nnfi.getPropSeed(NNxMLP_FeatureImportance.PERM_SEEDS), 'twister')
					
					value = randi(intmax('uint32'), 1, nnfi.get('P'));
					
					rng(rng_settings_)
					
				case NNxMLP_FeatureImportance.COMP_FEATURE_INDICES % __NNxMLP_FeatureImportance.COMP_FEATURE_INDICES__
					rng_settings_ = rng(); rng(nnfi.getPropSeed(NNxMLP_FeatureImportance.COMP_FEATURE_INDICES), 'twister')
					
					inputs = cell2mat(nnfi.memorize('BASELINE_INPUTS'));
					num_feature = size(inputs, 2);
					value = num2cell(1:num_feature);
					
					rng(rng_settings_)
					
				case NNxMLP_FeatureImportance.BASELINE_INPUTS % __NNxMLP_FeatureImportance.BASELINE_INPUTS__
					rng_settings_ = rng(); rng(nnfi.getPropSeed(NNxMLP_FeatureImportance.BASELINE_INPUTS), 'twister')
					
					value = nnfi.get('NN').get('INPUTS', nnfi.get('D'));
					
					rng(rng_settings_)
					
				case NNxMLP_FeatureImportance.D_SHUFFLED % __NNxMLP_FeatureImportance.D_SHUFFLED__
					if isempty(varargin)
					    value = {};
					    return
					end
					comp_feature_combination = varargin{1}; % the composite indexes to be shuffled
					
					d = nnfi.get('D');
					dp_it_list = d.get('DP_DICT').get('IT_LIST');
					P = nnfi.get('P');
					
					inputs = cell2mat(nnfi.memorize('BASELINE_INPUTS'));
					shuffled_inputs = inputs;
					for i = 1:length(comp_feature_combination)
					    feature_idx = comp_feature_combination(i);
					    permuted_value = squeeze(normrnd(mean(inputs(:, feature_idx)), std(inputs(:, feature_idx)), squeeze(size(inputs(:, feature_idx)))));
					    shuffled_inputs(:, feature_idx) = permuted_value;
					end
					
					for i = 1:length(dp_it_list)
					    dp = dp_it_list{i};
					    shuffled_input = {shuffled_inputs(i, :)};
					    shuffled_dp_list{i} = NNDataPoint_Shuffled('SHUFFLED_INPUT', shuffled_input);
					end
					
					shuffled_dp_dict = IndexedDictionary(...
					        'IT_CLASS', 'NNDataPoint_Shuffled', ...
					        'IT_LIST', shuffled_dp_list ...
					        );
					
					value = NNDataset( ...
					    'DP_CLASS', 'NNDataPoint_Shuffled', ...
					    'DP_DICT', shuffled_dp_dict ...
					    );
					
				case NNxMLP_FeatureImportance.BASELINE_LOSS % __NNxMLP_FeatureImportance.BASELINE_LOSS__
					rng_settings_ = rng(); rng(nnfi.getPropSeed(NNxMLP_FeatureImportance.BASELINE_LOSS), 'twister')
					
					d = nnfi.get('D');
					nn = nnfi.get('NN');
					net = nn.get('MODEL');
					inputs = cell2mat(nnfi.memorize('BASELINE_INPUTS'));
					targets = nn.get('TARGETS', d);
					value = crossentropy(net.predict(inputs), targets);
					
					rng(rng_settings_)
					
				case NNxMLP_FeatureImportance.SHUFFLED_LOSS % __NNxMLP_FeatureImportance.SHUFFLED_LOSS__
					seed = varargin{1};
					rng(seed, 'twister')
					
					d = nnfi.get('D');
					nn = nnfi.get('NN');
					targets = nn.get('TARGETS', d);
					
					comp_feature_indices = nnfi.get('COMP_FEATURE_INDICES');
					num_comp_feature_combinations = length(comp_feature_indices);
					leap_parallel = 2^10;
					
					start = tic;
					for j = 1:leap_parallel:num_comp_feature_combinations
					    for i = j:min(j+leap_parallel, num_comp_feature_combinations)
					        comp_feature_combination = comp_feature_indices{i};
					        d_perm = nnfi.get('D_SHUFFLED', comp_feature_combination);
					        predictions = nn.get('PREDICT', d_perm);
					        scrambled_loss = crossentropy(predictions, targets);
					        shuffled_loss(i) = scrambled_loss;
					    end
					    if nnfi.get('VERBOSE')
					        disp(['** PERMUTATION FEATURE IMPORTANCE - composite features #' int2str(min(j+leap_parallel-1, num_comp_feature_combinations)) '/' int2str(num_comp_feature_combinations) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's'])
					    end
					    if nnfi.get('INTERRUPTIBLE')
					        pause(nnfi.get('INTERRUPTIBLE'))
					    end
					end
					
					value = shuffled_loss;
					
				case NNxMLP_FeatureImportance.PERM_SHUFFLED_LOSS % __NNxMLP_FeatureImportance.PERM_SHUFFLED_LOSS__
					rng_settings_ = rng(); rng(nnfi.getPropSeed(NNxMLP_FeatureImportance.PERM_SHUFFLED_LOSS), 'twister')
					
					nnfi.memorize('BASELINE_INPUTS');
					p = nnfi.get('P');
					seeds = nnfi.get('PERM_SEEDS');
					value = {};
					leap_parallel = 2^5;
					wb = braph2waitbar(nnfi.get('WAITBAR'), 0, ['Feature importance permutation ...']);
					
					delete(gcp('nocreate')); parpool('Threads');
					start = tic;
					for j = 1:leap_parallel:p
					    parfor i = j:min(j+leap_parallel, p)
					        perm_shuflled_loss{i} = nnfi.get('SHUFFLED_LOSS', seeds(i));
					    end
					    if nnfi.get('VERBOSE')
					        disp(['** PERMUTATION FEATURE IMPORTANCE - sampling #' int2str(min(j+leap_parallel-1, p)) '/' int2str(p) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's'])
					    end
					    if nnfi.get('INTERRUPTIBLE')
					        pause(nnfi.get('INTERRUPTIBLE'))
					    end
					    braph2waitbar(wb, .15 + .85 * min(j+leap_parallel-1, p) / p, ['Permutation sampling # ' num2str(min(j+leap_parallel-1, p)) ' of ' num2str(p) ' ...'])
					end
					
					braph2waitbar(wb, 'close')
					
					value = perm_shuflled_loss;
					
					rng(rng_settings_)
					
				case NNxMLP_FeatureImportance.CONFIDENCE_INTERVALS % __NNxMLP_FeatureImportance.CONFIDENCE_INTERVALS__
					data = varargin{1};
					sig_level = varargin{2};
					sampleMean = mean(data); % Mean of the data
					sampleStd = std(data); % Std of the data
					n = numel(data);  % Sample size
					z = norminv(1 - sig_level/2);  % Z-score for the desired confidence level
					marginError = z * sampleStd / sqrt(n);  % Margin of error
					value = [sampleMean - marginError, sampleMean + marginError];
					
				case NNxMLP_FeatureImportance.STAT_SIG_MASK % __NNxMLP_FeatureImportance.STAT_SIG_MASK__
					rng_settings_ = rng(); rng(nnfi.getPropSeed(NNxMLP_FeatureImportance.STAT_SIG_MASK), 'twister')
					
					perm_shuffled_loss = nnfi.memorize('PERM_SHUFFLED_LOSS');
					perm_shuffled_loss = cell2mat(perm_shuffled_loss.');
					baseline_loss = nnfi.get('BASELINE_LOSS');
					
					comp_feature_indices = nnfi.get('COMP_FEATURE_INDICES');
					num_comp_feature_combinations = length(comp_feature_indices);
					
					sig_level = nnfi.get('SIG_LEVEL');
					if nnfi.get('APPLY_BONFERRONI')
					    sig_level = sig_level / num_comp_feature_combinations;
					end
					
					for i = 1:num_comp_feature_combinations
					    perm_values = squeeze(perm_shuffled_loss(:, i));
					    confidenceInterval = nnfi.get('CONFIDENCE_INTERVALS', perm_values, sig_level);
					    if confidenceInterval(1) - baseline_loss > 1e-04
					        significant_flag = 1;
					    else
					        significant_flag = 0;
					    end
					    significant_flags(i) = significant_flag;
					end
					
					value = significant_flags;
					
					rng(rng_settings_)
					
				case NNxMLP_FeatureImportance.FEATURE_IMPORTANCE % __NNxMLP_FeatureImportance.FEATURE_IMPORTANCE__
					rng_settings_ = rng(); rng(nnfi.getPropSeed(NNxMLP_FeatureImportance.FEATURE_IMPORTANCE), 'twister')
					
					nnfi.memorize('BASELINE_INPUTS');
					baseline_loss = nnfi.memorize('BASELINE_LOSS');
					perm_shuffled_loss = nnfi.memorize('PERM_SHUFFLED_LOSS');
					perm_shuffled_loss = cell2mat(perm_shuffled_loss.');
					
					comp_feature_indices = nnfi.get('COMP_FEATURE_INDICES');
					num_comp_feature_combinations = length(comp_feature_indices);
					
					fi_value = mean(perm_shuffled_loss, 1)/baseline_loss;
					
					if nnfi.get('APPLY_CONFIDENCE_INTERVALS') 
					    statistic_significance_mask = nnfi.get('STAT_SIG_MASK');
					    fi_value(~statistic_significance_mask) = 0;
					end
					
					value = {fi_value};
					
					rng(rng_settings_)
					
				case NNxMLP_FeatureImportance.RESHAPED_FEATURE_IMPORTANCE % __NNxMLP_FeatureImportance.RESHAPED_FEATURE_IMPORTANCE__
					cell1 = nnfi.get('FEATURE_IMPORTANCE');
					cell2 = nnfi.get('D').get('DP_DICT').get('IT', 1).get('INPUT');
					if ~isequal(numel(cell1), numel(cell2)) 
					    cell1 = nnfi.get('MAP_TO_CELL', cell2mat(cell1), cell2);
					end
					
					value = cell1;
					
				case NNxMLP_FeatureImportance.MAP_TO_CELL % __NNxMLP_FeatureImportance.MAP_TO_CELL__
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
					        numElements = nnfi.get('COUNT_ELEMENTS', cellData);
					        nestedVector = vector(index:index + numElements - 1);
					        mappedCellArray{i} = nnfi.get('MAP_TO_CELL', nestedVector, cellData);
					        index = index + numElements;
					    else
					        % Assign elements from the vector to cells
					        numElements = numel(cellData);
					        mappedCellArray{i} = reshape(vector(index:index + numElements - 1), size(cellData));
					        index = index + numElements;
					    end
					end
					
					value = mappedCellArray;
					
				case NNxMLP_FeatureImportance.COUNT_ELEMENTS % __NNxMLP_FeatureImportance.COUNT_ELEMENTS__
					if isempty(varargin)
					    value = {};
					    return
					end
					cell_data = varargin{1};
					count = 0;
					for i = 1:numel(cell_data)
					    if iscell(cell_data{i})
					        count = count + nnfi.get('COUNT_ELEMENTS', cell_data{i});
					    else
					        count = count + numel(cell_data{i});
					    end
					end
					
					value = count;
					
				case NNxMLP_FeatureImportance.FLATTEN_CELL % __NNxMLP_FeatureImportance.FLATTEN_CELL__
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
						value = calculateValue@ConcreteElement(nnfi, prop, varargin{:});
					else
						value = calculateValue@Element(nnfi, prop, varargin{:});
					end
			end
			
		end
	end
end
