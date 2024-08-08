classdef PanelPropIDict < PanelProp
	%PanelPropIDict plots the panel of a property idict.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% An Indexed-Dictionary Prop Panel (PanelPropIDict) plots the panel for a IDICT property with a button.
	%  It works for all categories.
	%
	% PanelPropIDict methods (constructor):
	%  PanelPropIDict - constructor
	%
	% PanelPropIDict methods:
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
	% PanelPropIDict methods (display):
	%  tostring - string with information about the idict prop panel
	%  disp - displays information about the idict prop panel
	%  tree - displays the tree of the idict prop panel
	%
	% PanelPropIDict methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two idict prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the idict prop panel
	%
	% PanelPropIDict methods (save/load, Static):
	%  save - saves BRAPH2 idict prop panel as b2 file
	%  load - loads a BRAPH2 idict prop panel from a b2 file
	%
	% PanelPropIDict method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the idict prop panel
	%
	% PanelPropIDict method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the idict prop panel
	%
	% PanelPropIDict methods (inspection, Static):
	%  getClass - returns the class of the idict prop panel
	%  getSubclasses - returns all subclasses of PanelPropIDict
	%  getProps - returns the property list of the idict prop panel
	%  getPropNumber - returns the property number of the idict prop panel
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
	% PanelPropIDict methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropIDict methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropIDict methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropIDict methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropIDict; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropIDict constants</a>.
	%
	%
	% See also uibutton, GUI, PanelElement, GUIElement.
	
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
		function pr = PanelPropIDict(varargin)
			%PanelPropIDict() creates a idict prop panel.
			%
			% PanelPropIDict(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropIDict(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the idict prop panel.
			%
			% CLASS = PanelPropIDict.GETCLASS() returns the class 'PanelPropIDict'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the idict prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropIDict') returns 'PanelPropIDict'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropIDict')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropIDict';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the idict prop panel.
			%
			% LIST = PanelPropIDict.GETSUBCLASSES() returns all subclasses of 'PanelPropIDict'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the idict prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropIDict') returns all subclasses of 'PanelPropIDict'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelPropIDict', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of idict prop panel.
			%
			% PROPS = PanelPropIDict.GETPROPS() returns the property list of idict prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropIDict.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the idict prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropIDict'[, CATEGORY]) returns the property list of 'PanelPropIDict'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						PanelPropIDict.BUTTON_TEXT ...
						PanelPropIDict.BUTTON ...
						PanelPropIDict.GUICLASS ...
						PanelPropIDict.GUI_ITEM ...
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
						PanelPropIDict.GUI_ITEM ...
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
						PanelPropIDict.BUTTON ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						PanelPropIDict.BUTTON_TEXT ...
						PanelPropIDict.GUICLASS ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of idict prop panel.
			%
			% N = PanelPropIDict.GETPROPNUMBER() returns the property number of idict prop panel.
			%
			% N = PanelPropIDict.GETPROPNUMBER(CATEGORY) returns the property number of idict prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the idict prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropIDict') returns the property number of 'PanelPropIDict'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelPropIDict.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in idict prop panel/error.
			%
			% CHECK = PanelPropIDict.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropIDict, PROP) checks whether PROP exists for PanelPropIDict.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropIDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropIDict:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropIDict:WrongInput]
			%  Element.EXISTSPROP(PanelPropIDict, PROP) throws error if PROP does NOT exist for PanelPropIDict.
			%   Error id: [BRAPH2:PanelPropIDict:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelPropIDict.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropIDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropIDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropIDict.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in idict prop panel/error.
			%
			% CHECK = PanelPropIDict.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropIDict, TAG) checks whether TAG exists for PanelPropIDict.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropIDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropIDict:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropIDict:WrongInput]
			%  Element.EXISTSTAG(PanelPropIDict, TAG) throws error if TAG does NOT exist for PanelPropIDict.
			%   Error id: [BRAPH2:PanelPropIDict:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelpropidict_tag_list = cellfun(@(x) PanelPropIDict.getPropTag(x), num2cell(PanelPropIDict.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelpropidict_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropIDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropIDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropIDict.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropIDict, POINTER) returns property number of POINTER of PanelPropIDict.
			%  PROPERTY = PR.GETPROPPROP(PanelPropIDict, POINTER) returns property number of POINTER of PanelPropIDict.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelpropidict_tag_list = cellfun(@(x) PanelPropIDict.getPropTag(x), num2cell(PanelPropIDict.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelpropidict_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PanelPropIDict, POINTER) returns tag of POINTER of PanelPropIDict.
			%  TAG = PR.GETPROPTAG(PanelPropIDict, POINTER) returns tag of POINTER of PanelPropIDict.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelPropIDict.BUTTON_TEXT
						tag = PanelPropIDict.BUTTON_TEXT_TAG;
					case PanelPropIDict.BUTTON
						tag = PanelPropIDict.BUTTON_TAG;
					case PanelPropIDict.GUICLASS
						tag = PanelPropIDict.GUICLASS_TAG;
					case PanelPropIDict.GUI_ITEM
						tag = PanelPropIDict.GUI_ITEM_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropIDict, POINTER) returns category of POINTER of PanelPropIDict.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropIDict, POINTER) returns category of POINTER of PanelPropIDict.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropIDict.getPropProp(pointer);
			
			switch prop
				case PanelPropIDict.BUTTON_TEXT
					prop_category = PanelPropIDict.BUTTON_TEXT_CATEGORY;
				case PanelPropIDict.BUTTON
					prop_category = PanelPropIDict.BUTTON_CATEGORY;
				case PanelPropIDict.GUICLASS
					prop_category = PanelPropIDict.GUICLASS_CATEGORY;
				case PanelPropIDict.GUI_ITEM
					prop_category = PanelPropIDict.GUI_ITEM_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropIDict, POINTER) returns format of POINTER of PanelPropIDict.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropIDict, POINTER) returns format of POINTER of PanelPropIDict.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropIDict.getPropProp(pointer);
			
			switch prop
				case PanelPropIDict.BUTTON_TEXT
					prop_format = PanelPropIDict.BUTTON_TEXT_FORMAT;
				case PanelPropIDict.BUTTON
					prop_format = PanelPropIDict.BUTTON_FORMAT;
				case PanelPropIDict.GUICLASS
					prop_format = PanelPropIDict.GUICLASS_FORMAT;
				case PanelPropIDict.GUI_ITEM
					prop_format = PanelPropIDict.GUI_ITEM_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropIDict, POINTER) returns description of POINTER of PanelPropIDict.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropIDict, POINTER) returns description of POINTER of PanelPropIDict.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropIDict.getPropProp(pointer);
			
			switch prop
				case PanelPropIDict.BUTTON_TEXT
					prop_description = 'BUTTON_TEXT (gui, string) is the button text.';
				case PanelPropIDict.BUTTON
					prop_description = 'BUTTON (evanescent, handle) is the logical value dropdown.';
				case PanelPropIDict.GUICLASS
					prop_description = 'GUICLASS (gui, option) is the GUI kind.';
				case PanelPropIDict.GUI_ITEM
					prop_description = 'GUI_ITEM (data, item) is the handle to the item figure.';
				case PanelPropIDict.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the idict property panel.';
				case PanelPropIDict.NAME
					prop_description = 'NAME (constant, string) is the name of the idict property panel.';
				case PanelPropIDict.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the idict property panel.';
				case PanelPropIDict.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the idict property panel.';
				case PanelPropIDict.ID
					prop_description = 'ID (data, string) is a few-letter code for the idict property panel.';
				case PanelPropIDict.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the idict property panel.';
				case PanelPropIDict.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the idict property panel.';
				case PanelPropIDict.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelPropIDict.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PanelPropIDict.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the property panel.';
				case PanelPropIDict.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case PanelPropIDict.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the button.';
				case PanelPropIDict.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case PanelPropIDict.SHOW
					prop_description = 'SHOW (query, logical) shows the figure containing the panel and, possibly, the item figure.';
				case PanelPropIDict.HIDE
					prop_description = 'HIDE (query, logical) hides the figure containing the panel and, possibly, the item figure.';
				case PanelPropIDict.DELETE
					prop_description = 'DELETE (query, logical) resets the handles and closes the dependent figures when the panel is deleted.';
				case PanelPropIDict.CLOSE
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropIDict, POINTER) returns settings of POINTER of PanelPropIDict.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropIDict, POINTER) returns settings of POINTER of PanelPropIDict.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropIDict.getPropProp(pointer);
			
			switch prop
				case PanelPropIDict.BUTTON_TEXT
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PanelPropIDict.BUTTON
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropIDict.GUICLASS
					prop_settings = {'GUIElement', 'GUIFig'};
				case PanelPropIDict.GUI_ITEM
					prop_settings = 'GUIElement';
				case PanelPropIDict.TEMPLATE
					prop_settings = 'PanelPropIDict';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropIDict.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropIDict.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropIDict, POINTER) returns the default value of POINTER of PanelPropIDict.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropIDict, POINTER) returns the default value of POINTER of PanelPropIDict.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropIDict.getPropProp(pointer);
			
			switch prop
				case PanelPropIDict.BUTTON_TEXT
					prop_default = Format.getFormatDefault(Format.STRING, PanelPropIDict.getPropSettings(prop));
				case PanelPropIDict.BUTTON
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropIDict.getPropSettings(prop));
				case PanelPropIDict.GUICLASS
					prop_default = Format.getFormatDefault(Format.OPTION, PanelPropIDict.getPropSettings(prop));
				case PanelPropIDict.GUI_ITEM
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropIDict.getPropSettings(prop));
				case PanelPropIDict.ELCLASS
					prop_default = 'PanelPropIDict';
				case PanelPropIDict.NAME
					prop_default = 'Indexed-Dictionary Prop Panel';
				case PanelPropIDict.DESCRIPTION
					prop_default = 'An Indexed-Dictionary Prop Panel (PanelPropIDict) plots the panel for a IDICT property with a button. It works for all categories.';
				case PanelPropIDict.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropIDict.getPropSettings(prop));
				case PanelPropIDict.ID
					prop_default = 'PanelPropIDict ID';
				case PanelPropIDict.LABEL
					prop_default = 'PanelPropIDict label';
				case PanelPropIDict.NOTES
					prop_default = 'PanelPropIDict notes';
				case PanelPropIDict.EL
					prop_default = Pipeline();
				case PanelPropIDict.PROP
					prop_default = Pipeline.PS_DICT;
				case PanelPropIDict.HEIGHT
					prop_default = s(4);
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropIDict.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropIDict.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropIDict, POINTER) returns the conditioned default value of POINTER of PanelPropIDict.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropIDict, POINTER) returns the conditioned default value of POINTER of PanelPropIDict.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropIDict.getPropProp(pointer);
			
			prop_default = PanelPropIDict.conditioning(prop, PanelPropIDict.getPropDefault(prop));
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
				case PanelPropIDict.GUI_ITEM % __PanelPropIDict.GUI_ITEM__
					if isa(value.getr('PE'), 'NoValue') % i.e., default initialization
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
			%  CHECK = Element.CHECKPROP(PanelPropIDict, PROP, VALUE) checks VALUE format for PROP of PanelPropIDict.
			%  CHECK = PR.CHECKPROP(PanelPropIDict, PROP, VALUE) checks VALUE format for PROP of PanelPropIDict.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelPropIDict:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelPropIDict:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelPropIDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropIDict.
			%   Error id: €BRAPH2.STR€:PanelPropIDict:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelPropIDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropIDict.
			%   Error id: €BRAPH2.STR€:PanelPropIDict:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropIDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropIDict.getPropProp(pointer);
			
			switch prop
				case PanelPropIDict.BUTTON_TEXT % __PanelPropIDict.BUTTON_TEXT__
					check = Format.checkFormat(Format.STRING, value, PanelPropIDict.getPropSettings(prop));
				case PanelPropIDict.BUTTON % __PanelPropIDict.BUTTON__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropIDict.getPropSettings(prop));
				case PanelPropIDict.GUICLASS % __PanelPropIDict.GUICLASS__
					check = Format.checkFormat(Format.OPTION, value, PanelPropIDict.getPropSettings(prop));
				case PanelPropIDict.GUI_ITEM % __PanelPropIDict.GUI_ITEM__
					check = Format.checkFormat(Format.ITEM, value, PanelPropIDict.getPropSettings(prop));
				case PanelPropIDict.TEMPLATE % __PanelPropIDict.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelPropIDict.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropIDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropIDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropIDict.getPropTag(prop) ' (' PanelPropIDict.getFormatTag(PanelPropIDict.getPropFormat(prop)) ').'] ...
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
				case PanelPropIDict.BUTTON % __PanelPropIDict.BUTTON__
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
					
				case PanelPropIDict.X_DRAW % __PanelPropIDict.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('BUTTON')
					end
					
				case PanelPropIDict.UPDATE % __PanelPropIDict.UPDATE__
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
					    
					    value = true;
					end
					
				case PanelPropIDict.REDRAW % __PanelPropIDict.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('BUTTON'), 'Position', [s(.3) s(.3) .70*w_p s(1.75)])
					end
					
				case PanelPropIDict.SHOW % __PanelPropIDict.SHOW__
					value = calculateValue@PanelProp(pr, PanelProp.SHOW, varargin{:}); % also warning
					if value
					    % figure item
					    if isa(pr.getr('GUI_ITEM'), 'GUI') && pr.get('GUI_ITEM').get('DRAWN')
					        pr.get('GUI_ITEM').get('SHOW')
					    end
					end
					
				case PanelPropIDict.HIDE % __PanelPropIDict.HIDE__
					value = calculateValue@PanelProp(pr, PanelProp.HIDE, varargin{:}); % also warning
					if value
					    % figure item
					    if isa(pr.getr('GUI_ITEM'), 'GUI') && pr.get('GUI_ITEM').get('DRAWN')
					        pr.get('GUI_ITEM').get('HIDE')
					    end
					end
					
				case PanelPropIDict.DELETE % __PanelPropIDict.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value    
					    pr.set('BUTTON', Element.getNoValue())
					end
					
				case PanelPropIDict.CLOSE % __PanelPropIDict.CLOSE__
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
