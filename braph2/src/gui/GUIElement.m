classdef GUIElement < GUI
	%GUIElement is a GUI for an element.
	% It is a subclass of <a href="matlab:help GUI">GUI</a>.
	%
	% An Element GUI (GUIElement) renders an element in a figure.
	% 
	% CONSTRUCTOR - To construct a GUI use, e.g.:
	% 
	%     gui = GUIElement(''PE'', <element>)
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
	% GUIElement methods (constructor):
	%  GUIElement - constructor
	%
	% GUIElement methods:
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
	% GUIElement methods (display):
	%  tostring - string with information about the element GUI
	%  disp - displays information about the element GUI
	%  tree - displays the tree of the element GUI
	%
	% GUIElement methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two element GUI are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the element GUI
	%
	% GUIElement methods (save/load, Static):
	%  save - saves BRAPH2 element GUI as b2 file
	%  load - loads a BRAPH2 element GUI from a b2 file
	%
	% GUIElement method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the element GUI
	%
	% GUIElement method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the element GUI
	%
	% GUIElement methods (inspection, Static):
	%  getClass - returns the class of the element GUI
	%  getSubclasses - returns all subclasses of GUIElement
	%  getProps - returns the property list of the element GUI
	%  getPropNumber - returns the property number of the element GUI
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
	% GUIElement methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GUIElement methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GUIElement methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GUIElement methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GUIElement; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GUIElement constants</a>.
	%
	%
	% See also uifigure, ConcreteElement, PanelElement.
	
	properties (Constant) % properties
		PE = GUI.getPropNumber() + 1;
		PE_TAG = 'PE';
		PE_CATEGORY = Category.DATA;
		PE_FORMAT = Format.ITEM;
		
		FILE = GUI.getPropNumber() + 2;
		FILE_TAG = 'FILE';
		FILE_CATEGORY = Category.METADATA;
		FILE_FORMAT = Format.STRING;
		
		TEXT_FILE = GUI.getPropNumber() + 3;
		TEXT_FILE_TAG = 'TEXT_FILE';
		TEXT_FILE_CATEGORY = Category.EVANESCENT;
		TEXT_FILE_FORMAT = Format.HANDLE;
		
		LAYOUT = GUI.getPropNumber() + 4;
		LAYOUT_TAG = 'LAYOUT';
		LAYOUT_CATEGORY = Category.DATA;
		LAYOUT_FORMAT = Format.ITEM;
		
		H_MENU_FILE = GUI.getPropNumber() + 5;
		H_MENU_FILE_TAG = 'H_MENU_FILE';
		H_MENU_FILE_CATEGORY = Category.EVANESCENT;
		H_MENU_FILE_FORMAT = Format.HANDLE;
		
		MENU_FILE = GUI.getPropNumber() + 6;
		MENU_FILE_TAG = 'MENU_FILE';
		MENU_FILE_CATEGORY = Category.GUI;
		MENU_FILE_FORMAT = Format.LOGICAL;
		
		H_MENU_IMPORT = GUI.getPropNumber() + 7;
		H_MENU_IMPORT_TAG = 'H_MENU_IMPORT';
		H_MENU_IMPORT_CATEGORY = Category.EVANESCENT;
		H_MENU_IMPORT_FORMAT = Format.HANDLE;
		
		MENU_IMPORT = GUI.getPropNumber() + 8;
		MENU_IMPORT_TAG = 'MENU_IMPORT';
		MENU_IMPORT_CATEGORY = Category.GUI;
		MENU_IMPORT_FORMAT = Format.LOGICAL;
		
		H_MENU_EXPORT = GUI.getPropNumber() + 9;
		H_MENU_EXPORT_TAG = 'H_MENU_EXPORT';
		H_MENU_EXPORT_CATEGORY = Category.EVANESCENT;
		H_MENU_EXPORT_FORMAT = Format.HANDLE;
		
		MENU_EXPORT = GUI.getPropNumber() + 10;
		MENU_EXPORT_TAG = 'MENU_EXPORT';
		MENU_EXPORT_CATEGORY = Category.GUI;
		MENU_EXPORT_FORMAT = Format.LOGICAL;
		
		H_MENU_PERSONALIZE = GUI.getPropNumber() + 11;
		H_MENU_PERSONALIZE_TAG = 'H_MENU_PERSONALIZE';
		H_MENU_PERSONALIZE_CATEGORY = Category.EVANESCENT;
		H_MENU_PERSONALIZE_FORMAT = Format.HANDLE;
		
		MENU_PERSONALIZE = GUI.getPropNumber() + 12;
		MENU_PERSONALIZE_TAG = 'MENU_PERSONALIZE';
		MENU_PERSONALIZE_CATEGORY = Category.GUI;
		MENU_PERSONALIZE_FORMAT = Format.LOGICAL;
		
		TOOL_FILE = GUI.getPropNumber() + 13;
		TOOL_FILE_TAG = 'TOOL_FILE';
		TOOL_FILE_CATEGORY = Category.GUI;
		TOOL_FILE_FORMAT = Format.LOGICAL;
	end
	methods % constructor
		function gui = GUIElement(varargin)
			%GUIElement() creates a element GUI.
			%
			% GUIElement(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GUIElement(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the element GUI.
			%
			% CLASS = GUIElement.GETCLASS() returns the class 'GUIElement'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GUI.GETCLASS() returns the class of the element GUI GUI.
			%  CLASS = Element.GETCLASS(GUI) returns the class of 'GUI'.
			%  CLASS = Element.GETCLASS('GUIElement') returns 'GUIElement'.
			%
			% Note that the Element.GETCLASS(GUI) and Element.GETCLASS('GUIElement')
			%  are less computationally efficient.
			
			gui_class = 'GUIElement';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the element GUI.
			%
			% LIST = GUIElement.GETSUBCLASSES() returns all subclasses of 'GUIElement'.
			%
			% Alternative forms to call this method are:
			%  LIST = GUI.GETSUBCLASSES() returns all subclasses of the element GUI GUI.
			%  LIST = Element.GETSUBCLASSES(GUI) returns all subclasses of 'GUI'.
			%  LIST = Element.GETSUBCLASSES('GUIElement') returns all subclasses of 'GUIElement'.
			%
			% Note that the Element.GETSUBCLASSES(GUI) and Element.GETSUBCLASSES('GUIElement')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GUIElement', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of element GUI.
			%
			% PROPS = GUIElement.GETPROPS() returns the property list of element GUI
			%  as a row vector.
			%
			% PROPS = GUIElement.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GUI.GETPROPS([CATEGORY]) returns the property list of the element GUI GUI.
			%  PROPS = Element.GETPROPS(GUI[, CATEGORY]) returns the property list of 'GUI'.
			%  PROPS = Element.GETPROPS('GUIElement'[, CATEGORY]) returns the property list of 'GUIElement'.
			%
			% Note that the Element.GETPROPS(GUI) and Element.GETPROPS('GUIElement')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					GUI.getProps() ...
						GUIElement.PE ...
						GUIElement.FILE ...
						GUIElement.TEXT_FILE ...
						GUIElement.LAYOUT ...
						GUIElement.H_MENU_FILE ...
						GUIElement.MENU_FILE ...
						GUIElement.H_MENU_IMPORT ...
						GUIElement.MENU_IMPORT ...
						GUIElement.H_MENU_EXPORT ...
						GUIElement.MENU_EXPORT ...
						GUIElement.H_MENU_PERSONALIZE ...
						GUIElement.MENU_PERSONALIZE ...
						GUIElement.TOOL_FILE ...
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
						GUIElement.FILE ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						GUI.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						GUI.getProps(Category.DATA) ...
						GUIElement.PE ...
						GUIElement.LAYOUT ...
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
						GUIElement.TEXT_FILE ...
						GUIElement.H_MENU_FILE ...
						GUIElement.H_MENU_IMPORT ...
						GUIElement.H_MENU_EXPORT ...
						GUIElement.H_MENU_PERSONALIZE ...
						];
				case Category.FIGURE
					prop_list = [ ...
						GUI.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						GUI.getProps(Category.GUI) ...
						GUIElement.MENU_FILE ...
						GUIElement.MENU_IMPORT ...
						GUIElement.MENU_EXPORT ...
						GUIElement.MENU_PERSONALIZE ...
						GUIElement.TOOL_FILE ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of element GUI.
			%
			% N = GUIElement.GETPROPNUMBER() returns the property number of element GUI.
			%
			% N = GUIElement.GETPROPNUMBER(CATEGORY) returns the property number of element GUI
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GUI.GETPROPNUMBER([CATEGORY]) returns the property number of the element GUI GUI.
			%  N = Element.GETPROPNUMBER(GUI) returns the property number of 'GUI'.
			%  N = Element.GETPROPNUMBER('GUIElement') returns the property number of 'GUIElement'.
			%
			% Note that the Element.GETPROPNUMBER(GUI) and Element.GETPROPNUMBER('GUIElement')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GUIElement.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in element GUI/error.
			%
			% CHECK = GUIElement.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GUI.EXISTSPROP(PROP) checks whether PROP exists for GUI.
			%  CHECK = Element.EXISTSPROP(GUI, PROP) checks whether PROP exists for GUI.
			%  CHECK = Element.EXISTSPROP(GUIElement, PROP) checks whether PROP exists for GUIElement.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GUIElement:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GUI.EXISTSPROP(PROP) throws error if PROP does NOT exist for GUI.
			%   Error id: [BRAPH2:GUIElement:WrongInput]
			%  Element.EXISTSPROP(GUI, PROP) throws error if PROP does NOT exist for GUI.
			%   Error id: [BRAPH2:GUIElement:WrongInput]
			%  Element.EXISTSPROP(GUIElement, PROP) throws error if PROP does NOT exist for GUIElement.
			%   Error id: [BRAPH2:GUIElement:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GUI) and Element.EXISTSPROP('GUIElement')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GUIElement.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GUIElement:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GUIElement:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GUIElement.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in element GUI/error.
			%
			% CHECK = GUIElement.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GUI.EXISTSTAG(TAG) checks whether TAG exists for GUI.
			%  CHECK = Element.EXISTSTAG(GUI, TAG) checks whether TAG exists for GUI.
			%  CHECK = Element.EXISTSTAG(GUIElement, TAG) checks whether TAG exists for GUIElement.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GUIElement:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GUI.EXISTSTAG(TAG) throws error if TAG does NOT exist for GUI.
			%   Error id: [BRAPH2:GUIElement:WrongInput]
			%  Element.EXISTSTAG(GUI, TAG) throws error if TAG does NOT exist for GUI.
			%   Error id: [BRAPH2:GUIElement:WrongInput]
			%  Element.EXISTSTAG(GUIElement, TAG) throws error if TAG does NOT exist for GUIElement.
			%   Error id: [BRAPH2:GUIElement:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GUI) and Element.EXISTSTAG('GUIElement')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			guielement_tag_list = cellfun(@(x) GUIElement.getPropTag(x), num2cell(GUIElement.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, guielement_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GUIElement:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GUIElement:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GUIElement.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GUIElement, POINTER) returns property number of POINTER of GUIElement.
			%  PROPERTY = GUI.GETPROPPROP(GUIElement, POINTER) returns property number of POINTER of GUIElement.
			%
			% Note that the Element.GETPROPPROP(GUI) and Element.GETPROPPROP('GUIElement')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				guielement_tag_list = cellfun(@(x) GUIElement.getPropTag(x), num2cell(GUIElement.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, guielement_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GUIElement, POINTER) returns tag of POINTER of GUIElement.
			%  TAG = GUI.GETPROPTAG(GUIElement, POINTER) returns tag of POINTER of GUIElement.
			%
			% Note that the Element.GETPROPTAG(GUI) and Element.GETPROPTAG('GUIElement')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GUIElement.PE
						tag = GUIElement.PE_TAG;
					case GUIElement.FILE
						tag = GUIElement.FILE_TAG;
					case GUIElement.TEXT_FILE
						tag = GUIElement.TEXT_FILE_TAG;
					case GUIElement.LAYOUT
						tag = GUIElement.LAYOUT_TAG;
					case GUIElement.H_MENU_FILE
						tag = GUIElement.H_MENU_FILE_TAG;
					case GUIElement.MENU_FILE
						tag = GUIElement.MENU_FILE_TAG;
					case GUIElement.H_MENU_IMPORT
						tag = GUIElement.H_MENU_IMPORT_TAG;
					case GUIElement.MENU_IMPORT
						tag = GUIElement.MENU_IMPORT_TAG;
					case GUIElement.H_MENU_EXPORT
						tag = GUIElement.H_MENU_EXPORT_TAG;
					case GUIElement.MENU_EXPORT
						tag = GUIElement.MENU_EXPORT_TAG;
					case GUIElement.H_MENU_PERSONALIZE
						tag = GUIElement.H_MENU_PERSONALIZE_TAG;
					case GUIElement.MENU_PERSONALIZE
						tag = GUIElement.MENU_PERSONALIZE_TAG;
					case GUIElement.TOOL_FILE
						tag = GUIElement.TOOL_FILE_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(GUIElement, POINTER) returns category of POINTER of GUIElement.
			%  CATEGORY = GUI.GETPROPCATEGORY(GUIElement, POINTER) returns category of POINTER of GUIElement.
			%
			% Note that the Element.GETPROPCATEGORY(GUI) and Element.GETPROPCATEGORY('GUIElement')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GUIElement.getPropProp(pointer);
			
			switch prop
				case GUIElement.PE
					prop_category = GUIElement.PE_CATEGORY;
				case GUIElement.FILE
					prop_category = GUIElement.FILE_CATEGORY;
				case GUIElement.TEXT_FILE
					prop_category = GUIElement.TEXT_FILE_CATEGORY;
				case GUIElement.LAYOUT
					prop_category = GUIElement.LAYOUT_CATEGORY;
				case GUIElement.H_MENU_FILE
					prop_category = GUIElement.H_MENU_FILE_CATEGORY;
				case GUIElement.MENU_FILE
					prop_category = GUIElement.MENU_FILE_CATEGORY;
				case GUIElement.H_MENU_IMPORT
					prop_category = GUIElement.H_MENU_IMPORT_CATEGORY;
				case GUIElement.MENU_IMPORT
					prop_category = GUIElement.MENU_IMPORT_CATEGORY;
				case GUIElement.H_MENU_EXPORT
					prop_category = GUIElement.H_MENU_EXPORT_CATEGORY;
				case GUIElement.MENU_EXPORT
					prop_category = GUIElement.MENU_EXPORT_CATEGORY;
				case GUIElement.H_MENU_PERSONALIZE
					prop_category = GUIElement.H_MENU_PERSONALIZE_CATEGORY;
				case GUIElement.MENU_PERSONALIZE
					prop_category = GUIElement.MENU_PERSONALIZE_CATEGORY;
				case GUIElement.TOOL_FILE
					prop_category = GUIElement.TOOL_FILE_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(GUIElement, POINTER) returns format of POINTER of GUIElement.
			%  FORMAT = GUI.GETPROPFORMAT(GUIElement, POINTER) returns format of POINTER of GUIElement.
			%
			% Note that the Element.GETPROPFORMAT(GUI) and Element.GETPROPFORMAT('GUIElement')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GUIElement.getPropProp(pointer);
			
			switch prop
				case GUIElement.PE
					prop_format = GUIElement.PE_FORMAT;
				case GUIElement.FILE
					prop_format = GUIElement.FILE_FORMAT;
				case GUIElement.TEXT_FILE
					prop_format = GUIElement.TEXT_FILE_FORMAT;
				case GUIElement.LAYOUT
					prop_format = GUIElement.LAYOUT_FORMAT;
				case GUIElement.H_MENU_FILE
					prop_format = GUIElement.H_MENU_FILE_FORMAT;
				case GUIElement.MENU_FILE
					prop_format = GUIElement.MENU_FILE_FORMAT;
				case GUIElement.H_MENU_IMPORT
					prop_format = GUIElement.H_MENU_IMPORT_FORMAT;
				case GUIElement.MENU_IMPORT
					prop_format = GUIElement.MENU_IMPORT_FORMAT;
				case GUIElement.H_MENU_EXPORT
					prop_format = GUIElement.H_MENU_EXPORT_FORMAT;
				case GUIElement.MENU_EXPORT
					prop_format = GUIElement.MENU_EXPORT_FORMAT;
				case GUIElement.H_MENU_PERSONALIZE
					prop_format = GUIElement.H_MENU_PERSONALIZE_FORMAT;
				case GUIElement.MENU_PERSONALIZE
					prop_format = GUIElement.MENU_PERSONALIZE_FORMAT;
				case GUIElement.TOOL_FILE
					prop_format = GUIElement.TOOL_FILE_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GUIElement, POINTER) returns description of POINTER of GUIElement.
			%  DESCRIPTION = GUI.GETPROPDESCRIPTION(GUIElement, POINTER) returns description of POINTER of GUIElement.
			%
			% Note that the Element.GETPROPDESCRIPTION(GUI) and Element.GETPROPDESCRIPTION('GUIElement')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GUIElement.getPropProp(pointer);
			
			switch prop
				case GUIElement.PE
					prop_description = 'PE (data, item) is the panel element.';
				case GUIElement.FILE
					prop_description = 'FILE (metadata, string) is the B2 file where the element is saved.';
				case GUIElement.TEXT_FILE
					prop_description = 'TEXT_FILE (evanescent, handle) is the label where the file name is shown.';
				case GUIElement.LAYOUT
					prop_description = 'LAYOUT (data, item) is the handle to the figure to manage layout.';
				case GUIElement.H_MENU_FILE
					prop_description = 'H_MENU_FILE (evanescent, handle) is the handle of the menu file.';
				case GUIElement.MENU_FILE
					prop_description = 'MENU_FILE (gui, logical) determines whether to show the menu file.';
				case GUIElement.H_MENU_IMPORT
					prop_description = 'H_MENU_IMPORT (evanescent, handle) is the handle of the menu import.';
				case GUIElement.MENU_IMPORT
					prop_description = 'MENU_IMPORT (gui, logical) determines whether to show the menu import.';
				case GUIElement.H_MENU_EXPORT
					prop_description = 'H_MENU_EXPORT (evanescent, handle) is the handle of the menu export.';
				case GUIElement.MENU_EXPORT
					prop_description = 'MENU_EXPORT (gui, logical) determines whether to show the menu export.';
				case GUIElement.H_MENU_PERSONALIZE
					prop_description = 'H_MENU_PERSONALIZE (evanescent, handle) is the handle of the menu personalize.';
				case GUIElement.MENU_PERSONALIZE
					prop_description = 'MENU_PERSONALIZE (gui, logical) determines whether to show the menu personalize.';
				case GUIElement.TOOL_FILE
					prop_description = 'TOOL_FILE (gui, logical) determines whether to show the toolbar file buttons.';
				case GUIElement.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the element GUI.';
				case GUIElement.NAME
					prop_description = 'NAME (constant, string) is the name of the element GUI.';
				case GUIElement.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the element GUI.';
				case GUIElement.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the element GUI.';
				case GUIElement.ID
					prop_description = 'ID (data, string) is a few-letter code for the element GUI.';
				case GUIElement.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the element GUI.';
				case GUIElement.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the element GUI.';
				case GUIElement.H_MENUBAR
					prop_description = 'H_MENUBAR (evanescent, handlelist) is the list of handles for the menus.';
				case GUIElement.MENUBAR
					prop_description = 'MENUBAR (gui, logical) determines whether to show the menubar.';
				case GUIElement.MENU_ABOUT
					prop_description = 'MENU_ABOUT (gui, logical) determines whether to show the menu about.';
				case GUIElement.H_TOOLS
					prop_description = 'H_TOOLS (evanescent, handlelist) is the handle list of the toolbar followed by the tools from the first.';
				case GUIElement.TOOLBAR
					prop_description = 'TOOLBAR (gui, logical) determines whether to show the toolbar.';
				case GUIElement.TOOL_ABOUT
					prop_description = 'TOOL_ABOUT (gui, logical) determines whether to show the toolbar about buttons.';
				case GUIElement.DRAW
					prop_description = 'DRAW (query, logical) draws the contents of a GUI before showing it.';
				case GUIElement.RESIZE
					prop_description = 'RESIZE (query, logical) updates prop POSITION and panel PanelElement when figure size is changed.';
				case GUIElement.H
					prop_description = 'H (evanescent, handle) is the figure handle.';
				case GUIElement.SHOW
					prop_description = 'SHOW (query, logical) shows the figure and its dependent figures.';
				case GUIElement.HIDE
					prop_description = 'HIDE (query, logical) hides the figure and its dependent figures.';
				case GUIElement.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the figure is deleted.';
				case GUIElement.CLOSE
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
			%  SETTINGS = Element.GETPROPSETTINGS(GUIElement, POINTER) returns settings of POINTER of GUIElement.
			%  SETTINGS = GUI.GETPROPSETTINGS(GUIElement, POINTER) returns settings of POINTER of GUIElement.
			%
			% Note that the Element.GETPROPSETTINGS(GUI) and Element.GETPROPSETTINGS('GUIElement')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GUIElement.getPropProp(pointer);
			
			switch prop
				case GUIElement.PE
					prop_settings = 'PanelElement';
				case GUIElement.FILE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case GUIElement.TEXT_FILE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GUIElement.LAYOUT
					prop_settings = 'GUILayout';
				case GUIElement.H_MENU_FILE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GUIElement.MENU_FILE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUIElement.H_MENU_IMPORT
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GUIElement.MENU_IMPORT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUIElement.H_MENU_EXPORT
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GUIElement.MENU_EXPORT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUIElement.H_MENU_PERSONALIZE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GUIElement.MENU_PERSONALIZE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUIElement.TOOL_FILE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GUIElement.TEMPLATE
					prop_settings = 'GUIElement';
				otherwise
					prop_settings = getPropSettings@GUI(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GUIElement.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GUIElement.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GUI.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GUI.
			%  DEFAULT = Element.GETPROPDEFAULT(GUIElement, POINTER) returns the default value of POINTER of GUIElement.
			%  DEFAULT = GUI.GETPROPDEFAULT(GUIElement, POINTER) returns the default value of POINTER of GUIElement.
			%
			% Note that the Element.GETPROPDEFAULT(GUI) and Element.GETPROPDEFAULT('GUIElement')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GUIElement.getPropProp(pointer);
			
			switch prop
				case GUIElement.PE
					prop_default = Format.getFormatDefault(Format.ITEM, GUIElement.getPropSettings(prop));
				case GUIElement.FILE
					prop_default = Format.getFormatDefault(Format.STRING, GUIElement.getPropSettings(prop));
				case GUIElement.TEXT_FILE
					prop_default = Format.getFormatDefault(Format.HANDLE, GUIElement.getPropSettings(prop));
				case GUIElement.LAYOUT
					prop_default = Format.getFormatDefault(Format.ITEM, GUIElement.getPropSettings(prop));
				case GUIElement.H_MENU_FILE
					prop_default = Format.getFormatDefault(Format.HANDLE, GUIElement.getPropSettings(prop));
				case GUIElement.MENU_FILE
					prop_default = true;
				case GUIElement.H_MENU_IMPORT
					prop_default = Format.getFormatDefault(Format.HANDLE, GUIElement.getPropSettings(prop));
				case GUIElement.MENU_IMPORT
					prop_default = true;
				case GUIElement.H_MENU_EXPORT
					prop_default = Format.getFormatDefault(Format.HANDLE, GUIElement.getPropSettings(prop));
				case GUIElement.MENU_EXPORT
					prop_default = true;
				case GUIElement.H_MENU_PERSONALIZE
					prop_default = Format.getFormatDefault(Format.HANDLE, GUIElement.getPropSettings(prop));
				case GUIElement.MENU_PERSONALIZE
					prop_default = true;
				case GUIElement.TOOL_FILE
					prop_default = true;
				case GUIElement.ELCLASS
					prop_default = 'GUIElement';
				case GUIElement.NAME
					prop_default = 'Element GUI';
				case GUIElement.DESCRIPTION
					prop_default = 'An Element GUI (GUIElement) renders an element in a figure.';
				case GUIElement.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, GUIElement.getPropSettings(prop));
				case GUIElement.ID
					prop_default = 'GUIElement ID';
				case GUIElement.LABEL
					prop_default = 'GUIElement label';
				case GUIElement.NOTES
					prop_default = 'GUIElement notes';
				case GUIElement.MENUBAR
					prop_default = true;
				case GUIElement.MENU_ABOUT
					prop_default = true;
				case GUIElement.TOOLBAR
					prop_default = true;
				case GUIElement.TOOL_ABOUT
					prop_default = true;
				otherwise
					prop_default = getPropDefault@GUI(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GUIElement.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GUIElement.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GUI.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GUIElement, POINTER) returns the conditioned default value of POINTER of GUIElement.
			%  DEFAULT = GUI.GETPROPDEFAULTCONDITIONED(GUIElement, POINTER) returns the conditioned default value of POINTER of GUIElement.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GUI) and Element.GETPROPDEFAULTCONDITIONED('GUIElement')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GUIElement.getPropProp(pointer);
			
			prop_default = GUIElement.conditioning(prop, GUIElement.getPropDefault(prop));
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
			
			prop = GUIElement.getPropProp(pointer);
			
			switch prop
				case GUIElement.PE % __GUIElement.PE__
					if ~isa(value, 'PanelElement')
					    value = PanelElement( ...
					        'EL', value, ...
					        'ID', ['Panel of ' value.get('TOSTRING')] ...
					        );
					end
					
				otherwise
					if prop <= GUI.getPropNumber()
						value = conditioning@GUI(pointer, value);
					end
			end
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
				case GUIElement.LAYOUT % __GUIElement.LAYOUT__
					if isa(value.getr('EL_CLASS'), 'NoValue')
					    f = gui.get('H');
					    value.set( ...
					        'EL_CLASS', gui.get('PE').get('EL'), ...
					        'POSITION', [x0(f)+w(f) y0(f)+h(f)*2/3 w(f) h(f)/3], ...
					        'CLOSEREQ', false ...
					        )
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
			%  CHECK = Element.CHECKPROP(GUIElement, PROP, VALUE) checks VALUE format for PROP of GUIElement.
			%  CHECK = GUI.CHECKPROP(GUIElement, PROP, VALUE) checks VALUE format for PROP of GUIElement.
			% 
			% GUI.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GUIElement:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GUI.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GUI.
			%   Error id: €BRAPH2.STR€:GUIElement:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GUIElement, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GUIElement.
			%   Error id: €BRAPH2.STR€:GUIElement:€BRAPH2.WRONG_INPUT€
			%  GUI.CHECKPROP(GUIElement, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GUIElement.
			%   Error id: €BRAPH2.STR€:GUIElement:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(GUI) and Element.CHECKPROP('GUIElement')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GUIElement.getPropProp(pointer);
			
			switch prop
				case GUIElement.PE % __GUIElement.PE__
					check = Format.checkFormat(Format.ITEM, value, GUIElement.getPropSettings(prop));
				case GUIElement.FILE % __GUIElement.FILE__
					check = Format.checkFormat(Format.STRING, value, GUIElement.getPropSettings(prop));
				case GUIElement.TEXT_FILE % __GUIElement.TEXT_FILE__
					check = Format.checkFormat(Format.HANDLE, value, GUIElement.getPropSettings(prop));
				case GUIElement.LAYOUT % __GUIElement.LAYOUT__
					check = Format.checkFormat(Format.ITEM, value, GUIElement.getPropSettings(prop));
				case GUIElement.H_MENU_FILE % __GUIElement.H_MENU_FILE__
					check = Format.checkFormat(Format.HANDLE, value, GUIElement.getPropSettings(prop));
				case GUIElement.MENU_FILE % __GUIElement.MENU_FILE__
					check = Format.checkFormat(Format.LOGICAL, value, GUIElement.getPropSettings(prop));
				case GUIElement.H_MENU_IMPORT % __GUIElement.H_MENU_IMPORT__
					check = Format.checkFormat(Format.HANDLE, value, GUIElement.getPropSettings(prop));
				case GUIElement.MENU_IMPORT % __GUIElement.MENU_IMPORT__
					check = Format.checkFormat(Format.LOGICAL, value, GUIElement.getPropSettings(prop));
				case GUIElement.H_MENU_EXPORT % __GUIElement.H_MENU_EXPORT__
					check = Format.checkFormat(Format.HANDLE, value, GUIElement.getPropSettings(prop));
				case GUIElement.MENU_EXPORT % __GUIElement.MENU_EXPORT__
					check = Format.checkFormat(Format.LOGICAL, value, GUIElement.getPropSettings(prop));
				case GUIElement.H_MENU_PERSONALIZE % __GUIElement.H_MENU_PERSONALIZE__
					check = Format.checkFormat(Format.HANDLE, value, GUIElement.getPropSettings(prop));
				case GUIElement.MENU_PERSONALIZE % __GUIElement.MENU_PERSONALIZE__
					check = Format.checkFormat(Format.LOGICAL, value, GUIElement.getPropSettings(prop));
				case GUIElement.TOOL_FILE % __GUIElement.TOOL_FILE__
					check = Format.checkFormat(Format.LOGICAL, value, GUIElement.getPropSettings(prop));
				case GUIElement.TEMPLATE % __GUIElement.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, GUIElement.getPropSettings(prop));
				otherwise
					if prop <= GUI.getPropNumber()
						check = checkProp@GUI(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GUIElement:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GUIElement:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GUIElement.getPropTag(prop) ' (' GUIElement.getFormatTag(GUIElement.getPropFormat(prop)) ').'] ...
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
				case GUIElement.PE % __GUIElement.PE__
					pe = gui.get('PE');
					pe.set('PARENT', gui)
					if isa(gui.getr('TITLE'), 'NoValue')
					    el = pe.get('EL');
					    gui.set('TITLE', [el.getClass() ' - ' el.get('ID') ' - ' BRAPH2.STR])
					end
					gui.lock('PE', 'Iterative', false)
					
					if isa(pe.getr('WAITBAR'), 'NoValue')
						pe.set('WAITBAR', gui.getCallback('WAITBAR'))
					end
					
				case GUIElement.FILE % __GUIElement.FILE__
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
				case GUIElement.TEXT_FILE % __GUIElement.TEXT_FILE__
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
					
				case GUIElement.H_MENU_FILE % __GUIElement.H_MENU_FILE__
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
					
				case GUIElement.H_MENU_IMPORT % __GUIElement.H_MENU_IMPORT__
					menu_import = uimenu(gui.memorize('H'), ... % f for figure
					    'Tag', 'MENU.Import', ...
					    'Label', 'Import', ...
					    'Callback', {@cb_refresh_import_menu});
					value = menu_import;
					
				case GUIElement.H_MENU_EXPORT % __GUIElement.H_MENU_EXPORT__
					menu_export = uimenu(gui.memorize('H'), ... % f for figure
					    'Tag', 'MENU.Export', ...
						'Label', 'Export', ...
						'Callback', {@cb_refresh_export_menu});
					value = menu_export;
					
				case GUIElement.H_MENU_PERSONALIZE % __GUIElement.H_MENU_PERSONALIZE__
					menu_file = uimenu(gui.memorize('H'), ... % f for figure
					    'Tag', 'MENU.Personalize', ...
					    'Label', 'Personalize' ...
					    );
					
					uimenu(menu_file, ...
					    'Tag', 'MENU.Personalize.Layout', ...
					    'Label', 'Layout ...', ...
					    'Callback', {@cb_layout})
					
					value = menu_file;
					
				case GUIElement.H_MENUBAR % __GUIElement.H_MENUBAR__
					value = {};
					if gui.get('MENU_FILE')
					    value = [value, gui.memorize('H_MENU_FILE')];
					end
					if gui.get('MENU_IMPORT')
					    value = [value, gui.memorize('H_MENU_IMPORT')];
					end
					if gui.get('MENU_EXPORT')
					    value = [value, gui.memorize('H_MENU_EXPORT')];
					end
					if gui.get('MENU_PERSONALIZE')
					    value = [value, gui.memorize('H_MENU_PERSONALIZE')];
					end
					if gui.get('MENU_ABOUT')
					    value = [value, gui.memorize('H_MENU_ABOUT')];
					end
					
				case GUIElement.H_TOOLS % __GUIElement.H_TOOLS__
					toolbar = gui.memorize('H_TOOLBAR');
					
					children = calculateValue@GUI(gui, GUI.H_TOOLS);
					
					value = {};
					if gui.get('TOOL_FILE')
					    
					    el = gui.get('PE').get('EL');
					    
					    % OPEN
					    tool_file_open = uipushtool(toolbar, ...
					        'Tag', 'TOOL.Open', ...                
					        'Tooltip', ['Open ' el.get('NAME')], ...
					        'CData', imread('icon_open_ml.png'), ...
					        'ClickedCallback', {@cb_open});
					
					    % Save
					    tool_file_save = uipushtool(toolbar, ...
					        'Tag', 'TOOL.Save', ...                
					        'Tooltip', ['Save ' el.get('NAME')], ...
					        'CData', imread('icon_save_ml.png'), ...
					        'ClickedCallback', {@cb_save});
					    
					    value = {value{:}, tool_file_open, tool_file_save};
					end
					
					value = {value{:}, children{:}};
					
					% reorder tools
					toolbar.Children = [value{end:-1:1}];
					
				case GUIElement.DRAW % __GUIElement.DRAW__
					if check_graphics(gui.memorize('H'), 'figure')
					
					    if gui.get('MENUBAR')
					        gui.memorize('H_MENUBAR')
					    end
					    
					    if gui.get('TOOLBAR')
					        % gui.memorize('H_TOOLBAR') % performed automatically by gui.memorize('H_TOOLS')
					        gui.memorize('H_TOOLS')
					    end
					    
					    pe = gui.memorize('PE');
					    pe.get('DRAW')
					    pe.get('RESIZEY')
					    
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
					
				case GUIElement.RESIZE % __GUIElement.RESIZE__
					value = calculateValue@GUI(gui, GUI.RESIZE, varargin{:}); % also warning
					if value
					    gui.get('PE').get('RESIZEX')
					
					    set(gui.get('TEXT_FILE'), 'Position', [5 0 w(gui.get('H'), 'pixels')-10 s(2)])
					end
					
				case GUIElement.H % __GUIElement.H__
					f = calculateValue@GUI(gui, GUI.H);
					el = gui.memorize('PE').memorize('EL');
					value = f;
					
				case GUIElement.SHOW % __GUIElement.SHOW__
					if gui.get('DRAWN')
					
					    % panel element
					    gui.get('PE').get('SHOW', 'ShowParentFigure', false)
					
					    % figure layout editor
					    if isa(gui.getr('LAYOUT'), 'GUILayout') && gui.get('LAYOUT').get('DRAWN')
					        gui.get('LAYOUT').get('SHOW')
					    end
					    
					    value = calculateValue@GUI(gui, GUI.SHOW, varargin{:});
					else
					    warning( ...
					        [BRAPH2.STR ':' class(gui)], ...
					        [BRAPH2.STR ':' class(gui) '\n' ...
					        'The call gui.get(''SHOW'') has NOT been executed.\n' ...
					        'First, the figure ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case GUIElement.HIDE % __GUIElement.HIDE__
					if gui.get('DRAWN')
					    
					    % panel element
					    gui.get('PE').get('HIDE', 'HideParentFigure', false)
					    
					    % figure layout editor
					    if isa(gui.getr('LAYOUT'), 'GUILayout') && gui.get('LAYOUT').get('DRAWN')
					        gui.get('LAYOUT').get('HIDE')
					    end
					    
					    value = calculateValue@GUI(gui, GUI.HIDE, varargin{:});
					else
					    warning( ...
					        [BRAPH2.STR ':' class(gui)], ...
					        [BRAPH2.STR ':' class(gui) '\n' ...
					        'The call gui.get(''HIDE'') has NOT been executed.\n' ...
					        'First, the figure ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case GUIElement.DELETE % __GUIElement.DELETE__
					if gui.get('DRAWN')
					    
					    gui.set('TEXT_FILE', Element.getNoValue())
					
					    gui.set('H_MENU_FILE', Element.getNoValue())
					    gui.set('H_MENU_IMPORT', Element.getNoValue())
					    gui.set('H_MENU_EXPORT', Element.getNoValue())
					    gui.set('H_MENU_PERSONALIZE', Element.getNoValue())
					    
					    value = calculateValue@GUI(gui, GUI.DELETE, varargin{:});
					else
					    warning( ...
					        [BRAPH2.STR ':' class(gui)], ...
					        [BRAPH2.STR ':' class(gui) '\n' ...
					        'The call gui.get(''DELETE'') has NOT been executed.\n' ...
					        'First, the panel ' gui.get('ID') ' should be drawn calling gui.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case GUIElement.CLOSE % __GUIElement.CLOSE__
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
					        % panel element
					        gui.get('PE').get('CLOSE', 'CloseParentFigure', false)
					
					        % figure layout editor
					        if isa(gui.getr('LAYOUT'), 'GUILayout') && gui.get('LAYOUT').get('DRAWN')
					            gui.get('LAYOUT').get('CLOSE')
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
			    el = gui.get('PE').get('EL');
			    % select file
			    [file, path, filterindex] = uigetfile(BRAPH2.EXT_ELEMENT, ['Select the ' el.get('NAME') ' file.']);
			    if filterindex
			        filename = fullfile(path, file);
			        tmp_el = Element.load(filename, gui.get('WAITBAR'));
			        %TODO: add checks for BRAPH2 version
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
			        el = gui.get('PE').get('EL');
			        Element.save(el, filename, gui.get('WAITBAR'))
			    else
			        cb_saveas();
			    end
			end
			function cb_saveas(~, ~)
			    el = gui.get('PE').get('EL');
			    % select file
			    [file, path, filterindex] = uiputfile(BRAPH2.EXT_ELEMENT, ['Select the ' el.get('NAME') ' file.']);
			    % save file
			    if filterindex
			        filename = fullfile(path, file);
			        Element.save(el, filename, gui.get('WAITBAR'))
			        gui.set('FILE', filename)
			    end
			end
			function cb_refresh_import_menu(~, ~)
			    menu_import = gui.get('H_MENU_IMPORT');
			    
			    im_menus = get(menu_import, 'Children');
			    for i = 1:1:length(im_menus)
			        delete(im_menus(i));
			    end
			    
			    pe = gui.get('PE');
			    el = pe.get('EL');
			    eval([el.getClass() '.getGUIMenuImport(el, menu_import, pe)']);
			end
			function cb_refresh_export_menu(~, ~)
			    menu_export = gui.get('H_MENU_EXPORT');
			    
			    ex_menus = get(menu_export, 'Children');
			    for i = 1:1:length(ex_menus)
			        delete(ex_menus(i));
			    end
			    
			    pe = gui.get('PE');
			    el = pe.get('EL');
			    eval([el.getClass() '.getGUIMenuExport(el, menu_export, pe)']);
			end
			function cb_layout(~, ~)
			    gui_layout = gui.memorize('LAYOUT');
			
			    gui_layout.get('DRAW')
			    gui_layout.get('SHOW')
			end
		end
	end
end
