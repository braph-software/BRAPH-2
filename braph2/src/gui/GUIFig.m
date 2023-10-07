classdef GUIFig < GUI
	%GUIFig is a GUI for a figure.
	% It is a subclass of <a href="matlab:help GUI">GUI</a>.
	%
	% A Figure GUI (GUIFIG) renders a figure.
	% 
	% CONSTRUCTOR - To construct a GUI use, e.g.:
	% 
	%     gui = GUIElement(''PF'', <element>)
	%     
	% DRAW - To create the element figure, use:
	% 
	%     gui.get('<strong>DRAW</strong>')
	%     gui.get('<strong>SHOW</strong>')
	%     f = gui.get('<strong>H</strong>'); % f is the figure handle.
	%  
	%  The query gui.get('<strong>DRAWN</strong>') returns whether the GUI has 
	%   been drawn and therefore can be shown.
	%  
	% CALLBACK - These are the public callbacks:
	% 
	%     gui.get('<strong>RESIZE</strong>') - updates POSITION when figure size is changed
	%     gui.get('<strong>SHOW</strong>') - brings to the front the figure and its dependent figures
	%     gui.get('<strong>HIDE</strong>') - hides the figure and its dependent figures
	%     gui.get('<strong>DELETE</strong>') - resets the handles (automatically called when the figure is deleted)
	%     gui.get('<strong>CLOSE</strong>') - closes the figure and its dependent figures
	%
	% GUIFig methods (constructor):
	%  GUIFig - constructor
	%
	% GUIFig methods:
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
	% GUIFig methods (display):
	%  tostring - string with information about the figure GUI
	%  disp - displays information about the figure GUI
	%  tree - displays the tree of the figure GUI
	%
	% GUIFig methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two figure GUI are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the figure GUI
	%
	% GUIFig methods (save/load, Static):
	%  save - saves BRAPH2 figure GUI as b2 file
	%  load - loads a BRAPH2 figure GUI from a b2 file
	%
	% GUIFig method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the figure GUI
	%
	% GUIFig method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the figure GUI
	%
	% GUIFig methods (inspection, Static):
	%  getClass - returns the class of the figure GUI
	%  getSubclasses - returns all subclasses of GUIFig
	%  getProps - returns the property list of the figure GUI
	%  getPropNumber - returns the property number of the figure GUI
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
	% GUIFig methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GUIFig methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GUIFig methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GUIFig methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GUIFig; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GUIFig constants</a>.
	%
	%
	% See also uifigure, PanelFig.
	
	properties (Constant) % properties
		PF = GUI.getPropNumber() + 1;
		PF_TAG = 'PF';
		PF_CATEGORY = Category.DATA;
		PF_FORMAT = Format.ITEM;
		
		FILE = GUI.getPropNumber() + 2;
		FILE_TAG = 'FILE';
		FILE_CATEGORY = Category.METADATA;
		FILE_FORMAT = Format.STRING;
		
		TEXT_FILE = GUI.getPropNumber() + 3;
		TEXT_FILE_TAG = 'TEXT_FILE';
		TEXT_FILE_CATEGORY = Category.EVANESCENT;
		TEXT_FILE_FORMAT = Format.HANDLE;
		
		GUI_LAYOUT = GUI.getPropNumber() + 4;
		GUI_LAYOUT_TAG = 'GUI_LAYOUT';
		GUI_LAYOUT_CATEGORY = Category.DATA;
		GUI_LAYOUT_FORMAT = Format.ITEM;
		
		GUI_SETTINGS = GUI.getPropNumber() + 5;
		GUI_SETTINGS_TAG = 'GUI_SETTINGS';
		GUI_SETTINGS_CATEGORY = Category.DATA;
		GUI_SETTINGS_FORMAT = Format.ITEM;
		
		H_MENU_FILE = GUI.getPropNumber() + 6;
		H_MENU_FILE_TAG = 'H_MENU_FILE';
		H_MENU_FILE_CATEGORY = Category.EVANESCENT;
		H_MENU_FILE_FORMAT = Format.HANDLE;
		
		MENU_FILE = GUI.getPropNumber() + 7;
		MENU_FILE_TAG = 'MENU_FILE';
		MENU_FILE_CATEGORY = Category.GUI;
		MENU_FILE_FORMAT = Format.LOGICAL;
		
		H_MENU_PRINT = GUI.getPropNumber() + 8;
		H_MENU_PRINT_TAG = 'H_MENU_PRINT';
		H_MENU_PRINT_CATEGORY = Category.EVANESCENT;
		H_MENU_PRINT_FORMAT = Format.HANDLE;
		
		MENU_PRINT = GUI.getPropNumber() + 9;
		MENU_PRINT_TAG = 'MENU_PRINT';
		MENU_PRINT_CATEGORY = Category.GUI;
		MENU_PRINT_FORMAT = Format.LOGICAL;
		
		H_MENU_GUI_SETTINGS = GUI.getPropNumber() + 10;
		H_MENU_GUI_SETTINGS_TAG = 'H_MENU_GUI_SETTINGS';
		H_MENU_GUI_SETTINGS_CATEGORY = Category.EVANESCENT;
		H_MENU_GUI_SETTINGS_FORMAT = Format.HANDLE;
		
		MENU_GUI_SETTINGS = GUI.getPropNumber() + 11;
		MENU_GUI_SETTINGS_TAG = 'MENU_GUI_SETTINGS';
		MENU_GUI_SETTINGS_CATEGORY = Category.GUI;
		MENU_GUI_SETTINGS_FORMAT = Format.LOGICAL;
		
		H_MENU_PERSONALIZE = GUI.getPropNumber() + 12;
		H_MENU_PERSONALIZE_TAG = 'H_MENU_PERSONALIZE';
		H_MENU_PERSONALIZE_CATEGORY = Category.EVANESCENT;
		H_MENU_PERSONALIZE_FORMAT = Format.HANDLE;
		
		MENU_PERSONALIZE = GUI.getPropNumber() + 13;
		MENU_PERSONALIZE_TAG = 'MENU_PERSONALIZE';
		MENU_PERSONALIZE_CATEGORY = Category.GUI;
		MENU_PERSONALIZE_FORMAT = Format.LOGICAL;
		
		TOOL_FILE = GUI.getPropNumber() + 14;
		TOOL_FILE_TAG = 'TOOL_FILE';
		TOOL_FILE_CATEGORY = Category.GUI;
		TOOL_FILE_FORMAT = Format.LOGICAL;
		
		TOOL_PRINT = GUI.getPropNumber() + 15;
		TOOL_PRINT_TAG = 'TOOL_PRINT';
		TOOL_PRINT_CATEGORY = Category.GUI;
		TOOL_PRINT_FORMAT = Format.LOGICAL;
		
		TOOL_GUI_SETTINGS = GUI.getPropNumber() + 16;
		TOOL_GUI_SETTINGS_TAG = 'TOOL_GUI_SETTINGS';
		TOOL_GUI_SETTINGS_CATEGORY = Category.GUI;
		TOOL_GUI_SETTINGS_FORMAT = Format.LOGICAL;
	end
	methods % constructor
		function gui = GUIFig(varargin)
			%GUIFig() creates a figure GUI.
			%
			% GUIFig(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GUIFig(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			gui = gui@GUI(varargin{:});
		end
	end
	methods (Static) % inspection
		function gui_class = getClass()
			%GETCLASS returns the class of the figure GUI.
			%
			% CLASS = GUIFig.GETCLASS() returns the class 'GUIFig'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GUI.GETCLASS() returns the class of the figure GUI GUI.
			%  CLASS = Element.GETCLASS(GUI) returns the class of 'GUI'.
			%  CLASS = Element.GETCLASS('GUIFig') returns 'GUIFig'.
			%
			% Note that the Element.GETCLASS(GUI) and Element.GETCLASS('GUIFig')
			%  are less computationally efficient.
			
			gui_class = 'GUIFig';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the figure GUI.
			%
			% LIST = GUIFig.GETSUBCLASSES() returns all subclasses of 'GUIFig'.
			%
			% Alternative forms to call this method are:
			%  LIST = GUI.GETSUBCLASSES() returns all subclasses of the figure GUI GUI.
			%  LIST = Element.GETSUBCLASSES(GUI) returns all subclasses of 'GUI'.
			%  LIST = Element.GETSUBCLASSES('GUIFig') returns all subclasses of 'GUIFig'.
			%
			% Note that the Element.GETSUBCLASSES(GUI) and Element.GETSUBCLASSES('GUIFig')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GUIFig', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of figure GUI.
			%
			% PROPS = GUIFig.GETPROPS() returns the property list of figure GUI
			%  as a row vector.
			%
			% PROPS = GUIFig.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GUI.GETPROPS([CATEGORY]) returns the property list of the figure GUI GUI.
			%  PROPS = Element.GETPROPS(GUI[, CATEGORY]) returns the property list of 'GUI'.
			%  PROPS = Element.GETPROPS('GUIFig'[, CATEGORY]) returns the property list of 'GUIFig'.
			%
			% Note that the Element.GETPROPS(GUI) and Element.GETPROPS('GUIFig')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					GUI.getProps() ...
						GUIFig.PF ...
						GUIFig.FILE ...
						GUIFig.TEXT_FILE ...
						GUIFig.GUI_LAYOUT ...
						GUIFig.GUI_SETTINGS ...
						GUIFig.H_MENU_FILE ...
						GUIFig.MENU_FILE ...
						GUIFig.H_MENU_PRINT ...
						GUIFig.MENU_PRINT ...
						GUIFig.H_MENU_GUI_SETTINGS ...
						GUIFig.MENU_GUI_SETTINGS ...
						GUIFig.H_MENU_PERSONALIZE ...
						GUIFig.MENU_PERSONALIZE ...
						GUIFig.TOOL_FILE ...
						GUIFig.TOOL_PRINT ...
						GUIFig.TOOL_GUI_SETTINGS ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						GUI.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						GUI.getProps(Category.METADATA) ...
						GUIFig.FILE ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						GUI.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						GUI.getProps(Category.DATA) ...
						GUIFig.PF ...
						GUIFig.GUI_LAYOUT ...
						GUIFig.GUI_SETTINGS ...
						];
				case Category.RESULT
					prop_list = [
						GUI.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						GUI.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						GUI.getProps(Category.EVANESCENT) ...
						GUIFig.TEXT_FILE ...
						GUIFig.H_MENU_FILE ...
						GUIFig.H_MENU_PRINT ...
						GUIFig.H_MENU_GUI_SETTINGS ...
						GUIFig.H_MENU_PERSONALIZE ...
						];
				case Category.FIGURE
					prop_list = [ ...
						GUI.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						GUI.getProps(Category.GUI) ...
						GUIFig.MENU_FILE ...
						GUIFig.MENU_PRINT ...
						GUIFig.MENU_GUI_SETTINGS ...
						GUIFig.MENU_PERSONALIZE ...
						GUIFig.TOOL_FILE ...
						GUIFig.TOOL_PRINT ...
						GUIFig.TOOL_GUI_SETTINGS ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of figure GUI.
			%
			% N = GUIFig.GETPROPNUMBER() returns the property number of figure GUI.
			%
			% N = GUIFig.GETPROPNUMBER(CATEGORY) returns the property number of figure GUI
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GUI.GETPROPNUMBER([CATEGORY]) returns the property number of the figure GUI GUI.
			%  N = Element.GETPROPNUMBER(GUI) returns the property number of 'GUI'.
			%  N = Element.GETPROPNUMBER('GUIFig') returns the property number of 'GUIFig'.
			%
			% Note that the Element.GETPROPNUMBER(GUI) and Element.GETPROPNUMBER('GUIFig')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GUIFig.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in figure GUI/error.
			%
			% CHECK = GUIFig.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GUI.EXISTSPROP(PROP) checks whether PROP exists for GUI.
			%  CHECK = Element.EXISTSPROP(GUI, PROP) checks whether PROP exists for GUI.
			%  CHECK = Element.EXISTSPROP(GUIFig, PROP) checks whether PROP exists for GUIFig.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GUIFig:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GUI.EXISTSPROP(PROP) throws error if PROP does NOT exist for GUI.
			%   Error id: [BRAPH2:GUIFig:WrongInput]
			%  Element.EXISTSPROP(GUI, PROP) throws error if PROP does NOT exist for GUI.
			%   Error id: [BRAPH2:GUIFig:WrongInput]
			%  Element.EXISTSPROP(GUIFig, PROP) throws error if PROP does NOT exist for GUIFig.
			%   Error id: [BRAPH2:GUIFig:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GUI) and Element.EXISTSPROP('GUIFig')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GUIFig.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GUIFig:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GUIFig:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GUIFig.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in figure GUI/error.
			%
			% CHECK = GUIFig.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GUI.EXISTSTAG(TAG) checks whether TAG exists for GUI.
			%  CHECK = Element.EXISTSTAG(GUI, TAG) checks whether TAG exists for GUI.
			%  CHECK = Element.EXISTSTAG(GUIFig, TAG) checks whether TAG exists for GUIFig.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GUIFig:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GUI.EXISTSTAG(TAG) throws error if TAG does NOT exist for GUI.
			%   Error id: [BRAPH2:GUIFig:WrongInput]
			%  Element.EXISTSTAG(GUI, TAG) throws error if TAG does NOT exist for GUI.
			%   Error id: [BRAPH2:GUIFig:WrongInput]
			%  Element.EXISTSTAG(GUIFig, TAG) throws error if TAG does NOT exist for GUIFig.
			%   Error id: [BRAPH2:GUIFig:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GUI) and Element.EXISTSTAG('GUIFig')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			guifig_tag_list = cellfun(@(x) GUIFig.getPropTag(x), num2cell(GUIFig.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, guifig_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GUIFig:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GUIFig:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GUIFig.'] ...
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
			%  PROPERTY = GUI.GETPROPPROP(POINTER) returns property number of POINTER of GUI.
			%  PROPERTY = Element.GETPROPPROP(GUIFig, POINTER) returns property number of POINTER of GUIFig.
			%  PROPERTY = GUI.GETPROPPROP(GUIFig, POINTER) returns property number of POINTER of GUIFig.
			%
			% Note that the Element.GETPROPPROP(GUI) and Element.GETPROPPROP('GUIFig')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				guifig_tag_list = cellfun(@(x) GUIFig.getPropTag(x), num2cell(GUIFig.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, guifig_tag_list)); % tag = pointer
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
			%  TAG = GUI.GETPROPTAG(POINTER) returns tag of POINTER of GUI.
			%  TAG = Element.GETPROPTAG(GUIFig, POINTER) returns tag of POINTER of GUIFig.
			%  TAG = GUI.GETPROPTAG(GUIFig, POINTER) returns tag of POINTER of GUIFig.
			%
			% Note that the Element.GETPROPTAG(GUI) and Element.GETPROPTAG('GUIFig')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GUIFig.PF
						tag = GUIFig.PF_TAG;
					case GUIFig.FILE
						tag = GUIFig.FILE_TAG;
					case GUIFig.TEXT_FILE
						tag = GUIFig.TEXT_FILE_TAG;
					case GUIFig.GUI_LAYOUT
						tag = GUIFig.GUI_LAYOUT_TAG;
					case GUIFig.GUI_SETTINGS
						tag = GUIFig.GUI_SETTINGS_TAG;
					case GUIFig.H_MENU_FILE
						tag = GUIFig.H_MENU_FILE_TAG;
					case GUIFig.MENU_FILE
						tag = GUIFig.MENU_FILE_TAG;
					case GUIFig.H_MENU_PRINT
						tag = GUIFig.H_MENU_PRINT_TAG;
					case GUIFig.MENU_PRINT
						tag = GUIFig.MENU_PRINT_TAG;
					case GUIFig.H_MENU_GUI_SETTINGS
						tag = GUIFig.H_MENU_GUI_SETTINGS_TAG;
					case GUIFig.MENU_GUI_SETTINGS
						tag = GUIFig.MENU_GUI_SETTINGS_TAG;
					case GUIFig.H_MENU_PERSONALIZE
						tag = GUIFig.H_MENU_PERSONALIZE_TAG;
					case GUIFig.MENU_PERSONALIZE
						tag = GUIFig.MENU_PERSONALIZE_TAG;
					case GUIFig.TOOL_FILE
						tag = GUIFig.TOOL_FILE_TAG;
					case GUIFig.TOOL_PRINT
						tag = GUIFig.TOOL_PRINT_TAG;
					case GUIFig.TOOL_GUI_SETTINGS
						tag = GUIFig.TOOL_GUI_SETTINGS_TAG;
					otherwise
						tag = getPropTag@GUI(prop);
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
			%  CATEGORY = GUI.GETPROPCATEGORY(POINTER) returns category of POINTER of GUI.
			%  CATEGORY = Element.GETPROPCATEGORY(GUIFig, POINTER) returns category of POINTER of GUIFig.
			%  CATEGORY = GUI.GETPROPCATEGORY(GUIFig, POINTER) returns category of POINTER of GUIFig.
			%
			% Note that the Element.GETPROPCATEGORY(GUI) and Element.GETPROPCATEGORY('GUIFig')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GUIFig.getPropProp(pointer);
			
			switch prop
				case GUIFig.PF
					prop_category = GUIFig.PF_CATEGORY;
				case GUIFig.FILE
					prop_category = GUIFig.FILE_CATEGORY;
				case GUIFig.TEXT_FILE
					prop_category = GUIFig.TEXT_FILE_CATEGORY;
				case GUIFig.GUI_LAYOUT
					prop_category = GUIFig.GUI_LAYOUT_CATEGORY;
				case GUIFig.GUI_SETTINGS
					prop_category = GUIFig.GUI_SETTINGS_CATEGORY;
				case GUIFig.H_MENU_FILE
					prop_category = GUIFig.H_MENU_FILE_CATEGORY;
				case GUIFig.MENU_FILE
					prop_category = GUIFig.MENU_FILE_CATEGORY;
				case GUIFig.H_MENU_PRINT
					prop_category = GUIFig.H_MENU_PRINT_CATEGORY;
				case GUIFig.MENU_PRINT
					prop_category = GUIFig.MENU_PRINT_CATEGORY;
				case GUIFig.H_MENU_GUI_SETTINGS
					prop_category = GUIFig.H_MENU_GUI_SETTINGS_CATEGORY;
				case GUIFig.MENU_GUI_SETTINGS
					prop_category = GUIFig.MENU_GUI_SETTINGS_CATEGORY;
				case GUIFig.H_MENU_PERSONALIZE
					prop_category = GUIFig.H_MENU_PERSONALIZE_CATEGORY;
				case GUIFig.MENU_PERSONALIZE
					prop_category = GUIFig.MENU_PERSONALIZE_CATEGORY;
				case GUIFig.TOOL_FILE
					prop_category = GUIFig.TOOL_FILE_CATEGORY;
				case GUIFig.TOOL_PRINT
					prop_category = GUIFig.TOOL_PRINT_CATEGORY;
				case GUIFig.TOOL_GUI_SETTINGS
					prop_category = GUIFig.TOOL_GUI_SETTINGS_CATEGORY;
				otherwise
					prop_category = getPropCategory@GUI(prop);
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
			%  FORMAT = GUI.GETPROPFORMAT(POINTER) returns format of POINTER of GUI.
			%  FORMAT = Element.GETPROPFORMAT(GUIFig, POINTER) returns format of POINTER of GUIFig.
			%  FORMAT = GUI.GETPROPFORMAT(GUIFig, POINTER) returns format of POINTER of GUIFig.
			%
			% Note that the Element.GETPROPFORMAT(GUI) and Element.GETPROPFORMAT('GUIFig')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GUIFig.getPropProp(pointer);
			
			switch prop
				case GUIFig.PF
					prop_format = GUIFig.PF_FORMAT;
				case GUIFig.FILE
					prop_format = GUIFig.FILE_FORMAT;
				case GUIFig.TEXT_FILE
					prop_format = GUIFig.TEXT_FILE_FORMAT;
				case GUIFig.GUI_LAYOUT
					prop_format = GUIFig.GUI_LAYOUT_FORMAT;
				case GUIFig.GUI_SETTINGS
					prop_format = GUIFig.GUI_SETTINGS_FORMAT;
				case GUIFig.H_MENU_FILE
					prop_format = GUIFig.H_MENU_FILE_FORMAT;
				case GUIFig.MENU_FILE
					prop_format = GUIFig.MENU_FILE_FORMAT;
				case GUIFig.H_MENU_PRINT
					prop_format = GUIFig.H_MENU_PRINT_FORMAT;
				case GUIFig.MENU_PRINT
					prop_format = GUIFig.MENU_PRINT_FORMAT;
				case GUIFig.H_MENU_GUI_SETTINGS
					prop_format = GUIFig.H_MENU_GUI_SETTINGS_FORMAT;
				case GUIFig.MENU_GUI_SETTINGS
					prop_format = GUIFig.MENU_GUI_SETTINGS_FORMAT;
				case GUIFig.H_MENU_PERSONALIZE
					prop_format = GUIFig.H_MENU_PERSONALIZE_FORMAT;
				case GUIFig.MENU_PERSONALIZE
					prop_format = GUIFig.MENU_PERSONALIZE_FORMAT;
				case GUIFig.TOOL_FILE
					prop_format = GUIFig.TOOL_FILE_FORMAT;
				case GUIFig.TOOL_PRINT
					prop_format = GUIFig.TOOL_PRINT_FORMAT;
				case GUIFig.TOOL_GUI_SETTINGS
					prop_format = GUIFig.TOOL_GUI_SETTINGS_FORMAT;
				otherwise
					prop_format = getPropFormat@GUI(prop);
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
			%  DESCRIPTION = GUI.GETPROPDESCRIPTION(POINTER) returns description of POINTER of GUI.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GUIFig, POINTER) returns description of POINTER of GUIFig.
			%  DESCRIPTION = GUI.GETPROPDESCRIPTION(GUIFig, POINTER) returns description of POINTER of GUIFig.
			%
			% Note that the Element.GETPROPDESCRIPTION(GUI) and Element.GETPROPDESCRIPTION('GUIFig')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GUIFig.getPropProp(pointer);
			
			switch prop
				case GUIFig.PF
					prop_description = 'PF (data, item) is the panel figure.';
				case GUIFig.FILE
					prop_description = 'FILE (metadata, string) is the B2 file where the element is saved.';
				case GUIFig.TEXT_FILE
					prop_description = 'TEXT_FILE (evanescent, handle) is the label where the file name is shown.';
				case GUIFig.GUI_LAYOUT
					prop_description = 'GUI_LAYOUT (data, item) is the handle to the figure to manage the layout.';
				case GUIFig.GUI_SETTINGS
					prop_description = 'GUI_SETTINGS (data, item) is the handle to the figure to manage the figure settings.';
				case GUIFig.H_MENU_FILE
					prop_description = 'H_MENU_FILE (evanescent, handle) is the handle of the menu file.';
				case GUIFig.MENU_FILE
					prop_description = 'MENU_FILE (gui, logical) determines whether to show the menu file.';
				case GUIFig.H_MENU_PRINT
					prop_description = 'H_MENU_PRINT (evanescent, handle) is the handle of the menu to print to image file.';
				case GUIFig.MENU_PRINT
					prop_description = 'MENU_PRINT (gui, logical) determines whether to show the menu to print to image file.';
				case GUIFig.H_MENU_GUI_SETTINGS
					prop_description = 'H_MENU_GUI_SETTINGS (evanescent, handle) is the handle of the menu settings.';
				case GUIFig.MENU_GUI_SETTINGS
					prop_description = 'MENU_GUI_SETTINGS (gui, logical) determines whether to show the menu settings.';
				case GUIFig.H_MENU_PERSONALIZE
					prop_description = 'H_MENU_PERSONALIZE (evanescent, handle) is the handle of the menu personalize.';
				case GUIFig.MENU_PERSONALIZE
					prop_description = 'MENU_PERSONALIZE (gui, logical) determines whether to show the menu personalize.';
				case GUIFig.TOOL_FILE
					prop_description = 'TOOL_FILE (gui, logical) determines whether to show the toolbar file buttons.';
				case GUIFig.TOOL_PRINT
					prop_description = 'TOOL_PRINT (gui, logical) determines whether to show the toolbar print button.';
				case GUIFig.TOOL_GUI_SETTINGS
					prop_description = 'TOOL_GUI_SETTINGS (gui, logical) determines whether to show the toolbar settings buttons.';
				case GUIFig.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the figure GUI.';
				case GUIFig.NAME
					prop_description = 'NAME (constant, string) is the name of the figure GUI.';
				case GUIFig.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the figure GUI.';
				case GUIFig.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the figure GUI.';
				case GUIFig.ID
					prop_description = 'ID (data, string) is a few-letter code for the figure GUI.';
				case GUIFig.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the figure GUI.';
				case GUIFig.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the figure GUI.';
				case GUIFig.POSITION
					prop_description = 'POSITION (gui, rvector) is the normalized position of the GUI on the screen.';
				case GUIFig.BKGCOLOR
					prop_description = 'BKGCOLOR (gui, color) is the GUI background color.';
				case GUIFig.H_MENUBAR
					prop_description = 'H_MENUBAR (evanescent, handlelist) is the list of handles for the menus.';
				case GUIFig.MENUBAR
					prop_description = 'MENUBAR (gui, logical) determines whether to show the menubar.';
				case GUIFig.MENU_ABOUT
					prop_description = 'MENU_ABOUT (gui, logical) determines whether to show the menu about.';
				case GUIFig.H_TOOLS
					prop_description = 'H_TOOLS (evanescent, handlelist) is the handle list of the toolbar followed by the tools from the first.';
				case GUIFig.TOOLBAR
					prop_description = 'TOOLBAR (gui, logical) determines whether to show the toolbar.';
				case GUIFig.TOOL_ABOUT
					prop_description = 'TOOL_ABOUT (gui, logical) determines whether to show the toolbar about buttons.';
				case GUIFig.DRAW
					prop_description = 'DRAW (query, logical) draws the contents of a GUI before showing it.';
				case GUIFig.H
					prop_description = 'H (evanescent, handle) is the figure handle.';
				case GUIFig.SHOW
					prop_description = 'SHOW (query, logical) shows the figure and its dependent figures.';
				case GUIFig.HIDE
					prop_description = 'HIDE (query, logical) hides the figure and its dependent figures.';
				case GUIFig.DELETE
					prop_description = 'DELETE (query, logical) resets the handles and closes the dependent figures when the figure is deleted.';
				case GUIFig.CLOSE
					prop_description = 'CLOSE (query, logical) closes the figure and its dependent figures.';
				otherwise
					prop_description = getPropDescription@GUI(prop);
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
			%  SETTINGS = GUI.GETPROPSETTINGS(POINTER) returns settings of POINTER of GUI.
			%  SETTINGS = Element.GETPROPSETTINGS(GUIFig, POINTER) returns settings of POINTER of GUIFig.
			%  SETTINGS = GUI.GETPROPSETTINGS(GUIFig, POINTER) returns settings of POINTER of GUIFig.
			%
			% Note that the Element.GETPROPSETTINGS(GUI) and Element.GETPROPSETTINGS('GUIFig')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GUIFig.getPropProp(pointer);
			
			switch prop
				case GUIFig.PF
					prop_settings = 'PanelFig';
				case GUIFig.FILE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GUIFig.TEXT_FILE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GUIFig.GUI_LAYOUT
					prop_settings = 'GUILayout';
				case GUIFig.GUI_SETTINGS
					prop_settings = 'GUIElement';
				case GUIFig.H_MENU_FILE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GUIFig.MENU_FILE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUIFig.H_MENU_PRINT
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GUIFig.MENU_PRINT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUIFig.H_MENU_GUI_SETTINGS
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GUIFig.MENU_GUI_SETTINGS
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUIFig.H_MENU_PERSONALIZE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GUIFig.MENU_PERSONALIZE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUIFig.TOOL_FILE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUIFig.TOOL_PRINT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUIFig.TOOL_GUI_SETTINGS
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUIFig.TEMPLATE
					prop_settings = 'GUIFig';
				otherwise
					prop_settings = getPropSettings@GUI(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GUIFig.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GUIFig.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GUI.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GUI.
			%  DEFAULT = Element.GETPROPDEFAULT(GUIFig, POINTER) returns the default value of POINTER of GUIFig.
			%  DEFAULT = GUI.GETPROPDEFAULT(GUIFig, POINTER) returns the default value of POINTER of GUIFig.
			%
			% Note that the Element.GETPROPDEFAULT(GUI) and Element.GETPROPDEFAULT('GUIFig')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GUIFig.getPropProp(pointer);
			
			switch prop
				case GUIFig.PF
					prop_default = Format.getFormatDefault(Format.ITEM, GUIFig.getPropSettings(prop));
				case GUIFig.FILE
					prop_default = Format.getFormatDefault(Format.STRING, GUIFig.getPropSettings(prop));
				case GUIFig.TEXT_FILE
					prop_default = Format.getFormatDefault(Format.HANDLE, GUIFig.getPropSettings(prop));
				case GUIFig.GUI_LAYOUT
					prop_default = Format.getFormatDefault(Format.ITEM, GUIFig.getPropSettings(prop));
				case GUIFig.GUI_SETTINGS
					prop_default = Format.getFormatDefault(Format.ITEM, GUIFig.getPropSettings(prop));
				case GUIFig.H_MENU_FILE
					prop_default = Format.getFormatDefault(Format.HANDLE, GUIFig.getPropSettings(prop));
				case GUIFig.MENU_FILE
					prop_default = true;
				case GUIFig.H_MENU_PRINT
					prop_default = Format.getFormatDefault(Format.HANDLE, GUIFig.getPropSettings(prop));
				case GUIFig.MENU_PRINT
					prop_default = true;
				case GUIFig.H_MENU_GUI_SETTINGS
					prop_default = Format.getFormatDefault(Format.HANDLE, GUIFig.getPropSettings(prop));
				case GUIFig.MENU_GUI_SETTINGS
					prop_default = true;
				case GUIFig.H_MENU_PERSONALIZE
					prop_default = Format.getFormatDefault(Format.HANDLE, GUIFig.getPropSettings(prop));
				case GUIFig.MENU_PERSONALIZE
					prop_default = true;
				case GUIFig.TOOL_FILE
					prop_default = true;
				case GUIFig.TOOL_PRINT
					prop_default = true;
				case GUIFig.TOOL_GUI_SETTINGS
					prop_default = true;
				case GUIFig.ELCLASS
					prop_default = 'GUIFig';
				case GUIFig.NAME
					prop_default = 'Figure GUI';
				case GUIFig.DESCRIPTION
					prop_default = 'A Figure GUI (GUIFIG) renders a figure.';
				case GUIFig.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, GUIFig.getPropSettings(prop));
				case GUIFig.ID
					prop_default = 'GUIFIG ID';
				case GUIFig.LABEL
					prop_default = 'GUIFIG label';
				case GUIFig.NOTES
					prop_default = 'GUIFIG notes';
				case GUIFig.POSITION
					prop_default = [.30 .40 .39 .47];
				case GUIFig.BKGCOLOR
					prop_default = BRAPH2.COL_F;
				case GUIFig.MENUBAR
					prop_default = true;
				case GUIFig.MENU_ABOUT
					prop_default = true;
				case GUIFig.TOOLBAR
					prop_default = true;
				case GUIFig.TOOL_ABOUT
					prop_default = true;
				otherwise
					prop_default = getPropDefault@GUI(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GUIFig.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GUIFig.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GUI.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GUIFig, POINTER) returns the conditioned default value of POINTER of GUIFig.
			%  DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(GUIFig, POINTER) returns the conditioned default value of POINTER of GUIFig.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GUI) and Element.GETPROPDEFAULTCONDITIONED('GUIFig')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GUIFig.getPropProp(pointer);
			
			prop_default = GUIFig.conditioning(prop, GUIFig.getPropDefault(prop));
		end
	end
	methods (Access=protected) % preset
		function value = preset(gui, prop, value)
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
				case GUIFig.GUI_LAYOUT % __GUIFig.GUI_LAYOUT__
					if isa(value.getr('EL_CLASS'), 'NoValue')
					    f = gui.get('H');
					    value.set( ...
					        'EL_CLASS', gui.get('PF'), ...
					        'POSITION', [x0(f)+w(f) y0(f)+h(f)*2/3 w(f) h(f)/3], ...
					        'CLOSEREQ', false ...
					        )
					end
					
				case GUIFig.GUI_SETTINGS % __GUIFig.GUI_SETTINGS__
					if isa(value.getr('PE'), 'NoValue') % i.e., default initialization
					    pf = gui.memorize('PF');
					    f = gui.get('H');
					    
					    pe = PanelElement('EL', pf);
					    
					    pr_visible = int8(pe.get('PR_VISIBLE') & ismember(1:1:pf.getPropNumber(), pf.getProps(Category.FIGURE))); % __Category.FIGURE__
					
					    pr_order = pe.get('PR_ORDER');
					    pr_order(pr_visible == 0) = NaN;
					    for i = sum(pr_visible):-1:1
					        pr_order(pr_order == max(pr_order)) = -i;
					    end
					    pr_order = -pr_order;
					    
					    pe.set( ...
					        'PR_VISIBLE', pr_visible, ...
					        'PR_ORDER', pr_order ...
					        )
					    
						value.set( ...
					        'PE', pe, ...
					        'TITLE', ['Settings - ' gui.get('TITLE')], ...
					        'POSITION', [ ...
					            min(x0(f, 'normalized') + w(f, 'normalized'), 1 - (pe.get('MIN_WIDTH') + 20) / w(0, 'pixels')) ... % min to ensure that figure within screen
					            y0(f, 'normalized') ...
					            (pe.get('MIN_WIDTH') + 20) / w(0, 'pixels') ...
					            h(f, 'normalized') ...
					            ], ...
					        'MENUBAR', false, ...
					        'TOOLBAR', false, ...
					        'WAITBAR', gui.getCallback('WAITBAR'), ...
					        'CLOSEREQ', false ...
					        );
					end
					
				otherwise
					if prop <= GUI.getPropNumber()
						value = preset@GUI(gui, prop, value);
					end
			end
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = GUI.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = GUI.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of GUI.
			%  CHECK = Element.CHECKPROP(GUIFig, PROP, VALUE) checks VALUE format for PROP of GUIFig.
			%  CHECK = GUI.CHECKPROP(GUIFig, PROP, VALUE) checks VALUE format for PROP of GUIFig.
			% 
			% GUI.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GUIFig:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GUI.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GUI.
			%   Error id: €BRAPH2.STR€:GUIFig:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GUIFig, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GUIFig.
			%   Error id: €BRAPH2.STR€:GUIFig:€BRAPH2.WRONG_INPUT€
			%  GUI.CHECKPROP(GUIFig, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GUIFig.
			%   Error id: €BRAPH2.STR€:GUIFig:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(GUI) and Element.CHECKPROP('GUIFig')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GUIFig.getPropProp(pointer);
			
			switch prop
				case GUIFig.PF % __GUIFig.PF__
					check = Format.checkFormat(Format.ITEM, value, GUIFig.getPropSettings(prop));
				case GUIFig.FILE % __GUIFig.FILE__
					check = Format.checkFormat(Format.STRING, value, GUIFig.getPropSettings(prop));
				case GUIFig.TEXT_FILE % __GUIFig.TEXT_FILE__
					check = Format.checkFormat(Format.HANDLE, value, GUIFig.getPropSettings(prop));
				case GUIFig.GUI_LAYOUT % __GUIFig.GUI_LAYOUT__
					check = Format.checkFormat(Format.ITEM, value, GUIFig.getPropSettings(prop));
				case GUIFig.GUI_SETTINGS % __GUIFig.GUI_SETTINGS__
					check = Format.checkFormat(Format.ITEM, value, GUIFig.getPropSettings(prop));
				case GUIFig.H_MENU_FILE % __GUIFig.H_MENU_FILE__
					check = Format.checkFormat(Format.HANDLE, value, GUIFig.getPropSettings(prop));
				case GUIFig.MENU_FILE % __GUIFig.MENU_FILE__
					check = Format.checkFormat(Format.LOGICAL, value, GUIFig.getPropSettings(prop));
				case GUIFig.H_MENU_PRINT % __GUIFig.H_MENU_PRINT__
					check = Format.checkFormat(Format.HANDLE, value, GUIFig.getPropSettings(prop));
				case GUIFig.MENU_PRINT % __GUIFig.MENU_PRINT__
					check = Format.checkFormat(Format.LOGICAL, value, GUIFig.getPropSettings(prop));
				case GUIFig.H_MENU_GUI_SETTINGS % __GUIFig.H_MENU_GUI_SETTINGS__
					check = Format.checkFormat(Format.HANDLE, value, GUIFig.getPropSettings(prop));
				case GUIFig.MENU_GUI_SETTINGS % __GUIFig.MENU_GUI_SETTINGS__
					check = Format.checkFormat(Format.LOGICAL, value, GUIFig.getPropSettings(prop));
				case GUIFig.H_MENU_PERSONALIZE % __GUIFig.H_MENU_PERSONALIZE__
					check = Format.checkFormat(Format.HANDLE, value, GUIFig.getPropSettings(prop));
				case GUIFig.MENU_PERSONALIZE % __GUIFig.MENU_PERSONALIZE__
					check = Format.checkFormat(Format.LOGICAL, value, GUIFig.getPropSettings(prop));
				case GUIFig.TOOL_FILE % __GUIFig.TOOL_FILE__
					check = Format.checkFormat(Format.LOGICAL, value, GUIFig.getPropSettings(prop));
				case GUIFig.TOOL_PRINT % __GUIFig.TOOL_PRINT__
					check = Format.checkFormat(Format.LOGICAL, value, GUIFig.getPropSettings(prop));
				case GUIFig.TOOL_GUI_SETTINGS % __GUIFig.TOOL_GUI_SETTINGS__
					check = Format.checkFormat(Format.LOGICAL, value, GUIFig.getPropSettings(prop));
				case GUIFig.TEMPLATE % __GUIFig.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, GUIFig.getPropSettings(prop));
				otherwise
					if prop <= GUI.getPropNumber()
						check = checkProp@GUI(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GUIFig:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GUIFig:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GUIFig.getPropTag(prop) ' (' GUIFig.getFormatTag(GUIFig.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(gui, prop)
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
				case GUIFig.PF % __GUIFig.PF__
					pf = gui.get('PF');
					pf.set('PARENT', gui)
					if isa(gui.getr('TITLE'), 'NoValue')
					    gui.set('TITLE', [pf.getClass() ' - ' pf.get('ID') ' - ' BRAPH2.STR])
					end
					gui.lock('PF', 'Iterative', false)
					
				case GUIFig.FILE % __GUIFig.FILE__
					if gui.get('DRAWN')
					    set(gui.get('TEXT_FILE'), ...
					        'Text', gui.get('FILE'), ...
					        'Tooltip', gui.get('FILE') ...
					        )
					end
					
				otherwise
					if prop <= GUI.getPropNumber()
						postset@GUI(gui, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(gui, prop, varargin)
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
				case GUIFig.TEXT_FILE % __GUIFig.TEXT_FILE__
					text_file = uilabel( ...
					    'Parent', gui.memorize('H'), ... % H = p for Panel
					    'Tag', 'TEXT_FILE', ...    
					    'Text', gui.get('FILE'), ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', gui.get('FILE'), ...
					    'HorizontalAlignment', 'left', ...
					    'Position', [5 0 w(gui.get('H'), 'pixels')-10 s(2)] ...
					    );
					value = text_file;
					
				case GUIFig.H_MENU_FILE % __GUIFig.H_MENU_FILE__
					menu_file = uimenu(gui.memorize('H'), ... % f for figure
					    'Tag', 'MENU.File', ...
					    'Label', 'File' ...
					    );
					
					uimenu(menu_file, ...
					    'Tag', 'MENU.File.Open', ...
					    'Label', 'Open ...', ...
					    'Accelerator', 'O', ...
					    'Callback', {@cb_open})
					uimenu(menu_file, ...
					    'Tag', 'MENU.File.Save', ...
					    'Label', 'Save', ...
					    'Accelerator', 'S', ...
					    'Callback', {@cb_save})
					uimenu(menu_file, ...
					    'Tag', 'MENU.File.Saveas', ...
					    'Label', 'Save as ...', ...
					    'Accelerator', 'A', ...
					    'Callback', {@cb_saveas})
					uimenu(menu_file, ...
					    'Separator', 'on', ...
					    'Tag', 'MENU.File.Close', ...
					    'Label', 'Quit', ...
					    'Accelerator', 'Q', ...
					    'Callback', {@cb_get, 'CLOSE'})
					
					value = menu_file;
					
				case GUIFig.H_MENU_PRINT % __GUIFig.H_MENU_PRINT__
					menu_print = uimenu(gui.memorize('H'), ... % f for figure
					    'Tag', 'MENU.Print', ...
					    'Label', 'Print' ...
					    );
					
					uimenu(menu_print, ...
					    'Tag', 'MENU.Print.Print', ...
					    'Label', 'Print ...', ...
					    'Accelerator', 'P', ...
					    'Callback', {@cb_print})
					uimenu(menu_print, ...
					    'Tag', 'MENU.Print.Vectorial', ...
					    'Label', 'Vectorial ...', ...
					    'Callback', {@cb_print, 'vector'})
					uimenu(menu_print, ...
					    'Separator', 'on', ...
					    'Tag', 'MENU.Print.HR300', ...
					    'Label', 'Hi-res (300 dpi) ...', ...
					    'Callback', {@cb_print, 'image', 300})
					uimenu(menu_print, ...
					    'Tag', 'MENU.Print.HR600', ...
					    'Label', 'Hi-res (600 dpi) ...', ...
					    'Callback', {@cb_print, 'image', 600})
					uimenu(menu_print, ...
					    'Tag', 'MENU.Print.HR1200', ...
					    'Label', 'Hi-res (1200 dpi) ...', ...
					    'Callback', {@cb_print, 'image', 1200})
					uimenu(menu_print, ...
					    'Separator', 'on', ...
					    'Tag', 'MENU.Print.Grayscale', ...
					    'Label', 'Grayscale ...', ...
					    'Callback', {@cb_print, [], [], 'gray'})
					uimenu(menu_print, ...
					    'Tag', 'MENU.Print.VectorialGrayscale', ...
					    'Label', 'Vectorial grayscale ...', ...
					    'Callback', {@cb_print, 'vector', [], 'gray'})
					uimenu(menu_print, ...
					    'Separator', 'on', ...
					    'Tag', 'MENU.Print.CMYK', ...
					    'Label', 'CMYK ...', ...
					    'Callback', {@cb_print, [], [], 'cmyk'})
					uimenu(menu_print, ...
					    'Tag', 'MENU.Print.VEctorialCMYK', ...
					    'Label', 'Vectorial CMYK ...', ...
					    'Callback', {@cb_print, 'vector', [], 'cmyk'})
					
					value = menu_print;
					
				case GUIFig.H_MENU_GUI_SETTINGS % __GUIFig.H_MENU_GUI_SETTINGS__
					menu_settings = uimenu(gui.memorize('H'), ... % f for figure
					    'Tag', 'MENU.Settings', ...
					    'Label', 'Settings' ...
					    );
					
					uimenu(menu_settings, ...
					    'Tag', 'MENU.Settings.Settings', ...
					    'Label', 'Settings ...', ...
					    'Callback', {@cb_settings})
					
					value = menu_settings;
					
				case GUIFig.H_MENU_PERSONALIZE % __GUIFig.H_MENU_PERSONALIZE__
					menu_personalize = uimenu(gui.memorize('H'), ... % f for figure
					    'Tag', 'MENU.Personalize', ...
					    'Label', 'Personalize' ...
					    );
					
					uimenu(menu_personalize, ...
					    'Tag', 'MENU.Personalize.Layout', ...
					    'Label', 'Layout ...', ...
					    'Callback', {@cb_layout})
					
					value = menu_personalize;
					
				case GUIFig.H_MENUBAR % __GUIFig.H_MENUBAR__
					value = {};
					if gui.get('MENU_FILE')
					    value = [value, gui.memorize('H_MENU_FILE')];
					end
					if gui.get('MENU_PRINT')
					    value = [value, gui.memorize('H_MENU_PRINT')];
					end
					if gui.get('MENU_GUI_SETTINGS')
					    value = [value, gui.memorize('H_MENU_GUI_SETTINGS')];
					end
					if gui.get('MENU_PERSONALIZE')
					    value = [value, gui.memorize('H_MENU_PERSONALIZE')];
					end
					if gui.get('MENU_ABOUT')
					    value = [value, gui.memorize('H_MENU_ABOUT')];
					end
					
				case GUIFig.H_TOOLS % __GUIFig.H_TOOLS__
					toolbar = gui.memorize('H_TOOLBAR');
					
					children = calculateValue@GUI(gui, GUI.H_TOOLS);
					
					pf = gui.memorize('PF');
					
					value = {};
					
					if gui.get('TOOL_FILE')
					    % OPEN
					    tool_file_open = uipushtool(toolbar, ...
					        'Tag', 'TOOL.Open', ...                
					        'Tooltip', ['Open ' pf.get('NAME')], ...
					        'CData', imread('icon_open_ml.png'), ...
					        'ClickedCallback', {@cb_open});
					    % Save
					    tool_file_save = uipushtool(toolbar, ...
					        'Tag', 'TOOL.Save', ...                
					        'Tooltip', ['Save ' pf.get('NAME')], ...
					        'CData', imread('icon_save_ml.png'), ...
					        'ClickedCallback', {@cb_save});
					    
					    value = {value{:}, tool_file_open, tool_file_save};
					end
					if gui.get('TOOL_PRINT')
					    % Print
					    tool_print = uipushtool(toolbar, ...
					        'Tag', 'TOOL.Print', ...                
					        'Tooltip', ['Print/Export to image file ' pf.get('NAME')], ...
					        'CData', imread('icon_print_ml.png'), ...
					        'ClickedCallback', {@cb_print, 'auto', 300});
					
					    value = {value{:}, tool_print};
					end
					if gui.get('TOOL_GUI_SETTINGS')
					    % Settings
					    tool_settings = uipushtool(toolbar, ...
					        'Tag', 'TOOL.Settings', ...       
					        'Separator', 'on', ...
					        'Tooltip', ['Settings ' pf.get('NAME')], ... 
					        'CData', imread('icon_settings_ml.png'), ...
					        'ClickedCallback', {@cb_settings});
					  
					    value = {value{:}, tool_settings};
					end
					
					panel_tools = pf.memorize('H_TOOLS');
					value = {value{:}, panel_tools{:}};
					
					value = {value{:}, children{:}};
					
					% reorder tools
					toolbar.Children = [value{end:-1:1}];
					
				case GUIFig.DRAW % __GUIFig.DRAW__
					if check_graphics(gui.memorize('H'), 'figure')
					
					    if gui.get('MENUBAR')
					        gui.memorize('H_MENUBAR')
					    end
					    
					    if gui.get('TOOLBAR')
					        % gui.memorize('H_TOOLBAR') % performed automatically by gui.memorize('H_TOOLS')
					        gui.memorize('H_TOOLS')
					    end
					    
					    pf = gui.memorize('PF');
					    pf.get('DRAW')
					
					    gui.memorize('TEXT_FILE')
					
					    drawnow()
					    
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(gui)], ...
					        [BRAPH2.STR ':' class(gui) '\n' ...
					        'The call gui.get(''DRAW'') did not work.\n' ...
					        'This shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case GUIFig.H % __GUIFig.H__
					f = calculateValue@GUI(gui, GUI.H);
					pf = gui.memorize('PF');
					value = f;
					
				case GUIFig.SHOW % __GUIFig.SHOW__
					value = calculateValue@GUI(gui, GUI.SHOW, varargin{:}); % also warning
					if value
					    % figure layout editor
					    if isa(gui.getr('GUI_LAYOUT'), 'GUILayout') && gui.get('GUI_LAYOUT').get('DRAWN')
					        gui.get('GUI_LAYOUT').get('SHOW')
					    end
					    
					    % figure settings
					    if isa(gui.getr('GUI_SETTINGS'), 'GUIElement') && gui.get('GUI_SETTINGS').get('DRAWN')
					        gui.get('GUI_SETTINGS').get('SHOW')
					    end
					end
					
				case GUIFig.HIDE % __GUIFig.HIDE__
					value = calculateValue@GUI(gui, GUI.HIDE, varargin{:}); % also warning
					if value
					    % figure layout editor
					    if isa(gui.getr('GUI_LAYOUT'), 'GUILayout') && gui.get('GUI_LAYOUT').get('DRAWN')
					        gui.get('GUI_LAYOUT').get('HIDE')
					    end
					
					    % figure settings
					    if isa(gui.getr('GUI_SETTINGS'), 'GUIElement') && gui.get('GUI_SETTINGS').get('DRAWN')
					        gui.get('GUI_SETTINGS').get('HIDE')
					    end
					end
					
				case GUIFig.DELETE % __GUIFig.DELETE__
					value = calculateValue@GUI(gui, GUI.DELETE, varargin{:}); % also warning
					if value
						gui.set('TEXT_FILE', Element.getNoValue())
					
					 	gui.set('H_MENU_FILE', Element.getNoValue())
						gui.set('H_MENU_PRINT', Element.getNoValue())
					 	gui.set('H_MENU_GUI_SETTINGS', Element.getNoValue())
					 	gui.set('H_MENU_PERSONALIZE', Element.getNoValue())
					end
					
				case GUIFig.CLOSE % __GUIFig.CLOSE__
					if gui.get('DRAWN')
					
					    title = gui.get('TITLE');
					
					    if gui.get('CLOSEREQ')
					        %TODO implement and use braph2msgbox instead of uiconfirm
					        selection = uiconfirm(gui.get('H'), ...
					            ['Do you want to close ' title '?'], ...
					            ['Close ' title], ...
					            'Options', {'Yes', 'No'}, ...
					            'DefaultOption', 2 ...
					            );
					    else
					        selection = 'Yes';
					    end
					
					    if strcmp(selection, 'Yes')
					        % figure layout editor
					        if isa(gui.getr('GUI_LAYOUT'), 'GUILayout') && gui.get('GUI_LAYOUT').get('DRAWN')
					            gui.get('GUI_LAYOUT').get('CLOSE')
					        end
					
					        % figure settings
					        if isa(gui.getr('GUI_SETTINGS'), 'GUIElement') && gui.get('GUI_SETTINGS').get('DRAWN')
					            gui.get('GUI_SETTINGS').get('CLOSE')
					        end
					        
					        % main figure
					        delete(gui.get('H'))
					    end
					
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(gui)], ...
					        [BRAPH2.STR ':' class(gui) '\n' ...
					        'The call gui.get(''CLOSE'') has NOT been executed.\n' ...
					        'First, the gui ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				otherwise
					if prop <= GUI.getPropNumber()
						value = calculateValue@GUI(gui, prop, varargin{:});
					else
						value = calculateValue@Element(gui, prop, varargin{:});
					end
			end
			
			function cb_get(~, ~, varargin)
				gui.get(varargin{:})
			end
			function cb_open(~, ~)
			    pf = gui.get('PF');
			    % select file
			    [file, path, filterindex] = uigetfile(BRAPH2.EXT_ELEMENT, ['Select the ' pf.get('NAME') ' file.']);
			    if filterindex
			        filename = fullfile(path, file);
			        tmp_el = Element.load(filename, gui.get('WAITBAR'));
			        % % % %TODO: add checks for BRAPH2 version
			        if isa(tmp_el, 'PanelFig')
			            tmp_gui = GUIFig('PF', tmp_el, 'FILE', filename, 'WAITBAR', gui.get('WAITBAR'));
			        else
			            tmp_gui = GUIElement('PE', tmp_el, 'FILE', filename, 'WAITBAR', gui.get('WAITBAR'));
			        end
			        tmp_gui.get('DRAW')
			        tmp_gui.get('SHOW')
			    end
			end
			function cb_save(~, ~)
			    filename = gui.get('FILE');
			    if isfile(filename)
			        pf = gui.get('PF');
			        Element.save(pf, filename, gui.get('WAITBAR'))
			    else
			        cb_saveas();
			    end
			end
			function cb_saveas(~, ~)
			    pf = gui.get('PF');
			    % select file
			    [file, path, filterindex] = uiputfile(BRAPH2.EXT_ELEMENT, ['Select the ' pf.get('NAME') ' file.']);
			    % save file
			    if filterindex
			        filename = fullfile(path, file);
			        Element.save(pf, filename, gui.get('WAITBAR'))
			        gui.set('FILE', filename)
			    end
			end
			function cb_print(~, ~, contenttype, resolution, colorspace)
			    if nargin < 5 || isempty(colorspace)
			        colorspace = 'rgb';
			    end
			    if nargin < 4 || isempty(resolution)
			        resolution = 150;
			    end
			    if nargin < 3 || isempty(contenttype)
			        contenttype = 'auto';
			    end        
			    braph2print(gui.get('PF').get('H'), [], 'ContentType', contenttype, 'Resolution', resolution, 'Colorspace', colorspace)
			end
			function cb_settings(~, ~)
				gui_settings = gui.memorize('GUI_SETTINGS');
			
			    if ~gui_settings.get('DRAWN')
			        gui_settings.get('DRAW')
			        gui_settings.get('SHOW')
			    else
			        if get(gui_settings.get('H'), 'Visible')
			            gui_settings.get('HIDE')
			        else
			            gui_settings.get('SHOW')
			        end
			    end
			end
			function cb_layout(~, ~)
			    gui_layout = gui.memorize('GUI_LAYOUT');
			
			    gui_layout.get('DRAW')
			    gui_layout.get('SHOW')
			end
		end
	end
end
