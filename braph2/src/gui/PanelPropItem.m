classdef PanelPropItem < PanelProp
	%PanelPropItem plots the panel of a property item.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% An Item Prop Panel (PanelPropItem) plots the panel for a ITEM property with a button.
	% It works for all categories. 
	% 
	% The property GUICLASS determines whether the item figure is a 'GUIElement' or 'GUIFig'.
	%
	% PanelPropItem methods (constructor):
	%  PanelPropItem - constructor
	%
	% PanelPropItem methods:
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
	% PanelPropItem methods (display):
	%  tostring - string with information about the item prop panel
	%  disp - displays information about the item prop panel
	%  tree - displays the tree of the item prop panel
	%
	% PanelPropItem methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two item prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the item prop panel
	%
	% PanelPropItem methods (save/load, Static):
	%  save - saves BRAPH2 item prop panel as b2 file
	%  load - loads a BRAPH2 item prop panel from a b2 file
	%
	% PanelPropItem method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the item prop panel
	%
	% PanelPropItem method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the item prop panel
	%
	% PanelPropItem methods (inspection, Static):
	%  getClass - returns the class of the item prop panel
	%  getSubclasses - returns all subclasses of PanelPropItem
	%  getProps - returns the property list of the item prop panel
	%  getPropNumber - returns the property number of the item prop panel
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
	% PanelPropItem methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropItem methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropItem methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropItem methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropItem; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropItem constants</a>.
	%
	%
	% See also uibutton, GUI, PanelElement, GUIElement, GUIFig.
	
	properties (Constant) % properties
		BUTTON_TEXT = PanelProp.getPropNumber() + 1;
		BUTTON_TEXT_TAG = 'BUTTON_TEXT';
		BUTTON_TEXT_CATEGORY = Category.GUI;
		BUTTON_TEXT_FORMAT = Format.STRING;
		
		BUTTON = PanelProp.getPropNumber() + 2;
		BUTTON_TAG = 'BUTTON';
		BUTTON_CATEGORY = Category.EVANESCENT;
		BUTTON_FORMAT = Format.HANDLE;
		
		GUICLASS = PanelProp.getPropNumber() + 3;
		GUICLASS_TAG = 'GUICLASS';
		GUICLASS_CATEGORY = Category.GUI;
		GUICLASS_FORMAT = Format.OPTION;
		
		GUI_ITEM = PanelProp.getPropNumber() + 4;
		GUI_ITEM_TAG = 'GUI_ITEM';
		GUI_ITEM_CATEGORY = Category.DATA;
		GUI_ITEM_FORMAT = Format.ITEM;
	end
	methods % constructor
		function pr = PanelPropItem(varargin)
			%PanelPropItem() creates a item prop panel.
			%
			% PanelPropItem(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropItem(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the item prop panel.
			%
			% CLASS = PanelPropItem.GETCLASS() returns the class 'PanelPropItem'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the item prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropItem') returns 'PanelPropItem'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropItem')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropItem';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the item prop panel.
			%
			% LIST = PanelPropItem.GETSUBCLASSES() returns all subclasses of 'PanelPropItem'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the item prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropItem') returns all subclasses of 'PanelPropItem'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropItem')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelPropItem', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of item prop panel.
			%
			% PROPS = PanelPropItem.GETPROPS() returns the property list of item prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropItem.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the item prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropItem'[, CATEGORY]) returns the property list of 'PanelPropItem'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropItem')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						PanelPropItem.BUTTON_TEXT ...
						PanelPropItem.BUTTON ...
						PanelPropItem.GUICLASS ...
						PanelPropItem.GUI_ITEM ...
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
						PanelPropItem.GUI_ITEM ...
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
						PanelPropItem.BUTTON ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						PanelPropItem.BUTTON_TEXT ...
						PanelPropItem.GUICLASS ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of item prop panel.
			%
			% N = PanelPropItem.GETPROPNUMBER() returns the property number of item prop panel.
			%
			% N = PanelPropItem.GETPROPNUMBER(CATEGORY) returns the property number of item prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the item prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropItem') returns the property number of 'PanelPropItem'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropItem')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelPropItem.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in item prop panel/error.
			%
			% CHECK = PanelPropItem.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropItem, PROP) checks whether PROP exists for PanelPropItem.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropItem:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropItem:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropItem:WrongInput]
			%  Element.EXISTSPROP(PanelPropItem, PROP) throws error if PROP does NOT exist for PanelPropItem.
			%   Error id: [BRAPH2:PanelPropItem:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropItem')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelPropItem.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropItem:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropItem:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropItem.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in item prop panel/error.
			%
			% CHECK = PanelPropItem.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropItem, TAG) checks whether TAG exists for PanelPropItem.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropItem:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropItem:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropItem:WrongInput]
			%  Element.EXISTSTAG(PanelPropItem, TAG) throws error if TAG does NOT exist for PanelPropItem.
			%   Error id: [BRAPH2:PanelPropItem:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropItem')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelpropitem_tag_list = cellfun(@(x) PanelPropItem.getPropTag(x), num2cell(PanelPropItem.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelpropitem_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropItem:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropItem:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropItem.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropItem, POINTER) returns property number of POINTER of PanelPropItem.
			%  PROPERTY = PR.GETPROPPROP(PanelPropItem, POINTER) returns property number of POINTER of PanelPropItem.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropItem')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelpropitem_tag_list = cellfun(@(x) PanelPropItem.getPropTag(x), num2cell(PanelPropItem.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelpropitem_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PanelPropItem, POINTER) returns tag of POINTER of PanelPropItem.
			%  TAG = PR.GETPROPTAG(PanelPropItem, POINTER) returns tag of POINTER of PanelPropItem.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropItem')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelPropItem.BUTTON_TEXT
						tag = PanelPropItem.BUTTON_TEXT_TAG;
					case PanelPropItem.BUTTON
						tag = PanelPropItem.BUTTON_TAG;
					case PanelPropItem.GUICLASS
						tag = PanelPropItem.GUICLASS_TAG;
					case PanelPropItem.GUI_ITEM
						tag = PanelPropItem.GUI_ITEM_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropItem, POINTER) returns category of POINTER of PanelPropItem.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropItem, POINTER) returns category of POINTER of PanelPropItem.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropItem')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropItem.getPropProp(pointer);
			
			switch prop
				case PanelPropItem.BUTTON_TEXT
					prop_category = PanelPropItem.BUTTON_TEXT_CATEGORY;
				case PanelPropItem.BUTTON
					prop_category = PanelPropItem.BUTTON_CATEGORY;
				case PanelPropItem.GUICLASS
					prop_category = PanelPropItem.GUICLASS_CATEGORY;
				case PanelPropItem.GUI_ITEM
					prop_category = PanelPropItem.GUI_ITEM_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropItem, POINTER) returns format of POINTER of PanelPropItem.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropItem, POINTER) returns format of POINTER of PanelPropItem.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropItem')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropItem.getPropProp(pointer);
			
			switch prop
				case PanelPropItem.BUTTON_TEXT
					prop_format = PanelPropItem.BUTTON_TEXT_FORMAT;
				case PanelPropItem.BUTTON
					prop_format = PanelPropItem.BUTTON_FORMAT;
				case PanelPropItem.GUICLASS
					prop_format = PanelPropItem.GUICLASS_FORMAT;
				case PanelPropItem.GUI_ITEM
					prop_format = PanelPropItem.GUI_ITEM_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropItem, POINTER) returns description of POINTER of PanelPropItem.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropItem, POINTER) returns description of POINTER of PanelPropItem.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropItem')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropItem.getPropProp(pointer);
			
			switch prop
				case PanelPropItem.BUTTON_TEXT
					prop_description = 'BUTTON_TEXT (gui, string) is the button text.';
				case PanelPropItem.BUTTON
					prop_description = 'BUTTON (evanescent, handle) is the logical value dropdown.';
				case PanelPropItem.GUICLASS
					prop_description = 'GUICLASS (gui, option) is the GUI kind.';
				case PanelPropItem.GUI_ITEM
					prop_description = 'GUI_ITEM (data, item) is the handle to the item figure.';
				case PanelPropItem.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the item property panel.';
				case PanelPropItem.NAME
					prop_description = 'NAME (constant, string) is the name of the item property panel.';
				case PanelPropItem.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the item property panel.';
				case PanelPropItem.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the item property panel.';
				case PanelPropItem.ID
					prop_description = 'ID (data, string) is a few-letter code for the item property panel.';
				case PanelPropItem.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the item property panel.';
				case PanelPropItem.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the item property panel.';
				case PanelPropItem.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelPropItem.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PanelPropItem.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the property panel.';
				case PanelPropItem.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case PanelPropItem.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the button.';
				case PanelPropItem.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case PanelPropItem.SHOW
					prop_description = 'SHOW (query, logical) shows the figure containing the panel and, possibly, the item figure.';
				case PanelPropItem.HIDE
					prop_description = 'HIDE (query, logical) hides the figure containing the panel and, possibly, the item figure.';
				case PanelPropItem.DELETE
					prop_description = 'DELETE (query, logical) resets the handles and closes the dependent figures when the panel is deleted.';
				case PanelPropItem.CLOSE
					prop_description = 'CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figure.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropItem, POINTER) returns settings of POINTER of PanelPropItem.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropItem, POINTER) returns settings of POINTER of PanelPropItem.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropItem')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropItem.getPropProp(pointer);
			
			switch prop
				case PanelPropItem.BUTTON_TEXT
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PanelPropItem.BUTTON
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropItem.GUICLASS
					prop_settings = {'GUIElement', 'GUIFig'};
				case PanelPropItem.GUI_ITEM
					prop_settings = 'GUI';
				case PanelPropItem.TEMPLATE
					prop_settings = 'PanelPropItem';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropItem.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropItem.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropItem, POINTER) returns the default value of POINTER of PanelPropItem.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropItem, POINTER) returns the default value of POINTER of PanelPropItem.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropItem')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropItem.getPropProp(pointer);
			
			switch prop
				case PanelPropItem.BUTTON_TEXT
					prop_default = Format.getFormatDefault(Format.STRING, PanelPropItem.getPropSettings(prop));
				case PanelPropItem.BUTTON
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropItem.getPropSettings(prop));
				case PanelPropItem.GUICLASS
					prop_default = Format.getFormatDefault(Format.OPTION, PanelPropItem.getPropSettings(prop));
				case PanelPropItem.GUI_ITEM
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropItem.getPropSettings(prop));
				case PanelPropItem.ELCLASS
					prop_default = 'PanelPropItem';
				case PanelPropItem.NAME
					prop_default = 'Item Prop Panel';
				case PanelPropItem.DESCRIPTION
					prop_default = 'An Item Prop Panel (PanelPropItem) plots the panel for a ITEM property with a button. It works for all categories. The property GUICLASS determines whether the item figure is a ''GUIElement'' or ''GUIFig''.';
				case PanelPropItem.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropItem.getPropSettings(prop));
				case PanelPropItem.ID
					prop_default = 'PanelPropItem ID';
				case PanelPropItem.LABEL
					prop_default = 'PanelPropItem label';
				case PanelPropItem.NOTES
					prop_default = 'PanelPropItem notes';
				case PanelPropItem.EL
					prop_default = PanelProp();
				case PanelPropItem.PROP
					prop_default = PanelProp.EL;
				case PanelPropItem.HEIGHT
					prop_default = s(4);
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropItem.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropItem.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropItem, POINTER) returns the conditioned default value of POINTER of PanelPropItem.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropItem, POINTER) returns the conditioned default value of POINTER of PanelPropItem.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropItem')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropItem.getPropProp(pointer);
			
			prop_default = PanelPropItem.conditioning(prop, PanelPropItem.getPropDefault(prop));
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
				case PanelPropItem.GUI_ITEM % __PanelPropItem.GUI_ITEM__
					if isequal(value.getClass(), 'GUI') % i.e., default initialization
					    switch pr.get('GUICLASS')
					        case 'GUIElement'
					            f = ancestor(pr.get('H'), 'figure');
					            
					            el = pr.get('EL');
					            prop = pr.get('PROP');
					
					            value = GUIElement( ...
					                'PE', el.memorize(prop), ... % ensure that the prop is stored
					                'POSITION', [ ...
					                    x0(f, 'normalized')+w(f, 'normalized') ...
					                    y0(f, 'normalized') ...
					                    w(f, 'normalized') ...
					                    h(f, 'normalized') ...
					                    ], ...
					                'WAITBAR', pr.getCallback('WAITBAR'), ...
					                'CLOSEREQ', false ...
					                );
					        case 'GUIFig'
					            f = ancestor(pr.get('H'), 'figure');
					
					            el = pr.get('EL');
					            prop = pr.get('PROP');
					
					            value = GUIFig( ...
					                'PF', el.memorize(prop), ... % ensure that the prop is stored
					                'POSITION', [ ...
					                    x0(f, 'normalized')+w(f, 'normalized') ...
					                    y0(f, 'normalized') ...
					                    w(0,'normalized')-x0(f, 'normalized')-w(f, 'normalized') ...
					                    h(f, 'normalized') ...
					                    ], ...
					                'WAITBAR', pr.getCallback('WAITBAR'), ...
					                'CLOSEREQ', false ...
					                );
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
			%  CHECK = Element.CHECKPROP(PanelPropItem, PROP, VALUE) checks VALUE format for PROP of PanelPropItem.
			%  CHECK = PR.CHECKPROP(PanelPropItem, PROP, VALUE) checks VALUE format for PROP of PanelPropItem.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelPropItem:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelPropItem:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelPropItem, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropItem.
			%   Error id: €BRAPH2.STR€:PanelPropItem:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelPropItem, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropItem.
			%   Error id: €BRAPH2.STR€:PanelPropItem:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropItem')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropItem.getPropProp(pointer);
			
			switch prop
				case PanelPropItem.BUTTON_TEXT % __PanelPropItem.BUTTON_TEXT__
					check = Format.checkFormat(Format.STRING, value, PanelPropItem.getPropSettings(prop));
				case PanelPropItem.BUTTON % __PanelPropItem.BUTTON__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropItem.getPropSettings(prop));
				case PanelPropItem.GUICLASS % __PanelPropItem.GUICLASS__
					check = Format.checkFormat(Format.OPTION, value, PanelPropItem.getPropSettings(prop));
				case PanelPropItem.GUI_ITEM % __PanelPropItem.GUI_ITEM__
					check = Format.checkFormat(Format.ITEM, value, PanelPropItem.getPropSettings(prop));
				case PanelPropItem.TEMPLATE % __PanelPropItem.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelPropItem.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropItem:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropItem:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropItem.getPropTag(prop) ' (' PanelPropItem.getFormatTag(PanelPropItem.getPropFormat(prop)) ').'] ...
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
				case PanelPropItem.BUTTON % __PanelPropItem.BUTTON__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					button = uibutton( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'BUTTON', ...
					    'Text', '', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ButtonPushedFcn', {@cb_button}, ...
					    'Interruptible', 'off', ...
					    'BusyAction', 'cancel' ...
					    );
					
					value = button;
					
				case PanelPropItem.X_DRAW % __PanelPropItem.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('BUTTON')
					end
					
				case PanelPropItem.UPDATE % __PanelPropItem.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    if ~isa(pr.getr('BUTTON_TEXT'), 'NoValue')
					        button_text = pr.get('BUTTON_TEXT');
					    else % isa(pr.getr('BUTTON_TEXT'), 'NoValue')
					        if isa(el.getr(prop), 'NoValue')
					            button_text = el.getPropDefault(prop).get('TOSTRING');
					        else
					            button_text = el.get(prop).get('TOSTRING');
					        end
					    end
					    
					    switch el.getPropCategory(prop)
					        case {Category.CONSTANT, Category.METADATA, Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('BUTTON'), ...
					                'Text', button_text, ...
					                'Tooltip', regexprep(el.get(prop).tree(), {'<strong>', '</strong>'}, {'' ''}) ...
					                )
					        
					        case {Category.RESULT Category.QUERY Category.EVANESCENT}
					            if isa(el.getr(prop), 'NoValue')
					                set(pr.get('BUTTON'), ...
					                    'Text', button_text, ...
					                    'Tooltip', regexprep(el.getPropDefault(prop).tree(), {'<strong>', '</strong>'}, {'' ''}), ...
					                    'Enable', 'off' ...
					                    )
					            else
					                set(pr.get('BUTTON'), ...
					                    'Text', button_text, ...
					                    'Tooltip', regexprep(el.get(prop).tree(), {'<strong>', '</strong>'}, {'' ''}), ...
					                    'Enable', 'on' ...
					                    )
					            end
					    end
					end
					
				case PanelPropItem.REDRAW % __PanelPropItem.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('BUTTON'), 'Position', [s(.3) s(.3) .70*w_p s(1.75)])
					end
					
				case PanelPropItem.SHOW % __PanelPropItem.SHOW__
					value = calculateValue@PanelProp(pr, PanelProp.SHOW, varargin{:}); % also warning
					if value
					    % figure item
					    if isa(pr.getr('GUI_ITEM'), 'GUI') && pr.get('GUI_ITEM').get('DRAWN')
					        pr.get('GUI_ITEM').get('SHOW')
					    end
					end
					
				case PanelPropItem.HIDE % __PanelPropItem.HIDE__
					value = calculateValue@PanelProp(pr, PanelProp.HIDE, varargin{:}); % also warning
					if value
					    % figure item
					    if isa(pr.getr('GUI_ITEM'), 'GUI') && pr.get('GUI_ITEM').get('DRAWN')
					        pr.get('GUI_ITEM').get('HIDE')
					    end
					end
					
				case PanelPropItem.DELETE % __PanelPropItem.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('BUTTON', Element.getNoValue())
					end
					
				case PanelPropItem.CLOSE % __PanelPropItem.CLOSE__
					value = calculateValue@PanelProp(pr, PanelProp.CLOSE, varargin{:}); % also warning
					if value
					    % figure item
					    if isa(pr.getr('GUI_ITEM'), 'GUI') && pr.get('GUI_ITEM').get('DRAWN')
					        pr.get('GUI_ITEM').get('CLOSE')
					    end
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_button(~, ~)
			    gui_item = pr.memorize('GUI_ITEM');
			
			    if ~gui_item.get('DRAWN')
			        gui_item.get('DRAW')
			        gui_item.get('SHOW')
			    else
			        if get(gui_item.get('H'), 'Visible')
			            gui_item.get('HIDE')
			        else
			            gui_item.get('SHOW')
			        end
			    end
			end
		end
	end
end
