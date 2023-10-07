classdef NNClassifierMLP_CrossValidation < NNCrossValidation
	%NNClassifierMLP_CrossValidation is a process for evaluating multi-layer perceptron classifiers using cross-validation.
	% It is a subclass of <a href="matlab:help NNCrossValidation">NNCrossValidation</a>.
	%
	% A cross validation for multi-layer perceptron classifiers (NNClassifierMLP_CrossValidation) is a process that facilitates the evaluation of multi-layer perceptron classifiers using cross-validation. 
	%  It involves splitting a dataset into multiple subsets (folds), training the model on some folds while validating on others, and then repeating the process for all combinations of folds. 
	%  This helps in assessing the generalization performance of the model and detecting overfitting.
	% 
	% To train all the neural networks for all folds, use: nncv.get('TRAIN')
	%
	% NNClassifierMLP_CrossValidation methods (constructor):
	%  NNClassifierMLP_CrossValidation - constructor
	%
	% NNClassifierMLP_CrossValidation methods:
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
	% NNClassifierMLP_CrossValidation methods (display):
	%  tostring - string with information about the neural network cross-validation
	%  disp - displays information about the neural network cross-validation
	%  tree - displays the tree of the neural network cross-validation
	%
	% NNClassifierMLP_CrossValidation methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network cross-validation are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network cross-validation
	%
	% NNClassifierMLP_CrossValidation methods (save/load, Static):
	%  save - saves BRAPH2 neural network cross-validation as b2 file
	%  load - loads a BRAPH2 neural network cross-validation from a b2 file
	%
	% NNClassifierMLP_CrossValidation method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network cross-validation
	%
	% NNClassifierMLP_CrossValidation method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network cross-validation
	%
	% NNClassifierMLP_CrossValidation methods (inspection, Static):
	%  getClass - returns the class of the neural network cross-validation
	%  getSubclasses - returns all subclasses of NNClassifierMLP_CrossValidation
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
	% NNClassifierMLP_CrossValidation methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNClassifierMLP_CrossValidation methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNClassifierMLP_CrossValidation methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNClassifierMLP_CrossValidation methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNClassifierMLP_CrossValidation; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNClassifierMLP_CrossValidation constants</a>.
	%
	%
	% See also NNDataPoint, NNDataset, NNEvaluator.
	
	properties (Constant) % properties
		P = NNCrossValidation.getPropNumber() + 1;
		P_TAG = 'P';
		P_CATEGORY = Category.PARAMETER;
		P_FORMAT = Format.SCALAR;
		
		AV_AUC = NNCrossValidation.getPropNumber() + 2;
		AV_AUC_TAG = 'AV_AUC';
		AV_AUC_CATEGORY = Category.RESULT;
		AV_AUC_FORMAT = Format.RVECTOR;
		
		PFROC = NNCrossValidation.getPropNumber() + 3;
		PFROC_TAG = 'PFROC';
		PFROC_CATEGORY = Category.GUI;
		PFROC_FORMAT = Format.ITEM;
		
		AV_MACRO_AUC = NNCrossValidation.getPropNumber() + 4;
		AV_MACRO_AUC_TAG = 'AV_MACRO_AUC';
		AV_MACRO_AUC_CATEGORY = Category.RESULT;
		AV_MACRO_AUC_FORMAT = Format.SCALAR;
		
		C_MATRIX = NNCrossValidation.getPropNumber() + 5;
		C_MATRIX_TAG = 'C_MATRIX';
		C_MATRIX_CATEGORY = Category.RESULT;
		C_MATRIX_FORMAT = Format.MATRIX;
		
		AV_FEATURE_IMPORTANCE = NNCrossValidation.getPropNumber() + 6;
		AV_FEATURE_IMPORTANCE_TAG = 'AV_FEATURE_IMPORTANCE';
		AV_FEATURE_IMPORTANCE_CATEGORY = Category.RESULT;
		AV_FEATURE_IMPORTANCE_FORMAT = Format.CELL;
	end
	methods % constructor
		function nncv = NNClassifierMLP_CrossValidation(varargin)
			%NNClassifierMLP_CrossValidation() creates a neural network cross-validation.
			%
			% NNClassifierMLP_CrossValidation(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNClassifierMLP_CrossValidation(TAG, VALUE, ...) with property TAG set to VALUE.
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
			% CLASS = NNClassifierMLP_CrossValidation.GETCLASS() returns the class 'NNClassifierMLP_CrossValidation'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNCV.GETCLASS() returns the class of the neural network cross-validation NNCV.
			%  CLASS = Element.GETCLASS(NNCV) returns the class of 'NNCV'.
			%  CLASS = Element.GETCLASS('NNClassifierMLP_CrossValidation') returns 'NNClassifierMLP_CrossValidation'.
			%
			% Note that the Element.GETCLASS(NNCV) and Element.GETCLASS('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			
			nncv_class = 'NNClassifierMLP_CrossValidation';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network cross-validation.
			%
			% LIST = NNClassifierMLP_CrossValidation.GETSUBCLASSES() returns all subclasses of 'NNClassifierMLP_CrossValidation'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNCV.GETSUBCLASSES() returns all subclasses of the neural network cross-validation NNCV.
			%  LIST = Element.GETSUBCLASSES(NNCV) returns all subclasses of 'NNCV'.
			%  LIST = Element.GETSUBCLASSES('NNClassifierMLP_CrossValidation') returns all subclasses of 'NNClassifierMLP_CrossValidation'.
			%
			% Note that the Element.GETSUBCLASSES(NNCV) and Element.GETSUBCLASSES('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNClassifierMLP_CrossValidation', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network cross-validation.
			%
			% PROPS = NNClassifierMLP_CrossValidation.GETPROPS() returns the property list of neural network cross-validation
			%  as a row vector.
			%
			% PROPS = NNClassifierMLP_CrossValidation.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNCV.GETPROPS([CATEGORY]) returns the property list of the neural network cross-validation NNCV.
			%  PROPS = Element.GETPROPS(NNCV[, CATEGORY]) returns the property list of 'NNCV'.
			%  PROPS = Element.GETPROPS('NNClassifierMLP_CrossValidation'[, CATEGORY]) returns the property list of 'NNClassifierMLP_CrossValidation'.
			%
			% Note that the Element.GETPROPS(NNCV) and Element.GETPROPS('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					NNCrossValidation.getProps() ...
						NNClassifierMLP_CrossValidation.P ...
						NNClassifierMLP_CrossValidation.AV_AUC ...
						NNClassifierMLP_CrossValidation.PFROC ...
						NNClassifierMLP_CrossValidation.AV_MACRO_AUC ...
						NNClassifierMLP_CrossValidation.C_MATRIX ...
						NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE ...
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
						NNClassifierMLP_CrossValidation.P ...
						];
				case Category.DATA
					prop_list = [ ...
						NNCrossValidation.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						NNCrossValidation.getProps(Category.RESULT) ...
						NNClassifierMLP_CrossValidation.AV_AUC ...
						NNClassifierMLP_CrossValidation.AV_MACRO_AUC ...
						NNClassifierMLP_CrossValidation.C_MATRIX ...
						NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE ...
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
						NNClassifierMLP_CrossValidation.PFROC ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network cross-validation.
			%
			% N = NNClassifierMLP_CrossValidation.GETPROPNUMBER() returns the property number of neural network cross-validation.
			%
			% N = NNClassifierMLP_CrossValidation.GETPROPNUMBER(CATEGORY) returns the property number of neural network cross-validation
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNCV.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network cross-validation NNCV.
			%  N = Element.GETPROPNUMBER(NNCV) returns the property number of 'NNCV'.
			%  N = Element.GETPROPNUMBER('NNClassifierMLP_CrossValidation') returns the property number of 'NNClassifierMLP_CrossValidation'.
			%
			% Note that the Element.GETPROPNUMBER(NNCV) and Element.GETPROPNUMBER('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNClassifierMLP_CrossValidation.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network cross-validation/error.
			%
			% CHECK = NNClassifierMLP_CrossValidation.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNCV.EXISTSPROP(PROP) checks whether PROP exists for NNCV.
			%  CHECK = Element.EXISTSPROP(NNCV, PROP) checks whether PROP exists for NNCV.
			%  CHECK = Element.EXISTSPROP(NNClassifierMLP_CrossValidation, PROP) checks whether PROP exists for NNClassifierMLP_CrossValidation.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_CrossValidation:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNCV.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidation:WrongInput]
			%  Element.EXISTSPROP(NNCV, PROP) throws error if PROP does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidation:WrongInput]
			%  Element.EXISTSPROP(NNClassifierMLP_CrossValidation, PROP) throws error if PROP does NOT exist for NNClassifierMLP_CrossValidation.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidation:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNCV) and Element.EXISTSPROP('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNClassifierMLP_CrossValidation.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidation:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidation:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNClassifierMLP_CrossValidation.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network cross-validation/error.
			%
			% CHECK = NNClassifierMLP_CrossValidation.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNCV.EXISTSTAG(TAG) checks whether TAG exists for NNCV.
			%  CHECK = Element.EXISTSTAG(NNCV, TAG) checks whether TAG exists for NNCV.
			%  CHECK = Element.EXISTSTAG(NNClassifierMLP_CrossValidation, TAG) checks whether TAG exists for NNClassifierMLP_CrossValidation.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNClassifierMLP_CrossValidation:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNCV.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidation:WrongInput]
			%  Element.EXISTSTAG(NNCV, TAG) throws error if TAG does NOT exist for NNCV.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidation:WrongInput]
			%  Element.EXISTSTAG(NNClassifierMLP_CrossValidation, TAG) throws error if TAG does NOT exist for NNClassifierMLP_CrossValidation.
			%   Error id: [BRAPH2:NNClassifierMLP_CrossValidation:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNCV) and Element.EXISTSTAG('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnclassifiermlp_crossvalidation_tag_list = cellfun(@(x) NNClassifierMLP_CrossValidation.getPropTag(x), num2cell(NNClassifierMLP_CrossValidation.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnclassifiermlp_crossvalidation_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidation:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidation:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNClassifierMLP_CrossValidation.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNClassifierMLP_CrossValidation, POINTER) returns property number of POINTER of NNClassifierMLP_CrossValidation.
			%  PROPERTY = NNCV.GETPROPPROP(NNClassifierMLP_CrossValidation, POINTER) returns property number of POINTER of NNClassifierMLP_CrossValidation.
			%
			% Note that the Element.GETPROPPROP(NNCV) and Element.GETPROPPROP('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnclassifiermlp_crossvalidation_tag_list = cellfun(@(x) NNClassifierMLP_CrossValidation.getPropTag(x), num2cell(NNClassifierMLP_CrossValidation.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnclassifiermlp_crossvalidation_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(NNClassifierMLP_CrossValidation, POINTER) returns tag of POINTER of NNClassifierMLP_CrossValidation.
			%  TAG = NNCV.GETPROPTAG(NNClassifierMLP_CrossValidation, POINTER) returns tag of POINTER of NNClassifierMLP_CrossValidation.
			%
			% Note that the Element.GETPROPTAG(NNCV) and Element.GETPROPTAG('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNClassifierMLP_CrossValidation.P
						tag = NNClassifierMLP_CrossValidation.P_TAG;
					case NNClassifierMLP_CrossValidation.AV_AUC
						tag = NNClassifierMLP_CrossValidation.AV_AUC_TAG;
					case NNClassifierMLP_CrossValidation.PFROC
						tag = NNClassifierMLP_CrossValidation.PFROC_TAG;
					case NNClassifierMLP_CrossValidation.AV_MACRO_AUC
						tag = NNClassifierMLP_CrossValidation.AV_MACRO_AUC_TAG;
					case NNClassifierMLP_CrossValidation.C_MATRIX
						tag = NNClassifierMLP_CrossValidation.C_MATRIX_TAG;
					case NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE
						tag = NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNClassifierMLP_CrossValidation, POINTER) returns category of POINTER of NNClassifierMLP_CrossValidation.
			%  CATEGORY = NNCV.GETPROPCATEGORY(NNClassifierMLP_CrossValidation, POINTER) returns category of POINTER of NNClassifierMLP_CrossValidation.
			%
			% Note that the Element.GETPROPCATEGORY(NNCV) and Element.GETPROPCATEGORY('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidation.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidation.P
					prop_category = NNClassifierMLP_CrossValidation.P_CATEGORY;
				case NNClassifierMLP_CrossValidation.AV_AUC
					prop_category = NNClassifierMLP_CrossValidation.AV_AUC_CATEGORY;
				case NNClassifierMLP_CrossValidation.PFROC
					prop_category = NNClassifierMLP_CrossValidation.PFROC_CATEGORY;
				case NNClassifierMLP_CrossValidation.AV_MACRO_AUC
					prop_category = NNClassifierMLP_CrossValidation.AV_MACRO_AUC_CATEGORY;
				case NNClassifierMLP_CrossValidation.C_MATRIX
					prop_category = NNClassifierMLP_CrossValidation.C_MATRIX_CATEGORY;
				case NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE
					prop_category = NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(NNClassifierMLP_CrossValidation, POINTER) returns format of POINTER of NNClassifierMLP_CrossValidation.
			%  FORMAT = NNCV.GETPROPFORMAT(NNClassifierMLP_CrossValidation, POINTER) returns format of POINTER of NNClassifierMLP_CrossValidation.
			%
			% Note that the Element.GETPROPFORMAT(NNCV) and Element.GETPROPFORMAT('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidation.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidation.P
					prop_format = NNClassifierMLP_CrossValidation.P_FORMAT;
				case NNClassifierMLP_CrossValidation.AV_AUC
					prop_format = NNClassifierMLP_CrossValidation.AV_AUC_FORMAT;
				case NNClassifierMLP_CrossValidation.PFROC
					prop_format = NNClassifierMLP_CrossValidation.PFROC_FORMAT;
				case NNClassifierMLP_CrossValidation.AV_MACRO_AUC
					prop_format = NNClassifierMLP_CrossValidation.AV_MACRO_AUC_FORMAT;
				case NNClassifierMLP_CrossValidation.C_MATRIX
					prop_format = NNClassifierMLP_CrossValidation.C_MATRIX_FORMAT;
				case NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE
					prop_format = NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNClassifierMLP_CrossValidation, POINTER) returns description of POINTER of NNClassifierMLP_CrossValidation.
			%  DESCRIPTION = NNCV.GETPROPDESCRIPTION(NNClassifierMLP_CrossValidation, POINTER) returns description of POINTER of NNClassifierMLP_CrossValidation.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNCV) and Element.GETPROPDESCRIPTION('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidation.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidation.P
					prop_description = 'P (parameter, scalar) is the permutation number.';
				case NNClassifierMLP_CrossValidation.AV_AUC
					prop_description = 'AV_AUC (result, rvector) provides the average value of the area under the receiver operating characteristic curve across k folds.';
				case NNClassifierMLP_CrossValidation.PFROC
					prop_description = 'PFROC (gui, item) contains the panel figure of the ROC plot for classification model.';
				case NNClassifierMLP_CrossValidation.AV_MACRO_AUC
					prop_description = 'AV_MACRO_AUC (result, scalar) provides the metric of the average macro AUC value across k folds.';
				case NNClassifierMLP_CrossValidation.C_MATRIX
					prop_description = 'C_MATRIX (result, matrix) provides the confusion matrix across k folds.';
				case NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE
					prop_description = 'AV_FEATURE_IMPORTANCE (result, cell) averages the feature importances across k folds.';
				case NNClassifierMLP_CrossValidation.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case NNClassifierMLP_CrossValidation.NAME
					prop_description = 'NAME (constant, string) is the name of the cross-validation.';
				case NNClassifierMLP_CrossValidation.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the cross-validation.';
				case NNClassifierMLP_CrossValidation.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the cross-validation.';
				case NNClassifierMLP_CrossValidation.ID
					prop_description = 'ID (data, string) is a few-letter code for the cross-validation.';
				case NNClassifierMLP_CrossValidation.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the cross-validation.';
				case NNClassifierMLP_CrossValidation.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the cross-validation.';
				case NNClassifierMLP_CrossValidation.NN_TEMPLATE
					prop_description = 'NN_TEMPLATE (parameter, item) is the neural network template to set all neural network parameters.';
				case NNClassifierMLP_CrossValidation.NNEVALUATOR_TEMPLATE
					prop_description = 'NNEVALUATOR_TEMPLATE (parameter, item) is the neural network evaluator template to set all evalutor parameters.';
				case NNClassifierMLP_CrossValidation.NN_LIST
					prop_description = 'NN_LIST (result, itemlist) contains the neural network models corresponding to k folds.';
				case NNClassifierMLP_CrossValidation.EVALUATOR_LIST
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNClassifierMLP_CrossValidation, POINTER) returns settings of POINTER of NNClassifierMLP_CrossValidation.
			%  SETTINGS = NNCV.GETPROPSETTINGS(NNClassifierMLP_CrossValidation, POINTER) returns settings of POINTER of NNClassifierMLP_CrossValidation.
			%
			% Note that the Element.GETPROPSETTINGS(NNCV) and Element.GETPROPSETTINGS('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNClassifierMLP_CrossValidation.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidation.P
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNClassifierMLP_CrossValidation.AV_AUC
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case NNClassifierMLP_CrossValidation.PFROC
					prop_settings = 'NNClassifierMLP_CrossValidationPF_ROC';
				case NNClassifierMLP_CrossValidation.AV_MACRO_AUC
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NNClassifierMLP_CrossValidation.C_MATRIX
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE
					prop_settings = Format.getFormatSettings(Format.CELL);
				case NNClassifierMLP_CrossValidation.TEMPLATE
					prop_settings = 'NNClassifierMLP_CrossValidation';
				case NNClassifierMLP_CrossValidation.NN_TEMPLATE
					prop_settings = 'NNClassifierMLP';
				case NNClassifierMLP_CrossValidation.NNEVALUATOR_TEMPLATE
					prop_settings = 'NNClassifierMLP_Evaluator';
				otherwise
					prop_settings = getPropSettings@NNCrossValidation(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNClassifierMLP_CrossValidation.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_CrossValidation.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNCV.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNCV.
			%  DEFAULT = Element.GETPROPDEFAULT(NNClassifierMLP_CrossValidation, POINTER) returns the default value of POINTER of NNClassifierMLP_CrossValidation.
			%  DEFAULT = NNCV.GETPROPDEFAULT(NNClassifierMLP_CrossValidation, POINTER) returns the default value of POINTER of NNClassifierMLP_CrossValidation.
			%
			% Note that the Element.GETPROPDEFAULT(NNCV) and Element.GETPROPDEFAULT('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNClassifierMLP_CrossValidation.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidation.P
					prop_default = 1e+2;
				case NNClassifierMLP_CrossValidation.AV_AUC
					prop_default = Format.getFormatDefault(Format.RVECTOR, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation.PFROC
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation.AV_MACRO_AUC
					prop_default = Format.getFormatDefault(Format.SCALAR, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation.C_MATRIX
					prop_default = Format.getFormatDefault(Format.MATRIX, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE
					prop_default = Format.getFormatDefault(Format.CELL, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation.ELCLASS
					prop_default = 'NNClassifierMLP_CrossValidation';
				case NNClassifierMLP_CrossValidation.NAME
					prop_default = 'NNClassifierMLP_CrossValidation';
				case NNClassifierMLP_CrossValidation.DESCRIPTION
					prop_default = 'A cross validation for multi-layer perceptron classifiers (NNClassifierMLP_CrossValidation) is a process that facilitates the evaluation of multi-layer perceptron classifiers using cross-validation. It involves splitting a dataset into multiple subsets (folds), training the model on some folds while validating on others, and then repeating the process for all combinations of folds. This helps in assessing the generalization performance of the model and detecting overfitting.';
				case NNClassifierMLP_CrossValidation.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation.ID
					prop_default = 'NNClassifierMLP_CrossValidation ID';
				case NNClassifierMLP_CrossValidation.LABEL
					prop_default = 'NNClassifierMLP_CrossValidation label';
				case NNClassifierMLP_CrossValidation.NOTES
					prop_default = 'NNClassifierMLP_CrossValidation notes';
				case NNClassifierMLP_CrossValidation.NN_TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation.NNEVALUATOR_TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@NNCrossValidation(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNClassifierMLP_CrossValidation.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNClassifierMLP_CrossValidation.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNCV.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNCV.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_CrossValidation, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_CrossValidation.
			%  DEFAULT = NNCV.GETPROPDEFAULTCONDITIONED(NNClassifierMLP_CrossValidation, POINTER) returns the conditioned default value of POINTER of NNClassifierMLP_CrossValidation.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNCV) and Element.GETPROPDEFAULTCONDITIONED('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNClassifierMLP_CrossValidation.getPropProp(pointer);
			
			prop_default = NNClassifierMLP_CrossValidation.conditioning(prop, NNClassifierMLP_CrossValidation.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNClassifierMLP_CrossValidation, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_CrossValidation.
			%  CHECK = NNCV.CHECKPROP(NNClassifierMLP_CrossValidation, PROP, VALUE) checks VALUE format for PROP of NNClassifierMLP_CrossValidation.
			% 
			% NNCV.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNClassifierMLP_CrossValidation:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNCV.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNCV.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_CrossValidation:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNClassifierMLP_CrossValidation, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_CrossValidation.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_CrossValidation:€BRAPH2.WRONG_INPUT€
			%  NNCV.CHECKPROP(NNClassifierMLP_CrossValidation, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNClassifierMLP_CrossValidation.
			%   Error id: €BRAPH2.STR€:NNClassifierMLP_CrossValidation:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(NNCV) and Element.CHECKPROP('NNClassifierMLP_CrossValidation')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNClassifierMLP_CrossValidation.getPropProp(pointer);
			
			switch prop
				case NNClassifierMLP_CrossValidation.P % __NNClassifierMLP_CrossValidation.P__
					check = Format.checkFormat(Format.SCALAR, value, NNClassifierMLP_CrossValidation.getPropSettings(prop));
					if check
						check = value > 0 && value == round(value);
					end
				case NNClassifierMLP_CrossValidation.AV_AUC % __NNClassifierMLP_CrossValidation.AV_AUC__
					check = Format.checkFormat(Format.RVECTOR, value, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation.PFROC % __NNClassifierMLP_CrossValidation.PFROC__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation.AV_MACRO_AUC % __NNClassifierMLP_CrossValidation.AV_MACRO_AUC__
					check = Format.checkFormat(Format.SCALAR, value, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation.C_MATRIX % __NNClassifierMLP_CrossValidation.C_MATRIX__
					check = Format.checkFormat(Format.MATRIX, value, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE % __NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE__
					check = Format.checkFormat(Format.CELL, value, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation.TEMPLATE % __NNClassifierMLP_CrossValidation.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation.NN_TEMPLATE % __NNClassifierMLP_CrossValidation.NN_TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				case NNClassifierMLP_CrossValidation.NNEVALUATOR_TEMPLATE % __NNClassifierMLP_CrossValidation.NNEVALUATOR_TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNClassifierMLP_CrossValidation.getPropSettings(prop));
				otherwise
					if prop <= NNCrossValidation.getPropNumber()
						check = checkProp@NNCrossValidation(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidation:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNClassifierMLP_CrossValidation:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNClassifierMLP_CrossValidation.getPropTag(prop) ' (' NNClassifierMLP_CrossValidation.getFormatTag(NNClassifierMLP_CrossValidation.getPropFormat(prop)) ').'] ...
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
				case NNClassifierMLP_CrossValidation.PFROC % __NNClassifierMLP_CrossValidation.PFROC__
					if isa(nncv.getr('PFROC'), 'NoValue')
					    nncv.set('PFROC', NNClassifierMLP_CrossValidationPF_ROC('NNCV', nncv));
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
				case NNClassifierMLP_CrossValidation.AV_AUC % __NNClassifierMLP_CrossValidation.AV_AUC__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNClassifierMLP_CrossValidation.AV_AUC), 'twister')
					
					e_list = nncv.get('EVALUATOR_LIST');
					
					aucs = cellfun(@(e) e.get('AUC'), ...
					    e_list, 'UniformOutput', false);
					
					if isempty(aucs)
					    value = [];
					else
					    value = mean(cell2mat(aucs), 1);
					end
					
					rng(rng_settings_)
					
				case NNClassifierMLP_CrossValidation.AV_MACRO_AUC % __NNClassifierMLP_CrossValidation.AV_MACRO_AUC__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNClassifierMLP_CrossValidation.AV_MACRO_AUC), 'twister')
					
					e_list = nncv.get('EVALUATOR_LIST');
					
					macro_aucs = cellfun(@(e) e.get('MACRO_AUC'), ...
					    e_list, 'UniformOutput', false);
					
					if isempty(macro_aucs)
					    value = 0;
					else
					    value = mean(cell2mat(macro_aucs), 1);
					end
					
					rng(rng_settings_)
					
				case NNClassifierMLP_CrossValidation.C_MATRIX % __NNClassifierMLP_CrossValidation.C_MATRIX__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNClassifierMLP_CrossValidation.C_MATRIX), 'twister')
					
					e_list = nncv.get('EVALUATOR_LIST');
					
					c_matrices = cellfun(@(e) e.get('C_MATRIX'), ...
					    e_list, 'UniformOutput', false);
					
					combined_c_matrix = cellfun(@(x) double(x), c_matrices, 'UniformOutput', false);
					value = sum(cat(3, combined_c_matrix{:}), 3);
					
					rng(rng_settings_)
					
				case NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE % __NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE), 'twister')
					
					e_list = nncv.get('EVALUATOR_LIST');
					wb = braph2waitbar(nncv.get('WAITBAR'), 0, ['Initialize featur importance permutation ...']);
					all_fi = cellfun(@(e) cell2mat(e.get('FEATURE_IMPORTANCE')), ...
					    e_list, 'UniformOutput', false);
					braph2waitbar(wb, 'close')
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
					
				case NNClassifierMLP_CrossValidation.NN_LIST % __NNClassifierMLP_CrossValidation.NN_LIST__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNClassifierMLP_CrossValidation.NN_LIST), 'twister')
					
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
					        nn_template = NNClassifierMLP( ...
					            'EPOCHS', nncv.get('EPOCHS'), ...
					            'BATCH', nncv.get('BATCH'), ...
					            'SHUFFLE', nncv.get('SHUFFLE'), ...
					            'SOLVER', nncv.get('SOLVER'), ...
					            'VERBOSE', nncv.get('VERBOSE'), ...
					            'PLOT_TRAINING', nncv.get('PLOT_TRAINING'));
					    end
					    
					    value = cellfun(@(d) NNClassifierMLP( ...
					        'TEMPLATE', nn_template, 'D', d, 'VERBOSE', nncv.get('VERBOSE'), 'PLOT_TRAINING', nncv.get('PLOT_TRAINING')), ...
					        d_training_set, 'UniformOutput', false);
					end
					
					rng(rng_settings_)
					
				case NNClassifierMLP_CrossValidation.EVALUATOR_LIST % __NNClassifierMLP_CrossValidation.EVALUATOR_LIST__
					rng_settings_ = rng(); rng(nncv.getPropSeed(NNClassifierMLP_CrossValidation.EVALUATOR_LIST), 'twister')
					
					d_list = nncv.get('D_LIST');
					nn_list = nncv.get('NN_LIST');
					
					if ~isa(nncv.getr('NNEVALUATOR_TEMPLATE'), 'NoValue')
					    nne_template = nncv.get('NNEVALUATOR_TEMPLATE');
					else
					    nne_template = NNClassifierMLP_Evaluator( ...
					        'P', nncv.get('P'));
					end
					
					value = cellfun(@(d, nn) NNClassifierMLP_Evaluator('TEMPLATE', nne_template, 'D', d, 'NN', nn), ...
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
				case NNClassifierMLP_CrossValidation.PFROC % __NNClassifierMLP_CrossValidation.PFROC__
					pr = PanelPropItem('EL', nncv, 'PROP', NNClassifierMLP_CrossValidation.PFROC, ...
					    'GUICLASS', 'GUIFig', ...
						'BUTTON_TEXT', ['ROC Plot'], ...
					    varargin{:});
					
				case NNClassifierMLP_CrossValidation.C_MATRIX % __NNClassifierMLP_CrossValidation.C_MATRIX__
					d = NNDatasetCombine('D_LIST', nncv.get('D')).get('D');
					targets = NNClassifierMLP().get('TARGET_IDS', d);
					class_names = unique(targets);
					pr = PanelPropMatrix('EL', nncv, 'PROP', NNClassifierMLP_CrossValidation.C_MATRIX, ...
					    'TABLE_HEIGHT', s(40), ...
					    'ROWNAME', class_names, ...
					    'COLUMNNAME', class_names, ...
					    varargin{:});
					
				case NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE % __NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE__
					input_datasets = nncv.get('D');
					input_dataset = input_datasets{1}; % TODO: create a query to get an item from this dataset list
					dp_class = input_dataset.get('DP_CLASS');
					graph_dp_classes = {NNDataPoint_Graph_CLA().get('NAME'), NNDataPoint_Graph_REG().get('NAME')};
					measure_dp_classes = {NNDataPoint_Measure_CLA().get('NAME'), NNDataPoint_Measure_REG().get('NAME')};
					
					if any(strcmp(dp_class, graph_dp_classes)) % GRAPH input
					    pr = NNxMLP_xPP_FI_Graph('EL', nncv, 'D', input_dataset, 'PROP', NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE, varargin{:});
					elseif any(strcmp(dp_class, measure_dp_classes))% MEASURE input
					    pr = NNxMLP_xPP_FI_Measure('EL', nncv, 'D', input_dataset, 'PROP', NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE, varargin{:});
					else % DATA input
					    pr = NNxMLP_xPP_FI_Data('EL', nncv, 'D', input_dataset, 'PROP', NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE, varargin{:});
					end
					
				otherwise
					pr = getPanelProp@NNCrossValidation(nncv, prop, varargin{:});
					
			end
		end
	end
end
