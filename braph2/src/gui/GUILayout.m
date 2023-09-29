classdef GUILayout < GUI
	%GUILayout is a layout editor.
	% It is a subclass of <a href="matlab:help GUI">GUI</a>.
	%
	% A GUI Layout (GUILayout) renders a layout editor.
	% 
	% CONSTRUCTOR - To construct a GUILayout use, e.g.:
	% 
	%     gui = GUILayout('<strong>EL_CLASS</strong>', EL_CLASS, '<strong>POSITION</strong>', [x0 y0 w h], '<strong>BKGCOLOR</strong>', [r g b]);
	%     gui = GUILayout('<strong>EL_CLASS</strong>', EL, '<strong>POSITION</strong>', [x0 y0 w h], '<strong>BKGCOLOR</strong>', [r g b]);
	% 
	%  The argument of EL_CLASS can be an element class or an element.
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
	% GUILayout methods (constructor):
	%  GUILayout - constructor
	%
	% GUILayout methods:
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
	% GUILayout methods (display):
	%  tostring - string with information about the GUI layout
	%  disp - displays information about the GUI layout
	%  tree - displays the tree of the GUI layout
	%
	% GUILayout methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two GUI layout are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the GUI layout
	%
	% GUILayout methods (save/load, Static):
	%  save - saves BRAPH2 GUI layout as b2 file
	%  load - loads a BRAPH2 GUI layout from a b2 file
	%
	% GUILayout method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the GUI layout
	%
	% GUILayout method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the GUI layout
	%
	% GUILayout methods (inspection, Static):
	%  getClass - returns the class of the GUI layout
	%  getSubclasses - returns all subclasses of GUILayout
	%  getProps - returns the property list of the GUI layout
	%  getPropNumber - returns the property number of the GUI layout
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
	% GUILayout methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GUILayout methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GUILayout methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GUILayout methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GUILayout; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GUILayout constants</a>.
	%
	%
	% See also uifigure, GUI, Element.
	
	properties (Constant) % properties
		EL_CLASS = GUI.getPropNumber() + 1;
		EL_CLASS_TAG = 'EL_CLASS';
		EL_CLASS_CATEGORY = Category.DATA;
		EL_CLASS_FORMAT = Format.CLASS;
		
		P = GUI.getPropNumber() + 2;
		P_TAG = 'P';
		P_CATEGORY = Category.EVANESCENT;
		P_FORMAT = Format.HANDLE;
		
		TABLE = GUI.getPropNumber() + 3;
		TABLE_TAG = 'TABLE';
		TABLE_CATEGORY = Category.EVANESCENT;
		TABLE_FORMAT = Format.HANDLE;
		
		SAVE_BTN = GUI.getPropNumber() + 4;
		SAVE_BTN_TAG = 'SAVE_BTN';
		SAVE_BTN_CATEGORY = Category.EVANESCENT;
		SAVE_BTN_FORMAT = Format.HANDLE;
		
		CANCEL_BTN = GUI.getPropNumber() + 5;
		CANCEL_BTN_TAG = 'CANCEL_BTN';
		CANCEL_BTN_CATEGORY = Category.EVANESCENT;
		CANCEL_BTN_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function gui = GUILayout(varargin)
			%GUILayout() creates a GUI layout.
			%
			% GUILayout(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GUILayout(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the GUI layout.
			%
			% CLASS = GUILayout.GETCLASS() returns the class 'GUILayout'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GUI.GETCLASS() returns the class of the GUI layout GUI.
			%  CLASS = Element.GETCLASS(GUI) returns the class of 'GUI'.
			%  CLASS = Element.GETCLASS('GUILayout') returns 'GUILayout'.
			%
			% Note that the Element.GETCLASS(GUI) and Element.GETCLASS('GUILayout')
			%  are less computationally efficient.
			
			gui_class = 'GUILayout';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the GUI layout.
			%
			% LIST = GUILayout.GETSUBCLASSES() returns all subclasses of 'GUILayout'.
			%
			% Alternative forms to call this method are:
			%  LIST = GUI.GETSUBCLASSES() returns all subclasses of the GUI layout GUI.
			%  LIST = Element.GETSUBCLASSES(GUI) returns all subclasses of 'GUI'.
			%  LIST = Element.GETSUBCLASSES('GUILayout') returns all subclasses of 'GUILayout'.
			%
			% Note that the Element.GETSUBCLASSES(GUI) and Element.GETSUBCLASSES('GUILayout')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GUILayout', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of GUI layout.
			%
			% PROPS = GUILayout.GETPROPS() returns the property list of GUI layout
			%  as a row vector.
			%
			% PROPS = GUILayout.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GUI.GETPROPS([CATEGORY]) returns the property list of the GUI layout GUI.
			%  PROPS = Element.GETPROPS(GUI[, CATEGORY]) returns the property list of 'GUI'.
			%  PROPS = Element.GETPROPS('GUILayout'[, CATEGORY]) returns the property list of 'GUILayout'.
			%
			% Note that the Element.GETPROPS(GUI) and Element.GETPROPS('GUILayout')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					GUI.getProps() ...
						GUILayout.EL_CLASS ...
						GUILayout.P ...
						GUILayout.TABLE ...
						GUILayout.SAVE_BTN ...
						GUILayout.CANCEL_BTN ...
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
						];
				case Category.PARAMETER
					prop_list = [ ...
						GUI.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						GUI.getProps(Category.DATA) ...
						GUILayout.EL_CLASS ...
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
						GUILayout.P ...
						GUILayout.TABLE ...
						GUILayout.SAVE_BTN ...
						GUILayout.CANCEL_BTN ...
						];
				case Category.FIGURE
					prop_list = [ ...
						GUI.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						GUI.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of GUI layout.
			%
			% N = GUILayout.GETPROPNUMBER() returns the property number of GUI layout.
			%
			% N = GUILayout.GETPROPNUMBER(CATEGORY) returns the property number of GUI layout
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GUI.GETPROPNUMBER([CATEGORY]) returns the property number of the GUI layout GUI.
			%  N = Element.GETPROPNUMBER(GUI) returns the property number of 'GUI'.
			%  N = Element.GETPROPNUMBER('GUILayout') returns the property number of 'GUILayout'.
			%
			% Note that the Element.GETPROPNUMBER(GUI) and Element.GETPROPNUMBER('GUILayout')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GUILayout.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in GUI layout/error.
			%
			% CHECK = GUILayout.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GUI.EXISTSPROP(PROP) checks whether PROP exists for GUI.
			%  CHECK = Element.EXISTSPROP(GUI, PROP) checks whether PROP exists for GUI.
			%  CHECK = Element.EXISTSPROP(GUILayout, PROP) checks whether PROP exists for GUILayout.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GUILayout:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GUI.EXISTSPROP(PROP) throws error if PROP does NOT exist for GUI.
			%   Error id: [BRAPH2:GUILayout:WrongInput]
			%  Element.EXISTSPROP(GUI, PROP) throws error if PROP does NOT exist for GUI.
			%   Error id: [BRAPH2:GUILayout:WrongInput]
			%  Element.EXISTSPROP(GUILayout, PROP) throws error if PROP does NOT exist for GUILayout.
			%   Error id: [BRAPH2:GUILayout:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GUI) and Element.EXISTSPROP('GUILayout')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GUILayout.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GUILayout:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GUILayout:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GUILayout.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in GUI layout/error.
			%
			% CHECK = GUILayout.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GUI.EXISTSTAG(TAG) checks whether TAG exists for GUI.
			%  CHECK = Element.EXISTSTAG(GUI, TAG) checks whether TAG exists for GUI.
			%  CHECK = Element.EXISTSTAG(GUILayout, TAG) checks whether TAG exists for GUILayout.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GUILayout:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GUI.EXISTSTAG(TAG) throws error if TAG does NOT exist for GUI.
			%   Error id: [BRAPH2:GUILayout:WrongInput]
			%  Element.EXISTSTAG(GUI, TAG) throws error if TAG does NOT exist for GUI.
			%   Error id: [BRAPH2:GUILayout:WrongInput]
			%  Element.EXISTSTAG(GUILayout, TAG) throws error if TAG does NOT exist for GUILayout.
			%   Error id: [BRAPH2:GUILayout:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GUI) and Element.EXISTSTAG('GUILayout')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			guilayout_tag_list = cellfun(@(x) GUILayout.getPropTag(x), num2cell(GUILayout.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, guilayout_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GUILayout:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GUILayout:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GUILayout.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GUILayout, POINTER) returns property number of POINTER of GUILayout.
			%  PROPERTY = GUI.GETPROPPROP(GUILayout, POINTER) returns property number of POINTER of GUILayout.
			%
			% Note that the Element.GETPROPPROP(GUI) and Element.GETPROPPROP('GUILayout')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				guilayout_tag_list = cellfun(@(x) GUILayout.getPropTag(x), num2cell(GUILayout.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, guilayout_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GUILayout, POINTER) returns tag of POINTER of GUILayout.
			%  TAG = GUI.GETPROPTAG(GUILayout, POINTER) returns tag of POINTER of GUILayout.
			%
			% Note that the Element.GETPROPTAG(GUI) and Element.GETPROPTAG('GUILayout')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GUILayout.EL_CLASS
						tag = GUILayout.EL_CLASS_TAG;
					case GUILayout.P
						tag = GUILayout.P_TAG;
					case GUILayout.TABLE
						tag = GUILayout.TABLE_TAG;
					case GUILayout.SAVE_BTN
						tag = GUILayout.SAVE_BTN_TAG;
					case GUILayout.CANCEL_BTN
						tag = GUILayout.CANCEL_BTN_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(GUILayout, POINTER) returns category of POINTER of GUILayout.
			%  CATEGORY = GUI.GETPROPCATEGORY(GUILayout, POINTER) returns category of POINTER of GUILayout.
			%
			% Note that the Element.GETPROPCATEGORY(GUI) and Element.GETPROPCATEGORY('GUILayout')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GUILayout.getPropProp(pointer);
			
			switch prop
				case GUILayout.EL_CLASS
					prop_category = GUILayout.EL_CLASS_CATEGORY;
				case GUILayout.P
					prop_category = GUILayout.P_CATEGORY;
				case GUILayout.TABLE
					prop_category = GUILayout.TABLE_CATEGORY;
				case GUILayout.SAVE_BTN
					prop_category = GUILayout.SAVE_BTN_CATEGORY;
				case GUILayout.CANCEL_BTN
					prop_category = GUILayout.CANCEL_BTN_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(GUILayout, POINTER) returns format of POINTER of GUILayout.
			%  FORMAT = GUI.GETPROPFORMAT(GUILayout, POINTER) returns format of POINTER of GUILayout.
			%
			% Note that the Element.GETPROPFORMAT(GUI) and Element.GETPROPFORMAT('GUILayout')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GUILayout.getPropProp(pointer);
			
			switch prop
				case GUILayout.EL_CLASS
					prop_format = GUILayout.EL_CLASS_FORMAT;
				case GUILayout.P
					prop_format = GUILayout.P_FORMAT;
				case GUILayout.TABLE
					prop_format = GUILayout.TABLE_FORMAT;
				case GUILayout.SAVE_BTN
					prop_format = GUILayout.SAVE_BTN_FORMAT;
				case GUILayout.CANCEL_BTN
					prop_format = GUILayout.CANCEL_BTN_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GUILayout, POINTER) returns description of POINTER of GUILayout.
			%  DESCRIPTION = GUI.GETPROPDESCRIPTION(GUILayout, POINTER) returns description of POINTER of GUILayout.
			%
			% Note that the Element.GETPROPDESCRIPTION(GUI) and Element.GETPROPDESCRIPTION('GUILayout')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GUILayout.getPropProp(pointer);
			
			switch prop
				case GUILayout.EL_CLASS
					prop_description = 'EL_CLASS (data, class) is the element class.';
				case GUILayout.P
					prop_description = 'P (evanescent, handle) is the panel.';
				case GUILayout.TABLE
					prop_description = 'TABLE (evanescent, handle) is the table.';
				case GUILayout.SAVE_BTN
					prop_description = 'SAVE_BTN (evanescent, handle) is the save button.';
				case GUILayout.CANCEL_BTN
					prop_description = 'CANCEL_BTN (evanescent, handle) is the edit button.';
				case GUILayout.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the GUI layout.';
				case GUILayout.NAME
					prop_description = 'NAME (constant, string) is the name of the GUI layout.';
				case GUILayout.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the GUI layout.';
				case GUILayout.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the GUI layout.';
				case GUILayout.ID
					prop_description = 'ID (data, string) is a few-letter code for the GUI layout.';
				case GUILayout.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the GUI layout.';
				case GUILayout.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the GUI layout.';
				case GUILayout.TITLE
					prop_description = 'TITLE (gui, string) is the name of the GUI layout.';
				case GUILayout.DRAW
					prop_description = 'DRAW (query, logical) draws the contents of a GUI before showing it.';
				case GUILayout.CLOSEREQ
					prop_description = 'CLOSEREQ (gui, logical) determines whether to confirm close.';
				case GUILayout.RESIZE
					prop_description = 'RESIZE (query, logical) updates prop POSITION and panel PanelElement when figure size is changed.';
				case GUILayout.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the figure is deleted.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(GUILayout, POINTER) returns settings of POINTER of GUILayout.
			%  SETTINGS = GUI.GETPROPSETTINGS(GUILayout, POINTER) returns settings of POINTER of GUILayout.
			%
			% Note that the Element.GETPROPSETTINGS(GUI) and Element.GETPROPSETTINGS('GUILayout')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GUILayout.getPropProp(pointer);
			
			switch prop
				case GUILayout.EL_CLASS
					prop_settings = Format.getFormatSettings(Format.CLASS);
				case GUILayout.P
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GUILayout.TABLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GUILayout.SAVE_BTN
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GUILayout.CANCEL_BTN
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GUILayout.TEMPLATE
					prop_settings = 'GUILayout';
				otherwise
					prop_settings = getPropSettings@GUI(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GUILayout.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GUILayout.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GUI.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GUI.
			%  DEFAULT = Element.GETPROPDEFAULT(GUILayout, POINTER) returns the default value of POINTER of GUILayout.
			%  DEFAULT = GUI.GETPROPDEFAULT(GUILayout, POINTER) returns the default value of POINTER of GUILayout.
			%
			% Note that the Element.GETPROPDEFAULT(GUI) and Element.GETPROPDEFAULT('GUILayout')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GUILayout.getPropProp(pointer);
			
			switch prop
				case GUILayout.EL_CLASS
					prop_default = Format.getFormatDefault(Format.CLASS, GUILayout.getPropSettings(prop));
				case GUILayout.P
					prop_default = Format.getFormatDefault(Format.HANDLE, GUILayout.getPropSettings(prop));
				case GUILayout.TABLE
					prop_default = Format.getFormatDefault(Format.HANDLE, GUILayout.getPropSettings(prop));
				case GUILayout.SAVE_BTN
					prop_default = Format.getFormatDefault(Format.HANDLE, GUILayout.getPropSettings(prop));
				case GUILayout.CANCEL_BTN
					prop_default = Format.getFormatDefault(Format.HANDLE, GUILayout.getPropSettings(prop));
				case GUILayout.ELCLASS
					prop_default = 'GUILayout';
				case GUILayout.NAME
					prop_default = 'GUI Layout';
				case GUILayout.DESCRIPTION
					prop_default = 'A GUI Layout (GUILayout) renders a layout editor.';
				case GUILayout.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, GUILayout.getPropSettings(prop));
				case GUILayout.ID
					prop_default = 'GUILayout ID';
				case GUILayout.LABEL
					prop_default = 'GUILayout label';
				case GUILayout.NOTES
					prop_default = 'GUILayout notes';
				case GUILayout.TITLE
					prop_default = ['Layout Editor - ' BRAPH2.STR];
				case GUILayout.CLOSEREQ
					prop_default = false;
				otherwise
					prop_default = getPropDefault@GUI(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GUILayout.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GUILayout.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GUI.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GUILayout, POINTER) returns the conditioned default value of POINTER of GUILayout.
			%  DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(GUILayout, POINTER) returns the conditioned default value of POINTER of GUILayout.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GUI) and Element.GETPROPDEFAULTCONDITIONED('GUILayout')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GUILayout.getPropProp(pointer);
			
			prop_default = GUILayout.conditioning(prop, GUILayout.getPropDefault(prop));
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
			
			prop = GUILayout.getPropProp(pointer);
			
			switch prop
				case GUILayout.EL_CLASS % __GUILayout.EL_CLASS__
					value = Element.getClass(value);
					
				otherwise
					if prop <= GUI.getPropNumber()
						value = conditioning@GUI(pointer, value);
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
			%  CHECK = Element.CHECKPROP(GUILayout, PROP, VALUE) checks VALUE format for PROP of GUILayout.
			%  CHECK = GUI.CHECKPROP(GUILayout, PROP, VALUE) checks VALUE format for PROP of GUILayout.
			% 
			% GUI.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GUILayout:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GUI.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GUI.
			%   Error id: €BRAPH2.STR€:GUILayout:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GUILayout, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GUILayout.
			%   Error id: €BRAPH2.STR€:GUILayout:€BRAPH2.WRONG_INPUT€
			%  GUI.CHECKPROP(GUILayout, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GUILayout.
			%   Error id: €BRAPH2.STR€:GUILayout:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(GUI) and Element.CHECKPROP('GUILayout')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GUILayout.getPropProp(pointer);
			
			switch prop
				case GUILayout.EL_CLASS % __GUILayout.EL_CLASS__
					check = Format.checkFormat(Format.CLASS, value, GUILayout.getPropSettings(prop));
				case GUILayout.P % __GUILayout.P__
					check = Format.checkFormat(Format.HANDLE, value, GUILayout.getPropSettings(prop));
				case GUILayout.TABLE % __GUILayout.TABLE__
					check = Format.checkFormat(Format.HANDLE, value, GUILayout.getPropSettings(prop));
				case GUILayout.SAVE_BTN % __GUILayout.SAVE_BTN__
					check = Format.checkFormat(Format.HANDLE, value, GUILayout.getPropSettings(prop));
				case GUILayout.CANCEL_BTN % __GUILayout.CANCEL_BTN__
					check = Format.checkFormat(Format.HANDLE, value, GUILayout.getPropSettings(prop));
				case GUILayout.TEMPLATE % __GUILayout.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, GUILayout.getPropSettings(prop));
				otherwise
					if prop <= GUI.getPropNumber()
						check = checkProp@GUI(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GUILayout:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GUILayout:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GUILayout.getPropTag(prop) ' (' GUILayout.getFormatTag(GUILayout.getPropFormat(prop)) ').'] ...
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
				case GUILayout.EL_CLASS % __GUILayout.EL_CLASS__
					if isa(gui.getr('TITLE'), 'NoValue')
					    gui.set('TITLE', ['Layout Editor - ' gui.get('EL_CLASS') ' - ' BRAPH2.STR])
					end
					gui.lock('EL_CLASS', 'Iterative', false)
					
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
				case GUILayout.P % __GUILayout.P__
					p = uipanel( ...
					    'Parent', gui.memorize('H'), ...
					    'Tag', 'p', ...
					    'Units', 'normalized', ...
					    'Position', [0 0 1 1], ...
					    'BackgroundColor', gui.get('BKGCOLOR'), ...
					    'AutoResizeChildren', 'off' ...
					    );
					value = p;
					
				case GUILayout.TABLE % __GUILayout.TABLE__
					table = uitable( ...
					    'Parent', gui.memorize('P'), ...
					    'Tag', 'table', ...
					    'Units', 'pixels', ...
					    'ColumnName', {'Show', 'Order', 'Title', 'Property', 'Category', 'Format'}, ...
					    'ColumnFormat', {'logical', 'char', 'char', 'char', 'char', 'char'}, ...
					    'ColumnEditable', [true true true false false false], ...
					    'CellEditCallback', {@cb_table} ...
					    );
					
					el_class = gui.get('EL_CLASS');
					[order, title, visible] = load_layout(el_class);
					
					data = cell(Element.getPropNumber(el_class), 6);
					for prop = 1:1:Element.getPropNumber(el_class)
					    data{prop, 1} = visible(prop); % VISIBLE = 1;
					    data{prop, 2} = order(prop); % ORDER = 2;
					    data{prop, 3} = title{prop}; % TITLE = 3;
					    data{prop, 4} = upper(Element.getPropTag(el_class, prop)); % TAG = 4;
					    
					    category = Element.getPropCategory(el_class, prop);
					    data{prop, 5} = [int2str(category) ' ' Category.getCategoryTag(category) ' ' Category.getCategoryName(category)]; % CATEGORY = 5;
					    
					    format = Element.getPropFormat(el_class, prop);
					    data{prop, 6} = [int2str(format) ' ' Format.getFormatTag(format) ' ' Format.getFormatName(format)]; % FORMAT = 6;
					end        
					set(table, 'Data', data);
					
					value = table;
					
				case GUILayout.SAVE_BTN % __GUILayout.SAVE_BTN__
					save_btn = uibutton( ...
					    'Parent', gui.memorize('P'), ...
					    'Tag', 'save_btn', ...
					    'Enable', 'off', ...
					    'Text', 'Save', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'ButtonPushedFcn', {@cb_save_btn}, ...
					    'Interruptible', 'off', ...
					    'BusyAction', 'cancel' ...
					    );
					value = save_btn;
					
				case GUILayout.CANCEL_BTN % __GUILayout.CANCEL_BTN__
					cancel_btn = uibutton( ...
					    'Parent', gui.memorize('P'), ...
					    'Tag', 'save_btn', ...
					    'Text', 'Cancel', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'ButtonPushedFcn', {@cb_cancel_btn}, ...
					    'Interruptible', 'off', ...
					    'BusyAction', 'cancel' ...
					    );
					value = cancel_btn;
					
				case GUILayout.DRAW % __GUILayout.DRAW__
					if check_graphics(gui.memorize('H'), 'figure')
						el_class = gui.memorize('EL_CLASS');
					
					    gui.memorize('P')
					    gui.memorize('TABLE')
					    gui.memorize('SAVE_BTN')
					    gui.memorize('CANCEL_BTN')
					    
					    gui.get('RESIZE')
					    
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
					
				case GUILayout.RESIZE % __GUILayout.RESIZE__
					value = calculateValue@GUI(gui, GUI.RESIZE, varargin{:}); % also warning
					if value    
					    p = gui.get('P');
					    
					    set(gui.get('TABLE'), 'Position', [s(1) s(4) w(p, 'pixels')-s(2) h(p, 'pixels')-s(5)])
					    set(gui.get('SAVE_BTN'), 'Position', [s(1) s(1) s(10) s(2)])
					    set(gui.get('CANCEL_BTN'), 'Position', [s(12) s(1) s(10) s(2)])
					end
					
				case GUILayout.DELETE % __GUILayout.DELETE__
					value = calculateValue@GUI(gui, GUI.DELETE, varargin{:}); % also warning
					if value
					    gui.set('P', Element.getNoValue())
					    gui.set('TABLE', Element.getNoValue())
					    gui.set('SAVE_BTN', Element.getNoValue())
					    gui.set('CANCEL_BTN', Element.getNoValue())
					end
					
				otherwise
					if prop <= GUI.getPropNumber()
						value = calculateValue@GUI(gui, prop, varargin{:});
					else
						value = calculateValue@Element(gui, prop, varargin{:});
					end
			end
			
			function cb_table(~, event)
			    prop = event.Indices(1);
			    col = event.Indices(2);
			    newdata = event.NewData;
			
			    table = gui.get('TABLE');
			    VISIBLE = 1;
			    ORDER = 2;
			    
			    data = get(table, 'Data');
			
			    if col == VISIBLE
			        if newdata == true
			            if any(~isnan(cell2mat(data(:, ORDER))))
			                data{prop, ORDER} = max(cell2mat(data(:, ORDER))) + 1;
			            else % all NaN (edge case)
			                data{prop, ORDER} = 1;
			            end
			        else % newdata == false
			            for i = data{prop, ORDER} + 1:1:max(cell2mat(data(:, ORDER)))
			                data{cell2mat(data(:, ORDER)) == i, ORDER} = i - 1;
			            end
			            data{prop, ORDER} = NaN;
			        end
			    end
			
			    if col == ORDER
			        if isnan(newdata)
			            data{prop, VISIBLE} = false;
			        else
			            data{prop, VISIBLE} = true;
			        end
			
			        order = cell2mat(data(:, ORDER)) + .00301040106;
			        order(prop) = newdata;
			        for i = 1:1:numel(order) - sum(isnan(order))
			            min_order_index = find(order == min(order));
			            data{min_order_index, ORDER} = i;
			            order(min_order_index) = NaN;
			        end
			    end
			
			    set(table, 'Data', data);
			    
			    set(gui.get('SAVE_BTN'), 'Enable', 'on')    
			end
			function cb_save_btn(~, ~)
			    el_class = gui.get('EL_CLASS');
			    table = gui.get('TABLE');
			    data = get(table, 'Data');
			    order = cell2mat(data(:, 2))';
			    title = data(:, 3); title = title';
			    save_layout(el_class, order, title)
			    
			    set(gui.get('SAVE_BTN'), 'Enable', 'off')
			end
			function cb_cancel_btn(~, ~)
			    gui.get('CLOSE')
			end
		end
	end
end
