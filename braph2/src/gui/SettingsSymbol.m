classdef SettingsSymbol < Settings
	%SettingsSymbol contains the symbol settings.
	% It is a subclass of <a href="matlab:help Settings">Settings</a>.
	%
	% A Symbol Settings (SettingsSymbol) provides the settings for a symbol, 
	% including visibility, x, y, z, symbol marker, symbol size, face color, and edge color.
	% The handle can be a line.
	%
	% SettingsSymbol methods (constructor):
	%  SettingsSymbol - constructor
	%
	% SettingsSymbol methods:
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
	% SettingsSymbol methods (display):
	%  tostring - string with information about the symbol settings
	%  disp - displays information about the symbol settings
	%  tree - displays the tree of the symbol settings
	%
	% SettingsSymbol methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two symbol settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the symbol settings
	%
	% SettingsSymbol methods (save/load, Static):
	%  save - saves BRAPH2 symbol settings as b2 file
	%  load - loads a BRAPH2 symbol settings from a b2 file
	%
	% SettingsSymbol method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the symbol settings
	%
	% SettingsSymbol method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the symbol settings
	%
	% SettingsSymbol methods (inspection, Static):
	%  getClass - returns the class of the symbol settings
	%  getSubclasses - returns all subclasses of SettingsSymbol
	%  getProps - returns the property list of the symbol settings
	%  getPropNumber - returns the property number of the symbol settings
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
	% SettingsSymbol methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsSymbol methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsSymbol methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsSymbol methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsSymbol; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsSymbol constants</a>.
	%
	%
	% See also line, PanelFig, GUIFig, check_graphics.
	
	properties (Constant) % properties
		VISIBLE = Settings.getPropNumber() + 1;
		VISIBLE_TAG = 'VISIBLE';
		VISIBLE_CATEGORY = Category.FIGURE;
		VISIBLE_FORMAT = Format.LOGICAL;
		
		X = Settings.getPropNumber() + 2;
		X_TAG = 'X';
		X_CATEGORY = Category.FIGURE;
		X_FORMAT = Format.SCALAR;
		
		Y = Settings.getPropNumber() + 3;
		Y_TAG = 'Y';
		Y_CATEGORY = Category.FIGURE;
		Y_FORMAT = Format.SCALAR;
		
		Z = Settings.getPropNumber() + 4;
		Z_TAG = 'Z';
		Z_CATEGORY = Category.FIGURE;
		Z_FORMAT = Format.SCALAR;
		
		SYMBOL = Settings.getPropNumber() + 5;
		SYMBOL_TAG = 'SYMBOL';
		SYMBOL_CATEGORY = Category.FIGURE;
		SYMBOL_FORMAT = Format.MARKER;
		
		SYMBOLSIZE = Settings.getPropNumber() + 6;
		SYMBOLSIZE_TAG = 'SYMBOLSIZE';
		SYMBOLSIZE_CATEGORY = Category.FIGURE;
		SYMBOLSIZE_FORMAT = Format.SIZE;
		
		EDGECOLOR = Settings.getPropNumber() + 7;
		EDGECOLOR_TAG = 'EDGECOLOR';
		EDGECOLOR_CATEGORY = Category.FIGURE;
		EDGECOLOR_FORMAT = Format.COLOR;
		
		FACECOLOR = Settings.getPropNumber() + 8;
		FACECOLOR_TAG = 'FACECOLOR';
		FACECOLOR_CATEGORY = Category.FIGURE;
		FACECOLOR_FORMAT = Format.COLOR;
	end
	methods % constructor
		function st = SettingsSymbol(varargin)
			%SettingsSymbol() creates a symbol settings.
			%
			% SettingsSymbol(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsSymbol(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the symbol settings.
			%
			% CLASS = SettingsSymbol.GETCLASS() returns the class 'SettingsSymbol'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ST.GETCLASS() returns the class of the symbol settings ST.
			%  CLASS = Element.GETCLASS(ST) returns the class of 'ST'.
			%  CLASS = Element.GETCLASS('SettingsSymbol') returns 'SettingsSymbol'.
			%
			% Note that the Element.GETCLASS(ST) and Element.GETCLASS('SettingsSymbol')
			%  are less computationally efficient.
			
			st_class = 'SettingsSymbol';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the symbol settings.
			%
			% LIST = SettingsSymbol.GETSUBCLASSES() returns all subclasses of 'SettingsSymbol'.
			%
			% Alternative forms to call this method are:
			%  LIST = ST.GETSUBCLASSES() returns all subclasses of the symbol settings ST.
			%  LIST = Element.GETSUBCLASSES(ST) returns all subclasses of 'ST'.
			%  LIST = Element.GETSUBCLASSES('SettingsSymbol') returns all subclasses of 'SettingsSymbol'.
			%
			% Note that the Element.GETSUBCLASSES(ST) and Element.GETSUBCLASSES('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SettingsSymbol', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of symbol settings.
			%
			% PROPS = SettingsSymbol.GETPROPS() returns the property list of symbol settings
			%  as a row vector.
			%
			% PROPS = SettingsSymbol.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ST.GETPROPS([CATEGORY]) returns the property list of the symbol settings ST.
			%  PROPS = Element.GETPROPS(ST[, CATEGORY]) returns the property list of 'ST'.
			%  PROPS = Element.GETPROPS('SettingsSymbol'[, CATEGORY]) returns the property list of 'SettingsSymbol'.
			%
			% Note that the Element.GETPROPS(ST) and Element.GETPROPS('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Settings.getProps() ...
						SettingsSymbol.VISIBLE ...
						SettingsSymbol.X ...
						SettingsSymbol.Y ...
						SettingsSymbol.Z ...
						SettingsSymbol.SYMBOL ...
						SettingsSymbol.SYMBOLSIZE ...
						SettingsSymbol.EDGECOLOR ...
						SettingsSymbol.FACECOLOR ...
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
						SettingsSymbol.VISIBLE ...
						SettingsSymbol.X ...
						SettingsSymbol.Y ...
						SettingsSymbol.Z ...
						SettingsSymbol.SYMBOL ...
						SettingsSymbol.SYMBOLSIZE ...
						SettingsSymbol.EDGECOLOR ...
						SettingsSymbol.FACECOLOR ...
						];
				case Category.GUI
					prop_list = [ ...
						Settings.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of symbol settings.
			%
			% N = SettingsSymbol.GETPROPNUMBER() returns the property number of symbol settings.
			%
			% N = SettingsSymbol.GETPROPNUMBER(CATEGORY) returns the property number of symbol settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ST.GETPROPNUMBER([CATEGORY]) returns the property number of the symbol settings ST.
			%  N = Element.GETPROPNUMBER(ST) returns the property number of 'ST'.
			%  N = Element.GETPROPNUMBER('SettingsSymbol') returns the property number of 'SettingsSymbol'.
			%
			% Note that the Element.GETPROPNUMBER(ST) and Element.GETPROPNUMBER('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SettingsSymbol.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in symbol settings/error.
			%
			% CHECK = SettingsSymbol.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSPROP(PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(ST, PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(SettingsSymbol, PROP) checks whether PROP exists for SettingsSymbol.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsSymbol:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSPROP(PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSymbol:WrongInput]
			%  Element.EXISTSPROP(ST, PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSymbol:WrongInput]
			%  Element.EXISTSPROP(SettingsSymbol, PROP) throws error if PROP does NOT exist for SettingsSymbol.
			%   Error id: [BRAPH2:SettingsSymbol:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ST) and Element.EXISTSPROP('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SettingsSymbol.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsSymbol:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsSymbol:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsSymbol.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in symbol settings/error.
			%
			% CHECK = SettingsSymbol.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSTAG(TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(ST, TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(SettingsSymbol, TAG) checks whether TAG exists for SettingsSymbol.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsSymbol:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSTAG(TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSymbol:WrongInput]
			%  Element.EXISTSTAG(ST, TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSymbol:WrongInput]
			%  Element.EXISTSTAG(SettingsSymbol, TAG) throws error if TAG does NOT exist for SettingsSymbol.
			%   Error id: [BRAPH2:SettingsSymbol:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ST) and Element.EXISTSTAG('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			settingssymbol_tag_list = cellfun(@(x) SettingsSymbol.getPropTag(x), num2cell(SettingsSymbol.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, settingssymbol_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsSymbol:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsSymbol:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SettingsSymbol.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsSymbol, POINTER) returns property number of POINTER of SettingsSymbol.
			%  PROPERTY = ST.GETPROPPROP(SettingsSymbol, POINTER) returns property number of POINTER of SettingsSymbol.
			%
			% Note that the Element.GETPROPPROP(ST) and Element.GETPROPPROP('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				settingssymbol_tag_list = cellfun(@(x) SettingsSymbol.getPropTag(x), num2cell(SettingsSymbol.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, settingssymbol_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(SettingsSymbol, POINTER) returns tag of POINTER of SettingsSymbol.
			%  TAG = ST.GETPROPTAG(SettingsSymbol, POINTER) returns tag of POINTER of SettingsSymbol.
			%
			% Note that the Element.GETPROPTAG(ST) and Element.GETPROPTAG('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SettingsSymbol.VISIBLE
						tag = SettingsSymbol.VISIBLE_TAG;
					case SettingsSymbol.X
						tag = SettingsSymbol.X_TAG;
					case SettingsSymbol.Y
						tag = SettingsSymbol.Y_TAG;
					case SettingsSymbol.Z
						tag = SettingsSymbol.Z_TAG;
					case SettingsSymbol.SYMBOL
						tag = SettingsSymbol.SYMBOL_TAG;
					case SettingsSymbol.SYMBOLSIZE
						tag = SettingsSymbol.SYMBOLSIZE_TAG;
					case SettingsSymbol.EDGECOLOR
						tag = SettingsSymbol.EDGECOLOR_TAG;
					case SettingsSymbol.FACECOLOR
						tag = SettingsSymbol.FACECOLOR_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsSymbol, POINTER) returns category of POINTER of SettingsSymbol.
			%  CATEGORY = ST.GETPROPCATEGORY(SettingsSymbol, POINTER) returns category of POINTER of SettingsSymbol.
			%
			% Note that the Element.GETPROPCATEGORY(ST) and Element.GETPROPCATEGORY('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsSymbol.getPropProp(pointer);
			
			switch prop
				case SettingsSymbol.VISIBLE
					prop_category = SettingsSymbol.VISIBLE_CATEGORY;
				case SettingsSymbol.X
					prop_category = SettingsSymbol.X_CATEGORY;
				case SettingsSymbol.Y
					prop_category = SettingsSymbol.Y_CATEGORY;
				case SettingsSymbol.Z
					prop_category = SettingsSymbol.Z_CATEGORY;
				case SettingsSymbol.SYMBOL
					prop_category = SettingsSymbol.SYMBOL_CATEGORY;
				case SettingsSymbol.SYMBOLSIZE
					prop_category = SettingsSymbol.SYMBOLSIZE_CATEGORY;
				case SettingsSymbol.EDGECOLOR
					prop_category = SettingsSymbol.EDGECOLOR_CATEGORY;
				case SettingsSymbol.FACECOLOR
					prop_category = SettingsSymbol.FACECOLOR_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsSymbol, POINTER) returns format of POINTER of SettingsSymbol.
			%  FORMAT = ST.GETPROPFORMAT(SettingsSymbol, POINTER) returns format of POINTER of SettingsSymbol.
			%
			% Note that the Element.GETPROPFORMAT(ST) and Element.GETPROPFORMAT('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsSymbol.getPropProp(pointer);
			
			switch prop
				case SettingsSymbol.VISIBLE
					prop_format = SettingsSymbol.VISIBLE_FORMAT;
				case SettingsSymbol.X
					prop_format = SettingsSymbol.X_FORMAT;
				case SettingsSymbol.Y
					prop_format = SettingsSymbol.Y_FORMAT;
				case SettingsSymbol.Z
					prop_format = SettingsSymbol.Z_FORMAT;
				case SettingsSymbol.SYMBOL
					prop_format = SettingsSymbol.SYMBOL_FORMAT;
				case SettingsSymbol.SYMBOLSIZE
					prop_format = SettingsSymbol.SYMBOLSIZE_FORMAT;
				case SettingsSymbol.EDGECOLOR
					prop_format = SettingsSymbol.EDGECOLOR_FORMAT;
				case SettingsSymbol.FACECOLOR
					prop_format = SettingsSymbol.FACECOLOR_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsSymbol, POINTER) returns description of POINTER of SettingsSymbol.
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(SettingsSymbol, POINTER) returns description of POINTER of SettingsSymbol.
			%
			% Note that the Element.GETPROPDESCRIPTION(ST) and Element.GETPROPDESCRIPTION('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsSymbol.getPropProp(pointer);
			
			switch prop
				case SettingsSymbol.VISIBLE
					prop_description = 'VISIBLE (figure, logical) determines whether the symbol is visible.';
				case SettingsSymbol.X
					prop_description = 'X (figure, scalar) is the x-coordinate.';
				case SettingsSymbol.Y
					prop_description = 'Y (figure, scalar) is the y-coordinate.';
				case SettingsSymbol.Z
					prop_description = 'Z (figure, scalar) is the z-coordinate.';
				case SettingsSymbol.SYMBOL
					prop_description = 'SYMBOL (figure, marker) is the symbol.';
				case SettingsSymbol.SYMBOLSIZE
					prop_description = 'SYMBOLSIZE (figure, size) is the symbol size.';
				case SettingsSymbol.EDGECOLOR
					prop_description = 'EDGECOLOR (figure, color) is the symbol RGB edge color.';
				case SettingsSymbol.FACECOLOR
					prop_description = 'FACECOLOR (figure, color) is the symbol RGB face color.';
				case SettingsSymbol.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the symbol settings.';
				case SettingsSymbol.NAME
					prop_description = 'NAME (constant, string) is the name of the symbol settings.';
				case SettingsSymbol.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the symbol settings.';
				case SettingsSymbol.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the symbol settings.';
				case SettingsSymbol.ID
					prop_description = 'ID (data, string) is a few-letter code for the symbol settings.';
				case SettingsSymbol.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the symbol settings.';
				case SettingsSymbol.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the symbol settings.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsSymbol, POINTER) returns settings of POINTER of SettingsSymbol.
			%  SETTINGS = ST.GETPROPSETTINGS(SettingsSymbol, POINTER) returns settings of POINTER of SettingsSymbol.
			%
			% Note that the Element.GETPROPSETTINGS(ST) and Element.GETPROPSETTINGS('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsSymbol.getPropProp(pointer);
			
			switch prop
				case SettingsSymbol.VISIBLE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SettingsSymbol.X
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case SettingsSymbol.Y
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case SettingsSymbol.Z
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case SettingsSymbol.SYMBOL
					prop_settings = Format.getFormatSettings(Format.MARKER);
				case SettingsSymbol.SYMBOLSIZE
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case SettingsSymbol.EDGECOLOR
					prop_settings = Format.getFormatSettings(Format.COLOR);
				case SettingsSymbol.FACECOLOR
					prop_settings = Format.getFormatSettings(Format.COLOR);
				case SettingsSymbol.TEMPLATE
					prop_settings = 'SettingsSymbol';
				otherwise
					prop_settings = getPropSettings@Settings(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsSymbol.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsSymbol.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsSymbol, POINTER) returns the default value of POINTER of SettingsSymbol.
			%  DEFAULT = ST.GETPROPDEFAULT(SettingsSymbol, POINTER) returns the default value of POINTER of SettingsSymbol.
			%
			% Note that the Element.GETPROPDEFAULT(ST) and Element.GETPROPDEFAULT('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsSymbol.getPropProp(pointer);
			
			switch prop
				case SettingsSymbol.VISIBLE
					prop_default = false;
				case SettingsSymbol.X
					prop_default = Format.getFormatDefault(Format.SCALAR, SettingsSymbol.getPropSettings(prop));
				case SettingsSymbol.Y
					prop_default = Format.getFormatDefault(Format.SCALAR, SettingsSymbol.getPropSettings(prop));
				case SettingsSymbol.Z
					prop_default = Format.getFormatDefault(Format.SCALAR, SettingsSymbol.getPropSettings(prop));
				case SettingsSymbol.SYMBOL
					prop_default = Format.getFormatDefault(Format.MARKER, SettingsSymbol.getPropSettings(prop));
				case SettingsSymbol.SYMBOLSIZE
					prop_default = 10;
				case SettingsSymbol.EDGECOLOR
					prop_default = [0 0 0];
				case SettingsSymbol.FACECOLOR
					prop_default = BRAPH2.COL;
				case SettingsSymbol.ELCLASS
					prop_default = 'SettingsSymbol';
				case SettingsSymbol.NAME
					prop_default = 'Symbol Settings';
				case SettingsSymbol.DESCRIPTION
					prop_default = 'A Symbol Settings (SettingsSymbol) provides the settings for a symbol, including visibility, x, y, z, symbol marker, symbol size, face color, and edge color.';
				case SettingsSymbol.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, SettingsSymbol.getPropSettings(prop));
				case SettingsSymbol.ID
					prop_default = 'SettingsSymbol ID';
				case SettingsSymbol.LABEL
					prop_default = 'SettingsSymbol label';
				case SettingsSymbol.NOTES
					prop_default = 'SettingsSymbol notes';
				otherwise
					prop_default = getPropDefault@Settings(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsSymbol.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsSymbol.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsSymbol, POINTER) returns the conditioned default value of POINTER of SettingsSymbol.
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(SettingsSymbol, POINTER) returns the conditioned default value of POINTER of SettingsSymbol.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ST) and Element.GETPROPDEFAULTCONDITIONED('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsSymbol.getPropProp(pointer);
			
			prop_default = SettingsSymbol.conditioning(prop, SettingsSymbol.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsSymbol, PROP, VALUE) checks VALUE format for PROP of SettingsSymbol.
			%  CHECK = ST.CHECKPROP(SettingsSymbol, PROP, VALUE) checks VALUE format for PROP of SettingsSymbol.
			% 
			% ST.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SettingsSymbol:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ST.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ST.
			%   Error id: €BRAPH2.STR€:SettingsSymbol:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SettingsSymbol, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsSymbol.
			%   Error id: €BRAPH2.STR€:SettingsSymbol:€BRAPH2.WRONG_INPUT€
			%  ST.CHECKPROP(SettingsSymbol, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsSymbol.
			%   Error id: €BRAPH2.STR€:SettingsSymbol:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(ST) and Element.CHECKPROP('SettingsSymbol')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsSymbol.getPropProp(pointer);
			
			switch prop
				case SettingsSymbol.VISIBLE % __SettingsSymbol.VISIBLE__
					check = Format.checkFormat(Format.LOGICAL, value, SettingsSymbol.getPropSettings(prop));
				case SettingsSymbol.X % __SettingsSymbol.X__
					check = Format.checkFormat(Format.SCALAR, value, SettingsSymbol.getPropSettings(prop));
				case SettingsSymbol.Y % __SettingsSymbol.Y__
					check = Format.checkFormat(Format.SCALAR, value, SettingsSymbol.getPropSettings(prop));
				case SettingsSymbol.Z % __SettingsSymbol.Z__
					check = Format.checkFormat(Format.SCALAR, value, SettingsSymbol.getPropSettings(prop));
				case SettingsSymbol.SYMBOL % __SettingsSymbol.SYMBOL__
					check = Format.checkFormat(Format.MARKER, value, SettingsSymbol.getPropSettings(prop));
				case SettingsSymbol.SYMBOLSIZE % __SettingsSymbol.SYMBOLSIZE__
					check = Format.checkFormat(Format.SIZE, value, SettingsSymbol.getPropSettings(prop));
				case SettingsSymbol.EDGECOLOR % __SettingsSymbol.EDGECOLOR__
					check = Format.checkFormat(Format.COLOR, value, SettingsSymbol.getPropSettings(prop));
				case SettingsSymbol.FACECOLOR % __SettingsSymbol.FACECOLOR__
					check = Format.checkFormat(Format.COLOR, value, SettingsSymbol.getPropSettings(prop));
				case SettingsSymbol.TEMPLATE % __SettingsSymbol.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, SettingsSymbol.getPropSettings(prop));
				otherwise
					if prop <= Settings.getPropNumber()
						check = checkProp@Settings(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsSymbol:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsSymbol:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsSymbol.getPropTag(prop) ' (' SettingsSymbol.getFormatTag(SettingsSymbol.getPropFormat(prop)) ').'] ...
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
				case SettingsSymbol.VISIBLE % __SettingsSymbol.VISIBLE__
					h = st.get('H');
					if check_graphics(h, 'line') && ( ...
					        get(h, 'Visible') ~= st.get('VISIBLE') || ...
					        get(h, 'XData') ~= st.get('X') || ...
					        get(h, 'YData') ~= st.get('Y') || ...
					        get(h, 'ZData') ~= st.get('Z') || ...
					        ~isequal(get(h, 'Marker'), regexprep(st.get('SYMBOL'), 'none', '')) || ...
					        get(h, 'MarkerSize') ~= st.get('SYMBOLSIZE') || ...
					        ~isequal(get(h, 'MarkerEdgeColor'), st.get('EDGECOLOR')) || ...
					        ~isequal(get(h, 'MarkerFaceColor'), st.get('FACECOLOR')) ...
					        )
					    if st.get('VISIBLE')
					        set(h, ...
					            'XData', st.get('X'), ...
					            'YData', st.get('Y'), ...
					            'ZData', st.get('Z'), ...
					            'Marker', st.get('SYMBOL'), ...
					            'MarkerSize', st.get('SYMBOLSIZE'), ...
					            'MarkerEdgeColor', st.get('EDGECOLOR'), ...
					            'MarkerFaceColor', st.get('FACECOLOR'), ...
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
