classdef SettingsAmbient < Settings
	%SettingsAmbient contains the ambient settings.
	% It is a subclass of <a href="matlab:help Settings">Settings</a>.
	%
	% An Ambient Settings (SettingsAmbient) provides the settings 
	%  for the ambient lightning and material, including lighting, material, 
	%  camlight, shading, and colormap.
	% The handle can be an axes (uiaxes).
	%
	% SettingsAmbient methods (constructor):
	%  SettingsAmbient - constructor
	%
	% SettingsAmbient methods:
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
	% SettingsAmbient methods (display):
	%  tostring - string with information about the ambient settings
	%  disp - displays information about the ambient settings
	%  tree - displays the tree of the ambient settings
	%
	% SettingsAmbient methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two ambient settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the ambient settings
	%
	% SettingsAmbient methods (save/load, Static):
	%  save - saves BRAPH2 ambient settings as b2 file
	%  load - loads a BRAPH2 ambient settings from a b2 file
	%
	% SettingsAmbient method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ambient settings
	%
	% SettingsAmbient method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the ambient settings
	%
	% SettingsAmbient methods (inspection, Static):
	%  getClass - returns the class of the ambient settings
	%  getSubclasses - returns all subclasses of SettingsAmbient
	%  getProps - returns the property list of the ambient settings
	%  getPropNumber - returns the property number of the ambient settings
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
	% SettingsAmbient methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsAmbient methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsAmbient methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsAmbient methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsAmbient; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsAmbient constants</a>.
	%
	%
	% See also uiaxes, SettingsAmbientPP, PanelFig, GUIFig, check_graphics.
	
	properties (Constant) % properties
		LIGHTING = Settings.getPropNumber() + 1;
		LIGHTING_TAG = 'LIGHTING';
		LIGHTING_CATEGORY = Category.FIGURE;
		LIGHTING_FORMAT = Format.OPTION;
		
		MATERIAL = Settings.getPropNumber() + 2;
		MATERIAL_TAG = 'MATERIAL';
		MATERIAL_CATEGORY = Category.FIGURE;
		MATERIAL_FORMAT = Format.OPTION;
		
		CAMLIGHT = Settings.getPropNumber() + 3;
		CAMLIGHT_TAG = 'CAMLIGHT';
		CAMLIGHT_CATEGORY = Category.FIGURE;
		CAMLIGHT_FORMAT = Format.OPTION;
		
		SHADING = Settings.getPropNumber() + 4;
		SHADING_TAG = 'SHADING';
		SHADING_CATEGORY = Category.FIGURE;
		SHADING_FORMAT = Format.OPTION;
		
		COLORMAP = Settings.getPropNumber() + 5;
		COLORMAP_TAG = 'COLORMAP';
		COLORMAP_CATEGORY = Category.FIGURE;
		COLORMAP_FORMAT = Format.OPTION;
	end
	methods % constructor
		function st = SettingsAmbient(varargin)
			%SettingsAmbient() creates a ambient settings.
			%
			% SettingsAmbient(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsAmbient(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the ambient settings.
			%
			% CLASS = SettingsAmbient.GETCLASS() returns the class 'SettingsAmbient'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ST.GETCLASS() returns the class of the ambient settings ST.
			%  CLASS = Element.GETCLASS(ST) returns the class of 'ST'.
			%  CLASS = Element.GETCLASS('SettingsAmbient') returns 'SettingsAmbient'.
			%
			% Note that the Element.GETCLASS(ST) and Element.GETCLASS('SettingsAmbient')
			%  are less computationally efficient.
			
			st_class = 'SettingsAmbient';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the ambient settings.
			%
			% LIST = SettingsAmbient.GETSUBCLASSES() returns all subclasses of 'SettingsAmbient'.
			%
			% Alternative forms to call this method are:
			%  LIST = ST.GETSUBCLASSES() returns all subclasses of the ambient settings ST.
			%  LIST = Element.GETSUBCLASSES(ST) returns all subclasses of 'ST'.
			%  LIST = Element.GETSUBCLASSES('SettingsAmbient') returns all subclasses of 'SettingsAmbient'.
			%
			% Note that the Element.GETSUBCLASSES(ST) and Element.GETSUBCLASSES('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SettingsAmbient', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ambient settings.
			%
			% PROPS = SettingsAmbient.GETPROPS() returns the property list of ambient settings
			%  as a row vector.
			%
			% PROPS = SettingsAmbient.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ST.GETPROPS([CATEGORY]) returns the property list of the ambient settings ST.
			%  PROPS = Element.GETPROPS(ST[, CATEGORY]) returns the property list of 'ST'.
			%  PROPS = Element.GETPROPS('SettingsAmbient'[, CATEGORY]) returns the property list of 'SettingsAmbient'.
			%
			% Note that the Element.GETPROPS(ST) and Element.GETPROPS('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Settings.getProps() ...
						SettingsAmbient.LIGHTING ...
						SettingsAmbient.MATERIAL ...
						SettingsAmbient.CAMLIGHT ...
						SettingsAmbient.SHADING ...
						SettingsAmbient.COLORMAP ...
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
						SettingsAmbient.LIGHTING ...
						SettingsAmbient.MATERIAL ...
						SettingsAmbient.CAMLIGHT ...
						SettingsAmbient.SHADING ...
						SettingsAmbient.COLORMAP ...
						];
				case Category.GUI
					prop_list = [ ...
						Settings.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of ambient settings.
			%
			% N = SettingsAmbient.GETPROPNUMBER() returns the property number of ambient settings.
			%
			% N = SettingsAmbient.GETPROPNUMBER(CATEGORY) returns the property number of ambient settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ST.GETPROPNUMBER([CATEGORY]) returns the property number of the ambient settings ST.
			%  N = Element.GETPROPNUMBER(ST) returns the property number of 'ST'.
			%  N = Element.GETPROPNUMBER('SettingsAmbient') returns the property number of 'SettingsAmbient'.
			%
			% Note that the Element.GETPROPNUMBER(ST) and Element.GETPROPNUMBER('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SettingsAmbient.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in ambient settings/error.
			%
			% CHECK = SettingsAmbient.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSPROP(PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(ST, PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(SettingsAmbient, PROP) checks whether PROP exists for SettingsAmbient.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsAmbient:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSPROP(PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsAmbient:WrongInput]
			%  Element.EXISTSPROP(ST, PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsAmbient:WrongInput]
			%  Element.EXISTSPROP(SettingsAmbient, PROP) throws error if PROP does NOT exist for SettingsAmbient.
			%   Error id: [BRAPH2:SettingsAmbient:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ST) and Element.EXISTSPROP('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SettingsAmbient.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsAmbient:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsAmbient:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsAmbient.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ambient settings/error.
			%
			% CHECK = SettingsAmbient.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSTAG(TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(ST, TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(SettingsAmbient, TAG) checks whether TAG exists for SettingsAmbient.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsAmbient:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSTAG(TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsAmbient:WrongInput]
			%  Element.EXISTSTAG(ST, TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsAmbient:WrongInput]
			%  Element.EXISTSTAG(SettingsAmbient, TAG) throws error if TAG does NOT exist for SettingsAmbient.
			%   Error id: [BRAPH2:SettingsAmbient:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ST) and Element.EXISTSTAG('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			settingsambient_tag_list = cellfun(@(x) SettingsAmbient.getPropTag(x), num2cell(SettingsAmbient.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, settingsambient_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsAmbient:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsAmbient:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SettingsAmbient.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsAmbient, POINTER) returns property number of POINTER of SettingsAmbient.
			%  PROPERTY = ST.GETPROPPROP(SettingsAmbient, POINTER) returns property number of POINTER of SettingsAmbient.
			%
			% Note that the Element.GETPROPPROP(ST) and Element.GETPROPPROP('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				settingsambient_tag_list = cellfun(@(x) SettingsAmbient.getPropTag(x), num2cell(SettingsAmbient.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, settingsambient_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(SettingsAmbient, POINTER) returns tag of POINTER of SettingsAmbient.
			%  TAG = ST.GETPROPTAG(SettingsAmbient, POINTER) returns tag of POINTER of SettingsAmbient.
			%
			% Note that the Element.GETPROPTAG(ST) and Element.GETPROPTAG('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SettingsAmbient.LIGHTING
						tag = SettingsAmbient.LIGHTING_TAG;
					case SettingsAmbient.MATERIAL
						tag = SettingsAmbient.MATERIAL_TAG;
					case SettingsAmbient.CAMLIGHT
						tag = SettingsAmbient.CAMLIGHT_TAG;
					case SettingsAmbient.SHADING
						tag = SettingsAmbient.SHADING_TAG;
					case SettingsAmbient.COLORMAP
						tag = SettingsAmbient.COLORMAP_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsAmbient, POINTER) returns category of POINTER of SettingsAmbient.
			%  CATEGORY = ST.GETPROPCATEGORY(SettingsAmbient, POINTER) returns category of POINTER of SettingsAmbient.
			%
			% Note that the Element.GETPROPCATEGORY(ST) and Element.GETPROPCATEGORY('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsAmbient.getPropProp(pointer);
			
			switch prop
				case SettingsAmbient.LIGHTING
					prop_category = SettingsAmbient.LIGHTING_CATEGORY;
				case SettingsAmbient.MATERIAL
					prop_category = SettingsAmbient.MATERIAL_CATEGORY;
				case SettingsAmbient.CAMLIGHT
					prop_category = SettingsAmbient.CAMLIGHT_CATEGORY;
				case SettingsAmbient.SHADING
					prop_category = SettingsAmbient.SHADING_CATEGORY;
				case SettingsAmbient.COLORMAP
					prop_category = SettingsAmbient.COLORMAP_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsAmbient, POINTER) returns format of POINTER of SettingsAmbient.
			%  FORMAT = ST.GETPROPFORMAT(SettingsAmbient, POINTER) returns format of POINTER of SettingsAmbient.
			%
			% Note that the Element.GETPROPFORMAT(ST) and Element.GETPROPFORMAT('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsAmbient.getPropProp(pointer);
			
			switch prop
				case SettingsAmbient.LIGHTING
					prop_format = SettingsAmbient.LIGHTING_FORMAT;
				case SettingsAmbient.MATERIAL
					prop_format = SettingsAmbient.MATERIAL_FORMAT;
				case SettingsAmbient.CAMLIGHT
					prop_format = SettingsAmbient.CAMLIGHT_FORMAT;
				case SettingsAmbient.SHADING
					prop_format = SettingsAmbient.SHADING_FORMAT;
				case SettingsAmbient.COLORMAP
					prop_format = SettingsAmbient.COLORMAP_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsAmbient, POINTER) returns description of POINTER of SettingsAmbient.
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(SettingsAmbient, POINTER) returns description of POINTER of SettingsAmbient.
			%
			% Note that the Element.GETPROPDESCRIPTION(ST) and Element.GETPROPDESCRIPTION('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsAmbient.getPropProp(pointer);
			
			switch prop
				case SettingsAmbient.LIGHTING
					prop_description = 'LIGHTING (figure, option) is the lighting value.';
				case SettingsAmbient.MATERIAL
					prop_description = 'MATERIAL (figure, option) is the material value.';
				case SettingsAmbient.CAMLIGHT
					prop_description = 'CAMLIGHT (figure, option) is the camlight value.';
				case SettingsAmbient.SHADING
					prop_description = 'SHADING (figure, option) is the shading value.';
				case SettingsAmbient.COLORMAP
					prop_description = 'COLORMAP (figure, option) is the colormap.';
				case SettingsAmbient.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the ambient settings.';
				case SettingsAmbient.NAME
					prop_description = 'NAME (constant, string) is the name of the ambient settings.';
				case SettingsAmbient.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the ambient settings.';
				case SettingsAmbient.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the ambient settings.';
				case SettingsAmbient.ID
					prop_description = 'ID (data, string) is a few-letter code for the ambient settings.';
				case SettingsAmbient.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the ambient settings.';
				case SettingsAmbient.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the ambient settings.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsAmbient, POINTER) returns settings of POINTER of SettingsAmbient.
			%  SETTINGS = ST.GETPROPSETTINGS(SettingsAmbient, POINTER) returns settings of POINTER of SettingsAmbient.
			%
			% Note that the Element.GETPROPSETTINGS(ST) and Element.GETPROPSETTINGS('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsAmbient.getPropProp(pointer);
			
			switch prop
				case SettingsAmbient.LIGHTING
					prop_settings = {'none' 'phong' 'flat' 'gouraud'};
				case SettingsAmbient.MATERIAL
					prop_settings = {'shiny' 'dull' 'metal'};
				case SettingsAmbient.CAMLIGHT
					prop_settings = {'none' 'headlight' 'headlight (x2)' 'headlight (x3)' 'right' 'right (x2)' 'right (x3)' 'left' 'left (x2)' 'left (x3)'};
				case SettingsAmbient.SHADING
					prop_settings = {'none' 'interp' 'flat' 'faceted'};
				case SettingsAmbient.COLORMAP
					prop_settings = {'none', 'white', 'parula', 'jet', 'hsv', 'hot', 'cool', 'spring', 'summer', 'autumn', 'winter', 'gray', 'bone', 'copper', 'pink', 'lines', 'colorcube', 'prism', 'flag'};
				case SettingsAmbient.TEMPLATE
					prop_settings = 'SettingsAmbient';
				otherwise
					prop_settings = getPropSettings@Settings(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsAmbient.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsAmbient.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsAmbient, POINTER) returns the default value of POINTER of SettingsAmbient.
			%  DEFAULT = ST.GETPROPDEFAULT(SettingsAmbient, POINTER) returns the default value of POINTER of SettingsAmbient.
			%
			% Note that the Element.GETPROPDEFAULT(ST) and Element.GETPROPDEFAULT('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsAmbient.getPropProp(pointer);
			
			switch prop
				case SettingsAmbient.LIGHTING
					prop_default = 'gouraud';
				case SettingsAmbient.MATERIAL
					prop_default = 'shiny';
				case SettingsAmbient.CAMLIGHT
					prop_default = 'headlight (x2)';
				case SettingsAmbient.SHADING
					prop_default = 'none';
				case SettingsAmbient.COLORMAP
					prop_default = 'none';
				case SettingsAmbient.ELCLASS
					prop_default = 'SettingsAmbient';
				case SettingsAmbient.NAME
					prop_default = 'Ambient Settings';
				case SettingsAmbient.DESCRIPTION
					prop_default = 'An Ambient Settings (SettingsAmbient) provides the settings for the ambient lightning and material, including lighting, material, camlight, shading, and colormap. The handle can be an axes (uiaxes).';
				case SettingsAmbient.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, SettingsAmbient.getPropSettings(prop));
				case SettingsAmbient.ID
					prop_default = 'SettingsAmbient ID';
				case SettingsAmbient.LABEL
					prop_default = 'SettingsAmbient label';
				case SettingsAmbient.NOTES
					prop_default = 'SettingsAmbient notes';
				otherwise
					prop_default = getPropDefault@Settings(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsAmbient.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsAmbient.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsAmbient, POINTER) returns the conditioned default value of POINTER of SettingsAmbient.
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(SettingsAmbient, POINTER) returns the conditioned default value of POINTER of SettingsAmbient.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ST) and Element.GETPROPDEFAULTCONDITIONED('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsAmbient.getPropProp(pointer);
			
			prop_default = SettingsAmbient.conditioning(prop, SettingsAmbient.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsAmbient, PROP, VALUE) checks VALUE format for PROP of SettingsAmbient.
			%  CHECK = ST.CHECKPROP(SettingsAmbient, PROP, VALUE) checks VALUE format for PROP of SettingsAmbient.
			% 
			% ST.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SettingsAmbient:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ST.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ST.
			%   Error id: €BRAPH2.STR€:SettingsAmbient:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SettingsAmbient, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsAmbient.
			%   Error id: €BRAPH2.STR€:SettingsAmbient:€BRAPH2.WRONG_INPUT€
			%  ST.CHECKPROP(SettingsAmbient, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsAmbient.
			%   Error id: €BRAPH2.STR€:SettingsAmbient:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(ST) and Element.CHECKPROP('SettingsAmbient')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsAmbient.getPropProp(pointer);
			
			switch prop
				case SettingsAmbient.LIGHTING % __SettingsAmbient.LIGHTING__
					check = Format.checkFormat(Format.OPTION, value, SettingsAmbient.getPropSettings(prop));
				case SettingsAmbient.MATERIAL % __SettingsAmbient.MATERIAL__
					check = Format.checkFormat(Format.OPTION, value, SettingsAmbient.getPropSettings(prop));
				case SettingsAmbient.CAMLIGHT % __SettingsAmbient.CAMLIGHT__
					check = Format.checkFormat(Format.OPTION, value, SettingsAmbient.getPropSettings(prop));
				case SettingsAmbient.SHADING % __SettingsAmbient.SHADING__
					check = Format.checkFormat(Format.OPTION, value, SettingsAmbient.getPropSettings(prop));
				case SettingsAmbient.COLORMAP % __SettingsAmbient.COLORMAP__
					check = Format.checkFormat(Format.OPTION, value, SettingsAmbient.getPropSettings(prop));
				case SettingsAmbient.TEMPLATE % __SettingsAmbient.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, SettingsAmbient.getPropSettings(prop));
				otherwise
					if prop <= Settings.getPropNumber()
						check = checkProp@Settings(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsAmbient:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsAmbient:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsAmbient.getPropTag(prop) ' (' SettingsAmbient.getFormatTag(SettingsAmbient.getPropFormat(prop)) ').'] ...
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
				case SettingsAmbient.LIGHTING % __SettingsAmbient.LIGHTING__
					a = st.get('H');
					if check_graphics(a, 'axes')
					    lighting(a, st.get('LIGHTING'))
					end
					
				case SettingsAmbient.MATERIAL % __SettingsAmbient.MATERIAL__
					a = st.get('H');
					if check_graphics(a, 'axes')
					    material(a, st.get('MATERIAL'))
					end
					
				case SettingsAmbient.CAMLIGHT % __SettingsAmbient.CAMLIGHT__
					a = st.get('H');
					if check_graphics(a, 'axes')
					    delete(findall(a, 'Type', 'light'))    
					    switch st.get('CAMLIGHT')
					        case 'headlight' 
					            camlight(a, 'headlight');
					        case 'headlight (x2)'
					            camlight(a, 'headlight');
					            camlight(a, 'headlight');
					        case 'headlight (x3)'
					            camlight(a, 'headlight');
					            camlight(a, 'headlight');
					            camlight(a, 'headlight');
					        case 'right'
					            camlight(a, 'right');
					        case 'right (x2)'
					            camlight(a, 'right');
					            camlight(a, 'right');
					        case 'right (x3)'
					            camlight(a, 'right');
					            camlight(a, 'right');
					            camlight(a, 'right');
					        case 'left'
					            camlight(a, 'left');
					        case 'left (x2)'
					            camlight(a, 'left');
					            camlight(a, 'left');
					        case 'left (x3)'
					            camlight(a, 'left');
					            camlight(a, 'left');
					            camlight(a, 'left');
					    end
					end
					
				case SettingsAmbient.SHADING % __SettingsAmbient.SHADING__
					a = st.get('H');
					if check_graphics(a, 'axes')
					    if ~strcmpi(st.get('SHADING'), 'none') && ~strcmpi(st.get('COLORMAP'), 'none')
					        colormap(a, st.get('COLORMAP'))
					        shading(a, st.get('SHADING'))
					    end
					end
					
				case SettingsAmbient.COLORMAP % __SettingsAmbient.COLORMAP__
					a = st.get('H');
					if check_graphics(a, 'axes')
					    if ~strcmpi(st.get('SHADING'), 'none') && ~strcmpi(st.get('COLORMAP'), 'none')
					        colormap(a, st.get('COLORMAP'))
					        shading(a, st.get('SHADING'))
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
