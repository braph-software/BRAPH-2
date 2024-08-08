classdef SettingsLine < Settings
	%SettingsLine contains the line settings.
	% It is a subclass of <a href="matlab:help Settings">Settings</a>.
	%
	% A Line Settings (SettingsSymbol) provides the settings for a line, 
	%  including visibility, x, y, z, line color, line width, line style, 
	%  symbol marker, symbol size, symbol face color, and symbol edge color.
	% The handle must be a line.
	%
	% SettingsLine methods (constructor):
	%  SettingsLine - constructor
	%
	% SettingsLine methods:
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
	% SettingsLine methods (display):
	%  tostring - string with information about the line settings
	%  disp - displays information about the line settings
	%  tree - displays the tree of the line settings
	%
	% SettingsLine methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two line settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the line settings
	%
	% SettingsLine methods (save/load, Static):
	%  save - saves BRAPH2 line settings as b2 file
	%  load - loads a BRAPH2 line settings from a b2 file
	%
	% SettingsLine method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the line settings
	%
	% SettingsLine method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the line settings
	%
	% SettingsLine methods (inspection, Static):
	%  getClass - returns the class of the line settings
	%  getSubclasses - returns all subclasses of SettingsLine
	%  getProps - returns the property list of the line settings
	%  getPropNumber - returns the property number of the line settings
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
	% SettingsLine methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsLine methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsLine methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsLine methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsLine; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsLine constants</a>.
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
		X_FORMAT = Format.RVECTOR;
		
		Y = Settings.getPropNumber() + 3;
		Y_TAG = 'Y';
		Y_CATEGORY = Category.FIGURE;
		Y_FORMAT = Format.RVECTOR;
		
		Z = Settings.getPropNumber() + 4;
		Z_TAG = 'Z';
		Z_CATEGORY = Category.FIGURE;
		Z_FORMAT = Format.RVECTOR;
		
		LINESTYLE = Settings.getPropNumber() + 5;
		LINESTYLE_TAG = 'LINESTYLE';
		LINESTYLE_CATEGORY = Category.FIGURE;
		LINESTYLE_FORMAT = Format.LINE;
		
		LINEWIDTH = Settings.getPropNumber() + 6;
		LINEWIDTH_TAG = 'LINEWIDTH';
		LINEWIDTH_CATEGORY = Category.FIGURE;
		LINEWIDTH_FORMAT = Format.SIZE;
		
		LINECOLOR = Settings.getPropNumber() + 7;
		LINECOLOR_TAG = 'LINECOLOR';
		LINECOLOR_CATEGORY = Category.FIGURE;
		LINECOLOR_FORMAT = Format.COLOR;
		
		SYMBOL = Settings.getPropNumber() + 8;
		SYMBOL_TAG = 'SYMBOL';
		SYMBOL_CATEGORY = Category.FIGURE;
		SYMBOL_FORMAT = Format.MARKER;
		
		SYMBOLSIZE = Settings.getPropNumber() + 9;
		SYMBOLSIZE_TAG = 'SYMBOLSIZE';
		SYMBOLSIZE_CATEGORY = Category.FIGURE;
		SYMBOLSIZE_FORMAT = Format.SIZE;
		
		EDGECOLOR = Settings.getPropNumber() + 10;
		EDGECOLOR_TAG = 'EDGECOLOR';
		EDGECOLOR_CATEGORY = Category.FIGURE;
		EDGECOLOR_FORMAT = Format.COLOR;
		
		FACECOLOR = Settings.getPropNumber() + 11;
		FACECOLOR_TAG = 'FACECOLOR';
		FACECOLOR_CATEGORY = Category.FIGURE;
		FACECOLOR_FORMAT = Format.COLOR;
	end
	methods % constructor
		function st = SettingsLine(varargin)
			%SettingsLine() creates a line settings.
			%
			% SettingsLine(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsLine(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the line settings.
			%
			% CLASS = SettingsLine.GETCLASS() returns the class 'SettingsLine'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ST.GETCLASS() returns the class of the line settings ST.
			%  CLASS = Element.GETCLASS(ST) returns the class of 'ST'.
			%  CLASS = Element.GETCLASS('SettingsLine') returns 'SettingsLine'.
			%
			% Note that the Element.GETCLASS(ST) and Element.GETCLASS('SettingsLine')
			%  are less computationally efficient.
			
			st_class = 'SettingsLine';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the line settings.
			%
			% LIST = SettingsLine.GETSUBCLASSES() returns all subclasses of 'SettingsLine'.
			%
			% Alternative forms to call this method are:
			%  LIST = ST.GETSUBCLASSES() returns all subclasses of the line settings ST.
			%  LIST = Element.GETSUBCLASSES(ST) returns all subclasses of 'ST'.
			%  LIST = Element.GETSUBCLASSES('SettingsLine') returns all subclasses of 'SettingsLine'.
			%
			% Note that the Element.GETSUBCLASSES(ST) and Element.GETSUBCLASSES('SettingsLine')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SettingsLine', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of line settings.
			%
			% PROPS = SettingsLine.GETPROPS() returns the property list of line settings
			%  as a row vector.
			%
			% PROPS = SettingsLine.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ST.GETPROPS([CATEGORY]) returns the property list of the line settings ST.
			%  PROPS = Element.GETPROPS(ST[, CATEGORY]) returns the property list of 'ST'.
			%  PROPS = Element.GETPROPS('SettingsLine'[, CATEGORY]) returns the property list of 'SettingsLine'.
			%
			% Note that the Element.GETPROPS(ST) and Element.GETPROPS('SettingsLine')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Settings.getProps() ...
						SettingsLine.VISIBLE ...
						SettingsLine.X ...
						SettingsLine.Y ...
						SettingsLine.Z ...
						SettingsLine.LINESTYLE ...
						SettingsLine.LINEWIDTH ...
						SettingsLine.LINECOLOR ...
						SettingsLine.SYMBOL ...
						SettingsLine.SYMBOLSIZE ...
						SettingsLine.EDGECOLOR ...
						SettingsLine.FACECOLOR ...
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
						SettingsLine.VISIBLE ...
						SettingsLine.X ...
						SettingsLine.Y ...
						SettingsLine.Z ...
						SettingsLine.LINESTYLE ...
						SettingsLine.LINEWIDTH ...
						SettingsLine.LINECOLOR ...
						SettingsLine.SYMBOL ...
						SettingsLine.SYMBOLSIZE ...
						SettingsLine.EDGECOLOR ...
						SettingsLine.FACECOLOR ...
						];
				case Category.GUI
					prop_list = [ ...
						Settings.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of line settings.
			%
			% N = SettingsLine.GETPROPNUMBER() returns the property number of line settings.
			%
			% N = SettingsLine.GETPROPNUMBER(CATEGORY) returns the property number of line settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ST.GETPROPNUMBER([CATEGORY]) returns the property number of the line settings ST.
			%  N = Element.GETPROPNUMBER(ST) returns the property number of 'ST'.
			%  N = Element.GETPROPNUMBER('SettingsLine') returns the property number of 'SettingsLine'.
			%
			% Note that the Element.GETPROPNUMBER(ST) and Element.GETPROPNUMBER('SettingsLine')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SettingsLine.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in line settings/error.
			%
			% CHECK = SettingsLine.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSPROP(PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(ST, PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(SettingsLine, PROP) checks whether PROP exists for SettingsLine.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsLine:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSPROP(PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsLine:WrongInput]
			%  Element.EXISTSPROP(ST, PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsLine:WrongInput]
			%  Element.EXISTSPROP(SettingsLine, PROP) throws error if PROP does NOT exist for SettingsLine.
			%   Error id: [BRAPH2:SettingsLine:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ST) and Element.EXISTSPROP('SettingsLine')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SettingsLine.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsLine:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsLine:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsLine.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in line settings/error.
			%
			% CHECK = SettingsLine.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSTAG(TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(ST, TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(SettingsLine, TAG) checks whether TAG exists for SettingsLine.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsLine:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSTAG(TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsLine:WrongInput]
			%  Element.EXISTSTAG(ST, TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsLine:WrongInput]
			%  Element.EXISTSTAG(SettingsLine, TAG) throws error if TAG does NOT exist for SettingsLine.
			%   Error id: [BRAPH2:SettingsLine:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ST) and Element.EXISTSTAG('SettingsLine')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			settingsline_tag_list = cellfun(@(x) SettingsLine.getPropTag(x), num2cell(SettingsLine.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, settingsline_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsLine:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsLine:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SettingsLine.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsLine, POINTER) returns property number of POINTER of SettingsLine.
			%  PROPERTY = ST.GETPROPPROP(SettingsLine, POINTER) returns property number of POINTER of SettingsLine.
			%
			% Note that the Element.GETPROPPROP(ST) and Element.GETPROPPROP('SettingsLine')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				settingsline_tag_list = cellfun(@(x) SettingsLine.getPropTag(x), num2cell(SettingsLine.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, settingsline_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(SettingsLine, POINTER) returns tag of POINTER of SettingsLine.
			%  TAG = ST.GETPROPTAG(SettingsLine, POINTER) returns tag of POINTER of SettingsLine.
			%
			% Note that the Element.GETPROPTAG(ST) and Element.GETPROPTAG('SettingsLine')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SettingsLine.VISIBLE
						tag = SettingsLine.VISIBLE_TAG;
					case SettingsLine.X
						tag = SettingsLine.X_TAG;
					case SettingsLine.Y
						tag = SettingsLine.Y_TAG;
					case SettingsLine.Z
						tag = SettingsLine.Z_TAG;
					case SettingsLine.LINESTYLE
						tag = SettingsLine.LINESTYLE_TAG;
					case SettingsLine.LINEWIDTH
						tag = SettingsLine.LINEWIDTH_TAG;
					case SettingsLine.LINECOLOR
						tag = SettingsLine.LINECOLOR_TAG;
					case SettingsLine.SYMBOL
						tag = SettingsLine.SYMBOL_TAG;
					case SettingsLine.SYMBOLSIZE
						tag = SettingsLine.SYMBOLSIZE_TAG;
					case SettingsLine.EDGECOLOR
						tag = SettingsLine.EDGECOLOR_TAG;
					case SettingsLine.FACECOLOR
						tag = SettingsLine.FACECOLOR_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsLine, POINTER) returns category of POINTER of SettingsLine.
			%  CATEGORY = ST.GETPROPCATEGORY(SettingsLine, POINTER) returns category of POINTER of SettingsLine.
			%
			% Note that the Element.GETPROPCATEGORY(ST) and Element.GETPROPCATEGORY('SettingsLine')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsLine.getPropProp(pointer);
			
			switch prop
				case SettingsLine.VISIBLE
					prop_category = SettingsLine.VISIBLE_CATEGORY;
				case SettingsLine.X
					prop_category = SettingsLine.X_CATEGORY;
				case SettingsLine.Y
					prop_category = SettingsLine.Y_CATEGORY;
				case SettingsLine.Z
					prop_category = SettingsLine.Z_CATEGORY;
				case SettingsLine.LINESTYLE
					prop_category = SettingsLine.LINESTYLE_CATEGORY;
				case SettingsLine.LINEWIDTH
					prop_category = SettingsLine.LINEWIDTH_CATEGORY;
				case SettingsLine.LINECOLOR
					prop_category = SettingsLine.LINECOLOR_CATEGORY;
				case SettingsLine.SYMBOL
					prop_category = SettingsLine.SYMBOL_CATEGORY;
				case SettingsLine.SYMBOLSIZE
					prop_category = SettingsLine.SYMBOLSIZE_CATEGORY;
				case SettingsLine.EDGECOLOR
					prop_category = SettingsLine.EDGECOLOR_CATEGORY;
				case SettingsLine.FACECOLOR
					prop_category = SettingsLine.FACECOLOR_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsLine, POINTER) returns format of POINTER of SettingsLine.
			%  FORMAT = ST.GETPROPFORMAT(SettingsLine, POINTER) returns format of POINTER of SettingsLine.
			%
			% Note that the Element.GETPROPFORMAT(ST) and Element.GETPROPFORMAT('SettingsLine')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsLine.getPropProp(pointer);
			
			switch prop
				case SettingsLine.VISIBLE
					prop_format = SettingsLine.VISIBLE_FORMAT;
				case SettingsLine.X
					prop_format = SettingsLine.X_FORMAT;
				case SettingsLine.Y
					prop_format = SettingsLine.Y_FORMAT;
				case SettingsLine.Z
					prop_format = SettingsLine.Z_FORMAT;
				case SettingsLine.LINESTYLE
					prop_format = SettingsLine.LINESTYLE_FORMAT;
				case SettingsLine.LINEWIDTH
					prop_format = SettingsLine.LINEWIDTH_FORMAT;
				case SettingsLine.LINECOLOR
					prop_format = SettingsLine.LINECOLOR_FORMAT;
				case SettingsLine.SYMBOL
					prop_format = SettingsLine.SYMBOL_FORMAT;
				case SettingsLine.SYMBOLSIZE
					prop_format = SettingsLine.SYMBOLSIZE_FORMAT;
				case SettingsLine.EDGECOLOR
					prop_format = SettingsLine.EDGECOLOR_FORMAT;
				case SettingsLine.FACECOLOR
					prop_format = SettingsLine.FACECOLOR_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsLine, POINTER) returns description of POINTER of SettingsLine.
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(SettingsLine, POINTER) returns description of POINTER of SettingsLine.
			%
			% Note that the Element.GETPROPDESCRIPTION(ST) and Element.GETPROPDESCRIPTION('SettingsLine')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsLine.getPropProp(pointer);
			
			switch prop
				case SettingsLine.VISIBLE
					prop_description = 'VISIBLE (figure, logical) determines whether the symbol is visible.';
				case SettingsLine.X
					prop_description = 'X (figure, rvector) is the vector of the x-coordinates.';
				case SettingsLine.Y
					prop_description = 'Y (figure, rvector) is the vector of the y-coordinates.';
				case SettingsLine.Z
					prop_description = 'Z (figure, rvector) is the vector of the z-coordinates.';
				case SettingsLine.LINESTYLE
					prop_description = 'LINESTYLE (figure, line) is the line style.';
				case SettingsLine.LINEWIDTH
					prop_description = 'LINEWIDTH (figure, size) is the line width.';
				case SettingsLine.LINECOLOR
					prop_description = 'LINECOLOR (figure, color) is the line RGB color.';
				case SettingsLine.SYMBOL
					prop_description = 'SYMBOL (figure, marker) is the symbol style.';
				case SettingsLine.SYMBOLSIZE
					prop_description = 'SYMBOLSIZE (figure, size) is the symbol size.';
				case SettingsLine.EDGECOLOR
					prop_description = 'EDGECOLOR (figure, color) is the symbol RGB edge color.';
				case SettingsLine.FACECOLOR
					prop_description = 'FACECOLOR (figure, color) is the symbol RGB face color.';
				case SettingsLine.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the line settings.';
				case SettingsLine.NAME
					prop_description = 'NAME (constant, string) is the name of the line settings.';
				case SettingsLine.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the line settings.';
				case SettingsLine.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the line settings.';
				case SettingsLine.ID
					prop_description = 'ID (data, string) is a few-letter code for the line settings.';
				case SettingsLine.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the line settings.';
				case SettingsLine.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the line settings.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsLine, POINTER) returns settings of POINTER of SettingsLine.
			%  SETTINGS = ST.GETPROPSETTINGS(SettingsLine, POINTER) returns settings of POINTER of SettingsLine.
			%
			% Note that the Element.GETPROPSETTINGS(ST) and Element.GETPROPSETTINGS('SettingsLine')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsLine.getPropProp(pointer);
			
			switch prop
				case SettingsLine.VISIBLE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SettingsLine.X
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case SettingsLine.Y
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case SettingsLine.Z
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case SettingsLine.LINESTYLE
					prop_settings = Format.getFormatSettings(Format.LINE);
				case SettingsLine.LINEWIDTH
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case SettingsLine.LINECOLOR
					prop_settings = Format.getFormatSettings(Format.COLOR);
				case SettingsLine.SYMBOL
					prop_settings = Format.getFormatSettings(Format.MARKER);
				case SettingsLine.SYMBOLSIZE
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case SettingsLine.EDGECOLOR
					prop_settings = Format.getFormatSettings(Format.COLOR);
				case SettingsLine.FACECOLOR
					prop_settings = Format.getFormatSettings(Format.COLOR);
				case SettingsLine.TEMPLATE
					prop_settings = 'SettingsLine';
				otherwise
					prop_settings = getPropSettings@Settings(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsLine.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsLine.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsLine, POINTER) returns the default value of POINTER of SettingsLine.
			%  DEFAULT = ST.GETPROPDEFAULT(SettingsLine, POINTER) returns the default value of POINTER of SettingsLine.
			%
			% Note that the Element.GETPROPDEFAULT(ST) and Element.GETPROPDEFAULT('SettingsLine')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsLine.getPropProp(pointer);
			
			switch prop
				case SettingsLine.VISIBLE
					prop_default = true;
				case SettingsLine.X
					prop_default = Format.getFormatDefault(Format.RVECTOR, SettingsLine.getPropSettings(prop));
				case SettingsLine.Y
					prop_default = Format.getFormatDefault(Format.RVECTOR, SettingsLine.getPropSettings(prop));
				case SettingsLine.Z
					prop_default = Format.getFormatDefault(Format.RVECTOR, SettingsLine.getPropSettings(prop));
				case SettingsLine.LINESTYLE
					prop_default = Format.getFormatDefault(Format.LINE, SettingsLine.getPropSettings(prop));
				case SettingsLine.LINEWIDTH
					prop_default = Format.getFormatDefault(Format.SIZE, SettingsLine.getPropSettings(prop));
				case SettingsLine.LINECOLOR
					prop_default = [0 0 0];
				case SettingsLine.SYMBOL
					prop_default = Format.getFormatDefault(Format.MARKER, SettingsLine.getPropSettings(prop));
				case SettingsLine.SYMBOLSIZE
					prop_default = 10;
				case SettingsLine.EDGECOLOR
					prop_default = [0 0 0];
				case SettingsLine.FACECOLOR
					prop_default = BRAPH2.COL;
				case SettingsLine.ELCLASS
					prop_default = 'SettingsLine';
				case SettingsLine.NAME
					prop_default = 'Line Settings';
				case SettingsLine.DESCRIPTION
					prop_default = 'A Line Settings (SettingsSymbol) provides the settings for a line, including visibility, x, y, z, line color, line width, line style, symbol marker, symbol size, symbol face color, and symbol edge color. The handle must be a line.';
				case SettingsLine.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, SettingsLine.getPropSettings(prop));
				case SettingsLine.ID
					prop_default = 'SettingsLine ID';
				case SettingsLine.LABEL
					prop_default = 'SettingsLine label';
				case SettingsLine.NOTES
					prop_default = 'SettingsLine notes';
				otherwise
					prop_default = getPropDefault@Settings(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsLine.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsLine.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsLine, POINTER) returns the conditioned default value of POINTER of SettingsLine.
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(SettingsLine, POINTER) returns the conditioned default value of POINTER of SettingsLine.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ST) and Element.GETPROPDEFAULTCONDITIONED('SettingsLine')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsLine.getPropProp(pointer);
			
			prop_default = SettingsLine.conditioning(prop, SettingsLine.getPropDefault(prop));
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
			
			prop = SettingsLine.getPropProp(pointer);
			
			switch prop
				case SettingsLine.X % __SettingsLine.X__
					value = value(:)';
					
				case SettingsLine.Y % __SettingsLine.Y__
					value = value(:)';
					
				case SettingsLine.Z % __SettingsLine.Z__
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
			%  CHECK = Element.CHECKPROP(SettingsLine, PROP, VALUE) checks VALUE format for PROP of SettingsLine.
			%  CHECK = ST.CHECKPROP(SettingsLine, PROP, VALUE) checks VALUE format for PROP of SettingsLine.
			% 
			% ST.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SettingsLine:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ST.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ST.
			%   Error id: €BRAPH2.STR€:SettingsLine:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SettingsLine, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsLine.
			%   Error id: €BRAPH2.STR€:SettingsLine:€BRAPH2.WRONG_INPUT€
			%  ST.CHECKPROP(SettingsLine, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsLine.
			%   Error id: €BRAPH2.STR€:SettingsLine:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(ST) and Element.CHECKPROP('SettingsLine')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsLine.getPropProp(pointer);
			
			switch prop
				case SettingsLine.VISIBLE % __SettingsLine.VISIBLE__
					check = Format.checkFormat(Format.LOGICAL, value, SettingsLine.getPropSettings(prop));
				case SettingsLine.X % __SettingsLine.X__
					check = Format.checkFormat(Format.RVECTOR, value, SettingsLine.getPropSettings(prop));
				case SettingsLine.Y % __SettingsLine.Y__
					check = Format.checkFormat(Format.RVECTOR, value, SettingsLine.getPropSettings(prop));
				case SettingsLine.Z % __SettingsLine.Z__
					check = Format.checkFormat(Format.RVECTOR, value, SettingsLine.getPropSettings(prop));
				case SettingsLine.LINESTYLE % __SettingsLine.LINESTYLE__
					check = Format.checkFormat(Format.LINE, value, SettingsLine.getPropSettings(prop));
				case SettingsLine.LINEWIDTH % __SettingsLine.LINEWIDTH__
					check = Format.checkFormat(Format.SIZE, value, SettingsLine.getPropSettings(prop));
				case SettingsLine.LINECOLOR % __SettingsLine.LINECOLOR__
					check = Format.checkFormat(Format.COLOR, value, SettingsLine.getPropSettings(prop));
				case SettingsLine.SYMBOL % __SettingsLine.SYMBOL__
					check = Format.checkFormat(Format.MARKER, value, SettingsLine.getPropSettings(prop));
				case SettingsLine.SYMBOLSIZE % __SettingsLine.SYMBOLSIZE__
					check = Format.checkFormat(Format.SIZE, value, SettingsLine.getPropSettings(prop));
				case SettingsLine.EDGECOLOR % __SettingsLine.EDGECOLOR__
					check = Format.checkFormat(Format.COLOR, value, SettingsLine.getPropSettings(prop));
				case SettingsLine.FACECOLOR % __SettingsLine.FACECOLOR__
					check = Format.checkFormat(Format.COLOR, value, SettingsLine.getPropSettings(prop));
				case SettingsLine.TEMPLATE % __SettingsLine.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, SettingsLine.getPropSettings(prop));
				otherwise
					if prop <= Settings.getPropNumber()
						check = checkProp@Settings(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsLine:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsLine:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsLine.getPropTag(prop) ' (' SettingsLine.getFormatTag(SettingsLine.getPropFormat(prop)) ').'] ...
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
				case SettingsLine.VISIBLE % __SettingsLine.VISIBLE__
					h = st.get('H');
					if check_graphics(h, 'line') && ( ...
					        get(h, 'Visible') ~= st.get('VISIBLE') || ...
					        ~isequal(get(h, 'XData'), st.get('X')) || ...
					        ~isequal(get(h, 'YData'), st.get('Y')) || ...
					        ~isequal(get(h, 'ZData'), st.get('Z')) || ...
					        ~isequal(get(h, 'Color'), st.get('LINECOLOR')) || ...
					        ~isequal(get(h, 'LineStyle'), st.get('LINESTYLE')) || ...
					        get(h, 'LineWidth') ~= st.get('LINEWIDTH') || ...
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
					            'Color', st.get('LINECOLOR'), ...
					            'LineStyle', st.get('LINESTYLE'), ...
					            'LineWidth', st.get('LINEWIDTH'), ...
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
