classdef Panel < ConcreteElement
	%Panel is a panel.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Panel is the basic element to manage graphical representations of elements.
	%  It is an empty graphical panel. It is filled with the graphical content 
	%  representing an element (PanelElement) or figure (PanelFig) or property 
	%  (typically, PanelProp and derived classes). It must be placed within 
	%  another container; for example, a figure (e.g., PanelElement into 
	%  GUIElement, or PanelFig into GUIFig) or another panel (e.g., PanelProp 
	%  into PanelElement).
	% 
	% CONSTRUCTOR - To construct a Panel use, e.g.:
	% 
	%     pn = Panel('<strong>PARENT</strong>', <parent element>);
	% 
	%  where the <parent element> can be a GUI or a Panel.
	% 
	% DRAW - To draw the panel, call:
	%     
	%     pn.get('<strong>DRAW</strong>'[, 'Name', <value>, ...])
	%     p = pn.get('<strong>H</strong>'); % p is the handle of the generated panel
	%  
	%  The query pn.get('<strong>DRAWN</strong>') returns whether the Panel has 
	%   been drawn and therefore can be shown.
	% 
	% CALLBACKS - These are the public callback (to be further implemented by the derived panels):
	% 
	%     pn.get('<strong>SHOW</strong>') - shows the figure containing the panel.
	%     pn.get('<strong>HIDE</strong>') - hides the figure containing the panel.
	%     pn.get('<strong>DELETE</strong>') - resets the handles when the panel is deleted.
	%     pn.get('<strong>CLOSE</strong>') - closes the figure containing the panel.
	%
	% Panel methods (constructor):
	%  Panel - constructor
	%
	% Panel methods:
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
	% Panel methods (display):
	%  tostring - string with information about the panel
	%  disp - displays information about the panel
	%  tree - displays the tree of the panel
	%
	% Panel methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel
	%
	% Panel methods (save/load, Static):
	%  save - saves BRAPH2 panel as b2 file
	%  load - loads a BRAPH2 panel from a b2 file
	%
	% Panel method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel
	%
	% Panel method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel
	%
	% Panel methods (inspection, Static):
	%  getClass - returns the class of the panel
	%  getSubclasses - returns all subclasses of Panel
	%  getProps - returns the property list of the panel
	%  getPropNumber - returns the property number of the panel
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
	% Panel methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Panel methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Panel methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Panel methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Panel; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Panel constants</a>.
	%
	%
	% See also uipanel, PanelElement, PanelProp, PanelFig, GUI, GUIElement, GUIFig.
	
	properties (Constant) % properties
		WAITBAR = ConcreteElement.getPropNumber() + 1;
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = Category.GUI;
		WAITBAR_FORMAT = Format.LOGICAL;
		
		H_WAITBAR = ConcreteElement.getPropNumber() + 2;
		H_WAITBAR_TAG = 'H_WAITBAR';
		H_WAITBAR_CATEGORY = Category.EVANESCENT;
		H_WAITBAR_FORMAT = Format.HANDLE;
		
		DRAW = ConcreteElement.getPropNumber() + 3;
		DRAW_TAG = 'DRAW';
		DRAW_CATEGORY = Category.QUERY;
		DRAW_FORMAT = Format.LOGICAL;
		
		DRAWN = ConcreteElement.getPropNumber() + 4;
		DRAWN_TAG = 'DRAWN';
		DRAWN_CATEGORY = Category.QUERY;
		DRAWN_FORMAT = Format.LOGICAL;
		
		PARENT = ConcreteElement.getPropNumber() + 5;
		PARENT_TAG = 'PARENT';
		PARENT_CATEGORY = Category.GUI;
		PARENT_FORMAT = Format.ITEM;
		
		BKGCOLOR = ConcreteElement.getPropNumber() + 6;
		BKGCOLOR_TAG = 'BKGCOLOR';
		BKGCOLOR_CATEGORY = Category.FIGURE;
		BKGCOLOR_FORMAT = Format.COLOR;
		
		H = ConcreteElement.getPropNumber() + 7;
		H_TAG = 'H';
		H_CATEGORY = Category.EVANESCENT;
		H_FORMAT = Format.HANDLE;
		
		SHOW = ConcreteElement.getPropNumber() + 8;
		SHOW_TAG = 'SHOW';
		SHOW_CATEGORY = Category.QUERY;
		SHOW_FORMAT = Format.LOGICAL;
		
		HIDE = ConcreteElement.getPropNumber() + 9;
		HIDE_TAG = 'HIDE';
		HIDE_CATEGORY = Category.QUERY;
		HIDE_FORMAT = Format.LOGICAL;
		
		DELETE = ConcreteElement.getPropNumber() + 10;
		DELETE_TAG = 'DELETE';
		DELETE_CATEGORY = Category.QUERY;
		DELETE_FORMAT = Format.LOGICAL;
		
		CLOSE = ConcreteElement.getPropNumber() + 11;
		CLOSE_TAG = 'CLOSE';
		CLOSE_CATEGORY = Category.QUERY;
		CLOSE_FORMAT = Format.LOGICAL;
	end
	methods % constructor
		function pn = Panel(varargin)
			%Panel() creates a panel.
			%
			% Panel(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Panel(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pn = pn@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function pn_class = getClass()
			%GETCLASS returns the class of the panel.
			%
			% CLASS = Panel.GETCLASS() returns the class 'Panel'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PN.GETCLASS() returns the class of the panel PN.
			%  CLASS = Element.GETCLASS(PN) returns the class of 'PN'.
			%  CLASS = Element.GETCLASS('Panel') returns 'Panel'.
			%
			% Note that the Element.GETCLASS(PN) and Element.GETCLASS('Panel')
			%  are less computationally efficient.
			
			pn_class = 'Panel';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel.
			%
			% LIST = Panel.GETSUBCLASSES() returns all subclasses of 'Panel'.
			%
			% Alternative forms to call this method are:
			%  LIST = PN.GETSUBCLASSES() returns all subclasses of the panel PN.
			%  LIST = Element.GETSUBCLASSES(PN) returns all subclasses of 'PN'.
			%  LIST = Element.GETSUBCLASSES('Panel') returns all subclasses of 'Panel'.
			%
			% Note that the Element.GETSUBCLASSES(PN) and Element.GETSUBCLASSES('Panel')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('Panel', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel.
			%
			% PROPS = Panel.GETPROPS() returns the property list of panel
			%  as a row vector.
			%
			% PROPS = Panel.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PN.GETPROPS([CATEGORY]) returns the property list of the panel PN.
			%  PROPS = Element.GETPROPS(PN[, CATEGORY]) returns the property list of 'PN'.
			%  PROPS = Element.GETPROPS('Panel'[, CATEGORY]) returns the property list of 'Panel'.
			%
			% Note that the Element.GETPROPS(PN) and Element.GETPROPS('Panel')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						Panel.WAITBAR ...
						Panel.H_WAITBAR ...
						Panel.DRAW ...
						Panel.DRAWN ...
						Panel.PARENT ...
						Panel.BKGCOLOR ...
						Panel.H ...
						Panel.SHOW ...
						Panel.HIDE ...
						Panel.DELETE ...
						Panel.CLOSE ...
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
						Panel.DRAW ...
						Panel.DRAWN ...
						Panel.SHOW ...
						Panel.HIDE ...
						Panel.DELETE ...
						Panel.CLOSE ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						Panel.H_WAITBAR ...
						Panel.H ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						Panel.BKGCOLOR ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						Panel.WAITBAR ...
						Panel.PARENT ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel.
			%
			% N = Panel.GETPROPNUMBER() returns the property number of panel.
			%
			% N = Panel.GETPROPNUMBER(CATEGORY) returns the property number of panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PN.GETPROPNUMBER([CATEGORY]) returns the property number of the panel PN.
			%  N = Element.GETPROPNUMBER(PN) returns the property number of 'PN'.
			%  N = Element.GETPROPNUMBER('Panel') returns the property number of 'Panel'.
			%
			% Note that the Element.GETPROPNUMBER(PN) and Element.GETPROPNUMBER('Panel')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(Panel.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel/error.
			%
			% CHECK = Panel.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PN.EXISTSPROP(PROP) checks whether PROP exists for PN.
			%  CHECK = Element.EXISTSPROP(PN, PROP) checks whether PROP exists for PN.
			%  CHECK = Element.EXISTSPROP(Panel, PROP) checks whether PROP exists for Panel.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Panel:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PN.EXISTSPROP(PROP) throws error if PROP does NOT exist for PN.
			%   Error id: [BRAPH2:Panel:WrongInput]
			%  Element.EXISTSPROP(PN, PROP) throws error if PROP does NOT exist for PN.
			%   Error id: [BRAPH2:Panel:WrongInput]
			%  Element.EXISTSPROP(Panel, PROP) throws error if PROP does NOT exist for Panel.
			%   Error id: [BRAPH2:Panel:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PN) and Element.EXISTSPROP('Panel')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == Panel.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Panel:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Panel:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Panel.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel/error.
			%
			% CHECK = Panel.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PN.EXISTSTAG(TAG) checks whether TAG exists for PN.
			%  CHECK = Element.EXISTSTAG(PN, TAG) checks whether TAG exists for PN.
			%  CHECK = Element.EXISTSTAG(Panel, TAG) checks whether TAG exists for Panel.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Panel:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PN.EXISTSTAG(TAG) throws error if TAG does NOT exist for PN.
			%   Error id: [BRAPH2:Panel:WrongInput]
			%  Element.EXISTSTAG(PN, TAG) throws error if TAG does NOT exist for PN.
			%   Error id: [BRAPH2:Panel:WrongInput]
			%  Element.EXISTSTAG(Panel, TAG) throws error if TAG does NOT exist for Panel.
			%   Error id: [BRAPH2:Panel:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PN) and Element.EXISTSTAG('Panel')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panel_tag_list = cellfun(@(x) Panel.getPropTag(x), num2cell(Panel.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panel_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Panel:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Panel:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for Panel.'] ...
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
			%  PROPERTY = PN.GETPROPPROP(POINTER) returns property number of POINTER of PN.
			%  PROPERTY = Element.GETPROPPROP(Panel, POINTER) returns property number of POINTER of Panel.
			%  PROPERTY = PN.GETPROPPROP(Panel, POINTER) returns property number of POINTER of Panel.
			%
			% Note that the Element.GETPROPPROP(PN) and Element.GETPROPPROP('Panel')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panel_tag_list = cellfun(@(x) Panel.getPropTag(x), num2cell(Panel.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panel_tag_list)); % tag = pointer
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
			%  TAG = PN.GETPROPTAG(POINTER) returns tag of POINTER of PN.
			%  TAG = Element.GETPROPTAG(Panel, POINTER) returns tag of POINTER of Panel.
			%  TAG = PN.GETPROPTAG(Panel, POINTER) returns tag of POINTER of Panel.
			%
			% Note that the Element.GETPROPTAG(PN) and Element.GETPROPTAG('Panel')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case Panel.WAITBAR
						tag = Panel.WAITBAR_TAG;
					case Panel.H_WAITBAR
						tag = Panel.H_WAITBAR_TAG;
					case Panel.DRAW
						tag = Panel.DRAW_TAG;
					case Panel.DRAWN
						tag = Panel.DRAWN_TAG;
					case Panel.PARENT
						tag = Panel.PARENT_TAG;
					case Panel.BKGCOLOR
						tag = Panel.BKGCOLOR_TAG;
					case Panel.H
						tag = Panel.H_TAG;
					case Panel.SHOW
						tag = Panel.SHOW_TAG;
					case Panel.HIDE
						tag = Panel.HIDE_TAG;
					case Panel.DELETE
						tag = Panel.DELETE_TAG;
					case Panel.CLOSE
						tag = Panel.CLOSE_TAG;
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
			%  CATEGORY = PN.GETPROPCATEGORY(POINTER) returns category of POINTER of PN.
			%  CATEGORY = Element.GETPROPCATEGORY(Panel, POINTER) returns category of POINTER of Panel.
			%  CATEGORY = PN.GETPROPCATEGORY(Panel, POINTER) returns category of POINTER of Panel.
			%
			% Note that the Element.GETPROPCATEGORY(PN) and Element.GETPROPCATEGORY('Panel')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Panel.getPropProp(pointer);
			
			switch prop
				case Panel.WAITBAR
					prop_category = Panel.WAITBAR_CATEGORY;
				case Panel.H_WAITBAR
					prop_category = Panel.H_WAITBAR_CATEGORY;
				case Panel.DRAW
					prop_category = Panel.DRAW_CATEGORY;
				case Panel.DRAWN
					prop_category = Panel.DRAWN_CATEGORY;
				case Panel.PARENT
					prop_category = Panel.PARENT_CATEGORY;
				case Panel.BKGCOLOR
					prop_category = Panel.BKGCOLOR_CATEGORY;
				case Panel.H
					prop_category = Panel.H_CATEGORY;
				case Panel.SHOW
					prop_category = Panel.SHOW_CATEGORY;
				case Panel.HIDE
					prop_category = Panel.HIDE_CATEGORY;
				case Panel.DELETE
					prop_category = Panel.DELETE_CATEGORY;
				case Panel.CLOSE
					prop_category = Panel.CLOSE_CATEGORY;
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
			%  FORMAT = PN.GETPROPFORMAT(POINTER) returns format of POINTER of PN.
			%  FORMAT = Element.GETPROPFORMAT(Panel, POINTER) returns format of POINTER of Panel.
			%  FORMAT = PN.GETPROPFORMAT(Panel, POINTER) returns format of POINTER of Panel.
			%
			% Note that the Element.GETPROPFORMAT(PN) and Element.GETPROPFORMAT('Panel')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Panel.getPropProp(pointer);
			
			switch prop
				case Panel.WAITBAR
					prop_format = Panel.WAITBAR_FORMAT;
				case Panel.H_WAITBAR
					prop_format = Panel.H_WAITBAR_FORMAT;
				case Panel.DRAW
					prop_format = Panel.DRAW_FORMAT;
				case Panel.DRAWN
					prop_format = Panel.DRAWN_FORMAT;
				case Panel.PARENT
					prop_format = Panel.PARENT_FORMAT;
				case Panel.BKGCOLOR
					prop_format = Panel.BKGCOLOR_FORMAT;
				case Panel.H
					prop_format = Panel.H_FORMAT;
				case Panel.SHOW
					prop_format = Panel.SHOW_FORMAT;
				case Panel.HIDE
					prop_format = Panel.HIDE_FORMAT;
				case Panel.DELETE
					prop_format = Panel.DELETE_FORMAT;
				case Panel.CLOSE
					prop_format = Panel.CLOSE_FORMAT;
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
			%  DESCRIPTION = PN.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PN.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Panel, POINTER) returns description of POINTER of Panel.
			%  DESCRIPTION = PN.GETPROPDESCRIPTION(Panel, POINTER) returns description of POINTER of Panel.
			%
			% Note that the Element.GETPROPDESCRIPTION(PN) and Element.GETPROPDESCRIPTION('Panel')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Panel.getPropProp(pointer);
			
			switch prop
				case Panel.WAITBAR
					prop_description = 'WAITBAR (gui, logical) detemines whether to show the waitbar.';
				case Panel.H_WAITBAR
					prop_description = 'H_WAITBAR (evanescent, handle) is the waitbar handle.';
				case Panel.DRAW
					prop_description = 'DRAW (query, logical) draws the panel [accepts uipanel Name-Value pairs].';
				case Panel.DRAWN
					prop_description = 'DRAWN (query, logical) returns whether the panel has been drawn.';
				case Panel.PARENT
					prop_description = 'PARENT (gui, item) is the panel parent.';
				case Panel.BKGCOLOR
					prop_description = 'BKGCOLOR (figure, color) is the panel background color.';
				case Panel.H
					prop_description = 'H (evanescent, handle) is the panel handle.';
				case Panel.SHOW
					prop_description = 'SHOW (query, logical) shows the figure containing the panel.';
				case Panel.HIDE
					prop_description = 'HIDE (query, logical) hides the figure containing the panel.';
				case Panel.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
				case Panel.CLOSE
					prop_description = 'CLOSE (query, logical) closes the figure containing the panel.';
				case Panel.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the panel.';
				case Panel.NAME
					prop_description = 'NAME (constant, string) is the name of the panel.';
				case Panel.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel.';
				case Panel.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel.';
				case Panel.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel.';
				case Panel.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel.';
				case Panel.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel.';
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
			%  SETTINGS = PN.GETPROPSETTINGS(POINTER) returns settings of POINTER of PN.
			%  SETTINGS = Element.GETPROPSETTINGS(Panel, POINTER) returns settings of POINTER of Panel.
			%  SETTINGS = PN.GETPROPSETTINGS(Panel, POINTER) returns settings of POINTER of Panel.
			%
			% Note that the Element.GETPROPSETTINGS(PN) and Element.GETPROPSETTINGS('Panel')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Panel.getPropProp(pointer);
			
			switch prop
				case Panel.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case Panel.H_WAITBAR
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case Panel.DRAW
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case Panel.DRAWN
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case Panel.PARENT
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case Panel.BKGCOLOR
					prop_settings = Format.getFormatSettings(Format.COLOR);
				case Panel.H
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case Panel.SHOW
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case Panel.HIDE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case Panel.DELETE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case Panel.CLOSE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case Panel.TEMPLATE
					prop_settings = 'Panel';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Panel.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Panel.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PN.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PN.
			%  DEFAULT = Element.GETPROPDEFAULT(Panel, POINTER) returns the default value of POINTER of Panel.
			%  DEFAULT = PN.GETPROPDEFAULT(Panel, POINTER) returns the default value of POINTER of Panel.
			%
			% Note that the Element.GETPROPDEFAULT(PN) and Element.GETPROPDEFAULT('Panel')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Panel.getPropProp(pointer);
			
			switch prop
				case Panel.WAITBAR
					prop_default = Format.getFormatDefault(Format.LOGICAL, Panel.getPropSettings(prop));
				case Panel.H_WAITBAR
					prop_default = Format.getFormatDefault(Format.HANDLE, Panel.getPropSettings(prop));
				case Panel.DRAW
					prop_default = Format.getFormatDefault(Format.LOGICAL, Panel.getPropSettings(prop));
				case Panel.DRAWN
					prop_default = Format.getFormatDefault(Format.LOGICAL, Panel.getPropSettings(prop));
				case Panel.PARENT
					prop_default = GUI();
				case Panel.BKGCOLOR
					prop_default = BRAPH2.COL_BKG;
				case Panel.H
					prop_default = Format.getFormatDefault(Format.HANDLE, Panel.getPropSettings(prop));
				case Panel.SHOW
					prop_default = Format.getFormatDefault(Format.LOGICAL, Panel.getPropSettings(prop));
				case Panel.HIDE
					prop_default = Format.getFormatDefault(Format.LOGICAL, Panel.getPropSettings(prop));
				case Panel.DELETE
					prop_default = Format.getFormatDefault(Format.LOGICAL, Panel.getPropSettings(prop));
				case Panel.CLOSE
					prop_default = Format.getFormatDefault(Format.LOGICAL, Panel.getPropSettings(prop));
				case Panel.ELCLASS
					prop_default = 'Panel';
				case Panel.NAME
					prop_default = 'Panel';
				case Panel.DESCRIPTION
					prop_default = 'A Panel is the basic element to manage graphical representations of elements. It is an empty graphical panel. It is filled with the graphical content representing an element (PanelElement) or figure (PanelFig) or property (typically, PanelProp and derived classes). It must be placed within another container; for example, a figure (e.g., PanelElement into GUIElement, or PanelFig into GUIFig) or another panel (e.g., PanelProp into PanelElement).';
				case Panel.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, Panel.getPropSettings(prop));
				case Panel.ID
					prop_default = 'Panel ID';
				case Panel.LABEL
					prop_default = 'Panel label';
				case Panel.NOTES
					prop_default = 'Panel notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Panel.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Panel.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PN.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PN.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Panel, POINTER) returns the conditioned default value of POINTER of Panel.
			%  DEFAULT = PN.GETPROPDEFAULTCONDITIONED(Panel, POINTER) returns the conditioned default value of POINTER of Panel.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PN) and Element.GETPROPDEFAULTCONDITIONED('Panel')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Panel.getPropProp(pointer);
			
			prop_default = Panel.conditioning(prop, Panel.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PN.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PN.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PN.
			%  CHECK = Element.CHECKPROP(Panel, PROP, VALUE) checks VALUE format for PROP of Panel.
			%  CHECK = PN.CHECKPROP(Panel, PROP, VALUE) checks VALUE format for PROP of Panel.
			% 
			% PN.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:Panel:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PN.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PN.
			%   Error id: €BRAPH2.STR€:Panel:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(Panel, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Panel.
			%   Error id: €BRAPH2.STR€:Panel:€BRAPH2.WRONG_INPUT€
			%  PN.CHECKPROP(Panel, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Panel.
			%   Error id: €BRAPH2.STR€:Panel:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PN) and Element.CHECKPROP('Panel')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Panel.getPropProp(pointer);
			
			switch prop
				case Panel.WAITBAR % __Panel.WAITBAR__
					check = Format.checkFormat(Format.LOGICAL, value, Panel.getPropSettings(prop));
				case Panel.H_WAITBAR % __Panel.H_WAITBAR__
					check = Format.checkFormat(Format.HANDLE, value, Panel.getPropSettings(prop));
				case Panel.DRAW % __Panel.DRAW__
					check = Format.checkFormat(Format.LOGICAL, value, Panel.getPropSettings(prop));
				case Panel.DRAWN % __Panel.DRAWN__
					check = Format.checkFormat(Format.LOGICAL, value, Panel.getPropSettings(prop));
				case Panel.PARENT % __Panel.PARENT__
					check = Format.checkFormat(Format.ITEM, value, Panel.getPropSettings(prop));
					if check
						check = isa(value, 'GUI') || isa(value, 'Panel');
					end
				case Panel.BKGCOLOR % __Panel.BKGCOLOR__
					check = Format.checkFormat(Format.COLOR, value, Panel.getPropSettings(prop));
				case Panel.H % __Panel.H__
					check = Format.checkFormat(Format.HANDLE, value, Panel.getPropSettings(prop));
				case Panel.SHOW % __Panel.SHOW__
					check = Format.checkFormat(Format.LOGICAL, value, Panel.getPropSettings(prop));
				case Panel.HIDE % __Panel.HIDE__
					check = Format.checkFormat(Format.LOGICAL, value, Panel.getPropSettings(prop));
				case Panel.DELETE % __Panel.DELETE__
					check = Format.checkFormat(Format.LOGICAL, value, Panel.getPropSettings(prop));
				case Panel.CLOSE % __Panel.CLOSE__
					check = Format.checkFormat(Format.LOGICAL, value, Panel.getPropSettings(prop));
				case Panel.TEMPLATE % __Panel.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, Panel.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Panel:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Panel:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Panel.getPropTag(prop) ' (' Panel.getFormatTag(Panel.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(pn, prop)
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
				case Panel.PARENT % __Panel.PARENT__
					if check_graphics(pn.getr('H'), 'uipanel') % H = p for panel
					    set(pn.get('H'), 'Parent', pn.get('PARENT').get('H')) % H = f for GUI and H = p for Panel
					end
					
				case Panel.BKGCOLOR % __Panel.BKGCOLOR__
					if pn.get('DRAWN') && ~isequal(get(pn.get('H'), 'BackgroundColor'), pn.get('BKGCOLOR'))
					    set(pn.get('H'), 'BackgroundColor', pn.get('BKGCOLOR'))
					end
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						postset@ConcreteElement(pn, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pn, prop, varargin)
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
				case Panel.DRAW % __Panel.DRAW__
					if check_graphics(pn.memorize('H'), 'uipanel') % H = p for panel
					    p = pn.get('H');
					    
					    if ~isempty(varargin)
					        set(p, varargin{:})
					    end
					    
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(pn)], ...
					        [BRAPH2.STR ':' class(pn) '\n' ...
					        'The call pn.get(''DRAW'') did not work.\n' ...
					        'This shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case Panel.DRAWN % __Panel.DRAWN__
					value = check_graphics(pn.getr('H'), 'uipanel'); % H = p for panel
					
				case Panel.H % __Panel.H__
					p = uipanel( ...
					    'Parent', pn.memorize('PARENT').memorize('H'), ... % H = f for GUI and H = p for Panel
					    'Tag', 'H', ...
					    'UserData', pn, ... % handle to retrieve the panel
					    'BackgroundColor', pn.get('BKGCOLOR'), ...
					    'BorderType', 'none', ...
					    'DeleteFcn', {@cb_get, 'DELETE'} ...
					    );
					value = p;
					
				case Panel.SHOW % __Panel.SHOW__
					if pn.get('DRAWN')
					    if get_from_varargin(true, 'ShowParentFigure', varargin)
					        pn.get('PARENT').get('SHOW')
					    end
					    
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(pn)], ...
					        [BRAPH2.STR ':' class(pn) '\n' ...
					        'The call pn.get(''SHOW'') has NOT been executed.\n' ...
					        'First, the panel ' pn.get('ID') ' should be drawn calling pn.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case Panel.HIDE % __Panel.HIDE__
					if pn.get('DRAWN')
					    if get_from_varargin(true, 'HideParentFigure', varargin)
					        pn.get('PARENT').get('HIDE')
					    end
					    
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(pn)], ...
					        [BRAPH2.STR ':' class(pn) '\n' ...
					        'The call pn.get(''HIDE'') has NOT been executed.\n' ...
					        'First, the panel ' pn.get('ID') ' should be drawn calling pn.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case Panel.DELETE % __Panel.DELETE__
					if pn.get('DRAWN')
					    pn.set('H', Element.getNoValue())
					
					    pn.set('H_WAITBAR', Element.getNoValue())
					    
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(pn)], ...
					        [BRAPH2.STR ':' class(pn) '\n' ...
					        'The call pn.get(''DELETE'') has NOT been executed.\n' ...
					        'First, the panel ' pn.get('ID') ' should be drawn calling pn.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case Panel.CLOSE % __Panel.CLOSE__
					if pn.get('DRAWN')
					    if get_from_varargin(true, 'CloseParentFigure', varargin)
					        pn.get('PARENT').get('CLOSE')
					    end
					    
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(pn)], ...
					        [BRAPH2.STR ':' class(pn) '\n' ...
					        'The call pn.get(''CLOSE'') has NOT been executed.\n' ...
					        'First, the panel ' pn.get('ID') ' should be drawn calling pn.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(pn, prop, varargin{:});
					else
						value = calculateValue@Element(pn, prop, varargin{:});
					end
			end
			
			function cb_get(~, ~, varargin)
				pn.get(varargin{:})
			end
		end
	end
end
