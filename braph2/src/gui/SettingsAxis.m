classdef SettingsAxis < Settings
	%SettingsAxis contains the axis settings.
	% It is a subclass of <a href="matlab:help Settings">Settings</a>.
	%
	% An Axis Settings (SettingsAxis) provides the settings for an axis, 
	%  including axis color, hold on/off, axis on/off, grid on/off, equal on/off, 
	%  box on/off, and tight on/off.
	% The handle can be an axes (uiaxes).
	%
	% SettingsAxis methods (constructor):
	%  SettingsAxis - constructor
	%
	% SettingsAxis methods:
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
	% SettingsAxis methods (display):
	%  tostring - string with information about the axis settings
	%  disp - displays information about the axis settings
	%  tree - displays the tree of the axis settings
	%
	% SettingsAxis methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two axis settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the axis settings
	%
	% SettingsAxis methods (save/load, Static):
	%  save - saves BRAPH2 axis settings as b2 file
	%  load - loads a BRAPH2 axis settings from a b2 file
	%
	% SettingsAxis method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the axis settings
	%
	% SettingsAxis method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the axis settings
	%
	% SettingsAxis methods (inspection, Static):
	%  getClass - returns the class of the axis settings
	%  getSubclasses - returns all subclasses of SettingsAxis
	%  getProps - returns the property list of the axis settings
	%  getPropNumber - returns the property number of the axis settings
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
	% SettingsAxis methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsAxis methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsAxis methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsAxis methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsAxis; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsAxis constants</a>.
	%
	%
	% See also uiaxes, SettingsAxisPP, PanelFig, GUIFig, check_graphics.
	
	properties (Constant) % properties
		AXISCOLOR = Settings.getPropNumber() + 1;
		AXISCOLOR_TAG = 'AXISCOLOR';
		AXISCOLOR_CATEGORY = Category.FIGURE;
		AXISCOLOR_FORMAT = Format.COLOR;
		
		HOLD = Settings.getPropNumber() + 2;
		HOLD_TAG = 'HOLD';
		HOLD_CATEGORY = Category.FIGURE;
		HOLD_FORMAT = Format.LOGICAL;
		
		GRID = Settings.getPropNumber() + 3;
		GRID_TAG = 'GRID';
		GRID_CATEGORY = Category.FIGURE;
		GRID_FORMAT = Format.LOGICAL;
		
		AXIS = Settings.getPropNumber() + 4;
		AXIS_TAG = 'AXIS';
		AXIS_CATEGORY = Category.FIGURE;
		AXIS_FORMAT = Format.LOGICAL;
		
		EQUAL = Settings.getPropNumber() + 5;
		EQUAL_TAG = 'EQUAL';
		EQUAL_CATEGORY = Category.FIGURE;
		EQUAL_FORMAT = Format.LOGICAL;
		
		TIGHT = Settings.getPropNumber() + 6;
		TIGHT_TAG = 'TIGHT';
		TIGHT_CATEGORY = Category.FIGURE;
		TIGHT_FORMAT = Format.LOGICAL;
		
		BOX = Settings.getPropNumber() + 7;
		BOX_TAG = 'BOX';
		BOX_CATEGORY = Category.FIGURE;
		BOX_FORMAT = Format.LOGICAL;
	end
	methods % constructor
		function st = SettingsAxis(varargin)
			%SettingsAxis() creates a axis settings.
			%
			% SettingsAxis(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsAxis(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			st = st@Settings(varargin{:});
		end
	end
	methods (Static) % inspection
		function st_class = getClass()
			%GETCLASS returns the class of the axis settings.
			%
			% CLASS = SettingsAxis.GETCLASS() returns the class 'SettingsAxis'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ST.GETCLASS() returns the class of the axis settings ST.
			%  CLASS = Element.GETCLASS(ST) returns the class of 'ST'.
			%  CLASS = Element.GETCLASS('SettingsAxis') returns 'SettingsAxis'.
			%
			% Note that the Element.GETCLASS(ST) and Element.GETCLASS('SettingsAxis')
			%  are less computationally efficient.
			
			st_class = 'SettingsAxis';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the axis settings.
			%
			% LIST = SettingsAxis.GETSUBCLASSES() returns all subclasses of 'SettingsAxis'.
			%
			% Alternative forms to call this method are:
			%  LIST = ST.GETSUBCLASSES() returns all subclasses of the axis settings ST.
			%  LIST = Element.GETSUBCLASSES(ST) returns all subclasses of 'ST'.
			%  LIST = Element.GETSUBCLASSES('SettingsAxis') returns all subclasses of 'SettingsAxis'.
			%
			% Note that the Element.GETSUBCLASSES(ST) and Element.GETSUBCLASSES('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SettingsAxis', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of axis settings.
			%
			% PROPS = SettingsAxis.GETPROPS() returns the property list of axis settings
			%  as a row vector.
			%
			% PROPS = SettingsAxis.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ST.GETPROPS([CATEGORY]) returns the property list of the axis settings ST.
			%  PROPS = Element.GETPROPS(ST[, CATEGORY]) returns the property list of 'ST'.
			%  PROPS = Element.GETPROPS('SettingsAxis'[, CATEGORY]) returns the property list of 'SettingsAxis'.
			%
			% Note that the Element.GETPROPS(ST) and Element.GETPROPS('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Settings.getProps() ...
						SettingsAxis.AXISCOLOR ...
						SettingsAxis.HOLD ...
						SettingsAxis.GRID ...
						SettingsAxis.AXIS ...
						SettingsAxis.EQUAL ...
						SettingsAxis.TIGHT ...
						SettingsAxis.BOX ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Settings.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Settings.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Settings.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						Settings.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						Settings.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Settings.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Settings.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Settings.getProps(Category.FIGURE) ...
						SettingsAxis.AXISCOLOR ...
						SettingsAxis.HOLD ...
						SettingsAxis.GRID ...
						SettingsAxis.AXIS ...
						SettingsAxis.EQUAL ...
						SettingsAxis.TIGHT ...
						SettingsAxis.BOX ...
						];
				case Category.GUI
					prop_list = [ ...
						Settings.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of axis settings.
			%
			% N = SettingsAxis.GETPROPNUMBER() returns the property number of axis settings.
			%
			% N = SettingsAxis.GETPROPNUMBER(CATEGORY) returns the property number of axis settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ST.GETPROPNUMBER([CATEGORY]) returns the property number of the axis settings ST.
			%  N = Element.GETPROPNUMBER(ST) returns the property number of 'ST'.
			%  N = Element.GETPROPNUMBER('SettingsAxis') returns the property number of 'SettingsAxis'.
			%
			% Note that the Element.GETPROPNUMBER(ST) and Element.GETPROPNUMBER('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SettingsAxis.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in axis settings/error.
			%
			% CHECK = SettingsAxis.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSPROP(PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(ST, PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(SettingsAxis, PROP) checks whether PROP exists for SettingsAxis.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsAxis:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSPROP(PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsAxis:WrongInput]
			%  Element.EXISTSPROP(ST, PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsAxis:WrongInput]
			%  Element.EXISTSPROP(SettingsAxis, PROP) throws error if PROP does NOT exist for SettingsAxis.
			%   Error id: [BRAPH2:SettingsAxis:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ST) and Element.EXISTSPROP('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SettingsAxis.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsAxis:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsAxis:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsAxis.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in axis settings/error.
			%
			% CHECK = SettingsAxis.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSTAG(TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(ST, TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(SettingsAxis, TAG) checks whether TAG exists for SettingsAxis.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsAxis:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSTAG(TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsAxis:WrongInput]
			%  Element.EXISTSTAG(ST, TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsAxis:WrongInput]
			%  Element.EXISTSTAG(SettingsAxis, TAG) throws error if TAG does NOT exist for SettingsAxis.
			%   Error id: [BRAPH2:SettingsAxis:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ST) and Element.EXISTSTAG('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			settingsaxis_tag_list = cellfun(@(x) SettingsAxis.getPropTag(x), num2cell(SettingsAxis.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, settingsaxis_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsAxis:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsAxis:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SettingsAxis.'] ...
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
			%  PROPERTY = ST.GETPROPPROP(POINTER) returns property number of POINTER of ST.
			%  PROPERTY = Element.GETPROPPROP(SettingsAxis, POINTER) returns property number of POINTER of SettingsAxis.
			%  PROPERTY = ST.GETPROPPROP(SettingsAxis, POINTER) returns property number of POINTER of SettingsAxis.
			%
			% Note that the Element.GETPROPPROP(ST) and Element.GETPROPPROP('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				settingsaxis_tag_list = cellfun(@(x) SettingsAxis.getPropTag(x), num2cell(SettingsAxis.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, settingsaxis_tag_list)); % tag = pointer
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
			%  TAG = ST.GETPROPTAG(POINTER) returns tag of POINTER of ST.
			%  TAG = Element.GETPROPTAG(SettingsAxis, POINTER) returns tag of POINTER of SettingsAxis.
			%  TAG = ST.GETPROPTAG(SettingsAxis, POINTER) returns tag of POINTER of SettingsAxis.
			%
			% Note that the Element.GETPROPTAG(ST) and Element.GETPROPTAG('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SettingsAxis.AXISCOLOR
						tag = SettingsAxis.AXISCOLOR_TAG;
					case SettingsAxis.HOLD
						tag = SettingsAxis.HOLD_TAG;
					case SettingsAxis.GRID
						tag = SettingsAxis.GRID_TAG;
					case SettingsAxis.AXIS
						tag = SettingsAxis.AXIS_TAG;
					case SettingsAxis.EQUAL
						tag = SettingsAxis.EQUAL_TAG;
					case SettingsAxis.TIGHT
						tag = SettingsAxis.TIGHT_TAG;
					case SettingsAxis.BOX
						tag = SettingsAxis.BOX_TAG;
					otherwise
						tag = getPropTag@Settings(prop);
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
			%  CATEGORY = ST.GETPROPCATEGORY(POINTER) returns category of POINTER of ST.
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsAxis, POINTER) returns category of POINTER of SettingsAxis.
			%  CATEGORY = ST.GETPROPCATEGORY(SettingsAxis, POINTER) returns category of POINTER of SettingsAxis.
			%
			% Note that the Element.GETPROPCATEGORY(ST) and Element.GETPROPCATEGORY('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsAxis.getPropProp(pointer);
			
			switch prop
				case SettingsAxis.AXISCOLOR
					prop_category = SettingsAxis.AXISCOLOR_CATEGORY;
				case SettingsAxis.HOLD
					prop_category = SettingsAxis.HOLD_CATEGORY;
				case SettingsAxis.GRID
					prop_category = SettingsAxis.GRID_CATEGORY;
				case SettingsAxis.AXIS
					prop_category = SettingsAxis.AXIS_CATEGORY;
				case SettingsAxis.EQUAL
					prop_category = SettingsAxis.EQUAL_CATEGORY;
				case SettingsAxis.TIGHT
					prop_category = SettingsAxis.TIGHT_CATEGORY;
				case SettingsAxis.BOX
					prop_category = SettingsAxis.BOX_CATEGORY;
				otherwise
					prop_category = getPropCategory@Settings(prop);
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
			%  FORMAT = ST.GETPROPFORMAT(POINTER) returns format of POINTER of ST.
			%  FORMAT = Element.GETPROPFORMAT(SettingsAxis, POINTER) returns format of POINTER of SettingsAxis.
			%  FORMAT = ST.GETPROPFORMAT(SettingsAxis, POINTER) returns format of POINTER of SettingsAxis.
			%
			% Note that the Element.GETPROPFORMAT(ST) and Element.GETPROPFORMAT('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsAxis.getPropProp(pointer);
			
			switch prop
				case SettingsAxis.AXISCOLOR
					prop_format = SettingsAxis.AXISCOLOR_FORMAT;
				case SettingsAxis.HOLD
					prop_format = SettingsAxis.HOLD_FORMAT;
				case SettingsAxis.GRID
					prop_format = SettingsAxis.GRID_FORMAT;
				case SettingsAxis.AXIS
					prop_format = SettingsAxis.AXIS_FORMAT;
				case SettingsAxis.EQUAL
					prop_format = SettingsAxis.EQUAL_FORMAT;
				case SettingsAxis.TIGHT
					prop_format = SettingsAxis.TIGHT_FORMAT;
				case SettingsAxis.BOX
					prop_format = SettingsAxis.BOX_FORMAT;
				otherwise
					prop_format = getPropFormat@Settings(prop);
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
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(POINTER) returns description of POINTER of ST.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsAxis, POINTER) returns description of POINTER of SettingsAxis.
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(SettingsAxis, POINTER) returns description of POINTER of SettingsAxis.
			%
			% Note that the Element.GETPROPDESCRIPTION(ST) and Element.GETPROPDESCRIPTION('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsAxis.getPropProp(pointer);
			
			switch prop
				case SettingsAxis.AXISCOLOR
					prop_description = 'AXISCOLOR (figure, color) is the axis background color.';
				case SettingsAxis.HOLD
					prop_description = 'HOLD (figure, logical) determines whether hold is on or off.';
				case SettingsAxis.GRID
					prop_description = 'GRID (figure, logical) determines whether the grid is shown.';
				case SettingsAxis.AXIS
					prop_description = 'AXIS (figure, logical) determines whether the axis is shown.';
				case SettingsAxis.EQUAL
					prop_description = 'EQUAL (figure, logical) determines whether the axis are equal.';
				case SettingsAxis.TIGHT
					prop_description = 'TIGHT (figure, logical) determines whether the axis are tight.';
				case SettingsAxis.BOX
					prop_description = 'BOX (figure, logical) determines whether the axis are boxed.';
				case SettingsAxis.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the axis settings.';
				case SettingsAxis.NAME
					prop_description = 'NAME (constant, string) is the name of the axis settings.';
				case SettingsAxis.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the axis settings.';
				case SettingsAxis.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the axis settings.';
				case SettingsAxis.ID
					prop_description = 'ID (data, string) is a few-letter code for the axis settings.';
				case SettingsAxis.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the axis settings.';
				case SettingsAxis.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the axis settings.';
				otherwise
					prop_description = getPropDescription@Settings(prop);
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
			%  SETTINGS = ST.GETPROPSETTINGS(POINTER) returns settings of POINTER of ST.
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsAxis, POINTER) returns settings of POINTER of SettingsAxis.
			%  SETTINGS = ST.GETPROPSETTINGS(SettingsAxis, POINTER) returns settings of POINTER of SettingsAxis.
			%
			% Note that the Element.GETPROPSETTINGS(ST) and Element.GETPROPSETTINGS('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsAxis.getPropProp(pointer);
			
			switch prop
				case SettingsAxis.AXISCOLOR
					prop_settings = Format.getFormatSettings(Format.COLOR);
				case SettingsAxis.HOLD
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SettingsAxis.GRID
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SettingsAxis.AXIS
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SettingsAxis.EQUAL
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SettingsAxis.TIGHT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SettingsAxis.BOX
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SettingsAxis.TEMPLATE
					prop_settings = 'SettingsAxis';
				otherwise
					prop_settings = getPropSettings@Settings(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsAxis.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsAxis.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsAxis, POINTER) returns the default value of POINTER of SettingsAxis.
			%  DEFAULT = ST.GETPROPDEFAULT(SettingsAxis, POINTER) returns the default value of POINTER of SettingsAxis.
			%
			% Note that the Element.GETPROPDEFAULT(ST) and Element.GETPROPDEFAULT('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsAxis.getPropProp(pointer);
			
			switch prop
				case SettingsAxis.AXISCOLOR
					prop_default = [1 1 1];
				case SettingsAxis.HOLD
					prop_default = true;
				case SettingsAxis.GRID
					prop_default = false;
				case SettingsAxis.AXIS
					prop_default = true;
				case SettingsAxis.EQUAL
					prop_default = true;
				case SettingsAxis.TIGHT
					prop_default = false;
				case SettingsAxis.BOX
					prop_default = false;
				case SettingsAxis.ELCLASS
					prop_default = 'SettingsAxis';
				case SettingsAxis.NAME
					prop_default = 'Axis Settings';
				case SettingsAxis.DESCRIPTION
					prop_default = 'An Axis Settings (SettingsAxis) provides the settings for an axis, including axis color, hold on/off, axis on/off, grid on/off, equal on/off, box on/off, and tight on/off. The handle can be an axes (uiaxes).';
				case SettingsAxis.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, SettingsAxis.getPropSettings(prop));
				case SettingsAxis.ID
					prop_default = 'SettingsAxis ID';
				case SettingsAxis.LABEL
					prop_default = 'SettingsAxis label';
				case SettingsAxis.NOTES
					prop_default = 'SettingsAxis notes';
				otherwise
					prop_default = getPropDefault@Settings(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsAxis.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsAxis.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsAxis, POINTER) returns the conditioned default value of POINTER of SettingsAxis.
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(SettingsAxis, POINTER) returns the conditioned default value of POINTER of SettingsAxis.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ST) and Element.GETPROPDEFAULTCONDITIONED('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsAxis.getPropProp(pointer);
			
			prop_default = SettingsAxis.conditioning(prop, SettingsAxis.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = ST.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = ST.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of ST.
			%  CHECK = Element.CHECKPROP(SettingsAxis, PROP, VALUE) checks VALUE format for PROP of SettingsAxis.
			%  CHECK = ST.CHECKPROP(SettingsAxis, PROP, VALUE) checks VALUE format for PROP of SettingsAxis.
			% 
			% ST.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SettingsAxis:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ST.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ST.
			%   Error id: €BRAPH2.STR€:SettingsAxis:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SettingsAxis, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsAxis.
			%   Error id: €BRAPH2.STR€:SettingsAxis:€BRAPH2.WRONG_INPUT€
			%  ST.CHECKPROP(SettingsAxis, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsAxis.
			%   Error id: €BRAPH2.STR€:SettingsAxis:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(ST) and Element.CHECKPROP('SettingsAxis')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsAxis.getPropProp(pointer);
			
			switch prop
				case SettingsAxis.AXISCOLOR % __SettingsAxis.AXISCOLOR__
					check = Format.checkFormat(Format.COLOR, value, SettingsAxis.getPropSettings(prop));
				case SettingsAxis.HOLD % __SettingsAxis.HOLD__
					check = Format.checkFormat(Format.LOGICAL, value, SettingsAxis.getPropSettings(prop));
				case SettingsAxis.GRID % __SettingsAxis.GRID__
					check = Format.checkFormat(Format.LOGICAL, value, SettingsAxis.getPropSettings(prop));
				case SettingsAxis.AXIS % __SettingsAxis.AXIS__
					check = Format.checkFormat(Format.LOGICAL, value, SettingsAxis.getPropSettings(prop));
				case SettingsAxis.EQUAL % __SettingsAxis.EQUAL__
					check = Format.checkFormat(Format.LOGICAL, value, SettingsAxis.getPropSettings(prop));
				case SettingsAxis.TIGHT % __SettingsAxis.TIGHT__
					check = Format.checkFormat(Format.LOGICAL, value, SettingsAxis.getPropSettings(prop));
				case SettingsAxis.BOX % __SettingsAxis.BOX__
					check = Format.checkFormat(Format.LOGICAL, value, SettingsAxis.getPropSettings(prop));
				case SettingsAxis.TEMPLATE % __SettingsAxis.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, SettingsAxis.getPropSettings(prop));
				otherwise
					if prop <= Settings.getPropNumber()
						check = checkProp@Settings(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsAxis:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsAxis:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsAxis.getPropTag(prop) ' (' SettingsAxis.getFormatTag(SettingsAxis.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(st, prop)
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
				case SettingsAxis.AXISCOLOR % __SettingsAxis.AXISCOLOR__
					a = st.get('H');
					if check_graphics(a, 'axes')
					    if ~isequal(get(a, 'Color'), st.get('AXISCOLOR'))
					        set(a, 'Color', st.get('AXISCOLOR'))
					    end
					end
					
				case SettingsAxis.HOLD % __SettingsAxis.HOLD__
					a = st.get('H');
					if check_graphics(a, 'axes')
					    if st.get('HOLD')
					        hold(a, 'on')
					    else
					        hold(a, 'off')
					    end
					end
					
				case SettingsAxis.GRID % __SettingsAxis.GRID__
					a = st.get('H');
					if check_graphics(a, 'axes')
					    if st.get('GRID')
					        grid(a, 'on')
					    else
					        grid(a, 'off')
					    end
					end
					
				case SettingsAxis.AXIS % __SettingsAxis.AXIS__
					a = st.get('H');
					if check_graphics(a, 'axes')
					    if st.get('AXIS')
					        axis(a, 'on')
					    else
					        axis(a, 'off')
					    end
					end
					
				case SettingsAxis.EQUAL % __SettingsAxis.EQUAL__
					a = st.get('H');
					if check_graphics(a, 'axes')
					    if st.get('EQUAL')
					        daspect(a, [1 1 1])
					    else
					        daspect(a, 'auto')
					    end
					end
					
				case SettingsAxis.TIGHT % __SettingsAxis.TIGHT__
					a = st.get('H');
					if check_graphics(a, 'axes')
					    if st.get('TIGHT')
					        axis(a, 'tight')
					    end
					end
					
				case SettingsAxis.BOX % __SettingsAxis.BOX__
					a = st.get('H');
					if check_graphics(a, 'axes')
					    if st.get('BOX')
					        box(a, 'on')
					    else
					        box(a, 'off')
					    end
					end
					
				otherwise
					if prop <= Settings.getPropNumber()
						postset@Settings(st, prop);
					end
			end
		end
	end
end
