classdef NNRegressorMLP_Evaluator < NNEvaluator
	%NNRegressorMLP_Evaluator evaluates the performance of a multi-layer perceptron regressor with a given dataset.
	% It is a subclass of <a href="matlab:help NNEvaluator">NNEvaluator</a>.
	%
	% A neural network evaluator for regressor (NNRegressorMLP_Evaluator) evaluates the performance of a multi-layer perceptron regressor with a given dataset.
	% NNRegressorMLP_Evaluator evaluates the performance of the trained regressor with a given dataset in terms of various regression metrics (e.g., coefficient of determination, mean squared error).
	%
	% NNRegressorMLP_Evaluator methods (constructor):
	%  NNRegressorMLP_Evaluator - constructor
	%
	% NNRegressorMLP_Evaluator methods:
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
	% NNRegressorMLP_Evaluator methods (display):
	%  tostring - string with information about the neural network evaluator for regressor
	%  disp - displays information about the neural network evaluator for regressor
	%  tree - displays the tree of the neural network evaluator for regressor
	%
	% NNRegressorMLP_Evaluator methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network evaluator for regressor are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network evaluator for regressor
	%
	% NNRegressorMLP_Evaluator methods (save/load, Static):
	%  save - saves BRAPH2 neural network evaluator for regressor as b2 file
	%  load - loads a BRAPH2 neural network evaluator for regressor from a b2 file
	%
	% NNRegressorMLP_Evaluator method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network evaluator for regressor
	%
	% NNRegressorMLP_Evaluator method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network evaluator for regressor
	%
	% NNRegressorMLP_Evaluator methods (inspection, Static):
	%  getClass - returns the class of the neural network evaluator for regressor
	%  getSubclasses - returns all subclasses of NNRegressorMLP_Evaluator
	%  getProps - returns the property list of the neural network evaluator for regressor
	%  getPropNumber - returns the property number of the neural network evaluator for regressor
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
	% NNRegressorMLP_Evaluator methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNRegressorMLP_Evaluator methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNRegressorMLP_Evaluator methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNRegressorMLP_Evaluator methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNRegressorMLP_Evaluator; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNRegressorMLP_Evaluator constants</a>.
	%
	%
	% See also NNDataPoint_CON_REG, NNRegressorMLP.
	
	properties (Constant) % properties
		GROUND_TRUTH = NNEvaluator.getPropNumber() + 1;
		GROUND_TRUTH_TAG = 'GROUND_TRUTH';
		GROUND_TRUTH_CATEGORY = Category.QUERY;
		GROUND_TRUTH_FORMAT = Format.MATRIX;
		
		CORR = NNEvaluator.getPropNumber() + 2;
		CORR_TAG = 'CORR';
		CORR_CATEGORY = Category.RESULT;
		CORR_FORMAT = Format.RVECTOR;
		
		DET = NNEvaluator.getPropNumber() + 3;
		DET_TAG = 'DET';
		DET_CATEGORY = Category.RESULT;
		DET_FORMAT = Format.RVECTOR;
		
		MAE = NNEvaluator.getPropNumber() + 4;
		MAE_TAG = 'MAE';
		MAE_CATEGORY = Category.RESULT;
		MAE_FORMAT = Format.RVECTOR;
		
		MSE = NNEvaluator.getPropNumber() + 5;
		MSE_TAG = 'MSE';
		MSE_CATEGORY = Category.RESULT;
		MSE_FORMAT = Format.RVECTOR;
		
		RMSE = NNEvaluator.getPropNumber() + 6;
		RMSE_TAG = 'RMSE';
		RMSE_CATEGORY = Category.RESULT;
		RMSE_FORMAT = Format.RVECTOR;
		
		P = NNEvaluator.getPropNumber() + 7;
		P_TAG = 'P';
		P_CATEGORY = Category.PARAMETER;
		P_FORMAT = Format.SCALAR;
		
		PERM_SEEDS = NNEvaluator.getPropNumber() + 8;
		PERM_SEEDS_TAG = 'PERM_SEEDS';
		PERM_SEEDS_CATEGORY = Category.RESULT;
		PERM_SEEDS_FORMAT = Format.RVECTOR;
		
		FEATURE_IMPORTANCE = NNEvaluator.getPropNumber() + 9;
		FEATURE_IMPORTANCE_TAG = 'FEATURE_IMPORTANCE';
		FEATURE_IMPORTANCE_CATEGORY = Category.RESULT;
		FEATURE_IMPORTANCE_FORMAT = Format.CELL;
		
		PFSP = NNEvaluator.getPropNumber() + 10;
		PFSP_TAG = 'PFSP';
		PFSP_CATEGORY = Category.GUI;
		PFSP_FORMAT = Format.ITEM;
	end
	methods % constructor
		function nne = NNRegressorMLP_Evaluator(varargin)
			%NNRegressorMLP_Evaluator() creates a neural network evaluator for regressor.
			%
			% NNRegressorMLP_Evaluator(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNRegressorMLP_Evaluator(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the neural network evaluator for regressor.
			%
			% CLASS = NNRegressorMLP_Evaluator.GETCLASS() returns the class 'NNRegressorMLP_Evaluator'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNE.GETCLASS() returns the class of the neural network evaluator for regressor NNE.
			%  CLASS = Element.GETCLASS(NNE) returns the class of 'NNE'.
			%  CLASS = Element.GETCLASS('NNRegressorMLP_Evaluator') returns 'NNRegressorMLP_Evaluator'.
			%
			% Note that the Element.GETCLASS(NNE) and Element.GETCLASS('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			
			nne_class = 'NNRegressorMLP_Evaluator';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network evaluator for regressor.
			%
			% LIST = NNRegressorMLP_Evaluator.GETSUBCLASSES() returns all subclasses of 'NNRegressorMLP_Evaluator'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNE.GETSUBCLASSES() returns all subclasses of the neural network evaluator for regressor NNE.
			%  LIST = Element.GETSUBCLASSES(NNE) returns all subclasses of 'NNE'.
			%  LIST = Element.GETSUBCLASSES('NNRegressorMLP_Evaluator') returns all subclasses of 'NNRegressorMLP_Evaluator'.
			%
			% Note that the Element.GETSUBCLASSES(NNE) and Element.GETSUBCLASSES('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNRegressorMLP_Evaluator', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network evaluator for regressor.
			%
			% PROPS = NNRegressorMLP_Evaluator.GETPROPS() returns the property list of neural network evaluator for regressor
			%  as a row vector.
			%
			% PROPS = NNRegressorMLP_Evaluator.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNE.GETPROPS([CATEGORY]) returns the property list of the neural network evaluator for regressor NNE.
			%  PROPS = Element.GETPROPS(NNE[, CATEGORY]) returns the property list of 'NNE'.
			%  PROPS = Element.GETPROPS('NNRegressorMLP_Evaluator'[, CATEGORY]) returns the property list of 'NNRegressorMLP_Evaluator'.
			%
			% Note that the Element.GETPROPS(NNE) and Element.GETPROPS('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					NNEvaluator.getProps() ...
						NNRegressorMLP_Evaluator.GROUND_TRUTH ...
						NNRegressorMLP_Evaluator.CORR ...
						NNRegressorMLP_Evaluator.DET ...
						NNRegressorMLP_Evaluator.MAE ...
						NNRegressorMLP_Evaluator.MSE ...
						NNRegressorMLP_Evaluator.RMSE ...
						NNRegressorMLP_Evaluator.P ...
						NNRegressorMLP_Evaluator.PERM_SEEDS ...
						NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE ...
						NNRegressorMLP_Evaluator.PFSP ...
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
						NNRegressorMLP_Evaluator.P ...
						];
				case Category.DATA
					prop_list = [ ...
						NNEvaluator.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						NNEvaluator.getProps(Category.RESULT) ...
						NNRegressorMLP_Evaluator.CORR ...
						NNRegressorMLP_Evaluator.DET ...
						NNRegressorMLP_Evaluator.MAE ...
						NNRegressorMLP_Evaluator.MSE ...
						NNRegressorMLP_Evaluator.RMSE ...
						NNRegressorMLP_Evaluator.PERM_SEEDS ...
						NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE ...
						];
				case Category.QUERY
					prop_list = [ ...
						NNEvaluator.getProps(Category.QUERY) ...
						NNRegressorMLP_Evaluator.GROUND_TRUTH ...
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
						NNRegressorMLP_Evaluator.PFSP ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network evaluator for regressor.
			%
			% N = NNRegressorMLP_Evaluator.GETPROPNUMBER() returns the property number of neural network evaluator for regressor.
			%
			% N = NNRegressorMLP_Evaluator.GETPROPNUMBER(CATEGORY) returns the property number of neural network evaluator for regressor
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNE.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network evaluator for regressor NNE.
			%  N = Element.GETPROPNUMBER(NNE) returns the property number of 'NNE'.
			%  N = Element.GETPROPNUMBER('NNRegressorMLP_Evaluator') returns the property number of 'NNRegressorMLP_Evaluator'.
			%
			% Note that the Element.GETPROPNUMBER(NNE) and Element.GETPROPNUMBER('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNRegressorMLP_Evaluator.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network evaluator for regressor/error.
			%
			% CHECK = NNRegressorMLP_Evaluator.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSPROP(PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNE, PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNRegressorMLP_Evaluator, PROP) checks whether PROP exists for NNRegressorMLP_Evaluator.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNRegressorMLP_Evaluator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNRegressorMLP_Evaluator:WrongInput]
			%  Element.EXISTSPROP(NNE, PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNRegressorMLP_Evaluator:WrongInput]
			%  Element.EXISTSPROP(NNRegressorMLP_Evaluator, PROP) throws error if PROP does NOT exist for NNRegressorMLP_Evaluator.
			%   Error id: [BRAPH2:NNRegressorMLP_Evaluator:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNE) and Element.EXISTSPROP('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNRegressorMLP_Evaluator.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNRegressorMLP_Evaluator:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNRegressorMLP_Evaluator:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNRegressorMLP_Evaluator.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network evaluator for regressor/error.
			%
			% CHECK = NNRegressorMLP_Evaluator.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSTAG(TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNE, TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNRegressorMLP_Evaluator, TAG) checks whether TAG exists for NNRegressorMLP_Evaluator.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNRegressorMLP_Evaluator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNRegressorMLP_Evaluator:WrongInput]
			%  Element.EXISTSTAG(NNE, TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNRegressorMLP_Evaluator:WrongInput]
			%  Element.EXISTSTAG(NNRegressorMLP_Evaluator, TAG) throws error if TAG does NOT exist for NNRegressorMLP_Evaluator.
			%   Error id: [BRAPH2:NNRegressorMLP_Evaluator:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNE) and Element.EXISTSTAG('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnregressormlp_evaluator_tag_list = cellfun(@(x) NNRegressorMLP_Evaluator.getPropTag(x), num2cell(NNRegressorMLP_Evaluator.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnregressormlp_evaluator_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNRegressorMLP_Evaluator:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNRegressorMLP_Evaluator:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNRegressorMLP_Evaluator.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNRegressorMLP_Evaluator, POINTER) returns property number of POINTER of NNRegressorMLP_Evaluator.
			%  PROPERTY = NNE.GETPROPPROP(NNRegressorMLP_Evaluator, POINTER) returns property number of POINTER of NNRegressorMLP_Evaluator.
			%
			% Note that the Element.GETPROPPROP(NNE) and Element.GETPROPPROP('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnregressormlp_evaluator_tag_list = cellfun(@(x) NNRegressorMLP_Evaluator.getPropTag(x), num2cell(NNRegressorMLP_Evaluator.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnregressormlp_evaluator_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(NNRegressorMLP_Evaluator, POINTER) returns tag of POINTER of NNRegressorMLP_Evaluator.
			%  TAG = NNE.GETPROPTAG(NNRegressorMLP_Evaluator, POINTER) returns tag of POINTER of NNRegressorMLP_Evaluator.
			%
			% Note that the Element.GETPROPTAG(NNE) and Element.GETPROPTAG('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNRegressorMLP_Evaluator.GROUND_TRUTH
						tag = NNRegressorMLP_Evaluator.GROUND_TRUTH_TAG;
					case NNRegressorMLP_Evaluator.CORR
						tag = NNRegressorMLP_Evaluator.CORR_TAG;
					case NNRegressorMLP_Evaluator.DET
						tag = NNRegressorMLP_Evaluator.DET_TAG;
					case NNRegressorMLP_Evaluator.MAE
						tag = NNRegressorMLP_Evaluator.MAE_TAG;
					case NNRegressorMLP_Evaluator.MSE
						tag = NNRegressorMLP_Evaluator.MSE_TAG;
					case NNRegressorMLP_Evaluator.RMSE
						tag = NNRegressorMLP_Evaluator.RMSE_TAG;
					case NNRegressorMLP_Evaluator.P
						tag = NNRegressorMLP_Evaluator.P_TAG;
					case NNRegressorMLP_Evaluator.PERM_SEEDS
						tag = NNRegressorMLP_Evaluator.PERM_SEEDS_TAG;
					case NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE
						tag = NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE_TAG;
					case NNRegressorMLP_Evaluator.PFSP
						tag = NNRegressorMLP_Evaluator.PFSP_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNRegressorMLP_Evaluator, POINTER) returns category of POINTER of NNRegressorMLP_Evaluator.
			%  CATEGORY = NNE.GETPROPCATEGORY(NNRegressorMLP_Evaluator, POINTER) returns category of POINTER of NNRegressorMLP_Evaluator.
			%
			% Note that the Element.GETPROPCATEGORY(NNE) and Element.GETPROPCATEGORY('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_Evaluator.getPropProp(pointer);
			
			switch prop
				case NNRegressorMLP_Evaluator.GROUND_TRUTH
					prop_category = NNRegressorMLP_Evaluator.GROUND_TRUTH_CATEGORY;
				case NNRegressorMLP_Evaluator.CORR
					prop_category = NNRegressorMLP_Evaluator.CORR_CATEGORY;
				case NNRegressorMLP_Evaluator.DET
					prop_category = NNRegressorMLP_Evaluator.DET_CATEGORY;
				case NNRegressorMLP_Evaluator.MAE
					prop_category = NNRegressorMLP_Evaluator.MAE_CATEGORY;
				case NNRegressorMLP_Evaluator.MSE
					prop_category = NNRegressorMLP_Evaluator.MSE_CATEGORY;
				case NNRegressorMLP_Evaluator.RMSE
					prop_category = NNRegressorMLP_Evaluator.RMSE_CATEGORY;
				case NNRegressorMLP_Evaluator.P
					prop_category = NNRegressorMLP_Evaluator.P_CATEGORY;
				case NNRegressorMLP_Evaluator.PERM_SEEDS
					prop_category = NNRegressorMLP_Evaluator.PERM_SEEDS_CATEGORY;
				case NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE
					prop_category = NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE_CATEGORY;
				case NNRegressorMLP_Evaluator.PFSP
					prop_category = NNRegressorMLP_Evaluator.PFSP_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(NNRegressorMLP_Evaluator, POINTER) returns format of POINTER of NNRegressorMLP_Evaluator.
			%  FORMAT = NNE.GETPROPFORMAT(NNRegressorMLP_Evaluator, POINTER) returns format of POINTER of NNRegressorMLP_Evaluator.
			%
			% Note that the Element.GETPROPFORMAT(NNE) and Element.GETPROPFORMAT('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_Evaluator.getPropProp(pointer);
			
			switch prop
				case NNRegressorMLP_Evaluator.GROUND_TRUTH
					prop_format = NNRegressorMLP_Evaluator.GROUND_TRUTH_FORMAT;
				case NNRegressorMLP_Evaluator.CORR
					prop_format = NNRegressorMLP_Evaluator.CORR_FORMAT;
				case NNRegressorMLP_Evaluator.DET
					prop_format = NNRegressorMLP_Evaluator.DET_FORMAT;
				case NNRegressorMLP_Evaluator.MAE
					prop_format = NNRegressorMLP_Evaluator.MAE_FORMAT;
				case NNRegressorMLP_Evaluator.MSE
					prop_format = NNRegressorMLP_Evaluator.MSE_FORMAT;
				case NNRegressorMLP_Evaluator.RMSE
					prop_format = NNRegressorMLP_Evaluator.RMSE_FORMAT;
				case NNRegressorMLP_Evaluator.P
					prop_format = NNRegressorMLP_Evaluator.P_FORMAT;
				case NNRegressorMLP_Evaluator.PERM_SEEDS
					prop_format = NNRegressorMLP_Evaluator.PERM_SEEDS_FORMAT;
				case NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE
					prop_format = NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE_FORMAT;
				case NNRegressorMLP_Evaluator.PFSP
					prop_format = NNRegressorMLP_Evaluator.PFSP_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNRegressorMLP_Evaluator, POINTER) returns description of POINTER of NNRegressorMLP_Evaluator.
			%  DESCRIPTION = NNE.GETPROPDESCRIPTION(NNRegressorMLP_Evaluator, POINTER) returns description of POINTER of NNRegressorMLP_Evaluator.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNE) and Element.GETPROPDESCRIPTION('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_Evaluator.getPropProp(pointer);
			
			switch prop
				case NNRegressorMLP_Evaluator.GROUND_TRUTH
					prop_description = 'GROUND_TRUTH (query, matrix) returns the matrix of ground truth derived from the targets.';
				case NNRegressorMLP_Evaluator.CORR
					prop_description = 'CORR (result, rvector) provides the metric of the correlation of coefficients.';
				case NNRegressorMLP_Evaluator.DET
					prop_description = 'DET (result, rvector) provides the coefficient of determination, a measure showing how well the predictions are replicated by the model.';
				case NNRegressorMLP_Evaluator.MAE
					prop_description = 'MAE (result, rvector) provides the metric of the mean absolute error.';
				case NNRegressorMLP_Evaluator.MSE
					prop_description = 'MSE (result, rvector) provides the metric of the mean squared error.';
				case NNRegressorMLP_Evaluator.RMSE
					prop_description = 'RMSE (result, rvector) provides the metric of the root mean squared error.';
				case NNRegressorMLP_Evaluator.P
					prop_description = 'P (parameter, scalar) is the permutation number.';
				case NNRegressorMLP_Evaluator.PERM_SEEDS
					prop_description = 'PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.';
				case NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE
					prop_description = 'FEATURE_IMPORTANCE (result, cell) quantifies the average significance and impact of individual input features within neural network models. Various techniques, such as permutation feature importance for MLPs and gradient-based analysis for CNNs, can be applied to quantify this aspect.';
				case NNRegressorMLP_Evaluator.PFSP
					prop_description = 'PFSP (gui, item) contains the panel figure of the scatter plot for regression model.';
				case NNRegressorMLP_Evaluator.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case NNRegressorMLP_Evaluator.NAME
					prop_description = 'NAME (constant, string) is the name of the neural network evaluator for the regression task.';
				case NNRegressorMLP_Evaluator.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the neural network evaluator for the regression task.';
				case NNRegressorMLP_Evaluator.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the neural network evaluator for the regression task.';
				case NNRegressorMLP_Evaluator.ID
					prop_description = 'ID (data, string) is a few-letter code for the neural network evaluator for the regression task.';
				case NNRegressorMLP_Evaluator.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the neural network evaluator for the regression task.';
				case NNRegressorMLP_Evaluator.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the neural network evaluator for the regression task.';
				case NNRegressorMLP_Evaluator.NN
					prop_description = 'NN (data, item) contains a trained neural network regressor.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNRegressorMLP_Evaluator, POINTER) returns settings of POINTER of NNRegressorMLP_Evaluator.
			%  SETTINGS = NNE.GETPROPSETTINGS(NNRegressorMLP_Evaluator, POINTER) returns settings of POINTER of NNRegressorMLP_Evaluator.
			%
			% Note that the Element.GETPROPSETTINGS(NNE) and Element.GETPROPSETTINGS('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_Evaluator.getPropProp(pointer);
			
			switch prop
				case NNRegressorMLP_Evaluator.GROUND_TRUTH
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case NNRegressorMLP_Evaluator.CORR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case NNRegressorMLP_Evaluator.DET
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case NNRegressorMLP_Evaluator.MAE
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case NNRegressorMLP_Evaluator.MSE
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case NNRegressorMLP_Evaluator.RMSE
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case NNRegressorMLP_Evaluator.P
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNRegressorMLP_Evaluator.PERM_SEEDS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNRegressorMLP_Evaluator.PFSP
					prop_settings = 'NNRegressorMLP_EvaluatorPF_Scatter';
				case NNRegressorMLP_Evaluator.TEMPLATE
					prop_settings = 'NNRegressorMLP_Evaluator';
				case NNRegressorMLP_Evaluator.NN
					prop_settings = 'NNRegressorMLP';
				otherwise
					prop_settings = getPropSettings@NNEvaluator(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNRegressorMLP_Evaluator.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNRegressorMLP_Evaluator.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULT(NNRegressorMLP_Evaluator, POINTER) returns the default value of POINTER of NNRegressorMLP_Evaluator.
			%  DEFAULT = NNE.GETPROPDEFAULT(NNRegressorMLP_Evaluator, POINTER) returns the default value of POINTER of NNRegressorMLP_Evaluator.
			%
			% Note that the Element.GETPROPDEFAULT(NNE) and Element.GETPROPDEFAULT('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNRegressorMLP_Evaluator.getPropProp(pointer);
			
			switch prop
				case NNRegressorMLP_Evaluator.GROUND_TRUTH
					prop_default = Format.getFormatDefault(Format.MATRIX, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case NNRegressorMLP_Evaluator.CORR
					prop_default = Format.getFormatDefault(Format.RVECTOR, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case NNRegressorMLP_Evaluator.DET
					prop_default = Format.getFormatDefault(Format.RVECTOR, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case NNRegressorMLP_Evaluator.MAE
					prop_default = Format.getFormatDefault(Format.RVECTOR, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case NNRegressorMLP_Evaluator.MSE
					prop_default = Format.getFormatDefault(Format.RVECTOR, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case NNRegressorMLP_Evaluator.RMSE
					prop_default = Format.getFormatDefault(Format.RVECTOR, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case NNRegressorMLP_Evaluator.P
					prop_default = 1e+2;
				case NNRegressorMLP_Evaluator.PERM_SEEDS
					prop_default = Format.getFormatDefault(Format.RVECTOR, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE
					prop_default = Format.getFormatDefault(Format.CELL, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case NNRegressorMLP_Evaluator.PFSP
					prop_default = Format.getFormatDefault(Format.ITEM, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case NNRegressorMLP_Evaluator.ELCLASS
					prop_default = 'NNRegressorMLP_Evaluator';
				case NNRegressorMLP_Evaluator.NAME
					prop_default = 'NNRegressorMLP_Evaluator';
				case NNRegressorMLP_Evaluator.DESCRIPTION
					prop_default = 'A neural network evaluator for regressor (NNRegressorMLP_Evaluator) evaluates the performance of a multi-layer perceptron regressor with a given dataset. NNRegressorMLP_Evaluator evaluates the performance of the trained regressor with a given dataset in terms of various regression metrics (e.g., coefficient of determination, mean squared error).';
				case NNRegressorMLP_Evaluator.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case NNRegressorMLP_Evaluator.ID
					prop_default = 'NNRegressorMLP_Evaluator ID';
				case NNRegressorMLP_Evaluator.LABEL
					prop_default = 'NNRegressorMLP_Evaluator label';
				case NNRegressorMLP_Evaluator.NOTES
					prop_default = 'NNRegressorMLP_Evaluator notes';
				case NNRegressorMLP_Evaluator.NN
					prop_default = Format.getFormatDefault(Format.ITEM, NNRegressorMLP_Evaluator.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@NNEvaluator(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNRegressorMLP_Evaluator.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNRegressorMLP_Evaluator.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNRegressorMLP_Evaluator, POINTER) returns the conditioned default value of POINTER of NNRegressorMLP_Evaluator.
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(NNRegressorMLP_Evaluator, POINTER) returns the conditioned default value of POINTER of NNRegressorMLP_Evaluator.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNE) and Element.GETPROPDEFAULTCONDITIONED('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNRegressorMLP_Evaluator.getPropProp(pointer);
			
			prop_default = NNRegressorMLP_Evaluator.conditioning(prop, NNRegressorMLP_Evaluator.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNRegressorMLP_Evaluator, PROP, VALUE) checks VALUE format for PROP of NNRegressorMLP_Evaluator.
			%  CHECK = NNE.CHECKPROP(NNRegressorMLP_Evaluator, PROP, VALUE) checks VALUE format for PROP of NNRegressorMLP_Evaluator.
			% 
			% NNE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNRegressorMLP_Evaluator:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNE.
			%   Error id: €BRAPH2.STR€:NNRegressorMLP_Evaluator:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNRegressorMLP_Evaluator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNRegressorMLP_Evaluator.
			%   Error id: €BRAPH2.STR€:NNRegressorMLP_Evaluator:€BRAPH2.WRONG_INPUT€
			%  NNE.CHECKPROP(NNRegressorMLP_Evaluator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNRegressorMLP_Evaluator.
			%   Error id: €BRAPH2.STR€:NNRegressorMLP_Evaluator:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(NNE) and Element.CHECKPROP('NNRegressorMLP_Evaluator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNRegressorMLP_Evaluator.getPropProp(pointer);
			
			switch prop
				case NNRegressorMLP_Evaluator.GROUND_TRUTH % __NNRegressorMLP_Evaluator.GROUND_TRUTH__
					check = Format.checkFormat(Format.MATRIX, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case NNRegressorMLP_Evaluator.CORR % __NNRegressorMLP_Evaluator.CORR__
					check = Format.checkFormat(Format.RVECTOR, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case NNRegressorMLP_Evaluator.DET % __NNRegressorMLP_Evaluator.DET__
					check = Format.checkFormat(Format.RVECTOR, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case NNRegressorMLP_Evaluator.MAE % __NNRegressorMLP_Evaluator.MAE__
					check = Format.checkFormat(Format.RVECTOR, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case NNRegressorMLP_Evaluator.MSE % __NNRegressorMLP_Evaluator.MSE__
					check = Format.checkFormat(Format.RVECTOR, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case NNRegressorMLP_Evaluator.RMSE % __NNRegressorMLP_Evaluator.RMSE__
					check = Format.checkFormat(Format.RVECTOR, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case NNRegressorMLP_Evaluator.P % __NNRegressorMLP_Evaluator.P__
					check = Format.checkFormat(Format.SCALAR, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
					if check
						check = value > 0 && value == round(value);
					end
				case NNRegressorMLP_Evaluator.PERM_SEEDS % __NNRegressorMLP_Evaluator.PERM_SEEDS__
					check = Format.checkFormat(Format.RVECTOR, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE % __NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE__
					check = Format.checkFormat(Format.CELL, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case NNRegressorMLP_Evaluator.PFSP % __NNRegressorMLP_Evaluator.PFSP__
					check = Format.checkFormat(Format.ITEM, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case NNRegressorMLP_Evaluator.TEMPLATE % __NNRegressorMLP_Evaluator.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
				case NNRegressorMLP_Evaluator.NN % __NNRegressorMLP_Evaluator.NN__
					check = Format.checkFormat(Format.ITEM, value, NNRegressorMLP_Evaluator.getPropSettings(prop));
				otherwise
					if prop <= NNEvaluator.getPropNumber()
						check = checkProp@NNEvaluator(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNRegressorMLP_Evaluator:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNRegressorMLP_Evaluator:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNRegressorMLP_Evaluator.getPropTag(prop) ' (' NNRegressorMLP_Evaluator.getFormatTag(NNRegressorMLP_Evaluator.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(nne, prop)
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
				case NNRegressorMLP_Evaluator.PFSP % __NNRegressorMLP_Evaluator.PFSP__
					if isa(nne.getr('PFSP'), 'NoValue')
					    nne.set('PFSP', NNRegressorMLP_EvaluatorPF_Scatter('NNE', nne));
					end
					
				otherwise
					if prop <= NNEvaluator.getPropNumber()
						postprocessing@NNEvaluator(nne, prop);
					end
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
				case NNRegressorMLP_Evaluator.GROUND_TRUTH % __NNRegressorMLP_Evaluator.GROUND_TRUTH__
					targets = nne.get('D').get('TARGETS');
					if isempty(targets)
					    value = [];
					else
					    for i = 1:length(targets)
					        value(i, :) = cell2mat(targets{i});
					    end
					end
					
				case NNRegressorMLP_Evaluator.CORR % __NNRegressorMLP_Evaluator.CORR__
					rng_settings_ = rng(); rng(nne.getPropSeed(NNRegressorMLP_Evaluator.CORR), 'twister')
					
					predictions = nne.get('NN').get('PREDICT', nne.get('D'));
					if isempty(predictions)
					    value = [];
					else
					    predictions = cell2mat(predictions);
					    ground_truth = nne.get('GROUND_TRUTH');
					    num_dp = size(ground_truth, 1);
					    num_target = size(ground_truth, 2);
					    for i = 1:num_target
					        corr_matrix = corrcoef(predictions(:, i), ground_truth(:, i));
					        value(i) = corr_matrix(1, 2);
					    end
					end
					
					rng(rng_settings_)
					
				case NNRegressorMLP_Evaluator.DET % __NNRegressorMLP_Evaluator.DET__
					rng_settings_ = rng(); rng(nne.getPropSeed(NNRegressorMLP_Evaluator.DET), 'twister')
					
					predictions = nne.get('NN').get('PREDICT', nne.get('D'));
					if isempty(predictions)
					    value = [];
					else
					    predictions = cell2mat(predictions);
					    ground_truth = nne.get('GROUND_TRUTH');
					    num_dp = size(ground_truth, 1);
					    num_target = size(ground_truth, 2);
					    for i = 1:num_target
					        corr_matrix = corrcoef(predictions(:, i), ground_truth(:, i));
					        value(i) = corr_matrix(1, 2)^2;
					    end
					end
					
					rng(rng_settings_)
					
				case NNRegressorMLP_Evaluator.MAE % __NNRegressorMLP_Evaluator.MAE__
					rng_settings_ = rng(); rng(nne.getPropSeed(NNRegressorMLP_Evaluator.MAE), 'twister')
					
					predictions = nne.get('NN').get('PREDICT', nne.get('D'));
					if isempty(predictions)
					    value = [];
					else
					    predictions = cell2mat(predictions);
					    ground_truth = nne.get('GROUND_TRUTH');
					    num_dp = size(ground_truth, 1);
					    num_target = size(ground_truth, 2);
					    for i = 1:num_target
					        value(i) = mean(abs(predictions(:, i) - ground_truth(:, i)));
					    end
					end
					
					rng(rng_settings_)
					
				case NNRegressorMLP_Evaluator.MSE % __NNRegressorMLP_Evaluator.MSE__
					rng_settings_ = rng(); rng(nne.getPropSeed(NNRegressorMLP_Evaluator.MSE), 'twister')
					
					predictions = nne.get('NN').get('PREDICT', nne.get('D'));
					if isempty(predictions)
					    value = [];
					else
					    predictions = cell2mat(predictions);
					    ground_truth = nne.get('GROUND_TRUTH');
					    num_dp = size(ground_truth, 1);
					    num_target = size(ground_truth, 2);
					    for i = 1:num_target
					        value(i) = mean((predictions(:, i) - ground_truth(:, i)).^2);
					    end
					end
					
					rng(rng_settings_)
					
				case NNRegressorMLP_Evaluator.RMSE % __NNRegressorMLP_Evaluator.RMSE__
					rng_settings_ = rng(); rng(nne.getPropSeed(NNRegressorMLP_Evaluator.RMSE), 'twister')
					
					predictions = nne.get('NN').get('PREDICT', nne.get('D'));
					if isempty(predictions)
					    value = [];
					else
					    predictions = cell2mat(predictions);
					    ground_truth = nne.get('GROUND_TRUTH');
					    num_dp = size(ground_truth, 1);
					    num_target = size(ground_truth, 2);
					    for i = 1:num_target
					        value(i) = sqrt(mean((predictions(:, i) - ground_truth(:, i)).^2));
					    end
					end
					
					rng(rng_settings_)
					
				case NNRegressorMLP_Evaluator.PERM_SEEDS % __NNRegressorMLP_Evaluator.PERM_SEEDS__
					rng_settings_ = rng(); rng(nne.getPropSeed(NNRegressorMLP_Evaluator.PERM_SEEDS), 'twister')
					
					value = randi(intmax('uint32'), 1, nne.get('P'));
					
					rng(rng_settings_)
					
				case NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE % __NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE__
					rng_settings_ = rng(); rng(nne.getPropSeed(NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE), 'twister')
					
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
	methods % GUI
		function pr = getPanelProp(nne, prop, varargin)
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
				case NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE % __NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE__
					input_dataset = nne.get('D');
					dp_class = input_dataset.get('DP_CLASS');
					graph_dp_classes = {NNDataPoint_Graph_CLA().get('NAME'), NNDataPoint_Graph_REG().get('NAME')};
					measure_dp_classes = {NNDataPoint_Measure_CLA().get('NAME'), NNDataPoint_Measure_REG().get('NAME')};
					
					if any(strcmp(dp_class, graph_dp_classes)) % GRAPH input
					    pr = NNxMLP_xPP_FI_Graph('EL', nne, 'D', input_dataset, 'PROP', NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE, varargin{:});
					elseif any(strcmp(dp_class, measure_dp_classes))% MEASURE input
					    pr = NNxMLP_xPP_FI_Measure('EL', nne, 'D', input_dataset, 'PROP', NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE, varargin{:});
					else % DATA input
					    pr = NNxMLP_xPP_FI_Data('EL', nne, 'D', input_dataset, 'PROP', NNRegressorMLP_Evaluator.FEATURE_IMPORTANCE, varargin{:});
					end
					
				case NNRegressorMLP_Evaluator.PFSP % __NNRegressorMLP_Evaluator.PFSP__
					pr = PanelPropItem('EL', nne, 'PROP', NNRegressorMLP_Evaluator.PFSP, ...
					    'GUICLASS', 'GUIFig', ...
						'BUTTON_TEXT', ['Scatter Plot'], ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@NNEvaluator(nne, prop, varargin{:});
					
			end
		end
	end
end
