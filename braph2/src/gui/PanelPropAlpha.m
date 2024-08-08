classdef PanelPropAlpha < PanelProp
	%PanelPropAlpha plots the panel of a property alpha.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% An Alpha Property Panel (PanelPropAlpha) plots the panel for an ALPHA property 
	%  with a numeric edit field and a slider.
	% It works for all categories.
	%
	% PanelPropAlpha methods (constructor):
	%  PanelPropAlpha - constructor
	%
	% PanelPropAlpha methods:
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
	% PanelPropAlpha methods (display):
	%  tostring - string with information about the alpha prop panel
	%  disp - displays information about the alpha prop panel
	%  tree - displays the tree of the alpha prop panel
	%
	% PanelPropAlpha methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two alpha prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the alpha prop panel
	%
	% PanelPropAlpha methods (save/load, Static):
	%  save - saves BRAPH2 alpha prop panel as b2 file
	%  load - loads a BRAPH2 alpha prop panel from a b2 file
	%
	% PanelPropAlpha method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the alpha prop panel
	%
	% PanelPropAlpha method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the alpha prop panel
	%
	% PanelPropAlpha methods (inspection, Static):
	%  getClass - returns the class of the alpha prop panel
	%  getSubclasses - returns all subclasses of PanelPropAlpha
	%  getProps - returns the property list of the alpha prop panel
	%  getPropNumber - returns the property number of the alpha prop panel
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
	% PanelPropAlpha methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropAlpha methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropAlpha methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropAlpha methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropAlpha; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropAlpha constants</a>.
	%
	%
	% See also uieditfield, uislider, GUI, PanelElement.
	
	properties (Constant) % properties
		ENABLE = PanelProp.getPropNumber() + 1;
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = Category.GUI;
		ENABLE_FORMAT = Format.LOGICAL;
		
		EDITFIELD = PanelProp.getPropNumber() + 2;
		EDITFIELD_TAG = 'EDITFIELD';
		EDITFIELD_CATEGORY = Category.EVANESCENT;
		EDITFIELD_FORMAT = Format.HANDLE;
		
		SLIDER = PanelProp.getPropNumber() + 3;
		SLIDER_TAG = 'SLIDER';
		SLIDER_CATEGORY = Category.EVANESCENT;
		SLIDER_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = PanelPropAlpha(varargin)
			%PanelPropAlpha() creates a alpha prop panel.
			%
			% PanelPropAlpha(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropAlpha(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the alpha prop panel.
			%
			% CLASS = PanelPropAlpha.GETCLASS() returns the class 'PanelPropAlpha'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the alpha prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropAlpha') returns 'PanelPropAlpha'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropAlpha')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropAlpha';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the alpha prop panel.
			%
			% LIST = PanelPropAlpha.GETSUBCLASSES() returns all subclasses of 'PanelPropAlpha'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the alpha prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropAlpha') returns all subclasses of 'PanelPropAlpha'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropAlpha')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelPropAlpha', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of alpha prop panel.
			%
			% PROPS = PanelPropAlpha.GETPROPS() returns the property list of alpha prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropAlpha.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the alpha prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropAlpha'[, CATEGORY]) returns the property list of 'PanelPropAlpha'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropAlpha')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						PanelPropAlpha.ENABLE ...
						PanelPropAlpha.EDITFIELD ...
						PanelPropAlpha.SLIDER ...
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
						PanelPropAlpha.EDITFIELD ...
						PanelPropAlpha.SLIDER ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						PanelPropAlpha.ENABLE ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of alpha prop panel.
			%
			% N = PanelPropAlpha.GETPROPNUMBER() returns the property number of alpha prop panel.
			%
			% N = PanelPropAlpha.GETPROPNUMBER(CATEGORY) returns the property number of alpha prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the alpha prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropAlpha') returns the property number of 'PanelPropAlpha'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropAlpha')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelPropAlpha.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in alpha prop panel/error.
			%
			% CHECK = PanelPropAlpha.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropAlpha, PROP) checks whether PROP exists for PanelPropAlpha.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropAlpha:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropAlpha:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropAlpha:WrongInput]
			%  Element.EXISTSPROP(PanelPropAlpha, PROP) throws error if PROP does NOT exist for PanelPropAlpha.
			%   Error id: [BRAPH2:PanelPropAlpha:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropAlpha')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelPropAlpha.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropAlpha:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropAlpha:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropAlpha.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in alpha prop panel/error.
			%
			% CHECK = PanelPropAlpha.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropAlpha, TAG) checks whether TAG exists for PanelPropAlpha.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropAlpha:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropAlpha:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropAlpha:WrongInput]
			%  Element.EXISTSTAG(PanelPropAlpha, TAG) throws error if TAG does NOT exist for PanelPropAlpha.
			%   Error id: [BRAPH2:PanelPropAlpha:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropAlpha')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelpropalpha_tag_list = cellfun(@(x) PanelPropAlpha.getPropTag(x), num2cell(PanelPropAlpha.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelpropalpha_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropAlpha:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropAlpha:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropAlpha.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropAlpha, POINTER) returns property number of POINTER of PanelPropAlpha.
			%  PROPERTY = PR.GETPROPPROP(PanelPropAlpha, POINTER) returns property number of POINTER of PanelPropAlpha.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropAlpha')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelpropalpha_tag_list = cellfun(@(x) PanelPropAlpha.getPropTag(x), num2cell(PanelPropAlpha.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelpropalpha_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PanelPropAlpha, POINTER) returns tag of POINTER of PanelPropAlpha.
			%  TAG = PR.GETPROPTAG(PanelPropAlpha, POINTER) returns tag of POINTER of PanelPropAlpha.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropAlpha')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelPropAlpha.ENABLE
						tag = PanelPropAlpha.ENABLE_TAG;
					case PanelPropAlpha.EDITFIELD
						tag = PanelPropAlpha.EDITFIELD_TAG;
					case PanelPropAlpha.SLIDER
						tag = PanelPropAlpha.SLIDER_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropAlpha, POINTER) returns category of POINTER of PanelPropAlpha.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropAlpha, POINTER) returns category of POINTER of PanelPropAlpha.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropAlpha')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropAlpha.getPropProp(pointer);
			
			switch prop
				case PanelPropAlpha.ENABLE
					prop_category = PanelPropAlpha.ENABLE_CATEGORY;
				case PanelPropAlpha.EDITFIELD
					prop_category = PanelPropAlpha.EDITFIELD_CATEGORY;
				case PanelPropAlpha.SLIDER
					prop_category = PanelPropAlpha.SLIDER_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropAlpha, POINTER) returns format of POINTER of PanelPropAlpha.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropAlpha, POINTER) returns format of POINTER of PanelPropAlpha.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropAlpha')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropAlpha.getPropProp(pointer);
			
			switch prop
				case PanelPropAlpha.ENABLE
					prop_format = PanelPropAlpha.ENABLE_FORMAT;
				case PanelPropAlpha.EDITFIELD
					prop_format = PanelPropAlpha.EDITFIELD_FORMAT;
				case PanelPropAlpha.SLIDER
					prop_format = PanelPropAlpha.SLIDER_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropAlpha, POINTER) returns description of POINTER of PanelPropAlpha.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropAlpha, POINTER) returns description of POINTER of PanelPropAlpha.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropAlpha')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropAlpha.getPropProp(pointer);
			
			switch prop
				case PanelPropAlpha.ENABLE
					prop_description = 'ENABLE (gui, logical) switches the editfield between active and inactive appearance when not editable.';
				case PanelPropAlpha.EDITFIELD
					prop_description = 'EDITFIELD (evanescent, handle) is the alpha value edit field.';
				case PanelPropAlpha.SLIDER
					prop_description = 'SLIDER (evanescent, handle) is the alpha value slider.';
				case PanelPropAlpha.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the alpha property panel.';
				case PanelPropAlpha.NAME
					prop_description = 'NAME (constant, string) is the name of the alpha property panel.';
				case PanelPropAlpha.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the alpha property panel.';
				case PanelPropAlpha.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the alpha property panel.';
				case PanelPropAlpha.ID
					prop_description = 'ID (data, string) is a few-letter code for the alpha property panel.';
				case PanelPropAlpha.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the alpha property panel.';
				case PanelPropAlpha.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the alpha property panel.';
				case PanelPropAlpha.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelPropAlpha.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PanelPropAlpha.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the property panel.';
				case PanelPropAlpha.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case PanelPropAlpha.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the editfield.';
				case PanelPropAlpha.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case PanelPropAlpha.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropAlpha, POINTER) returns settings of POINTER of PanelPropAlpha.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropAlpha, POINTER) returns settings of POINTER of PanelPropAlpha.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropAlpha')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropAlpha.getPropProp(pointer);
			
			switch prop
				case PanelPropAlpha.ENABLE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case PanelPropAlpha.EDITFIELD
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropAlpha.SLIDER
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropAlpha.TEMPLATE
					prop_settings = 'PanelPropAlpha';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropAlpha.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropAlpha.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropAlpha, POINTER) returns the default value of POINTER of PanelPropAlpha.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropAlpha, POINTER) returns the default value of POINTER of PanelPropAlpha.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropAlpha')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropAlpha.getPropProp(pointer);
			
			switch prop
				case PanelPropAlpha.ENABLE
					prop_default = true;
				case PanelPropAlpha.EDITFIELD
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropAlpha.getPropSettings(prop));
				case PanelPropAlpha.SLIDER
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropAlpha.getPropSettings(prop));
				case PanelPropAlpha.ELCLASS
					prop_default = 'PanelPropAlpha';
				case PanelPropAlpha.NAME
					prop_default = 'Alpha Prop Panel';
				case PanelPropAlpha.DESCRIPTION
					prop_default = 'An Alpha Prop Panel (PanelPropAlpha) plots the panel for a ALPHA property with a numeric edit field and a slider. It works for all categories.';
				case PanelPropAlpha.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropAlpha.getPropSettings(prop));
				case PanelPropAlpha.ID
					prop_default = 'PanelPropAlpha ID';
				case PanelPropAlpha.LABEL
					prop_default = 'PanelPropAlpha label';
				case PanelPropAlpha.NOTES
					prop_default = 'PanelPropAlpha notes';
				case PanelPropAlpha.EL
					prop_default = SettingsSurface();
				case PanelPropAlpha.PROP
					prop_default = SettingsSurface.FACEALPHA;
				case PanelPropAlpha.HEIGHT
					prop_default = s(5);
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropAlpha.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropAlpha.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropAlpha, POINTER) returns the conditioned default value of POINTER of PanelPropAlpha.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropAlpha, POINTER) returns the conditioned default value of POINTER of PanelPropAlpha.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropAlpha')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropAlpha.getPropProp(pointer);
			
			prop_default = PanelPropAlpha.conditioning(prop, PanelPropAlpha.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PanelPropAlpha, PROP, VALUE) checks VALUE format for PROP of PanelPropAlpha.
			%  CHECK = PR.CHECKPROP(PanelPropAlpha, PROP, VALUE) checks VALUE format for PROP of PanelPropAlpha.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelPropAlpha:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelPropAlpha:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelPropAlpha, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropAlpha.
			%   Error id: €BRAPH2.STR€:PanelPropAlpha:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelPropAlpha, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropAlpha.
			%   Error id: €BRAPH2.STR€:PanelPropAlpha:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropAlpha')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropAlpha.getPropProp(pointer);
			
			switch prop
				case PanelPropAlpha.ENABLE % __PanelPropAlpha.ENABLE__
					check = Format.checkFormat(Format.LOGICAL, value, PanelPropAlpha.getPropSettings(prop));
				case PanelPropAlpha.EDITFIELD % __PanelPropAlpha.EDITFIELD__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropAlpha.getPropSettings(prop));
				case PanelPropAlpha.SLIDER % __PanelPropAlpha.SLIDER__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropAlpha.getPropSettings(prop));
				case PanelPropAlpha.TEMPLATE % __PanelPropAlpha.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelPropAlpha.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropAlpha:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropAlpha:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropAlpha.getPropTag(prop) ' (' PanelPropAlpha.getFormatTag(PanelPropAlpha.getPropFormat(prop)) ').'] ...
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
				case PanelPropAlpha.EDITFIELD % __PanelPropAlpha.EDITFIELD__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					editfield = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'EDITFIELD', ...
					    'Limits', [0 1], ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_editfield} ...
					    );
					
					value = editfield;
					
				case PanelPropAlpha.SLIDER % __PanelPropAlpha.SLIDER__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					slider = uislider( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'SLIDER', ...
					    'Limits', [0 1], ...
					    'FontSize', BRAPH2.FONTSIZE / 2, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_slider} ...
					    );
					
					% output
					value = slider;
					
				case PanelPropAlpha.X_DRAW % __PanelPropAlpha.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('EDITFIELD')
					    pr.memorize('SLIDER')
					end
					
				case PanelPropAlpha.UPDATE % __PanelPropAlpha.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    switch el.getPropCategory(prop)
					        case Category.CONSTANT
					            set(pr.get('EDITFIELD'), ...
					                'Value', el.get(prop), ...
					                'Editable', 'off', ...
					                'Enable', pr.get('ENABLE') ...
					                )
					            set(pr.get('SLIDER'), ...
					                'Value', el.get(prop), ...
					                'Enable', 'off' ...
					                )
					            
					        case Category.METADATA
					            set(pr.get('EDITFIELD'), 'Value', el.get(prop))
					            set(pr.get('SLIDER'), 'Value', el.get(prop))
					
					            if el.isLocked(prop)
					                set(pr.get('EDITFIELD'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER'), 'Enable', 'off')
					            end
					            
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('EDITFIELD'), 'Value', el.get(prop))
					            set(pr.get('SLIDER'), 'Value', el.get(prop))
					
					            prop_value = el.getr(prop);
					            if el.isLocked(prop) || isa(prop_value, 'Callback')
					                set(pr.get('EDITFIELD'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER'), 'Enable', 'off')
					            end
					
					        case {Category.RESULT Category.QUERY Category.EVANESCENT}
					            prop_value = el.getr(prop);
					
					            if isa(prop_value, 'NoValue')
					                set(pr.get('EDITFIELD'), 'Value', el.getPropDefault(prop))
					                set(pr.get('SLIDER'), 'Value', el.getPropDefault(prop))
					            else
					                set(pr.get('EDITFIELD'), 'Value', el.get(prop))
					                set(pr.get('SLIDER'), 'Value', el.get(prop))
					            end
					            
					            set(pr.get('EDITFIELD'), ...
					                'Editable', 'off', ...
					                'Enable', pr.get('ENABLE') ...
					                )
					            set(pr.get('SLIDER'), 'Enable', 'off')
					    end
					end
					
				case PanelPropAlpha.REDRAW % __PanelPropAlpha.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('EDITFIELD'), 'Position', [s(.3) s(.3) .15*w_p s(1.75)])
					    set(pr.get('SLIDER'), 'Position', [s(.3)+.15*w_p+s(1.7) s(2.25) .70*w_p 3]) % the height of a slider cannot be changed
					end
					
				case PanelPropAlpha.DELETE % __PanelPropAlpha.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('EDITFIELD', Element.getNoValue())
					    pr.set('SLIDER', Element.getNoValue())
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_editfield(~, ~)
			    pr.get('EL').set(pr.get('PROP'), get(pr.get('EDITFIELD'), 'Value'))
			end
			function cb_slider(~, ~)
			    pr.get('EL').set(pr.get('PROP'), get(pr.get('SLIDER'), 'Value'))
			end
		end
	end
end
