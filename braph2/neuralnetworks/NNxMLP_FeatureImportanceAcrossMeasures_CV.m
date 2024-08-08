classdef NNxMLP_FeatureImportanceAcrossMeasures_CV < NNxMLP_FeatureImportance_CV
	%NNxMLP_FeatureImportanceAcrossMeasures_CV provides feature importance analysis with cross validation for multi-layer perceptron (MLP) across all included graph measures.
	% It is a subclass of <a href="matlab:help NNxMLP_FeatureImportance_CV">NNxMLP_FeatureImportance_CV</a>.
	%
	% Neural Network Feature Importance Across Graph Measures with Cross-Validation (NNxMLP_FeatureImportanceAcrossMeasures_CV) 
	%  assesses the importance of graph measures by measuring the increase in model error when specific graph measure values are randomly shuffled. 
	% The feature importance score for each measure is then averaged across all folds. 
	% It applies a template to all folds of NNxMLP_FeatureImportance for setting up the parameters of the permutation method, 
	%  such as a user-defined confidence interval, and adjusts for multiple comparisons with the Bonferroni correction.
	%
	% NNxMLP_FeatureImportanceAcrossMeasures_CV methods (constructor):
	%  NNxMLP_FeatureImportanceAcrossMeasures_CV - constructor
	%
	% NNxMLP_FeatureImportanceAcrossMeasures_CV methods:
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
	% NNxMLP_FeatureImportanceAcrossMeasures_CV methods (display):
	%  tostring - string with information about the neural network feature importace for multi-layer perceptron
	%  disp - displays information about the neural network feature importace for multi-layer perceptron
	%  tree - displays the tree of the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceAcrossMeasures_CV methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network feature importace for multi-layer perceptron are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceAcrossMeasures_CV methods (save/load, Static):
	%  save - saves BRAPH2 neural network feature importace for multi-layer perceptron as b2 file
	%  load - loads a BRAPH2 neural network feature importace for multi-layer perceptron from a b2 file
	%
	% NNxMLP_FeatureImportanceAcrossMeasures_CV method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceAcrossMeasures_CV method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network feature importace for multi-layer perceptron
	%
	% NNxMLP_FeatureImportanceAcrossMeasures_CV methods (inspection, Static):
	%  getClass - returns the class of the neural network feature importace for multi-layer perceptron
	%  getSubclasses - returns all subclasses of NNxMLP_FeatureImportanceAcrossMeasures_CV
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
	% NNxMLP_FeatureImportanceAcrossMeasures_CV methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNxMLP_FeatureImportanceAcrossMeasures_CV methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNxMLP_FeatureImportanceAcrossMeasures_CV methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNxMLP_FeatureImportanceAcrossMeasures_CV methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNxMLP_FeatureImportanceAcrossMeasures_CV; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNxMLP_FeatureImportanceAcrossMeasures_CV constants</a>.
	%
	%
	% See also NNxMLP_FeatureImportanceAcrossMeasures, NNClassifierMLP_CrossValidation, NNRegressorMLP_CrossValidation.
	
	methods % constructor
		function nnficv = NNxMLP_FeatureImportanceAcrossMeasures_CV(varargin)
			%NNxMLP_FeatureImportanceAcrossMeasures_CV() creates a neural network feature importace for multi-layer perceptron.
			%
			% NNxMLP_FeatureImportanceAcrossMeasures_CV(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNxMLP_FeatureImportanceAcrossMeasures_CV(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			nnficv = nnficv@NNxMLP_FeatureImportance_CV(varargin{:});
		end
	end
	methods (Static) % inspection
		function nnficv_class = getClass()
			%GETCLASS returns the class of the neural network feature importace for multi-layer perceptron.
			%
			% CLASS = NNxMLP_FeatureImportanceAcrossMeasures_CV.GETCLASS() returns the class 'NNxMLP_FeatureImportanceAcrossMeasures_CV'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNFICV.GETCLASS() returns the class of the neural network feature importace for multi-layer perceptron NNFICV.
			%  CLASS = Element.GETCLASS(NNFICV) returns the class of 'NNFICV'.
			%  CLASS = Element.GETCLASS('NNxMLP_FeatureImportanceAcrossMeasures_CV') returns 'NNxMLP_FeatureImportanceAcrossMeasures_CV'.
			%
			% Note that the Element.GETCLASS(NNFICV) and Element.GETCLASS('NNxMLP_FeatureImportanceAcrossMeasures_CV')
			%  are less computationally efficient.
			
			nnficv_class = 'NNxMLP_FeatureImportanceAcrossMeasures_CV';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network feature importace for multi-layer perceptron.
			%
			% LIST = NNxMLP_FeatureImportanceAcrossMeasures_CV.GETSUBCLASSES() returns all subclasses of 'NNxMLP_FeatureImportanceAcrossMeasures_CV'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNFICV.GETSUBCLASSES() returns all subclasses of the neural network feature importace for multi-layer perceptron NNFICV.
			%  LIST = Element.GETSUBCLASSES(NNFICV) returns all subclasses of 'NNFICV'.
			%  LIST = Element.GETSUBCLASSES('NNxMLP_FeatureImportanceAcrossMeasures_CV') returns all subclasses of 'NNxMLP_FeatureImportanceAcrossMeasures_CV'.
			%
			% Note that the Element.GETSUBCLASSES(NNFICV) and Element.GETSUBCLASSES('NNxMLP_FeatureImportanceAcrossMeasures_CV')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNxMLP_FeatureImportanceAcrossMeasures_CV', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network feature importace for multi-layer perceptron.
			%
			% PROPS = NNxMLP_FeatureImportanceAcrossMeasures_CV.GETPROPS() returns the property list of neural network feature importace for multi-layer perceptron
			%  as a row vector.
			%
			% PROPS = NNxMLP_FeatureImportanceAcrossMeasures_CV.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNFICV.GETPROPS([CATEGORY]) returns the property list of the neural network feature importace for multi-layer perceptron NNFICV.
			%  PROPS = Element.GETPROPS(NNFICV[, CATEGORY]) returns the property list of 'NNFICV'.
			%  PROPS = Element.GETPROPS('NNxMLP_FeatureImportanceAcrossMeasures_CV'[, CATEGORY]) returns the property list of 'NNxMLP_FeatureImportanceAcrossMeasures_CV'.
			%
			% Note that the Element.GETPROPS(NNFICV) and Element.GETPROPS('NNxMLP_FeatureImportanceAcrossMeasures_CV')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					NNxMLP_FeatureImportance_CV.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						NNxMLP_FeatureImportance_CV.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						NNxMLP_FeatureImportance_CV.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						NNxMLP_FeatureImportance_CV.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						NNxMLP_FeatureImportance_CV.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						NNxMLP_FeatureImportance_CV.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						NNxMLP_FeatureImportance_CV.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						NNxMLP_FeatureImportance_CV.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						NNxMLP_FeatureImportance_CV.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						NNxMLP_FeatureImportance_CV.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network feature importace for multi-layer perceptron.
			%
			% N = NNxMLP_FeatureImportanceAcrossMeasures_CV.GETPROPNUMBER() returns the property number of neural network feature importace for multi-layer perceptron.
			%
			% N = NNxMLP_FeatureImportanceAcrossMeasures_CV.GETPROPNUMBER(CATEGORY) returns the property number of neural network feature importace for multi-layer perceptron
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNFICV.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network feature importace for multi-layer perceptron NNFICV.
			%  N = Element.GETPROPNUMBER(NNFICV) returns the property number of 'NNFICV'.
			%  N = Element.GETPROPNUMBER('NNxMLP_FeatureImportanceAcrossMeasures_CV') returns the property number of 'NNxMLP_FeatureImportanceAcrossMeasures_CV'.
			%
			% Note that the Element.GETPROPNUMBER(NNFICV) and Element.GETPROPNUMBER('NNxMLP_FeatureImportanceAcrossMeasures_CV')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNxMLP_FeatureImportanceAcrossMeasures_CV.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network feature importace for multi-layer perceptron/error.
			%
			% CHECK = NNxMLP_FeatureImportanceAcrossMeasures_CV.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFICV.EXISTSPROP(PROP) checks whether PROP exists for NNFICV.
			%  CHECK = Element.EXISTSPROP(NNFICV, PROP) checks whether PROP exists for NNFICV.
			%  CHECK = Element.EXISTSPROP(NNxMLP_FeatureImportanceAcrossMeasures_CV, PROP) checks whether PROP exists for NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossMeasures_CV:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFICV.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNFICV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossMeasures_CV:WrongInput]
			%  Element.EXISTSPROP(NNFICV, PROP) throws error if PROP does NOT exist for NNFICV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossMeasures_CV:WrongInput]
			%  Element.EXISTSPROP(NNxMLP_FeatureImportanceAcrossMeasures_CV, PROP) throws error if PROP does NOT exist for NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossMeasures_CV:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNFICV) and Element.EXISTSPROP('NNxMLP_FeatureImportanceAcrossMeasures_CV')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNxMLP_FeatureImportanceAcrossMeasures_CV.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceAcrossMeasures_CV:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceAcrossMeasures_CV:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNxMLP_FeatureImportanceAcrossMeasures_CV.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network feature importace for multi-layer perceptron/error.
			%
			% CHECK = NNxMLP_FeatureImportanceAcrossMeasures_CV.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNFICV.EXISTSTAG(TAG) checks whether TAG exists for NNFICV.
			%  CHECK = Element.EXISTSTAG(NNFICV, TAG) checks whether TAG exists for NNFICV.
			%  CHECK = Element.EXISTSTAG(NNxMLP_FeatureImportanceAcrossMeasures_CV, TAG) checks whether TAG exists for NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossMeasures_CV:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNFICV.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNFICV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossMeasures_CV:WrongInput]
			%  Element.EXISTSTAG(NNFICV, TAG) throws error if TAG does NOT exist for NNFICV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossMeasures_CV:WrongInput]
			%  Element.EXISTSTAG(NNxMLP_FeatureImportanceAcrossMeasures_CV, TAG) throws error if TAG does NOT exist for NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%   Error id: [BRAPH2:NNxMLP_FeatureImportanceAcrossMeasures_CV:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNFICV) and Element.EXISTSTAG('NNxMLP_FeatureImportanceAcrossMeasures_CV')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnxmlp_featureimportanceacrossmeasures_cv_tag_list = cellfun(@(x) NNxMLP_FeatureImportanceAcrossMeasures_CV.getPropTag(x), num2cell(NNxMLP_FeatureImportanceAcrossMeasures_CV.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnxmlp_featureimportanceacrossmeasures_cv_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceAcrossMeasures_CV:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceAcrossMeasures_CV:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNxMLP_FeatureImportanceAcrossMeasures_CV.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNxMLP_FeatureImportanceAcrossMeasures_CV, POINTER) returns property number of POINTER of NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%  PROPERTY = NNFICV.GETPROPPROP(NNxMLP_FeatureImportanceAcrossMeasures_CV, POINTER) returns property number of POINTER of NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%
			% Note that the Element.GETPROPPROP(NNFICV) and Element.GETPROPPROP('NNxMLP_FeatureImportanceAcrossMeasures_CV')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnxmlp_featureimportanceacrossmeasures_cv_tag_list = cellfun(@(x) NNxMLP_FeatureImportanceAcrossMeasures_CV.getPropTag(x), num2cell(NNxMLP_FeatureImportanceAcrossMeasures_CV.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnxmlp_featureimportanceacrossmeasures_cv_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(NNxMLP_FeatureImportanceAcrossMeasures_CV, POINTER) returns tag of POINTER of NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%  TAG = NNFICV.GETPROPTAG(NNxMLP_FeatureImportanceAcrossMeasures_CV, POINTER) returns tag of POINTER of NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%
			% Note that the Element.GETPROPTAG(NNFICV) and Element.GETPROPTAG('NNxMLP_FeatureImportanceAcrossMeasures_CV')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					otherwise
						tag = getPropTag@NNxMLP_FeatureImportance_CV(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNxMLP_FeatureImportanceAcrossMeasures_CV, POINTER) returns category of POINTER of NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%  CATEGORY = NNFICV.GETPROPCATEGORY(NNxMLP_FeatureImportanceAcrossMeasures_CV, POINTER) returns category of POINTER of NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%
			% Note that the Element.GETPROPCATEGORY(NNFICV) and Element.GETPROPCATEGORY('NNxMLP_FeatureImportanceAcrossMeasures_CV')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceAcrossMeasures_CV.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@NNxMLP_FeatureImportance_CV(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(NNxMLP_FeatureImportanceAcrossMeasures_CV, POINTER) returns format of POINTER of NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%  FORMAT = NNFICV.GETPROPFORMAT(NNxMLP_FeatureImportanceAcrossMeasures_CV, POINTER) returns format of POINTER of NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%
			% Note that the Element.GETPROPFORMAT(NNFICV) and Element.GETPROPFORMAT('NNxMLP_FeatureImportanceAcrossMeasures_CV')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceAcrossMeasures_CV.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@NNxMLP_FeatureImportance_CV(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNxMLP_FeatureImportanceAcrossMeasures_CV, POINTER) returns description of POINTER of NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%  DESCRIPTION = NNFICV.GETPROPDESCRIPTION(NNxMLP_FeatureImportanceAcrossMeasures_CV, POINTER) returns description of POINTER of NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNFICV) and Element.GETPROPDESCRIPTION('NNxMLP_FeatureImportanceAcrossMeasures_CV')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceAcrossMeasures_CV.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceAcrossMeasures_CV.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the feature importance analysis with cross validation for multi-layer perceptron (MLP) across all included graph measures.';
				case NNxMLP_FeatureImportanceAcrossMeasures_CV.NAME
					prop_description = 'NAME (constant, string) is the name of the feature importance analysis with cross validation for multi-layer perceptron (MLP) across all included graph measures.';
				case NNxMLP_FeatureImportanceAcrossMeasures_CV.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the feature importance analysis with cross validation for multi-layer perceptron (MLP) across all included graph measures.';
				case NNxMLP_FeatureImportanceAcrossMeasures_CV.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the feature importance analysis with cross validation for multi-layer perceptron (MLP) across all included graph measures.';
				case NNxMLP_FeatureImportanceAcrossMeasures_CV.ID
					prop_description = 'ID (data, string) is a few-letter code of the the feature importance analysis with cross validation for multi-layer perceptron (MLP) across all included graph measures.';
				case NNxMLP_FeatureImportanceAcrossMeasures_CV.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the feature importance analysis with cross validation for multi-layer perceptron (MLP) across all included graph measures.';
				case NNxMLP_FeatureImportanceAcrossMeasures_CV.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the feature importance analysis with cross validation for multi-layer perceptron (MLP) across all included graph measures.';
				case NNxMLP_FeatureImportanceAcrossMeasures_CV.AV_FEATURE_IMPORTANCE
					prop_description = 'AV_FEATURE_IMPORTANCE (result, cell) is determined by applying FDR correction for the permutation and obtaining the value by the average of the permutation number times of shuffled loss, which then in trun are divided by base loss for normalizaiton.';
				case NNxMLP_FeatureImportanceAcrossMeasures_CV.FEATURE_IMPORTANCE_FOLDS
					prop_description = 'FEATURE_IMPORTANCE_FOLDS (result, cell) is determined by applying FDR correction for the permutation and obtaining the value by the average of the permutation number times of shuffled loss, which then in trun are divided by base loss for normalizaiton.';
				otherwise
					prop_description = getPropDescription@NNxMLP_FeatureImportance_CV(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNxMLP_FeatureImportanceAcrossMeasures_CV, POINTER) returns settings of POINTER of NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%  SETTINGS = NNFICV.GETPROPSETTINGS(NNxMLP_FeatureImportanceAcrossMeasures_CV, POINTER) returns settings of POINTER of NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%
			% Note that the Element.GETPROPSETTINGS(NNFICV) and Element.GETPROPSETTINGS('NNxMLP_FeatureImportanceAcrossMeasures_CV')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_FeatureImportanceAcrossMeasures_CV.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceAcrossMeasures_CV.TEMPLATE
					prop_settings = 'NNxMLP_FeatureImportanceAcrossMeasures_CV';
				otherwise
					prop_settings = getPropSettings@NNxMLP_FeatureImportance_CV(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportanceAcrossMeasures_CV.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportanceAcrossMeasures_CV.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFICV.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNFICV.
			%  DEFAULT = Element.GETPROPDEFAULT(NNxMLP_FeatureImportanceAcrossMeasures_CV, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%  DEFAULT = NNFICV.GETPROPDEFAULT(NNxMLP_FeatureImportanceAcrossMeasures_CV, POINTER) returns the default value of POINTER of NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%
			% Note that the Element.GETPROPDEFAULT(NNFICV) and Element.GETPROPDEFAULT('NNxMLP_FeatureImportanceAcrossMeasures_CV')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNxMLP_FeatureImportanceAcrossMeasures_CV.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceAcrossMeasures_CV.ELCLASS
					prop_default = 'NNxMLP_FeatureImportanceAcrossMeasures_CV';
				case NNxMLP_FeatureImportanceAcrossMeasures_CV.NAME
					prop_default = 'Feature Importace for Multi-layer Perceptron';
				case NNxMLP_FeatureImportanceAcrossMeasures_CV.DESCRIPTION
					prop_default = 'Neural Network Feature Importance Across Graph Measures with Cross-Validation (NNxMLP_FeatureImportanceAcrossMeasures_CV) assesses the importance of graph measures by measuring the increase in model error when specific graph measure values are randomly shuffled. The feature importance score for each measure is then averaged across all folds. It applies a template to all folds of NNxMLP_FeatureImportance for setting up the parameters of the permutation method, such as a user-defined confidence interval, and adjusts for multiple comparisons with the Bonferroni correction.';
				case NNxMLP_FeatureImportanceAcrossMeasures_CV.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNxMLP_FeatureImportanceAcrossMeasures_CV.getPropSettings(prop));
				case NNxMLP_FeatureImportanceAcrossMeasures_CV.ID
					prop_default = 'NNxMLP_FeatureImportanceAcrossMeasures_CV ID';
				case NNxMLP_FeatureImportanceAcrossMeasures_CV.LABEL
					prop_default = 'NNxMLP_FeatureImportanceAcrossMeasures_CV label';
				case NNxMLP_FeatureImportanceAcrossMeasures_CV.NOTES
					prop_default = 'NNxMLP_FeatureImportanceAcrossMeasures_CV notes';
				otherwise
					prop_default = getPropDefault@NNxMLP_FeatureImportance_CV(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNxMLP_FeatureImportanceAcrossMeasures_CV.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_FeatureImportanceAcrossMeasures_CV.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNFICV.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNFICV.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportanceAcrossMeasures_CV, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%  DEFAULT = NNFICV.GETPROPDEFAULTCONDITIONED(NNxMLP_FeatureImportanceAcrossMeasures_CV, POINTER) returns the conditioned default value of POINTER of NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNFICV) and Element.GETPROPDEFAULTCONDITIONED('NNxMLP_FeatureImportanceAcrossMeasures_CV')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNxMLP_FeatureImportanceAcrossMeasures_CV.getPropProp(pointer);
			
			prop_default = NNxMLP_FeatureImportanceAcrossMeasures_CV.conditioning(prop, NNxMLP_FeatureImportanceAcrossMeasures_CV.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNxMLP_FeatureImportanceAcrossMeasures_CV, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%  CHECK = NNFICV.CHECKPROP(NNxMLP_FeatureImportanceAcrossMeasures_CV, PROP, VALUE) checks VALUE format for PROP of NNxMLP_FeatureImportanceAcrossMeasures_CV.
			% 
			% NNFICV.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNxMLP_FeatureImportanceAcrossMeasures_CV:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNFICV.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNFICV.
			%   Error id: €BRAPH2.STR€:NNxMLP_FeatureImportanceAcrossMeasures_CV:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNxMLP_FeatureImportanceAcrossMeasures_CV, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%   Error id: €BRAPH2.STR€:NNxMLP_FeatureImportanceAcrossMeasures_CV:€BRAPH2.WRONG_INPUT€
			%  NNFICV.CHECKPROP(NNxMLP_FeatureImportanceAcrossMeasures_CV, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_FeatureImportanceAcrossMeasures_CV.
			%   Error id: €BRAPH2.STR€:NNxMLP_FeatureImportanceAcrossMeasures_CV:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(NNFICV) and Element.CHECKPROP('NNxMLP_FeatureImportanceAcrossMeasures_CV')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNxMLP_FeatureImportanceAcrossMeasures_CV.getPropProp(pointer);
			
			switch prop
				case NNxMLP_FeatureImportanceAcrossMeasures_CV.TEMPLATE % __NNxMLP_FeatureImportanceAcrossMeasures_CV.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNxMLP_FeatureImportanceAcrossMeasures_CV.getPropSettings(prop));
				otherwise
					if prop <= NNxMLP_FeatureImportance_CV.getPropNumber()
						check = checkProp@NNxMLP_FeatureImportance_CV(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceAcrossMeasures_CV:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_FeatureImportanceAcrossMeasures_CV:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNxMLP_FeatureImportanceAcrossMeasures_CV.getPropTag(prop) ' (' NNxMLP_FeatureImportanceAcrossMeasures_CV.getFormatTag(NNxMLP_FeatureImportanceAcrossMeasures_CV.getPropFormat(prop)) ').'] ...
					)
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
				case NNxMLP_FeatureImportanceAcrossMeasures_CV.AV_FEATURE_IMPORTANCE % __NNxMLP_FeatureImportanceAcrossMeasures_CV.AV_FEATURE_IMPORTANCE__
					fi_list = nnficv.get('FI_LIST');
					m_list = fi_list{1}.get('D').get('DP_DICT').get('IT', 1).get('M_LIST');
					pr = PanelPropCell('EL', nnficv, 'PROP', NNxMLP_FeatureImportanceAcrossMeasures_CV.AV_FEATURE_IMPORTANCE, ...
					    'TABLE_HEIGHT', s(40), ...
					    'ROWNAME', {}, ...
					    'COLUMNNAME', m_list, ...
					    varargin{:});
					
				case NNxMLP_FeatureImportanceAcrossMeasures_CV.FEATURE_IMPORTANCE_FOLDS % __NNxMLP_FeatureImportanceAcrossMeasures_CV.FEATURE_IMPORTANCE_FOLDS__
					fi_list = nnficv.get('FI_LIST');
					m_list = fi_list{1}.get('D').get('DP_DICT').get('IT', 1).get('M_LIST');
					pr = PanelPropCell('EL', nnficv, 'PROP', NNxMLP_FeatureImportanceAcrossMeasures_CV.AV_FEATURE_IMPORTANCE, ...
					    'TABLE_HEIGHT', s(40), ...
					    'ROWNAME', {}, ...
					    'COLUMNNAME', m_list, ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@NNxMLP_FeatureImportance_CV(nnficv, prop, varargin{:});
					
			end
		end
	end
end
