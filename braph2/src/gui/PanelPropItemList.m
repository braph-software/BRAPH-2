classdef PanelPropItemList < PanelProp
	%PanelPropItemList plots the panel of a property item-list.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% An Item-List Prop Panel (PanelPropItemList) plots the panel for a ITEMLIST property with a table.
	%  It works for all categories. 
	%  
	% It can be personalized with the following props:
	%   COLS - Numerical array with the columns to be visualized. It can include 
	%          PanelPropIDictTable.SELECTOR and/or prop numbers of the item class.
	%   ROWNAME - String list with the row names as per uitable format.
	%          It can be a string list or 'numbered' or {} (to reset it).
	%   COLUMNAME - String list with the column names as per uitable format.
	%          It can be a string list or 'numbered'.
	%   COLUMNWIDTH - String list with the cloumn width as per uitable format.
	%          It can be a string list (e.g. {'1x' '2x'}) or 'auto'.
	%   COLUMNEDITABLE - Row vector to determine the cloumn editability as per uitable format.
	%          It can be a row vector of booleans.
	%   COLUMNFORMAT - Code to determine the column format as per uitable format.
	%          The format should be, e.g., {'char' 'logical' 'numeric' {'op1' 'op2'}}.
	%   CB_TAB_EDIT - Code in a cell array for the edit callback to be evaluated 
	%          by the table edit callback. It can refer to the variables:
	%           el, prop, dict, it_class, pr, i, col, newdata
	%          and use the standard callback function:
	%           cb_table_edit_default()
	%
	% PanelPropItemList methods (constructor):
	%  PanelPropItemList - constructor
	%
	% PanelPropItemList methods:
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
	% PanelPropItemList methods (display):
	%  tostring - string with information about the item-list prop panel
	%  disp - displays information about the item-list prop panel
	%  tree - displays the tree of the item-list prop panel
	%
	% PanelPropItemList methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two item-list prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the item-list prop panel
	%
	% PanelPropItemList methods (save/load, Static):
	%  save - saves BRAPH2 item-list prop panel as b2 file
	%  load - loads a BRAPH2 item-list prop panel from a b2 file
	%
	% PanelPropItemList method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the item-list prop panel
	%
	% PanelPropItemList method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the item-list prop panel
	%
	% PanelPropItemList methods (inspection, Static):
	%  getClass - returns the class of the item-list prop panel
	%  getSubclasses - returns all subclasses of PanelPropItemList
	%  getProps - returns the property list of the item-list prop panel
	%  getPropNumber - returns the property number of the item-list prop panel
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
	% PanelPropItemList methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropItemList methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropItemList methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropItemList methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropItemList; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropItemList constants</a>.
	%
	%
	% See also uitable, GUI, PanelElement, GUIElement.
	
	properties (Constant) % constants
		SELECTOR = -1 % code for the selector column.
	end
	properties (Constant) % properties
		TABLE_HEIGHT = PanelProp.getPropNumber() + 1;
		TABLE_HEIGHT_TAG = 'TABLE_HEIGHT';
		TABLE_HEIGHT_CATEGORY = Category.GUI;
		TABLE_HEIGHT_FORMAT = Format.SIZE;
		
		SELECTED = PanelProp.getPropNumber() + 2;
		SELECTED_TAG = 'SELECTED';
		SELECTED_CATEGORY = Category.GUI;
		SELECTED_FORMAT = Format.CVECTOR;
		
		COLS = PanelProp.getPropNumber() + 3;
		COLS_TAG = 'COLS';
		COLS_CATEGORY = Category.GUI;
		COLS_FORMAT = Format.RVECTOR;
		
		ROWNAME = PanelProp.getPropNumber() + 4;
		ROWNAME_TAG = 'ROWNAME';
		ROWNAME_CATEGORY = Category.GUI;
		ROWNAME_FORMAT = Format.STRINGLIST;
		
		COLUMNNAME = PanelProp.getPropNumber() + 5;
		COLUMNNAME_TAG = 'COLUMNNAME';
		COLUMNNAME_CATEGORY = Category.GUI;
		COLUMNNAME_FORMAT = Format.STRINGLIST;
		
		COLUMNWIDTH = PanelProp.getPropNumber() + 6;
		COLUMNWIDTH_TAG = 'COLUMNWIDTH';
		COLUMNWIDTH_CATEGORY = Category.GUI;
		COLUMNWIDTH_FORMAT = Format.STRINGLIST;
		
		COLUMNEDITABLE = PanelProp.getPropNumber() + 7;
		COLUMNEDITABLE_TAG = 'COLUMNEDITABLE';
		COLUMNEDITABLE_CATEGORY = Category.GUI;
		COLUMNEDITABLE_FORMAT = Format.RVECTOR;
		
		COLUMNFORMAT = PanelProp.getPropNumber() + 8;
		COLUMNFORMAT_TAG = 'COLUMNFORMAT';
		COLUMNFORMAT_CATEGORY = Category.GUI;
		COLUMNFORMAT_FORMAT = Format.STRINGLIST;
		
		CB_TAB_EDIT = PanelProp.getPropNumber() + 9;
		CB_TAB_EDIT_TAG = 'CB_TAB_EDIT';
		CB_TAB_EDIT_CATEGORY = Category.GUI;
		CB_TAB_EDIT_FORMAT = Format.STRING;
		
		TABLE = PanelProp.getPropNumber() + 10;
		TABLE_TAG = 'TABLE';
		TABLE_CATEGORY = Category.EVANESCENT;
		TABLE_FORMAT = Format.HANDLE;
		
		MENU_OPEN_ITEMS = PanelProp.getPropNumber() + 11;
		MENU_OPEN_ITEMS_TAG = 'MENU_OPEN_ITEMS';
		MENU_OPEN_ITEMS_CATEGORY = Category.GUI;
		MENU_OPEN_ITEMS_FORMAT = Format.LOGICAL;
		
		MENU_EXPORT = PanelProp.getPropNumber() + 12;
		MENU_EXPORT_TAG = 'MENU_EXPORT';
		MENU_EXPORT_CATEGORY = Category.GUI;
		MENU_EXPORT_FORMAT = Format.LOGICAL;
		
		CONTEXTMENU = PanelProp.getPropNumber() + 13;
		CONTEXTMENU_TAG = 'CONTEXTMENU';
		CONTEXTMENU_CATEGORY = Category.EVANESCENT;
		CONTEXTMENU_FORMAT = Format.HANDLE;
		
		GUI_ITS_DICT = PanelProp.getPropNumber() + 14;
		GUI_ITS_DICT_TAG = 'GUI_ITS_DICT';
		GUI_ITS_DICT_CATEGORY = Category.GUI;
		GUI_ITS_DICT_FORMAT = Format.IDICT;
	end
	methods % constructor
		function pr = PanelPropItemList(varargin)
			%PanelPropItemList() creates a item-list prop panel.
			%
			% PanelPropItemList(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropItemList(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the item-list prop panel.
			%
			% CLASS = PanelPropItemList.GETCLASS() returns the class 'PanelPropItemList'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the item-list prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropItemList') returns 'PanelPropItemList'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropItemList')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropItemList';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the item-list prop panel.
			%
			% LIST = PanelPropItemList.GETSUBCLASSES() returns all subclasses of 'PanelPropItemList'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the item-list prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropItemList') returns all subclasses of 'PanelPropItemList'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelPropItemList', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of item-list prop panel.
			%
			% PROPS = PanelPropItemList.GETPROPS() returns the property list of item-list prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropItemList.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the item-list prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropItemList'[, CATEGORY]) returns the property list of 'PanelPropItemList'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						PanelPropItemList.TABLE_HEIGHT ...
						PanelPropItemList.SELECTED ...
						PanelPropItemList.COLS ...
						PanelPropItemList.ROWNAME ...
						PanelPropItemList.COLUMNNAME ...
						PanelPropItemList.COLUMNWIDTH ...
						PanelPropItemList.COLUMNEDITABLE ...
						PanelPropItemList.COLUMNFORMAT ...
						PanelPropItemList.CB_TAB_EDIT ...
						PanelPropItemList.TABLE ...
						PanelPropItemList.MENU_OPEN_ITEMS ...
						PanelPropItemList.MENU_EXPORT ...
						PanelPropItemList.CONTEXTMENU ...
						PanelPropItemList.GUI_ITS_DICT ...
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
						PanelPropItemList.TABLE ...
						PanelPropItemList.CONTEXTMENU ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						PanelPropItemList.TABLE_HEIGHT ...
						PanelPropItemList.SELECTED ...
						PanelPropItemList.COLS ...
						PanelPropItemList.ROWNAME ...
						PanelPropItemList.COLUMNNAME ...
						PanelPropItemList.COLUMNWIDTH ...
						PanelPropItemList.COLUMNEDITABLE ...
						PanelPropItemList.COLUMNFORMAT ...
						PanelPropItemList.CB_TAB_EDIT ...
						PanelPropItemList.MENU_OPEN_ITEMS ...
						PanelPropItemList.MENU_EXPORT ...
						PanelPropItemList.GUI_ITS_DICT ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of item-list prop panel.
			%
			% N = PanelPropItemList.GETPROPNUMBER() returns the property number of item-list prop panel.
			%
			% N = PanelPropItemList.GETPROPNUMBER(CATEGORY) returns the property number of item-list prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the item-list prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropItemList') returns the property number of 'PanelPropItemList'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelPropItemList.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in item-list prop panel/error.
			%
			% CHECK = PanelPropItemList.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropItemList, PROP) checks whether PROP exists for PanelPropItemList.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropItemList:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropItemList:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropItemList:WrongInput]
			%  Element.EXISTSPROP(PanelPropItemList, PROP) throws error if PROP does NOT exist for PanelPropItemList.
			%   Error id: [BRAPH2:PanelPropItemList:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelPropItemList.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropItemList:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropItemList:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropItemList.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in item-list prop panel/error.
			%
			% CHECK = PanelPropItemList.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropItemList, TAG) checks whether TAG exists for PanelPropItemList.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropItemList:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropItemList:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropItemList:WrongInput]
			%  Element.EXISTSTAG(PanelPropItemList, TAG) throws error if TAG does NOT exist for PanelPropItemList.
			%   Error id: [BRAPH2:PanelPropItemList:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelpropitemlist_tag_list = cellfun(@(x) PanelPropItemList.getPropTag(x), num2cell(PanelPropItemList.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelpropitemlist_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropItemList:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropItemList:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropItemList.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropItemList, POINTER) returns property number of POINTER of PanelPropItemList.
			%  PROPERTY = PR.GETPROPPROP(PanelPropItemList, POINTER) returns property number of POINTER of PanelPropItemList.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelpropitemlist_tag_list = cellfun(@(x) PanelPropItemList.getPropTag(x), num2cell(PanelPropItemList.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelpropitemlist_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PanelPropItemList, POINTER) returns tag of POINTER of PanelPropItemList.
			%  TAG = PR.GETPROPTAG(PanelPropItemList, POINTER) returns tag of POINTER of PanelPropItemList.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelPropItemList.TABLE_HEIGHT
						tag = PanelPropItemList.TABLE_HEIGHT_TAG;
					case PanelPropItemList.SELECTED
						tag = PanelPropItemList.SELECTED_TAG;
					case PanelPropItemList.COLS
						tag = PanelPropItemList.COLS_TAG;
					case PanelPropItemList.ROWNAME
						tag = PanelPropItemList.ROWNAME_TAG;
					case PanelPropItemList.COLUMNNAME
						tag = PanelPropItemList.COLUMNNAME_TAG;
					case PanelPropItemList.COLUMNWIDTH
						tag = PanelPropItemList.COLUMNWIDTH_TAG;
					case PanelPropItemList.COLUMNEDITABLE
						tag = PanelPropItemList.COLUMNEDITABLE_TAG;
					case PanelPropItemList.COLUMNFORMAT
						tag = PanelPropItemList.COLUMNFORMAT_TAG;
					case PanelPropItemList.CB_TAB_EDIT
						tag = PanelPropItemList.CB_TAB_EDIT_TAG;
					case PanelPropItemList.TABLE
						tag = PanelPropItemList.TABLE_TAG;
					case PanelPropItemList.MENU_OPEN_ITEMS
						tag = PanelPropItemList.MENU_OPEN_ITEMS_TAG;
					case PanelPropItemList.MENU_EXPORT
						tag = PanelPropItemList.MENU_EXPORT_TAG;
					case PanelPropItemList.CONTEXTMENU
						tag = PanelPropItemList.CONTEXTMENU_TAG;
					case PanelPropItemList.GUI_ITS_DICT
						tag = PanelPropItemList.GUI_ITS_DICT_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropItemList, POINTER) returns category of POINTER of PanelPropItemList.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropItemList, POINTER) returns category of POINTER of PanelPropItemList.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropItemList.getPropProp(pointer);
			
			switch prop
				case PanelPropItemList.TABLE_HEIGHT
					prop_category = PanelPropItemList.TABLE_HEIGHT_CATEGORY;
				case PanelPropItemList.SELECTED
					prop_category = PanelPropItemList.SELECTED_CATEGORY;
				case PanelPropItemList.COLS
					prop_category = PanelPropItemList.COLS_CATEGORY;
				case PanelPropItemList.ROWNAME
					prop_category = PanelPropItemList.ROWNAME_CATEGORY;
				case PanelPropItemList.COLUMNNAME
					prop_category = PanelPropItemList.COLUMNNAME_CATEGORY;
				case PanelPropItemList.COLUMNWIDTH
					prop_category = PanelPropItemList.COLUMNWIDTH_CATEGORY;
				case PanelPropItemList.COLUMNEDITABLE
					prop_category = PanelPropItemList.COLUMNEDITABLE_CATEGORY;
				case PanelPropItemList.COLUMNFORMAT
					prop_category = PanelPropItemList.COLUMNFORMAT_CATEGORY;
				case PanelPropItemList.CB_TAB_EDIT
					prop_category = PanelPropItemList.CB_TAB_EDIT_CATEGORY;
				case PanelPropItemList.TABLE
					prop_category = PanelPropItemList.TABLE_CATEGORY;
				case PanelPropItemList.MENU_OPEN_ITEMS
					prop_category = PanelPropItemList.MENU_OPEN_ITEMS_CATEGORY;
				case PanelPropItemList.MENU_EXPORT
					prop_category = PanelPropItemList.MENU_EXPORT_CATEGORY;
				case PanelPropItemList.CONTEXTMENU
					prop_category = PanelPropItemList.CONTEXTMENU_CATEGORY;
				case PanelPropItemList.GUI_ITS_DICT
					prop_category = PanelPropItemList.GUI_ITS_DICT_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropItemList, POINTER) returns format of POINTER of PanelPropItemList.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropItemList, POINTER) returns format of POINTER of PanelPropItemList.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropItemList.getPropProp(pointer);
			
			switch prop
				case PanelPropItemList.TABLE_HEIGHT
					prop_format = PanelPropItemList.TABLE_HEIGHT_FORMAT;
				case PanelPropItemList.SELECTED
					prop_format = PanelPropItemList.SELECTED_FORMAT;
				case PanelPropItemList.COLS
					prop_format = PanelPropItemList.COLS_FORMAT;
				case PanelPropItemList.ROWNAME
					prop_format = PanelPropItemList.ROWNAME_FORMAT;
				case PanelPropItemList.COLUMNNAME
					prop_format = PanelPropItemList.COLUMNNAME_FORMAT;
				case PanelPropItemList.COLUMNWIDTH
					prop_format = PanelPropItemList.COLUMNWIDTH_FORMAT;
				case PanelPropItemList.COLUMNEDITABLE
					prop_format = PanelPropItemList.COLUMNEDITABLE_FORMAT;
				case PanelPropItemList.COLUMNFORMAT
					prop_format = PanelPropItemList.COLUMNFORMAT_FORMAT;
				case PanelPropItemList.CB_TAB_EDIT
					prop_format = PanelPropItemList.CB_TAB_EDIT_FORMAT;
				case PanelPropItemList.TABLE
					prop_format = PanelPropItemList.TABLE_FORMAT;
				case PanelPropItemList.MENU_OPEN_ITEMS
					prop_format = PanelPropItemList.MENU_OPEN_ITEMS_FORMAT;
				case PanelPropItemList.MENU_EXPORT
					prop_format = PanelPropItemList.MENU_EXPORT_FORMAT;
				case PanelPropItemList.CONTEXTMENU
					prop_format = PanelPropItemList.CONTEXTMENU_FORMAT;
				case PanelPropItemList.GUI_ITS_DICT
					prop_format = PanelPropItemList.GUI_ITS_DICT_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropItemList, POINTER) returns description of POINTER of PanelPropItemList.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropItemList, POINTER) returns description of POINTER of PanelPropItemList.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropItemList.getPropProp(pointer);
			
			switch prop
				case PanelPropItemList.TABLE_HEIGHT
					prop_description = 'TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.';
				case PanelPropItemList.SELECTED
					prop_description = 'SELECTED (gui, cvector) is the list of selected items.';
				case PanelPropItemList.COLS
					prop_description = 'COLS (gui, rvector) is the ordered list of columns.';
				case PanelPropItemList.ROWNAME
					prop_description = 'ROWNAME (gui, stringlist) determines the table row names.';
				case PanelPropItemList.COLUMNNAME
					prop_description = 'COLUMNNAME (gui, stringlist) determines the table column names.';
				case PanelPropItemList.COLUMNWIDTH
					prop_description = 'COLUMNWIDTH (gui, stringlist) determines the column widths.';
				case PanelPropItemList.COLUMNEDITABLE
					prop_description = 'COLUMNEDITABLE (gui, rvector) determines whether the columns are editable.';
				case PanelPropItemList.COLUMNFORMAT
					prop_description = 'COLUMNFORMAT (gui, stringlist) determines the columns formats.';
				case PanelPropItemList.CB_TAB_EDIT
					prop_description = 'CB_TAB_EDIT (gui, string) is executed when a cell is updated (to be evaluated).';
				case PanelPropItemList.TABLE
					prop_description = 'TABLE (evanescent, handle) is the table.';
				case PanelPropItemList.MENU_OPEN_ITEMS
					prop_description = 'MENU_OPEN_ITEMS (gui, logical) determines whether to show the context menu to open the items.';
				case PanelPropItemList.MENU_EXPORT
					prop_description = 'MENU_EXPORT (gui, logical) determines whether to show the context menu to export data.';
				case PanelPropItemList.CONTEXTMENU
					prop_description = 'CONTEXTMENU (evanescent, handle) is the context menu.';
				case PanelPropItemList.GUI_ITS_DICT
					prop_description = 'GUI_ITS_DICT (gui, idict) contains the GUIs for the items.';
				case PanelPropItemList.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the item-list property panel.';
				case PanelPropItemList.NAME
					prop_description = 'NAME (constant, string) is the name of the item-list property panel.';
				case PanelPropItemList.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the item-list property panel.';
				case PanelPropItemList.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the item-list property panel.';
				case PanelPropItemList.ID
					prop_description = 'ID (data, string) is a few-letter code for the item-list property panel.';
				case PanelPropItemList.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the item-list property panel.';
				case PanelPropItemList.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the item-list property panel.';
				case PanelPropItemList.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelPropItemList.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PanelPropItemList.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case PanelPropItemList.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the table.';
				case PanelPropItemList.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case PanelPropItemList.SHOW
					prop_description = 'SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.';
				case PanelPropItemList.HIDE
					prop_description = 'HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.';
				case PanelPropItemList.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
				case PanelPropItemList.CLOSE
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropItemList, POINTER) returns settings of POINTER of PanelPropItemList.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropItemList, POINTER) returns settings of POINTER of PanelPropItemList.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropItemList.getPropProp(pointer);
			
			switch prop
				case PanelPropItemList.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case PanelPropItemList.SELECTED
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case PanelPropItemList.COLS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PanelPropItemList.ROWNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case PanelPropItemList.COLUMNNAME
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case PanelPropItemList.COLUMNWIDTH
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case PanelPropItemList.COLUMNEDITABLE
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case PanelPropItemList.COLUMNFORMAT
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case PanelPropItemList.CB_TAB_EDIT
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PanelPropItemList.TABLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropItemList.MENU_OPEN_ITEMS
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelPropItemList.MENU_EXPORT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelPropItemList.CONTEXTMENU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropItemList.GUI_ITS_DICT
					prop_settings = 'GUI';
				case PanelPropItemList.TEMPLATE
					prop_settings = 'PanelPropItemList';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropItemList.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropItemList.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropItemList, POINTER) returns the default value of POINTER of PanelPropItemList.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropItemList, POINTER) returns the default value of POINTER of PanelPropItemList.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropItemList.getPropProp(pointer);
			
			switch prop
				case PanelPropItemList.TABLE_HEIGHT
					prop_default = s(20);
				case PanelPropItemList.SELECTED
					prop_default = Format.getFormatDefault(Format.CVECTOR, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.COLS
					prop_default = Format.getFormatDefault(Format.RVECTOR, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.ROWNAME
					prop_default = Format.getFormatDefault(Format.STRINGLIST, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.COLUMNNAME
					prop_default = Format.getFormatDefault(Format.STRINGLIST, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.COLUMNWIDTH
					prop_default = Format.getFormatDefault(Format.STRINGLIST, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.COLUMNEDITABLE
					prop_default = Format.getFormatDefault(Format.RVECTOR, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.COLUMNFORMAT
					prop_default = Format.getFormatDefault(Format.STRINGLIST, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.CB_TAB_EDIT
					prop_default = Format.getFormatDefault(Format.STRING, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.TABLE
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.MENU_OPEN_ITEMS
					prop_default = true;
				case PanelPropItemList.MENU_EXPORT
					prop_default = false;
				case PanelPropItemList.CONTEXTMENU
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.GUI_ITS_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.ELCLASS
					prop_default = 'PanelPropItemList';
				case PanelPropItemList.NAME
					prop_default = 'Item-List Prop Panel';
				case PanelPropItemList.DESCRIPTION
					prop_default = 'An Item-List Prop Panel (PanelPropItemList) plots the panel for a ITEMLIST property with a table. It works for all categories. It can be personalized with the following props: COLS, ROWNAME, COLUMNAME, COLUMNWIDTH, COLUMNEDITABLE, COLUMNFORMAT, CB_TAB_EDIT.';
				case PanelPropItemList.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.ID
					prop_default = 'PanelPropItemList ID';
				case PanelPropItemList.LABEL
					prop_default = 'PanelPropItemList label';
				case PanelPropItemList.NOTES
					prop_default = 'PanelPropItemList notes';
				case PanelPropItemList.EL
					prop_default = IndexedDictionary();
				case PanelPropItemList.PROP
					prop_default = IndexedDictionary.IT_LIST;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropItemList.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropItemList.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropItemList, POINTER) returns the conditioned default value of POINTER of PanelPropItemList.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropItemList, POINTER) returns the conditioned default value of POINTER of PanelPropItemList.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropItemList.getPropProp(pointer);
			
			prop_default = PanelPropItemList.conditioning(prop, PanelPropItemList.getPropDefault(prop));
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
			
			prop = PanelPropItemList.getPropProp(pointer);
			
			switch prop
				case PanelPropItemList.SELECTED % __PanelPropItemList.SELECTED__
					if isrow(value)
					    value = value';
					end
					
				case PanelPropItemList.CB_TAB_EDIT % __PanelPropItemList.CB_TAB_EDIT__
					if iscell(value)
					    value = sprintf('%s;', value{:});
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = conditioning@PanelProp(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % preset
		function value = preset(pr, prop, value)
			%PRESET preprocesses the value of a property before setting it.
			%
			% VALUE = PRESET(EL, PROP, VALUE) prepropcesses the VALUE of the property
			%  PROP. It works only with properties with Category.METADATA,
			%  Category.PARAMETER, Category.DATA, Category.FIGURE and Category.GUI. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% See also conditioning, checkProp, postset, postprocessing,
			%  calculateValue, checkValue.
			
			switch prop
				case PanelPropItemList.COLS % __PanelPropItemList.COLS__
					if isempty(value)
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    it_class = el.getPropSettings(prop);
					
					    % columns to be to be shown in the table
					    % col = pr.SELECTOR for the selector column
					    % col = prop for the prop columns
					    cols = [pr.SELECTOR Element.getProps(it_class)];
					    
					    value = cols;
					end
					
				case PanelPropItemList.ROWNAME % __PanelPropItemList.ROWNAME__
					if isempty(value)
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    it_list = el.get(prop);
					    
					    rowname = cellfun(@(it) it.get('ID'), it_list, 'UniformOutput', false);
					    
					    value = rowname;
					    
					elseif isequal(value, 'numbered')
					    value = {'numbered'};
					end
					
				case PanelPropItemList.COLUMNNAME % __PanelPropItemList.COLUMNNAME__
					if isempty(value)
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    it_class = el.getPropSettings(prop);
					
					    cols = pr.memorize('COLS');
					    
					    columnname = repmat({''}, 1, length(cols));
					    for c = 1:1:length(cols)
					        col = cols(c);
					        if col == pr.SELECTOR
					            columnname{c} = '';
					        elseif Element.existsProp(it_class, col) % prop = col;
					            columnname{c} = Element.getPropTag(it_class, col);
					        end
					    end
					    
					    value = columnname;
					    
					elseif isequal(value, 'numbered')
					    value = {'numbered'};
					end
					
				case PanelPropItemList.COLUMNWIDTH % __PanelPropItemList.COLUMNWIDTH__
					if isempty(value) || isequal(value, 'auto')
					    columnwidth = {'auto'};
					    
					    value = columnwidth;
					end
					
				case PanelPropItemList.COLUMNEDITABLE % __PanelPropItemList.COLUMNEDITABLE__
					if isempty(value)
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    it_class = el.getPropSettings(prop);
					    
					    cols = pr.memorize('COLS');
					    
					    columneditable = false(1, length(cols));
					    for c = 1:1:length(cols)
					        col = cols(c);
					        if col == pr.SELECTOR
					            columneditable(c) = true; % always true
					        else
					            if ~el.isLocked(prop)
					                switch Element.getPropFormat(it_class, col)
					                    case Format.EMPTY % __Format.EMPTY__
					                        %%%__WARN_TBI__
					                    
					                    case Format.STRING % __Format.STRING__
					                        columneditable(c) = true;
					                        
					                    case Format.STRINGLIST % __Format.STRINGLIST__
					                        %%%__WARN_TBI__
					
					                    case Format.LOGICAL % __Format.LOGICAL__
					                        columneditable(c) = true;
					                        
					                    case Format.OPTION % __Format.OPTION__
					                        columneditable(c) = true;
					                        
					                    case Format.CLASS % __Format.CLASS__
					                        %%%__WARN_TBI__
					
					                    case Format.CLASSLIST % __Format.CLASSLIST__
					                        %%%__WARN_TBI__
					                        
					                    case Format.ITEM % __Format.ITEM__
					                        columneditable(c) = false;
					                        
					                    case Format.ITEMLIST % __Format.ITEMLIST__
					                        %%%__WARN_TBI__
					
					                    case Format.IDICT % __Format.IDICT__
					                        columneditable(c) = false;
					                        
					                    case Format.SCALAR % __Format.SCALAR__
					                        columneditable(c) = true;
					                        
					                    case {Format.RVECTOR Format.CVECTOR Format.MATRIX Format.SMATRIX} % {__Format.RVECTOR__ __Format.CVECTOR__ __Format.MATRIX__ __Format.SMATRIX__}
					                        columneditable(c) = false;
					                        
					                    case Format.CELL % __Format.CELL__
					                        %%%__WARN_TBI__
					
					                    case Format.NET % __Format.NET__
					                        %%%__WARN_TBI__
					                        
					                    case Format.HANDLE % __Format.HANDLE__
					                        %%%__WARN_TBI__
					
					                    case Format.HANDLELIST % __Format.HANDLELIST__
					                        %%%__WARN_TBI__
					
					                    case Format.COLOR % __Format.COLOR__
					                        columneditable(c) = true;
					                        
					                    case Format.ALPHA % __Format.ALPHA__
					                        columneditable(c) = true;
					                        
					                    case Format.SIZE % __Format.SIZE__
					                        columneditable(c) = true;
					                        
					                    case Format.MARKER % __Format.MARKER__
					                        columneditable(c) = true;
					                        
					                    case Format.LINE % __Format.LINE__
					                        columneditable(c) = true;
					                end
					            end
					        end
					    end
					    
					    value = columneditable;
					end
					
					% ensures that the value is numeric (not logical)
					value = int8(columneditable);
					
				case PanelPropItemList.COLUMNFORMAT % __PanelPropItemList.COLUMNFORMAT__
					if isempty(value)
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    it_class = el.getPropSettings(prop);
					    
					    cols = pr.memorize('COLS');
					
					    columnformat = repmat({''}, 1, length(cols));
					    for c = 1:1:length(cols)
					        col = cols(c);
					        if col == pr.SELECTOR
					            columnformat{c} = 'logical';
					        elseif Element.existsProp(it_class, col) % prop = col;
					            switch Element.getPropFormat(it_class, col)
					                case Format.EMPTY % __Format.EMPTY__
					                    %%%__WARN_TBI__
					
					                case Format.STRING % __Format.STRING__
					                    columnformat{c} = 'char';
					
					                case Format.STRINGLIST % __Format.STRINGLIST__
					                    %%%__WARN_TBI__
					
					                case Format.LOGICAL % __Format.LOGICAL__
					                    columnformat{c} = 'logical';
					
					                case Format.OPTION % __Format.OPTION__
					                    columnformat{c} = Element.getPropSettings(it_class, col);
					
					                case Format.CLASS % __Format.CLASS__
					                    %%%__WARN_TBI__
					
					                case Format.CLASSLIST % __Format.CLASSLIST__
					                    %%%__WARN_TBI__
					
					                case Format.ITEM % __Format.ITEM__
					                    columnformat{c} = 'char';
					
					                case Format.ITEMLIST % __Format.ITEMLIST__
					                    %%%__WARN_TBI__
					
					                case Format.IDICT % __Format.IDICT__
					                    columnformat{c} = 'char';
					
					                case Format.SCALAR % __Format.SCALAR__
					                    columnformat{c} = 'numeric';
					
					                case {Format.RVECTOR Format.CVECTOR Format.MATRIX Format.SMATRIX} % {__Format.RVECTOR__ __Format.CVECTOR__ __Format.MATRIX__ __Format.SMATRIX__}
					                    columnformat{c} = 'char';
					
					                case Format.CELL % __Format.CELL__
					                    %%%__WARN_TBI__
					
					                case Format.NET % __Format.NET__
					                    %%%__WARN_TBI__
					
					                case Format.HANDLE % __Format.HANDLE__
					                    %%%__WARN_TBI__
					
					                case Format.HANDLELIST % __Format.HANDLELIST__
					                    %%%__WARN_TBI__
					
					                case Format.COLOR % __Format.COLOR__
					                    columnformat{c} = 'char';
					
					                case Format.ALPHA % __Format.ALPHA__
					                    columnformat{c} = 'numeric';
					
					                case Format.SIZE % __Format.SIZE__
					                    columnformat{c} = 'numeric';
					
					                case Format.MARKER % __Format.MARKER__
					                    columnformat{c} = Element.getPropSettings(it_class, col);
					
					                case Format.LINE % __Format.LINE__
					                    columnformat{c} = Element.getPropSettings(it_class, col);
					            end            
					        end
					    end
					    
					    value = columnformat;
					end
					
					for i = 1:1:length(value)
					    if iscell(value{i})
					        value{i} = cell2str(value{i});
					    end
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = preset@PanelProp(pr, prop, value);
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
			%  CHECK = Element.CHECKPROP(PanelPropItemList, PROP, VALUE) checks VALUE format for PROP of PanelPropItemList.
			%  CHECK = PR.CHECKPROP(PanelPropItemList, PROP, VALUE) checks VALUE format for PROP of PanelPropItemList.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelPropItemList:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelPropItemList:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelPropItemList, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropItemList.
			%   Error id: €BRAPH2.STR€:PanelPropItemList:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelPropItemList, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropItemList.
			%   Error id: €BRAPH2.STR€:PanelPropItemList:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropItemList')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropItemList.getPropProp(pointer);
			
			switch prop
				case PanelPropItemList.TABLE_HEIGHT % __PanelPropItemList.TABLE_HEIGHT__
					check = Format.checkFormat(Format.SIZE, value, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.SELECTED % __PanelPropItemList.SELECTED__
					check = Format.checkFormat(Format.CVECTOR, value, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.COLS % __PanelPropItemList.COLS__
					check = Format.checkFormat(Format.RVECTOR, value, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.ROWNAME % __PanelPropItemList.ROWNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.COLUMNNAME % __PanelPropItemList.COLUMNNAME__
					check = Format.checkFormat(Format.STRINGLIST, value, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.COLUMNWIDTH % __PanelPropItemList.COLUMNWIDTH__
					check = Format.checkFormat(Format.STRINGLIST, value, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.COLUMNEDITABLE % __PanelPropItemList.COLUMNEDITABLE__
					check = Format.checkFormat(Format.RVECTOR, value, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.COLUMNFORMAT % __PanelPropItemList.COLUMNFORMAT__
					check = Format.checkFormat(Format.STRINGLIST, value, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.CB_TAB_EDIT % __PanelPropItemList.CB_TAB_EDIT__
					check = Format.checkFormat(Format.STRING, value, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.TABLE % __PanelPropItemList.TABLE__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.MENU_OPEN_ITEMS % __PanelPropItemList.MENU_OPEN_ITEMS__
					check = Format.checkFormat(Format.LOGICAL, value, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.MENU_EXPORT % __PanelPropItemList.MENU_EXPORT__
					check = Format.checkFormat(Format.LOGICAL, value, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.CONTEXTMENU % __PanelPropItemList.CONTEXTMENU__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.GUI_ITS_DICT % __PanelPropItemList.GUI_ITS_DICT__
					check = Format.checkFormat(Format.IDICT, value, PanelPropItemList.getPropSettings(prop));
				case PanelPropItemList.TEMPLATE % __PanelPropItemList.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelPropItemList.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropItemList:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropItemList:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropItemList.getPropTag(prop) ' (' PanelPropItemList.getFormatTag(PanelPropItemList.getPropFormat(prop)) ').'] ...
					)
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
				case PanelPropItemList.TABLE % __PanelPropItemList.TABLE__
					table = uitable( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'table', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'ColumnSortable', true, ...
					    'CellEditCallback', {@cb_table} ...
					    );
					value = table;
					
				case PanelPropItemList.CONTEXTMENU % __PanelPropItemList.CONTEXTMENU__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					it_class = el.getPropSettings(prop);
					    
					contextmenu = uicontextmenu( ...
					    'Parent', ancestor(pr.get('H'), 'figure'), ...
					    'Tag', 'CONTEXTMENU' ...
					    );
					menu_select_all = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_SELECT_ALL', ...
					    'Text', 'Select All', ...
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
					menu_apply_to_selection = uimenu( ...
					    'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_APPLY_TO_SELECTION', ...
					    'Text', 'Apply to Selection', ...
					    'Checked', false ...
					    );
					set(menu_apply_to_selection, ...
					    'MenuSelectedFcn', {@cb_apply_to_selection, menu_apply_to_selection} ...
					    );
					if pr.get('MENU_OPEN_ITEMS')
					    menu_open_selection = uimenu( ...
					        'Separator', 'on', ...
					        'Parent', contextmenu, ...
					        'Tag', 'MENU_OPEN_SELECTION', ...
					        'Text', 'Open Selection', ...
					        'MenuSelectedFcn', {@cb_open_selection} ...
					        );
					    menu_hide_selection = uimenu( ...
					        'Parent', contextmenu, ...
					        'Tag', 'MENU_HIDE_SELECTION', ...
					        'Text', 'Hide Selection', ...
					        'MenuSelectedFcn', {@cb_hide_selection} ...
					        );
					    menu_hide_all = uimenu( ...
					        'Parent', contextmenu, ...
					        'Tag', 'MENU_HIDE_ALL', ...
					        'Text', 'Hide All', ...
					        'MenuSelectedFcn', {@cb_hide_all} ...
					        );
					end
					if (isempty(pr.get('COLS')) && any(cellfun(@(prop) isequal(Element.getPropFormat(it_class, prop), Format.COLOR), num2cell(Element.getProps(it_class))))) ...
					        || any(cellfun(@(prop) prop > 0 && isequal(Element.getPropFormat(it_class, prop), Format.COLOR), num2cell(pr.get('COLS'))))
					    menu_colorize_table = uimenu( ...
					        'Separator', 'on', ...
					        'Parent', contextmenu, ...
					        'Tag', 'MENU_COLORIZE_TABLE', ...
					        'Text', 'Colorize Table', ...
					        'Checked', false ...
					        );
						set(menu_colorize_table, ...
					        'MenuSelectedFcn', {@cb_colorize_table, menu_colorize_table} ...
					        );
					end
					if pr.get('MENU_EXPORT')
					    menu_export_to_xls = uimenu( ...
					        'Separator', 'on', ...
					        'Parent', contextmenu, ...
					        'Tag', 'MENU_EXPORT_TO_XLS', ...
					        'Text', 'Export to XLS', ...
					        'MenuSelectedFcn', {@cb_export_to_xls});
					end
					if isempty(pr.get('COLS')) || ismember(pr.SELECTOR, pr.get('COLS'))
					    set(pr.get('TABLE'), 'ContextMenu', contextmenu)
					end
					
					value = contextmenu;
					
				case PanelPropItemList.X_DRAW % __PanelPropItemList.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value 
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					end
					
				case PanelPropItemList.UPDATE % __PanelPropItemList.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value 
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    if any(el.getPropCategory(prop) == [Category.RESULT Category.QUERY Category.EVANESCENT]) && isa(el.getr(prop), 'NoValue')
					        pr.set('HEIGHT', s(2))
					    else
					        it_list = el.get(prop);
					        pr.set('HEIGHT', min(s(4.5) + s(2) * length(it_list), pr.get('TABLE_HEIGHT')))
					    end
					
					    switch el.getPropCategory(prop)
					        case Category.CONSTANT % __Category.CONSTANT__
					            set_table()
					            set(pr.get('TABLE'), 'ColumnEditable', false)
					            
					        case Category.METADATA % __Category.METADATA__
					            set_table()
					
					            if el.isLocked(prop)
					                set(pr.get('TABLE'), 'ColumnEditable', false)
					            end
					        case {Category.PARAMETER Category.DATA Category.FIGURE Category.GUI} % {__Category.PARAMETER__ __Category.DATA__ __Category.FIGURE__ __Category.GUI__}
					            set_table()
					            
					            if el.isLocked(prop)
					                set(pr.get('TABLE'), 'ColumnEditable', false)
					            end
					            
					            prop_value = el.getr(prop);
					            if isa(prop_value, 'Callback')
					                set(pr.get('TABLE'), 'ColumnEditable', false)
					            end
					
					        case {Category.RESULT Category.QUERY Category.EVANESCENT} % {__Category.RESULT__ __Category.QUERY__ __Category.EVANESCENT__}
					            prop_value = el.getr(prop);
					
					            if isa(prop_value, 'NoValue')
					                % don't plot anything for a result not yet calculated
					                set(pr.get('TABLE'), 'Visible', 'off')
					            else
					                set_table()
					                set(pr.get('TABLE'), 'Visible', 'on')
					            end
					    end
					end
					
				case PanelPropItemList.REDRAW % __PanelPropItemList.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('TABLE'), 'Position', [s(.3) s(.3) w_p-s(.6) max(1, pr.get('HEIGHT')-s(2.2))])
					end
					
				case PanelPropItemList.SHOW % __PanelPropItemList.SHOW__
					value = calculateValue@PanelProp(pr, PanelProp.SHOW, varargin{:}); % also warning
					if value
					    % figures for items
					    gui_its_dict = pr.get('GUI_ITS_DICT');
					    for i = 1:1:gui_its_dict.get('LENGTH')
					        gui = gui_its_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('SHOW')
					        end
					    end
					end
					
				case PanelPropItemList.HIDE % __PanelPropItemList.HIDE__
					value = calculateValue@PanelProp(pr, PanelProp.HIDE, varargin{:}); % also warning
					if value    
					    % figures for items
					    gui_its_dict = pr.get('GUI_ITS_DICT');
					    for i = 1:1:gui_its_dict.get('LENGTH')
					        gui = gui_its_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('HIDE')
					        end
					    end
					end
					
				case PanelPropItemList.DELETE % __PanelPropItemList.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('TABLE', Element.getNoValue())
					    pr.set('CONTEXTMENU', Element.getNoValue())
					end
					
				case PanelPropItemList.CLOSE % __PanelPropItemList.CLOSE__
					value = calculateValue@PanelProp(pr, PanelProp.CLOSE, varargin{:}); % also warning
					if value
					    % figures for items
					    gui_its_dict = pr.get('GUI_ITS_DICT');
					    for i = 1:1:gui_its_dict.get('LENGTH')
					        gui = gui_its_dict.get('IT', i);
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
			    menu_apply_to_selection = findobj(pr.get('CONTEXTMENU'), 'Tag', 'MENU_APPLY_TO_SELECTION');
				if ~get(menu_apply_to_selection, 'Checked')
			        cols = pr.get('COLS');
			        cb_table_edit(event.Indices(1), cols(event.Indices(2)), event.NewData)
			    else
			        cols = pr.get('COLS');
			
			        % adds current item to selected
			        if cols(event.Indices(2)) == pr.SELECTOR
			            cb_table_edit(event.Indices(1), pr.SELECTOR, event.NewData)
			        else
			            cb_table_edit(event.Indices(1), pr.SELECTOR, true)
			        end
			
			        % updates all selected
			        selected = pr.get('SELECTED');
			        for s = 1:1:length(selected)
			            cb_table_edit(selected(s), cols(event.Indices(2)), event.NewData)
			        end
				end
			
			    pr.get('UPDATE') % placed here for numerical efficiency
			
			    function cb_table_edit(i, col, newdata)
			
			        el = pr.get('EL');
			        prop = pr.get('PROP');
			        
			        it_class = el.getPropSettings(prop);
			        
			        if ~isempty(pr.get('CB_TAB_EDIT'))
			            eval(pr.get('CB_TAB_EDIT'))
			        else
			            cb_table_edit_default()
			        end
			        function cb_table_edit_default()
			            if col == pr.SELECTOR
			                selected = pr.get('SELECTED');
			                if newdata == 1
			                    pr.set('SELECTED', sort(unique([selected; i])));
			                else
			                    pr.set('SELECTED', selected(selected ~= i));
			                end
			            elseif Element.existsProp(it_class, col) % prop = col;
			                switch Element.getPropFormat(it_class, col)
			                    case Format.EMPTY % __Format.EMPTY__
			                        %%%__WARN_TBI__
			    
			                    case Format.STRING % __Format.STRING__
			                        dict.get('IT', i).set(col, newdata)
			                        
			                    case Format.STRINGLIST % __Format.STRINGLIST__
			                        %%%__WARN_TBI__
			
			                    case Format.LOGICAL % __Format.LOGICAL__
			                        dict.get('IT', i).set(col, newdata)
			    
			                    case Format.OPTION % __Format.OPTION__
			                        dict.get('IT', i).set(col, newdata)
			    
			                    case Format.CLASS % __Format.CLASS__
			                        %%%__WARN_TBI__
			    
			                    case Format.CLASSLIST % __Format.CLASSLIST__
			                        %%%__WARN_TBI__
			    
			                    case Format.ITEM % __Format.ITEM__
			                        %
			    
			                    case Format.ITEMLIST % __Format.ITEMLIST__
			                        %%%__WARN_TBI__
			    
			                    case Format.IDICT % __Format.IDICT__
			                        %
			    
			                    case Format.SCALAR % __Format.SCALAR__ % __Format.SCALAR__
			                        dict.get('IT', i).set(col, newdata)
			    
			                    case {Format.RVECTOR Format.CVECTOR Format.MATRIX Format.SMATRIX} % {__Format.RVECTOR__ __Format.CVECTOR__ __Format.MATRIX__ __Format.SMATRIX__}
			                        %
			    
			                    case Format.CELL % __Format.CELL__
			                        %%%__WARN_TBI__
			    
			                    case Format.NET % __Format.NET__
			                        %%%__WARN_TBI__
			    
			                    case Format.HANDLE % __Format.HANDLE__
			                        %%%__WARN_TBI__
			
			                    case Format.HANDLELIST % __Format.HANDLELIST__
			                        %%%__WARN_TBI__
			
			                    case Format.COLOR % __Format.COLOR__
			                        try
			                            rgb = [hex2dec(newdata(1:2))/255 hex2dec(newdata(3:4))/255 hex2dec(newdata(5:6))/255];
			                            dict.get('IT', i).set(col, rgb)
			                        catch
			                            %
			                        end
			    
			                    case Format.ALPHA % __Format.ALPHA__
			                        dict.get('IT', i).set(col, min(abs(newdata), 1))
			    
			                    case Format.SIZE % __Format.SIZE__
			                        if newdata ~= 0
			                            dict.get('IT', i).set(col, abs(newdata))
			                        end
			    
			                    case Format.MARKER % __Format.MARKER__
			                        dict.get('IT', i).set(col, newdata)
			    
			                    case Format.LINE % __Format.LINE__
			                        dict.get('IT', i).set(col, newdata)
			                end
			            end        
			        end
			        
			    % pr.get('UPDATE') % placed above for numerical efficiency
			    end
			
			end
			function cb_select_all(~, ~) 
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    it_list = el.get(prop);
			
			    pr.set('SELECTED', [1:1:length(it_list)])
			
			    pr.get('UPDATE')
			end
			function cb_clear_selection(~, ~) 
			    pr.set('SELECTED', [])
			
			    pr.get('UPDATE')
			end
			function cb_invert_selection(~, ~) 
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    it_list = el.get(prop);
			
			    selected_tmp = [1:1:length(it_list)];
			    selected_tmp(pr.get('SELECTED')) = [];
			    pr.set('SELECTED', selected_tmp)
			
			    pr.get('UPDATE')
			end
			function cb_apply_to_selection(~, ~, menu_apply_to_selection) 
			    if get(menu_apply_to_selection, 'Checked')
			        set(menu_apply_to_selection, 'Checked', false)
			    else
			        set(menu_apply_to_selection, 'Checked', true)
				end
			end
			function cb_open_selection(~, ~) 
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    it_list = el.get(prop);
			
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
			    N = ceil(sqrt(length(it_list))); % number of row and columns of figures
			    selected = pr.get('SELECTED');
			
			    gui_its_dict = pr.memorize('GUI_ITS_DICT');
			    
			    for s = 1:1:length(selected)
			        i = selected(s);
			
			        it = it_list{i};
			        key = int2str(i);
			        
			        if ~gui_its_dict.get('CONTAINS_KEY', key)
			            gui = GUIElement( ...
			                'ID', key, ... % the key is the position number of the item in the list
			                'PE', it, ... 
			                'POSITION', [ ...
			                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ... % x = (f_gr_x + f_gr_w) / screen_w + mod(selected_it - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
			                    y0(f, 'normalized') ... % y = f_gr_y / screen_h;
			                    w(f, 'normalized') ... % w = f_gr_w / screen_w;
			                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ... % h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_it - .5) / N)) / N / screen_h;
			                    ], ...
			                'WAITBAR', pr.getCallback('WAITBAR'), ...
			                'CLOSEREQ', false ...
			                );
			            gui_its_dict.get('ADD', gui)
			        end
			        
			        gui = gui_its_dict.get('IT', key);
			        if ~gui.get('DRAWN')
			            gui.get('DRAW')
			        end
			        gui.get('SHOW')
			    end
			end
			function cb_hide_selection(~, ~) 
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    selected = pr.get('SELECTED');
			    
			    gui_its_dict = pr.memorize('GUI_ITS_DICT');
			
			    for s = 1:1:length(selected)
			        key = int2str(selected(s));
			        
			        if gui_its_dict.get('CONTAINS_KEY', key)
			            gui = gui_its_dict.get('IT', key);
			            gui.get('HIDE')
			        end
			    end
			end
			function cb_hide_all(~, ~) 
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    it_list = el.get(prop);
			
			    gui_its_dict = pr.memorize('GUI_ITS_DICT');
			
			    for i = 1:1:length(it_list)
			        
			        key = int2str(i);
			        
			        if gui_its_dict.get('CONTAINS_KEY', key)
			            gui = gui_its_dict.get('IT', key);
			            gui.get('HIDE')
			        end
			    end
			end
			function cb_colorize_table(~, ~, menu_colorize_table)
			    if get(menu_colorize_table, 'Checked')
			        set(menu_colorize_table, 'Checked', false)
			    else
			        set(menu_colorize_table, 'Checked', true)
			    end
			    pr.get('UPDATE')
			end
			function cb_export_to_xls(~, ~)
			    if isempty(pr.get('SELECTED'))
			        el = pr.get('EL');
			        prop = pr.get('PROP');
			        dict = el.get(prop);
			
			        selected = [1:1:dict.get('LENGTH')];
			    else
			        selected = pr.get('SELECTED');
			    end
			    
			    % create data table
			    data = pr.get('TABLE').Data(selected, :);
			    columns = pr.get('TABLE').ColumnName;
			    rows = pr.get('TABLE').RowName;
			    % special rules: selection column, numbered rownames.
			    if isempty(columns{1})
			        columns{1} = 'sel';
			    end
			    if isequal(rows, 'numbered')
			        rows = cellfun(@(x) num2str(x), num2cell(selected), 'UniformOutput', false)';
			    elseif length(selected) ~= length(rows)
			        rows = rows(reshape(selected, [1 length(selected)]));
			    end
			    
			    t = cell2table(data, ...
			        'VariableNames', columns, ...
			        'RowNames', rows);
			
			    % save file
			    [filename, filepath, filterindex] = uiputfile({'*.xlsx';'*.xls'}, 'Select Excel file');
			    if filterindex
			        file = [filepath filename];
			        writetable(t, file, 'WriteRowNames', true);
			    end
			end
			function set_table()
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    it_list = el.get(prop);
			    it_class = el.getPropSettings(prop);
			
			    % columns to be to be shown in the table
			    % col = pr.SELECTOR for the selector column
			    % col = prop for the prop columns
			    if isempty(pr.get('COLS')) % empty pr.get('COLS')
			        pr.set('COLS', pr.get('COLS'))
			    end
				cols = pr.memorize('COLS');
			
			    % data
				data = cell(length(it_list), length(cols));
			    for i = 1:1:length(it_list)
			        for c = 1:1:length(cols)
			            col = cols(c);
			            if col == pr.SELECTOR
			                if any(pr.get('SELECTED') == i)
			                    data{i, c} = true;
			                else
			                    data{i, c} = false;
			                end
			            elseif Element.existsProp(it_class, col) % prop = col;
			                switch Element.getPropFormat(it_class, col)
			                    case Format.EMPTY % __Format.EMPTY__
			                        %%%__WARN_TBI__
			                    
			                    case Format.STRING % __Format.STRING__
			                        data{i, c} = it_list{i}.get(col);
			                        
			                    case Format.STRINGLIST % __Format.STRINGLIST__
			                        %%%__WARN_TBI__
			                    
			                    case Format.LOGICAL % __Format.LOGICAL__
			                        data{i, c} = it_list{i}.get(col);
			                        
			                    case Format.OPTION % __Format.OPTION__
			                        data{i, c} = it_list{i}.get(col);
			                        
			                    case Format.CLASS % __Format.CLASS__
			                        %%%__WARN_TBI__
			
			                    case Format.CLASSLIST % __Format.CLASSLIST__
			                        %%%__WARN_TBI__
			                        
			                    case Format.ITEM % __Format.ITEM__
			                        data{i, c} = it_list{i}.get(col).get('TOSTRING');
			                        
			                    case Format.ITEMLIST % __Format.ITEMLIST__
			                        %%%__WARN_TBI__
			
			                    case Format.IDICT % __Format.IDICT__
			                        data{i, c} = it_list{i}.get(col).get('TOSTRING');
			                        
			                    case Format.SCALAR % __Format.SCALAR__
			                        data{i, c} = it_list{i}.get(col);
			                        
			                    case {Format.RVECTOR Format.CVECTOR Format.MATRIX Format.SMATRIX} % {__Format.RVECTOR__ __Format.CVECTOR__ __Format.MATRIX__ __Format.SMATRIX__}
			                        prop_value = it_list{i}.get(col);
			                        data{i, c} = [int2str(size(prop_value, 1)) ' x ' int2str(size(prop_value, 2))];
			                        
			                    case Format.CELL % __Format.CELL__
			                        %%%__WARN_TBI__
			
			                    case Format.NET % __Format.NET__
			                        %%%__WARN_TBI__
			                        
			                    case Format.HANDLE % __Format.HANDLE__
			                        %%%__WARN_TBI__
			
			                    case Format.HANDLELIST % __Format.HANDLELIST__
			                        %%%__WARN_TBI__
			
			                    case Format.COLOR % __Format.COLOR__
			                        rgb = it_list{i}.get(col);
			                        data{i, c} = [dec2hex(round(rgb(1) * 255), 2) dec2hex(round(rgb(2) * 255), 2) dec2hex(round(rgb(3) * 255), 2)];
			                        
			                    case Format.ALPHA % __Format.ALPHA__
			                        data{i, c} = it_list{i}.get(col);
			                        
			                    case Format.SIZE % __Format.SIZE__
			                        data{i, c} = it_list{i}.get(col);
			                        
			                    case Format.MARKER % __Format.MARKER__
			                        data{i, c} = it_list{i}.get(col);
			                        
			                    case Format.LINE % __Format.LINE__
			                        data{i, c} = it_list{i}.get(col);
			                end
			            end
			        end
			    end
			    
			    % rowname: string list or {'numbered'}
			    rowname = pr.memorize('ROWNAME');
			    if isempty(rowname)
			        pr.set('ROWNAME', rowname)
			        rowname = pr.memorize('ROWNAME'); % triggers preset
			    elseif isequal(rowname, {'numbered'})
			        rowname = 'numbered';
			    end
			    
			    % columnname: string list or {'numbered'}
			    columnname = pr.memorize('COLUMNNAME');
			    if isequal(columnname, {'numbered'})
			        columnname = 'numbered';
			    end
			
			    % columnwidth
			    columnwidth = pr.memorize('COLUMNWIDTH');
			    if isequal(columnwidth, {'auto'})
			        columnwidth = 'auto';
			    end
			
			    % columneditable
			    columneditable = logical(pr.memorize('COLUMNEDITABLE'));
			
			    % columnformat
				columnformat = pr.memorize('COLUMNFORMAT');
			    for i = 1:1:length(columnformat)
			        columnformat_i_as_cell = str2cell(columnformat{i});
			        if length(columnformat_i_as_cell) ~= 1
			            columnformat{i} = columnformat_i_as_cell'; % ColumnFormat popupmenu definitions must be row vectors
			        end
			    end
			
			    set(pr.get('TABLE'), ...
			        'Data', data, ...
			        'RowName', rowname, ...
			        'ColumnName', columnname, ... 
			        'ColumnWidth', columnwidth, ...
			        'ColumnEditable', columneditable, ...
			        'ColumnFormat', columnformat ...
			        )
			
			    % style SELECTED
			    styles_row = find(pr.get('TABLE').StyleConfigurations.Target == 'row');
			    if ~isempty(styles_row)
			        removeStyle(pr.get('TABLE'), styles_row)
			    end
			    if ~isempty(pr.get('SELECTED'))
			        addStyle(pr.get('TABLE'), uistyle('FontWeight', 'bold'), 'row', pr.get('SELECTED'))
			    end
			        
			    % style COLOR
			    menu_colorize_table = findobj(pr.get('CONTEXTMENU'), 'Tag', 'MENU_COLORIZE_TABLE');
			    
			    styles_cell = find(pr.get('TABLE').StyleConfigurations.Target == 'cell');
			    if check_graphics(menu_colorize_table, 'uimenu') && get(menu_colorize_table, 'Checked')
			        if isempty(styles_cell)
			            for c = 1:1:length(cols)
			                col = cols(c);
			                if col > 0 && isequal(Element.getPropFormat(it_class, col), Format.COLOR)                            
			                    for i = 1:1:dict.get('LENGTH')
			                        addStyle(pr.get('TABLE'), ...
			                            uistyle('FontColor', dict.get('IT', i).get(col)), ...
			                            'cell', [i, c] ...
			                            )
			                    end
			                end
			            end
			        else
			            for c = 1:1:length(cols)
			                col = cols(c);
			                if col > 0 && isequal(Element.getPropFormat(it_class, col), Format.COLOR)
			                    for i = 1:1:dict.get('LENGTH')
			                        cell_to_be_removed = find(cellfun(@(x) isequal(x, [i, c]), pr.get('TABLE').StyleConfigurations.TargetIndex));
			                        if ~isempty(cell_to_be_removed)
			                            current_rgb = pr.get('TABLE').StyleConfigurations.Style(cell_to_be_removed).FontColor;
			                            new_rgb = dict.get('IT', i).get(col);
			                            if ~isequal(current_rgb, new_rgb)
			                                removeStyle(pr.get('TABLE'), cell_to_be_removed)
			                                addStyle(pr.get('TABLE'), ...
			                                    uistyle('FontColor', new_rgb), ...
			                                    'cell', [i, c] ...
			                                    )
			                            end
			                        end
			                    end
			                end
			            end
			        end
			    else
			        if ~isempty(styles_cell)
			            removeStyle(pr.get('TABLE'), styles_cell)
			        end
			    end
			end
		end
	end
end
