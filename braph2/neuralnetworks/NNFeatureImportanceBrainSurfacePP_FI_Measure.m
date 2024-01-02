classdef NNFeatureImportanceBrainSurfacePP_FI_Measure < PanelProp
	%NNFeatureImportanceBrainSurfacePP_FI_Measure plots the panel to manage the feature importance of a neural network analysis with graph measures.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A panel for feature importance of a neural network analysis with graph measures (NNFeatureImportanceBrainSurfacePP_FI_Measure) 
	%  plots the panel to select a measure, of which the feature importance will be 
	%  plotted, from a drop-down list.
	% It is supposed to be used with the property FEATURE_IMPORTANCE of 
	%  NNClassifierMLP_Evaluator, NNClassifierMLP_CrossValidation, NNRegressorMLP_Evaluator,
	%  and NNRegressorMLP_CrossValidation.
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Measure methods (constructor):
	%  NNFeatureImportanceBrainSurfacePP_FI_Measure - constructor
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Measure methods:
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
	% NNFeatureImportanceBrainSurfacePP_FI_Measure methods (display):
	%  tostring - string with information about the panel property feature importance
	%  disp - displays information about the panel property feature importance
	%  tree - displays the tree of the panel property feature importance
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Measure methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel property feature importance are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel property feature importance
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Measure methods (save/load, Static):
	%  save - saves BRAPH2 panel property feature importance as b2 file
	%  load - loads a BRAPH2 panel property feature importance from a b2 file
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Measure method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel property feature importance
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Measure method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel property feature importance
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Measure methods (inspection, Static):
	%  getClass - returns the class of the panel property feature importance
	%  getSubclasses - returns all subclasses of NNFeatureImportanceBrainSurfacePP_FI_Measure
	%  getProps - returns the property list of the panel property feature importance
	%  getPropNumber - returns the property number of the panel property feature importance
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
	% NNFeatureImportanceBrainSurfacePP_FI_Measure methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Measure methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Measure methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Measure methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNFeatureImportanceBrainSurfacePP_FI_Measure; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNFeatureImportanceBrainSurfacePP_FI_Measure constants</a>.
	%
	%
	% See also NNClassifierMLP_Evaluator, NNClassifierMLP_CrossValidation, NNRegressorMLP_Evaluator, NNRegressorMLP_CrossValidation..
	
	properties (Constant) % properties
		D = PanelProp.getPropNumber() + 1;
		D_TAG = 'D';
		D_CATEGORY = Category.METADATA;
		D_FORMAT = Format.ITEM;
		
		ENABLE = PanelProp.getPropNumber() + 2;
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = Category.GUI;
		ENABLE_FORMAT = Format.OPTION;
		
		ROWNAME = PanelProp.getPropNumber() + 3;
		ROWNAME_TAG = 'ROWNAME';
		ROWNAME_CATEGORY = Category.GUI;
		ROWNAME_FORMAT = Format.STRINGLIST;
		
		COLUMNNAME = PanelProp.getPropNumber() + 4;
		COLUMNNAME_TAG = 'COLUMNNAME';
		COLUMNNAME_CATEGORY = Category.GUI;
		COLUMNNAME_FORMAT = Format.STRINGLIST;
		
		MENU_EXPORT = PanelProp.getPropNumber() + 5;
		MENU_EXPORT_TAG = 'MENU_EXPORT';
		MENU_EXPORT_CATEGORY = Category.GUI;
		MENU_EXPORT_FORMAT = Format.LOGICAL;
		
		TABLE_HEIGHT = PanelProp.getPropNumber() + 6;
		TABLE_HEIGHT_TAG = 'TABLE_HEIGHT';
		TABLE_HEIGHT_CATEGORY = Category.GUI;
		TABLE_HEIGHT_FORMAT = Format.SIZE;
		
		SELECTED = PanelProp.getPropNumber() + 7;
		SELECTED_TAG = 'SELECTED';
		SELECTED_CATEGORY = Category.GUI;
		SELECTED_FORMAT = Format.CVECTOR;
		
		TABLE = PanelProp.getPropNumber() + 8;
		TABLE_TAG = 'TABLE';
		TABLE_CATEGORY = Category.EVANESCENT;
		TABLE_FORMAT = Format.HANDLE;
		
		CONTEXTMENU = PanelProp.getPropNumber() + 9;
		CONTEXTMENU_TAG = 'CONTEXTMENU';
		CONTEXTMENU_CATEGORY = Category.EVANESCENT;
		CONTEXTMENU_FORMAT = Format.HANDLE;
		
		GUI_B_DICT = PanelProp.getPropNumber() + 10;
		GUI_B_DICT_TAG = 'GUI_B_DICT';
		GUI_B_DICT_CATEGORY = Category.GUI;
		GUI_B_DICT_FORMAT = Format.IDICT;
	end
	methods % constructor
		function pr = NNFeatureImportanceBrainSurfacePP_FI_Measure(varargin)
			%NNFeatureImportanceBrainSurfacePP_FI_Measure() creates a panel property feature importance.
			%
			% NNFeatureImportanceBrainSurfacePP_FI_Measure(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNFeatureImportanceBrainSurfacePP_FI_Measure(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pr = pr@PanelProp(varargin{:});
		end
	end
	methods (Static) % inspection
		function pr_class = getClass()
			%GETCLASS returns the class of the panel property feature importance.
			%
			% CLASS = NNFeatureImportanceBrainSurfacePP_FI_Measure.GETCLASS() returns the class 'NNFeatureImportanceBrainSurfacePP_FI_Measure'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the panel property feature importance PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('NNFeatureImportanceBrainSurfacePP_FI_Measure') returns 'NNFeatureImportanceBrainSurfacePP_FI_Measure'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('NNFeatureImportanceBrainSurfacePP_FI_Measure')
			%  are less computationally efficient.
			
			pr_class = 'NNFeatureImportanceBrainSurfacePP_FI_Measure';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel property feature importance.
			%
			% LIST = NNFeatureImportanceBrainSurfacePP_FI_Measure.GETSUBCLASSES() returns all subclasses of 'NNFeatureImportanceBrainSurfacePP_FI_Measure'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the panel property feature importance PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('NNFeatureImportanceBrainSurfacePP_FI_Measure') returns all subclasses of 'NNFeatureImportanceBrainSurfacePP_FI_Measure'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('NNFeatureImportanceBrainSurfacePP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNFeatureImportanceBrainSurfacePP_FI_Measure', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel property feature importance.
			%
			% PROPS = NNFeatureImportanceBrainSurfacePP_FI_Measure.GETPROPS() returns the property list of panel property feature importance
			%  as a row vector.
			%
			% PROPS = NNFeatureImportanceBrainSurfacePP_FI_Measure.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the panel property feature importance PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('NNFeatureImportanceBrainSurfacePP_FI_Measure'[, CATEGORY]) returns the property list of 'NNFeatureImportanceBrainSurfacePP_FI_Measure'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('NNFeatureImportanceBrainSurfacePP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						NNFeatureImportanceBrainSurfacePP_FI_Measure.D ...
						NNFeatureImportanceBrainSurfacePP_FI_Measure.ENABLE ...
						NNFeatureImportanceBrainSurfacePP_FI_Measure.ROWNAME ...
						NNFeatureImportanceBrainSurfacePP_FI_Measure.COLUMNNAME ...
						NNFeatureImportanceBrainSurfacePP_FI_Measure.MENU_EXPORT ...
						NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE_HEIGHT ...
						NNFeatureImportanceBrainSurfacePP_FI_Measure.SELECTED ...
						NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE ...
						NNFeatureImportanceBrainSurfacePP_FI_Measure.CONTEXTMENU ...
						NNFeatureImportanceBrainSurfacePP_FI_Measure.GUI_B_DICT ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						PanelProp.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						PanelProp.getProps(Category.METADATA) ...
						NNFeatureImportanceBrainSurfacePP_FI_Measure.D ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						PanelProp.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						PanelProp.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						PanelProp.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						PanelProp.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelProp.getProps(Category.EVANESCENT) ...
						NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE ...
						NNFeatureImportanceBrainSurfacePP_FI_Measure.CONTEXTMENU ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						NNFeatureImportanceBrainSurfacePP_FI_Measure.ENABLE ...
						NNFeatureImportanceBrainSurfacePP_FI_Measure.ROWNAME ...
						NNFeatureImportanceBrainSurfacePP_FI_Measure.COLUMNNAME ...
						NNFeatureImportanceBrainSurfacePP_FI_Measure.MENU_EXPORT ...
						NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE_HEIGHT ...
						NNFeatureImportanceBrainSurfacePP_FI_Measure.SELECTED ...
						NNFeatureImportanceBrainSurfacePP_FI_Measure.GUI_B_DICT ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel property feature importance.
			%
			% N = NNFeatureImportanceBrainSurfacePP_FI_Measure.GETPROPNUMBER() returns the property number of panel property feature importance.
			%
			% N = NNFeatureImportanceBrainSurfacePP_FI_Measure.GETPROPNUMBER(CATEGORY) returns the property number of panel property feature importance
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the panel property feature importance PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('NNFeatureImportanceBrainSurfacePP_FI_Measure') returns the property number of 'NNFeatureImportanceBrainSurfacePP_FI_Measure'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('NNFeatureImportanceBrainSurfacePP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNFeatureImportanceBrainSurfacePP_FI_Measure.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel property feature importance/error.
			%
			% CHECK = NNFeatureImportanceBrainSurfacePP_FI_Measure.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(NNFeatureImportanceBrainSurfacePP_FI_Measure, PROP) checks whether PROP exists for NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Measure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Measure:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Measure:WrongInput]
			%  Element.EXISTSPROP(NNFeatureImportanceBrainSurfacePP_FI_Measure, PROP) throws error if PROP does NOT exist for NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Measure:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('NNFeatureImportanceBrainSurfacePP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNFeatureImportanceBrainSurfacePP_FI_Measure.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurfacePP_FI_Measure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurfacePP_FI_Measure:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNFeatureImportanceBrainSurfacePP_FI_Measure.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel property feature importance/error.
			%
			% CHECK = NNFeatureImportanceBrainSurfacePP_FI_Measure.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(NNFeatureImportanceBrainSurfacePP_FI_Measure, TAG) checks whether TAG exists for NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Measure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Measure:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Measure:WrongInput]
			%  Element.EXISTSTAG(NNFeatureImportanceBrainSurfacePP_FI_Measure, TAG) throws error if TAG does NOT exist for NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Measure:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('NNFeatureImportanceBrainSurfacePP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnfeatureimportancebrainsurfacepp_fi_measure_tag_list = cellfun(@(x) NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropTag(x), num2cell(NNFeatureImportanceBrainSurfacePP_FI_Measure.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnfeatureimportancebrainsurfacepp_fi_measure_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurfacePP_FI_Measure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurfacePP_FI_Measure:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNFeatureImportanceBrainSurfacePP_FI_Measure.'] ...
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
			%  PROPERTY = PR.GETPROPPROP(POINTER) returns property number of POINTER of PR.
			%  PROPERTY = Element.GETPROPPROP(NNFeatureImportanceBrainSurfacePP_FI_Measure, POINTER) returns property number of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%  PROPERTY = PR.GETPROPPROP(NNFeatureImportanceBrainSurfacePP_FI_Measure, POINTER) returns property number of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('NNFeatureImportanceBrainSurfacePP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnfeatureimportancebrainsurfacepp_fi_measure_tag_list = cellfun(@(x) NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropTag(x), num2cell(NNFeatureImportanceBrainSurfacePP_FI_Measure.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnfeatureimportancebrainsurfacepp_fi_measure_tag_list)); % tag = pointer
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
			%  TAG = PR.GETPROPTAG(POINTER) returns tag of POINTER of PR.
			%  TAG = Element.GETPROPTAG(NNFeatureImportanceBrainSurfacePP_FI_Measure, POINTER) returns tag of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%  TAG = PR.GETPROPTAG(NNFeatureImportanceBrainSurfacePP_FI_Measure, POINTER) returns tag of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('NNFeatureImportanceBrainSurfacePP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNFeatureImportanceBrainSurfacePP_FI_Measure.D
						tag = NNFeatureImportanceBrainSurfacePP_FI_Measure.D_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Measure.ENABLE
						tag = NNFeatureImportanceBrainSurfacePP_FI_Measure.ENABLE_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Measure.ROWNAME
						tag = NNFeatureImportanceBrainSurfacePP_FI_Measure.ROWNAME_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Measure.COLUMNNAME
						tag = NNFeatureImportanceBrainSurfacePP_FI_Measure.COLUMNNAME_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Measure.MENU_EXPORT
						tag = NNFeatureImportanceBrainSurfacePP_FI_Measure.MENU_EXPORT_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE_HEIGHT
						tag = NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE_HEIGHT_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Measure.SELECTED
						tag = NNFeatureImportanceBrainSurfacePP_FI_Measure.SELECTED_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE
						tag = NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Measure.CONTEXTMENU
						tag = NNFeatureImportanceBrainSurfacePP_FI_Measure.CONTEXTMENU_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Measure.GUI_B_DICT
						tag = NNFeatureImportanceBrainSurfacePP_FI_Measure.GUI_B_DICT_TAG;
					otherwise
						tag = getPropTag@PanelProp(prop);
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
			%  CATEGORY = PR.GETPROPCATEGORY(POINTER) returns category of POINTER of PR.
			%  CATEGORY = Element.GETPROPCATEGORY(NNFeatureImportanceBrainSurfacePP_FI_Measure, POINTER) returns category of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%  CATEGORY = PR.GETPROPCATEGORY(NNFeatureImportanceBrainSurfacePP_FI_Measure, POINTER) returns category of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('NNFeatureImportanceBrainSurfacePP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropProp(pointer);
			
			switch prop
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.D
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Measure.D_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.ENABLE
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Measure.ENABLE_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.ROWNAME
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Measure.ROWNAME_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.COLUMNNAME
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Measure.COLUMNNAME_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.MENU_EXPORT
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Measure.MENU_EXPORT_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE_HEIGHT
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE_HEIGHT_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.SELECTED
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Measure.SELECTED_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.CONTEXTMENU
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Measure.CONTEXTMENU_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.GUI_B_DICT
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Measure.GUI_B_DICT_CATEGORY;
				otherwise
					prop_category = getPropCategory@PanelProp(prop);
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
			%  FORMAT = PR.GETPROPFORMAT(POINTER) returns format of POINTER of PR.
			%  FORMAT = Element.GETPROPFORMAT(NNFeatureImportanceBrainSurfacePP_FI_Measure, POINTER) returns format of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%  FORMAT = PR.GETPROPFORMAT(NNFeatureImportanceBrainSurfacePP_FI_Measure, POINTER) returns format of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('NNFeatureImportanceBrainSurfacePP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropProp(pointer);
			
			switch prop
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.D
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Measure.D_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.ENABLE
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Measure.ENABLE_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.ROWNAME
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Measure.ROWNAME_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.COLUMNNAME
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Measure.COLUMNNAME_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.MENU_EXPORT
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Measure.MENU_EXPORT_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE_HEIGHT
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE_HEIGHT_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.SELECTED
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Measure.SELECTED_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.CONTEXTMENU
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Measure.CONTEXTMENU_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.GUI_B_DICT
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Measure.GUI_B_DICT_FORMAT;
				otherwise
					prop_format = getPropFormat@PanelProp(prop);
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
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PR.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNFeatureImportanceBrainSurfacePP_FI_Measure, POINTER) returns description of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(NNFeatureImportanceBrainSurfacePP_FI_Measure, POINTER) returns description of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('NNFeatureImportanceBrainSurfacePP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropProp(pointer);
			
			switch prop
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.D
					prop_description = 'D (metadata, item) is the input dataset.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.ENABLE
					prop_description = 'ENABLE (gui, option) switches table between on and off.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.ROWNAME
					prop_description = 'ROWNAME (gui, stringlist) determines the table row names.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.COLUMNNAME
					prop_description = 'COLUMNNAME (gui, stringlist) determines the table column names.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.MENU_EXPORT
					prop_description = 'MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE_HEIGHT
					prop_description = 'TABLE_HEIGHT (gui, size) is the pixel height of the prop panel when the table is shown.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.SELECTED
					prop_description = 'SELECTED (gui, cvector) is the list of selected items.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE
					prop_description = 'TABLE (evanescent, handle) is the table.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.CONTEXTMENU
					prop_description = 'CONTEXTMENU (evanescent, handle) is the context menu.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.GUI_B_DICT
					prop_description = 'GUI_B_DICT (gui, idict) contains the GUIs for the brain measures.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the panel for feature importance.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.NAME
					prop_description = 'NAME (constant, string) is the name of the panel for feature importance.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel for feature importance.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel for feature importance.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel for feature importance.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel for feature importance.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel for feature importance.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.EL
					prop_description = 'EL (data, item) is the element.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.PROP
					prop_description = 'PROP (data, scalar) is the prop number.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the prop panel.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the table.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.SHOW
					prop_description = 'SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.HIDE
					prop_description = 'HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.CLOSE
					prop_description = 'CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figures.';
				otherwise
					prop_description = getPropDescription@PanelProp(prop);
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
			%  SETTINGS = PR.GETPROPSETTINGS(POINTER) returns settings of POINTER of PR.
			%  SETTINGS = Element.GETPROPSETTINGS(NNFeatureImportanceBrainSurfacePP_FI_Measure, POINTER) returns settings of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%  SETTINGS = PR.GETPROPSETTINGS(NNFeatureImportanceBrainSurfacePP_FI_Measure, POINTER) returns settings of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('NNFeatureImportanceBrainSurfacePP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropProp(pointer);
			
			switch prop
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.D
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.ENABLE
					prop_settings = {'on', 'off'};
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.ROWNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.COLUMNNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.MENU_EXPORT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.SELECTED
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.CONTEXTMENU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.GUI_B_DICT
					prop_settings = 'GUIFig';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.TEMPLATE
					prop_settings = 'NNFeatureImportanceBrainSurfacePP_FI_Measure';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNFeatureImportanceBrainSurfacePP_FI_Measure.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNFeatureImportanceBrainSurfacePP_FI_Measure.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(NNFeatureImportanceBrainSurfacePP_FI_Measure, POINTER) returns the default value of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%  DEFAULT = PR.GETPROPDEFAULT(NNFeatureImportanceBrainSurfacePP_FI_Measure, POINTER) returns the default value of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('NNFeatureImportanceBrainSurfacePP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropProp(pointer);
			
			switch prop
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.D
					prop_default = NNDataset();
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.ENABLE
					prop_default = 'on';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.ROWNAME
					prop_default = {'numbered'};
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.COLUMNNAME
					prop_default = {'numbered'};
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.MENU_EXPORT
					prop_default = true;
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE_HEIGHT
					prop_default = s(20);
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.SELECTED
					prop_default = Format.getFormatDefault(Format.CVECTOR, NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE
					prop_default = Format.getFormatDefault(Format.HANDLE, NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.CONTEXTMENU
					prop_default = Format.getFormatDefault(Format.HANDLE, NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.GUI_B_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.ELCLASS
					prop_default = 'NNFeatureImportanceBrainSurfacePP_FI_Measure';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.NAME
					prop_default = 'A Panel for Feature Importance of a Neural Network Analysis';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.DESCRIPTION
					prop_default = 'A panel for feature importance of a neural network analysis with graph measures (NNFeatureImportanceBrainSurfacePP_FI_Measure) plots the panel to select a measure, of which the feature importance will be plotted, from a drop-down list. It is supposed to be used with the property FEATURE_IMPORTANCE of NNClassifierMLP_Evaluator, NNClassifierMLP_CrossValidation, NNRegressorMLP_Evaluator, and NNRegressorMLP_CrossValidation.';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.ID
					prop_default = 'NNFeatureImportanceBrainSurfacePP_FI_Measure ID';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.LABEL
					prop_default = 'NNFeatureImportanceBrainSurfacePP_FI_Measure label';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.NOTES
					prop_default = 'NNFeatureImportanceBrainSurfacePP_FI_Measure notes';
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.EL
					prop_default = NNFeatureImportanceBrainSurface();
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.PROP
					prop_default = NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNFeatureImportanceBrainSurfacePP_FI_Measure.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNFeatureImportanceBrainSurfacePP_FI_Measure.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNFeatureImportanceBrainSurfacePP_FI_Measure, POINTER) returns the conditioned default value of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(NNFeatureImportanceBrainSurfacePP_FI_Measure, POINTER) returns the conditioned default value of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('NNFeatureImportanceBrainSurfacePP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropProp(pointer);
			
			prop_default = NNFeatureImportanceBrainSurfacePP_FI_Measure.conditioning(prop, NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropDefault(prop));
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			%CONDITIONING conditions a value before setting a property.
			%
			% VALUE = CONDITIONING(EL, PROP, VALUE) conditions the value VALUE before
			%  it is set as the value of the property PROP.
			%  By default, this function does not do anything, so it should be
			%  implemented in the subclasses of Element when needed.
			%
			% Conditioning is only used for props of Category.METADATA,
			%  Category.PARAMETER, Category.DATA, Category.FIGURE and Category.GUI.
			%
			% See also preset, checkProp, postset, postprocessing, calculateValue,
			%  checkValue.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropProp(pointer);
			
			switch prop
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.SELECTED % __NNFeatureImportanceBrainSurfacePP_FI_Measure.SELECTED__
					if isrow(value)
					    value = value';
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = conditioning@PanelProp(pointer, value);
					end
			end
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PR.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PR.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PR.
			%  CHECK = Element.CHECKPROP(NNFeatureImportanceBrainSurfacePP_FI_Measure, PROP, VALUE) checks VALUE format for PROP of NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%  CHECK = PR.CHECKPROP(NNFeatureImportanceBrainSurfacePP_FI_Measure, PROP, VALUE) checks VALUE format for PROP of NNFeatureImportanceBrainSurfacePP_FI_Measure.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNFeatureImportanceBrainSurfacePP_FI_Measure:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:NNFeatureImportanceBrainSurfacePP_FI_Measure:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNFeatureImportanceBrainSurfacePP_FI_Measure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%   Error id: €BRAPH2.STR€:NNFeatureImportanceBrainSurfacePP_FI_Measure:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(NNFeatureImportanceBrainSurfacePP_FI_Measure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNFeatureImportanceBrainSurfacePP_FI_Measure.
			%   Error id: €BRAPH2.STR€:NNFeatureImportanceBrainSurfacePP_FI_Measure:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('NNFeatureImportanceBrainSurfacePP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropProp(pointer);
			
			switch prop
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.D % __NNFeatureImportanceBrainSurfacePP_FI_Measure.D__
					check = Format.checkFormat(Format.ITEM, value, NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.ENABLE % __NNFeatureImportanceBrainSurfacePP_FI_Measure.ENABLE__
					check = Format.checkFormat(Format.OPTION, value, NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.ROWNAME % __NNFeatureImportanceBrainSurfacePP_FI_Measure.ROWNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.COLUMNNAME % __NNFeatureImportanceBrainSurfacePP_FI_Measure.COLUMNNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.MENU_EXPORT % __NNFeatureImportanceBrainSurfacePP_FI_Measure.MENU_EXPORT__
					check = Format.checkFormat(Format.LOGICAL, value, NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE_HEIGHT % __NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE_HEIGHT__
					check = Format.checkFormat(Format.SIZE, value, NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.SELECTED % __NNFeatureImportanceBrainSurfacePP_FI_Measure.SELECTED__
					check = Format.checkFormat(Format.CVECTOR, value, NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE % __NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE__
					check = Format.checkFormat(Format.HANDLE, value, NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.CONTEXTMENU % __NNFeatureImportanceBrainSurfacePP_FI_Measure.CONTEXTMENU__
					check = Format.checkFormat(Format.HANDLE, value, NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.GUI_B_DICT % __NNFeatureImportanceBrainSurfacePP_FI_Measure.GUI_B_DICT__
					check = Format.checkFormat(Format.IDICT, value, NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.TEMPLATE % __NNFeatureImportanceBrainSurfacePP_FI_Measure.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurfacePP_FI_Measure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurfacePP_FI_Measure:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropTag(prop) ' (' NNFeatureImportanceBrainSurfacePP_FI_Measure.getFormatTag(NNFeatureImportanceBrainSurfacePP_FI_Measure.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(pr, prop)
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
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.ROWNAME % __NNFeatureImportanceBrainSurfacePP_FI_Measure.ROWNAME__
					if pr.get('DRAWN')
					    pr.get('UPDATE')
					end
					
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.COLUMNNAME % __NNFeatureImportanceBrainSurfacePP_FI_Measure.COLUMNNAME__
					if pr.get('DRAWN')
					    pr.get('UPDATE')
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						postset@PanelProp(pr, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pr, prop, varargin)
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
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE % __NNFeatureImportanceBrainSurfacePP_FI_Measure.TABLE__
					table = uitable( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'table', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'ColumnSortable', true, ...
					    'ColumnName', {'', 'Measure', 'Shape', 'Scope', 'Notes'}, ...
					    'ColumnFormat', {'logical',  'char', 'char', 'char', 'char'}, ...
					    'ColumnWidth', {30, 'auto', 'auto', 'auto', 'auto'}, ...
					    'ColumnEditable', [true false false false false], ...
					    'CellEditCallback', {@cb_table} ...
					    );
					value = table;
					
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.CONTEXTMENU % __NNFeatureImportanceBrainSurfacePP_FI_Measure.CONTEXTMENU__
					contextmenu = uicontextmenu( ...
					    'Parent', ancestor(pr.get('H'), 'figure'), ...
					    'Tag', 'CONTEXTMENU' ...
					    );
					menu_select_all = uimenu( ...
						'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_SELECT_ALL', ...
					    'Text', 'Select All Measures', ...
					    'MenuSelectedFcn', {@cb_select_all} ...
					    );
					menu_clear_selection = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_CLEAR_SELECTION', ...
					    'Text', 'Clear Selection', ...
					    'MenuSelectedFcn', {@cb_clear_selection} ...
					    );
					menu_invert_selection = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_INVERT_SELECTION', ...
					    'Text', 'Invert Selection', ...
					    'MenuSelectedFcn', {@cb_invert_selection} ...
					    );
					menu_open_elements = uimenu( ...
						'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_OPEN_ELEMENTS', ...
					    'Text', 'Plot Selected Measures on Brain ...', ...
					    'MenuSelectedFcn', {@cb_open_mbrain} ...
					    );
					menu_hide_elements = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_ELEMENTS', ...
					    'Text', 'Hide Selected Brain-Plots', ...
						'MenuSelectedFcn', {@cb_hide_mbrain} ...
					    );
					
					set(pr.get('TABLE'), 'ContextMenu', contextmenu)
					
					value = contextmenu;
					
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.X_DRAW % __NNFeatureImportanceBrainSurfacePP_FI_Measure.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					end
					
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.UPDATE % __NNFeatureImportanceBrainSurfacePP_FI_Measure.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    if isa(el.getr(prop), 'NoValue')
					        % don't plot anything for a result not yet calculated
					        pr.set('HEIGHT', pr.getPropDefault('HEIGHT'))
					        set(pr.get('TABLE'), 'Visible', 'off')
					    else
					        set_table()
					        pr.set('HEIGHT', pr.getPropDefault('HEIGHT') + pr.get('TABLE_HEIGHT'))
					        set(pr.get('TABLE'), 'Visible', 'on')
					    end
					end
					
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.REDRAW % __NNFeatureImportanceBrainSurfacePP_FI_Measure.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('TABLE'), 'Position', [s(.3) s(.3) w_p-s(.6) max(1, pr.get('HEIGHT')-s(2.2))])
					end
					
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.SHOW % __NNFeatureImportanceBrainSurfacePP_FI_Measure.SHOW__
					value = calculateValue@PanelProp(pr, PanelProp.SHOW, varargin{:}); % also warning
					if value
					    % figures for brain figure
					    gui_b_dict = pr.get('GUI_B_DICT');
					    for i = 1:1:gui_b_dict.get('LENGTH')
					        gui = gui_b_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('SHOW')
					        end
					    end
					end
					
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.HIDE % __NNFeatureImportanceBrainSurfacePP_FI_Measure.HIDE__
					value = calculateValue@PanelProp(pr, PanelProp.HIDE, varargin{:}); % also warning
					if value
					    % figures for brain figures
					    gui_b_dict = pr.get('GUI_B_DICT');
					    for i = 1:1:gui_b_dict.get('LENGTH')
					        gui = gui_b_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('HIDE')
					        end
					    end
					end
					
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.DELETE % __NNFeatureImportanceBrainSurfacePP_FI_Measure.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('TABLE', Element.getNoValue())
					    pr.set('CONTEXTMENU', Element.getNoValue())
					end
					
				case NNFeatureImportanceBrainSurfacePP_FI_Measure.CLOSE % __NNFeatureImportanceBrainSurfacePP_FI_Measure.CLOSE__
					value = calculateValue@PanelProp(pr, PanelProp.CLOSE, varargin{:}); % also warning
					if value
					    % figures for brain figures
					    gui_b_dict = pr.get('GUI_B_DICT');
					    for i = 1:1:gui_b_dict.get('LENGTH')
					        gui = gui_b_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('CLOSE')
					        end
					    end
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_table(~, event) % (src, event)
			    % only needs to update the selector
			    
			    i = event.Indices(1);
			    
			    selected = pr.get('SELECTED');
			    if event.NewData == 1
			        pr.set('SELECTED', sort(unique([selected; i])));
			    else
			        pr.set('SELECTED', selected(selected ~= i));
			    end
			    
			    pr.get('UPDATE')
			end
			function cb_select_all(~, ~) 
			    input_dataset = pr.get('D');
			    m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
			
			    pr.set('SELECTED', [1:1:length(m_list)])
			
			    pr.get('UPDATE')
			end
			function cb_clear_selection(~, ~) 
			    pr.set('SELECTED', [])
			
			    pr.get('UPDATE')
			end
			function cb_invert_selection(~, ~) 
			    input_dataset = pr.get('D');
			    m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
			
			    selected_tmp = [1:1:length(m_list)];
			    selected_tmp(pr.get('SELECTED')) = [];
			    pr.set('SELECTED', selected_tmp);
			
			    pr.get('UPDATE')
			end
			function cb_open_mbrain(~, ~)
			    input_dataset = pr.get('D');
			    m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
			
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI
			    N = ceil(sqrt(length(m_list))); % number of row and columns of figures
			
			    gui_b_dict = pr.memorize('GUI_B_DICT');
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			
			        measure = m_list{i}; % also key
			
                    el = pr.get('EL');
                    values = el.get('RESHAPED_FEATURE_IMPORTANCE');
			        value = values(i);
			
			        if ~gui_b_dict.get('CONTAINS_KEY', measure)
			
			            brain_atlas = el.get('BA'); 
			            %brain_atlas = ImporterBrainAtlasXLS('WAITBAR', false, 'FILE', [fileparts(which('braph2')) filesep() 'atlases' filesep() 'desikan_atlas.xlsx']).get('BA');
			            switch Element.getPropDefault(measure, 'SHAPE')
			                case Measure.GLOBAL % __Measure.GLOBAL__
			                    switch Element.getPropDefault(measure, 'SCOPE')
			                        case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
			                            mbfipf = NNFeatureImportanceBrainSurfacePF_FI_Measure_GS('FI', value, 'BA', brain_atlas);
			                        case Measure.UNILAYER % __Measure.UNILAYER__
			                            mbfipf = NNFeatureImportanceBrainSurfacePF_FI_Measure_GU('FI', value, 'BA', brain_atlas);
			                        case Measure.BILAYER % __Measure.BILAYER__
			                            mbfipf = NNFeatureImportanceBrainSurfacePF_FI_Measure_GB('FI', value, 'BA', brain_atlas);
			                    end
			                case Measure.NODAL % __Measure.NODAL__
			                    switch Element.getPropDefault(measure, 'SCOPE')
			                        case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
			                            mbfipf = NNFeatureImportanceBrainSurfacePF_FI_Measure_NS('FI', value, 'BA', brain_atlas);
			                        case Measure.UNILAYER % __Measure.UNILAYER__
			                            mbfipf = NNFeatureImportanceBrainSurfacePF_FI_Measure_NU('FI', value, 'BA', brain_atlas);
			                        case Measure.BILAYER % __Measure.BILAYER__
			                            mbfipf = NNFeatureImportanceBrainSurfacePF_FI_Measure_NB('FI', value, 'BA', brain_atlas);
			                    end
			                case Measure.BINODAL % __Measure.BINODAL__
			                    switch Element.getPropDefault(measure, 'SCOPE')
			                        case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
			                            mbfipf = NNFeatureImportanceBrainSurfacePF_FI_Measure_BS('FI', value, 'BA', brain_atlas);
			                        case Measure.UNILAYER % __Measure.UNILAYER__
			                            mbfipf = NNFeatureImportanceBrainSurfacePF_FI_Measure_BU('FI', value, 'BA', brain_atlas);
			                        case Measure.BILAYER % __Measure.BILAYER__
			                            mbfipf = NNFeatureImportanceBrainSurfacePF_FI_Measure_BB('FI', value, 'BA', brain_atlas);
			                    end
			            end
			
			            gui = GUIFig( ...
			                'ID', measure, ... % this is the dictionary key
			                'PF', mbfipf, ...
			                'POSITION', [ ...
			                x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ...
			                y0(f, 'normalized') ...
			                w(f, 'normalized') * 3 ...
			                .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ...
			                ], ...
			                'WAITBAR', pr.getCallback('WAITBAR'), ...
			                'CLOSEREQ', false ...
			                );
			            gui_b_dict.get('ADD', gui)
			        end
			
			        gui = gui_b_dict.get('IT', measure);
			        if ~gui.get('DRAWN')
			            gui.get('DRAW')
			        end
			        gui.get('SHOW')
			    end
			end
			function cb_hide_mbrain(~, ~)
			    % % % input_dataset = pr.get('D');
			    % % % m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
			    % % % 
			    % % % gui_b_dict = pr.memorize('GUI_B_DICT');
			    % % % 
			    % % % selected = pr.get('SELECTED');
			    % % % for s = 1:1:length(selected)
			    % % %     i = selected(s);
			    % % % 
			    % % %     measure = m_list{i}; % also key
			    % % % 
			    % % %     if gui_b_dict.get('CONTAINS_KEY', measure)
			    % % %         gui = gui_b_dict.get('IT', measure);
			    % % %         if gui.get('DRAWN')
			    % % %             gui.get('HIDE')
			    % % %         end
			    % % %     end
			    % % % end
			end
			function set_table()
			
			    input_dataset = pr.get('D');
			    m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
			    
			    rowname = cell(length(m_list), 1);
			    data = cell(length(m_list), 5);
			    for mi = 1:1:length(m_list)
			
			        if any(pr.get('SELECTED') == mi)
			            data{mi, 1} = true;
			        else
			            data{mi, 1} = false;
			        end
			
			        data{mi, 2} = eval([m_list{mi} '.getPropDefault(''NAME'')']);
			
			        if Element.getPropDefault(m_list{mi}, 'SHAPE') == Measure.NODAL
			            data{mi, 3} = 'NODAL';
			        elseif Element.getPropDefault(m_list{mi}, 'SHAPE') == Measure.GLOBAL
			            data{mi, 3} = 'GLOBAL';
			        elseif Element.getPropDefault(m_list{mi}, 'SHAPE') == Measure.BINODAL
			            data{mi, 3} = 'BINODAL';
			        end
			
			        if Element.getPropDefault(m_list{mi}, 'SCOPE') == Measure.SUPERGLOBAL
			            data{mi, 4} = 'SUPERGLOBAL';
			        elseif Element.getPropDefault(m_list{mi}, 'SCOPE') == Measure.UNILAYER
			            data{mi, 4} = 'UNILAYER';
			        elseif Element.getPropDefault(m_list{mi}, 'SCOPE') == Measure.BILAYER
			            data{mi, 4} = 'BILAYER';
			        end
			        
			        data{mi, 5} = eval([m_list{mi} '.getPropDefault(''DESCRIPTION'')']);
			    
			        set(pr.get('TABLE'), ...
			            'RowName', rowname, ...
			            'Data', data ...
			            )
			    
			        % style SELECTED
			        styles_row = find(pr.get('TABLE').StyleConfigurations.Target == 'row');
			        if ~isempty(styles_row)
			            removeStyle(pr.get('TABLE'), styles_row)
			        end
			        if ~isempty(pr.get('SELECTED'))
			            addStyle(pr.get('TABLE'), uistyle('FontWeight', 'bold'), 'row', pr.get('SELECTED'))
			        end
			    end
			end
		end
	end
end
