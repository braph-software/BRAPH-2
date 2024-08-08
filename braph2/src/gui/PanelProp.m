classdef PanelProp < Panel
	%PanelProp is a property panel.
	% It is a subclass of <a href="matlab:help Panel">Panel</a>.
	%
	% A Prop Panel (PanelProp) renders a property of an element in a panel. 
	%  It contains a text with the prop tag and a tooltip with the prop description.
	%  For parameter, data, figure and gui callbacks, it also features a callback button.
	%  For results, it features calculate and delete buttons.
	%  It is typically employed in one of its derived forms, 
	%  where also the contents of the element property are shown.
	% 
	%  Children of PanelProp should update the props:
	%   <strong>X_DRAW</strong> - to initially create the panel and its graphical objects
	%   <strong>UPDATE</strong> - to update the information content of the panel and of the element
	%   <strong>REDRAW</strong> - to resize the panel and reposition its graphical objcts
	%   <strong>HEIGHT</strong> - to determine the height of the panel
	% 
	% CONSTRUCTOR - To construct a PanelProp use, e.g.:
	% 
	% 	pr = PanelProp('<strong>PARENT</strong>', <parent element>, '<strong>EL</strong>', <element>)
	%     
	%  where the <parent element> is most often a PanelElement.
	%    
	% DRAW - To create the initial prop panel (title text and buttons), call:
	% 
	%     pr.get('<strong>DRAW</strong>'[, 'Name', <value>, ...])
	%     p = pr.get('<strong>H</strong>'); % p is the handle of the generated panel
	% 
	%  The query pn.get('<strong>DRAWN</strong>') returns whether the Panel has 
	%   been drawn and therefore can be shown.
	% 
	% UPDATE - Updates the information content of the panel and of the element.
	%   Typically, it does not need to be called explicitly.
	%   It is internally called by PanelElement when needed.
	% 
	% REDRAW - Resizes the panel and repositions its graphical objcts.
	%   Typically, it does not need to be called explicitly.
	%   It is internally called by PanelElement when needed.
	% 
	% CALLBACKS - These are the public callback (to be further implemented by the derived panels):
	% 
	%     pn.get('<strong>SHOW</strong>') - shows the figure containing the panel.
	%     pn.get('<strong>HIDE</strong>') - hides the figure containing the panel.
	%     pn.get('<strong>DELETE</strong>') - resets the handles when the panel is deleted.
	%     pn.get('<strong>CLOSE</strong>') - closes the figure containing the panel.
	%
	% PanelProp methods (constructor):
	%  PanelProp - constructor
	%
	% PanelProp methods:
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
	% PanelProp methods (display):
	%  tostring - string with information about the prop panel
	%  disp - displays information about the prop panel
	%  tree - displays the tree of the prop panel
	%
	% PanelProp methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the prop panel
	%
	% PanelProp methods (save/load, Static):
	%  save - saves BRAPH2 prop panel as b2 file
	%  load - loads a BRAPH2 prop panel from a b2 file
	%
	% PanelProp method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the prop panel
	%
	% PanelProp method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the prop panel
	%
	% PanelProp methods (inspection, Static):
	%  getClass - returns the class of the prop panel
	%  getSubclasses - returns all subclasses of PanelProp
	%  getProps - returns the property list of the prop panel
	%  getPropNumber - returns the property number of the prop panel
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
	% PanelProp methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelProp methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelProp methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelProp methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelProp; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelProp constants</a>.
	%
	%
	% See also uipanel, uilabel, uibutton, GUI, GUIElement, PanelElement.
	
	properties (Constant) % properties
		X_DRAW = Panel.getPropNumber() + 1;
		X_DRAW_TAG = 'X_DRAW';
		X_DRAW_CATEGORY = Category.QUERY;
		X_DRAW_FORMAT = Format.LOGICAL;
		
		UPDATE = Panel.getPropNumber() + 2;
		UPDATE_TAG = 'UPDATE';
		UPDATE_CATEGORY = Category.QUERY;
		UPDATE_FORMAT = Format.LOGICAL;
		
		REDRAW = Panel.getPropNumber() + 3;
		REDRAW_TAG = 'REDRAW';
		REDRAW_CATEGORY = Category.QUERY;
		REDRAW_FORMAT = Format.LOGICAL;
		
		EL = Panel.getPropNumber() + 4;
		EL_TAG = 'EL';
		EL_CATEGORY = Category.DATA;
		EL_FORMAT = Format.ITEM;
		
		PROP = Panel.getPropNumber() + 5;
		PROP_TAG = 'PROP';
		PROP_CATEGORY = Category.DATA;
		PROP_FORMAT = Format.SCALAR;
		
		HEIGHT = Panel.getPropNumber() + 6;
		HEIGHT_TAG = 'HEIGHT';
		HEIGHT_CATEGORY = Category.GUI;
		HEIGHT_FORMAT = Format.SIZE;
		
		TITLE = Panel.getPropNumber() + 7;
		TITLE_TAG = 'TITLE';
		TITLE_CATEGORY = Category.GUI;
		TITLE_FORMAT = Format.STRING;
		
		LABEL_TITLE = Panel.getPropNumber() + 8;
		LABEL_TITLE_TAG = 'LABEL_TITLE';
		LABEL_TITLE_CATEGORY = Category.EVANESCENT;
		LABEL_TITLE_FORMAT = Format.HANDLE;
		
		BUTTON_CB = Panel.getPropNumber() + 9;
		BUTTON_CB_TAG = 'BUTTON_CB';
		BUTTON_CB_CATEGORY = Category.EVANESCENT;
		BUTTON_CB_FORMAT = Format.HANDLE;
		
		GUI_CB = Panel.getPropNumber() + 10;
		GUI_CB_TAG = 'GUI_CB';
		GUI_CB_CATEGORY = Category.DATA;
		GUI_CB_FORMAT = Format.ITEM;
		
		LISTENER_CB = Panel.getPropNumber() + 11;
		LISTENER_CB_TAG = 'LISTENER_CB';
		LISTENER_CB_CATEGORY = Category.EVANESCENT;
		LISTENER_CB_FORMAT = Format.HANDLE;
		
		BUTTON_CALC = Panel.getPropNumber() + 12;
		BUTTON_CALC_TAG = 'BUTTON_CALC';
		BUTTON_CALC_CATEGORY = Category.EVANESCENT;
		BUTTON_CALC_FORMAT = Format.HANDLE;
		
		BUTTON_DEL = Panel.getPropNumber() + 13;
		BUTTON_DEL_TAG = 'BUTTON_DEL';
		BUTTON_DEL_CATEGORY = Category.EVANESCENT;
		BUTTON_DEL_FORMAT = Format.HANDLE;
		
		LISTENER_SET = Panel.getPropNumber() + 14;
		LISTENER_SET_TAG = 'LISTENER_SET';
		LISTENER_SET_CATEGORY = Category.EVANESCENT;
		LISTENER_SET_FORMAT = Format.HANDLELIST;
		
		LISTENER_MEMORIZED = Panel.getPropNumber() + 15;
		LISTENER_MEMORIZED_TAG = 'LISTENER_MEMORIZED';
		LISTENER_MEMORIZED_CATEGORY = Category.EVANESCENT;
		LISTENER_MEMORIZED_FORMAT = Format.HANDLELIST;
		
		LISTENER_LOCKED = Panel.getPropNumber() + 16;
		LISTENER_LOCKED_TAG = 'LISTENER_LOCKED';
		LISTENER_LOCKED_CATEGORY = Category.EVANESCENT;
		LISTENER_LOCKED_FORMAT = Format.HANDLELIST;
	end
	methods % constructor
		function pr = PanelProp(varargin)
			%PanelProp() creates a prop panel.
			%
			% PanelProp(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelProp(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pr = pr@Panel(varargin{:});
		end
	end
	methods (Static) % inspection
		function pr_class = getClass()
			%GETCLASS returns the class of the prop panel.
			%
			% CLASS = PanelProp.GETCLASS() returns the class 'PanelProp'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelProp') returns 'PanelProp'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelProp')
			%  are less computationally efficient.
			
			pr_class = 'PanelProp';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the prop panel.
			%
			% LIST = PanelProp.GETSUBCLASSES() returns all subclasses of 'PanelProp'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelProp') returns all subclasses of 'PanelProp'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelProp')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelProp', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of prop panel.
			%
			% PROPS = PanelProp.GETPROPS() returns the property list of prop panel
			%  as a row vector.
			%
			% PROPS = PanelProp.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelProp'[, CATEGORY]) returns the property list of 'PanelProp'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Panel.getProps() ...
						PanelProp.X_DRAW ...
						PanelProp.UPDATE ...
						PanelProp.REDRAW ...
						PanelProp.EL ...
						PanelProp.PROP ...
						PanelProp.HEIGHT ...
						PanelProp.TITLE ...
						PanelProp.LABEL_TITLE ...
						PanelProp.BUTTON_CB ...
						PanelProp.GUI_CB ...
						PanelProp.LISTENER_CB ...
						PanelProp.BUTTON_CALC ...
						PanelProp.BUTTON_DEL ...
						PanelProp.LISTENER_SET ...
						PanelProp.LISTENER_MEMORIZED ...
						PanelProp.LISTENER_LOCKED ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Panel.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Panel.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Panel.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						Panel.getProps(Category.DATA) ...
						PanelProp.EL ...
						PanelProp.PROP ...
						PanelProp.GUI_CB ...
						];
				case Category.RESULT
					prop_list = [
						Panel.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Panel.getProps(Category.QUERY) ...
						PanelProp.X_DRAW ...
						PanelProp.UPDATE ...
						PanelProp.REDRAW ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Panel.getProps(Category.EVANESCENT) ...
						PanelProp.LABEL_TITLE ...
						PanelProp.BUTTON_CB ...
						PanelProp.LISTENER_CB ...
						PanelProp.BUTTON_CALC ...
						PanelProp.BUTTON_DEL ...
						PanelProp.LISTENER_SET ...
						PanelProp.LISTENER_MEMORIZED ...
						PanelProp.LISTENER_LOCKED ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Panel.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Panel.getProps(Category.GUI) ...
						PanelProp.HEIGHT ...
						PanelProp.TITLE ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of prop panel.
			%
			% N = PanelProp.GETPROPNUMBER() returns the property number of prop panel.
			%
			% N = PanelProp.GETPROPNUMBER(CATEGORY) returns the property number of prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelProp') returns the property number of 'PanelProp'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelProp')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelProp.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in prop panel/error.
			%
			% CHECK = PanelProp.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelProp, PROP) checks whether PROP exists for PanelProp.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelProp:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelProp:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelProp:WrongInput]
			%  Element.EXISTSPROP(PanelProp, PROP) throws error if PROP does NOT exist for PanelProp.
			%   Error id: [BRAPH2:PanelProp:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelProp')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelProp.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelProp:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelProp:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelProp.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in prop panel/error.
			%
			% CHECK = PanelProp.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelProp, TAG) checks whether TAG exists for PanelProp.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelProp:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelProp:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelProp:WrongInput]
			%  Element.EXISTSTAG(PanelProp, TAG) throws error if TAG does NOT exist for PanelProp.
			%   Error id: [BRAPH2:PanelProp:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelProp')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelprop_tag_list = cellfun(@(x) PanelProp.getPropTag(x), num2cell(PanelProp.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelprop_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelProp:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelProp:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelProp.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelProp, POINTER) returns property number of POINTER of PanelProp.
			%  PROPERTY = PR.GETPROPPROP(PanelProp, POINTER) returns property number of POINTER of PanelProp.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelprop_tag_list = cellfun(@(x) PanelProp.getPropTag(x), num2cell(PanelProp.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelprop_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PanelProp, POINTER) returns tag of POINTER of PanelProp.
			%  TAG = PR.GETPROPTAG(PanelProp, POINTER) returns tag of POINTER of PanelProp.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelProp.X_DRAW
						tag = PanelProp.X_DRAW_TAG;
					case PanelProp.UPDATE
						tag = PanelProp.UPDATE_TAG;
					case PanelProp.REDRAW
						tag = PanelProp.REDRAW_TAG;
					case PanelProp.EL
						tag = PanelProp.EL_TAG;
					case PanelProp.PROP
						tag = PanelProp.PROP_TAG;
					case PanelProp.HEIGHT
						tag = PanelProp.HEIGHT_TAG;
					case PanelProp.TITLE
						tag = PanelProp.TITLE_TAG;
					case PanelProp.LABEL_TITLE
						tag = PanelProp.LABEL_TITLE_TAG;
					case PanelProp.BUTTON_CB
						tag = PanelProp.BUTTON_CB_TAG;
					case PanelProp.GUI_CB
						tag = PanelProp.GUI_CB_TAG;
					case PanelProp.LISTENER_CB
						tag = PanelProp.LISTENER_CB_TAG;
					case PanelProp.BUTTON_CALC
						tag = PanelProp.BUTTON_CALC_TAG;
					case PanelProp.BUTTON_DEL
						tag = PanelProp.BUTTON_DEL_TAG;
					case PanelProp.LISTENER_SET
						tag = PanelProp.LISTENER_SET_TAG;
					case PanelProp.LISTENER_MEMORIZED
						tag = PanelProp.LISTENER_MEMORIZED_TAG;
					case PanelProp.LISTENER_LOCKED
						tag = PanelProp.LISTENER_LOCKED_TAG;
					otherwise
						tag = getPropTag@Panel(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelProp, POINTER) returns category of POINTER of PanelProp.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelProp, POINTER) returns category of POINTER of PanelProp.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelProp')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelProp.getPropProp(pointer);
			
			switch prop
				case PanelProp.X_DRAW
					prop_category = PanelProp.X_DRAW_CATEGORY;
				case PanelProp.UPDATE
					prop_category = PanelProp.UPDATE_CATEGORY;
				case PanelProp.REDRAW
					prop_category = PanelProp.REDRAW_CATEGORY;
				case PanelProp.EL
					prop_category = PanelProp.EL_CATEGORY;
				case PanelProp.PROP
					prop_category = PanelProp.PROP_CATEGORY;
				case PanelProp.HEIGHT
					prop_category = PanelProp.HEIGHT_CATEGORY;
				case PanelProp.TITLE
					prop_category = PanelProp.TITLE_CATEGORY;
				case PanelProp.LABEL_TITLE
					prop_category = PanelProp.LABEL_TITLE_CATEGORY;
				case PanelProp.BUTTON_CB
					prop_category = PanelProp.BUTTON_CB_CATEGORY;
				case PanelProp.GUI_CB
					prop_category = PanelProp.GUI_CB_CATEGORY;
				case PanelProp.LISTENER_CB
					prop_category = PanelProp.LISTENER_CB_CATEGORY;
				case PanelProp.BUTTON_CALC
					prop_category = PanelProp.BUTTON_CALC_CATEGORY;
				case PanelProp.BUTTON_DEL
					prop_category = PanelProp.BUTTON_DEL_CATEGORY;
				case PanelProp.LISTENER_SET
					prop_category = PanelProp.LISTENER_SET_CATEGORY;
				case PanelProp.LISTENER_MEMORIZED
					prop_category = PanelProp.LISTENER_MEMORIZED_CATEGORY;
				case PanelProp.LISTENER_LOCKED
					prop_category = PanelProp.LISTENER_LOCKED_CATEGORY;
				otherwise
					prop_category = getPropCategory@Panel(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(PanelProp, POINTER) returns format of POINTER of PanelProp.
			%  FORMAT = PR.GETPROPFORMAT(PanelProp, POINTER) returns format of POINTER of PanelProp.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelProp')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelProp.getPropProp(pointer);
			
			switch prop
				case PanelProp.X_DRAW
					prop_format = PanelProp.X_DRAW_FORMAT;
				case PanelProp.UPDATE
					prop_format = PanelProp.UPDATE_FORMAT;
				case PanelProp.REDRAW
					prop_format = PanelProp.REDRAW_FORMAT;
				case PanelProp.EL
					prop_format = PanelProp.EL_FORMAT;
				case PanelProp.PROP
					prop_format = PanelProp.PROP_FORMAT;
				case PanelProp.HEIGHT
					prop_format = PanelProp.HEIGHT_FORMAT;
				case PanelProp.TITLE
					prop_format = PanelProp.TITLE_FORMAT;
				case PanelProp.LABEL_TITLE
					prop_format = PanelProp.LABEL_TITLE_FORMAT;
				case PanelProp.BUTTON_CB
					prop_format = PanelProp.BUTTON_CB_FORMAT;
				case PanelProp.GUI_CB
					prop_format = PanelProp.GUI_CB_FORMAT;
				case PanelProp.LISTENER_CB
					prop_format = PanelProp.LISTENER_CB_FORMAT;
				case PanelProp.BUTTON_CALC
					prop_format = PanelProp.BUTTON_CALC_FORMAT;
				case PanelProp.BUTTON_DEL
					prop_format = PanelProp.BUTTON_DEL_FORMAT;
				case PanelProp.LISTENER_SET
					prop_format = PanelProp.LISTENER_SET_FORMAT;
				case PanelProp.LISTENER_MEMORIZED
					prop_format = PanelProp.LISTENER_MEMORIZED_FORMAT;
				case PanelProp.LISTENER_LOCKED
					prop_format = PanelProp.LISTENER_LOCKED_FORMAT;
				otherwise
					prop_format = getPropFormat@Panel(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelProp, POINTER) returns description of POINTER of PanelProp.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelProp, POINTER) returns description of POINTER of PanelProp.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelProp.getPropProp(pointer);
			
			switch prop
				case PanelProp.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the graphical objects of the prop panel [to be implemented in subelements].';
				case PanelProp.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content of the prop panel and its graphical objects.';
				case PanelProp.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the prop panel and repositions its graphical objects [accept Width-value pair].';
				case PanelProp.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelProp.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PanelProp.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the prop panel.';
				case PanelProp.TITLE
					prop_description = 'TITLE (gui, string) is the property title.';
				case PanelProp.LABEL_TITLE
					prop_description = 'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.';
				case PanelProp.BUTTON_CB
					prop_description = 'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].';
				case PanelProp.GUI_CB
					prop_description = 'GUI_CB (data, item) is the handle to the item figure.';
				case PanelProp.LISTENER_CB
					prop_description = 'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.';
				case PanelProp.BUTTON_CALC
					prop_description = 'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].';
				case PanelProp.BUTTON_DEL
					prop_description = 'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].';
				case PanelProp.LISTENER_SET
					prop_description = 'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.';
				case PanelProp.LISTENER_MEMORIZED
					prop_description = 'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.';
				case PanelProp.LISTENER_LOCKED
					prop_description = 'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.';
				case PanelProp.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the property panel.';
				case PanelProp.NAME
					prop_description = 'NAME (constant, string) is the name of the property panel.';
				case PanelProp.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the property panel.';
				case PanelProp.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the property panel.';
				case PanelProp.ID
					prop_description = 'ID (data, string) is a few-letter code for the property panel.';
				case PanelProp.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the property panel.';
				case PanelProp.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the property panel.';
				case PanelProp.DRAW
					prop_description = 'DRAW (query, logical) draws the property panel.';
				case PanelProp.SHOW
					prop_description = 'SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.';
				case PanelProp.HIDE
					prop_description = 'HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.';
				case PanelProp.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
				case PanelProp.CLOSE
					prop_description = 'CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.';
				otherwise
					prop_description = getPropDescription@Panel(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelProp, POINTER) returns settings of POINTER of PanelProp.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelProp, POINTER) returns settings of POINTER of PanelProp.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelProp.getPropProp(pointer);
			
			switch prop
				case PanelProp.X_DRAW
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelProp.UPDATE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelProp.REDRAW
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelProp.EL
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case PanelProp.PROP
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case PanelProp.HEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case PanelProp.TITLE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PanelProp.LABEL_TITLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelProp.BUTTON_CB
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelProp.GUI_CB
					prop_settings = 'GUI';
				case PanelProp.LISTENER_CB
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelProp.BUTTON_CALC
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelProp.BUTTON_DEL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelProp.LISTENER_SET
					prop_settings = Format.getFormatSettings(Format.HANDLELIST);
				case PanelProp.LISTENER_MEMORIZED
					prop_settings = Format.getFormatSettings(Format.HANDLELIST);
				case PanelProp.LISTENER_LOCKED
					prop_settings = Format.getFormatSettings(Format.HANDLELIST);
				case PanelProp.TEMPLATE
					prop_settings = 'PanelProp';
				otherwise
					prop_settings = getPropSettings@Panel(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelProp.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelProp.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelProp, POINTER) returns the default value of POINTER of PanelProp.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelProp, POINTER) returns the default value of POINTER of PanelProp.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelProp.getPropProp(pointer);
			
			switch prop
				case PanelProp.X_DRAW
					prop_default = Format.getFormatDefault(Format.LOGICAL, PanelProp.getPropSettings(prop));
				case PanelProp.UPDATE
					prop_default = Format.getFormatDefault(Format.LOGICAL, PanelProp.getPropSettings(prop));
				case PanelProp.REDRAW
					prop_default = Format.getFormatDefault(Format.LOGICAL, PanelProp.getPropSettings(prop));
				case PanelProp.EL
					prop_default = Format.getFormatDefault(Format.ITEM, PanelProp.getPropSettings(prop));
				case PanelProp.PROP
					prop_default = 1;
				case PanelProp.HEIGHT
					prop_default = s(2);
				case PanelProp.TITLE
					prop_default = Format.getFormatDefault(Format.STRING, PanelProp.getPropSettings(prop));
				case PanelProp.LABEL_TITLE
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelProp.getPropSettings(prop));
				case PanelProp.BUTTON_CB
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelProp.getPropSettings(prop));
				case PanelProp.GUI_CB
					prop_default = Format.getFormatDefault(Format.ITEM, PanelProp.getPropSettings(prop));
				case PanelProp.LISTENER_CB
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelProp.getPropSettings(prop));
				case PanelProp.BUTTON_CALC
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelProp.getPropSettings(prop));
				case PanelProp.BUTTON_DEL
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelProp.getPropSettings(prop));
				case PanelProp.LISTENER_SET
					prop_default = Format.getFormatDefault(Format.HANDLELIST, PanelProp.getPropSettings(prop));
				case PanelProp.LISTENER_MEMORIZED
					prop_default = Format.getFormatDefault(Format.HANDLELIST, PanelProp.getPropSettings(prop));
				case PanelProp.LISTENER_LOCKED
					prop_default = Format.getFormatDefault(Format.HANDLELIST, PanelProp.getPropSettings(prop));
				case PanelProp.ELCLASS
					prop_default = 'PanelProp';
				case PanelProp.NAME
					prop_default = 'Prop Panel';
				case PanelProp.DESCRIPTION
					prop_default = 'A Prop Panel (PanelProp) renders a property of an element in a panel.';
				case PanelProp.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelProp.getPropSettings(prop));
				case PanelProp.ID
					prop_default = 'PanelProp ID';
				case PanelProp.LABEL
					prop_default = 'PanelProp label';
				case PanelProp.NOTES
					prop_default = 'PanelProp notes';
				otherwise
					prop_default = getPropDefault@Panel(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelProp.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelProp.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelProp, POINTER) returns the conditioned default value of POINTER of PanelProp.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelProp, POINTER) returns the conditioned default value of POINTER of PanelProp.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelProp')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelProp.getPropProp(pointer);
			
			prop_default = PanelProp.conditioning(prop, PanelProp.getPropDefault(prop));
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
				case PanelProp.GUI_CB % __PanelProp.GUI_CB__
					if isequal(value.getClass(), 'GUI') % i.e., default initialization
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    if isa(el.getr(prop), 'Callback')
					        f = ancestor(pr.get('H'), 'figure');
					
					        value = GUIElement( ...
					            'PE', el.getr(prop).get('EL'), ... % ensure that the element is stored
					            'POSITION', [ ...
					                x0(f, 'normalized')+w(f, 'normalized') ...
					                y0(f, 'normalized') ...
					                w(f, 'normalized') ...
					                h(f, 'normalized') ...
					                ], ...
					            'WAITBAR', pr.getCallback('WAITBAR'), ...
					            'CLOSEREQ', false ...
					            );
					    end
					end
					
				otherwise
					if prop <= Panel.getPropNumber()
						value = preset@Panel(pr, prop, value);
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
			%  CHECK = Element.CHECKPROP(PanelProp, PROP, VALUE) checks VALUE format for PROP of PanelProp.
			%  CHECK = PR.CHECKPROP(PanelProp, PROP, VALUE) checks VALUE format for PROP of PanelProp.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelProp:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelProp:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelProp, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelProp.
			%   Error id: €BRAPH2.STR€:PanelProp:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelProp, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelProp.
			%   Error id: €BRAPH2.STR€:PanelProp:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelProp')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelProp.getPropProp(pointer);
			
			switch prop
				case PanelProp.X_DRAW % __PanelProp.X_DRAW__
					check = Format.checkFormat(Format.LOGICAL, value, PanelProp.getPropSettings(prop));
				case PanelProp.UPDATE % __PanelProp.UPDATE__
					check = Format.checkFormat(Format.LOGICAL, value, PanelProp.getPropSettings(prop));
				case PanelProp.REDRAW % __PanelProp.REDRAW__
					check = Format.checkFormat(Format.LOGICAL, value, PanelProp.getPropSettings(prop));
				case PanelProp.EL % __PanelProp.EL__
					check = Format.checkFormat(Format.ITEM, value, PanelProp.getPropSettings(prop));
				case PanelProp.PROP % __PanelProp.PROP__
					check = Format.checkFormat(Format.SCALAR, value, PanelProp.getPropSettings(prop));
				case PanelProp.HEIGHT % __PanelProp.HEIGHT__
					check = Format.checkFormat(Format.SIZE, value, PanelProp.getPropSettings(prop));
				case PanelProp.TITLE % __PanelProp.TITLE__
					check = Format.checkFormat(Format.STRING, value, PanelProp.getPropSettings(prop));
				case PanelProp.LABEL_TITLE % __PanelProp.LABEL_TITLE__
					check = Format.checkFormat(Format.HANDLE, value, PanelProp.getPropSettings(prop));
				case PanelProp.BUTTON_CB % __PanelProp.BUTTON_CB__
					check = Format.checkFormat(Format.HANDLE, value, PanelProp.getPropSettings(prop));
				case PanelProp.GUI_CB % __PanelProp.GUI_CB__
					check = Format.checkFormat(Format.ITEM, value, PanelProp.getPropSettings(prop));
				case PanelProp.LISTENER_CB % __PanelProp.LISTENER_CB__
					check = Format.checkFormat(Format.HANDLE, value, PanelProp.getPropSettings(prop));
				case PanelProp.BUTTON_CALC % __PanelProp.BUTTON_CALC__
					check = Format.checkFormat(Format.HANDLE, value, PanelProp.getPropSettings(prop));
				case PanelProp.BUTTON_DEL % __PanelProp.BUTTON_DEL__
					check = Format.checkFormat(Format.HANDLE, value, PanelProp.getPropSettings(prop));
				case PanelProp.LISTENER_SET % __PanelProp.LISTENER_SET__
					check = Format.checkFormat(Format.HANDLELIST, value, PanelProp.getPropSettings(prop));
				case PanelProp.LISTENER_MEMORIZED % __PanelProp.LISTENER_MEMORIZED__
					check = Format.checkFormat(Format.HANDLELIST, value, PanelProp.getPropSettings(prop));
				case PanelProp.LISTENER_LOCKED % __PanelProp.LISTENER_LOCKED__
					check = Format.checkFormat(Format.HANDLELIST, value, PanelProp.getPropSettings(prop));
				case PanelProp.TEMPLATE % __PanelProp.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelProp.getPropSettings(prop));
				otherwise
					if prop <= Panel.getPropNumber()
						check = checkProp@Panel(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelProp:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelProp:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelProp.getPropTag(prop) ' (' PanelProp.getFormatTag(PanelProp.getPropFormat(prop)) ').'] ...
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
				case PanelProp.EL % __PanelProp.EL__
					pr.lock('EL', 'Iterative', false)
					if ~isa(pr.getr('PROP'), 'NoValue')
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    settings = {};
					    if isa(pr.getr('ID'), 'NoValue')
					        settings = [settings 'ID' el.getPropTag(prop)];
					    end
					    if isa(pr.getr('TITLE'), 'NoValue')
					        settings = [settings 'TITLE' el.getPropTag(prop)];
					    end
					    if isa(pr.getr('BKGCOLOR'), 'NoValue')
					        switch el.getPropCategory(prop)
					            case Category.CONSTANT
					                color = BRAPH2.COL_C;
					            case Category.METADATA
					                color = BRAPH2.COL_M;
					            case Category.PARAMETER
					                color = BRAPH2.COL_P;
					            case Category.DATA
					                color = BRAPH2.COL_D;
					            case Category.RESULT
					                color = BRAPH2.COL_R;
					            case Category.QUERY
					                color = BRAPH2.COL_Q;
					            case Category.EVANESCENT
					                color = BRAPH2.COL_E;
					            case Category.FIGURE
					                color = BRAPH2.COL_F;
					            case Category.GUI
					                color = BRAPH2.COL_G;
					        end
					        settings = [settings 'BKGCOLOR' color];
					    end
					    if ~isempty(settings)
					        pr.set(settings{:})
					    end
					end
					
				case PanelProp.PROP % __PanelProp.PROP__
					pr.lock('PROP', 'Iterative', false)
					if ~isa(pr.getr('EL'), 'NoValue')
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					
					    settings = {};
					    if isa(pr.getr('ID'), 'NoValue')
					        settings = [settings 'ID' el.getPropTag(prop)];
					    end
					    if isa(pr.getr('TITLE'), 'NoValue')
					        settings = [settings 'TITLE' el.getPropTag(prop)];
					    end
					    if isa(pr.getr('BKGCOLOR'), 'NoValue')
					        switch el.getPropCategory(prop)
					            case Category.CONSTANT
					                color = BRAPH2.COL_C;
					            case Category.METADATA
					                color = BRAPH2.COL_M;
					            case Category.PARAMETER
					                color = BRAPH2.COL_P;
					            case Category.DATA
					                color = BRAPH2.COL_D;
					            case Category.RESULT
					                color = BRAPH2.COL_R;
					            case Category.QUERY
					                color = BRAPH2.COL_Q;
					            case Category.EVANESCENT
					                color = BRAPH2.COL_E;
					            case Category.FIGURE
					                color = BRAPH2.COL_F;
					            case Category.GUI
					                color = BRAPH2.COL_G;
					        end
					        settings = [settings 'BKGCOLOR' color];
					    end
					    if ~isempty(settings)
					        pr.set(settings{:})
					    end
					end
					
				case PanelProp.HEIGHT % __PanelProp.HEIGHT__
					if pr.get('DRAWN')
					    pr.get('REDRAW')
					end
					
				otherwise
					if prop <= Panel.getPropNumber()
						postset@Panel(pr, prop);
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
				case PanelProp.X_DRAW % __PanelProp.X_DRAW__
					value = true;
					
				case PanelProp.UPDATE % __PanelProp.UPDATE__
					if pr.get('DRAWN')
					    switch pr.get('EL').getPropCategory(pr.get('PROP'))
					        case {Category.CONSTANT Category.METADATA} % {__Category.CONSTANT__ __Category.METADATA__}
					            %
					
					        case {Category.PARAMETER Category.DATA Category.FIGURE Category.GUI} % {__Category.PARAMETER__ __Category.DATA__ __Category.FIGURE__ __Category.GUI__}
					            prop_value = pr.get('EL').getr(pr.get('PROP'));
					            if isa(prop_value, 'Callback')
					                set(pr.get('BUTTON_CB'), ...
					                    'Tooltip', prop_value.get('TOSTRING'), ...
					                    'Visible', 'on' ...
					                    )
					            else
					                set(pr.get('BUTTON_CB'), ...
					                    'Visible', 'off' ...
					                    )
					            end
					
					        case {Category.RESULT Category.EVANESCENT} % {__Category.RESULT__ __Category.EVANESCENT__}
					            prop_value = pr.get('EL').getr(pr.get('PROP'));
					            if isa(prop_value, 'NoValue')
					                set(pr.get('BUTTON_CALC'), 'Enable', 'on')
					                set(pr.get('BUTTON_DEL'), 'Enable', 'off')
					            else
					                set(pr.get('BUTTON_CALC'), 'Enable', 'off')
					                set(pr.get('BUTTON_DEL'), 'Enable', 'on')
					            end
					            
					        case Category.QUERY % __Category.QUERY__
					            prop_value = get_from_varargin(pr.get('EL').getr(pr.get('PROP')), 'Value', varargin); % see BUTTON_CALC
					            if isa(prop_value, 'NoValue')
					                set(pr.get('BUTTON_CALC'), 'Enable', 'on')
					                set(pr.get('BUTTON_DEL'), 'Enable', 'off')
					            else
					                set(pr.get('BUTTON_CALC'), 'Enable', 'on')
					                set(pr.get('BUTTON_DEL'), 'Enable', 'on')
					            end
					            
					    end
					    
					    % resets the LISTENER_CB
					    pr.set('LISTENER_CB', Element.getNoValue())
					    pr.memorize('LISTENER_CB');
					    
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(pr)], ...
					        [BRAPH2.STR ':' class(pr) '\n' ...
					        'The call pr.get(''UPDATE'') has NOT been executed.\n' ...
					        'First, the prop panel ' pr.get('ID') ' should be drawn calling pr.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case PanelProp.REDRAW % __PanelProp.REDRAW__
					if pr.get('DRAWN')
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    h_p = pr.get('HEIGHT'); % should be identical to h(pr.get('H'), 'pixels') 
					                            % the panel height should be set to this value 
					                            % by some external code controlling the PanelProp
					    
					    % places label_title to the top
					    set(pr.get('LABEL_TITLE'), 'Position', [s(.3) h_p-s(1.3)+1 w_p s(1.3)])
					
					    % places the relevant buttons (depending on category)
					    switch pr.get('EL').getPropCategory(pr.get('PROP'))
					        case {Category.CONSTANT Category.METADATA} % {__Category.CONSTANT__ __Category.METADATA__}
					            %
					
					        case {Category.PARAMETER Category.DATA Category.FIGURE Category.GUI} % {__Category.PARAMETER__ __Category.DATA__ __Category.FIGURE__ __Category.GUI__}
					            set(pr.get('BUTTON_CB'), 'Position', [w_p-s(2.1) h_p-s(1.9) s(1.7) s(1.7)])
					
					        case {Category.RESULT Category.QUERY Category.EVANESCENT} % {__Category.RESULT__ __Category.QUERY__ __Category.EVANESCENT__}
					            set(pr.get('BUTTON_CALC'), 'Position', [w_p-s(4.2) h_p-s(1.9) s(1.7) s(1.7)])
					            set(pr.get('BUTTON_DEL'), 'Position', [w_p-s(2.1) h_p-s(1.9) s(1.7) s(1.7)])
					    end
					     
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(pr)], ...
					        [BRAPH2.STR ':' class(pr) '\n' ...
					        'The call pr.get(''REDRAW'') has NOT been executed.\n' ...
					        'First, the prop panel ' pr.get('ID') ' should be drawn calling pr.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case PanelProp.LABEL_TITLE % __PanelProp.LABEL_TITLE__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					pr_string_title = pr.get('TITLE');
					if isempty(pr_string_title)
					    pr_string_title = upper(el.getPropTag(prop));
					end
					
					label_title =  uilabel( ...
					    'Parent', pr.get('H'), ... % H = p for Panel
					    'Tag', 'LABEL_TAG', ...
					    'Text', pr_string_title, ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'HorizontalAlignment', 'left', ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'BackgroundColor', pr.get('BKGCOLOR') ...
					    );
					
					value = label_title;
					
				case PanelProp.BUTTON_CB % __PanelProp.BUTTON_CB__
					button_cb = uibutton( ...
					    'Parent', pr.get('H'), ... % H = p for Panel
					    'Tag', 'BUTTON_CB', ...
					    'Text', '@', ...
					    'FontWeight', 'bold', ...
					    'ButtonPushedFcn', {@cb_button_cb}, ...
					    'Interruptible', 'off', ...
					    'BusyAction', 'cancel' ...
					    );
					value = button_cb;
					
				case PanelProp.LISTENER_CB % __PanelProp.LISTENER_CB__
					el = pr.get('EL');
					prop = pr.get('PROP');
					if isa(el.getr(prop), 'Callback')
					    while isa(el.getr(prop), 'Callback')
					        cb = el.getr(prop);
					        el = cb.get('EL');
					        prop = cb.get('PROP');
					    end
					    value = listener(el, 'PropSet', @cb_listener_cb); 
					else
						value = gobjects(1);
					end
					
				case PanelProp.BUTTON_CALC % __PanelProp.BUTTON_CALC__
					button_calc = uibutton( ...
					    'Parent', pr.get('H'), ... % H = p for Panel
					    'Tag', 'BUTTON_CALC', ...
					    'Text', 'C', ...
					    'FontWeight', 'bold', ...
					    'Tooltip', 'Calculate', ...
					    'ButtonPushedFcn', {@cb_button_calc}, ...
					    'Interruptible', 'off', ...
					    'BusyAction', 'cancel' ...
					    );
					value = button_calc;
					
				case PanelProp.BUTTON_DEL % __PanelProp.BUTTON_DEL__
					button_del = uibutton( ...
					    'Parent', pr.get('H'), ... % H = p for Panel
					    'Tag', 'BUTTON_DEL', ...
					    'Text', 'D', ...
					    'FontWeight', 'bold', ...
					    'Tooltip', 'Delete', ...
					    'ButtonPushedFcn', {@cb_button_del}, ...
					    'Interruptible', 'off', ...
					    'BusyAction', 'cancel' ...
					    );
					value = button_del;
					
				case PanelProp.LISTENER_SET % __PanelProp.LISTENER_SET__
					value = {listener(pr.get('EL'), 'PropSet', @cb_listener_set)};
					
				case PanelProp.LISTENER_MEMORIZED % __PanelProp.LISTENER_MEMORIZED__
					value = {listener(pr.get('EL'), 'PropMemorized', @cb_listener_memorized)};
					
				case PanelProp.LISTENER_LOCKED % __PanelProp.LISTENER_LOCKED__
					value = {listener(pr.get('EL'), 'PropLocked', @cb_listener_locked)};
					
				case PanelProp.DRAW % __PanelProp.DRAW__
					value = calculateValue@Panel(pr, Panel.DRAW, varargin{:}); % also warning
					if value
					    switch pr.get('EL').getPropCategory(pr.get('PROP'))
					        case {Category.CONSTANT Category.METADATA} % {__Category.CONSTANT__ __Category.METADATA__}
					            pr.memorize('LABEL_TITLE')
					
					            pr.memorize('LISTENER_SET')
					            pr.memorize('LISTENER_LOCKED')
					
					        case {Category.PARAMETER Category.DATA Category.FIGURE Category.GUI} % {__Category.PARAMETER__ __Category.DATA__ __Category.FIGURE__ __Category.GUI__}
					            pr.memorize('LABEL_TITLE')
					
					            pr.memorize('BUTTON_CB')
					
					            pr.memorize('LISTENER_SET')
					            pr.memorize('LISTENER_LOCKED')
					
					        case {Category.RESULT Category.QUERY Category.EVANESCENT} % {__Category.RESULT__ __Category.QUERY__ __Category.EVANESCENT__}
					            pr.memorize('LABEL_TITLE')
					
					            pr.memorize('BUTTON_CALC')
					            pr.memorize('BUTTON_DEL')
					
					            pr.memorize('LISTENER_SET')
					            pr.memorize('LISTENER_MEMORIZED')
					            pr.memorize('LISTENER_LOCKED')
					    end
					
					    pr.get('X_DRAW')    
					    pr.get('UPDATE')
					    pr.get('REDRAW')
					end
					
				case PanelProp.SHOW % __PanelProp.SHOW__
					if pr.get('DRAWN')
					
					    calculateValue@Panel(pr, Panel.SHOW, varargin{:}); % Panel.SHOW = __Panel.SHOW__
					
					    % figure cb
					    if isa(pr.getr('GUI_CB'), 'GUI') && pr.get('GUI_CB').get('DRAWN')
					        pr.get('GUI_CB').get('SHOW')
					    end
					    
						value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(pr)], ...
					        [BRAPH2.STR ':' class(pr) '\n' ...
					        'The call pr.get(''SHOW'') has NOT been executed.\n' ...
					        'First, the panel ' pr.get('ID') ' should be drawn calling pr.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case PanelProp.HIDE % __PanelProp.HIDE__
					if pr.get('DRAWN')
					
					    calculateValue@Panel(pr, Panel.HIDE, varargin{:}); % Panel.HIDE = __Panel.HIDE__
					    
					    % figure cb
					    if isa(pr.getr('GUI_CB'), 'GUI') && pr.get('GUI_CB').get('DRAWN')
					        pr.get('GUI_CB').get('HIDE')
					    end
					    
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(pr)], ...
					        [BRAPH2.STR ':' class(pr) '\n' ...
					        'The call pr.get(''HIDE'') has NOT been executed.\n' ...
					        'First, the panel ' pr.get('ID') ' should be drawn calling pr.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				case PanelProp.DELETE % __PanelProp.DELETE__
					value = calculateValue@Panel(pr, Panel.DELETE, varargin{:}); % Panel.DELETE = __Panel.DELETE__ % also warning
					if value
					    pr.set('LABEL_TITLE', Element.getNoValue())
					    
					    pr.set('BUTTON_CB', Element.getNoValue())
					    pr.set('LISTENER_CB', Element.getNoValue())
					
					    pr.set('BUTTON_CALC', Element.getNoValue())
					    pr.set('BUTTON_DEL', Element.getNoValue())
					    
					    pr.set('LISTENER_SET', Element.getNoValue())
					    pr.set('LISTENER_MEMORIZED', Element.getNoValue())
					    pr.set('LISTENER_LOCKED', Element.getNoValue())   
					end
					
				case PanelProp.CLOSE % __PanelProp.CLOSE__
					if pr.get('DRAWN')
					
					    calculateValue@Panel(pr, Panel.CLOSE, varargin{:}); % Panel.CLOSE = __Panel.CLOSE__
					    
					    % figure cb
					    if isa(pr.getr('GUI_CB'), 'GUI') && pr.get('GUI_CB').get('DRAWN')
					        pr.get('GUI_CB').get('CLOSE')
					    end
					    
					    value = true;
					else
					    warning( ...
					        [BRAPH2.STR ':' class(pr)], ...
					        [BRAPH2.STR ':' class(pr) '\n' ...
					        'The call pr.get(''CLOSE'') has NOT been executed.\n' ...
					        'First, the panel ' pr.get('ID') ' should be drawn calling pr.get(''DRAW'').\n' ...
					        'Probably, not a big deal, but this shouldn''t happen with well-written code!'] ...
					        )
					    value = false;
					end
					
				otherwise
					if prop <= Panel.getPropNumber()
						value = calculateValue@Panel(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_button_cb(~, ~)
			    gui_cb = pr.memorize('GUI_CB');
			
			    if ~gui_cb.get('DRAWN')
			        gui_cb.get('DRAW')
			        gui_cb.get('SHOW')
			    else
			        if get(gui_cb.get('H'), 'Visible')
			            gui_cb.get('HIDE')
			        else
			            gui_cb.get('SHOW')
			        end
			    end
			end
			function cb_listener_cb(~, event)
			    if any(cellfun(@(prop) prop, event.props), pr.get('PROP'))
			        pr.get('UPDATE')
			    end
			end
			function cb_button_calc(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    switch el.getPropCategory(prop)
			        case {Category.RESULT Category.EVANESCENT}
			
			            el.memorize(prop);
			            
			            pr.get('UPDATE')
			            pr.get('REDRAW')
			            
			        case Category.QUERY
			            
			            value = el.get(prop);
			            
			            pr.get('UPDATE', 'Value', value)
			            pr.get('REDRAW')
			            
			    end
			end
			function cb_button_del(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.set(prop, NoValue.getNoValue())
			    
			    pr.get('UPDATE')
			    pr.get('REDRAW')    
			end
			function cb_listener_set(~, event)
			    if ismember(pr.get('PROP'), cell2mat(event.props)) && pr.get('DRAWN')
			        pr.get('UPDATE')
			        pr.get('REDRAW')        
			    end
			end
			function cb_listener_memorized(~, event)
			    if pr.get('PROP') == event.prop && pr.get('DRAWN')
			        pr.get('UPDATE')
			        pr.get('REDRAW')        
			    end
			end
			function cb_listener_locked(~, event)
			    if pr.get('PROP') == event.prop && pr.get('DRAWN')
			        pr.get('UPDATE')
			        pr.get('REDRAW')
			    end
			end
		end
	end
end
