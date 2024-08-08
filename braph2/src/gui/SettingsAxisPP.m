classdef SettingsAxisPP < SettingsPP
	%SettingsAxisPP is the panel with axis settings.
	% It is a subclass of <a href="matlab:help SettingsPP">SettingsPP</a>.
	%
	% A Prop Panel for Axis Settings (SettingsAxisPP) plots the panel 
	%  for axis settings, including a button for the axis color and 
	%  checkboxes for axis on/off, grid on/off, equal on/off, and tight on/off.
	% It works for all categories.
	%
	% SettingsAxisPP methods (constructor):
	%  SettingsAxisPP - constructor
	%
	% SettingsAxisPP methods:
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
	% SettingsAxisPP methods (display):
	%  tostring - string with information about the prop panel for axis settings
	%  disp - displays information about the prop panel for axis settings
	%  tree - displays the tree of the prop panel for axis settings
	%
	% SettingsAxisPP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two prop panel for axis settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the prop panel for axis settings
	%
	% SettingsAxisPP methods (save/load, Static):
	%  save - saves BRAPH2 prop panel for axis settings as b2 file
	%  load - loads a BRAPH2 prop panel for axis settings from a b2 file
	%
	% SettingsAxisPP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the prop panel for axis settings
	%
	% SettingsAxisPP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the prop panel for axis settings
	%
	% SettingsAxisPP methods (inspection, Static):
	%  getClass - returns the class of the prop panel for axis settings
	%  getSubclasses - returns all subclasses of SettingsAxisPP
	%  getProps - returns the property list of the prop panel for axis settings
	%  getPropNumber - returns the property number of the prop panel for axis settings
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
	% SettingsAxisPP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsAxisPP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsAxisPP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsAxisPP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsAxisPP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsAxisPP constants</a>.
	%
	%
	% See also SettingsPosition, uicheckbox, uipushbutton.
	
	properties (Constant) % properties
		ENABLE = SettingsPP.getPropNumber() + 1;
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = Category.GUI;
		ENABLE_FORMAT = Format.LOGICAL;
		
		BUTTON_AXISCOLOR = SettingsPP.getPropNumber() + 2;
		BUTTON_AXISCOLOR_TAG = 'BUTTON_AXISCOLOR';
		BUTTON_AXISCOLOR_CATEGORY = Category.EVANESCENT;
		BUTTON_AXISCOLOR_FORMAT = Format.HANDLE;
		
		CHECKBOX_AXIS = SettingsPP.getPropNumber() + 3;
		CHECKBOX_AXIS_TAG = 'CHECKBOX_AXIS';
		CHECKBOX_AXIS_CATEGORY = Category.EVANESCENT;
		CHECKBOX_AXIS_FORMAT = Format.HANDLE;
		
		CHECKBOX_GRID = SettingsPP.getPropNumber() + 4;
		CHECKBOX_GRID_TAG = 'CHECKBOX_GRID';
		CHECKBOX_GRID_CATEGORY = Category.EVANESCENT;
		CHECKBOX_GRID_FORMAT = Format.HANDLE;
		
		CHECKBOX_EQUAL = SettingsPP.getPropNumber() + 5;
		CHECKBOX_EQUAL_TAG = 'CHECKBOX_EQUAL';
		CHECKBOX_EQUAL_CATEGORY = Category.EVANESCENT;
		CHECKBOX_EQUAL_FORMAT = Format.HANDLE;
		
		CHECKBOX_TIGHT = SettingsPP.getPropNumber() + 6;
		CHECKBOX_TIGHT_TAG = 'CHECKBOX_TIGHT';
		CHECKBOX_TIGHT_CATEGORY = Category.EVANESCENT;
		CHECKBOX_TIGHT_FORMAT = Format.HANDLE;
		
		CHECKBOX_BOX = SettingsPP.getPropNumber() + 7;
		CHECKBOX_BOX_TAG = 'CHECKBOX_BOX';
		CHECKBOX_BOX_CATEGORY = Category.EVANESCENT;
		CHECKBOX_BOX_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = SettingsAxisPP(varargin)
			%SettingsAxisPP() creates a prop panel for axis settings.
			%
			% SettingsAxisPP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsAxisPP(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pr = pr@SettingsPP(varargin{:});
		end
	end
	methods (Static) % inspection
		function pr_class = getClass()
			%GETCLASS returns the class of the prop panel for axis settings.
			%
			% CLASS = SettingsAxisPP.GETCLASS() returns the class 'SettingsAxisPP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the prop panel for axis settings PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('SettingsAxisPP') returns 'SettingsAxisPP'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('SettingsAxisPP')
			%  are less computationally efficient.
			
			pr_class = 'SettingsAxisPP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the prop panel for axis settings.
			%
			% LIST = SettingsAxisPP.GETSUBCLASSES() returns all subclasses of 'SettingsAxisPP'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the prop panel for axis settings PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('SettingsAxisPP') returns all subclasses of 'SettingsAxisPP'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SettingsAxisPP', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of prop panel for axis settings.
			%
			% PROPS = SettingsAxisPP.GETPROPS() returns the property list of prop panel for axis settings
			%  as a row vector.
			%
			% PROPS = SettingsAxisPP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the prop panel for axis settings PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('SettingsAxisPP'[, CATEGORY]) returns the property list of 'SettingsAxisPP'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					SettingsPP.getProps() ...
						SettingsAxisPP.ENABLE ...
						SettingsAxisPP.BUTTON_AXISCOLOR ...
						SettingsAxisPP.CHECKBOX_AXIS ...
						SettingsAxisPP.CHECKBOX_GRID ...
						SettingsAxisPP.CHECKBOX_EQUAL ...
						SettingsAxisPP.CHECKBOX_TIGHT ...
						SettingsAxisPP.CHECKBOX_BOX ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						SettingsPP.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						SettingsPP.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						SettingsPP.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						SettingsPP.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						SettingsPP.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						SettingsPP.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						SettingsPP.getProps(Category.EVANESCENT) ...
						SettingsAxisPP.BUTTON_AXISCOLOR ...
						SettingsAxisPP.CHECKBOX_AXIS ...
						SettingsAxisPP.CHECKBOX_GRID ...
						SettingsAxisPP.CHECKBOX_EQUAL ...
						SettingsAxisPP.CHECKBOX_TIGHT ...
						SettingsAxisPP.CHECKBOX_BOX ...
						];
				case Category.FIGURE
					prop_list = [ ...
						SettingsPP.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						SettingsPP.getProps(Category.GUI) ...
						SettingsAxisPP.ENABLE ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of prop panel for axis settings.
			%
			% N = SettingsAxisPP.GETPROPNUMBER() returns the property number of prop panel for axis settings.
			%
			% N = SettingsAxisPP.GETPROPNUMBER(CATEGORY) returns the property number of prop panel for axis settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the prop panel for axis settings PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('SettingsAxisPP') returns the property number of 'SettingsAxisPP'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SettingsAxisPP.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in prop panel for axis settings/error.
			%
			% CHECK = SettingsAxisPP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(SettingsAxisPP, PROP) checks whether PROP exists for SettingsAxisPP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsAxisPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAxisPP:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAxisPP:WrongInput]
			%  Element.EXISTSPROP(SettingsAxisPP, PROP) throws error if PROP does NOT exist for SettingsAxisPP.
			%   Error id: [BRAPH2:SettingsAxisPP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SettingsAxisPP.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsAxisPP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsAxisPP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsAxisPP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in prop panel for axis settings/error.
			%
			% CHECK = SettingsAxisPP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(SettingsAxisPP, TAG) checks whether TAG exists for SettingsAxisPP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsAxisPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAxisPP:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAxisPP:WrongInput]
			%  Element.EXISTSTAG(SettingsAxisPP, TAG) throws error if TAG does NOT exist for SettingsAxisPP.
			%   Error id: [BRAPH2:SettingsAxisPP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			settingsaxispp_tag_list = cellfun(@(x) SettingsAxisPP.getPropTag(x), num2cell(SettingsAxisPP.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, settingsaxispp_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsAxisPP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsAxisPP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SettingsAxisPP.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsAxisPP, POINTER) returns property number of POINTER of SettingsAxisPP.
			%  PROPERTY = PR.GETPROPPROP(SettingsAxisPP, POINTER) returns property number of POINTER of SettingsAxisPP.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				settingsaxispp_tag_list = cellfun(@(x) SettingsAxisPP.getPropTag(x), num2cell(SettingsAxisPP.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, settingsaxispp_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(SettingsAxisPP, POINTER) returns tag of POINTER of SettingsAxisPP.
			%  TAG = PR.GETPROPTAG(SettingsAxisPP, POINTER) returns tag of POINTER of SettingsAxisPP.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SettingsAxisPP.ENABLE
						tag = SettingsAxisPP.ENABLE_TAG;
					case SettingsAxisPP.BUTTON_AXISCOLOR
						tag = SettingsAxisPP.BUTTON_AXISCOLOR_TAG;
					case SettingsAxisPP.CHECKBOX_AXIS
						tag = SettingsAxisPP.CHECKBOX_AXIS_TAG;
					case SettingsAxisPP.CHECKBOX_GRID
						tag = SettingsAxisPP.CHECKBOX_GRID_TAG;
					case SettingsAxisPP.CHECKBOX_EQUAL
						tag = SettingsAxisPP.CHECKBOX_EQUAL_TAG;
					case SettingsAxisPP.CHECKBOX_TIGHT
						tag = SettingsAxisPP.CHECKBOX_TIGHT_TAG;
					case SettingsAxisPP.CHECKBOX_BOX
						tag = SettingsAxisPP.CHECKBOX_BOX_TAG;
					otherwise
						tag = getPropTag@SettingsPP(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsAxisPP, POINTER) returns category of POINTER of SettingsAxisPP.
			%  CATEGORY = PR.GETPROPCATEGORY(SettingsAxisPP, POINTER) returns category of POINTER of SettingsAxisPP.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsAxisPP.getPropProp(pointer);
			
			switch prop
				case SettingsAxisPP.ENABLE
					prop_category = SettingsAxisPP.ENABLE_CATEGORY;
				case SettingsAxisPP.BUTTON_AXISCOLOR
					prop_category = SettingsAxisPP.BUTTON_AXISCOLOR_CATEGORY;
				case SettingsAxisPP.CHECKBOX_AXIS
					prop_category = SettingsAxisPP.CHECKBOX_AXIS_CATEGORY;
				case SettingsAxisPP.CHECKBOX_GRID
					prop_category = SettingsAxisPP.CHECKBOX_GRID_CATEGORY;
				case SettingsAxisPP.CHECKBOX_EQUAL
					prop_category = SettingsAxisPP.CHECKBOX_EQUAL_CATEGORY;
				case SettingsAxisPP.CHECKBOX_TIGHT
					prop_category = SettingsAxisPP.CHECKBOX_TIGHT_CATEGORY;
				case SettingsAxisPP.CHECKBOX_BOX
					prop_category = SettingsAxisPP.CHECKBOX_BOX_CATEGORY;
				otherwise
					prop_category = getPropCategory@SettingsPP(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsAxisPP, POINTER) returns format of POINTER of SettingsAxisPP.
			%  FORMAT = PR.GETPROPFORMAT(SettingsAxisPP, POINTER) returns format of POINTER of SettingsAxisPP.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsAxisPP.getPropProp(pointer);
			
			switch prop
				case SettingsAxisPP.ENABLE
					prop_format = SettingsAxisPP.ENABLE_FORMAT;
				case SettingsAxisPP.BUTTON_AXISCOLOR
					prop_format = SettingsAxisPP.BUTTON_AXISCOLOR_FORMAT;
				case SettingsAxisPP.CHECKBOX_AXIS
					prop_format = SettingsAxisPP.CHECKBOX_AXIS_FORMAT;
				case SettingsAxisPP.CHECKBOX_GRID
					prop_format = SettingsAxisPP.CHECKBOX_GRID_FORMAT;
				case SettingsAxisPP.CHECKBOX_EQUAL
					prop_format = SettingsAxisPP.CHECKBOX_EQUAL_FORMAT;
				case SettingsAxisPP.CHECKBOX_TIGHT
					prop_format = SettingsAxisPP.CHECKBOX_TIGHT_FORMAT;
				case SettingsAxisPP.CHECKBOX_BOX
					prop_format = SettingsAxisPP.CHECKBOX_BOX_FORMAT;
				otherwise
					prop_format = getPropFormat@SettingsPP(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsAxisPP, POINTER) returns description of POINTER of SettingsAxisPP.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(SettingsAxisPP, POINTER) returns description of POINTER of SettingsAxisPP.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsAxisPP.getPropProp(pointer);
			
			switch prop
				case SettingsAxisPP.ENABLE
					prop_description = 'ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.';
				case SettingsAxisPP.BUTTON_AXISCOLOR
					prop_description = 'BUTTON_AXISCOLOR (evanescent, handle) is the axis color button.';
				case SettingsAxisPP.CHECKBOX_AXIS
					prop_description = 'CHECKBOX_AXIS (evanescent, handle) is the axis checkbox.';
				case SettingsAxisPP.CHECKBOX_GRID
					prop_description = 'CHECKBOX_GRID (evanescent, handle) is the grid checkbox.';
				case SettingsAxisPP.CHECKBOX_EQUAL
					prop_description = 'CHECKBOX_EQUAL (evanescent, handle) is the equal checkbox.';
				case SettingsAxisPP.CHECKBOX_TIGHT
					prop_description = 'CHECKBOX_TIGHT (evanescent, handle) is the tight checkbox.';
				case SettingsAxisPP.CHECKBOX_BOX
					prop_description = 'CHECKBOX_BOX (evanescent, handle) is the box checkbox.';
				case SettingsAxisPP.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the property panel for axis settings.';
				case SettingsAxisPP.NAME
					prop_description = 'NAME (constant, string) is the name of the property panel for axis settings.';
				case SettingsAxisPP.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the property panel for axis settings.';
				case SettingsAxisPP.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the property panel for axis settings.';
				case SettingsAxisPP.ID
					prop_description = 'ID (data, string) is a few-letter code for the property panel for axis settings.';
				case SettingsAxisPP.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the property panel for axis settings.';
				case SettingsAxisPP.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the property panel for axis settings.';
				case SettingsAxisPP.EL
					prop_description = 'EL (data, item) is the element.';
				case SettingsAxisPP.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case SettingsAxisPP.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the settings position panel.';
				case SettingsAxisPP.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case SettingsAxisPP.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.';
				case SettingsAxisPP.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case SettingsAxisPP.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
				otherwise
					prop_description = getPropDescription@SettingsPP(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsAxisPP, POINTER) returns settings of POINTER of SettingsAxisPP.
			%  SETTINGS = PR.GETPROPSETTINGS(SettingsAxisPP, POINTER) returns settings of POINTER of SettingsAxisPP.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsAxisPP.getPropProp(pointer);
			
			switch prop
				case SettingsAxisPP.ENABLE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SettingsAxisPP.BUTTON_AXISCOLOR
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAxisPP.CHECKBOX_AXIS
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAxisPP.CHECKBOX_GRID
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAxisPP.CHECKBOX_EQUAL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAxisPP.CHECKBOX_TIGHT
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAxisPP.CHECKBOX_BOX
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAxisPP.TEMPLATE
					prop_settings = 'SettingsAxisPP';
				otherwise
					prop_settings = getPropSettings@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsAxisPP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsAxisPP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsAxisPP, POINTER) returns the default value of POINTER of SettingsAxisPP.
			%  DEFAULT = PR.GETPROPDEFAULT(SettingsAxisPP, POINTER) returns the default value of POINTER of SettingsAxisPP.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsAxisPP.getPropProp(pointer);
			
			switch prop
				case SettingsAxisPP.ENABLE
					prop_default = true;
				case SettingsAxisPP.BUTTON_AXISCOLOR
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAxisPP.getPropSettings(prop));
				case SettingsAxisPP.CHECKBOX_AXIS
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAxisPP.getPropSettings(prop));
				case SettingsAxisPP.CHECKBOX_GRID
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAxisPP.getPropSettings(prop));
				case SettingsAxisPP.CHECKBOX_EQUAL
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAxisPP.getPropSettings(prop));
				case SettingsAxisPP.CHECKBOX_TIGHT
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAxisPP.getPropSettings(prop));
				case SettingsAxisPP.CHECKBOX_BOX
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAxisPP.getPropSettings(prop));
				case SettingsAxisPP.ELCLASS
					prop_default = 'SettingsAxisPP';
				case SettingsAxisPP.NAME
					prop_default = 'Prop Panel for Axis Settings';
				case SettingsAxisPP.DESCRIPTION
					prop_default = 'A Prop Panel for Axis Settings (SettingsAxisPP) plots the panel for axis settings, including a button for the axis color and checkboxes for axis on/off, grid on/off, equal on/off, and tight on/off. It works for all categories.';
				case SettingsAxisPP.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, SettingsAxisPP.getPropSettings(prop));
				case SettingsAxisPP.ID
					prop_default = 'SettingsAxisPP ID';
				case SettingsAxisPP.LABEL
					prop_default = 'SettingsAxisPP label';
				case SettingsAxisPP.NOTES
					prop_default = 'SettingsAxisPP notes';
				case SettingsAxisPP.EL
					prop_default = BrainSurfacePF();
				case SettingsAxisPP.PROP
					prop_default = BrainSurfacePF.ST_AXIS;
				case SettingsAxisPP.HEIGHT
					prop_default = s(5.5);
				otherwise
					prop_default = getPropDefault@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsAxisPP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsAxisPP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsAxisPP, POINTER) returns the conditioned default value of POINTER of SettingsAxisPP.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(SettingsAxisPP, POINTER) returns the conditioned default value of POINTER of SettingsAxisPP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsAxisPP.getPropProp(pointer);
			
			prop_default = SettingsAxisPP.conditioning(prop, SettingsAxisPP.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsAxisPP, PROP, VALUE) checks VALUE format for PROP of SettingsAxisPP.
			%  CHECK = PR.CHECKPROP(SettingsAxisPP, PROP, VALUE) checks VALUE format for PROP of SettingsAxisPP.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SettingsAxisPP:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:SettingsAxisPP:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SettingsAxisPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsAxisPP.
			%   Error id: €BRAPH2.STR€:SettingsAxisPP:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(SettingsAxisPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsAxisPP.
			%   Error id: €BRAPH2.STR€:SettingsAxisPP:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('SettingsAxisPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsAxisPP.getPropProp(pointer);
			
			switch prop
				case SettingsAxisPP.ENABLE % __SettingsAxisPP.ENABLE__
					check = Format.checkFormat(Format.LOGICAL, value, SettingsAxisPP.getPropSettings(prop));
				case SettingsAxisPP.BUTTON_AXISCOLOR % __SettingsAxisPP.BUTTON_AXISCOLOR__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAxisPP.getPropSettings(prop));
				case SettingsAxisPP.CHECKBOX_AXIS % __SettingsAxisPP.CHECKBOX_AXIS__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAxisPP.getPropSettings(prop));
				case SettingsAxisPP.CHECKBOX_GRID % __SettingsAxisPP.CHECKBOX_GRID__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAxisPP.getPropSettings(prop));
				case SettingsAxisPP.CHECKBOX_EQUAL % __SettingsAxisPP.CHECKBOX_EQUAL__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAxisPP.getPropSettings(prop));
				case SettingsAxisPP.CHECKBOX_TIGHT % __SettingsAxisPP.CHECKBOX_TIGHT__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAxisPP.getPropSettings(prop));
				case SettingsAxisPP.CHECKBOX_BOX % __SettingsAxisPP.CHECKBOX_BOX__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAxisPP.getPropSettings(prop));
				case SettingsAxisPP.TEMPLATE % __SettingsAxisPP.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, SettingsAxisPP.getPropSettings(prop));
				otherwise
					if prop <= SettingsPP.getPropNumber()
						check = checkProp@SettingsPP(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsAxisPP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsAxisPP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsAxisPP.getPropTag(prop) ' (' SettingsAxisPP.getFormatTag(SettingsAxisPP.getPropFormat(prop)) ').'] ...
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
				case SettingsAxisPP.BUTTON_AXISCOLOR % __SettingsAxisPP.BUTTON_AXISCOLOR__
					el = pr.get('EL');
					prop = pr.get('PROP');
					button_axiscolor = uibutton( ...
					    'Parent', pr.memorize('H'), ...
						'Tag', 'BUTTON_AXISCOLOR', ...
						'Text', '', ...
						'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('AXISCOLOR')) ' ' el.get(prop).getPropDescription('AXISCOLOR')], ...
						'ButtonPushedFcn', {@cb_button_axiscolor}, ...
					    'Interruptible', 'off', ...
					    'BusyAction', 'cancel' ...
						);
					value = button_axiscolor;
					
				case SettingsAxisPP.CHECKBOX_AXIS % __SettingsAxisPP.CHECKBOX_AXIS__
					el = pr.get('EL');
					prop = pr.get('PROP');
					checkbox_axis = uicheckbox( ...
					    'Parent', pr.memorize('H'), ...
						'Tag', 'CHECKBOX_AXIS', ...
					    'Text', 'axis', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('AXIS')) ' ' el.get(prop).getPropDescription('AXIS')], ...
					    'ValueChangedFcn', {@cb_axis} ...
					    );
					value = checkbox_axis;
					
				case SettingsAxisPP.CHECKBOX_GRID % __SettingsAxisPP.CHECKBOX_GRID__
					el = pr.get('EL');
					prop = pr.get('PROP');
					checkbox_grid = uicheckbox( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'CHECKBOX_GRID', ...
					    'Text', 'grid', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('GRID')) ' ' el.get(prop).getPropDescription('GRID')], ...
					    'ValueChangedFcn', {@cb_axis} ... % callback in CHECKBOX_AXIS
					    );
					value = checkbox_grid;
					
				case SettingsAxisPP.CHECKBOX_EQUAL % __SettingsAxisPP.CHECKBOX_EQUAL__
					el = pr.get('EL');
					prop = pr.get('PROP');
					checkbox_equal = uicheckbox( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'CHECKBOX_EQUAL', ...
					    'Text', 'equal', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('EQUAL')) ' ' el.get(prop).getPropDescription('EQUAL')], ...
					    'ValueChangedFcn', {@cb_axis} ... % callback in CHECKBOX_AXIS
					    );
					value = checkbox_equal;
					
				case SettingsAxisPP.CHECKBOX_TIGHT % __SettingsAxisPP.CHECKBOX_TIGHT__
					el = pr.get('EL');
					prop = pr.get('PROP');
					checkbox_tight = uicheckbox( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'CHECKBOX_TIGHT', ...
					    'Text', 'tight', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('TIGHT')) ' ' el.get(prop).getPropDescription('TIGHT')], ...
					    'ValueChangedFcn', {@cb_axis} ... % callback in CHECKBOX_AXIS
					    );
					value = checkbox_tight;
					
				case SettingsAxisPP.CHECKBOX_BOX % __SettingsAxisPP.CHECKBOX_BOX__
					el = pr.get('EL');
					prop = pr.get('PROP');
					checkbox_box = uicheckbox( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'CHECKBOX_BOX', ...
					    'Text', 'box', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('BOX')) ' ' el.get(prop).getPropDescription('BOX')], ...
					    'ValueChangedFcn', {@cb_axis} ... % callback in CHECKBOX_AXIS
					    );
					value = checkbox_box;
					
				case SettingsAxisPP.X_DRAW % __SettingsAxisPP.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('BUTTON_AXISCOLOR')
					    pr.memorize('CHECKBOX_AXIS')
					    pr.memorize('CHECKBOX_GRID')
					    pr.memorize('CHECKBOX_EQUAL')
					    pr.memorize('CHECKBOX_TIGHT')
					    pr.memorize('CHECKBOX_BOX')
					end
					
				case SettingsAxisPP.UPDATE % __SettingsAxisPP.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    if el.isLocked(prop)
					        set(pr.get('BUTTON_AXISCOLOR'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('CHECKBOX_AXIS'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('CHECKBOX_GRID'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('CHECKBOX_EQUAL'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('CHECKBOX_TIGHT'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('CHECKBOX_BOX'), 'Enable', pr.get('ENABLE'))
					    end
					
					    switch el.getPropCategory(prop)
					        case Category.METADATA
					            set(pr.get('BUTTON_AXISCOLOR'), 'BackgroundColor', el.get(prop).get('AXISCOLOR'))
					            set(pr.get('CHECKBOX_AXIS'), 'Value', el.get(prop).get('AXIS'))
					            set(pr.get('CHECKBOX_GRID'), 'Value', el.get(prop).get('GRID'))
					            set(pr.get('CHECKBOX_EQUAL'), 'Value', el.get(prop).get('EQUAL'))
					            set(pr.get('CHECKBOX_TIGHT'), 'Value', el.get(prop).get('TIGHT'))
					            set(pr.get('CHECKBOX_BOX'), 'Value', el.get(prop).get('BOX'))
					
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('BUTTON_AXISCOLOR'), 'BackgroundColor', el.get(prop).get('AXISCOLOR'))
					            set(pr.get('CHECKBOX_AXIS'), 'Value', el.get(prop).get('AXIS'))
					            set(pr.get('CHECKBOX_GRID'), 'Value', el.get(prop).get('GRID'))
					            set(pr.get('CHECKBOX_EQUAL'), 'Value', el.get(prop).get('EQUAL'))
					            set(pr.get('CHECKBOX_TIGHT'), 'Value', el.get(prop).get('TIGHT'))
					            set(pr.get('CHECKBOX_BOX'), 'Value', el.get(prop).get('BOX'))
					
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('AXISCOLOR'), 'Callback')
					                set(pr.get('BUTTON_AXISCOLOR'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('AXIS'), 'Callback')
					                set(pr.get('CHECKBOX_AXIS'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('GRID'), 'Callback')
					                set(pr.get('CHECKBOX_GRID'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('EQUAL'), 'Callback')
					                set(pr.get('CHECKBOX_EQUAL'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('TIGHT'), 'Callback')
					                set(pr.get('CHECKBOX_TIGHT'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('BOX'), 'Callback')
					                set(pr.get('CHECKBOX_BOX'), 'Enable', pr.get('ENABLE'))
					            end
					            
					        case Category.RESULT
					            value = el.getr(prop);
					
					            if isa(value, 'NoValue')
					                set(pr.get('BUTTON_AXISCOLOR'), ...
					                    'BackgroundColor', el.get(prop).getPropDefault('AXISCOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('CHECKBOX_AXIS'), ...
					                    'Value', el.get(prop).getPropDefault('AXIS'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('CHECKBOX_GRID'), ...
					                    'Value', el.get(prop).getPropDefault('GRID'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('CHECKBOX_EQUAL'), ...
					                    'Value', el.get(prop).getPropDefault('EQUAL'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('CHECKBOX_TIGHT'), ...
					                    'Value', el.get(prop).getPropDefault('TIGHT'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('CHECKBOX_BOX'), ...
					                    'Value', el.get(prop).getPropDefault('BOX'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            else
					                set(pr.get('BUTTON_AXISCOLOR'), ...
					                    'BackgroundColor', el.get(prop).get('AXISCOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('CHECKBOX_AXIS'), ...
					                    'Value', el.get(prop).get('AXIS'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('CHECKBOX_GRID'), ...
					                    'Value', el.get(prop).get('GRID'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('CHECKBOX_EQUAL'), ...
					                    'Value', el.get(prop).get('EQUAL'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('CHECKBOX_TIGHT'), ...
					                    'Value', el.get(prop).get('TIGHT'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('CHECKBOX_BOX'), ...
					                    'Value', el.get(prop).get('BOX'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					    end
					end
					
				case SettingsAxisPP.REDRAW % __SettingsAxisPP.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('BUTTON_AXISCOLOR'), 'Position', [s(.9)+.60*w_p s(2.3) .30*w_p s(1.7)])
					    set(pr.get('CHECKBOX_AXIS'), 'Position', [s(.3) s(2.3) .30*w_p s(1.7)])
					    set(pr.get('CHECKBOX_GRID'), 'Position', [s(.6)+.30*w_p s(2.3) .30*w_p s(1.7)])
					    set(pr.get('CHECKBOX_EQUAL'), 'Position', [s(.3) s(.3) .30*w_p s(1.7)])
					    set(pr.get('CHECKBOX_TIGHT'), 'Position', [s(.6)+.30*w_p s(.3) .30*w_p s(1.7)])
					    set(pr.get('CHECKBOX_BOX'), 'Position', [s(.6)+.60*w_p s(.3) .30*w_p s(1.7)])
					end
					
				case SettingsAxisPP.DELETE % __SettingsAxisPP.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('BUTTON_AXISCOLOR', Element.getNoValue())
					    pr.set('CHECKBOX_AXIS', Element.getNoValue())
					    pr.set('CHECKBOX_GRID', Element.getNoValue())
					    pr.set('CHECKBOX_EQUAL', Element.getNoValue())
					    pr.set('CHECKBOX_TIGHT', Element.getNoValue())
					    pr.set('CHECKBOX_BOX', Element.getNoValue())
					end
					
				otherwise
					if prop <= SettingsPP.getPropNumber()
						value = calculateValue@SettingsPP(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_button_axiscolor(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    new_color = uisetcolor(el.get(prop).get('AXISCOLOR'));
			    if ~isequal(new_color, el.get(prop).get('AXISCOLOR'))
			        el.get(prop).set('AXISCOLOR', new_color)
			
			        pr.get('UPDATE')
			    end
			end
			function cb_axis(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set( ...
			        'AXIS', get(pr.get('CHECKBOX_AXIS'), 'Value'), ...
			        'GRID', get(pr.get('CHECKBOX_GRID'), 'Value'), ...
			        'EQUAL', get(pr.get('CHECKBOX_EQUAL'), 'Value'), ...
			        'TIGHT', get(pr.get('CHECKBOX_TIGHT'), 'Value'), ...
			        'BOX', get(pr.get('CHECKBOX_BOX'), 'Value') ...
			        )
			
			end
		end
	end
end
