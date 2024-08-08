classdef SettingsPosition < Settings
	%SettingsPosition contains the figure panel position settings.
	% It is a subclass of <a href="matlab:help Settings">Settings</a>.
	%
	% A Position Settings (SettingsPosition) provides the settings 
	%  for a posistion settings panel, including autopositioning, x0, y0, height 
	%  and width.
	% The handle can be an uipanel.
	%
	% SettingsPosition methods (constructor):
	%  SettingsPosition - constructor
	%
	% SettingsPosition methods:
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
	% SettingsPosition methods (display):
	%  tostring - string with information about the position settings
	%  disp - displays information about the position settings
	%  tree - displays the tree of the position settings
	%
	% SettingsPosition methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two position settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the position settings
	%
	% SettingsPosition methods (save/load, Static):
	%  save - saves BRAPH2 position settings as b2 file
	%  load - loads a BRAPH2 position settings from a b2 file
	%
	% SettingsPosition method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the position settings
	%
	% SettingsPosition method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the position settings
	%
	% SettingsPosition methods (inspection, Static):
	%  getClass - returns the class of the position settings
	%  getSubclasses - returns all subclasses of SettingsPosition
	%  getProps - returns the property list of the position settings
	%  getPropNumber - returns the property number of the position settings
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
	% SettingsPosition methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsPosition methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsPosition methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsPosition methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsPosition; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsPosition constants</a>.
	%
	%
	% See also uipanel, SettingsPositionPP, PanelFig, GUIFig, check_graphics.
	
	properties (Constant) % properties
		AUTOPOS = Settings.getPropNumber() + 1;
		AUTOPOS_TAG = 'AUTOPOS';
		AUTOPOS_CATEGORY = Category.FIGURE;
		AUTOPOS_FORMAT = Format.LOGICAL;
		
		X0 = Settings.getPropNumber() + 2;
		X0_TAG = 'X0';
		X0_CATEGORY = Category.FIGURE;
		X0_FORMAT = Format.SCALAR;
		
		Y0 = Settings.getPropNumber() + 3;
		Y0_TAG = 'Y0';
		Y0_CATEGORY = Category.FIGURE;
		Y0_FORMAT = Format.SCALAR;
		
		WIDTH = Settings.getPropNumber() + 4;
		WIDTH_TAG = 'WIDTH';
		WIDTH_CATEGORY = Category.FIGURE;
		WIDTH_FORMAT = Format.SIZE;
		
		HEIGHT = Settings.getPropNumber() + 5;
		HEIGHT_TAG = 'HEIGHT';
		HEIGHT_CATEGORY = Category.FIGURE;
		HEIGHT_FORMAT = Format.SIZE;
	end
	methods % constructor
		function st = SettingsPosition(varargin)
			%SettingsPosition() creates a position settings.
			%
			% SettingsPosition(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsPosition(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the position settings.
			%
			% CLASS = SettingsPosition.GETCLASS() returns the class 'SettingsPosition'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ST.GETCLASS() returns the class of the position settings ST.
			%  CLASS = Element.GETCLASS(ST) returns the class of 'ST'.
			%  CLASS = Element.GETCLASS('SettingsPosition') returns 'SettingsPosition'.
			%
			% Note that the Element.GETCLASS(ST) and Element.GETCLASS('SettingsPosition')
			%  are less computationally efficient.
			
			st_class = 'SettingsPosition';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the position settings.
			%
			% LIST = SettingsPosition.GETSUBCLASSES() returns all subclasses of 'SettingsPosition'.
			%
			% Alternative forms to call this method are:
			%  LIST = ST.GETSUBCLASSES() returns all subclasses of the position settings ST.
			%  LIST = Element.GETSUBCLASSES(ST) returns all subclasses of 'ST'.
			%  LIST = Element.GETSUBCLASSES('SettingsPosition') returns all subclasses of 'SettingsPosition'.
			%
			% Note that the Element.GETSUBCLASSES(ST) and Element.GETSUBCLASSES('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SettingsPosition', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of position settings.
			%
			% PROPS = SettingsPosition.GETPROPS() returns the property list of position settings
			%  as a row vector.
			%
			% PROPS = SettingsPosition.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ST.GETPROPS([CATEGORY]) returns the property list of the position settings ST.
			%  PROPS = Element.GETPROPS(ST[, CATEGORY]) returns the property list of 'ST'.
			%  PROPS = Element.GETPROPS('SettingsPosition'[, CATEGORY]) returns the property list of 'SettingsPosition'.
			%
			% Note that the Element.GETPROPS(ST) and Element.GETPROPS('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Settings.getProps() ...
						SettingsPosition.AUTOPOS ...
						SettingsPosition.X0 ...
						SettingsPosition.Y0 ...
						SettingsPosition.WIDTH ...
						SettingsPosition.HEIGHT ...
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
						SettingsPosition.AUTOPOS ...
						SettingsPosition.X0 ...
						SettingsPosition.Y0 ...
						SettingsPosition.WIDTH ...
						SettingsPosition.HEIGHT ...
						];
				case Category.GUI
					prop_list = [ ...
						Settings.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of position settings.
			%
			% N = SettingsPosition.GETPROPNUMBER() returns the property number of position settings.
			%
			% N = SettingsPosition.GETPROPNUMBER(CATEGORY) returns the property number of position settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ST.GETPROPNUMBER([CATEGORY]) returns the property number of the position settings ST.
			%  N = Element.GETPROPNUMBER(ST) returns the property number of 'ST'.
			%  N = Element.GETPROPNUMBER('SettingsPosition') returns the property number of 'SettingsPosition'.
			%
			% Note that the Element.GETPROPNUMBER(ST) and Element.GETPROPNUMBER('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SettingsPosition.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in position settings/error.
			%
			% CHECK = SettingsPosition.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSPROP(PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(ST, PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(SettingsPosition, PROP) checks whether PROP exists for SettingsPosition.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsPosition:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSPROP(PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsPosition:WrongInput]
			%  Element.EXISTSPROP(ST, PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsPosition:WrongInput]
			%  Element.EXISTSPROP(SettingsPosition, PROP) throws error if PROP does NOT exist for SettingsPosition.
			%   Error id: [BRAPH2:SettingsPosition:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ST) and Element.EXISTSPROP('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SettingsPosition.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsPosition:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsPosition:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsPosition.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in position settings/error.
			%
			% CHECK = SettingsPosition.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSTAG(TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(ST, TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(SettingsPosition, TAG) checks whether TAG exists for SettingsPosition.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsPosition:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSTAG(TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsPosition:WrongInput]
			%  Element.EXISTSTAG(ST, TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsPosition:WrongInput]
			%  Element.EXISTSTAG(SettingsPosition, TAG) throws error if TAG does NOT exist for SettingsPosition.
			%   Error id: [BRAPH2:SettingsPosition:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ST) and Element.EXISTSTAG('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			settingsposition_tag_list = cellfun(@(x) SettingsPosition.getPropTag(x), num2cell(SettingsPosition.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, settingsposition_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsPosition:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsPosition:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SettingsPosition.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsPosition, POINTER) returns property number of POINTER of SettingsPosition.
			%  PROPERTY = ST.GETPROPPROP(SettingsPosition, POINTER) returns property number of POINTER of SettingsPosition.
			%
			% Note that the Element.GETPROPPROP(ST) and Element.GETPROPPROP('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				settingsposition_tag_list = cellfun(@(x) SettingsPosition.getPropTag(x), num2cell(SettingsPosition.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, settingsposition_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(SettingsPosition, POINTER) returns tag of POINTER of SettingsPosition.
			%  TAG = ST.GETPROPTAG(SettingsPosition, POINTER) returns tag of POINTER of SettingsPosition.
			%
			% Note that the Element.GETPROPTAG(ST) and Element.GETPROPTAG('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SettingsPosition.AUTOPOS
						tag = SettingsPosition.AUTOPOS_TAG;
					case SettingsPosition.X0
						tag = SettingsPosition.X0_TAG;
					case SettingsPosition.Y0
						tag = SettingsPosition.Y0_TAG;
					case SettingsPosition.WIDTH
						tag = SettingsPosition.WIDTH_TAG;
					case SettingsPosition.HEIGHT
						tag = SettingsPosition.HEIGHT_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsPosition, POINTER) returns category of POINTER of SettingsPosition.
			%  CATEGORY = ST.GETPROPCATEGORY(SettingsPosition, POINTER) returns category of POINTER of SettingsPosition.
			%
			% Note that the Element.GETPROPCATEGORY(ST) and Element.GETPROPCATEGORY('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsPosition.getPropProp(pointer);
			
			switch prop
				case SettingsPosition.AUTOPOS
					prop_category = SettingsPosition.AUTOPOS_CATEGORY;
				case SettingsPosition.X0
					prop_category = SettingsPosition.X0_CATEGORY;
				case SettingsPosition.Y0
					prop_category = SettingsPosition.Y0_CATEGORY;
				case SettingsPosition.WIDTH
					prop_category = SettingsPosition.WIDTH_CATEGORY;
				case SettingsPosition.HEIGHT
					prop_category = SettingsPosition.HEIGHT_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsPosition, POINTER) returns format of POINTER of SettingsPosition.
			%  FORMAT = ST.GETPROPFORMAT(SettingsPosition, POINTER) returns format of POINTER of SettingsPosition.
			%
			% Note that the Element.GETPROPFORMAT(ST) and Element.GETPROPFORMAT('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsPosition.getPropProp(pointer);
			
			switch prop
				case SettingsPosition.AUTOPOS
					prop_format = SettingsPosition.AUTOPOS_FORMAT;
				case SettingsPosition.X0
					prop_format = SettingsPosition.X0_FORMAT;
				case SettingsPosition.Y0
					prop_format = SettingsPosition.Y0_FORMAT;
				case SettingsPosition.WIDTH
					prop_format = SettingsPosition.WIDTH_FORMAT;
				case SettingsPosition.HEIGHT
					prop_format = SettingsPosition.HEIGHT_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsPosition, POINTER) returns description of POINTER of SettingsPosition.
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(SettingsPosition, POINTER) returns description of POINTER of SettingsPosition.
			%
			% Note that the Element.GETPROPDESCRIPTION(ST) and Element.GETPROPDESCRIPTION('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsPosition.getPropProp(pointer);
			
			switch prop
				case SettingsPosition.AUTOPOS
					prop_description = 'AUTOPOS (figure, logical) determines whether the position is adjusted automatically.';
				case SettingsPosition.X0
					prop_description = 'X0 (figure, scalar) is the lower left x-coordinate of the panel in pixels.';
				case SettingsPosition.Y0
					prop_description = 'Y0 (figure, scalar) is the lower-left y-coordinate of the panel in pixels.';
				case SettingsPosition.WIDTH
					prop_description = 'WIDTH (figure, size) is the width of the panel in pixels.';
				case SettingsPosition.HEIGHT
					prop_description = 'HEIGHT (figure, size) is the height of the panel in pixels.';
				case SettingsPosition.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the position settings.';
				case SettingsPosition.NAME
					prop_description = 'NAME (constant, string) is the name of the position settings.';
				case SettingsPosition.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the position settings.';
				case SettingsPosition.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the position settings.';
				case SettingsPosition.ID
					prop_description = 'ID (data, string) is a few-letter code for the position settings.';
				case SettingsPosition.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the position settings.';
				case SettingsPosition.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the position settings.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsPosition, POINTER) returns settings of POINTER of SettingsPosition.
			%  SETTINGS = ST.GETPROPSETTINGS(SettingsPosition, POINTER) returns settings of POINTER of SettingsPosition.
			%
			% Note that the Element.GETPROPSETTINGS(ST) and Element.GETPROPSETTINGS('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsPosition.getPropProp(pointer);
			
			switch prop
				case SettingsPosition.AUTOPOS
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SettingsPosition.X0
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case SettingsPosition.Y0
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case SettingsPosition.WIDTH
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case SettingsPosition.HEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case SettingsPosition.TEMPLATE
					prop_settings = 'SettingsPosition';
				otherwise
					prop_settings = getPropSettings@Settings(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsPosition.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsPosition.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsPosition, POINTER) returns the default value of POINTER of SettingsPosition.
			%  DEFAULT = ST.GETPROPDEFAULT(SettingsPosition, POINTER) returns the default value of POINTER of SettingsPosition.
			%
			% Note that the Element.GETPROPDEFAULT(ST) and Element.GETPROPDEFAULT('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsPosition.getPropProp(pointer);
			
			switch prop
				case SettingsPosition.AUTOPOS
					prop_default = true;
				case SettingsPosition.X0
					prop_default = 1;
				case SettingsPosition.Y0
					prop_default = 1;
				case SettingsPosition.WIDTH
					prop_default = 800;
				case SettingsPosition.HEIGHT
					prop_default = 600;
				case SettingsPosition.ELCLASS
					prop_default = 'SettingsPosition';
				case SettingsPosition.NAME
					prop_default = 'Posiiton Settings';
				case SettingsPosition.DESCRIPTION
					prop_default = 'A Position Settings (SettingsPosition) provides the settings for a posistion settings panel, including autopositioning, x0, y0, height and width. The handle can be an uipanel.';
				case SettingsPosition.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, SettingsPosition.getPropSettings(prop));
				case SettingsPosition.ID
					prop_default = 'SettingsPosition ID';
				case SettingsPosition.LABEL
					prop_default = 'SettingsPosition label';
				case SettingsPosition.NOTES
					prop_default = 'SettingsPosition notes';
				otherwise
					prop_default = getPropDefault@Settings(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsPosition.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsPosition.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsPosition, POINTER) returns the conditioned default value of POINTER of SettingsPosition.
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(SettingsPosition, POINTER) returns the conditioned default value of POINTER of SettingsPosition.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ST) and Element.GETPROPDEFAULTCONDITIONED('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsPosition.getPropProp(pointer);
			
			prop_default = SettingsPosition.conditioning(prop, SettingsPosition.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsPosition, PROP, VALUE) checks VALUE format for PROP of SettingsPosition.
			%  CHECK = ST.CHECKPROP(SettingsPosition, PROP, VALUE) checks VALUE format for PROP of SettingsPosition.
			% 
			% ST.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SettingsPosition:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ST.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ST.
			%   Error id: €BRAPH2.STR€:SettingsPosition:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SettingsPosition, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsPosition.
			%   Error id: €BRAPH2.STR€:SettingsPosition:€BRAPH2.WRONG_INPUT€
			%  ST.CHECKPROP(SettingsPosition, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsPosition.
			%   Error id: €BRAPH2.STR€:SettingsPosition:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(ST) and Element.CHECKPROP('SettingsPosition')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsPosition.getPropProp(pointer);
			
			switch prop
				case SettingsPosition.AUTOPOS % __SettingsPosition.AUTOPOS__
					check = Format.checkFormat(Format.LOGICAL, value, SettingsPosition.getPropSettings(prop));
				case SettingsPosition.X0 % __SettingsPosition.X0__
					check = Format.checkFormat(Format.SCALAR, value, SettingsPosition.getPropSettings(prop));
				case SettingsPosition.Y0 % __SettingsPosition.Y0__
					check = Format.checkFormat(Format.SCALAR, value, SettingsPosition.getPropSettings(prop));
				case SettingsPosition.WIDTH % __SettingsPosition.WIDTH__
					check = Format.checkFormat(Format.SIZE, value, SettingsPosition.getPropSettings(prop));
				case SettingsPosition.HEIGHT % __SettingsPosition.HEIGHT__
					check = Format.checkFormat(Format.SIZE, value, SettingsPosition.getPropSettings(prop));
				case SettingsPosition.TEMPLATE % __SettingsPosition.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, SettingsPosition.getPropSettings(prop));
				otherwise
					if prop <= Settings.getPropNumber()
						check = checkProp@Settings(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsPosition:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsPosition:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsPosition.getPropTag(prop) ' (' SettingsPosition.getFormatTag(SettingsPosition.getPropFormat(prop)) ').'] ...
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
				case SettingsPosition.AUTOPOS % __SettingsPosition.AUTOPOS__
					p = st.get('H');
					if check_graphics(p, 'uipanel')
					    if st.get('AUTOPOS')
					        set(p, ...
					            'Units', 'normalized', ...
					            'Position', [0 0 1 1] ...
					            )
					        set(get(p, 'Parent'), 'Scrollable', 'off')
					    else
					        set(p, ...
					            'Units', 'pixels', ...
					            'Position', [st.get('X0') st.get('Y0') st.get('WIDTH') st.get('HEIGHT')] ...
					            )
					        set(get(p, 'Parent'), 'Scrollable', 'on')
					    end
					end
					
				case SettingsPosition.X0 % __SettingsPosition.X0__
					p = st.get('H');
					if check_graphics(p, 'uipanel')
					    if ~st.get('AUTOPOS')
					        set(p, 'Position', [st.get('X0') st.get('Y0') st.get('WIDTH') st.get('HEIGHT')])
					    end
					end
					
				case SettingsPosition.Y0 % __SettingsPosition.Y0__
					p = st.get('H');
					if check_graphics(p, 'uipanel')
					    if ~st.get('AUTOPOS')
					        set(p, 'Position', [st.get('X0') st.get('Y0') st.get('WIDTH') st.get('HEIGHT')])
					    end
					end
					
				case SettingsPosition.WIDTH % __SettingsPosition.WIDTH__
					p = st.get('H');
					if check_graphics(p, 'uipanel')
					    if ~st.get('AUTOPOS')
					        set(p, 'Position', [st.get('X0') st.get('Y0') st.get('WIDTH') st.get('HEIGHT')])
					    end
					end
					
				case SettingsPosition.HEIGHT % __SettingsPosition.HEIGHT__
					p = st.get('H');
					if check_graphics(p, 'uipanel')
					    if ~st.get('AUTOPOS')
					        set(p, 'Position', [st.get('X0') st.get('Y0') st.get('WIDTH') st.get('HEIGHT')])
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
