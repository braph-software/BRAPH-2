classdef NNxMLP_xPP_FI_Measure < PanelProp
	%NNxMLP_xPP_FI_Measure plots the panel of a prop cell.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Cell Prop Panel (NNxMLP_xPP_FI_Measure) plots the panel for a CELL prop with a table and two sliders.
	% It works for all categories.
	% 
	% It can be personalized with the following props:
	%  TABLE_HEIGHT - Panel height in pixels when the table is shown.
	%  XSLIDERSHOW - Whether to show the x-slider.
	%  XSLIDERLABELS - Labels for the x-slider.
	%  XSLIDERHEIGHT - Height of x-slider in pixels.
	%  YSLIDERSHOW - Whether to show the y-slider.
	%  YSLIDERLABELS - Labels for the y-slider.
	%  YSLIDERWIDTH - Width of y-slider in pixels.
	%  XYSLIDERLOCK - Whether the sliders are locked so that only the diagonal is shown.
	%  ROWNAME - String list with row names (no names if empty; numbered if {'numbered'}). Dynamically updatable.
	%  COLUMNAME - String list with column names (no names if empty; numbered if {'numbered'}). Dynamically updatable.
	%  MENU_EXPORT - Whether to show the export menu. To be defined before drawing.
	%
	% NNxMLP_xPP_FI_Measure methods (constructor):
	%  NNxMLP_xPP_FI_Measure - constructor
	%
	% NNxMLP_xPP_FI_Measure methods:
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
	% NNxMLP_xPP_FI_Measure methods (display):
	%  tostring - string with information about the cell prop panel
	%  disp - displays information about the cell prop panel
	%  tree - displays the tree of the cell prop panel
	%
	% NNxMLP_xPP_FI_Measure methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two cell prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the cell prop panel
	%
	% NNxMLP_xPP_FI_Measure methods (save/load, Static):
	%  save - saves BRAPH2 cell prop panel as b2 file
	%  load - loads a BRAPH2 cell prop panel from a b2 file
	%
	% NNxMLP_xPP_FI_Measure method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the cell prop panel
	%
	% NNxMLP_xPP_FI_Measure method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the cell prop panel
	%
	% NNxMLP_xPP_FI_Measure methods (inspection, Static):
	%  getClass - returns the class of the cell prop panel
	%  getSubclasses - returns all subclasses of NNxMLP_xPP_FI_Measure
	%  getProps - returns the property list of the cell prop panel
	%  getPropNumber - returns the property number of the cell prop panel
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
	% NNxMLP_xPP_FI_Measure methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNxMLP_xPP_FI_Measure methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNxMLP_xPP_FI_Measure methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNxMLP_xPP_FI_Measure methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNxMLP_xPP_FI_Measure; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNxMLP_xPP_FI_Measure constants</a>.
	%
	%
	% See also uitable, uislider, GUI, PanelElement.
	
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
		
		MAP_TO_CELL = PanelProp.getPropNumber() + 11;
		MAP_TO_CELL_TAG = 'MAP_TO_CELL';
		MAP_TO_CELL_CATEGORY = Category.QUERY;
		MAP_TO_CELL_FORMAT = Format.EMPTY;
	end
	methods % constructor
		function pr = NNxMLP_xPP_FI_Measure(varargin)
			%NNxMLP_xPP_FI_Measure() creates a cell prop panel.
			%
			% NNxMLP_xPP_FI_Measure(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNxMLP_xPP_FI_Measure(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the cell prop panel.
			%
			% CLASS = NNxMLP_xPP_FI_Measure.GETCLASS() returns the class 'NNxMLP_xPP_FI_Measure'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the cell prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('NNxMLP_xPP_FI_Measure') returns 'NNxMLP_xPP_FI_Measure'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('NNxMLP_xPP_FI_Measure')
			%  are less computationally efficient.
			
			pr_class = 'NNxMLP_xPP_FI_Measure';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the cell prop panel.
			%
			% LIST = NNxMLP_xPP_FI_Measure.GETSUBCLASSES() returns all subclasses of 'NNxMLP_xPP_FI_Measure'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the cell prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('NNxMLP_xPP_FI_Measure') returns all subclasses of 'NNxMLP_xPP_FI_Measure'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('NNxMLP_xPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNxMLP_xPP_FI_Measure', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of cell prop panel.
			%
			% PROPS = NNxMLP_xPP_FI_Measure.GETPROPS() returns the property list of cell prop panel
			%  as a row vector.
			%
			% PROPS = NNxMLP_xPP_FI_Measure.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the cell prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('NNxMLP_xPP_FI_Measure'[, CATEGORY]) returns the property list of 'NNxMLP_xPP_FI_Measure'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('NNxMLP_xPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						NNxMLP_xPP_FI_Measure.D ...
						NNxMLP_xPP_FI_Measure.ENABLE ...
						NNxMLP_xPP_FI_Measure.ROWNAME ...
						NNxMLP_xPP_FI_Measure.COLUMNNAME ...
						NNxMLP_xPP_FI_Measure.MENU_EXPORT ...
						NNxMLP_xPP_FI_Measure.TABLE_HEIGHT ...
						NNxMLP_xPP_FI_Measure.SELECTED ...
						NNxMLP_xPP_FI_Measure.TABLE ...
						NNxMLP_xPP_FI_Measure.CONTEXTMENU ...
						NNxMLP_xPP_FI_Measure.GUI_B_DICT ...
						NNxMLP_xPP_FI_Measure.MAP_TO_CELL ...
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
						NNxMLP_xPP_FI_Measure.D ...
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
						NNxMLP_xPP_FI_Measure.MAP_TO_CELL ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelProp.getProps(Category.EVANESCENT) ...
						NNxMLP_xPP_FI_Measure.TABLE ...
						NNxMLP_xPP_FI_Measure.CONTEXTMENU ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						NNxMLP_xPP_FI_Measure.ENABLE ...
						NNxMLP_xPP_FI_Measure.ROWNAME ...
						NNxMLP_xPP_FI_Measure.COLUMNNAME ...
						NNxMLP_xPP_FI_Measure.MENU_EXPORT ...
						NNxMLP_xPP_FI_Measure.TABLE_HEIGHT ...
						NNxMLP_xPP_FI_Measure.SELECTED ...
						NNxMLP_xPP_FI_Measure.GUI_B_DICT ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of cell prop panel.
			%
			% N = NNxMLP_xPP_FI_Measure.GETPROPNUMBER() returns the property number of cell prop panel.
			%
			% N = NNxMLP_xPP_FI_Measure.GETPROPNUMBER(CATEGORY) returns the property number of cell prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the cell prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('NNxMLP_xPP_FI_Measure') returns the property number of 'NNxMLP_xPP_FI_Measure'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('NNxMLP_xPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNxMLP_xPP_FI_Measure.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in cell prop panel/error.
			%
			% CHECK = NNxMLP_xPP_FI_Measure.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(NNxMLP_xPP_FI_Measure, PROP) checks whether PROP exists for NNxMLP_xPP_FI_Measure.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_xPP_FI_Measure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:NNxMLP_xPP_FI_Measure:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:NNxMLP_xPP_FI_Measure:WrongInput]
			%  Element.EXISTSPROP(NNxMLP_xPP_FI_Measure, PROP) throws error if PROP does NOT exist for NNxMLP_xPP_FI_Measure.
			%   Error id: [BRAPH2:NNxMLP_xPP_FI_Measure:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('NNxMLP_xPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNxMLP_xPP_FI_Measure.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_xPP_FI_Measure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_xPP_FI_Measure:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNxMLP_xPP_FI_Measure.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in cell prop panel/error.
			%
			% CHECK = NNxMLP_xPP_FI_Measure.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(NNxMLP_xPP_FI_Measure, TAG) checks whether TAG exists for NNxMLP_xPP_FI_Measure.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNxMLP_xPP_FI_Measure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:NNxMLP_xPP_FI_Measure:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:NNxMLP_xPP_FI_Measure:WrongInput]
			%  Element.EXISTSTAG(NNxMLP_xPP_FI_Measure, TAG) throws error if TAG does NOT exist for NNxMLP_xPP_FI_Measure.
			%   Error id: [BRAPH2:NNxMLP_xPP_FI_Measure:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('NNxMLP_xPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnxmlp_xpp_fi_measure_tag_list = cellfun(@(x) NNxMLP_xPP_FI_Measure.getPropTag(x), num2cell(NNxMLP_xPP_FI_Measure.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnxmlp_xpp_fi_measure_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_xPP_FI_Measure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_xPP_FI_Measure:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNxMLP_xPP_FI_Measure.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNxMLP_xPP_FI_Measure, POINTER) returns property number of POINTER of NNxMLP_xPP_FI_Measure.
			%  PROPERTY = PR.GETPROPPROP(NNxMLP_xPP_FI_Measure, POINTER) returns property number of POINTER of NNxMLP_xPP_FI_Measure.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('NNxMLP_xPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnxmlp_xpp_fi_measure_tag_list = cellfun(@(x) NNxMLP_xPP_FI_Measure.getPropTag(x), num2cell(NNxMLP_xPP_FI_Measure.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnxmlp_xpp_fi_measure_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(NNxMLP_xPP_FI_Measure, POINTER) returns tag of POINTER of NNxMLP_xPP_FI_Measure.
			%  TAG = PR.GETPROPTAG(NNxMLP_xPP_FI_Measure, POINTER) returns tag of POINTER of NNxMLP_xPP_FI_Measure.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('NNxMLP_xPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNxMLP_xPP_FI_Measure.D
						tag = NNxMLP_xPP_FI_Measure.D_TAG;
					case NNxMLP_xPP_FI_Measure.ENABLE
						tag = NNxMLP_xPP_FI_Measure.ENABLE_TAG;
					case NNxMLP_xPP_FI_Measure.ROWNAME
						tag = NNxMLP_xPP_FI_Measure.ROWNAME_TAG;
					case NNxMLP_xPP_FI_Measure.COLUMNNAME
						tag = NNxMLP_xPP_FI_Measure.COLUMNNAME_TAG;
					case NNxMLP_xPP_FI_Measure.MENU_EXPORT
						tag = NNxMLP_xPP_FI_Measure.MENU_EXPORT_TAG;
					case NNxMLP_xPP_FI_Measure.TABLE_HEIGHT
						tag = NNxMLP_xPP_FI_Measure.TABLE_HEIGHT_TAG;
					case NNxMLP_xPP_FI_Measure.SELECTED
						tag = NNxMLP_xPP_FI_Measure.SELECTED_TAG;
					case NNxMLP_xPP_FI_Measure.TABLE
						tag = NNxMLP_xPP_FI_Measure.TABLE_TAG;
					case NNxMLP_xPP_FI_Measure.CONTEXTMENU
						tag = NNxMLP_xPP_FI_Measure.CONTEXTMENU_TAG;
					case NNxMLP_xPP_FI_Measure.GUI_B_DICT
						tag = NNxMLP_xPP_FI_Measure.GUI_B_DICT_TAG;
					case NNxMLP_xPP_FI_Measure.MAP_TO_CELL
						tag = NNxMLP_xPP_FI_Measure.MAP_TO_CELL_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNxMLP_xPP_FI_Measure, POINTER) returns category of POINTER of NNxMLP_xPP_FI_Measure.
			%  CATEGORY = PR.GETPROPCATEGORY(NNxMLP_xPP_FI_Measure, POINTER) returns category of POINTER of NNxMLP_xPP_FI_Measure.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('NNxMLP_xPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_xPP_FI_Measure.getPropProp(pointer);
			
			switch prop
				case NNxMLP_xPP_FI_Measure.D
					prop_category = NNxMLP_xPP_FI_Measure.D_CATEGORY;
				case NNxMLP_xPP_FI_Measure.ENABLE
					prop_category = NNxMLP_xPP_FI_Measure.ENABLE_CATEGORY;
				case NNxMLP_xPP_FI_Measure.ROWNAME
					prop_category = NNxMLP_xPP_FI_Measure.ROWNAME_CATEGORY;
				case NNxMLP_xPP_FI_Measure.COLUMNNAME
					prop_category = NNxMLP_xPP_FI_Measure.COLUMNNAME_CATEGORY;
				case NNxMLP_xPP_FI_Measure.MENU_EXPORT
					prop_category = NNxMLP_xPP_FI_Measure.MENU_EXPORT_CATEGORY;
				case NNxMLP_xPP_FI_Measure.TABLE_HEIGHT
					prop_category = NNxMLP_xPP_FI_Measure.TABLE_HEIGHT_CATEGORY;
				case NNxMLP_xPP_FI_Measure.SELECTED
					prop_category = NNxMLP_xPP_FI_Measure.SELECTED_CATEGORY;
				case NNxMLP_xPP_FI_Measure.TABLE
					prop_category = NNxMLP_xPP_FI_Measure.TABLE_CATEGORY;
				case NNxMLP_xPP_FI_Measure.CONTEXTMENU
					prop_category = NNxMLP_xPP_FI_Measure.CONTEXTMENU_CATEGORY;
				case NNxMLP_xPP_FI_Measure.GUI_B_DICT
					prop_category = NNxMLP_xPP_FI_Measure.GUI_B_DICT_CATEGORY;
				case NNxMLP_xPP_FI_Measure.MAP_TO_CELL
					prop_category = NNxMLP_xPP_FI_Measure.MAP_TO_CELL_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(NNxMLP_xPP_FI_Measure, POINTER) returns format of POINTER of NNxMLP_xPP_FI_Measure.
			%  FORMAT = PR.GETPROPFORMAT(NNxMLP_xPP_FI_Measure, POINTER) returns format of POINTER of NNxMLP_xPP_FI_Measure.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('NNxMLP_xPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_xPP_FI_Measure.getPropProp(pointer);
			
			switch prop
				case NNxMLP_xPP_FI_Measure.D
					prop_format = NNxMLP_xPP_FI_Measure.D_FORMAT;
				case NNxMLP_xPP_FI_Measure.ENABLE
					prop_format = NNxMLP_xPP_FI_Measure.ENABLE_FORMAT;
				case NNxMLP_xPP_FI_Measure.ROWNAME
					prop_format = NNxMLP_xPP_FI_Measure.ROWNAME_FORMAT;
				case NNxMLP_xPP_FI_Measure.COLUMNNAME
					prop_format = NNxMLP_xPP_FI_Measure.COLUMNNAME_FORMAT;
				case NNxMLP_xPP_FI_Measure.MENU_EXPORT
					prop_format = NNxMLP_xPP_FI_Measure.MENU_EXPORT_FORMAT;
				case NNxMLP_xPP_FI_Measure.TABLE_HEIGHT
					prop_format = NNxMLP_xPP_FI_Measure.TABLE_HEIGHT_FORMAT;
				case NNxMLP_xPP_FI_Measure.SELECTED
					prop_format = NNxMLP_xPP_FI_Measure.SELECTED_FORMAT;
				case NNxMLP_xPP_FI_Measure.TABLE
					prop_format = NNxMLP_xPP_FI_Measure.TABLE_FORMAT;
				case NNxMLP_xPP_FI_Measure.CONTEXTMENU
					prop_format = NNxMLP_xPP_FI_Measure.CONTEXTMENU_FORMAT;
				case NNxMLP_xPP_FI_Measure.GUI_B_DICT
					prop_format = NNxMLP_xPP_FI_Measure.GUI_B_DICT_FORMAT;
				case NNxMLP_xPP_FI_Measure.MAP_TO_CELL
					prop_format = NNxMLP_xPP_FI_Measure.MAP_TO_CELL_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNxMLP_xPP_FI_Measure, POINTER) returns description of POINTER of NNxMLP_xPP_FI_Measure.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(NNxMLP_xPP_FI_Measure, POINTER) returns description of POINTER of NNxMLP_xPP_FI_Measure.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('NNxMLP_xPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNxMLP_xPP_FI_Measure.getPropProp(pointer);
			
			switch prop
				case NNxMLP_xPP_FI_Measure.D
					prop_description = 'D (metadata, item) is the input dataset.';
				case NNxMLP_xPP_FI_Measure.ENABLE
					prop_description = 'ENABLE (gui, option) switches table between on and off.';
				case NNxMLP_xPP_FI_Measure.ROWNAME
					prop_description = 'ROWNAME (gui, stringlist) determines the table row names.';
				case NNxMLP_xPP_FI_Measure.COLUMNNAME
					prop_description = 'COLUMNNAME (gui, stringlist) determines the table column names.';
				case NNxMLP_xPP_FI_Measure.MENU_EXPORT
					prop_description = 'MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.';
				case NNxMLP_xPP_FI_Measure.TABLE_HEIGHT
					prop_description = 'TABLE_HEIGHT (gui, size) is the pixel height of the prop panel when the table is shown.';
				case NNxMLP_xPP_FI_Measure.SELECTED
					prop_description = 'SELECTED (gui, cvector) is the list of selected items.';
				case NNxMLP_xPP_FI_Measure.TABLE
					prop_description = 'TABLE (evanescent, handle) is the table.';
				case NNxMLP_xPP_FI_Measure.CONTEXTMENU
					prop_description = 'CONTEXTMENU (evanescent, handle) is the context menu.';
				case NNxMLP_xPP_FI_Measure.GUI_B_DICT
					prop_description = 'GUI_B_DICT (gui, idict) contains the GUIs for the brain measures.';
				case NNxMLP_xPP_FI_Measure.MAP_TO_CELL
					prop_description = 'MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.';
				case NNxMLP_xPP_FI_Measure.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the  % % % .';
				case NNxMLP_xPP_FI_Measure.NAME
					prop_description = 'NAME (constant, string) is the name of the cell prop panel.';
				case NNxMLP_xPP_FI_Measure.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the cell prop panel.';
				case NNxMLP_xPP_FI_Measure.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the cell prop panel.';
				case NNxMLP_xPP_FI_Measure.ID
					prop_description = 'ID (data, string) is a few-letter code for the cell prop panel.';
				case NNxMLP_xPP_FI_Measure.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the cell prop panel.';
				case NNxMLP_xPP_FI_Measure.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the cell prop panel.';
				case NNxMLP_xPP_FI_Measure.EL
					prop_description = 'EL (data, item) is the element.';
				case NNxMLP_xPP_FI_Measure.PROP
					prop_description = 'PROP (data, scalar) is the prop number.';
				case NNxMLP_xPP_FI_Measure.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the prop panel.';
				case NNxMLP_xPP_FI_Measure.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the table.';
				case NNxMLP_xPP_FI_Measure.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.';
				case NNxMLP_xPP_FI_Measure.SHOW
					prop_description = 'SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.';
				case NNxMLP_xPP_FI_Measure.HIDE
					prop_description = 'HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.';
				case NNxMLP_xPP_FI_Measure.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
				case NNxMLP_xPP_FI_Measure.CLOSE
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNxMLP_xPP_FI_Measure, POINTER) returns settings of POINTER of NNxMLP_xPP_FI_Measure.
			%  SETTINGS = PR.GETPROPSETTINGS(NNxMLP_xPP_FI_Measure, POINTER) returns settings of POINTER of NNxMLP_xPP_FI_Measure.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('NNxMLP_xPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNxMLP_xPP_FI_Measure.getPropProp(pointer);
			
			switch prop
				case NNxMLP_xPP_FI_Measure.D
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case NNxMLP_xPP_FI_Measure.ENABLE
					prop_settings = {'on', 'off'};
				case NNxMLP_xPP_FI_Measure.ROWNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNxMLP_xPP_FI_Measure.COLUMNNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case NNxMLP_xPP_FI_Measure.MENU_EXPORT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case NNxMLP_xPP_FI_Measure.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case NNxMLP_xPP_FI_Measure.SELECTED
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case NNxMLP_xPP_FI_Measure.TABLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNxMLP_xPP_FI_Measure.CONTEXTMENU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case NNxMLP_xPP_FI_Measure.GUI_B_DICT
					prop_settings = 'GUIFig';
				case NNxMLP_xPP_FI_Measure.MAP_TO_CELL
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case NNxMLP_xPP_FI_Measure.TEMPLATE
					prop_settings = 'NNxMLP_xPP_FI_Measure';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNxMLP_xPP_FI_Measure.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_xPP_FI_Measure.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(NNxMLP_xPP_FI_Measure, POINTER) returns the default value of POINTER of NNxMLP_xPP_FI_Measure.
			%  DEFAULT = PR.GETPROPDEFAULT(NNxMLP_xPP_FI_Measure, POINTER) returns the default value of POINTER of NNxMLP_xPP_FI_Measure.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('NNxMLP_xPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNxMLP_xPP_FI_Measure.getPropProp(pointer);
			
			switch prop
				case NNxMLP_xPP_FI_Measure.D
					prop_default = NNDataset();
				case NNxMLP_xPP_FI_Measure.ENABLE
					prop_default = 'on';
				case NNxMLP_xPP_FI_Measure.ROWNAME
					prop_default = {'numbered'};
				case NNxMLP_xPP_FI_Measure.COLUMNNAME
					prop_default = {'numbered'};
				case NNxMLP_xPP_FI_Measure.MENU_EXPORT
					prop_default = true;
				case NNxMLP_xPP_FI_Measure.TABLE_HEIGHT
					prop_default = s(20);
				case NNxMLP_xPP_FI_Measure.SELECTED
					prop_default = Format.getFormatDefault(Format.CVECTOR, NNxMLP_xPP_FI_Measure.getPropSettings(prop));
				case NNxMLP_xPP_FI_Measure.TABLE
					prop_default = Format.getFormatDefault(Format.HANDLE, NNxMLP_xPP_FI_Measure.getPropSettings(prop));
				case NNxMLP_xPP_FI_Measure.CONTEXTMENU
					prop_default = Format.getFormatDefault(Format.HANDLE, NNxMLP_xPP_FI_Measure.getPropSettings(prop));
				case NNxMLP_xPP_FI_Measure.GUI_B_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, NNxMLP_xPP_FI_Measure.getPropSettings(prop));
				case NNxMLP_xPP_FI_Measure.MAP_TO_CELL
					prop_default = Format.getFormatDefault(Format.EMPTY, NNxMLP_xPP_FI_Measure.getPropSettings(prop));
				case NNxMLP_xPP_FI_Measure.ELCLASS
					prop_default = 'NNxMLP_xPP_FI_Measure';
				case NNxMLP_xPP_FI_Measure.NAME
					prop_default = 'Cell Prop Panel';
				case NNxMLP_xPP_FI_Measure.DESCRIPTION
					prop_default = 'A Cell Prop Panel (NNxMLP_xPP_FI_Measure) plots the panel for a CELL prop with a table and two sliders. It works for all categories. It can be personalized with the following props: TABLE_HEIGHT, XSLIDERSHOW, XSLIDERLABELS, XSLIDERHEIGHT, YSLIDERSHOW, YSLIDERLABELS, YSLIDERHEIGHT, XYSLIDERLOCK, ROWNAME, COLUMNAME, MENU_EXPORT.';
				case NNxMLP_xPP_FI_Measure.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNxMLP_xPP_FI_Measure.getPropSettings(prop));
				case NNxMLP_xPP_FI_Measure.ID
					prop_default = 'NNxMLP_xPP_FI_Measure ID';
				case NNxMLP_xPP_FI_Measure.LABEL
					prop_default = 'NNxMLP_xPP_FI_Measure label';
				case NNxMLP_xPP_FI_Measure.NOTES
					prop_default = 'NNxMLP_xPP_FI_Measure notes';
				case NNxMLP_xPP_FI_Measure.EL
					prop_default = NNClassifierMLP_CrossValidation();
				case NNxMLP_xPP_FI_Measure.PROP
					prop_default = NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNxMLP_xPP_FI_Measure.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNxMLP_xPP_FI_Measure.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNxMLP_xPP_FI_Measure, POINTER) returns the conditioned default value of POINTER of NNxMLP_xPP_FI_Measure.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(NNxMLP_xPP_FI_Measure, POINTER) returns the conditioned default value of POINTER of NNxMLP_xPP_FI_Measure.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('NNxMLP_xPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNxMLP_xPP_FI_Measure.getPropProp(pointer);
			
			prop_default = NNxMLP_xPP_FI_Measure.conditioning(prop, NNxMLP_xPP_FI_Measure.getPropDefault(prop));
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
			
			prop = NNxMLP_xPP_FI_Measure.getPropProp(pointer);
			
			switch prop
				case NNxMLP_xPP_FI_Measure.SELECTED % __NNxMLP_xPP_FI_Measure.SELECTED__
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
			%  CHECK = Element.CHECKPROP(NNxMLP_xPP_FI_Measure, PROP, VALUE) checks VALUE format for PROP of NNxMLP_xPP_FI_Measure.
			%  CHECK = PR.CHECKPROP(NNxMLP_xPP_FI_Measure, PROP, VALUE) checks VALUE format for PROP of NNxMLP_xPP_FI_Measure.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNxMLP_xPP_FI_Measure:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:NNxMLP_xPP_FI_Measure:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNxMLP_xPP_FI_Measure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_xPP_FI_Measure.
			%   Error id: €BRAPH2.STR€:NNxMLP_xPP_FI_Measure:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(NNxMLP_xPP_FI_Measure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNxMLP_xPP_FI_Measure.
			%   Error id: €BRAPH2.STR€:NNxMLP_xPP_FI_Measure:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('NNxMLP_xPP_FI_Measure')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNxMLP_xPP_FI_Measure.getPropProp(pointer);
			
			switch prop
				case NNxMLP_xPP_FI_Measure.D % __NNxMLP_xPP_FI_Measure.D__
					check = Format.checkFormat(Format.ITEM, value, NNxMLP_xPP_FI_Measure.getPropSettings(prop));
				case NNxMLP_xPP_FI_Measure.ENABLE % __NNxMLP_xPP_FI_Measure.ENABLE__
					check = Format.checkFormat(Format.OPTION, value, NNxMLP_xPP_FI_Measure.getPropSettings(prop));
				case NNxMLP_xPP_FI_Measure.ROWNAME % __NNxMLP_xPP_FI_Measure.ROWNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, NNxMLP_xPP_FI_Measure.getPropSettings(prop));
				case NNxMLP_xPP_FI_Measure.COLUMNNAME % __NNxMLP_xPP_FI_Measure.COLUMNNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, NNxMLP_xPP_FI_Measure.getPropSettings(prop));
				case NNxMLP_xPP_FI_Measure.MENU_EXPORT % __NNxMLP_xPP_FI_Measure.MENU_EXPORT__
					check = Format.checkFormat(Format.LOGICAL, value, NNxMLP_xPP_FI_Measure.getPropSettings(prop));
				case NNxMLP_xPP_FI_Measure.TABLE_HEIGHT % __NNxMLP_xPP_FI_Measure.TABLE_HEIGHT__
					check = Format.checkFormat(Format.SIZE, value, NNxMLP_xPP_FI_Measure.getPropSettings(prop));
				case NNxMLP_xPP_FI_Measure.SELECTED % __NNxMLP_xPP_FI_Measure.SELECTED__
					check = Format.checkFormat(Format.CVECTOR, value, NNxMLP_xPP_FI_Measure.getPropSettings(prop));
				case NNxMLP_xPP_FI_Measure.TABLE % __NNxMLP_xPP_FI_Measure.TABLE__
					check = Format.checkFormat(Format.HANDLE, value, NNxMLP_xPP_FI_Measure.getPropSettings(prop));
				case NNxMLP_xPP_FI_Measure.CONTEXTMENU % __NNxMLP_xPP_FI_Measure.CONTEXTMENU__
					check = Format.checkFormat(Format.HANDLE, value, NNxMLP_xPP_FI_Measure.getPropSettings(prop));
				case NNxMLP_xPP_FI_Measure.GUI_B_DICT % __NNxMLP_xPP_FI_Measure.GUI_B_DICT__
					check = Format.checkFormat(Format.IDICT, value, NNxMLP_xPP_FI_Measure.getPropSettings(prop));
				case NNxMLP_xPP_FI_Measure.MAP_TO_CELL % __NNxMLP_xPP_FI_Measure.MAP_TO_CELL__
					check = Format.checkFormat(Format.EMPTY, value, NNxMLP_xPP_FI_Measure.getPropSettings(prop));
				case NNxMLP_xPP_FI_Measure.TEMPLATE % __NNxMLP_xPP_FI_Measure.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNxMLP_xPP_FI_Measure.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNxMLP_xPP_FI_Measure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNxMLP_xPP_FI_Measure:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNxMLP_xPP_FI_Measure.getPropTag(prop) ' (' NNxMLP_xPP_FI_Measure.getFormatTag(NNxMLP_xPP_FI_Measure.getPropFormat(prop)) ').'] ...
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
				case NNxMLP_xPP_FI_Measure.ROWNAME % __NNxMLP_xPP_FI_Measure.ROWNAME__
					if pr.get('DRAWN')
					    pr.get('UPDATE')
					end
					
				case NNxMLP_xPP_FI_Measure.COLUMNNAME % __NNxMLP_xPP_FI_Measure.COLUMNNAME__
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
				case NNxMLP_xPP_FI_Measure.TABLE % __NNxMLP_xPP_FI_Measure.TABLE__
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
					
				case NNxMLP_xPP_FI_Measure.CONTEXTMENU % __NNxMLP_xPP_FI_Measure.CONTEXTMENU__
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
					
				case NNxMLP_xPP_FI_Measure.MAP_TO_CELL % __NNxMLP_xPP_FI_Measure.MAP_TO_CELL__
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
					
				case NNxMLP_xPP_FI_Measure.X_DRAW % __NNxMLP_xPP_FI_Measure.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					end
					
				case NNxMLP_xPP_FI_Measure.UPDATE % __NNxMLP_xPP_FI_Measure.UPDATE__
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
					
				case NNxMLP_xPP_FI_Measure.REDRAW % __NNxMLP_xPP_FI_Measure.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('TABLE'), 'Position', [s(.3) s(.3) w_p-s(.6) max(1, pr.get('HEIGHT')-s(2.2))])
					end
					
				case NNxMLP_xPP_FI_Measure.SHOW % __NNxMLP_xPP_FI_Measure.SHOW__
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
					
				case NNxMLP_xPP_FI_Measure.HIDE % __NNxMLP_xPP_FI_Measure.HIDE__
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
					
				case NNxMLP_xPP_FI_Measure.DELETE % __NNxMLP_xPP_FI_Measure.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('TABLE', Element.getNoValue())
					    pr.set('CONTEXTMENU', Element.getNoValue())
					end
					
				case NNxMLP_xPP_FI_Measure.CLOSE % __NNxMLP_xPP_FI_Measure.CLOSE__
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
			    % % % input_dataset = pr.get('D');
			    % % % m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
			    % % % 
			    % % % f = ancestor(pr.get('H'), 'figure'); % parent GUI
			    % % % N = ceil(sqrt(length(m_list))); % number of row and columns of figures
			    % % % 
			    % % % gui_b_dict = pr.memorize('GUI_B_DICT');
			    % % % selected = pr.get('SELECTED');
			    % % % for s = 1:1:length(selected)
			    % % %     i = selected(s);
			    % % % 
			    % % %     measure = m_list{i}; % also key
			    % % % 
			    % % %     values_vectored = el.get(prop);
			    % % %     cell_template = pr.get('D').get('DP_DICT').get('IT', 1).get('INPUT');
			    % % %     values = pr.get('MAP_TO_CELL', cell2mat(values_vectored), cell_template);
			    % % %     value = values(i);
			    % % % 
			    % % %     if ~gui_b_dict.get('CONTAINS_KEY', measure)
			    % % % 
			    % % %         brain_atlas = pr.get('BA'); 
			    % % %         %brain_atlas = ImporterBrainAtlasXLS('WAITBAR', false, 'FILE', [fileparts(which('braph2')) filesep() 'atlases' filesep() 'desikan_atlas.xlsx']).get('BA');
			    % % %         switch Element.getPropDefault(measure, 'SHAPE')
			    % % %             case Measure.GLOBAL % __Measure.GLOBAL__
			    % % %                 switch Element.getPropDefault(measure, 'SCOPE')
			    % % %                     case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
			    % % %                         mbfipf = NNxMLP_xPF_FI_MeasureBrain_GS('FI', value, 'BA', brain_atlas);
			    % % %                     case Measure.UNILAYER % __Measure.UNILAYER__
			    % % %                         mbfipf = NNxMLP_xPF_FI_MeasureBrain_GU('FI', value, 'BA', brain_atlas);
			    % % %                     case Measure.BILAYER % __Measure.BILAYER__
			    % % %                         mbfipf = NNxMLP_xPF_FI_MeasureBrain_GB('FI', value, 'BA', brain_atlas);
			    % % %                 end
			    % % %             case Measure.NODAL % __Measure.NODAL__
			    % % %                 switch Element.getPropDefault(measure, 'SCOPE')
			    % % %                     case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
			    % % %                         mbfipf = NNxMLP_xPF_FI_MeasureBrain_NS('FI', value, 'BA', brain_atlas);
			    % % %                     case Measure.UNILAYER % __Measure.UNILAYER__
			    % % %                         mbfipf = NNxMLP_xPF_FI_MeasureBrain_NU('FI', value, 'BA', brain_atlas);
			    % % %                     case Measure.BILAYER % __Measure.BILAYER__
			    % % %                         mbfipf = NNxMLP_xPF_FI_MeasureBrain_NB('FI', value, 'BA', brain_atlas);
			    % % %                 end
			    % % %             case Measure.BINODAL % __Measure.BINODAL__
			    % % %                 switch Element.getPropDefault(measure, 'SCOPE')
			    % % %                     case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
			    % % %                         mbfipf = NNxMLP_xPF_FI_MeasureBrain_BS('FI', value, 'BA', brain_atlas);
			    % % %                     case Measure.UNILAYER % __Measure.UNILAYER__
			    % % %                         mbfipf = NNxMLP_xPF_FI_MeasureBrain_BU('FI', value, 'BA', brain_atlas);
			    % % %                     case Measure.BILAYER % __Measure.BILAYER__
			    % % %                         mbfipf = NNxMLP_xPF_FI_MeasureBrain_BB('FI', value, 'BA', brain_atlas);
			    % % %                 end
			    % % %         end
			    % % % 
			    % % %         gui = GUIFig( ...
			    % % %             'ID', measure, ... % this is the dictionary key
			    % % %             'PF', mbfipf, ...
			    % % %             'POSITION', [ ...
			    % % %             x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ...
			    % % %             y0(f, 'normalized') ...
			    % % %             w(f, 'normalized') * 3 ...
			    % % %             .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ...
			    % % %             ], ...
			    % % %             'WAITBAR', pr.getCallback('WAITBAR'), ...
			    % % %             'CLOSEREQ', false ...
			    % % %             );
			    % % %         gui_b_dict.get('ADD', gui)
			    % % %     end
			    % % % 
			    % % %     gui = gui_b_dict.get('IT', measure);
			    % % %     if ~gui.get('DRAWN')
			    % % %         gui.get('DRAW')
			    % % %     end
			    % % %     gui.get('SHOW')
			    % % % end
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
