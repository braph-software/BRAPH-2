classdef GUI < ConcreteElement
	%GUI renders a GUI figure.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A GUI renders a figure with its basic functionalities.
	% 
	% CONSTRUCTOR - To construct a GUI use, e.g.:
	% 
	%     gui = GUI('<strong>TITLE</strong>', 'Figure Title', '<strong>POSITION</strong>', [x0 y0 w h], '<strong>BKGCOLOR</strong>', [r g b]);
	%     
	% DRAW - To create and show the figure, use:
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
	% GUI methods (constructor):
	%  GUI - constructor
	%
	% GUI methods:
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
	% GUI methods (display):
	%  tostring - string with information about the graphical user interface
	%  disp - displays information about the graphical user interface
	%  tree - displays the tree of the graphical user interface
	%
	% GUI methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graphical user interface are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graphical user interface
	%
	% GUI methods (save/load, Static):
	%  save - saves BRAPH2 graphical user interface as b2 file
	%  load - loads a BRAPH2 graphical user interface from a b2 file
	%
	% GUI method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graphical user interface
	%
	% GUI method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graphical user interface
	%
	% GUI methods (inspection, Static):
	%  getClass - returns the class of the graphical user interface
	%  getSubclasses - returns all subclasses of GUI
	%  getProps - returns the property list of the graphical user interface
	%  getPropNumber - returns the property number of the graphical user interface
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
	% GUI methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GUI methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GUI methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GUI methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GUI; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GUI constants</a>.
	%
	%
	% See also uifigure, GUIElement, GUIFig.
	
	properties (Constant) % properties
		WAITBAR = ConcreteElement.getPropNumber() + 1;
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = Category.GUI;
		WAITBAR_FORMAT = Format.LOGICAL;
		
		DRAW = ConcreteElement.getPropNumber() + 2;
		DRAW_TAG = 'DRAW';
		DRAW_CATEGORY = Category.QUERY;
		DRAW_FORMAT = Format.LOGICAL;
		
		DRAWN = ConcreteElement.getPropNumber() + 3;
		DRAWN_TAG = 'DRAWN';
		DRAWN_CATEGORY = Category.QUERY;
		DRAWN_FORMAT = Format.LOGICAL;
		
		TITLE = ConcreteElement.getPropNumber() + 4;
		TITLE_TAG = 'TITLE';
		TITLE_CATEGORY = Category.GUI;
		TITLE_FORMAT = Format.STRING;
		
		POSITION = ConcreteElement.getPropNumber() + 5;
		POSITION_TAG = 'POSITION';
		POSITION_CATEGORY = Category.GUI;
		POSITION_FORMAT = Format.RVECTOR;
		
		BKGCOLOR = ConcreteElement.getPropNumber() + 6;
		BKGCOLOR_TAG = 'BKGCOLOR';
		BKGCOLOR_CATEGORY = Category.GUI;
		BKGCOLOR_FORMAT = Format.COLOR;
		
		H_MENUBAR = ConcreteElement.getPropNumber() + 7;
		H_MENUBAR_TAG = 'H_MENUBAR';
		H_MENUBAR_CATEGORY = Category.EVANESCENT;
		H_MENUBAR_FORMAT = Format.HANDLELIST;
		
		MENUBAR = ConcreteElement.getPropNumber() + 8;
		MENUBAR_TAG = 'MENUBAR';
		MENUBAR_CATEGORY = Category.GUI;
		MENUBAR_FORMAT = Format.LOGICAL;
		
		H_MENU_ABOUT = ConcreteElement.getPropNumber() + 9;
		H_MENU_ABOUT_TAG = 'H_MENU_ABOUT';
		H_MENU_ABOUT_CATEGORY = Category.EVANESCENT;
		H_MENU_ABOUT_FORMAT = Format.HANDLE;
		
		MENU_ABOUT = ConcreteElement.getPropNumber() + 10;
		MENU_ABOUT_TAG = 'MENU_ABOUT';
		MENU_ABOUT_CATEGORY = Category.GUI;
		MENU_ABOUT_FORMAT = Format.LOGICAL;
		
		H_TOOLBAR = ConcreteElement.getPropNumber() + 11;
		H_TOOLBAR_TAG = 'H_TOOLBAR';
		H_TOOLBAR_CATEGORY = Category.EVANESCENT;
		H_TOOLBAR_FORMAT = Format.HANDLE;
		
		H_TOOLS = ConcreteElement.getPropNumber() + 12;
		H_TOOLS_TAG = 'H_TOOLS';
		H_TOOLS_CATEGORY = Category.EVANESCENT;
		H_TOOLS_FORMAT = Format.HANDLELIST;
		
		TOOLBAR = ConcreteElement.getPropNumber() + 13;
		TOOLBAR_TAG = 'TOOLBAR';
		TOOLBAR_CATEGORY = Category.GUI;
		TOOLBAR_FORMAT = Format.LOGICAL;
		
		TOOL_ABOUT = ConcreteElement.getPropNumber() + 14;
		TOOL_ABOUT_TAG = 'TOOL_ABOUT';
		TOOL_ABOUT_CATEGORY = Category.GUI;
		TOOL_ABOUT_FORMAT = Format.LOGICAL;
		
		CLOSEREQ = ConcreteElement.getPropNumber() + 15;
		CLOSEREQ_TAG = 'CLOSEREQ';
		CLOSEREQ_CATEGORY = Category.GUI;
		CLOSEREQ_FORMAT = Format.LOGICAL;
		
		H = ConcreteElement.getPropNumber() + 16;
		H_TAG = 'H';
		H_CATEGORY = Category.EVANESCENT;
		H_FORMAT = Format.HANDLE;
		
		RESIZE = ConcreteElement.getPropNumber() + 17;
		RESIZE_TAG = 'RESIZE';
		RESIZE_CATEGORY = Category.QUERY;
		RESIZE_FORMAT = Format.LOGICAL;
		
		SHOW = ConcreteElement.getPropNumber() + 18;
		SHOW_TAG = 'SHOW';
		SHOW_CATEGORY = Category.QUERY;
		SHOW_FORMAT = Format.LOGICAL;
		
		HIDE = ConcreteElement.getPropNumber() + 19;
		HIDE_TAG = 'HIDE';
		HIDE_CATEGORY = Category.QUERY;
		HIDE_FORMAT = Format.LOGICAL;
		
		DELETE = ConcreteElement.getPropNumber() + 20;
		DELETE_TAG = 'DELETE';
		DELETE_CATEGORY = Category.QUERY;
		DELETE_FORMAT = Format.LOGICAL;
		
		CLOSE = ConcreteElement.getPropNumber() + 21;
		CLOSE_TAG = 'CLOSE';
		CLOSE_CATEGORY = Category.QUERY;
		CLOSE_FORMAT = Format.LOGICAL;
	end
	methods % constructor
		function gui = GUI(varargin)
			%GUI() creates a graphical user interface.
			%
			% GUI(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GUI(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			gui = gui@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function gui_class = getClass()
			%GETCLASS returns the class of the graphical user interface.
			%
			% CLASS = GUI.GETCLASS() returns the class 'GUI'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GUI.GETCLASS() returns the class of the graphical user interface GUI.
			%  CLASS = Element.GETCLASS(GUI) returns the class of 'GUI'.
			%  CLASS = Element.GETCLASS('GUI') returns 'GUI'.
			%
			% Note that the Element.GETCLASS(GUI) and Element.GETCLASS('GUI')
			%  are less computationally efficient.
			
			gui_class = 'GUI';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graphical user interface.
			%
			% LIST = GUI.GETSUBCLASSES() returns all subclasses of 'GUI'.
			%
			% Alternative forms to call this method are:
			%  LIST = GUI.GETSUBCLASSES() returns all subclasses of the graphical user interface GUI.
			%  LIST = Element.GETSUBCLASSES(GUI) returns all subclasses of 'GUI'.
			%  LIST = Element.GETSUBCLASSES('GUI') returns all subclasses of 'GUI'.
			%
			% Note that the Element.GETSUBCLASSES(GUI) and Element.GETSUBCLASSES('GUI')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GUI', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graphical user interface.
			%
			% PROPS = GUI.GETPROPS() returns the property list of graphical user interface
			%  as a row vector.
			%
			% PROPS = GUI.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GUI.GETPROPS([CATEGORY]) returns the property list of the graphical user interface GUI.
			%  PROPS = Element.GETPROPS(GUI[, CATEGORY]) returns the property list of 'GUI'.
			%  PROPS = Element.GETPROPS('GUI'[, CATEGORY]) returns the property list of 'GUI'.
			%
			% Note that the Element.GETPROPS(GUI) and Element.GETPROPS('GUI')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						GUI.WAITBAR ...
						GUI.DRAW ...
						GUI.DRAWN ...
						GUI.TITLE ...
						GUI.POSITION ...
						GUI.BKGCOLOR ...
						GUI.H_MENUBAR ...
						GUI.MENUBAR ...
						GUI.H_MENU_ABOUT ...
						GUI.MENU_ABOUT ...
						GUI.H_TOOLBAR ...
						GUI.H_TOOLS ...
						GUI.TOOLBAR ...
						GUI.TOOL_ABOUT ...
						GUI.CLOSEREQ ...
						GUI.H ...
						GUI.RESIZE ...
						GUI.SHOW ...
						GUI.HIDE ...
						GUI.DELETE ...
						GUI.CLOSE ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						GUI.DRAW ...
						GUI.DRAWN ...
						GUI.RESIZE ...
						GUI.SHOW ...
						GUI.HIDE ...
						GUI.DELETE ...
						GUI.CLOSE ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						GUI.H_MENUBAR ...
						GUI.H_MENU_ABOUT ...
						GUI.H_TOOLBAR ...
						GUI.H_TOOLS ...
						GUI.H ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						GUI.WAITBAR ...
						GUI.TITLE ...
						GUI.POSITION ...
						GUI.BKGCOLOR ...
						GUI.MENUBAR ...
						GUI.MENU_ABOUT ...
						GUI.TOOLBAR ...
						GUI.TOOL_ABOUT ...
						GUI.CLOSEREQ ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graphical user interface.
			%
			% N = GUI.GETPROPNUMBER() returns the property number of graphical user interface.
			%
			% N = GUI.GETPROPNUMBER(CATEGORY) returns the property number of graphical user interface
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GUI.GETPROPNUMBER([CATEGORY]) returns the property number of the graphical user interface GUI.
			%  N = Element.GETPROPNUMBER(GUI) returns the property number of 'GUI'.
			%  N = Element.GETPROPNUMBER('GUI') returns the property number of 'GUI'.
			%
			% Note that the Element.GETPROPNUMBER(GUI) and Element.GETPROPNUMBER('GUI')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GUI.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graphical user interface/error.
			%
			% CHECK = GUI.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GUI.EXISTSPROP(PROP) checks whether PROP exists for GUI.
			%  CHECK = Element.EXISTSPROP(GUI, PROP) checks whether PROP exists for GUI.
			%  CHECK = Element.EXISTSPROP(GUI, PROP) checks whether PROP exists for GUI.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GUI:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GUI.EXISTSPROP(PROP) throws error if PROP does NOT exist for GUI.
			%   Error id: [BRAPH2:GUI:WrongInput]
			%  Element.EXISTSPROP(GUI, PROP) throws error if PROP does NOT exist for GUI.
			%   Error id: [BRAPH2:GUI:WrongInput]
			%  Element.EXISTSPROP(GUI, PROP) throws error if PROP does NOT exist for GUI.
			%   Error id: [BRAPH2:GUI:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GUI) and Element.EXISTSPROP('GUI')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GUI.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GUI:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GUI:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GUI.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graphical user interface/error.
			%
			% CHECK = GUI.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GUI.EXISTSTAG(TAG) checks whether TAG exists for GUI.
			%  CHECK = Element.EXISTSTAG(GUI, TAG) checks whether TAG exists for GUI.
			%  CHECK = Element.EXISTSTAG(GUI, TAG) checks whether TAG exists for GUI.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GUI:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GUI.EXISTSTAG(TAG) throws error if TAG does NOT exist for GUI.
			%   Error id: [BRAPH2:GUI:WrongInput]
			%  Element.EXISTSTAG(GUI, TAG) throws error if TAG does NOT exist for GUI.
			%   Error id: [BRAPH2:GUI:WrongInput]
			%  Element.EXISTSTAG(GUI, TAG) throws error if TAG does NOT exist for GUI.
			%   Error id: [BRAPH2:GUI:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GUI) and Element.EXISTSTAG('GUI')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			gui_tag_list = cellfun(@(x) GUI.getPropTag(x), num2cell(GUI.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, gui_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GUI:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GUI:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GUI.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GUI, POINTER) returns property number of POINTER of GUI.
			%  PROPERTY = GUI.GETPROPPROP(GUI, POINTER) returns property number of POINTER of GUI.
			%
			% Note that the Element.GETPROPPROP(GUI) and Element.GETPROPPROP('GUI')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				gui_tag_list = cellfun(@(x) GUI.getPropTag(x), num2cell(GUI.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, gui_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GUI, POINTER) returns tag of POINTER of GUI.
			%  TAG = GUI.GETPROPTAG(GUI, POINTER) returns tag of POINTER of GUI.
			%
			% Note that the Element.GETPROPTAG(GUI) and Element.GETPROPTAG('GUI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GUI.WAITBAR
						tag = GUI.WAITBAR_TAG;
					case GUI.DRAW
						tag = GUI.DRAW_TAG;
					case GUI.DRAWN
						tag = GUI.DRAWN_TAG;
					case GUI.TITLE
						tag = GUI.TITLE_TAG;
					case GUI.POSITION
						tag = GUI.POSITION_TAG;
					case GUI.BKGCOLOR
						tag = GUI.BKGCOLOR_TAG;
					case GUI.H_MENUBAR
						tag = GUI.H_MENUBAR_TAG;
					case GUI.MENUBAR
						tag = GUI.MENUBAR_TAG;
					case GUI.H_MENU_ABOUT
						tag = GUI.H_MENU_ABOUT_TAG;
					case GUI.MENU_ABOUT
						tag = GUI.MENU_ABOUT_TAG;
					case GUI.H_TOOLBAR
						tag = GUI.H_TOOLBAR_TAG;
					case GUI.H_TOOLS
						tag = GUI.H_TOOLS_TAG;
					case GUI.TOOLBAR
						tag = GUI.TOOLBAR_TAG;
					case GUI.TOOL_ABOUT
						tag = GUI.TOOL_ABOUT_TAG;
					case GUI.CLOSEREQ
						tag = GUI.CLOSEREQ_TAG;
					case GUI.H
						tag = GUI.H_TAG;
					case GUI.RESIZE
						tag = GUI.RESIZE_TAG;
					case GUI.SHOW
						tag = GUI.SHOW_TAG;
					case GUI.HIDE
						tag = GUI.HIDE_TAG;
					case GUI.DELETE
						tag = GUI.DELETE_TAG;
					case GUI.CLOSE
						tag = GUI.CLOSE_TAG;
					otherwise
						tag = getPropTag@ConcreteElement(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(GUI, POINTER) returns category of POINTER of GUI.
			%  CATEGORY = GUI.GETPROPCATEGORY(GUI, POINTER) returns category of POINTER of GUI.
			%
			% Note that the Element.GETPROPCATEGORY(GUI) and Element.GETPROPCATEGORY('GUI')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GUI.getPropProp(pointer);
			
			switch prop
				case GUI.WAITBAR
					prop_category = GUI.WAITBAR_CATEGORY;
				case GUI.DRAW
					prop_category = GUI.DRAW_CATEGORY;
				case GUI.DRAWN
					prop_category = GUI.DRAWN_CATEGORY;
				case GUI.TITLE
					prop_category = GUI.TITLE_CATEGORY;
				case GUI.POSITION
					prop_category = GUI.POSITION_CATEGORY;
				case GUI.BKGCOLOR
					prop_category = GUI.BKGCOLOR_CATEGORY;
				case GUI.H_MENUBAR
					prop_category = GUI.H_MENUBAR_CATEGORY;
				case GUI.MENUBAR
					prop_category = GUI.MENUBAR_CATEGORY;
				case GUI.H_MENU_ABOUT
					prop_category = GUI.H_MENU_ABOUT_CATEGORY;
				case GUI.MENU_ABOUT
					prop_category = GUI.MENU_ABOUT_CATEGORY;
				case GUI.H_TOOLBAR
					prop_category = GUI.H_TOOLBAR_CATEGORY;
				case GUI.H_TOOLS
					prop_category = GUI.H_TOOLS_CATEGORY;
				case GUI.TOOLBAR
					prop_category = GUI.TOOLBAR_CATEGORY;
				case GUI.TOOL_ABOUT
					prop_category = GUI.TOOL_ABOUT_CATEGORY;
				case GUI.CLOSEREQ
					prop_category = GUI.CLOSEREQ_CATEGORY;
				case GUI.H
					prop_category = GUI.H_CATEGORY;
				case GUI.RESIZE
					prop_category = GUI.RESIZE_CATEGORY;
				case GUI.SHOW
					prop_category = GUI.SHOW_CATEGORY;
				case GUI.HIDE
					prop_category = GUI.HIDE_CATEGORY;
				case GUI.DELETE
					prop_category = GUI.DELETE_CATEGORY;
				case GUI.CLOSE
					prop_category = GUI.CLOSE_CATEGORY;
				otherwise
					prop_category = getPropCategory@ConcreteElement(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(GUI, POINTER) returns format of POINTER of GUI.
			%  FORMAT = GUI.GETPROPFORMAT(GUI, POINTER) returns format of POINTER of GUI.
			%
			% Note that the Element.GETPROPFORMAT(GUI) and Element.GETPROPFORMAT('GUI')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GUI.getPropProp(pointer);
			
			switch prop
				case GUI.WAITBAR
					prop_format = GUI.WAITBAR_FORMAT;
				case GUI.DRAW
					prop_format = GUI.DRAW_FORMAT;
				case GUI.DRAWN
					prop_format = GUI.DRAWN_FORMAT;
				case GUI.TITLE
					prop_format = GUI.TITLE_FORMAT;
				case GUI.POSITION
					prop_format = GUI.POSITION_FORMAT;
				case GUI.BKGCOLOR
					prop_format = GUI.BKGCOLOR_FORMAT;
				case GUI.H_MENUBAR
					prop_format = GUI.H_MENUBAR_FORMAT;
				case GUI.MENUBAR
					prop_format = GUI.MENUBAR_FORMAT;
				case GUI.H_MENU_ABOUT
					prop_format = GUI.H_MENU_ABOUT_FORMAT;
				case GUI.MENU_ABOUT
					prop_format = GUI.MENU_ABOUT_FORMAT;
				case GUI.H_TOOLBAR
					prop_format = GUI.H_TOOLBAR_FORMAT;
				case GUI.H_TOOLS
					prop_format = GUI.H_TOOLS_FORMAT;
				case GUI.TOOLBAR
					prop_format = GUI.TOOLBAR_FORMAT;
				case GUI.TOOL_ABOUT
					prop_format = GUI.TOOL_ABOUT_FORMAT;
				case GUI.CLOSEREQ
					prop_format = GUI.CLOSEREQ_FORMAT;
				case GUI.H
					prop_format = GUI.H_FORMAT;
				case GUI.RESIZE
					prop_format = GUI.RESIZE_FORMAT;
				case GUI.SHOW
					prop_format = GUI.SHOW_FORMAT;
				case GUI.HIDE
					prop_format = GUI.HIDE_FORMAT;
				case GUI.DELETE
					prop_format = GUI.DELETE_FORMAT;
				case GUI.CLOSE
					prop_format = GUI.CLOSE_FORMAT;
				otherwise
					prop_format = getPropFormat@ConcreteElement(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GUI, POINTER) returns description of POINTER of GUI.
			%  DESCRIPTION = GUI.GETPROPDESCRIPTION(GUI, POINTER) returns description of POINTER of GUI.
			%
			% Note that the Element.GETPROPDESCRIPTION(GUI) and Element.GETPROPDESCRIPTION('GUI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GUI.getPropProp(pointer);
			
			switch prop
				case GUI.WAITBAR
					prop_description = 'WAITBAR (gui, logical) detemines whether to show the waitbar.';
				case GUI.DRAW
					prop_description = 'DRAW (query, logical) draws the contents of a GUI before showing it.';
				case GUI.DRAWN
					prop_description = 'DRAWN (query, logical) returns whether the GUI has been drawn.';
				case GUI.TITLE
					prop_description = 'TITLE (gui, string) is the name of the GUI.';
				case GUI.POSITION
					prop_description = 'POSITION (gui, rvector) is the normalized position of the GUI on the screen.';
				case GUI.BKGCOLOR
					prop_description = 'BKGCOLOR (gui, color) is the GUI background color.';
				case GUI.H_MENUBAR
					prop_description = 'H_MENUBAR (evanescent, handlelist) is the list of handles for the menus.';
				case GUI.MENUBAR
					prop_description = 'MENUBAR (gui, logical) determines whether to show the menubar [set before DRAW].';
				case GUI.H_MENU_ABOUT
					prop_description = 'H_MENU_ABOUT (evanescent, handle) is the handle of the menu about.';
				case GUI.MENU_ABOUT
					prop_description = 'MENU_ABOUT (gui, logical) determines whether to show the menu about [set before DRAW].';
				case GUI.H_TOOLBAR
					prop_description = 'H_TOOLBAR (evanescent, handle) is the handle list of the toolbar.';
				case GUI.H_TOOLS
					prop_description = 'H_TOOLS (evanescent, handlelist) is the handle list of the tools from the first.';
				case GUI.TOOLBAR
					prop_description = 'TOOLBAR (gui, logical) determines whether to show the toolbar [set before DRAW].';
				case GUI.TOOL_ABOUT
					prop_description = 'TOOL_ABOUT (gui, logical) determines whether to show the toolbar about buttons [set before DRAW].';
				case GUI.CLOSEREQ
					prop_description = 'CLOSEREQ (gui, logical) determines whether to confirm close.';
				case GUI.H
					prop_description = 'H (evanescent, handle) is the figure handle.';
				case GUI.RESIZE
					prop_description = 'RESIZE (query, logical) updates POSITION when figure size is changed.';
				case GUI.SHOW
					prop_description = 'SHOW (query, logical) shows the figure and its dependent figures.';
				case GUI.HIDE
					prop_description = 'HIDE (query, logical) hides the figure and its dependent figures.';
				case GUI.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the figure is deleted.';
				case GUI.CLOSE
					prop_description = 'CLOSE (query, logical) closes the figure and its dependent figures.';
				case GUI.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the graphical user interface.';
				case GUI.NAME
					prop_description = 'NAME (constant, string) is the name of the graphical user interface.';
				case GUI.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the graphical user interface.';
				case GUI.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the graphical user interface.';
				case GUI.ID
					prop_description = 'ID (data, string) is a few-letter code for the graphical user interface.';
				case GUI.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the graphical user interface.';
				case GUI.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the graphical user interface.';
				otherwise
					prop_description = getPropDescription@ConcreteElement(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(GUI, POINTER) returns settings of POINTER of GUI.
			%  SETTINGS = GUI.GETPROPSETTINGS(GUI, POINTER) returns settings of POINTER of GUI.
			%
			% Note that the Element.GETPROPSETTINGS(GUI) and Element.GETPROPSETTINGS('GUI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GUI.getPropProp(pointer);
			
			switch prop
				case GUI.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.DRAW
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.DRAWN
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.TITLE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GUI.POSITION
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case GUI.BKGCOLOR
					prop_settings = Format.getFormatSettings(Format.COLOR);
				case GUI.H_MENUBAR
					prop_settings = Format.getFormatSettings(Format.HANDLELIST);
				case GUI.MENUBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.H_MENU_ABOUT
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GUI.MENU_ABOUT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.H_TOOLBAR
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GUI.H_TOOLS
					prop_settings = Format.getFormatSettings(Format.HANDLELIST);
				case GUI.TOOLBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.TOOL_ABOUT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.CLOSEREQ
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.H
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GUI.RESIZE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.SHOW
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.HIDE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.DELETE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.CLOSE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUI.TEMPLATE
					prop_settings = 'GUI';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GUI.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GUI.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GUI.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GUI.
			%  DEFAULT = Element.GETPROPDEFAULT(GUI, POINTER) returns the default value of POINTER of GUI.
			%  DEFAULT = GUI.GETPROPDEFAULT(GUI, POINTER) returns the default value of POINTER of GUI.
			%
			% Note that the Element.GETPROPDEFAULT(GUI) and Element.GETPROPDEFAULT('GUI')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GUI.getPropProp(pointer);
			
			switch prop
				case GUI.WAITBAR
					prop_default = Format.getFormatDefault(Format.LOGICAL, GUI.getPropSettings(prop));
				case GUI.DRAW
					prop_default = Format.getFormatDefault(Format.LOGICAL, GUI.getPropSettings(prop));
				case GUI.DRAWN
					prop_default = Format.getFormatDefault(Format.LOGICAL, GUI.getPropSettings(prop));
				case GUI.TITLE
					prop_default = BRAPH2.STR;
				case GUI.POSITION
					prop_default = [.00 .00 (PanelElement.getPropDefault('MIN_WIDTH')+20)/w(0, 'pixels') 1.00];
				case GUI.BKGCOLOR
					prop_default = BRAPH2.COL_BKG;
				case GUI.H_MENUBAR
					prop_default = Format.getFormatDefault(Format.HANDLELIST, GUI.getPropSettings(prop));
				case GUI.MENUBAR
					prop_default = false;
				case GUI.H_MENU_ABOUT
					prop_default = Format.getFormatDefault(Format.HANDLE, GUI.getPropSettings(prop));
				case GUI.MENU_ABOUT
					prop_default = false;
				case GUI.H_TOOLBAR
					prop_default = Format.getFormatDefault(Format.HANDLE, GUI.getPropSettings(prop));
				case GUI.H_TOOLS
					prop_default = Format.getFormatDefault(Format.HANDLELIST, GUI.getPropSettings(prop));
				case GUI.TOOLBAR
					prop_default = false;
				case GUI.TOOL_ABOUT
					prop_default = false;
				case GUI.CLOSEREQ
					prop_default = true;
				case GUI.H
					prop_default = Format.getFormatDefault(Format.HANDLE, GUI.getPropSettings(prop));
				case GUI.RESIZE
					prop_default = Format.getFormatDefault(Format.LOGICAL, GUI.getPropSettings(prop));
				case GUI.SHOW
					prop_default = Format.getFormatDefault(Format.LOGICAL, GUI.getPropSettings(prop));
				case GUI.HIDE
					prop_default = Format.getFormatDefault(Format.LOGICAL, GUI.getPropSettings(prop));
				case GUI.DELETE
					prop_default = Format.getFormatDefault(Format.LOGICAL, GUI.getPropSettings(prop));
				case GUI.CLOSE
					prop_default = Format.getFormatDefault(Format.LOGICAL, GUI.getPropSettings(prop));
				case GUI.ELCLASS
					prop_default = 'GUI';
				case GUI.NAME
					prop_default = 'GUI';
				case GUI.DESCRIPTION
					prop_default = 'A GUI renders a figure with its basic functionalities.';
				case GUI.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, GUI.getPropSettings(prop));
				case GUI.ID
					prop_default = 'GUI ID';
				case GUI.LABEL
					prop_default = 'GUI label';
				case GUI.NOTES
					prop_default = 'GUI notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GUI.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GUI, POINTER) returns the conditioned default value of POINTER of GUI.
			%  DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(GUI, POINTER) returns the conditioned default value of POINTER of GUI.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GUI) and Element.GETPROPDEFAULTCONDITIONED('GUI')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GUI.getPropProp(pointer);
			
			prop_default = GUI.conditioning(prop, GUI.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GUI, PROP, VALUE) checks VALUE format for PROP of GUI.
			%  CHECK = GUI.CHECKPROP(GUI, PROP, VALUE) checks VALUE format for PROP of GUI.
			% 
			% GUI.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GUI:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GUI.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GUI.
			%   Error id: €BRAPH2.STR€:GUI:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GUI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GUI.
			%   Error id: €BRAPH2.STR€:GUI:€BRAPH2.WRONG_INPUT€
			%  GUI.CHECKPROP(GUI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GUI.
			%   Error id: €BRAPH2.STR€:GUI:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(GUI) and Element.CHECKPROP('GUI')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GUI.getPropProp(pointer);
			
			switch prop
				case GUI.WAITBAR % __GUI.WAITBAR__
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.DRAW % __GUI.DRAW__
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.DRAWN % __GUI.DRAWN__
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.TITLE % __GUI.TITLE__
					check = Format.checkFormat(Format.STRING, value, GUI.getPropSettings(prop));
				case GUI.POSITION % __GUI.POSITION__
					check = Format.checkFormat(Format.RVECTOR, value, GUI.getPropSettings(prop));
					if check
						check = (length(value) == 4) && all(value(3:4) >= 0);
					end
				case GUI.BKGCOLOR % __GUI.BKGCOLOR__
					check = Format.checkFormat(Format.COLOR, value, GUI.getPropSettings(prop));
				case GUI.H_MENUBAR % __GUI.H_MENUBAR__
					check = Format.checkFormat(Format.HANDLELIST, value, GUI.getPropSettings(prop));
				case GUI.MENUBAR % __GUI.MENUBAR__
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.H_MENU_ABOUT % __GUI.H_MENU_ABOUT__
					check = Format.checkFormat(Format.HANDLE, value, GUI.getPropSettings(prop));
				case GUI.MENU_ABOUT % __GUI.MENU_ABOUT__
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.H_TOOLBAR % __GUI.H_TOOLBAR__
					check = Format.checkFormat(Format.HANDLE, value, GUI.getPropSettings(prop));
				case GUI.H_TOOLS % __GUI.H_TOOLS__
					check = Format.checkFormat(Format.HANDLELIST, value, GUI.getPropSettings(prop));
				case GUI.TOOLBAR % __GUI.TOOLBAR__
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.TOOL_ABOUT % __GUI.TOOL_ABOUT__
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.CLOSEREQ % __GUI.CLOSEREQ__
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.H % __GUI.H__
					check = Format.checkFormat(Format.HANDLE, value, GUI.getPropSettings(prop));
				case GUI.RESIZE % __GUI.RESIZE__
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.SHOW % __GUI.SHOW__
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.HIDE % __GUI.HIDE__
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.DELETE % __GUI.DELETE__
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.CLOSE % __GUI.CLOSE__
					check = Format.checkFormat(Format.LOGICAL, value, GUI.getPropSettings(prop));
				case GUI.TEMPLATE % __GUI.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, GUI.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GUI:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GUI:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GUI.getPropTag(prop) ' (' GUI.getFormatTag(GUI.getPropFormat(prop)) ').'] ...
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
				case GUI.TITLE % __GUI.TITLE__
					if gui.get('DRAWN')
					    set(gui.get('H'), 'Name', gui.get('TITLE'))
					end
					
				case GUI.POSITION % __GUI.POSITION__
					if gui.get('DRAWN')
					    set(gui.get('H'), 'Position', gui.get('POSITION'))
					end
					
				case GUI.BKGCOLOR % __GUI.BKGCOLOR__
					if gui.get('DRAWN')
					    set(gui.get('H'), 'Color', gui.get('BKGCOLOR'))
					end
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						postset@ConcreteElement(gui, prop);
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
				case GUI.DRAW % __GUI.DRAW__
					if check_graphics(gui.memorize('H'), 'figure')
					
					    if gui.get('MENUBAR')
					        gui.memorize('H_MENUBAR')
					    end
					
					    if gui.get('TOOLBAR')
					        % gui.memorize('H_TOOLBAR') % performed automatically by gui.memorize('H_TOOLS')
					        gui.memorize('H_TOOLS')
					    end
					    
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
					
				case GUI.DRAWN % __GUI.DRAWN__
					value = check_graphics(gui.getr('H'), 'figure');
					
				case GUI.H_MENUBAR % __GUI.H_MENUBAR__
					value = {};
					if gui.get('MENU_ABOUT')
					    value = [value, gui.memorize('H_MENU_ABOUT')];
					end
					
				case GUI.H_MENU_ABOUT % __GUI.H_MENU_ABOUT__
					menu_about = uimenu(gui.get('H'), ... % f for figure
					    'Tag', 'MENU.About', ...
					    'Label', 'About' ...
					    );
					
					uimenu(menu_about, ...
					    'Tag', 'MENU.About.Web', ...
					    'Label', 'BRAPH.org ...', ...
					    'Callback', 'BRAPH2.web()')
					uimenu(menu_about, ...
					    'Tag', 'MENU.About.Forum', ...
					    'Label', 'Forums ...', ...
					    'Callback', 'BRAPH2.forum()')
					uimenu(menu_about, ...
					    'Tag', 'MENU.About.Twitter', ...
					    'Label', 'Twitter ...', ...
					    'Callback', 'BRAPH2.twitter()')
					uimenu(menu_about, ...
					    'Tag', 'MENU.About.License', ...
					    'Label', 'License ...', ...
					    'Callback', 'BRAPH2.license()')
					uimenu(menu_about, ...
					    'Tag', 'MENU.About.Credits', ...
					    'Label', 'Credits ...', ...
					    'Callback', 'BRAPH2.credits()')
					
					value = menu_about;
					
				case GUI.H_TOOLBAR % __GUI.H_TOOLBAR__
					value = uitoolbar(gui.memorize('H'), 'Tag', 'TOOLBAR');
					
				case GUI.H_TOOLS % __GUI.H_TOOLS__
					toolbar = gui.memorize('H_TOOLBAR');
					
					value = {};
					
					if gui.get('TOOL_ABOUT')
					    tool_spacer_1 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
					
					    % Website
					    tool_about_web = uipushtool(toolbar, ...
					        'Tag', 'BRAPH2.Web', ...                
					        'Separator', 'on', ...
					        'Tooltip', 'Link to braph.org', ...
					        'CData', imread('icon_web.png'), ...
					        'ClickedCallback', 'BRAPH2.web()');
					
					    % Forum
					    tool_about_forum = uipushtool(toolbar, ...
					        'Tag', 'BRAPH2.Forum', ...                
					        'Separator', 'off', ...
					        'Tooltip', 'Link to the BRAPH 2.0 forums', ...
					        'CData', imread('icon_forum.png'), ...
					        'ClickedCallback', 'BRAPH2.forum()');
					
					    % Twitter
					    tool_about_twitter = uipushtool(toolbar, ...
					        'Tag', 'BRAPH2.Twitter', ...                
					        'Separator', 'off', ...
					        'Tooltip', 'Link to the BRAPH 2.0 Twitter', ...
					        'CData', imread('icon_twitter.png'), ...
					        'ClickedCallback', 'BRAPH2.twitter()');
					
					    tool_spacer_2 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
					
					    % License
					    tool_about_license = uipushtool(toolbar, ...
					        'Tag', 'BRAPH2.License', ...                
					        'Separator', 'on', ...
					        'Tooltip', 'BRAPH 2.0 License', ...
					        'CData', imread('icon_license.png'), ...
					        'ClickedCallback', 'BRAPH2.license()');
					
					    % Credits
					    tool_about_credits = uipushtool(toolbar, ...
					        'Tag', 'BRAPH2.Credits', ...                
					        'Separator', 'off', ...
					        'Tooltip', 'Informtion about BRAPH 2.0 and credits', ...
					        'CData', imread('icon_about.png'), ...
					        'ClickedCallback', 'BRAPH2.credits()');
					    
					    value = {value{:}, tool_spacer_1, tool_about_web, tool_about_forum, tool_about_twitter, tool_spacer_2, tool_about_license, tool_about_credits};
					end
					
				case GUI.H % __GUI.H__
					f = uifigure( ...
					    'Visible', 'off', ...
					    'Tag', 'H', ...
					    'UserData', gui, ... % handle to retrieve gui
					    'Name', gui.get('TITLE'), ...
					    'Units', 'normalized', ...
					    'Position', gui.get('POSITION'), ...
					    'Color', gui.get('BKGCOLOR'), ...
					    'Icon', 'braph2icon.png', ...
					    'AutoResizeChildren', false, ...
					    'SizeChangedFcn', {@cb_get, 'RESIZE'}, ...
					    'DeleteFcn', {@cb_get, 'DELETE'}, ...
					    'CloseRequestFcn', {@cb_get, 'CLOSE'} ...
					    );
					value = f;
					
				case GUI.RESIZE % __GUI.RESIZE__
					if gui.get('DRAWN')
					    gui.set('POSITION', gui.get('H').get('Position'))
					    
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(gui)], ...
					        [BRAPH2.STR ':' class(gui) '\n' ...
					        'The call gui.get(''RESIZE'') has NOT been executed.\n' ...
					        'First, the gui ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case GUI.SHOW % __GUI.SHOW__
					if gui.get('DRAWN')
					    figure(gui.get('H')) 
					    set(gui.get('H'), ...
					        'Visible', 'on', ...
					        'WindowState', 'normal' ...
					        )
					
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(gui)], ...
					        [BRAPH2.STR ':' class(gui) '\n' ...
					        'The call gui.get(''SHOW'') has NOT been executed.\n' ...
					        'First, the gui ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case GUI.HIDE % __GUI.HIDE__
					if gui.get('DRAWN')
					    set(gui.get('H'), 'Visible', 'off')
					
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(gui)], ...
					        [BRAPH2.STR ':' class(gui) '\n' ...
					        'The call gui.get(''HIDE'') has NOT been executed.\n' ...
					        'First, the gui ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case GUI.DELETE % __GUI.DELETE__
					if gui.get('DRAWN')
					    gui.set('POSITION', gui.get('H').get('Position'))
					
					    gui.set('H', Element.getNoValue())
					
					    gui.set('H_MENUBAR', Element.getNoValue())
					    gui.set('H_MENU_ABOUT', Element.getNoValue())
					
					    gui.set('H_TOOLBAR', Element.getNoValue())
					    gui.set('H_TOOLS', Element.getNoValue())
					    
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(gui)], ...
					        [BRAPH2.STR ':' class(gui) '\n' ...
					        'The call gui.get(''DELETE'') has NOT been executed.\n' ...
					        'First, the gui ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case GUI.CLOSE % __GUI.CLOSE__
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
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(gui, prop, varargin{:});
					else
						value = calculateValue@Element(gui, prop, varargin{:});
					end
			end
			
			function cb_get(~, ~, varargin)
				gui.get(varargin{:})
			end
		end
	end
end
