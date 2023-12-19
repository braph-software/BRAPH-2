classdef NNFeatureImportanceBrainSurfacePP_FI_Data < PanelProp
	%NNFeatureImportanceBrainSurfacePP_FI_Data plots the panel to manage the feature importance of a neural network analysis with the data of subjects.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A panel for feature importance of a neural network analysis with the data of subjects (NNFeatureImportanceBrainSurfacePP_FI_Data) 
	%  plots the panel to show the feature importance, matching the layer number and node number as of the subject data.
	% It is supposed to be used with the property FEATURE_IMPORTANCE of 
	%  NNClassifierMLP_Evaluator, NNClassifierMLP_CrossValidation, NNRegressorMLP_Evaluator,
	%  and NNRegressorMLP_CrossValidation.
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Data methods (constructor):
	%  NNFeatureImportanceBrainSurfacePP_FI_Data - constructor
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Data methods:
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
	% NNFeatureImportanceBrainSurfacePP_FI_Data methods (display):
	%  tostring - string with information about the panel property feature importance
	%  disp - displays information about the panel property feature importance
	%  tree - displays the tree of the panel property feature importance
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Data methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel property feature importance are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel property feature importance
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Data methods (save/load, Static):
	%  save - saves BRAPH2 panel property feature importance as b2 file
	%  load - loads a BRAPH2 panel property feature importance from a b2 file
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Data method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel property feature importance
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Data method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel property feature importance
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Data methods (inspection, Static):
	%  getClass - returns the class of the panel property feature importance
	%  getSubclasses - returns all subclasses of NNFeatureImportanceBrainSurfacePP_FI_Data
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
	% NNFeatureImportanceBrainSurfacePP_FI_Data methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Data methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Data methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNFeatureImportanceBrainSurfacePP_FI_Data methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNFeatureImportanceBrainSurfacePP_FI_Data; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNFeatureImportanceBrainSurfacePP_FI_Data constants</a>.
	%
	%
	% See also NNClassifierMLP_Evaluator, NNClassifierMLP_CrossValidation, NNRegressorMLP_Evaluator, NNRegressorMLP_CrossValidation..
	
	properties (Constant) % properties
		D = PanelProp.getPropNumber() + 1;
		D_TAG = 'D';
		D_CATEGORY = Category.METADATA;
		D_FORMAT = Format.ITEM;
		
		XSLIDERSHOW = PanelProp.getPropNumber() + 2;
		XSLIDERSHOW_TAG = 'XSLIDERSHOW';
		XSLIDERSHOW_CATEGORY = Category.GUI;
		XSLIDERSHOW_FORMAT = Format.LOGICAL;
		
		XSLIDERLABELS = PanelProp.getPropNumber() + 3;
		XSLIDERLABELS_TAG = 'XSLIDERLABELS';
		XSLIDERLABELS_CATEGORY = Category.GUI;
		XSLIDERLABELS_FORMAT = Format.STRINGLIST;
		
		XSLIDERHEIGHT = PanelProp.getPropNumber() + 4;
		XSLIDERHEIGHT_TAG = 'XSLIDERHEIGHT';
		XSLIDERHEIGHT_CATEGORY = Category.GUI;
		XSLIDERHEIGHT_FORMAT = Format.SIZE;
		
		XSLIDER = PanelProp.getPropNumber() + 5;
		XSLIDER_TAG = 'XSLIDER';
		XSLIDER_CATEGORY = Category.EVANESCENT;
		XSLIDER_FORMAT = Format.HANDLE;
		
		YSLIDERSHOW = PanelProp.getPropNumber() + 6;
		YSLIDERSHOW_TAG = 'YSLIDERSHOW';
		YSLIDERSHOW_CATEGORY = Category.GUI;
		YSLIDERSHOW_FORMAT = Format.LOGICAL;
		
		YSLIDERLABELS = PanelProp.getPropNumber() + 7;
		YSLIDERLABELS_TAG = 'YSLIDERLABELS';
		YSLIDERLABELS_CATEGORY = Category.GUI;
		YSLIDERLABELS_FORMAT = Format.STRINGLIST;
		
		YSLIDERWIDTH = PanelProp.getPropNumber() + 8;
		YSLIDERWIDTH_TAG = 'YSLIDERWIDTH';
		YSLIDERWIDTH_CATEGORY = Category.GUI;
		YSLIDERWIDTH_FORMAT = Format.SIZE;
		
		YSLIDER = PanelProp.getPropNumber() + 9;
		YSLIDER_TAG = 'YSLIDER';
		YSLIDER_CATEGORY = Category.EVANESCENT;
		YSLIDER_FORMAT = Format.HANDLE;
		
		XYSLIDERLOCK = PanelProp.getPropNumber() + 10;
		XYSLIDERLOCK_TAG = 'XYSLIDERLOCK';
		XYSLIDERLOCK_CATEGORY = Category.GUI;
		XYSLIDERLOCK_FORMAT = Format.LOGICAL;
		
		ENABLE = PanelProp.getPropNumber() + 11;
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = Category.GUI;
		ENABLE_FORMAT = Format.OPTION;
		
		ROWNAME = PanelProp.getPropNumber() + 12;
		ROWNAME_TAG = 'ROWNAME';
		ROWNAME_CATEGORY = Category.GUI;
		ROWNAME_FORMAT = Format.STRINGLIST;
		
		COLUMNNAME = PanelProp.getPropNumber() + 13;
		COLUMNNAME_TAG = 'COLUMNNAME';
		COLUMNNAME_CATEGORY = Category.GUI;
		COLUMNNAME_FORMAT = Format.STRINGLIST;
		
		MENU_EXPORT = PanelProp.getPropNumber() + 14;
		MENU_EXPORT_TAG = 'MENU_EXPORT';
		MENU_EXPORT_CATEGORY = Category.GUI;
		MENU_EXPORT_FORMAT = Format.LOGICAL;
		
		TABLE_HEIGHT = PanelProp.getPropNumber() + 15;
		TABLE_HEIGHT_TAG = 'TABLE_HEIGHT';
		TABLE_HEIGHT_CATEGORY = Category.GUI;
		TABLE_HEIGHT_FORMAT = Format.SIZE;
		
		TABLE = PanelProp.getPropNumber() + 16;
		TABLE_TAG = 'TABLE';
		TABLE_CATEGORY = Category.EVANESCENT;
		TABLE_FORMAT = Format.HANDLE;
		
		CONTEXTMENU = PanelProp.getPropNumber() + 17;
		CONTEXTMENU_TAG = 'CONTEXTMENU';
		CONTEXTMENU_CATEGORY = Category.EVANESCENT;
		CONTEXTMENU_FORMAT = Format.HANDLE;
		
		MAP_TO_CELL = PanelProp.getPropNumber() + 18;
		MAP_TO_CELL_TAG = 'MAP_TO_CELL';
		MAP_TO_CELL_CATEGORY = Category.QUERY;
		MAP_TO_CELL_FORMAT = Format.EMPTY;
	end
	methods % constructor
		function pr = NNFeatureImportanceBrainSurfacePP_FI_Data(varargin)
			%NNFeatureImportanceBrainSurfacePP_FI_Data() creates a panel property feature importance.
			%
			% NNFeatureImportanceBrainSurfacePP_FI_Data(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNFeatureImportanceBrainSurfacePP_FI_Data(TAG, VALUE, ...) with property TAG set to VALUE.
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
			% CLASS = NNFeatureImportanceBrainSurfacePP_FI_Data.GETCLASS() returns the class 'NNFeatureImportanceBrainSurfacePP_FI_Data'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the panel property feature importance PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('NNFeatureImportanceBrainSurfacePP_FI_Data') returns 'NNFeatureImportanceBrainSurfacePP_FI_Data'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('NNFeatureImportanceBrainSurfacePP_FI_Data')
			%  are less computationally efficient.
			
			pr_class = 'NNFeatureImportanceBrainSurfacePP_FI_Data';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel property feature importance.
			%
			% LIST = NNFeatureImportanceBrainSurfacePP_FI_Data.GETSUBCLASSES() returns all subclasses of 'NNFeatureImportanceBrainSurfacePP_FI_Data'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the panel property feature importance PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('NNFeatureImportanceBrainSurfacePP_FI_Data') returns all subclasses of 'NNFeatureImportanceBrainSurfacePP_FI_Data'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('NNFeatureImportanceBrainSurfacePP_FI_Data')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNFeatureImportanceBrainSurfacePP_FI_Data', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel property feature importance.
			%
			% PROPS = NNFeatureImportanceBrainSurfacePP_FI_Data.GETPROPS() returns the property list of panel property feature importance
			%  as a row vector.
			%
			% PROPS = NNFeatureImportanceBrainSurfacePP_FI_Data.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the panel property feature importance PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('NNFeatureImportanceBrainSurfacePP_FI_Data'[, CATEGORY]) returns the property list of 'NNFeatureImportanceBrainSurfacePP_FI_Data'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('NNFeatureImportanceBrainSurfacePP_FI_Data')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.D ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERSHOW ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERLABELS ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERHEIGHT ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDER ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERSHOW ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERLABELS ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERWIDTH ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDER ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.XYSLIDERLOCK ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.ENABLE ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.ROWNAME ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.COLUMNNAME ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.MENU_EXPORT ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE_HEIGHT ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.CONTEXTMENU ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.MAP_TO_CELL ...
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
						NNFeatureImportanceBrainSurfacePP_FI_Data.D ...
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
						NNFeatureImportanceBrainSurfacePP_FI_Data.MAP_TO_CELL ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelProp.getProps(Category.EVANESCENT) ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDER ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDER ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.CONTEXTMENU ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERSHOW ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERLABELS ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERHEIGHT ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERSHOW ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERLABELS ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERWIDTH ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.XYSLIDERLOCK ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.ENABLE ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.ROWNAME ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.COLUMNNAME ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.MENU_EXPORT ...
						NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE_HEIGHT ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel property feature importance.
			%
			% N = NNFeatureImportanceBrainSurfacePP_FI_Data.GETPROPNUMBER() returns the property number of panel property feature importance.
			%
			% N = NNFeatureImportanceBrainSurfacePP_FI_Data.GETPROPNUMBER(CATEGORY) returns the property number of panel property feature importance
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the panel property feature importance PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('NNFeatureImportanceBrainSurfacePP_FI_Data') returns the property number of 'NNFeatureImportanceBrainSurfacePP_FI_Data'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('NNFeatureImportanceBrainSurfacePP_FI_Data')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNFeatureImportanceBrainSurfacePP_FI_Data.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel property feature importance/error.
			%
			% CHECK = NNFeatureImportanceBrainSurfacePP_FI_Data.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(NNFeatureImportanceBrainSurfacePP_FI_Data, PROP) checks whether PROP exists for NNFeatureImportanceBrainSurfacePP_FI_Data.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Data:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Data:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Data:WrongInput]
			%  Element.EXISTSPROP(NNFeatureImportanceBrainSurfacePP_FI_Data, PROP) throws error if PROP does NOT exist for NNFeatureImportanceBrainSurfacePP_FI_Data.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Data:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('NNFeatureImportanceBrainSurfacePP_FI_Data')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNFeatureImportanceBrainSurfacePP_FI_Data.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurfacePP_FI_Data:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurfacePP_FI_Data:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNFeatureImportanceBrainSurfacePP_FI_Data.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel property feature importance/error.
			%
			% CHECK = NNFeatureImportanceBrainSurfacePP_FI_Data.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(NNFeatureImportanceBrainSurfacePP_FI_Data, TAG) checks whether TAG exists for NNFeatureImportanceBrainSurfacePP_FI_Data.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Data:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Data:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Data:WrongInput]
			%  Element.EXISTSTAG(NNFeatureImportanceBrainSurfacePP_FI_Data, TAG) throws error if TAG does NOT exist for NNFeatureImportanceBrainSurfacePP_FI_Data.
			%   Error id: [BRAPH2:NNFeatureImportanceBrainSurfacePP_FI_Data:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('NNFeatureImportanceBrainSurfacePP_FI_Data')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnfeatureimportancebrainsurfacepp_fi_data_tag_list = cellfun(@(x) NNFeatureImportanceBrainSurfacePP_FI_Data.getPropTag(x), num2cell(NNFeatureImportanceBrainSurfacePP_FI_Data.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnfeatureimportancebrainsurfacepp_fi_data_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurfacePP_FI_Data:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurfacePP_FI_Data:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNFeatureImportanceBrainSurfacePP_FI_Data.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNFeatureImportanceBrainSurfacePP_FI_Data, POINTER) returns property number of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Data.
			%  PROPERTY = PR.GETPROPPROP(NNFeatureImportanceBrainSurfacePP_FI_Data, POINTER) returns property number of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Data.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('NNFeatureImportanceBrainSurfacePP_FI_Data')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnfeatureimportancebrainsurfacepp_fi_data_tag_list = cellfun(@(x) NNFeatureImportanceBrainSurfacePP_FI_Data.getPropTag(x), num2cell(NNFeatureImportanceBrainSurfacePP_FI_Data.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnfeatureimportancebrainsurfacepp_fi_data_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(NNFeatureImportanceBrainSurfacePP_FI_Data, POINTER) returns tag of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Data.
			%  TAG = PR.GETPROPTAG(NNFeatureImportanceBrainSurfacePP_FI_Data, POINTER) returns tag of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Data.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('NNFeatureImportanceBrainSurfacePP_FI_Data')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNFeatureImportanceBrainSurfacePP_FI_Data.D
						tag = NNFeatureImportanceBrainSurfacePP_FI_Data.D_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERSHOW
						tag = NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERSHOW_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERLABELS
						tag = NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERLABELS_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERHEIGHT
						tag = NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERHEIGHT_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDER
						tag = NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDER_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERSHOW
						tag = NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERSHOW_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERLABELS
						tag = NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERLABELS_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERWIDTH
						tag = NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERWIDTH_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDER
						tag = NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDER_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Data.XYSLIDERLOCK
						tag = NNFeatureImportanceBrainSurfacePP_FI_Data.XYSLIDERLOCK_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Data.ENABLE
						tag = NNFeatureImportanceBrainSurfacePP_FI_Data.ENABLE_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Data.ROWNAME
						tag = NNFeatureImportanceBrainSurfacePP_FI_Data.ROWNAME_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Data.COLUMNNAME
						tag = NNFeatureImportanceBrainSurfacePP_FI_Data.COLUMNNAME_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Data.MENU_EXPORT
						tag = NNFeatureImportanceBrainSurfacePP_FI_Data.MENU_EXPORT_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE_HEIGHT
						tag = NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE_HEIGHT_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE
						tag = NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Data.CONTEXTMENU
						tag = NNFeatureImportanceBrainSurfacePP_FI_Data.CONTEXTMENU_TAG;
					case NNFeatureImportanceBrainSurfacePP_FI_Data.MAP_TO_CELL
						tag = NNFeatureImportanceBrainSurfacePP_FI_Data.MAP_TO_CELL_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNFeatureImportanceBrainSurfacePP_FI_Data, POINTER) returns category of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Data.
			%  CATEGORY = PR.GETPROPCATEGORY(NNFeatureImportanceBrainSurfacePP_FI_Data, POINTER) returns category of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Data.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('NNFeatureImportanceBrainSurfacePP_FI_Data')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Data.getPropProp(pointer);
			
			switch prop
				case NNFeatureImportanceBrainSurfacePP_FI_Data.D
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Data.D_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERSHOW
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERSHOW_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERLABELS
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERLABELS_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERHEIGHT
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERHEIGHT_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDER
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDER_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERSHOW
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERSHOW_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERLABELS
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERLABELS_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERWIDTH
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERWIDTH_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDER
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDER_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XYSLIDERLOCK
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Data.XYSLIDERLOCK_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.ENABLE
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Data.ENABLE_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.ROWNAME
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Data.ROWNAME_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.COLUMNNAME
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Data.COLUMNNAME_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.MENU_EXPORT
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Data.MENU_EXPORT_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE_HEIGHT
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE_HEIGHT_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.CONTEXTMENU
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Data.CONTEXTMENU_CATEGORY;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.MAP_TO_CELL
					prop_category = NNFeatureImportanceBrainSurfacePP_FI_Data.MAP_TO_CELL_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(NNFeatureImportanceBrainSurfacePP_FI_Data, POINTER) returns format of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Data.
			%  FORMAT = PR.GETPROPFORMAT(NNFeatureImportanceBrainSurfacePP_FI_Data, POINTER) returns format of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Data.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('NNFeatureImportanceBrainSurfacePP_FI_Data')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Data.getPropProp(pointer);
			
			switch prop
				case NNFeatureImportanceBrainSurfacePP_FI_Data.D
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Data.D_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERSHOW
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERSHOW_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERLABELS
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERLABELS_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERHEIGHT
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERHEIGHT_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDER
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDER_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERSHOW
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERSHOW_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERLABELS
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERLABELS_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERWIDTH
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERWIDTH_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDER
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDER_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XYSLIDERLOCK
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Data.XYSLIDERLOCK_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.ENABLE
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Data.ENABLE_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.ROWNAME
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Data.ROWNAME_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.COLUMNNAME
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Data.COLUMNNAME_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.MENU_EXPORT
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Data.MENU_EXPORT_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE_HEIGHT
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE_HEIGHT_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.CONTEXTMENU
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Data.CONTEXTMENU_FORMAT;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.MAP_TO_CELL
					prop_format = NNFeatureImportanceBrainSurfacePP_FI_Data.MAP_TO_CELL_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNFeatureImportanceBrainSurfacePP_FI_Data, POINTER) returns description of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Data.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(NNFeatureImportanceBrainSurfacePP_FI_Data, POINTER) returns description of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Data.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('NNFeatureImportanceBrainSurfacePP_FI_Data')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Data.getPropProp(pointer);
			
			switch prop
				case NNFeatureImportanceBrainSurfacePP_FI_Data.D
					prop_description = 'D (metadata, item) is the input dataset.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERSHOW
					prop_description = 'XSLIDERSHOW (gui, logical) determines whether to show the xslider.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERLABELS
					prop_description = 'XSLIDERLABELS (gui, stringlist) determines the xslider labels.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERHEIGHT
					prop_description = 'XSLIDERHEIGHT (gui, size) is the height below the xslider in font size units.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDER
					prop_description = 'XSLIDER (evanescent, handle) is the x-slider.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERSHOW
					prop_description = 'YSLIDERSHOW (gui, logical) determines whether to show the yslider.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERLABELS
					prop_description = 'YSLIDERLABELS (gui, stringlist) determines the yslider labels.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERWIDTH
					prop_description = 'YSLIDERWIDTH (gui, size) is the width to the right of the yslider in font size units.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDER
					prop_description = 'YSLIDER (evanescent, handle) is the y-slider.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XYSLIDERLOCK
					prop_description = 'XYSLIDERLOCK (gui, logical) determines whether the sliders are locked so that only the diagonal is shown.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.ENABLE
					prop_description = 'ENABLE (gui, option) switches table between on and off.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.ROWNAME
					prop_description = 'ROWNAME (gui, stringlist) determines the table row names.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.COLUMNNAME
					prop_description = 'COLUMNNAME (gui, stringlist) determines the table column names.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.MENU_EXPORT
					prop_description = 'MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE_HEIGHT
					prop_description = 'TABLE_HEIGHT (gui, size) is the pixel height of the prop panel when the table is shown.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE
					prop_description = 'TABLE (evanescent, handle) is the alpha value edit field.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.CONTEXTMENU
					prop_description = 'CONTEXTMENU (evanescent, handle) is the context menu.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.MAP_TO_CELL
					prop_description = 'MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the panel for feature importance.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.NAME
					prop_description = 'NAME (constant, string) is the name of the panel for feature importance.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel for feature importance.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel for feature importance.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel for feature importance.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel for feature importance.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel for feature importance.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.EL
					prop_description = 'EL (data, item) is the element.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.PROP
					prop_description = 'PROP (data, scalar) is the prop number.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the prop panel.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the table.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNFeatureImportanceBrainSurfacePP_FI_Data, POINTER) returns settings of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Data.
			%  SETTINGS = PR.GETPROPSETTINGS(NNFeatureImportanceBrainSurfacePP_FI_Data, POINTER) returns settings of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Data.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('NNFeatureImportanceBrainSurfacePP_FI_Data')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Data.getPropProp(pointer);
			
			switch prop
				case NNFeatureImportanceBrainSurfacePP_FI_Data.D
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERSHOW
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERLABELS
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERHEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDER
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERSHOW
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERLABELS
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERWIDTH
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDER
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XYSLIDERLOCK
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNFeatureImportanceBrainSurfacePP_FI_Data.ENABLE
					prop_settings = {'on', 'off'};
				case NNFeatureImportanceBrainSurfacePP_FI_Data.ROWNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNFeatureImportanceBrainSurfacePP_FI_Data.COLUMNNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNFeatureImportanceBrainSurfacePP_FI_Data.MENU_EXPORT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNFeatureImportanceBrainSurfacePP_FI_Data.CONTEXTMENU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNFeatureImportanceBrainSurfacePP_FI_Data.MAP_TO_CELL
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case NNFeatureImportanceBrainSurfacePP_FI_Data.TEMPLATE
					prop_settings = 'NNFeatureImportanceBrainSurfacePP_FI_Data';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNFeatureImportanceBrainSurfacePP_FI_Data.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNFeatureImportanceBrainSurfacePP_FI_Data.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(NNFeatureImportanceBrainSurfacePP_FI_Data, POINTER) returns the default value of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Data.
			%  DEFAULT = PR.GETPROPDEFAULT(NNFeatureImportanceBrainSurfacePP_FI_Data, POINTER) returns the default value of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Data.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('NNFeatureImportanceBrainSurfacePP_FI_Data')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Data.getPropProp(pointer);
			
			switch prop
				case NNFeatureImportanceBrainSurfacePP_FI_Data.D
					prop_default = NNDataset();
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERSHOW
					prop_default = true;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERLABELS
					prop_default = Format.getFormatDefault(Format.STRINGLIST, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERHEIGHT
					prop_default = s(3);
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDER
					prop_default = Format.getFormatDefault(Format.HANDLE, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERSHOW
					prop_default = true;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERLABELS
					prop_default = Format.getFormatDefault(Format.STRINGLIST, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERWIDTH
					prop_default = s(3);
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDER
					prop_default = Format.getFormatDefault(Format.HANDLE, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XYSLIDERLOCK
					prop_default = false;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.ENABLE
					prop_default = 'on';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.ROWNAME
					prop_default = {'numbered'};
				case NNFeatureImportanceBrainSurfacePP_FI_Data.COLUMNNAME
					prop_default = {'numbered'};
				case NNFeatureImportanceBrainSurfacePP_FI_Data.MENU_EXPORT
					prop_default = true;
				case NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE_HEIGHT
					prop_default = s(20);
				case NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE
					prop_default = Format.getFormatDefault(Format.HANDLE, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.CONTEXTMENU
					prop_default = Format.getFormatDefault(Format.HANDLE, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.MAP_TO_CELL
					prop_default = Format.getFormatDefault(Format.EMPTY, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.ELCLASS
					prop_default = 'NNFeatureImportanceBrainSurfacePP_FI_Data';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.NAME
					prop_default = 'A Panel for Feature Importance of a Neural Network Analysis';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.DESCRIPTION
					prop_default = 'A panel for feature importance of a neural network analysis with the data of subjects (NNFeatureImportanceBrainSurfacePP_FI_Data) plots the panel to show the feature importance, matching the layer number and node number as of the subject data. It is supposed to be used with the property FEATURE_IMPORTANCE of NNClassifierMLP_Evaluator, NNClassifierMLP_CrossValidation, NNRegressorMLP_Evaluator, and NNRegressorMLP_CrossValidation.';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.ID
					prop_default = 'NNFeatureImportanceBrainSurfacePP_FI_Data ID';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.LABEL
					prop_default = 'NNFeatureImportanceBrainSurfacePP_FI_Data label';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.NOTES
					prop_default = 'NNFeatureImportanceBrainSurfacePP_FI_Data notes';
				case NNFeatureImportanceBrainSurfacePP_FI_Data.EL
					prop_default = NNFeatureImportanceBrainSurface();
				case NNFeatureImportanceBrainSurfacePP_FI_Data.PROP
					prop_default = NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNFeatureImportanceBrainSurfacePP_FI_Data.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNFeatureImportanceBrainSurfacePP_FI_Data.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNFeatureImportanceBrainSurfacePP_FI_Data, POINTER) returns the conditioned default value of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Data.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(NNFeatureImportanceBrainSurfacePP_FI_Data, POINTER) returns the conditioned default value of POINTER of NNFeatureImportanceBrainSurfacePP_FI_Data.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('NNFeatureImportanceBrainSurfacePP_FI_Data')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Data.getPropProp(pointer);
			
			prop_default = NNFeatureImportanceBrainSurfacePP_FI_Data.conditioning(prop, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNFeatureImportanceBrainSurfacePP_FI_Data, PROP, VALUE) checks VALUE format for PROP of NNFeatureImportanceBrainSurfacePP_FI_Data.
			%  CHECK = PR.CHECKPROP(NNFeatureImportanceBrainSurfacePP_FI_Data, PROP, VALUE) checks VALUE format for PROP of NNFeatureImportanceBrainSurfacePP_FI_Data.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNFeatureImportanceBrainSurfacePP_FI_Data:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:NNFeatureImportanceBrainSurfacePP_FI_Data:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNFeatureImportanceBrainSurfacePP_FI_Data, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNFeatureImportanceBrainSurfacePP_FI_Data.
			%   Error id: €BRAPH2.STR€:NNFeatureImportanceBrainSurfacePP_FI_Data:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(NNFeatureImportanceBrainSurfacePP_FI_Data, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNFeatureImportanceBrainSurfacePP_FI_Data.
			%   Error id: €BRAPH2.STR€:NNFeatureImportanceBrainSurfacePP_FI_Data:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('NNFeatureImportanceBrainSurfacePP_FI_Data')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNFeatureImportanceBrainSurfacePP_FI_Data.getPropProp(pointer);
			
			switch prop
				case NNFeatureImportanceBrainSurfacePP_FI_Data.D % __NNFeatureImportanceBrainSurfacePP_FI_Data.D__
					check = Format.checkFormat(Format.ITEM, value, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERSHOW % __NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERSHOW__
					check = Format.checkFormat(Format.LOGICAL, value, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERLABELS % __NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERLABELS__
					check = Format.checkFormat(Format.STRINGLIST, value, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERHEIGHT % __NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDERHEIGHT__
					check = Format.checkFormat(Format.SIZE, value, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDER % __NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDER__
					check = Format.checkFormat(Format.HANDLE, value, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERSHOW % __NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERSHOW__
					check = Format.checkFormat(Format.LOGICAL, value, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERLABELS % __NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERLABELS__
					check = Format.checkFormat(Format.STRINGLIST, value, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERWIDTH % __NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDERWIDTH__
					check = Format.checkFormat(Format.SIZE, value, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDER % __NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDER__
					check = Format.checkFormat(Format.HANDLE, value, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XYSLIDERLOCK % __NNFeatureImportanceBrainSurfacePP_FI_Data.XYSLIDERLOCK__
					check = Format.checkFormat(Format.LOGICAL, value, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.ENABLE % __NNFeatureImportanceBrainSurfacePP_FI_Data.ENABLE__
					check = Format.checkFormat(Format.OPTION, value, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.ROWNAME % __NNFeatureImportanceBrainSurfacePP_FI_Data.ROWNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.COLUMNNAME % __NNFeatureImportanceBrainSurfacePP_FI_Data.COLUMNNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.MENU_EXPORT % __NNFeatureImportanceBrainSurfacePP_FI_Data.MENU_EXPORT__
					check = Format.checkFormat(Format.LOGICAL, value, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE_HEIGHT % __NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE_HEIGHT__
					check = Format.checkFormat(Format.SIZE, value, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE % __NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE__
					check = Format.checkFormat(Format.HANDLE, value, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.CONTEXTMENU % __NNFeatureImportanceBrainSurfacePP_FI_Data.CONTEXTMENU__
					check = Format.checkFormat(Format.HANDLE, value, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.MAP_TO_CELL % __NNFeatureImportanceBrainSurfacePP_FI_Data.MAP_TO_CELL__
					check = Format.checkFormat(Format.EMPTY, value, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				case NNFeatureImportanceBrainSurfacePP_FI_Data.TEMPLATE % __NNFeatureImportanceBrainSurfacePP_FI_Data.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNFeatureImportanceBrainSurfacePP_FI_Data.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurfacePP_FI_Data:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNFeatureImportanceBrainSurfacePP_FI_Data:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNFeatureImportanceBrainSurfacePP_FI_Data.getPropTag(prop) ' (' NNFeatureImportanceBrainSurfacePP_FI_Data.getFormatTag(NNFeatureImportanceBrainSurfacePP_FI_Data.getPropFormat(prop)) ').'] ...
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
				case NNFeatureImportanceBrainSurfacePP_FI_Data.ROWNAME % __NNFeatureImportanceBrainSurfacePP_FI_Data.ROWNAME__
					if pr.get('DRAWN')
					    pr.get('UPDATE')
					end
					
				case NNFeatureImportanceBrainSurfacePP_FI_Data.COLUMNNAME % __NNFeatureImportanceBrainSurfacePP_FI_Data.COLUMNNAME__
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
				case NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDER % __NNFeatureImportanceBrainSurfacePP_FI_Data.XSLIDER__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					xslider = uislider( ...
					    'Parent', pr.get('H'), ...
					    'Tag', 'XSLIDER', ...
					    'MajorTicksMode', 'manual', ...
					    'MajorTickLabelsMode', 'manual', ...
					    'MinorTicksMode', 'manual', ...
					    'MinorTicks', [], ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_xslider} ...
					    );
					
					value = xslider;
					
				case NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDER % __NNFeatureImportanceBrainSurfacePP_FI_Data.YSLIDER__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					yslider = uislider( ...
					    'Parent', pr.get('H'), ...
					    'Tag', 'YSLIDER', ...
					    'Orientation', 'vertical', ...
					    'MajorTicksMode', 'manual', ...
					    'MajorTickLabelsMode', 'manual', ...
					    'MinorTicksMode', 'manual', ...
					    'MinorTicks', [], ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_yslider} ...
					    );
					
					value = yslider;
					
				case NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE % __NNFeatureImportanceBrainSurfacePP_FI_Data.TABLE__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					table = uitable( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'TABLE', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'CellEditCallback', {@cb_table} ...
					    );
					
					value = table;
					
				case NNFeatureImportanceBrainSurfacePP_FI_Data.CONTEXTMENU % __NNFeatureImportanceBrainSurfacePP_FI_Data.CONTEXTMENU__
					contextmenu = uicontextmenu(...
					    'Parent', ancestor(pr.get('H'), 'figure'), ...
					    'Tag', 'CONTEXTMENU' ...
					    );
					menu_export_to_xls = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_EXPORT_TO_XLS', ...
					    'Text', 'Export to XLS', ...
					    'MenuSelectedFcn', {@cb_export_to_xls} ...
					    );
					if pr.get('MENU_EXPORT')
					    set(pr.get('TABLE'), 'ContextMenu', contextmenu)
					end
					value = contextmenu;
					
				case NNFeatureImportanceBrainSurfacePP_FI_Data.MAP_TO_CELL % __NNFeatureImportanceBrainSurfacePP_FI_Data.MAP_TO_CELL__
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
					        nestedVector = pr.get('MAP_TO_CELL', vector(index:end), cellData);
					        mappedCellArray{i} = nestedVector;
					    else
					        % Assign elements from the vector to cells
					        numElements = numel(cellData);
					        mappedCellArray{i} = reshape(vector(index:index+numElements-1), size(cellData));
					        index = index + numElements;
					    end
					end
					
					value = mappedCellArray;
					
				case NNFeatureImportanceBrainSurfacePP_FI_Data.X_DRAW % __NNFeatureImportanceBrainSurfacePP_FI_Data.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					    pr.memorize('XSLIDER')
					    pr.memorize('YSLIDER')
					end
					
				case NNFeatureImportanceBrainSurfacePP_FI_Data.UPDATE % __NNFeatureImportanceBrainSurfacePP_FI_Data.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    if any(el.getPropCategory(prop) == [Category.RESULT Category.QUERY Category.EVANESCENT]) && isa(el.getr(prop), 'NoValue')
					        pr.set('HEIGHT', s(2))
					    else
					        pr.set('HEIGHT', pr.get('TABLE_HEIGHT'))
					    end
					    
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    input_dataset = pr.get('D');
					
					    % % % if input_dataset.get('DP_DICT').get('LENGTH')
					    % % %     sub = input_dataset.get('DP_DICT').get('IT', 1).get('SUB');
					    % % % else
					    % % %     sub = SubjectCON();
					    % % % end
					    % % % pr.set('TABLE_HEIGHT', s(40), ...
					    % % %     'XSLIDERSHOW', true, ...
					    % % %     'XSLIDERLABELS', sub.getCallback('ALAYERLABELS'), ...
					    % % %     'YSLIDERSHOW', false, ...
					    % % %     'ROWNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
					    % % %     'COLUMNNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
					    % % %     varargin{:});
					
					    rowname = pr.get('ROWNAME');
					    if isempty(rowname)
					        rowname = 'numbered';
					    end
					    columnname = pr.get('COLUMNNAME');
					    if isempty(rowname)
					        columnname = 'numbered';
					    end
					    set(pr.get('TABLE'), ...
					        'RowName', rowname, ...
					        'ColumnName', columnname ...
					        );
					
					    if el.isLocked(prop)
					        set(pr.get('TABLE'), 'Enable', pr.get('ENABLE'))
					    end
					    
					    prop_value = el.getr(prop);
					
					    if isa(prop_value, 'NoValue')
					        % don't plot anything for a result not yet calculated
					        set(pr.get('TABLE'), 'Visible', 'off')
					        set(pr.get('XSLIDER'), 'Visible', 'off')
					        set(pr.get('YSLIDER'), 'Visible', 'off')
					    else
					        set(pr.get('TABLE'), ...
					            'Data', set_sliders_and_get_value(), ...
					            'Enable', pr.get('ENABLE'), ...
					            'ColumnEditable', false, ...
					            'Visible', 'on' ...
					            )
					    end
					end
					
				case NNFeatureImportanceBrainSurfacePP_FI_Data.REDRAW % __NNFeatureImportanceBrainSurfacePP_FI_Data.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    if ~pr.get('XSLIDERSHOW') && ~pr.get('YSLIDERSHOW')
					        set(pr.get('TABLE'), 'Position', [s(.3) s(.3) max(1, w_p-s(.6)) max(1, pr.get('HEIGHT')-s(2.2))])
					    elseif pr.get('XSLIDERSHOW') && ~pr.get('YSLIDERSHOW')
					        set(pr.get('TABLE'), 'Position', [s(.3) s(.3) max(1, w_p-s(.6)) max(1, pr.get('HEIGHT')-s(2.2)-pr.get('XSLIDERHEIGHT'))])
					        set(pr.get('XSLIDER'), 'Position', [s(.3) max(1, pr.get('HEIGHT')-s(2.0)-s(.3)) max(1, w_p-s(.6)) 3])
					    elseif ~pr.get('XSLIDERSHOW') && pr.get('YSLIDERSHOW')
					        set(pr.get('TABLE'), 'Position', [s(.3)+pr.get('YSLIDERWIDTH') s(.3) max(1, w_p-s(.6)-pr.get('YSLIDERWIDTH')) max(1, pr.get('HEIGHT')-s(2.2))])
					        set(pr.get('YSLIDER'), 'Position', [s(.3) s(.3) 3 max(1, pr.get('HEIGHT')-s(2.2))])
					    else % pr.get('XSLIDERSHOW') && pr.get('YSLIDERSHOW')
					        set(pr.get('TABLE'), 'Position', [s(.3)+pr.get('YSLIDERWIDTH') s(.3) max(1, w_p-s(.6)-pr.get('YSLIDERWIDTH')) max(1, pr.get('HEIGHT')-s(2.2)-pr.get('XSLIDERHEIGHT'))])
					        set(pr.get('XSLIDER'), 'Position', [s(.3)+pr.get('YSLIDERWIDTH') max(1, pr.get('HEIGHT')-s(2.0)-s(.3)) max(1, w_p-s(.6)-pr.get('YSLIDERWIDTH')) 3])
					        set(pr.get('YSLIDER'), 'Position', [s(.3) s(.3) 3 max(1, pr.get('HEIGHT')-s(2.2)-s(.6)-pr.get('XSLIDERHEIGHT'))])
					    end
					end
					
				case NNFeatureImportanceBrainSurfacePP_FI_Data.DELETE % __NNFeatureImportanceBrainSurfacePP_FI_Data.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('TABLE', Element.getNoValue())
					    pr.set('CONTEXTMENU', Element.getNoValue())
					    pr.set('XSLIDER', Element.getNoValue())
					    pr.set('YSLIDER', Element.getNoValue())
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_xslider(~, ~)
			    set(pr.get('XSLIDER'), 'Value', round(get(pr.get('XSLIDER'), 'Value')))
			    
			    % if pr.get('XYSLIDERLOCK')
			    %     el = pr.get('EL');
			    %     prop = pr.get('PROP');
			    %     value = el.get(prop);
			    %     [R, C] = size(value);
			    % 
			    %     R = max(R, 1); % to manage the case in which C = R = 0 (empty cell)
			    % 
			    %     set(pr.get('YSLIDER'), 'Value', R + 1 - get(pr.get('XSLIDER'), 'Value'))
			    % end
			    
			    pr.get('UPDATE')
			end
			function cb_yslider(~, ~)
			    set(pr.get('YSLIDER'), 'Value', round(get(pr.get('YSLIDER'), 'Value')))
			    
			    if pr.get('XYSLIDERLOCK')
			        el = pr.get('EL');
			        prop = pr.get('PROP');
			        value_vectored = el.get(prop);
			
			        cell_template = pr.get('D').get('DP_DICT').get('IT', 1).get('INPUT');
			        value = pr.get('MAP_TO_CELL', cell2mat(value_vectored), cell_template);
			
			        [R, C] = size(value);
			        
			        C = max(C, 1); % to manage the case in which C = R = 0 (empty cell)
			
			        set(pr.get('XSLIDER'), 'Value', C + 1 - get(pr.get('YSLIDER'), 'Value'))
			    end
			
			    pr.get('UPDATE')
			end
			function cb_table(~, event)
			    i = event.Indices(1);
			    j = event.Indices(2); 
			    newdata = event.NewData;
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    value = el.get(prop);
			    [R, C] = size(value);
			    
			    r = R + 1 - get(pr.get('YSLIDER'), 'Value');
			    c = get(pr.get('XSLIDER'), 'Value');
			    
			    value_rc = value{r, c};
			    value_rc(i, j) = newdata;
			    value{r, c} = value_rc;
			    el.set(prop, value)
			end
			function cb_export_to_xls(~, ~)
			    table = pr.get('TABLE');
			    data = table.Data;
			    
			    columns = table.ColumnName;
			    if isempty(columns)
			        columns = cellfun(@(x) ['Column ' num2str(x)], num2cell([1:1:size(data, 2)]), 'UniformOutput', false);
			    elseif isequal(columns, 'numbered')
			        columns = cellfun(@(x) num2str(x), num2cell([1:1:size(data, 2)]), 'UniformOutput', false);
			    end
			    
			    rows = table.RowName;
			    if isempty(rows)
			        rows = cellfun(@(x) ['Column ' num2str(x)], num2cell([1:1:size(data, 1)]), 'UniformOutput', false);
			    elseif isequal(rows, 'numbered')
			        rows = cellfun(@(x) num2str(x), num2cell([1:1:size(data, 1)]), 'UniformOutput', false);
			    end
			    
			    t = array2table(data, ...
			        'VariableNames', columns, ...
			        'RowNames', rows ...
			        );
			
			    % save file
			    [filename, filepath, filterindex] = uiputfile({'*.xlsx';'*.xls'}, 'Select Excel file');
			    if filterindex
			        file = [filepath filename];
			        writetable(t, file, 'WriteRowNames', true);
			    end
			end
			function value = set_sliders_and_get_value()
			    value_vectored = el.get(prop);
			    
			    cell_template = pr.get('D').get('DP_DICT').get('IT', 1).get('INPUT');
			    value = pr.get('MAP_TO_CELL', cell2mat(value_vectored), cell_template);
			
			    if isempty(value)
			        set(pr.get('XSLIDER'), ...
			            'Limits', [.6 1.4], ...
			            'MajorTicks', [1], ...
			            'MajorTickLabels', {}, ...
			            'Value', 1, ...
			            'Visible', pr.get('XSLIDERSHOW') ...
			            )
			        set(pr.get('YSLIDER'), ...
			            'Limits', [.6 1.4], ...
			            'MajorTicks', [1], ...
			            'MajorTickLabels', {}, ...
			            'Value', 1, ...
			            'Visible', pr.get('YSLIDERSHOW') ...
			            )
			    else
			        [R, C] = size(value);
			        set(pr.get('XSLIDER'), ...
			            'Limits', [.6 C+.4], ...
			            'MajorTicks', [1:1:C], ...
			            'MajorTickLabels', pr.get('XSLIDERLABELS'), ...
			            'Value', max(1, min(round(get(pr.get('XSLIDER'), 'Value'), C))), ...
			            'Visible', pr.get('XSLIDERSHOW') ...
			            )
			        set(pr.get('YSLIDER'), ...
			            'Limits', [.6 R+.4], ...
			            'MajorTicks', [1:1:R], ...
			            'MajorTickLabels', flip(pr.get('YSLIDERLABELS')), ...
			            'Value', max(1, min(round(get(pr.get('YSLIDER'), 'Value'), R))), ...
			            'Visible', pr.get('YSLIDERSHOW') ...
			            )
			
			        if pr.get('XYSLIDERLOCK')
			            set(pr.get('YSLIDER'), 'Value', R + 1 - get(pr.get('XSLIDER'), 'Value'))
			        end
			
			        value = value{R + 1 - get(pr.get('YSLIDER'), 'Value'), get(pr.get('XSLIDER'), 'Value')};
			    end
			end
		end
	end
end
