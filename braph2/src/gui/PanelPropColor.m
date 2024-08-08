classdef PanelPropColor < PanelProp
	%PanelPropColor plots the panel of a property color.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Color Prop Panel (PanelPropColor) plots the panel for a COLOR property with a button.
	% It works for all categories.
	%
	% PanelPropColor methods (constructor):
	%  PanelPropColor - constructor
	%
	% PanelPropColor methods:
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
	% PanelPropColor methods (display):
	%  tostring - string with information about the color prop panel
	%  disp - displays information about the color prop panel
	%  tree - displays the tree of the color prop panel
	%
	% PanelPropColor methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two color prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the color prop panel
	%
	% PanelPropColor methods (save/load, Static):
	%  save - saves BRAPH2 color prop panel as b2 file
	%  load - loads a BRAPH2 color prop panel from a b2 file
	%
	% PanelPropColor method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the color prop panel
	%
	% PanelPropColor method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the color prop panel
	%
	% PanelPropColor methods (inspection, Static):
	%  getClass - returns the class of the color prop panel
	%  getSubclasses - returns all subclasses of PanelPropColor
	%  getProps - returns the property list of the color prop panel
	%  getPropNumber - returns the property number of the color prop panel
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
	% PanelPropColor methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropColor methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropColor methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropColor methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropColor; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropColor constants</a>.
	%
	%
	% See also uibutton, GUI, PanelElement.
	
	properties (Constant) % properties
		BUTTON = PanelProp.getPropNumber() + 1;
		BUTTON_TAG = 'BUTTON';
		BUTTON_CATEGORY = Category.EVANESCENT;
		BUTTON_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = PanelPropColor(varargin)
			%PanelPropColor() creates a color prop panel.
			%
			% PanelPropColor(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropColor(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the color prop panel.
			%
			% CLASS = PanelPropColor.GETCLASS() returns the class 'PanelPropColor'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the color prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropColor') returns 'PanelPropColor'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropColor')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropColor';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the color prop panel.
			%
			% LIST = PanelPropColor.GETSUBCLASSES() returns all subclasses of 'PanelPropColor'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the color prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropColor') returns all subclasses of 'PanelPropColor'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropColor')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelPropColor', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of color prop panel.
			%
			% PROPS = PanelPropColor.GETPROPS() returns the property list of color prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropColor.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the color prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropColor'[, CATEGORY]) returns the property list of 'PanelPropColor'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropColor')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						PanelPropColor.BUTTON ...
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
						PanelPropColor.BUTTON ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of color prop panel.
			%
			% N = PanelPropColor.GETPROPNUMBER() returns the property number of color prop panel.
			%
			% N = PanelPropColor.GETPROPNUMBER(CATEGORY) returns the property number of color prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the color prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropColor') returns the property number of 'PanelPropColor'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropColor')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelPropColor.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in color prop panel/error.
			%
			% CHECK = PanelPropColor.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropColor, PROP) checks whether PROP exists for PanelPropColor.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropColor:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropColor:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropColor:WrongInput]
			%  Element.EXISTSPROP(PanelPropColor, PROP) throws error if PROP does NOT exist for PanelPropColor.
			%   Error id: [BRAPH2:PanelPropColor:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropColor')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelPropColor.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropColor:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropColor:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropColor.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in color prop panel/error.
			%
			% CHECK = PanelPropColor.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropColor, TAG) checks whether TAG exists for PanelPropColor.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropColor:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropColor:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropColor:WrongInput]
			%  Element.EXISTSTAG(PanelPropColor, TAG) throws error if TAG does NOT exist for PanelPropColor.
			%   Error id: [BRAPH2:PanelPropColor:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropColor')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelpropcolor_tag_list = cellfun(@(x) PanelPropColor.getPropTag(x), num2cell(PanelPropColor.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelpropcolor_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropColor:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropColor:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropColor.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropColor, POINTER) returns property number of POINTER of PanelPropColor.
			%  PROPERTY = PR.GETPROPPROP(PanelPropColor, POINTER) returns property number of POINTER of PanelPropColor.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropColor')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelpropcolor_tag_list = cellfun(@(x) PanelPropColor.getPropTag(x), num2cell(PanelPropColor.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelpropcolor_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PanelPropColor, POINTER) returns tag of POINTER of PanelPropColor.
			%  TAG = PR.GETPROPTAG(PanelPropColor, POINTER) returns tag of POINTER of PanelPropColor.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropColor')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelPropColor.BUTTON
						tag = PanelPropColor.BUTTON_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropColor, POINTER) returns category of POINTER of PanelPropColor.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropColor, POINTER) returns category of POINTER of PanelPropColor.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropColor')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropColor.getPropProp(pointer);
			
			switch prop
				case PanelPropColor.BUTTON
					prop_category = PanelPropColor.BUTTON_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropColor, POINTER) returns format of POINTER of PanelPropColor.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropColor, POINTER) returns format of POINTER of PanelPropColor.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropColor')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropColor.getPropProp(pointer);
			
			switch prop
				case PanelPropColor.BUTTON
					prop_format = PanelPropColor.BUTTON_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropColor, POINTER) returns description of POINTER of PanelPropColor.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropColor, POINTER) returns description of POINTER of PanelPropColor.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropColor')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropColor.getPropProp(pointer);
			
			switch prop
				case PanelPropColor.BUTTON
					prop_description = 'BUTTON (evanescent, handle) is the color value button.';
				case PanelPropColor.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the color property panel.';
				case PanelPropColor.NAME
					prop_description = 'NAME (constant, string) is the name of the color property panel.';
				case PanelPropColor.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the color property panel.';
				case PanelPropColor.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the color property panel.';
				case PanelPropColor.ID
					prop_description = 'ID (data, string) is a few-letter code for the color property panel.';
				case PanelPropColor.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the color property panel.';
				case PanelPropColor.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the color property panel.';
				case PanelPropColor.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelPropColor.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PanelPropColor.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the property panel.';
				case PanelPropColor.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case PanelPropColor.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the button.';
				case PanelPropColor.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case PanelPropColor.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropColor, POINTER) returns settings of POINTER of PanelPropColor.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropColor, POINTER) returns settings of POINTER of PanelPropColor.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropColor')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropColor.getPropProp(pointer);
			
			switch prop
				case PanelPropColor.BUTTON
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropColor.TEMPLATE
					prop_settings = 'PanelPropColor';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropColor.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropColor.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropColor, POINTER) returns the default value of POINTER of PanelPropColor.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropColor, POINTER) returns the default value of POINTER of PanelPropColor.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropColor')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropColor.getPropProp(pointer);
			
			switch prop
				case PanelPropColor.BUTTON
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropColor.getPropSettings(prop));
				case PanelPropColor.ELCLASS
					prop_default = 'PanelPropColor';
				case PanelPropColor.NAME
					prop_default = 'Color Prop Panel';
				case PanelPropColor.DESCRIPTION
					prop_default = 'A Color Prop Panel (PanelPropColor) plots the panel for a COLOR property with a button. It works for all categories.';
				case PanelPropColor.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropColor.getPropSettings(prop));
				case PanelPropColor.ID
					prop_default = 'PanelPropColor ID';
				case PanelPropColor.LABEL
					prop_default = 'PanelPropColor label';
				case PanelPropColor.NOTES
					prop_default = 'PanelPropColor notes';
				case PanelPropColor.EL
					prop_default = PanelProp();
				case PanelPropColor.PROP
					prop_default = PanelProp.BKGCOLOR;
				case PanelPropColor.HEIGHT
					prop_default = s(4);
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropColor.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropColor.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropColor, POINTER) returns the conditioned default value of POINTER of PanelPropColor.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropColor, POINTER) returns the conditioned default value of POINTER of PanelPropColor.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropColor')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropColor.getPropProp(pointer);
			
			prop_default = PanelPropColor.conditioning(prop, PanelPropColor.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PanelPropColor, PROP, VALUE) checks VALUE format for PROP of PanelPropColor.
			%  CHECK = PR.CHECKPROP(PanelPropColor, PROP, VALUE) checks VALUE format for PROP of PanelPropColor.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelPropColor:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelPropColor:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelPropColor, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropColor.
			%   Error id: €BRAPH2.STR€:PanelPropColor:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelPropColor, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropColor.
			%   Error id: €BRAPH2.STR€:PanelPropColor:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropColor')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropColor.getPropProp(pointer);
			
			switch prop
				case PanelPropColor.BUTTON % __PanelPropColor.BUTTON__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropColor.getPropSettings(prop));
				case PanelPropColor.TEMPLATE % __PanelPropColor.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelPropColor.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropColor:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropColor:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropColor.getPropTag(prop) ' (' PanelPropColor.getFormatTag(PanelPropColor.getPropFormat(prop)) ').'] ...
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
				case PanelPropColor.BUTTON % __PanelPropColor.BUTTON__
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
					
				case PanelPropColor.X_DRAW % __PanelPropColor.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('BUTTON')
					end
					
				case PanelPropColor.UPDATE % __PanelPropColor.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    switch el.getPropCategory(prop)
					        case Category.CONSTANT
					            set(pr.get('BUTTON'), ...
					                'BackgroundColor', el.get(prop), ...
					                'Enable', 'off' ...
					                )
					            
					        case Category.METADATA
					            set(pr.get('BUTTON'), 'BackgroundColor', el.get(prop))
					
					            if el.isLocked(prop)
					                set(pr.get('BUTTON'), 'Enable', 'off')
					            end
					            
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('BUTTON'), 'BackgroundColor', el.get(prop))
					
					            prop_value = el.getr(prop);
					            if el.isLocked(prop) || isa(prop_value, 'Callback')
					                set(pr.get('BUTTON'), 'Enable', 'off')
					            end
					
					        case {Category.RESULT Category.QUERY Category.EVANESCENT}
					            prop_value = el.getr(prop);
					
					            if isa(prop_value, 'NoValue')
					                set(pr.get('BUTTON'), 'BackgroundColor', el.getPropDefault(prop))
					            else
					                set(pr.get('BUTTON'), 'BackgroundColor', el.get(prop))
					            end
					            
					            set(pr.get('BUTTON'), 'Enable', 'off')
					    end
					end
					
				case PanelPropColor.REDRAW % __PanelPropColor.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('BUTTON'), 'Position', [s(.3) s(.3) .70*w_p s(1.75)])
					end
					
				case PanelPropColor.DELETE % __PanelPropColor.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('BUTTON', Element.getNoValue())
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_button(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    new_color = uisetcolor(el.get(prop));
			    if ~isequal(new_color, el.get(prop))
			        el.set(prop, new_color)
			    end
			end
		end
	end
end
