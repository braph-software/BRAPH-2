classdef PanelPropOption < PanelProp
	%PanelPropOption plots the panel of a property option.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% An Option Prop Panel (PanelPropOption) plots the panel for an OPTION property with a drop-down list.
	% It works for all categories.
	%
	% PanelPropOption methods (constructor):
	%  PanelPropOption - constructor
	%
	% PanelPropOption methods:
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
	% PanelPropOption methods (display):
	%  tostring - string with information about the option prop panel
	%  disp - displays information about the option prop panel
	%  tree - displays the tree of the option prop panel
	%
	% PanelPropOption methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two option prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the option prop panel
	%
	% PanelPropOption methods (save/load, Static):
	%  save - saves BRAPH2 option prop panel as b2 file
	%  load - loads a BRAPH2 option prop panel from a b2 file
	%
	% PanelPropOption method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the option prop panel
	%
	% PanelPropOption method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the option prop panel
	%
	% PanelPropOption methods (inspection, Static):
	%  getClass - returns the class of the option prop panel
	%  getSubclasses - returns all subclasses of PanelPropOption
	%  getProps - returns the property list of the option prop panel
	%  getPropNumber - returns the property number of the option prop panel
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
	% PanelPropOption methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropOption methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropOption methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropOption methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropOption; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropOption constants</a>.
	%
	%
	% See also uidropdown, GUI, PanelElement.
	
	properties (Constant) % properties
		DROPDOWN = PanelProp.getPropNumber() + 1;
		DROPDOWN_TAG = 'DROPDOWN';
		DROPDOWN_CATEGORY = Category.EVANESCENT;
		DROPDOWN_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = PanelPropOption(varargin)
			%PanelPropOption() creates a option prop panel.
			%
			% PanelPropOption(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropOption(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the option prop panel.
			%
			% CLASS = PanelPropOption.GETCLASS() returns the class 'PanelPropOption'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the option prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropOption') returns 'PanelPropOption'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropOption')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropOption';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the option prop panel.
			%
			% LIST = PanelPropOption.GETSUBCLASSES() returns all subclasses of 'PanelPropOption'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the option prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropOption') returns all subclasses of 'PanelPropOption'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropOption')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PanelPropOption', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of option prop panel.
			%
			% PROPS = PanelPropOption.GETPROPS() returns the property list of option prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropOption.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the option prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropOption'[, CATEGORY]) returns the property list of 'PanelPropOption'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropOption')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						PanelPropOption.DROPDOWN ...
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
						PanelPropOption.DROPDOWN ...
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
			%GETPROPNUMBER returns the property number of option prop panel.
			%
			% N = PanelPropOption.GETPROPNUMBER() returns the property number of option prop panel.
			%
			% N = PanelPropOption.GETPROPNUMBER(CATEGORY) returns the property number of option prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the option prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropOption') returns the property number of 'PanelPropOption'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropOption')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PanelPropOption.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in option prop panel/error.
			%
			% CHECK = PanelPropOption.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropOption, PROP) checks whether PROP exists for PanelPropOption.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropOption:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropOption:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropOption:WrongInput]
			%  Element.EXISTSPROP(PanelPropOption, PROP) throws error if PROP does NOT exist for PanelPropOption.
			%   Error id: [BRAPH2:PanelPropOption:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropOption')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PanelPropOption.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropOption:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropOption:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropOption.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in option prop panel/error.
			%
			% CHECK = PanelPropOption.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropOption, TAG) checks whether TAG exists for PanelPropOption.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropOption:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropOption:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropOption:WrongInput]
			%  Element.EXISTSTAG(PanelPropOption, TAG) throws error if TAG does NOT exist for PanelPropOption.
			%   Error id: [BRAPH2:PanelPropOption:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropOption')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			panelpropoption_tag_list = cellfun(@(x) PanelPropOption.getPropTag(x), num2cell(PanelPropOption.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, panelpropoption_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropOption:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropOption:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropOption.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(PanelPropOption, POINTER) returns property number of POINTER of PanelPropOption.
			%  PROPERTY = PR.GETPROPPROP(PanelPropOption, POINTER) returns property number of POINTER of PanelPropOption.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropOption')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				panelpropoption_tag_list = cellfun(@(x) PanelPropOption.getPropTag(x), num2cell(PanelPropOption.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, panelpropoption_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(PanelPropOption, POINTER) returns tag of POINTER of PanelPropOption.
			%  TAG = PR.GETPROPTAG(PanelPropOption, POINTER) returns tag of POINTER of PanelPropOption.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropOption')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PanelPropOption.DROPDOWN
						tag = PanelPropOption.DROPDOWN_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropOption, POINTER) returns category of POINTER of PanelPropOption.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropOption, POINTER) returns category of POINTER of PanelPropOption.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropOption')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropOption.getPropProp(pointer);
			
			switch prop
				case PanelPropOption.DROPDOWN
					prop_category = PanelPropOption.DROPDOWN_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(PanelPropOption, POINTER) returns format of POINTER of PanelPropOption.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropOption, POINTER) returns format of POINTER of PanelPropOption.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropOption')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropOption.getPropProp(pointer);
			
			switch prop
				case PanelPropOption.DROPDOWN
					prop_format = PanelPropOption.DROPDOWN_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropOption, POINTER) returns description of POINTER of PanelPropOption.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropOption, POINTER) returns description of POINTER of PanelPropOption.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropOption')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropOption.getPropProp(pointer);
			
			switch prop
				case PanelPropOption.DROPDOWN
					prop_description = 'DROPDOWN (evanescent, handle) is the logical value dropdown.';
				case PanelPropOption.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the option property panel.';
				case PanelPropOption.NAME
					prop_description = 'NAME (constant, string) is the name of the option property panel.';
				case PanelPropOption.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the option property panel.';
				case PanelPropOption.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the option property panel.';
				case PanelPropOption.ID
					prop_description = 'ID (data, string) is a few-letter code for the option property panel.';
				case PanelPropOption.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the option property panel.';
				case PanelPropOption.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the option property panel.';
				case PanelPropOption.EL
					prop_description = 'EL (data, item) is the element.';
				case PanelPropOption.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case PanelPropOption.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the property panel.';
				case PanelPropOption.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case PanelPropOption.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the editfield.';
				case PanelPropOption.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.';
				case PanelPropOption.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropOption, POINTER) returns settings of POINTER of PanelPropOption.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropOption, POINTER) returns settings of POINTER of PanelPropOption.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropOption')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropOption.getPropProp(pointer);
			
			switch prop
				case PanelPropOption.DROPDOWN
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case PanelPropOption.TEMPLATE
					prop_settings = 'PanelPropOption';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropOption.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropOption.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropOption, POINTER) returns the default value of POINTER of PanelPropOption.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropOption, POINTER) returns the default value of POINTER of PanelPropOption.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropOption')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropOption.getPropProp(pointer);
			
			switch prop
				case PanelPropOption.DROPDOWN
					prop_default = Format.getFormatDefault(Format.HANDLE, PanelPropOption.getPropSettings(prop));
				case PanelPropOption.ELCLASS
					prop_default = 'PanelPropOption';
				case PanelPropOption.NAME
					prop_default = 'Option Prop Panel';
				case PanelPropOption.DESCRIPTION
					prop_default = 'An Option Prop Panel (PanelPropOption) plots the panel for an OPTION property with a drop-down list. It works for all categories.';
				case PanelPropOption.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PanelPropOption.getPropSettings(prop));
				case PanelPropOption.ID
					prop_default = 'PanelPropOption ID';
				case PanelPropOption.LABEL
					prop_default = 'PanelPropOption label';
				case PanelPropOption.NOTES
					prop_default = 'PanelPropOption notes';
				case PanelPropOption.EL
					prop_default = PanelPropItem();
				case PanelPropOption.PROP
					prop_default = PanelPropItem.GUICLASS;
				case PanelPropOption.HEIGHT
					prop_default = s(4);
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropOption.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropOption.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropOption, POINTER) returns the conditioned default value of POINTER of PanelPropOption.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropOption, POINTER) returns the conditioned default value of POINTER of PanelPropOption.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropOption')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropOption.getPropProp(pointer);
			
			prop_default = PanelPropOption.conditioning(prop, PanelPropOption.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(PanelPropOption, PROP, VALUE) checks VALUE format for PROP of PanelPropOption.
			%  CHECK = PR.CHECKPROP(PanelPropOption, PROP, VALUE) checks VALUE format for PROP of PanelPropOption.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PanelPropOption:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:PanelPropOption:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PanelPropOption, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropOption.
			%   Error id: €BRAPH2.STR€:PanelPropOption:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(PanelPropOption, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropOption.
			%   Error id: €BRAPH2.STR€:PanelPropOption:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropOption')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropOption.getPropProp(pointer);
			
			switch prop
				case PanelPropOption.DROPDOWN % __PanelPropOption.DROPDOWN__
					check = Format.checkFormat(Format.HANDLE, value, PanelPropOption.getPropSettings(prop));
				case PanelPropOption.TEMPLATE % __PanelPropOption.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PanelPropOption.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PanelPropOption:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PanelPropOption:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropOption.getPropTag(prop) ' (' PanelPropOption.getFormatTag(PanelPropOption.getPropFormat(prop)) ').'] ...
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
				case PanelPropOption.DROPDOWN % __PanelPropOption.DROPDOWN__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					dropdown = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN', ...
					    'Items', el.getPropSettings(prop), ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_dropdown} ...
					    );
					
					value = dropdown;
					
				case PanelPropOption.X_DRAW % __PanelPropOption.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('DROPDOWN')
					end
					
				case PanelPropOption.UPDATE % __PanelPropOption.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    switch el.getPropCategory(prop)
					        case Category.CONSTANT
					            set(pr.get('DROPDOWN'), ...
					                'Value', el.get(prop), ...
					                'Enable', 'off' ...
					                )
					            
					        case Category.METADATA
					            set(pr.get('DROPDOWN'), 'Value', el.get(prop))
					
					            if el.isLocked(prop)
					                set(pr.get('DROPDOWN'), 'Enable', 'off')
					            end
					            
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('DROPDOWN'), 'Value', el.get(prop))
					
					            prop_value = el.getr(prop);
					            if el.isLocked(prop) || isa(prop_value, 'Callback')
					                set(pr.get('DROPDOWN'), 'Enable', 'off')
					            end
					
					        case {Category.RESULT Category.QUERY Category.EVANESCENT}
					            prop_value = el.getr(prop);
					
					            if isa(prop_value, 'NoValue')
					                set(pr.get('DROPDOWN'), 'Value', el.getPropDefault(prop))
					            else
					                set(pr.get('DROPDOWN'), 'Value', el.get(prop))
					            end
					            
					            set(pr.get('DROPDOWN'), 'Enable', 'off')
					    end
					end
					
				case PanelPropOption.REDRAW % __PanelPropOption.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('DROPDOWN'), 'Position', [s(.3) s(.3) .70*w_p s(1.75)])
					end
					
				case PanelPropOption.DELETE % __PanelPropOption.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('DROPDOWN', Element.getNoValue())
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_dropdown(~, ~)
			    pr.get('EL').set(pr.get('PROP'), get(pr.get('DROPDOWN'), 'Value'))
			end
		end
	end
end
