classdef SettingsArea < Settings
	%SettingsArea contains the area settings.
	% It is a subclass of <a href="matlab:help Settings">Settings</a>.
	%
	% An Area Settings (SettingsArea) provides the settings for a filled area plot,
	%  including visibility, x, y, z, face color, and face alpha.
	% The handle must be a patch.
	%
	% SettingsArea methods (constructor):
	%  SettingsArea - constructor
	%
	% SettingsArea methods:
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
	% SettingsArea methods (display):
	%  tostring - string with information about the area settings
	%  disp - displays information about the area settings
	%  tree - displays the tree of the area settings
	%
	% SettingsArea methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two area settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the area settings
	%
	% SettingsArea methods (save/load, Static):
	%  save - saves BRAPH2 area settings as b2 file
	%  load - loads a BRAPH2 area settings from a b2 file
	%
	% SettingsArea method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the area settings
	%
	% SettingsArea method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the area settings
	%
	% SettingsArea methods (inspection, Static):
	%  getClass - returns the class of the area settings
	%  getSubclasses - returns all subclasses of SettingsArea
	%  getProps - returns the property list of the area settings
	%  getPropNumber - returns the property number of the area settings
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
	% SettingsArea methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsArea methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsArea methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsArea methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsArea; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsArea constants</a>.
	%
	%
	% See also patch, PanelFig, GUIFig.
	
	properties (Constant) % properties
		VISIBLE = Settings.getPropNumber() + 1;
		VISIBLE_TAG = 'VISIBLE';
		VISIBLE_CATEGORY = Category.FIGURE;
		VISIBLE_FORMAT = Format.LOGICAL;
		
		X = Settings.getPropNumber() + 2;
		X_TAG = 'X';
		X_CATEGORY = Category.FIGURE;
		X_FORMAT = Format.RVECTOR;
		
		Y = Settings.getPropNumber() + 3;
		Y_TAG = 'Y';
		Y_CATEGORY = Category.FIGURE;
		Y_FORMAT = Format.RVECTOR;
		
		Z = Settings.getPropNumber() + 4;
		Z_TAG = 'Z';
		Z_CATEGORY = Category.FIGURE;
		Z_FORMAT = Format.RVECTOR;
		
		FACECOLOR = Settings.getPropNumber() + 5;
		FACECOLOR_TAG = 'FACECOLOR';
		FACECOLOR_CATEGORY = Category.FIGURE;
		FACECOLOR_FORMAT = Format.COLOR;
		
		FACEALPHA = Settings.getPropNumber() + 6;
		FACEALPHA_TAG = 'FACEALPHA';
		FACEALPHA_CATEGORY = Category.FIGURE;
		FACEALPHA_FORMAT = Format.SCALAR;
		
		EDGECOLOR = Settings.getPropNumber() + 7;
		EDGECOLOR_TAG = 'EDGECOLOR';
		EDGECOLOR_CATEGORY = Category.FIGURE;
		EDGECOLOR_FORMAT = Format.COLOR;
		
		EDGEALPHA = Settings.getPropNumber() + 8;
		EDGEALPHA_TAG = 'EDGEALPHA';
		EDGEALPHA_CATEGORY = Category.FIGURE;
		EDGEALPHA_FORMAT = Format.SCALAR;
	end
	methods % constructor
		function st = SettingsArea(varargin)
			%SettingsArea() creates a area settings.
			%
			% SettingsArea(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsArea(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the area settings.
			%
			% CLASS = SettingsArea.GETCLASS() returns the class 'SettingsArea'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ST.GETCLASS() returns the class of the area settings ST.
			%  CLASS = Element.GETCLASS(ST) returns the class of 'ST'.
			%  CLASS = Element.GETCLASS('SettingsArea') returns 'SettingsArea'.
			%
			% Note that the Element.GETCLASS(ST) and Element.GETCLASS('SettingsArea')
			%  are less computationally efficient.
			
			st_class = 'SettingsArea';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the area settings.
			%
			% LIST = SettingsArea.GETSUBCLASSES() returns all subclasses of 'SettingsArea'.
			%
			% Alternative forms to call this method are:
			%  LIST = ST.GETSUBCLASSES() returns all subclasses of the area settings ST.
			%  LIST = Element.GETSUBCLASSES(ST) returns all subclasses of 'ST'.
			%  LIST = Element.GETSUBCLASSES('SettingsArea') returns all subclasses of 'SettingsArea'.
			%
			% Note that the Element.GETSUBCLASSES(ST) and Element.GETSUBCLASSES('SettingsArea')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SettingsArea', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of area settings.
			%
			% PROPS = SettingsArea.GETPROPS() returns the property list of area settings
			%  as a row vector.
			%
			% PROPS = SettingsArea.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ST.GETPROPS([CATEGORY]) returns the property list of the area settings ST.
			%  PROPS = Element.GETPROPS(ST[, CATEGORY]) returns the property list of 'ST'.
			%  PROPS = Element.GETPROPS('SettingsArea'[, CATEGORY]) returns the property list of 'SettingsArea'.
			%
			% Note that the Element.GETPROPS(ST) and Element.GETPROPS('SettingsArea')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Settings.getProps() ...
						SettingsArea.VISIBLE ...
						SettingsArea.X ...
						SettingsArea.Y ...
						SettingsArea.Z ...
						SettingsArea.FACECOLOR ...
						SettingsArea.FACEALPHA ...
						SettingsArea.EDGECOLOR ...
						SettingsArea.EDGEALPHA ...
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
						SettingsArea.VISIBLE ...
						SettingsArea.X ...
						SettingsArea.Y ...
						SettingsArea.Z ...
						SettingsArea.FACECOLOR ...
						SettingsArea.FACEALPHA ...
						SettingsArea.EDGECOLOR ...
						SettingsArea.EDGEALPHA ...
						];
				case Category.GUI
					prop_list = [ ...
						Settings.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of area settings.
			%
			% N = SettingsArea.GETPROPNUMBER() returns the property number of area settings.
			%
			% N = SettingsArea.GETPROPNUMBER(CATEGORY) returns the property number of area settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ST.GETPROPNUMBER([CATEGORY]) returns the property number of the area settings ST.
			%  N = Element.GETPROPNUMBER(ST) returns the property number of 'ST'.
			%  N = Element.GETPROPNUMBER('SettingsArea') returns the property number of 'SettingsArea'.
			%
			% Note that the Element.GETPROPNUMBER(ST) and Element.GETPROPNUMBER('SettingsArea')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SettingsArea.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in area settings/error.
			%
			% CHECK = SettingsArea.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSPROP(PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(ST, PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(SettingsArea, PROP) checks whether PROP exists for SettingsArea.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsArea:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSPROP(PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsArea:WrongInput]
			%  Element.EXISTSPROP(ST, PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsArea:WrongInput]
			%  Element.EXISTSPROP(SettingsArea, PROP) throws error if PROP does NOT exist for SettingsArea.
			%   Error id: [BRAPH2:SettingsArea:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ST) and Element.EXISTSPROP('SettingsArea')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SettingsArea.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsArea:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsArea:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsArea.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in area settings/error.
			%
			% CHECK = SettingsArea.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSTAG(TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(ST, TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(SettingsArea, TAG) checks whether TAG exists for SettingsArea.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsArea:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSTAG(TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsArea:WrongInput]
			%  Element.EXISTSTAG(ST, TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsArea:WrongInput]
			%  Element.EXISTSTAG(SettingsArea, TAG) throws error if TAG does NOT exist for SettingsArea.
			%   Error id: [BRAPH2:SettingsArea:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ST) and Element.EXISTSTAG('SettingsArea')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			settingsarea_tag_list = cellfun(@(x) SettingsArea.getPropTag(x), num2cell(SettingsArea.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, settingsarea_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsArea:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsArea:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SettingsArea.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsArea, POINTER) returns property number of POINTER of SettingsArea.
			%  PROPERTY = ST.GETPROPPROP(SettingsArea, POINTER) returns property number of POINTER of SettingsArea.
			%
			% Note that the Element.GETPROPPROP(ST) and Element.GETPROPPROP('SettingsArea')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				settingsarea_tag_list = cellfun(@(x) SettingsArea.getPropTag(x), num2cell(SettingsArea.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, settingsarea_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(SettingsArea, POINTER) returns tag of POINTER of SettingsArea.
			%  TAG = ST.GETPROPTAG(SettingsArea, POINTER) returns tag of POINTER of SettingsArea.
			%
			% Note that the Element.GETPROPTAG(ST) and Element.GETPROPTAG('SettingsArea')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SettingsArea.VISIBLE
						tag = SettingsArea.VISIBLE_TAG;
					case SettingsArea.X
						tag = SettingsArea.X_TAG;
					case SettingsArea.Y
						tag = SettingsArea.Y_TAG;
					case SettingsArea.Z
						tag = SettingsArea.Z_TAG;
					case SettingsArea.FACECOLOR
						tag = SettingsArea.FACECOLOR_TAG;
					case SettingsArea.FACEALPHA
						tag = SettingsArea.FACEALPHA_TAG;
					case SettingsArea.EDGECOLOR
						tag = SettingsArea.EDGECOLOR_TAG;
					case SettingsArea.EDGEALPHA
						tag = SettingsArea.EDGEALPHA_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsArea, POINTER) returns category of POINTER of SettingsArea.
			%  CATEGORY = ST.GETPROPCATEGORY(SettingsArea, POINTER) returns category of POINTER of SettingsArea.
			%
			% Note that the Element.GETPROPCATEGORY(ST) and Element.GETPROPCATEGORY('SettingsArea')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsArea.getPropProp(pointer);
			
			switch prop
				case SettingsArea.VISIBLE
					prop_category = SettingsArea.VISIBLE_CATEGORY;
				case SettingsArea.X
					prop_category = SettingsArea.X_CATEGORY;
				case SettingsArea.Y
					prop_category = SettingsArea.Y_CATEGORY;
				case SettingsArea.Z
					prop_category = SettingsArea.Z_CATEGORY;
				case SettingsArea.FACECOLOR
					prop_category = SettingsArea.FACECOLOR_CATEGORY;
				case SettingsArea.FACEALPHA
					prop_category = SettingsArea.FACEALPHA_CATEGORY;
				case SettingsArea.EDGECOLOR
					prop_category = SettingsArea.EDGECOLOR_CATEGORY;
				case SettingsArea.EDGEALPHA
					prop_category = SettingsArea.EDGEALPHA_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsArea, POINTER) returns format of POINTER of SettingsArea.
			%  FORMAT = ST.GETPROPFORMAT(SettingsArea, POINTER) returns format of POINTER of SettingsArea.
			%
			% Note that the Element.GETPROPFORMAT(ST) and Element.GETPROPFORMAT('SettingsArea')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsArea.getPropProp(pointer);
			
			switch prop
				case SettingsArea.VISIBLE
					prop_format = SettingsArea.VISIBLE_FORMAT;
				case SettingsArea.X
					prop_format = SettingsArea.X_FORMAT;
				case SettingsArea.Y
					prop_format = SettingsArea.Y_FORMAT;
				case SettingsArea.Z
					prop_format = SettingsArea.Z_FORMAT;
				case SettingsArea.FACECOLOR
					prop_format = SettingsArea.FACECOLOR_FORMAT;
				case SettingsArea.FACEALPHA
					prop_format = SettingsArea.FACEALPHA_FORMAT;
				case SettingsArea.EDGECOLOR
					prop_format = SettingsArea.EDGECOLOR_FORMAT;
				case SettingsArea.EDGEALPHA
					prop_format = SettingsArea.EDGEALPHA_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsArea, POINTER) returns description of POINTER of SettingsArea.
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(SettingsArea, POINTER) returns description of POINTER of SettingsArea.
			%
			% Note that the Element.GETPROPDESCRIPTION(ST) and Element.GETPROPDESCRIPTION('SettingsArea')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsArea.getPropProp(pointer);
			
			switch prop
				case SettingsArea.VISIBLE
					prop_description = 'VISIBLE (figure, logical) determines whether the symbol is visible.';
				case SettingsArea.X
					prop_description = 'X (figure, rvector) is the vector of the x-coordinates.';
				case SettingsArea.Y
					prop_description = 'Y (figure, rvector) is the vector of y-coordinates.';
				case SettingsArea.Z
					prop_description = 'Z (figure, rvector) is the vector of the z-coordinates.';
				case SettingsArea.FACECOLOR
					prop_description = 'FACECOLOR (figure, color) is the symbol RGB face color.';
				case SettingsArea.FACEALPHA
					prop_description = 'FACEALPHA (figure, scalar) is the symbol RGB face color.';
				case SettingsArea.EDGECOLOR
					prop_description = 'EDGECOLOR (figure, color) is the symbol RGB edge color.';
				case SettingsArea.EDGEALPHA
					prop_description = 'EDGEALPHA (figure, scalar) is the symbol RGB edge color.';
				case SettingsArea.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the concrete element.';
				case SettingsArea.NAME
					prop_description = 'NAME (constant, string) is the name of the area settings.';
				case SettingsArea.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the area settings.';
				case SettingsArea.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the area settings.';
				case SettingsArea.ID
					prop_description = 'ID (data, string) is a few-letter code for the area settings.';
				case SettingsArea.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the area settings.';
				case SettingsArea.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the area settings.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsArea, POINTER) returns settings of POINTER of SettingsArea.
			%  SETTINGS = ST.GETPROPSETTINGS(SettingsArea, POINTER) returns settings of POINTER of SettingsArea.
			%
			% Note that the Element.GETPROPSETTINGS(ST) and Element.GETPROPSETTINGS('SettingsArea')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsArea.getPropProp(pointer);
			
			switch prop
				case SettingsArea.VISIBLE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SettingsArea.X
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case SettingsArea.Y
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case SettingsArea.Z
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case SettingsArea.FACECOLOR
					prop_settings = Format.getFormatSettings(Format.COLOR);
				case SettingsArea.FACEALPHA
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case SettingsArea.EDGECOLOR
					prop_settings = Format.getFormatSettings(Format.COLOR);
				case SettingsArea.EDGEALPHA
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case SettingsArea.TEMPLATE
					prop_settings = 'SettingsArea';
				otherwise
					prop_settings = getPropSettings@Settings(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsArea.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsArea.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsArea, POINTER) returns the default value of POINTER of SettingsArea.
			%  DEFAULT = ST.GETPROPDEFAULT(SettingsArea, POINTER) returns the default value of POINTER of SettingsArea.
			%
			% Note that the Element.GETPROPDEFAULT(ST) and Element.GETPROPDEFAULT('SettingsArea')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsArea.getPropProp(pointer);
			
			switch prop
				case SettingsArea.VISIBLE
					prop_default = true;
				case SettingsArea.X
					prop_default = Format.getFormatDefault(Format.RVECTOR, SettingsArea.getPropSettings(prop));
				case SettingsArea.Y
					prop_default = Format.getFormatDefault(Format.RVECTOR, SettingsArea.getPropSettings(prop));
				case SettingsArea.Z
					prop_default = Format.getFormatDefault(Format.RVECTOR, SettingsArea.getPropSettings(prop));
				case SettingsArea.FACECOLOR
					prop_default = BRAPH2.COL;
				case SettingsArea.FACEALPHA
					prop_default = 0.5;
				case SettingsArea.EDGECOLOR
					prop_default = [0 0 0];
				case SettingsArea.EDGEALPHA
					prop_default = 0;
				case SettingsArea.ELCLASS
					prop_default = 'SettingsArea';
				case SettingsArea.NAME
					prop_default = 'Area Settings';
				case SettingsArea.DESCRIPTION
					prop_default = 'An Area Settings (SettingsArea) provides the settings for a filled area plot, including visibility, x, y, z, face color, and face alpha. The handle must be a patch.';
				case SettingsArea.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, SettingsArea.getPropSettings(prop));
				case SettingsArea.ID
					prop_default = 'SettingsArea ID';
				case SettingsArea.LABEL
					prop_default = 'SettingsArea label';
				case SettingsArea.NOTES
					prop_default = 'SettingsArea notes';
				otherwise
					prop_default = getPropDefault@Settings(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsArea.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsArea.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsArea, POINTER) returns the conditioned default value of POINTER of SettingsArea.
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(SettingsArea, POINTER) returns the conditioned default value of POINTER of SettingsArea.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ST) and Element.GETPROPDEFAULTCONDITIONED('SettingsArea')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsArea.getPropProp(pointer);
			
			prop_default = SettingsArea.conditioning(prop, SettingsArea.getPropDefault(prop));
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			%CONDITIONING conditions a value before setting a property.
			%
			% VALUE = CONDITIONING(EL, PROP, VALUE) conditions the value VALUE before
			%  it is set as the value of the property PROP.
			%  By default, this function does not do anything, so it should be
			%  implemented in the subclasses of Element when needed.
			%
			% Conditioning is only used for props of Category.METADATA,
			%  Category.PARAMETER, Category.DATA, Category.FIGURE and Category.GUI.
			%
			% See also preset, checkProp, postset, postprocessing, calculateValue,
			%  checkValue.
			
			prop = SettingsArea.getPropProp(pointer);
			
			switch prop
				case SettingsArea.X % __SettingsArea.X__
					value = value(:)';
					
				case SettingsArea.Y % __SettingsArea.Y__
					value = value(:)';
					
				case SettingsArea.Z % __SettingsArea.Z__
					value = value(:)';
					
				otherwise
					if prop <= Settings.getPropNumber()
						value = conditioning@Settings(pointer, value);
					end
			end
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
			%  CHECK = Element.CHECKPROP(SettingsArea, PROP, VALUE) checks VALUE format for PROP of SettingsArea.
			%  CHECK = ST.CHECKPROP(SettingsArea, PROP, VALUE) checks VALUE format for PROP of SettingsArea.
			% 
			% ST.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SettingsArea:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ST.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ST.
			%   Error id: €BRAPH2.STR€:SettingsArea:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SettingsArea, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsArea.
			%   Error id: €BRAPH2.STR€:SettingsArea:€BRAPH2.WRONG_INPUT€
			%  ST.CHECKPROP(SettingsArea, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsArea.
			%   Error id: €BRAPH2.STR€:SettingsArea:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(ST) and Element.CHECKPROP('SettingsArea')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsArea.getPropProp(pointer);
			
			switch prop
				case SettingsArea.VISIBLE % __SettingsArea.VISIBLE__
					check = Format.checkFormat(Format.LOGICAL, value, SettingsArea.getPropSettings(prop));
				case SettingsArea.X % __SettingsArea.X__
					check = Format.checkFormat(Format.RVECTOR, value, SettingsArea.getPropSettings(prop));
				case SettingsArea.Y % __SettingsArea.Y__
					check = Format.checkFormat(Format.RVECTOR, value, SettingsArea.getPropSettings(prop));
				case SettingsArea.Z % __SettingsArea.Z__
					check = Format.checkFormat(Format.RVECTOR, value, SettingsArea.getPropSettings(prop));
				case SettingsArea.FACECOLOR % __SettingsArea.FACECOLOR__
					check = Format.checkFormat(Format.COLOR, value, SettingsArea.getPropSettings(prop));
				case SettingsArea.FACEALPHA % __SettingsArea.FACEALPHA__
					check = Format.checkFormat(Format.SCALAR, value, SettingsArea.getPropSettings(prop));
				case SettingsArea.EDGECOLOR % __SettingsArea.EDGECOLOR__
					check = Format.checkFormat(Format.COLOR, value, SettingsArea.getPropSettings(prop));
				case SettingsArea.EDGEALPHA % __SettingsArea.EDGEALPHA__
					check = Format.checkFormat(Format.SCALAR, value, SettingsArea.getPropSettings(prop));
				case SettingsArea.TEMPLATE % __SettingsArea.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, SettingsArea.getPropSettings(prop));
				otherwise
					if prop <= Settings.getPropNumber()
						check = checkProp@Settings(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsArea:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsArea:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsArea.getPropTag(prop) ' (' SettingsArea.getFormatTag(SettingsArea.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(st, prop)
			%POSTPROCESSING postprocessesing after setting.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing of PROP after setting. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% The postprocessing of all properties occurs each time set is called.
			%
			% See also conditioning, preset, checkProp, postset, calculateValue,
			%  checkValue.
			
			switch prop
				case SettingsArea.VISIBLE % __SettingsArea.VISIBLE__
					h = st.get('H');
					if check_graphics(h, 'patch') && ( ...
					        get(h, 'Visible') ~= st.get('VISIBLE') || ...
					        ~isequal(get(h, 'XData'), st.get('X')) || ...
					        ~isequal(get(h, 'YData'), st.get('Y')) || ...
					        ~isequal(get(h, 'ZData'), st.get('Z')) || ...
					        ~isequal(get(h, 'FaceColor'), st.get('FACEALPHA')) || ...
					        get(h, 'FaceAlpha') ~= st.get('FACEALPHA') || ...
					        ~isequal(get(h, 'EdgeColor'), st.get('EDGEALPHA')) || ...
					        get(h, 'EdgeAlpha') ~= st.get('EDGEALPHA') ...
					        )
					    if st.get('VISIBLE')
					        set(h, ...
					            'XData', st.get('X'), ...
					            'YData', st.get('Y'), ...
					            'ZData', st.get('Z'), ...
					            'FaceColor', st.get('FACECOLOR'), ...
					            'FaceAlpha', st.get('FACEALPHA'), ...
					            'EdgeColor', st.get('EDGECOLOR'), ...
					            'EdgeAlpha', st.get('EDGEALPHA'), ...
					            'Visible', true ...
					            )
					    else
					        set(h, 'VISIBLE', false)
					    end
					end
					
				otherwise
					if prop <= Settings.getPropNumber()
						postprocessing@Settings(st, prop);
					end
			end
		end
	end
end
