classdef NNClassifierMLP_Evaluator < NNEvaluator
	%NNClassifierMLP_Evaluator evaluates the performance of a multi-layer perceptron classifier with a given dataset.
	% It is a subclass of <a href="matlab:help NNEvaluator">NNEvaluator</a>.
	%
	% A neural network evaluator for multi-layer perceptron classifier (NNClassifierMLP_Evaluator) evaluates the performance of a multi-layer perceptron classifier with a given dataset.
	% NNClassifierMLP_Evaluator evaluates the performance of the trained classifier with a given dataset in terms of various classification metrics (e.g., confusion matrix, area under the receiver operating characteristic curve).
	%
	% NNClassifierMLP_Evaluator methods (constructor):
	%  NNClassifierMLP_Evaluator - constructor
	%
	% NNClassifierMLP_Evaluator methods:
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
	% NNClassifierMLP_Evaluator methods (display):
	%  tostring - string with information about the neural network evaluator for classification
	%  disp - displays information about the neural network evaluator for classification
	%  tree - displays the tree of the neural network evaluator for classification
	%
	% NNClassifierMLP_Evaluator methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network evaluator for classification are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network evaluator for classification
	%
	% NNClassifierMLP_Evaluator methods (save/load, Static):
	%  save - saves BRAPH2 neural network evaluator for classification as b2 file
	%  load - loads a BRAPH2 neural network evaluator for classification from a b2 file
	%
	% NNClassifierMLP_Evaluator method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network evaluator for classification
	%
	% NNClassifierMLP_Evaluator method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network evaluator for classification
	%
	% NNClassifierMLP_Evaluator methods (inspection, Static):
	%  getClass - returns the class of the neural network evaluator for classification
	%  getSubclasses - returns all subclasses of NNClassifierMLP_Evaluator
	%  getProps - returns the property list of the neural network evaluator for classification
	%  getPropNumber - returns the property number of the neural network evaluator for classification
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
	% NNClassifierMLP_Evaluator methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNClassifierMLP_Evaluator methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNClassifierMLP_Evaluator methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNClassifierMLP_Evaluator methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNClassifierMLP_Evaluator; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNClassifierMLP_Evaluator constants</a>.
	%
	%
	% See also NNDataPoint_CON_CLA, NNClassifierMLP.
	
	properties (Constant) % properties
		GROUND_TRUTH = NNEvaluator.getPropNumber() + 1;
		GROUND_TRUTH_TAG = 'GROUND_TRUTH';
		GROUND_TRUTH_CATEGORY = Category.QUERY;
		GROUND_TRUTH_FORMAT = Format.STRINGLIST;
		
		AUC = NNEvaluator.getPropNumber() + 2;
		AUC_TAG = 'AUC';
		AUC_CATEGORY = Category.RESULT;
		AUC_FORMAT = Format.RVECTOR;
		
		MACRO_AUC = NNEvaluator.getPropNumber() + 3;
		MACRO_AUC_TAG = 'MACRO_AUC';
		MACRO_AUC_CATEGORY = Category.RESULT;
		MACRO_AUC_FORMAT = Format.SCALAR;
		
		C_MATRIX = NNEvaluator.getPropNumber() + 4;
		C_MATRIX_TAG = 'C_MATRIX';
		C_MATRIX_CATEGORY = Category.RESULT;
		C_MATRIX_FORMAT = Format.MATRIX;
		
		P = NNEvaluator.getPropNumber() + 5;
		P_TAG = 'P';
		P_CATEGORY = Category.PARAMETER;
		P_FORMAT = Format.SCALAR;
		
		PERM_SEEDS = NNEvaluator.getPropNumber() + 6;
		PERM_SEEDS_TAG = 'PERM_SEEDS';
		PERM_SEEDS_CATEGORY = Category.RESULT;
		PERM_SEEDS_FORMAT = Format.RVECTOR;
		
		FEATURE_IMPORTANCE = NNEvaluator.getPropNumber() + 7;
		FEATURE_IMPORTANCE_TAG = 'FEATURE_IMPORTANCE';
		FEATURE_IMPORTANCE_CATEGORY = Category.RESULT;
		FEATURE_IMPORTANCE_FORMAT = Format.CELL;
	end
	methods % constructor
		function nne = NNClassifierMLP_Evaluator(varargin)
			%NNClassifierMLP_Evaluator() creates a neural network evaluator for classification.
			%
			% NNClassifierMLP_Evaluator(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNClassifierMLP_Evaluator(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			nne = nne@NNEvaluator(varargin{:});
		end
	end
	methods (Static) % inspection
		function nne_class = getClass()
			%GETCLASS returns the class of the neural network evaluator for classification.
			%
			% CLASS = NNClassifierMLP_Evaluator.GETCLASS() returns the class 'NNClassifierMLP_Evaluator'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNE.GETCLASS() returns the class of the neural network evaluator for classification NNE.
			%  CLASS = Element.GETCLASS(NNE) returns the class of 'NNE'.
			%  CLASS = Element.GETCLASS('NNClassifierMLP_Evaluator') returns 'NNClassifierMLP_Evaluator'.
			%
			% Note that the Element.GETCLASS(NNE) and Element.GETCLASS('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			
			nne_class = 'NNClassifierMLP_Evaluator';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network evaluator for classification.
			%
			% LIST = NNClassifierMLP_Evaluator.GETSUBCLASSES() returns all subclasses of 'NNClassifierMLP_Evaluator'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNE.GETSUBCLASSES() returns all subclasses of the neural network evaluator for classification NNE.
			%  LIST = Element.GETSUBCLASSES(NNE) returns all subclasses of 'NNE'.
			%  LIST = Element.GETSUBCLASSES('NNClassifierMLP_Evaluator') returns all subclasses of 'NNClassifierMLP_Evaluator'.
			%
			% Note that the Element.GETSUBCLASSES(NNE) and Element.GETSUBCLASSES('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNClassifierMLP_Evaluator', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network evaluator for classification.
			%
			% PROPS = NNClassifierMLP_Evaluator.GETPROPS() returns the property list of neural network evaluator for classification
			%  as a row vector.
			%
			% PROPS = NNClassifierMLP_Evaluator.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNE.GETPROPS([CATEGORY]) returns the property list of the neural network evaluator for classification NNE.
			%  PROPS = Element.GETPROPS(NNE[, CATEGORY]) returns the property list of 'NNE'.
			%  PROPS = Element.GETPROPS('NNClassifierMLP_Evaluator'[, CATEGORY]) returns the property list of 'NNClassifierMLP_Evaluator'.
			%
			% Note that the Element.GETPROPS(NNE) and Element.GETPROPS('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					NNEvaluator.getProps() ...
						NNClassifierMLP_Evaluator.GROUND_TRUTH ...
						NNClassifierMLP_Evaluator.AUC ...
						NNClassifierMLP_Evaluator.MACRO_AUC ...
						NNClassifierMLP_Evaluator.C_MATRIX ...
						NNClassifierMLP_Evaluator.P ...
						NNClassifierMLP_Evaluator.PERM_SEEDS ...
						NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						NNEvaluator.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						NNEvaluator.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						NNEvaluator.getProps(Category.PARAMETER) ...
						NNClassifierMLP_Evaluator.P ...
						];
				case Category.DATA
					prop_list = [ ...
						NNEvaluator.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						NNEvaluator.getProps(Category.RESULT) ...
						NNClassifierMLP_Evaluator.AUC ...
						NNClassifierMLP_Evaluator.MACRO_AUC ...
						NNClassifierMLP_Evaluator.C_MATRIX ...
						NNClassifierMLP_Evaluator.PERM_SEEDS ...
						NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE ...
						];
				case Category.QUERY
					prop_list = [ ...
						NNEvaluator.getProps(Category.QUERY) ...
						NNClassifierMLP_Evaluator.GROUND_TRUTH ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						NNEvaluator.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						NNEvaluator.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						NNEvaluator.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network evaluator for classification.
			%
			% N = NNClassifierMLP_Evaluator.GETPROPNUMBER() returns the property number of neural network evaluator for classification.
			%
			% N = NNClassifierMLP_Evaluator.GETPROPNUMBER(CATEGORY) returns the property number of neural network evaluator for classification
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNE.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network evaluator for classification NNE.
			%  N = Element.GETPROPNUMBER(NNE) returns the property number of 'NNE'.
			%  N = Element.GETPROPNUMBER('NNClassifierMLP_Evaluator') returns the property number of 'NNClassifierMLP_Evaluator'.
			%
			% Note that the Element.GETPROPNUMBER(NNE) and Element.GETPROPNUMBER('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNClassifierMLP_Evaluator.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network evaluator for classification/error.
			%
			% CHECK = NNClassifierMLP_Evaluator.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSPROP(PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNE, PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNClassifierMLP_Evaluator, PROP) checks whether PROP exists for NNClassifierMLP_Evaluator.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%  Element.EXISTSPROP(NNE, PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%  Element.EXISTSPROP(NNClassifierMLP_Evaluator, PROP) throws error if PROP does NOT exist for NNClassifierMLP_Evaluator.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNE) and Element.EXISTSPROP('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNClassifierMLP_Evaluator.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_Evaluator:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_Evaluator:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNClassifierMLP_Evaluator.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network evaluator for classification/error.
			%
			% CHECK = NNClassifierMLP_Evaluator.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSTAG(TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNE, TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNClassifierMLP_Evaluator, TAG) checks whether TAG exists for NNClassifierMLP_Evaluator.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%  Element.EXISTSTAG(NNE, TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%  Element.EXISTSTAG(NNClassifierMLP_Evaluator, TAG) throws error if TAG does NOT exist for NNClassifierMLP_Evaluator.
			%   Error id: [BRAPH2:NNClassifierMLP_Evaluator:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNE) and Element.EXISTSTAG('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnclassifiermlp_evaluator_tag_list = cellfun(@(x) NNClassifierMLP_Evaluator.getPropTag(x), num2cell(NNClassifierMLP_Evaluator.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnclassifiermlp_evaluator_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_Evaluator:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_Evaluator:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNClassifierMLP_Evaluator.'] ...
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
			%  PROPERTY = NNE.GETPROPPROP(POINTER) returns property number of POINTER of NNE.
			%  PROPERTY = Element.GETPROPPROP(NNClassifierMLP_Evaluator, POINTER) returns property number of POINTER of NNClassifierMLP_Evaluator.
			%  PROPERTY = NNE.GETPROPPROP(NNClassifierMLP_Evaluator, POINTER) returns property number of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPPROP(NNE) and Element.GETPROPPROP('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnclassifiermlp_evaluator_tag_list = cellfun(@(x) NNClassifierMLP_Evaluator.getPropTag(x), num2cell(NNClassifierMLP_Evaluator.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnclassifiermlp_evaluator_tag_list)); % tag = pointer
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
			%  TAG = NNE.GETPROPTAG(POINTER) returns tag of POINTER of NNE.
			%  TAG = Element.GETPROPTAG(NNClassifierMLP_Evaluator, POINTER) returns tag of POINTER of NNClassifierMLP_Evaluator.
			%  TAG = NNE.GETPROPTAG(NNClassifierMLP_Evaluator, POINTER) returns tag of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPTAG(NNE) and Element.GETPROPTAG('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNClassifierMLP_Evaluator.GROUND_TRUTH
						tag = NNClassifierMLP_Evaluator.GROUND_TRUTH_TAG;
					case NNClassifierMLP_Evaluator.AUC
						tag = NNClassifierMLP_Evaluator.AUC_TAG;
					case NNClassifierMLP_Evaluator.MACRO_AUC
						tag = NNClassifierMLP_Evaluator.MACRO_AUC_TAG;
					case NNClassifierMLP_Evaluator.C_MATRIX
						tag = NNClassifierMLP_Evaluator.C_MATRIX_TAG;
					case NNClassifierMLP_Evaluator.P
						tag = NNClassifierMLP_Evaluator.P_TAG;
					case NNClassifierMLP_Evaluator.PERM_SEEDS
						tag = NNClassifierMLP_Evaluator.PERM_SEEDS_TAG;
					case NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE
						tag = NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE_TAG;
					otherwise
						tag = getPropTag@NNEvaluator(prop);
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
			%  CATEGORY = NNE.GETPROPCATEGORY(POINTER) returns category of POINTER of NNE.
			%  CATEGORY = Element.GETPROPCATEGORY(NNClassifierMLP_Evaluator, POINTER) returns category of POINTER of NNClassifierMLP_Evaluator.
			%  CATEGORY = NNE.GETPROPCATEGORY(NNClassifierMLP_Evaluator, POINTER) returns category of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPCATEGORY(NNE) and Element.GETPROPCATEGORY('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_Evaluator.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_Evaluator.GROUND_TRUTH
					prop_category = NNClassifierMLP_Evaluator.GROUND_TRUTH_CATEGORY;
				case NNClassifierMLP_Evaluator.AUC
					prop_category = NNClassifierMLP_Evaluator.AUC_CATEGORY;
				case NNClassifierMLP_Evaluator.MACRO_AUC
					prop_category = NNClassifierMLP_Evaluator.MACRO_AUC_CATEGORY;
				case NNClassifierMLP_Evaluator.C_MATRIX
					prop_category = NNClassifierMLP_Evaluator.C_MATRIX_CATEGORY;
				case NNClassifierMLP_Evaluator.P
					prop_category = NNClassifierMLP_Evaluator.P_CATEGORY;
				case NNClassifierMLP_Evaluator.PERM_SEEDS
					prop_category = NNClassifierMLP_Evaluator.PERM_SEEDS_CATEGORY;
				case NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE
					prop_category = NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE_CATEGORY;
				otherwise
					prop_category = getPropCategory@NNEvaluator(prop);
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
			%  FORMAT = NNE.GETPROPFORMAT(POINTER) returns format of POINTER of NNE.
			%  FORMAT = Element.GETPROPFORMAT(NNClassifierMLP_Evaluator, POINTER) returns format of POINTER of NNClassifierMLP_Evaluator.
			%  FORMAT = NNE.GETPROPFORMAT(NNClassifierMLP_Evaluator, POINTER) returns format of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPFORMAT(NNE) and Element.GETPROPFORMAT('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_Evaluator.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_Evaluator.GROUND_TRUTH
					prop_format = NNClassifierMLP_Evaluator.GROUND_TRUTH_FORMAT;
				case NNClassifierMLP_Evaluator.AUC
					prop_format = NNClassifierMLP_Evaluator.AUC_FORMAT;
				case NNClassifierMLP_Evaluator.MACRO_AUC
					prop_format = NNClassifierMLP_Evaluator.MACRO_AUC_FORMAT;
				case NNClassifierMLP_Evaluator.C_MATRIX
					prop_format = NNClassifierMLP_Evaluator.C_MATRIX_FORMAT;
				case NNClassifierMLP_Evaluator.P
					prop_format = NNClassifierMLP_Evaluator.P_FORMAT;
				case NNClassifierMLP_Evaluator.PERM_SEEDS
					prop_format = NNClassifierMLP_Evaluator.PERM_SEEDS_FORMAT;
				case NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE
					prop_format = NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE_FORMAT;
				otherwise
					prop_format = getPropFormat@NNEvaluator(prop);
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
			%  DESCRIPTION = NNE.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNE.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNClassifierMLP_Evaluator, POINTER) returns description of POINTER of NNClassifierMLP_Evaluator.
			%  DESCRIPTION = NNE.GETPROPDESCRIPTION(NNClassifierMLP_Evaluator, POINTER) returns description of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNE) and Element.GETPROPDESCRIPTION('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_Evaluator.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_Evaluator.GROUND_TRUTH
					prop_description = 'GROUND_TRUTH (query, stringlist) returns the matrix of ground truth derived from the targets.';
				case NNClassifierMLP_Evaluator.AUC
					prop_description = 'AUC (result, rvector) provides the value of the area under the receiver operating characteristic curve.';
				case NNClassifierMLP_Evaluator.MACRO_AUC
					prop_description = 'MACRO_AUC (result, scalar) provides the metric of the average AUC value.';
				case NNClassifierMLP_Evaluator.C_MATRIX
					prop_description = 'C_MATRIX (result, matrix) provides the confusion matrix.';
				case NNClassifierMLP_Evaluator.P
					prop_description = 'P (parameter, scalar) is the permutation number.';
				case NNClassifierMLP_Evaluator.PERM_SEEDS
					prop_description = 'PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.';
				case NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE
					prop_description = 'FEATURE_IMPORTANCE (result, cell) quantifies the average significance and impact of individual input features within neural network models. Various techniques, such as permutation feature importance for MLPs and gradient-based analysis for CNNs, can be applied to quantify this aspect.';
				case NNClassifierMLP_Evaluator.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case NNClassifierMLP_Evaluator.NAME
					prop_description = 'NAME (constant, string) is the name of the neural network evaluator for the classification task.';
				case NNClassifierMLP_Evaluator.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the neural network evaluator for the classification task.';
				case NNClassifierMLP_Evaluator.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the neural network evaluator for the classification task.';
				case NNClassifierMLP_Evaluator.ID
					prop_description = 'ID (data, string) is a few-letter code for the neural network evaluator for the classification task.';
				case NNClassifierMLP_Evaluator.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the neural network evaluator for the classification task.';
				case NNClassifierMLP_Evaluator.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the neural network evaluator for the classification task.';
				case NNClassifierMLP_Evaluator.NN
					prop_description = 'NN (data, item) contains a trained neural network classifier.';
				otherwise
					prop_description = getPropDescription@NNEvaluator(prop);
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
			%  SETTINGS = NNE.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNE.
			%  SETTINGS = Element.GETPROPSETTINGS(NNClassifierMLP_Evaluator, POINTER) returns settings of POINTER of NNClassifierMLP_Evaluator.
			%  SETTINGS = NNE.GETPROPSETTINGS(NNClassifierMLP_Evaluator, POINTER) returns settings of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPSETTINGS(NNE) and Element.GETPROPSETTINGS('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_Evaluator.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_Evaluator.GROUND_TRUTH
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNClassifierMLP_Evaluator.AUC
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case NNClassifierMLP_Evaluator.MACRO_AUC
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNClassifierMLP_Evaluator.C_MATRIX
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case NNClassifierMLP_Evaluator.P
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNClassifierMLP_Evaluator.PERM_SEEDS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNClassifierMLP_Evaluator.TEMPLATE
					prop_settings = 'NNClassifierMLP_Evaluator';
				case NNClassifierMLP_Evaluator.NN
					prop_settings = 'NNClassifierMLP';
				otherwise
					prop_settings = getPropSettings@NNEvaluator(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNClassifierMLP_Evaluator.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_Evaluator.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULT(NNClassifierMLP_Evaluator, POINTER) returns the default value of POINTER of NNClassifierMLP_Evaluator.
			%  DEFAULT = NNE.GETPROPDEFAULT(NNClassifierMLP_Evaluator, POINTER) returns the default value of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPDEFAULT(NNE) and Element.GETPROPDEFAULT('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNClassifierMLP_Evaluator.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_Evaluator.GROUND_TRUTH
					prop_default = Format.getFormatDefault(Format.STRINGLIST, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case NNClassifierMLP_Evaluator.AUC
					prop_default = Format.getFormatDefault(Format.RVECTOR, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case NNClassifierMLP_Evaluator.MACRO_AUC
					prop_default = Format.getFormatDefault(Format.SCALAR, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case NNClassifierMLP_Evaluator.C_MATRIX
					prop_default = Format.getFormatDefault(Format.MATRIX, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case NNClassifierMLP_Evaluator.P
					prop_default = 1e+2;
				case NNClassifierMLP_Evaluator.PERM_SEEDS
					prop_default = Format.getFormatDefault(Format.RVECTOR, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE
					prop_default = Format.getFormatDefault(Format.CELL, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case NNClassifierMLP_Evaluator.ELCLASS
					prop_default = 'NNClassifierMLP_Evaluator';
				case NNClassifierMLP_Evaluator.NAME
					prop_default = 'NNClassifierMLP_Evaluator';
				case NNClassifierMLP_Evaluator.DESCRIPTION
					prop_default = 'A neural network evaluator for multi-layer perceptron classifier (NNClassifierMLP_Evaluator) evaluates the performance of a multi-layer perceptron classifier with a given dataset. NNClassifierMLP_Evaluator evaluates the performance of the trained classifier with a given dataset in terms of various classification metrics (e.g., confusion matrix, area under the receiver operating characteristic curve).';
				case NNClassifierMLP_Evaluator.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case NNClassifierMLP_Evaluator.ID
					prop_default = 'NNClassifierMLP_Evaluator ID';
				case NNClassifierMLP_Evaluator.LABEL
					prop_default = 'NNClassifierMLP_Evaluator label';
				case NNClassifierMLP_Evaluator.NOTES
					prop_default = 'NNClassifierMLP_Evaluator notes';
				case NNClassifierMLP_Evaluator.NN
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierMLP_Evaluator.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@NNEvaluator(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNClassifierMLP_Evaluator.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_Evaluator.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_Evaluator, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_Evaluator.
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_Evaluator, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_Evaluator.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNE) and Element.GETPROPDEFAULTCONDITIONED('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNClassifierMLP_Evaluator.getPropProp(pointer);
			
			prop_default = NNClassifierMLP_Evaluator.conditioning(prop, NNClassifierMLP_Evaluator.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNE.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNE.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNE.
			%  CHECK = Element.CHECKPROP(NNClassifierMLP_Evaluator, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_Evaluator.
			%  CHECK = NNE.CHECKPROP(NNClassifierMLP_Evaluator, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_Evaluator.
			% 
			% NNE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNClassifierMLP_Evaluator:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNE.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_Evaluator:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNClassifierMLP_Evaluator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_Evaluator.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_Evaluator:€BRAPH2.WRONG_INPUT€
			%  NNE.CHECKPROP(NNClassifierMLP_Evaluator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_Evaluator.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_Evaluator:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(NNE) and Element.CHECKPROP('NNClassifierMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNClassifierMLP_Evaluator.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_Evaluator.GROUND_TRUTH % __NNClassifierMLP_Evaluator.GROUND_TRUTH__
					check = Format.checkFormat(Format.STRINGLIST, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case NNClassifierMLP_Evaluator.AUC % __NNClassifierMLP_Evaluator.AUC__
					check = Format.checkFormat(Format.RVECTOR, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case NNClassifierMLP_Evaluator.MACRO_AUC % __NNClassifierMLP_Evaluator.MACRO_AUC__
					check = Format.checkFormat(Format.SCALAR, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case NNClassifierMLP_Evaluator.C_MATRIX % __NNClassifierMLP_Evaluator.C_MATRIX__
					check = Format.checkFormat(Format.MATRIX, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case NNClassifierMLP_Evaluator.P % __NNClassifierMLP_Evaluator.P__
					check = Format.checkFormat(Format.SCALAR, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
					if check
						check = value > 0 && value == round(value);
					end
				case NNClassifierMLP_Evaluator.PERM_SEEDS % __NNClassifierMLP_Evaluator.PERM_SEEDS__
					check = Format.checkFormat(Format.RVECTOR, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE % __NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE__
					check = Format.checkFormat(Format.CELL, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case NNClassifierMLP_Evaluator.TEMPLATE % __NNClassifierMLP_Evaluator.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				case NNClassifierMLP_Evaluator.NN % __NNClassifierMLP_Evaluator.NN__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_Evaluator.getPropSettings(prop));
				otherwise
					if prop <= NNEvaluator.getPropNumber()
						check = checkProp@NNEvaluator(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_Evaluator:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_Evaluator:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNClassifierMLP_Evaluator.getPropTag(prop) ' (' NNClassifierMLP_Evaluator.getFormatTag(NNClassifierMLP_Evaluator.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nne, prop, varargin)
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
				case NNClassifierMLP_Evaluator.GROUND_TRUTH % __NNClassifierMLP_Evaluator.GROUND_TRUTH__
					targets = nne.get('D').get('TARGETS');
					if isempty(targets)
					    value = {''};
					else
					    for i = 1:length(targets)
					        value(i, :) = targets{i};
					    end
					end
					
				case NNClassifierMLP_Evaluator.AUC % __NNClassifierMLP_Evaluator.AUC__
					rng_settings_ = rng(); rng(nne.getPropSeed(NNClassifierMLP_Evaluator.AUC), 'twister')
					
					predictions = cell2mat(nne.get('NN').get('PREDICT', nne.get('D')));
					if isempty(predictions)
					    value = [];
					else
					    class_names = nne.get('NN').get('MODEL').Layers(end).Classes;
					    ground_truth = categorical(nne.get('GROUND_TRUTH'));
					    rocNet = rocmetrics(ground_truth, predictions, class_names);
					    value = rocNet.AUC;
					end
					
					rng(rng_settings_)
					
				case NNClassifierMLP_Evaluator.MACRO_AUC % __NNClassifierMLP_Evaluator.MACRO_AUC__
					rng_settings_ = rng(); rng(nne.getPropSeed(NNClassifierMLP_Evaluator.MACRO_AUC), 'twister')
					
					auc = nne.get('AUC');
					if isempty(auc)
					    value = 0;
					else
					    value = double(mean(auc));
					end
					
					rng(rng_settings_)
					
				case NNClassifierMLP_Evaluator.C_MATRIX % __NNClassifierMLP_Evaluator.C_MATRIX__
					rng_settings_ = rng(); rng(nne.getPropSeed(NNClassifierMLP_Evaluator.C_MATRIX), 'twister')
					
					predictions = cell2mat(nne.get('NN').get('PREDICT', nne.get('D')));
					[~, maxIndices] = max(predictions, [], 2);
					predictions = logical(full(sparse(1:numel(maxIndices), maxIndices, 1, size(predictions, 1), size(predictions, 2))));
					if isempty(predictions)
					    value = [];
					else
					    classNames = nne.get('NN').get('MODEL').Layers(end).Classes;
					    for i = 1:length(predictions)
					        classified(i) = classNames(predictions(i, :));
					    end
					    ground_truth = categorical(nne.get('GROUND_TRUTH'));
					    value = confusionmat(classified, ground_truth);
					end
					
					rng(rng_settings_)
					
				case NNClassifierMLP_Evaluator.PERM_SEEDS % __NNClassifierMLP_Evaluator.PERM_SEEDS__
					rng_settings_ = rng(); rng(nne.getPropSeed(NNClassifierMLP_Evaluator.PERM_SEEDS), 'twister')
					
					value = randi(intmax('uint32'), 1, nne.get('P'));
					
					rng(rng_settings_)
					
				case NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE % __NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE__
					rng_settings_ = rng(); rng(nne.getPropSeed(NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE), 'twister')
					
					all_fi = nne.get('NN').get('FEATURE_IMPORTANCE', nne.get('D'), nne.get('P'), nne.get('PERM_SEEDS'));
					if isempty(cell2mat(all_fi))
					    value = {};
					else
					    average_fi = zeros(size(all_fi{1}));
					    for i = 1:numel(all_fi)
					        % Add the current cell contents to the averageCell
					        average_fi = average_fi + all_fi{i};
					    end
					    average_fi = average_fi / numel(all_fi);
					    value = {average_fi};
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= NNEvaluator.getPropNumber()
						value = calculateValue@NNEvaluator(nne, prop, varargin{:});
					else
						value = calculateValue@Element(nne, prop, varargin{:});
					end
			end
			
		end
	end
end
