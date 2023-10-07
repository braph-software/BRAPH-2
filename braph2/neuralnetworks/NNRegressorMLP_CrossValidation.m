classdef NNRegressorMLP_CrossValidation < NNCrossValidation
	%NNRegressorMLP_CrossValidation is a process for evaluating multi-layer perceptron regressors using cross-validation.
	% It is a subclass of <a href="matlab:help NNCrossValidation">NNCrossValidation</a>.
	%
	% A cross validation for multi-layer perceptron regressors (NNRegressorMLP_CrossValidation) is a process that facilitates the evaluation of multi-layer perceptron regressors using cross-validation. 
	%  It involves splitting a dataset into multiple subsets (folds), training the model on some folds while validating on others, and then repeating the process for all combinations of folds. 
	%  This helps in assessing the generalization performance of the model and detecting overfitting.
	% 
	% To train all the neural networks for all folds, use: nncv.get('TRAIN')
	%
	% NNRegressorMLP_CrossValidation methods (constructor):
	%  NNRegressorMLP_CrossValidation - constructor
	%
	% NNRegressorMLP_CrossValidation methods:
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
	% NNRegressorMLP_CrossValidation methods (display):
	%  tostring - string with information about the neural network cross-validation
	%  disp - displays information about the neural network cross-validation
	%  tree - displays the tree of the neural network cross-validation
	%
	% NNRegressorMLP_CrossValidation methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network cross-validation are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network cross-validation
	%
	% NNRegressorMLP_CrossValidation methods (save/load, Static):
	%  save - saves BRAPH2 neural network cross-validation as b2 file
	%  load - loads a BRAPH2 neural network cross-validation from a b2 file
	%
	% NNRegressorMLP_CrossValidation method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network cross-validation
	%
	% NNRegressorMLP_CrossValidation method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network cross-validation
	%
	% NNRegressorMLP_CrossValidation methods (inspection, Static):
	%  getClass - returns the class of the neural network cross-validation
	%  getSubclasses - returns all subclasses of NNRegressorMLP_CrossValidation
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
	% NNRegressorMLP_CrossValidation methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNRegressorMLP_CrossValidation methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNRegressorMLP_CrossValidation methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNRegressorMLP_CrossValidation methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNRegressorMLP_CrossValidation; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNRegressorMLP_CrossValidation constants</a>.
	%
	%
	% See also NNDataPoint, NNDataset, NNEvaluator.
	
	properties (Constant) % properties
		P = NNCrossValidation.getPropNumber() + 1;
		P_TAG = 'P';
		P_CATEGORY = Category.PARAMETER;
		P_FORMAT = Format.SCALAR;
		
		AV_CORR = NNCrossValidation.getPropNumber() + 2;
		AV_CORR_TAG = 'AV_CORR';
		AV_CORR_CATEGORY = Category.RESULT;
		AV_CORR_FORMAT = Format.RVECTOR;
		
		AV_DET = NNCrossValidation.getPropNumber() + 3;
		AV_DET_TAG = 'AV_DET';
		AV_DET_CATEGORY = Category.RESULT;
		AV_DET_FORMAT = Format.RVECTOR;
		
		AV_MAE = NNCrossValidation.getPropNumber() + 4;
		AV_MAE_TAG = 'AV_MAE';
		AV_MAE_CATEGORY = Category.RESULT;
		AV_MAE_FORMAT = Format.RVECTOR;
		
		AV_MSE = NNCrossValidation.getPropNumber() + 5;
		AV_MSE_TAG = 'AV_MSE';
		AV_MSE_CATEGORY = Category.RESULT;
		AV_MSE_FORMAT = Format.RVECTOR;
		
		AV_RMSE = NNCrossValidation.getPropNumber() + 6;
		AV_RMSE_TAG = 'AV_RMSE';
		AV_RMSE_CATEGORY = Category.RESULT;
		AV_RMSE_FORMAT = Format.RVECTOR;
		
		AV_FEATURE_IMPORTANCE = NNCrossValidation.getPropNumber() + 7;
		AV_FEATURE_IMPORTANCE_TAG = 'AV_FEATURE_IMPORTANCE';
		AV_FEATURE_IMPORTANCE_CATEGORY = Category.RESULT;
		AV_FEATURE_IMPORTANCE_FORMAT = Format.CELL;
		
		PFSP = NNCrossValidation.getPropNumber() + 8;
		PFSP_TAG = 'PFSP';
		PFSP_CATEGORY = Category.GUI;
		PFSP_FORMAT = Format.ITEM;
	end
	methods % constructor
		function nncv = NNRegressorMLP_CrossValidation(varargin)
			%NNRegressorMLP_CrossValidation() creates a neural network cross-validation.
			%
			% NNRegressorMLP_CrossValidation(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNRegressorMLP_CrossValidation(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			nncv = nncv@NNCrossValidation(varargin{:});
		end
	end
	methods (Static) % inspection
		function nncv_class = getClass()
			%GETCLASS returns the class of the neural network cross-validation.
			%
			% CLASS = NNRegressorMLP_CrossValidation.GETCLASS() returns the class 'NNRegressorMLP_CrossValidation'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNCV.GETCLASS() returns the class of the neural network cross-validation NNCV.
			%  CLASS = Element.GETCLASS(NNCV) returns the class of 'NNCV'.
			%  CLASS = Element.GETCLASS('NNRegressorMLP_CrossValidation') returns 'NNRegressorMLP_CrossValidation'.
			%
			% Note that the Element.GETCLASS(NNCV) and Element.GETCLASS('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			
			nncv_class = 'NNRegressorMLP_CrossValidation';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network cross-validation.
			%
			% LIST = NNRegressorMLP_CrossValidation.GETSUBCLASSES() returns all subclasses of 'NNRegressorMLP_CrossValidation'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNCV.GETSUBCLASSES() returns all subclasses of the neural network cross-validation NNCV.
			%  LIST = Element.GETSUBCLASSES(NNCV) returns all subclasses of 'NNCV'.
			%  LIST = Element.GETSUBCLASSES('NNRegressorMLP_CrossValidation') returns all subclasses of 'NNRegressorMLP_CrossValidation'.
			%
			% Note that the Element.GETSUBCLASSES(NNCV) and Element.GETSUBCLASSES('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNRegressorMLP_CrossValidation', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network cross-validation.
			%
			% PROPS = NNRegressorMLP_CrossValidation.GETPROPS() returns the property list of neural network cross-validation
			%  as a row vector.
			%
			% PROPS = NNRegressorMLP_CrossValidation.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNCV.GETPROPS([CATEGORY]) returns the property list of the neural network cross-validation NNCV.
			%  PROPS = Element.GETPROPS(NNCV[, CATEGORY]) returns the property list of 'NNCV'.
			%  PROPS = Element.GETPROPS('NNRegressorMLP_CrossValidation'[, CATEGORY]) returns the property list of 'NNRegressorMLP_CrossValidation'.
			%
			% Note that the Element.GETPROPS(NNCV) and Element.GETPROPS('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					NNCrossValidation.getProps() ...
						NNRegressorMLP_CrossValidation.P ...
						NNRegressorMLP_CrossValidation.AV_CORR ...
						NNRegressorMLP_CrossValidation.AV_DET ...
						NNRegressorMLP_CrossValidation.AV_MAE ...
						NNRegressorMLP_CrossValidation.AV_MSE ...
						NNRegressorMLP_CrossValidation.AV_RMSE ...
						NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE ...
						NNRegressorMLP_CrossValidation.PFSP ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						NNCrossValidation.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						NNCrossValidation.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						NNCrossValidation.getProps(Category.PARAMETER) ...
						NNRegressorMLP_CrossValidation.P ...
						];
				case Category.DATA
					prop_list = [ ...
						NNCrossValidation.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						NNCrossValidation.getProps(Category.RESULT) ...
						NNRegressorMLP_CrossValidation.AV_CORR ...
						NNRegressorMLP_CrossValidation.AV_DET ...
						NNRegressorMLP_CrossValidation.AV_MAE ...
						NNRegressorMLP_CrossValidation.AV_MSE ...
						NNRegressorMLP_CrossValidation.AV_RMSE ...
						NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE ...
						];
				case Category.QUERY
					prop_list = [ ...
						NNCrossValidation.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						NNCrossValidation.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						NNCrossValidation.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						NNCrossValidation.getProps(Category.GUI) ...
						NNRegressorMLP_CrossValidation.PFSP ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network cross-validation.
			%
			% N = NNRegressorMLP_CrossValidation.GETPROPNUMBER() returns the property number of neural network cross-validation.
			%
			% N = NNRegressorMLP_CrossValidation.GETPROPNUMBER(CATEGORY) returns the property number of neural network cross-validation
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNCV.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network cross-validation NNCV.
			%  N = Element.GETPROPNUMBER(NNCV) returns the property number of 'NNCV'.
			%  N = Element.GETPROPNUMBER('NNRegressorMLP_CrossValidation') returns the property number of 'NNRegressorMLP_CrossValidation'.
			%
			% Note that the Element.GETPROPNUMBER(NNCV) and Element.GETPROPNUMBER('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNRegressorMLP_CrossValidation.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network cross-validation/error.
			%
			% CHECK = NNRegressorMLP_CrossValidation.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNCV.EXISTSPROP(PROP) checks whether PROP exists for NNCV.
			%  CHECK = Element.EXISTSPROP(NNCV, PROP) checks whether PROP exists for NNCV.
			%  CHECK = Element.EXISTSPROP(NNRegressorMLP_CrossValidation, PROP) checks whether PROP exists for NNRegressorMLP_CrossValidation.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNRegressorMLP_CrossValidation:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNCV.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNRegressorMLP_CrossValidation:WrongInput]
			%  Element.EXISTSPROP(NNCV, PROP) throws error if PROP does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNRegressorMLP_CrossValidation:WrongInput]
			%  Element.EXISTSPROP(NNRegressorMLP_CrossValidation, PROP) throws error if PROP does NOT exist for NNRegressorMLP_CrossValidation.
			%   Error id: [BRAPH2:NNRegressorMLP_CrossValidation:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNCV) and Element.EXISTSPROP('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNRegressorMLP_CrossValidation.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNRegressorMLP_CrossValidation:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNRegressorMLP_CrossValidation:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNRegressorMLP_CrossValidation.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network cross-validation/error.
			%
			% CHECK = NNRegressorMLP_CrossValidation.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNCV.EXISTSTAG(TAG) checks whether TAG exists for NNCV.
			%  CHECK = Element.EXISTSTAG(NNCV, TAG) checks whether TAG exists for NNCV.
			%  CHECK = Element.EXISTSTAG(NNRegressorMLP_CrossValidation, TAG) checks whether TAG exists for NNRegressorMLP_CrossValidation.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNRegressorMLP_CrossValidation:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNCV.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNRegressorMLP_CrossValidation:WrongInput]
			%  Element.EXISTSTAG(NNCV, TAG) throws error if TAG does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNRegressorMLP_CrossValidation:WrongInput]
			%  Element.EXISTSTAG(NNRegressorMLP_CrossValidation, TAG) throws error if TAG does NOT exist for NNRegressorMLP_CrossValidation.
			%   Error id: [BRAPH2:NNRegressorMLP_CrossValidation:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNCV) and Element.EXISTSTAG('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnregressormlp_crossvalidation_tag_list = cellfun(@(x) NNRegressorMLP_CrossValidation.getPropTag(x), num2cell(NNRegressorMLP_CrossValidation.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnregressormlp_crossvalidation_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNRegressorMLP_CrossValidation:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNRegressorMLP_CrossValidation:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNRegressorMLP_CrossValidation.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNRegressorMLP_CrossValidation, POINTER) returns property number of POINTER of NNRegressorMLP_CrossValidation.
			%  PROPERTY = NNCV.GETPROPPROP(NNRegressorMLP_CrossValidation, POINTER) returns property number of POINTER of NNRegressorMLP_CrossValidation.
			%
			% Note that the Element.GETPROPPROP(NNCV) and Element.GETPROPPROP('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnregressormlp_crossvalidation_tag_list = cellfun(@(x) NNRegressorMLP_CrossValidation.getPropTag(x), num2cell(NNRegressorMLP_CrossValidation.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnregressormlp_crossvalidation_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(NNRegressorMLP_CrossValidation, POINTER) returns tag of POINTER of NNRegressorMLP_CrossValidation.
			%  TAG = NNCV.GETPROPTAG(NNRegressorMLP_CrossValidation, POINTER) returns tag of POINTER of NNRegressorMLP_CrossValidation.
			%
			% Note that the Element.GETPROPTAG(NNCV) and Element.GETPROPTAG('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNRegressorMLP_CrossValidation.P
						tag = NNRegressorMLP_CrossValidation.P_TAG;
					case NNRegressorMLP_CrossValidation.AV_CORR
						tag = NNRegressorMLP_CrossValidation.AV_CORR_TAG;
					case NNRegressorMLP_CrossValidation.AV_DET
						tag = NNRegressorMLP_CrossValidation.AV_DET_TAG;
					case NNRegressorMLP_CrossValidation.AV_MAE
						tag = NNRegressorMLP_CrossValidation.AV_MAE_TAG;
					case NNRegressorMLP_CrossValidation.AV_MSE
						tag = NNRegressorMLP_CrossValidation.AV_MSE_TAG;
					case NNRegressorMLP_CrossValidation.AV_RMSE
						tag = NNRegressorMLP_CrossValidation.AV_RMSE_TAG;
					case NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE
						tag = NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE_TAG;
					case NNRegressorMLP_CrossValidation.PFSP
						tag = NNRegressorMLP_CrossValidation.PFSP_TAG;
					otherwise
						tag = getPropTag@NNCrossValidation(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNRegressorMLP_CrossValidation, POINTER) returns category of POINTER of NNRegressorMLP_CrossValidation.
			%  CATEGORY = NNCV.GETPROPCATEGORY(NNRegressorMLP_CrossValidation, POINTER) returns category of POINTER of NNRegressorMLP_CrossValidation.
			%
			% Note that the Element.GETPROPCATEGORY(NNCV) and Element.GETPROPCATEGORY('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_CrossValidation.getPropProp(pointer);
			
			switch prop
				case NNRegressorMLP_CrossValidation.P
					prop_category = NNRegressorMLP_CrossValidation.P_CATEGORY;
				case NNRegressorMLP_CrossValidation.AV_CORR
					prop_category = NNRegressorMLP_CrossValidation.AV_CORR_CATEGORY;
				case NNRegressorMLP_CrossValidation.AV_DET
					prop_category = NNRegressorMLP_CrossValidation.AV_DET_CATEGORY;
				case NNRegressorMLP_CrossValidation.AV_MAE
					prop_category = NNRegressorMLP_CrossValidation.AV_MAE_CATEGORY;
				case NNRegressorMLP_CrossValidation.AV_MSE
					prop_category = NNRegressorMLP_CrossValidation.AV_MSE_CATEGORY;
				case NNRegressorMLP_CrossValidation.AV_RMSE
					prop_category = NNRegressorMLP_CrossValidation.AV_RMSE_CATEGORY;
				case NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE
					prop_category = NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE_CATEGORY;
				case NNRegressorMLP_CrossValidation.PFSP
					prop_category = NNRegressorMLP_CrossValidation.PFSP_CATEGORY;
				otherwise
					prop_category = getPropCategory@NNCrossValidation(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(NNRegressorMLP_CrossValidation, POINTER) returns format of POINTER of NNRegressorMLP_CrossValidation.
			%  FORMAT = NNCV.GETPROPFORMAT(NNRegressorMLP_CrossValidation, POINTER) returns format of POINTER of NNRegressorMLP_CrossValidation.
			%
			% Note that the Element.GETPROPFORMAT(NNCV) and Element.GETPROPFORMAT('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_CrossValidation.getPropProp(pointer);
			
			switch prop
				case NNRegressorMLP_CrossValidation.P
					prop_format = NNRegressorMLP_CrossValidation.P_FORMAT;
				case NNRegressorMLP_CrossValidation.AV_CORR
					prop_format = NNRegressorMLP_CrossValidation.AV_CORR_FORMAT;
				case NNRegressorMLP_CrossValidation.AV_DET
					prop_format = NNRegressorMLP_CrossValidation.AV_DET_FORMAT;
				case NNRegressorMLP_CrossValidation.AV_MAE
					prop_format = NNRegressorMLP_CrossValidation.AV_MAE_FORMAT;
				case NNRegressorMLP_CrossValidation.AV_MSE
					prop_format = NNRegressorMLP_CrossValidation.AV_MSE_FORMAT;
				case NNRegressorMLP_CrossValidation.AV_RMSE
					prop_format = NNRegressorMLP_CrossValidation.AV_RMSE_FORMAT;
				case NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE
					prop_format = NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE_FORMAT;
				case NNRegressorMLP_CrossValidation.PFSP
					prop_format = NNRegressorMLP_CrossValidation.PFSP_FORMAT;
				otherwise
					prop_format = getPropFormat@NNCrossValidation(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNRegressorMLP_CrossValidation, POINTER) returns description of POINTER of NNRegressorMLP_CrossValidation.
			%  DESCRIPTION = NNCV.GETPROPDESCRIPTION(NNRegressorMLP_CrossValidation, POINTER) returns description of POINTER of NNRegressorMLP_CrossValidation.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNCV) and Element.GETPROPDESCRIPTION('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_CrossValidation.getPropProp(pointer);
			
			switch prop
				case NNRegressorMLP_CrossValidation.P
					prop_description = 'P (parameter, scalar) is the permutation number.';
				case NNRegressorMLP_CrossValidation.AV_CORR
					prop_description = 'AV_CORR (result, rvector) provides the metric of the correlation of coefficients.';
				case NNRegressorMLP_CrossValidation.AV_DET
					prop_description = 'AV_DET (result, rvector) provides the coefficient of determination, a measure showing how well the predictions are replicated by the model.';
				case NNRegressorMLP_CrossValidation.AV_MAE
					prop_description = 'AV_MAE (result, rvector) provides the metric of the mean absolute error.';
				case NNRegressorMLP_CrossValidation.AV_MSE
					prop_description = 'AV_MSE (result, rvector) provides the metric of the mean squared error.';
				case NNRegressorMLP_CrossValidation.AV_RMSE
					prop_description = 'AV_RMSE (result, rvector) provides the metric of the root mean squared error.';
				case NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE
					prop_description = 'AV_FEATURE_IMPORTANCE (result, cell) averages the feature importances across k folds.';
				case NNRegressorMLP_CrossValidation.PFSP
					prop_description = 'PFSP (gui, item) contains the panel figure of the scatter plot for regression model.';
				case NNRegressorMLP_CrossValidation.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case NNRegressorMLP_CrossValidation.NAME
					prop_description = 'NAME (constant, string) is the name of the cross-validation.';
				case NNRegressorMLP_CrossValidation.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the cross-validation.';
				case NNRegressorMLP_CrossValidation.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the nerual cross-validation.';
				case NNRegressorMLP_CrossValidation.ID
					prop_description = 'ID (data, string) is a few-letter code for the cross-validation.';
				case NNRegressorMLP_CrossValidation.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the cross-validation.';
				case NNRegressorMLP_CrossValidation.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the cross-validation.';
				case NNRegressorMLP_CrossValidation.NN_TEMPLATE
					prop_description = 'NN_TEMPLATE (parameter, item) is the neural network template to set all neural network parameters.';
				case NNRegressorMLP_CrossValidation.NNEVALUATOR_TEMPLATE
					prop_description = 'NNEVALUATOR_TEMPLATE (parameter, item) is the neural network evaluator template to set all evalutor parameters.';
				case NNRegressorMLP_CrossValidation.NN_LIST
					prop_description = 'NN_LIST (result, itemlist) contains the neural network models corresponding to k folds.';
				case NNRegressorMLP_CrossValidation.EVALUATOR_LIST
					prop_description = 'EVALUATOR_LIST (result, itemlist) contains the evaluators corresponding to k folds.';
				case NNRegressorMLP_CrossValidation.EVALUATOR_LIST
					prop_description = 'EVALUATOR_LIST (result, itemlist) contains the evaluators corresponding to k folds.';
				otherwise
					prop_description = getPropDescription@NNCrossValidation(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNRegressorMLP_CrossValidation, POINTER) returns settings of POINTER of NNRegressorMLP_CrossValidation.
			%  SETTINGS = NNCV.GETPROPSETTINGS(NNRegressorMLP_CrossValidation, POINTER) returns settings of POINTER of NNRegressorMLP_CrossValidation.
			%
			% Note that the Element.GETPROPSETTINGS(NNCV) and Element.GETPROPSETTINGS('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNRegressorMLP_CrossValidation.getPropProp(pointer);
			
			switch prop
				case NNRegressorMLP_CrossValidation.P
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNRegressorMLP_CrossValidation.AV_CORR
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case NNRegressorMLP_CrossValidation.AV_DET
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case NNRegressorMLP_CrossValidation.AV_MAE
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case NNRegressorMLP_CrossValidation.AV_MSE
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case NNRegressorMLP_CrossValidation.AV_RMSE
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNRegressorMLP_CrossValidation.PFSP
					prop_settings = 'NNRegressorMLP_CrossValidationPF_Scatter';
				case NNRegressorMLP_CrossValidation.TEMPLATE
					prop_settings = 'NNRegressorMLP_CrossValidation';
				case NNRegressorMLP_CrossValidation.NN_TEMPLATE
					prop_settings = 'NNRegressorMLP';
				case NNRegressorMLP_CrossValidation.NNEVALUATOR_TEMPLATE
					prop_settings = 'NNRegressorMLP_Evaluator';
				otherwise
					prop_settings = getPropSettings@NNCrossValidation(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNRegressorMLP_CrossValidation.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNRegressorMLP_CrossValidation.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNCV.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNCV.
			%  DEFAULT = Element.GETPROPDEFAULT(NNRegressorMLP_CrossValidation, POINTER) returns the default value of POINTER of NNRegressorMLP_CrossValidation.
			%  DEFAULT = NNCV.GETPROPDEFAULT(NNRegressorMLP_CrossValidation, POINTER) returns the default value of POINTER of NNRegressorMLP_CrossValidation.
			%
			% Note that the Element.GETPROPDEFAULT(NNCV) and Element.GETPROPDEFAULT('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNRegressorMLP_CrossValidation.getPropProp(pointer);
			
			switch prop
				case NNRegressorMLP_CrossValidation.P
					prop_default = 1e+2;
				case NNRegressorMLP_CrossValidation.AV_CORR
					prop_default = Format.getFormatDefault(Format.RVECTOR, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case NNRegressorMLP_CrossValidation.AV_DET
					prop_default = Format.getFormatDefault(Format.RVECTOR, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case NNRegressorMLP_CrossValidation.AV_MAE
					prop_default = Format.getFormatDefault(Format.RVECTOR, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case NNRegressorMLP_CrossValidation.AV_MSE
					prop_default = Format.getFormatDefault(Format.RVECTOR, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case NNRegressorMLP_CrossValidation.AV_RMSE
					prop_default = Format.getFormatDefault(Format.RVECTOR, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE
					prop_default = Format.getFormatDefault(Format.CELL, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case NNRegressorMLP_CrossValidation.PFSP
					prop_default = Format.getFormatDefault(Format.ITEM, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case NNRegressorMLP_CrossValidation.ELCLASS
					prop_default = 'NNRegressorMLP_CrossValidation';
				case NNRegressorMLP_CrossValidation.NAME
					prop_default = 'NNRegressorMLP_CrossValidation';
				case NNRegressorMLP_CrossValidation.DESCRIPTION
					prop_default = 'A cross validation for multi-layer perceptron regressors (NNRegressorMLP_CrossValidation) is a process that facilitates the evaluation of multi-layer perceptron regressors using cross-validation. It involves splitting a dataset into multiple subsets (folds), training the model on some folds while validating on others, and then repeating the process for all combinations of folds. This helps in assessing the generalization performance of the model and detecting overfitting.';
				case NNRegressorMLP_CrossValidation.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case NNRegressorMLP_CrossValidation.ID
					prop_default = 'NNRegressorMLP_CrossValidation ID';
				case NNRegressorMLP_CrossValidation.LABEL
					prop_default = 'NNRegressorMLP_CrossValidation label';
				case NNRegressorMLP_CrossValidation.NOTES
					prop_default = 'NNRegressorMLP_CrossValidation notes';
				case NNRegressorMLP_CrossValidation.NN_TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case NNRegressorMLP_CrossValidation.NNEVALUATOR_TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@NNCrossValidation(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNRegressorMLP_CrossValidation.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNRegressorMLP_CrossValidation.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNCV.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNCV.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNRegressorMLP_CrossValidation, POINTER) returns the conditioned default value of POINTER of NNRegressorMLP_CrossValidation.
			%  DEFAULT = NNCV.GETPROPDEFAULTCONDITIONED(NNRegressorMLP_CrossValidation, POINTER) returns the conditioned default value of POINTER of NNRegressorMLP_CrossValidation.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNCV) and Element.GETPROPDEFAULTCONDITIONED('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNRegressorMLP_CrossValidation.getPropProp(pointer);
			
			prop_default = NNRegressorMLP_CrossValidation.conditioning(prop, NNRegressorMLP_CrossValidation.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNRegressorMLP_CrossValidation, PROP, VALUE) checks VALUE format for PROP of NNRegressorMLP_CrossValidation.
			%  CHECK = NNCV.CHECKPROP(NNRegressorMLP_CrossValidation, PROP, VALUE) checks VALUE format for PROP of NNRegressorMLP_CrossValidation.
			% 
			% NNCV.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNRegressorMLP_CrossValidation:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNCV.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNCV.
			%   Error id: €BRAPH2.STR€:NNRegressorMLP_CrossValidation:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNRegressorMLP_CrossValidation, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNRegressorMLP_CrossValidation.
			%   Error id: €BRAPH2.STR€:NNRegressorMLP_CrossValidation:€BRAPH2.WRONG_INPUT€
			%  NNCV.CHECKPROP(NNRegressorMLP_CrossValidation, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNRegressorMLP_CrossValidation.
			%   Error id: €BRAPH2.STR€:NNRegressorMLP_CrossValidation:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(NNCV) and Element.CHECKPROP('NNRegressorMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNRegressorMLP_CrossValidation.getPropProp(pointer);
			
			switch prop
				case NNRegressorMLP_CrossValidation.P % __NNRegressorMLP_CrossValidation.P__
					check = Format.checkFormat(Format.SCALAR, value, NNRegressorMLP_CrossValidation.getPropSettings(prop));
					if check
						check = value > 0 && value == round(value);
					end
				case NNRegressorMLP_CrossValidation.AV_CORR % __NNRegressorMLP_CrossValidation.AV_CORR__
					check = Format.checkFormat(Format.RVECTOR, value, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case NNRegressorMLP_CrossValidation.AV_DET % __NNRegressorMLP_CrossValidation.AV_DET__
					check = Format.checkFormat(Format.RVECTOR, value, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case NNRegressorMLP_CrossValidation.AV_MAE % __NNRegressorMLP_CrossValidation.AV_MAE__
					check = Format.checkFormat(Format.RVECTOR, value, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case NNRegressorMLP_CrossValidation.AV_MSE % __NNRegressorMLP_CrossValidation.AV_MSE__
					check = Format.checkFormat(Format.RVECTOR, value, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case NNRegressorMLP_CrossValidation.AV_RMSE % __NNRegressorMLP_CrossValidation.AV_RMSE__
					check = Format.checkFormat(Format.RVECTOR, value, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE % __NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE__
					check = Format.checkFormat(Format.CELL, value, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case NNRegressorMLP_CrossValidation.PFSP % __NNRegressorMLP_CrossValidation.PFSP__
					check = Format.checkFormat(Format.ITEM, value, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case NNRegressorMLP_CrossValidation.TEMPLATE % __NNRegressorMLP_CrossValidation.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case NNRegressorMLP_CrossValidation.NN_TEMPLATE % __NNRegressorMLP_CrossValidation.NN_TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				case NNRegressorMLP_CrossValidation.NNEVALUATOR_TEMPLATE % __NNRegressorMLP_CrossValidation.NNEVALUATOR_TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNRegressorMLP_CrossValidation.getPropSettings(prop));
				otherwise
					if prop <= NNCrossValidation.getPropNumber()
						check = checkProp@NNCrossValidation(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNRegressorMLP_CrossValidation:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNRegressorMLP_CrossValidation:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNRegressorMLP_CrossValidation.getPropTag(prop) ' (' NNRegressorMLP_CrossValidation.getFormatTag(NNRegressorMLP_CrossValidation.getPropFormat(prop)) ').'] ...
					)
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
				case NNRegressorMLP_CrossValidation.PFSP % __NNRegressorMLP_CrossValidation.PFSP__
					if isa(nncv.getr('PFSP'), 'NoValue')
					    nncv.set('PFSP', NNRegressorMLP_CrossValidationPF_Scatter('NNCV', nncv));
					end
					
				otherwise
					if prop <= NNCrossValidation.getPropNumber()
						postprocessing@NNCrossValidation(nncv, prop);
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
				case NNRegressorMLP_CrossValidation.AV_CORR % __NNRegressorMLP_CrossValidation.AV_CORR__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNRegressorMLP_CrossValidation.AV_CORR), 'twister')
					
					e_list = nncv.get('EVALUATOR_LIST');
					
					value = cellfun(@(e) e.get('CORR'), ...
					    e_list, 'UniformOutput', false);
					
					if isempty(value)
					    value = [];
					else
					    value = mean(cell2mat(value), 1);
					end
					
					rng(rng_settings_)
					
				case NNRegressorMLP_CrossValidation.AV_DET % __NNRegressorMLP_CrossValidation.AV_DET__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNRegressorMLP_CrossValidation.AV_DET), 'twister')
					
					e_list = nncv.get('EVALUATOR_LIST');
					
					value = cellfun(@(e) e.get('DET'), ...
					    e_list, 'UniformOutput', false);
					
					if isempty(value)
					    value = [];
					else
					    value = mean(cell2mat(value), 1);
					end
					
					rng(rng_settings_)
					
				case NNRegressorMLP_CrossValidation.AV_MAE % __NNRegressorMLP_CrossValidation.AV_MAE__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNRegressorMLP_CrossValidation.AV_MAE), 'twister')
					
					e_list = nncv.get('EVALUATOR_LIST');
					
					value = cellfun(@(e) e.get('MAE'), ...
					    e_list, 'UniformOutput', false);
					
					if isempty(value)
					    value = [];
					else
					    value = mean(cell2mat(value), 1);
					end
					
					rng(rng_settings_)
					
				case NNRegressorMLP_CrossValidation.AV_MSE % __NNRegressorMLP_CrossValidation.AV_MSE__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNRegressorMLP_CrossValidation.AV_MSE), 'twister')
					
					e_list = nncv.get('EVALUATOR_LIST');
					
					value = cellfun(@(e) e.get('MSE'), ...
					    e_list, 'UniformOutput', false);
					
					if isempty(value)
					    value = [];
					else
					    value = mean(cell2mat(value), 1);
					end
					
					rng(rng_settings_)
					
				case NNRegressorMLP_CrossValidation.AV_RMSE % __NNRegressorMLP_CrossValidation.AV_RMSE__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNRegressorMLP_CrossValidation.AV_RMSE), 'twister')
					
					e_list = nncv.get('EVALUATOR_LIST');
					
					value = cellfun(@(e) e.get('RMSE'), ...
					    e_list, 'UniformOutput', false);
					
					if isempty(value)
					    value = [];
					else
					    value = mean(cell2mat(value), 1);
					end
					
					rng(rng_settings_)
					
				case NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE % __NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE), 'twister')
					
					e_list = nncv.get('EVALUATOR_LIST');
					
					all_fi = cellfun(@(e) cell2mat(e.get('FEATURE_IMPORTANCE')), ...
					    e_list, 'UniformOutput', false);
					
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
					
				case NNRegressorMLP_CrossValidation.NN_LIST % __NNRegressorMLP_CrossValidation.NN_LIST__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNRegressorMLP_CrossValidation.NN_LIST), 'twister')
					
					d_list = nncv.get('D_LIST');
					
					if isempty(d_list)
					    value = {};
					else
					    for i = 1:length(d_list)
					        d_training_set{i} = d_list;
					        d_training_set{i}(i) = [];  % Exclude the i-th element
					        d_training_set{i} = NNDatasetCombine('D_LIST', d_training_set{i}).get('D');
					    end
					
					    d_training_set = d_training_set';
					
					    if ~isa(nncv.getr('NN_TEMPLATE'), 'NoValue')
					        nn_template = nncv.get('NN_TEMPLATE');
					    else
					        nn_template = NNRegressorMLP( ...
					            'EPOCHS', nncv.get('EPOCHS'), ...
					            'BATCH', nncv.get('BATCH'), ...
					            'SHUFFLE', nncv.get('SHUFFLE'), ...
					            'SOLVER', nncv.get('SOLVER'), ...
					            'VERBOSE', nncv.get('VERBOSE'), ...
					            'PLOT_TRAINING', nncv.get('PLOT_TRAINING'));
					    end
					    
					    value = cellfun(@(d) NNRegressorMLP( ...
					        'TEMPLATE', nn_template, 'D', d), ...
					        d_training_set, 'UniformOutput', false);
					end
					
					rng(rng_settings_)
					
				case NNRegressorMLP_CrossValidation.EVALUATOR_LIST % __NNRegressorMLP_CrossValidation.EVALUATOR_LIST__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNRegressorMLP_CrossValidation.EVALUATOR_LIST), 'twister')
					
					d_list = nncv.get('D_LIST');
					nn_list = nncv.get('NN_LIST');
					
					if ~isa(nncv.getr('NNEVALUATOR_TEMPLATE'), 'NoValue')
					    nne_template = nncv.get('NNEVALUATOR_TEMPLATE');
					else
					    nne_template = NNRegressorMLP_Evaluator( ...
					        'P', nncv.get('P'));
					end
					
					value = cellfun(@(d, nn) NNRegressorMLP_Evaluator('TEMPLATE', nne_template, 'D', d, 'NN', nn), ...
					    d_list, nn_list, 'UniformOutput', false);
					
					rng(rng_settings_)
					
				otherwise
					if prop <= NNCrossValidation.getPropNumber()
						value = calculateValue@NNCrossValidation(nncv, prop, varargin{:});
					else
						value = calculateValue@Element(nncv, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(nncv, prop, varargin)
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
				case NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE % __NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE__
					input_datasets = nncv.get('D');
					input_dataset = input_datasets{1}; % TODO: create a query to get an item from this dataset list
					dp_class = input_dataset.get('DP_CLASS');
					graph_dp_classes = {NNDataPoint_Graph_CLA().get('NAME'), NNDataPoint_Graph_REG().get('NAME')};
					measure_dp_classes = {NNDataPoint_Measure_CLA().get('NAME'), NNDataPoint_Measure_REG().get('NAME')};
					
					if any(strcmp(dp_class, graph_dp_classes)) % GRAPH input
					    pr = NNxMLP_xPP_FI_Graph('EL', nncv, 'D', input_dataset, 'PROP', NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE, varargin{:});
					elseif any(strcmp(dp_class, measure_dp_classes))% MEASURE input
					    pr = NNxMLP_xPP_FI_Measure('EL', nncv, 'D', input_dataset, 'PROP', NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE, varargin{:});
					else % DATA input
					    pr = NNxMLP_xPP_FI_Data('EL', nncv, 'D', input_dataset, 'PROP', NNRegressorMLP_CrossValidation.AV_FEATURE_IMPORTANCE, varargin{:});
					end
					
				case NNRegressorMLP_CrossValidation.PFSP % __NNRegressorMLP_CrossValidation.PFSP__
					pr = PanelPropItem('EL', nncv, 'PROP', NNRegressorMLP_CrossValidation.PFSP, ...
					    'GUICLASS', 'GUIFig', ...
						'BUTTON_TEXT', ['Scatter Plot'], ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@NNCrossValidation(nncv, prop, varargin{:});
					
			end
		end
	end
end
