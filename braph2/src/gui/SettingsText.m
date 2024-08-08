classdef SettingsText < Settings
	%SettingsText contains the text settings.
	% It is a subclass of <a href="matlab:help Settings">Settings</a>.
	%
	% A Text Settings (SettingsText) provides the settings for a text, 
	% including visibility, x, y, z, font color, font size, and interpreter.
	% The handle can be a text.
	%
	% SettingsText methods (constructor):
	%  SettingsText - constructor
	%
	% SettingsText methods:
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
	% SettingsText methods (display):
	%  tostring - string with information about the text settings
	%  disp - displays information about the text settings
	%  tree - displays the tree of the text settings
	%
	% SettingsText methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two text settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the text settings
	%
	% SettingsText methods (save/load, Static):
	%  save - saves BRAPH2 text settings as b2 file
	%  load - loads a BRAPH2 text settings from a b2 file
	%
	% SettingsText method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the text settings
	%
	% SettingsText method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the text settings
	%
	% SettingsText methods (inspection, Static):
	%  getClass - returns the class of the text settings
	%  getSubclasses - returns all subclasses of SettingsText
	%  getProps - returns the property list of the text settings
	%  getPropNumber - returns the property number of the text settings
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
	% SettingsText methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsText methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsText methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsText methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsText; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsText constants</a>.
	%
	%
	% See also text, PanelFig, GUIFig, check_graphics.
	
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
		
		TXT = Settings.getPropNumber() + 5;
		TXT_TAG = 'TXT';
		TXT_CATEGORY = Category.FIGURE;
		TXT_FORMAT = Format.STRING;
		
		FONTSIZE = Settings.getPropNumber() + 6;
		FONTSIZE_TAG = 'FONTSIZE';
		FONTSIZE_CATEGORY = Category.FIGURE;
		FONTSIZE_FORMAT = Format.SIZE;
		
		FONTNAME = Settings.getPropNumber() + 7;
		FONTNAME_TAG = 'FONTNAME';
		FONTNAME_CATEGORY = Category.FIGURE;
		FONTNAME_FORMAT = Format.STRING;
		
		FONTCOLOR = Settings.getPropNumber() + 8;
		FONTCOLOR_TAG = 'FONTCOLOR';
		FONTCOLOR_CATEGORY = Category.FIGURE;
		FONTCOLOR_FORMAT = Format.COLOR;
		
		FONTWEIGHT = Settings.getPropNumber() + 9;
		FONTWEIGHT_TAG = 'FONTWEIGHT';
		FONTWEIGHT_CATEGORY = Category.FIGURE;
		FONTWEIGHT_FORMAT = Format.OPTION;
		
		INTERPRETER = Settings.getPropNumber() + 10;
		INTERPRETER_TAG = 'INTERPRETER';
		INTERPRETER_CATEGORY = Category.FIGURE;
		INTERPRETER_FORMAT = Format.OPTION;
		
		HALIGN = Settings.getPropNumber() + 11;
		HALIGN_TAG = 'HALIGN';
		HALIGN_CATEGORY = Category.FIGURE;
		HALIGN_FORMAT = Format.OPTION;
		
		VALIGN = Settings.getPropNumber() + 12;
		VALIGN_TAG = 'VALIGN';
		VALIGN_CATEGORY = Category.FIGURE;
		VALIGN_FORMAT = Format.OPTION;
		
		ROTATION = Settings.getPropNumber() + 13;
		ROTATION_TAG = 'ROTATION';
		ROTATION_CATEGORY = Category.FIGURE;
		ROTATION_FORMAT = Format.SCALAR;
	end
	methods % constructor
		function st = SettingsText(varargin)
			%SettingsText() creates a text settings.
			%
			% SettingsText(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsText(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the text settings.
			%
			% CLASS = SettingsText.GETCLASS() returns the class 'SettingsText'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ST.GETCLASS() returns the class of the text settings ST.
			%  CLASS = Element.GETCLASS(ST) returns the class of 'ST'.
			%  CLASS = Element.GETCLASS('SettingsText') returns 'SettingsText'.
			%
			% Note that the Element.GETCLASS(ST) and Element.GETCLASS('SettingsText')
			%  are less computationally efficient.
			
			st_class = 'SettingsText';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the text settings.
			%
			% LIST = SettingsText.GETSUBCLASSES() returns all subclasses of 'SettingsText'.
			%
			% Alternative forms to call this method are:
			%  LIST = ST.GETSUBCLASSES() returns all subclasses of the text settings ST.
			%  LIST = Element.GETSUBCLASSES(ST) returns all subclasses of 'ST'.
			%  LIST = Element.GETSUBCLASSES('SettingsText') returns all subclasses of 'SettingsText'.
			%
			% Note that the Element.GETSUBCLASSES(ST) and Element.GETSUBCLASSES('SettingsText')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SettingsText', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of text settings.
			%
			% PROPS = SettingsText.GETPROPS() returns the property list of text settings
			%  as a row vector.
			%
			% PROPS = SettingsText.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ST.GETPROPS([CATEGORY]) returns the property list of the text settings ST.
			%  PROPS = Element.GETPROPS(ST[, CATEGORY]) returns the property list of 'ST'.
			%  PROPS = Element.GETPROPS('SettingsText'[, CATEGORY]) returns the property list of 'SettingsText'.
			%
			% Note that the Element.GETPROPS(ST) and Element.GETPROPS('SettingsText')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Settings.getProps() ...
						SettingsText.VISIBLE ...
						SettingsText.X ...
						SettingsText.Y ...
						SettingsText.Z ...
						SettingsText.TXT ...
						SettingsText.FONTSIZE ...
						SettingsText.FONTNAME ...
						SettingsText.FONTCOLOR ...
						SettingsText.FONTWEIGHT ...
						SettingsText.INTERPRETER ...
						SettingsText.HALIGN ...
						SettingsText.VALIGN ...
						SettingsText.ROTATION ...
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
						SettingsText.VISIBLE ...
						SettingsText.X ...
						SettingsText.Y ...
						SettingsText.Z ...
						SettingsText.TXT ...
						SettingsText.FONTSIZE ...
						SettingsText.FONTNAME ...
						SettingsText.FONTCOLOR ...
						SettingsText.FONTWEIGHT ...
						SettingsText.INTERPRETER ...
						SettingsText.HALIGN ...
						SettingsText.VALIGN ...
						SettingsText.ROTATION ...
						];
				case Category.GUI
					prop_list = [ ...
						Settings.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of text settings.
			%
			% N = SettingsText.GETPROPNUMBER() returns the property number of text settings.
			%
			% N = SettingsText.GETPROPNUMBER(CATEGORY) returns the property number of text settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ST.GETPROPNUMBER([CATEGORY]) returns the property number of the text settings ST.
			%  N = Element.GETPROPNUMBER(ST) returns the property number of 'ST'.
			%  N = Element.GETPROPNUMBER('SettingsText') returns the property number of 'SettingsText'.
			%
			% Note that the Element.GETPROPNUMBER(ST) and Element.GETPROPNUMBER('SettingsText')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SettingsText.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in text settings/error.
			%
			% CHECK = SettingsText.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSPROP(PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(ST, PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(SettingsText, PROP) checks whether PROP exists for SettingsText.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsText:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSPROP(PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsText:WrongInput]
			%  Element.EXISTSPROP(ST, PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsText:WrongInput]
			%  Element.EXISTSPROP(SettingsText, PROP) throws error if PROP does NOT exist for SettingsText.
			%   Error id: [BRAPH2:SettingsText:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ST) and Element.EXISTSPROP('SettingsText')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SettingsText.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsText:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsText:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsText.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in text settings/error.
			%
			% CHECK = SettingsText.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSTAG(TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(ST, TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(SettingsText, TAG) checks whether TAG exists for SettingsText.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsText:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSTAG(TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsText:WrongInput]
			%  Element.EXISTSTAG(ST, TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsText:WrongInput]
			%  Element.EXISTSTAG(SettingsText, TAG) throws error if TAG does NOT exist for SettingsText.
			%   Error id: [BRAPH2:SettingsText:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ST) and Element.EXISTSTAG('SettingsText')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			settingstext_tag_list = cellfun(@(x) SettingsText.getPropTag(x), num2cell(SettingsText.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, settingstext_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsText:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsText:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SettingsText.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsText, POINTER) returns property number of POINTER of SettingsText.
			%  PROPERTY = ST.GETPROPPROP(SettingsText, POINTER) returns property number of POINTER of SettingsText.
			%
			% Note that the Element.GETPROPPROP(ST) and Element.GETPROPPROP('SettingsText')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				settingstext_tag_list = cellfun(@(x) SettingsText.getPropTag(x), num2cell(SettingsText.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, settingstext_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(SettingsText, POINTER) returns tag of POINTER of SettingsText.
			%  TAG = ST.GETPROPTAG(SettingsText, POINTER) returns tag of POINTER of SettingsText.
			%
			% Note that the Element.GETPROPTAG(ST) and Element.GETPROPTAG('SettingsText')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SettingsText.VISIBLE
						tag = SettingsText.VISIBLE_TAG;
					case SettingsText.X
						tag = SettingsText.X_TAG;
					case SettingsText.Y
						tag = SettingsText.Y_TAG;
					case SettingsText.Z
						tag = SettingsText.Z_TAG;
					case SettingsText.TXT
						tag = SettingsText.TXT_TAG;
					case SettingsText.FONTSIZE
						tag = SettingsText.FONTSIZE_TAG;
					case SettingsText.FONTNAME
						tag = SettingsText.FONTNAME_TAG;
					case SettingsText.FONTCOLOR
						tag = SettingsText.FONTCOLOR_TAG;
					case SettingsText.FONTWEIGHT
						tag = SettingsText.FONTWEIGHT_TAG;
					case SettingsText.INTERPRETER
						tag = SettingsText.INTERPRETER_TAG;
					case SettingsText.HALIGN
						tag = SettingsText.HALIGN_TAG;
					case SettingsText.VALIGN
						tag = SettingsText.VALIGN_TAG;
					case SettingsText.ROTATION
						tag = SettingsText.ROTATION_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsText, POINTER) returns category of POINTER of SettingsText.
			%  CATEGORY = ST.GETPROPCATEGORY(SettingsText, POINTER) returns category of POINTER of SettingsText.
			%
			% Note that the Element.GETPROPCATEGORY(ST) and Element.GETPROPCATEGORY('SettingsText')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsText.getPropProp(pointer);
			
			switch prop
				case SettingsText.VISIBLE
					prop_category = SettingsText.VISIBLE_CATEGORY;
				case SettingsText.X
					prop_category = SettingsText.X_CATEGORY;
				case SettingsText.Y
					prop_category = SettingsText.Y_CATEGORY;
				case SettingsText.Z
					prop_category = SettingsText.Z_CATEGORY;
				case SettingsText.TXT
					prop_category = SettingsText.TXT_CATEGORY;
				case SettingsText.FONTSIZE
					prop_category = SettingsText.FONTSIZE_CATEGORY;
				case SettingsText.FONTNAME
					prop_category = SettingsText.FONTNAME_CATEGORY;
				case SettingsText.FONTCOLOR
					prop_category = SettingsText.FONTCOLOR_CATEGORY;
				case SettingsText.FONTWEIGHT
					prop_category = SettingsText.FONTWEIGHT_CATEGORY;
				case SettingsText.INTERPRETER
					prop_category = SettingsText.INTERPRETER_CATEGORY;
				case SettingsText.HALIGN
					prop_category = SettingsText.HALIGN_CATEGORY;
				case SettingsText.VALIGN
					prop_category = SettingsText.VALIGN_CATEGORY;
				case SettingsText.ROTATION
					prop_category = SettingsText.ROTATION_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsText, POINTER) returns format of POINTER of SettingsText.
			%  FORMAT = ST.GETPROPFORMAT(SettingsText, POINTER) returns format of POINTER of SettingsText.
			%
			% Note that the Element.GETPROPFORMAT(ST) and Element.GETPROPFORMAT('SettingsText')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsText.getPropProp(pointer);
			
			switch prop
				case SettingsText.VISIBLE
					prop_format = SettingsText.VISIBLE_FORMAT;
				case SettingsText.X
					prop_format = SettingsText.X_FORMAT;
				case SettingsText.Y
					prop_format = SettingsText.Y_FORMAT;
				case SettingsText.Z
					prop_format = SettingsText.Z_FORMAT;
				case SettingsText.TXT
					prop_format = SettingsText.TXT_FORMAT;
				case SettingsText.FONTSIZE
					prop_format = SettingsText.FONTSIZE_FORMAT;
				case SettingsText.FONTNAME
					prop_format = SettingsText.FONTNAME_FORMAT;
				case SettingsText.FONTCOLOR
					prop_format = SettingsText.FONTCOLOR_FORMAT;
				case SettingsText.FONTWEIGHT
					prop_format = SettingsText.FONTWEIGHT_FORMAT;
				case SettingsText.INTERPRETER
					prop_format = SettingsText.INTERPRETER_FORMAT;
				case SettingsText.HALIGN
					prop_format = SettingsText.HALIGN_FORMAT;
				case SettingsText.VALIGN
					prop_format = SettingsText.VALIGN_FORMAT;
				case SettingsText.ROTATION
					prop_format = SettingsText.ROTATION_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsText, POINTER) returns description of POINTER of SettingsText.
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(SettingsText, POINTER) returns description of POINTER of SettingsText.
			%
			% Note that the Element.GETPROPDESCRIPTION(ST) and Element.GETPROPDESCRIPTION('SettingsText')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsText.getPropProp(pointer);
			
			switch prop
				case SettingsText.VISIBLE
					prop_description = 'VISIBLE (figure, logical) determines whether the text is visible.';
				case SettingsText.X
					prop_description = 'X (figure, scalar) is the x-coordinate.';
				case SettingsText.Y
					prop_description = 'Y (figure, scalar) is the y-coordinate.';
				case SettingsText.Z
					prop_description = 'Z (figure, scalar) is the z-coordinate.';
				case SettingsText.TXT
					prop_description = 'TXT (figure, string) is the text.';
				case SettingsText.FONTSIZE
					prop_description = 'FONTSIZE (figure, size) is the font size.';
				case SettingsText.FONTNAME
					prop_description = 'FONTNAME (figure, string) is the font name.';
				case SettingsText.FONTCOLOR
					prop_description = 'FONTCOLOR (figure, color) is the text color.';
				case SettingsText.FONTWEIGHT
					prop_description = 'FONTWEIGHT (figure, option) is the font weight.';
				case SettingsText.INTERPRETER
					prop_description = 'INTERPRETER (figure, option) is the text interpreter.';
				case SettingsText.HALIGN
					prop_description = 'HALIGN (figure, option) is the text horizonthal alignment.';
				case SettingsText.VALIGN
					prop_description = 'VALIGN (figure, option) is the text vertical alignment.';
				case SettingsText.ROTATION
					prop_description = 'ROTATION (figure, scalar) is the text rotation.';
				case SettingsText.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the text settings.';
				case SettingsText.NAME
					prop_description = 'NAME (constant, string) is the name of the text settings.';
				case SettingsText.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the text settings.';
				case SettingsText.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the text settings.';
				case SettingsText.ID
					prop_description = 'ID (data, string) is a few-letter code for the text settings.';
				case SettingsText.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the text settings.';
				case SettingsText.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the text settings.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsText, POINTER) returns settings of POINTER of SettingsText.
			%  SETTINGS = ST.GETPROPSETTINGS(SettingsText, POINTER) returns settings of POINTER of SettingsText.
			%
			% Note that the Element.GETPROPSETTINGS(ST) and Element.GETPROPSETTINGS('SettingsText')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsText.getPropProp(pointer);
			
			switch prop
				case SettingsText.VISIBLE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SettingsText.X
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case SettingsText.Y
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case SettingsText.Z
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case SettingsText.TXT
					prop_settings = Format.getFormatSettings(Format.STRING);
				case SettingsText.FONTSIZE
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case SettingsText.FONTNAME
					prop_settings = Format.getFormatSettings(Format.STRING);
				case SettingsText.FONTCOLOR
					prop_settings = Format.getFormatSettings(Format.COLOR);
				case SettingsText.FONTWEIGHT
					prop_settings = {'normal' 'bold'};
				case SettingsText.INTERPRETER
					prop_settings = {'none', 'TeX', 'LaTeX'};
				case SettingsText.HALIGN
					prop_settings = {'left', 'center', 'right'};
				case SettingsText.VALIGN
					prop_settings = {'middle', 'top', 'bottom', 'baseline', 'cap'};
				case SettingsText.ROTATION
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case SettingsText.TEMPLATE
					prop_settings = 'SettingsText';
				otherwise
					prop_settings = getPropSettings@Settings(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsText.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsText.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsText, POINTER) returns the default value of POINTER of SettingsText.
			%  DEFAULT = ST.GETPROPDEFAULT(SettingsText, POINTER) returns the default value of POINTER of SettingsText.
			%
			% Note that the Element.GETPROPDEFAULT(ST) and Element.GETPROPDEFAULT('SettingsText')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsText.getPropProp(pointer);
			
			switch prop
				case SettingsText.VISIBLE
					prop_default = Format.getFormatDefault(Format.LOGICAL, SettingsText.getPropSettings(prop));
				case SettingsText.X
					prop_default = Format.getFormatDefault(Format.SCALAR, SettingsText.getPropSettings(prop));
				case SettingsText.Y
					prop_default = Format.getFormatDefault(Format.SCALAR, SettingsText.getPropSettings(prop));
				case SettingsText.Z
					prop_default = Format.getFormatDefault(Format.SCALAR, SettingsText.getPropSettings(prop));
				case SettingsText.TXT
					prop_default = Format.getFormatDefault(Format.STRING, SettingsText.getPropSettings(prop));
				case SettingsText.FONTSIZE
					prop_default = BRAPH2.FONTSIZE;
				case SettingsText.FONTNAME
					prop_default = 'Helvetica';
				case SettingsText.FONTCOLOR
					prop_default = [0 0 0];
				case SettingsText.FONTWEIGHT
					prop_default = 'normal';
				case SettingsText.INTERPRETER
					prop_default = 'none';
				case SettingsText.HALIGN
					prop_default = Format.getFormatDefault(Format.OPTION, SettingsText.getPropSettings(prop));
				case SettingsText.VALIGN
					prop_default = Format.getFormatDefault(Format.OPTION, SettingsText.getPropSettings(prop));
				case SettingsText.ROTATION
					prop_default = Format.getFormatDefault(Format.SCALAR, SettingsText.getPropSettings(prop));
				case SettingsText.ELCLASS
					prop_default = 'SettingsText';
				case SettingsText.NAME
					prop_default = 'Text Settings';
				case SettingsText.DESCRIPTION
					prop_default = 'A Text Settings (SettingsText) provides the settings for a text, including visibility, x, y, z, font color, font size, and interpreter.';
				case SettingsText.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, SettingsText.getPropSettings(prop));
				case SettingsText.ID
					prop_default = 'SettingsText ID';
				case SettingsText.LABEL
					prop_default = 'SettingsText label';
				case SettingsText.NOTES
					prop_default = 'SettingsText notes';
				otherwise
					prop_default = getPropDefault@Settings(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsText.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsText.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsText, POINTER) returns the conditioned default value of POINTER of SettingsText.
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(SettingsText, POINTER) returns the conditioned default value of POINTER of SettingsText.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ST) and Element.GETPROPDEFAULTCONDITIONED('SettingsText')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsText.getPropProp(pointer);
			
			prop_default = SettingsText.conditioning(prop, SettingsText.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsText, PROP, VALUE) checks VALUE format for PROP of SettingsText.
			%  CHECK = ST.CHECKPROP(SettingsText, PROP, VALUE) checks VALUE format for PROP of SettingsText.
			% 
			% ST.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SettingsText:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ST.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ST.
			%   Error id: €BRAPH2.STR€:SettingsText:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SettingsText, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsText.
			%   Error id: €BRAPH2.STR€:SettingsText:€BRAPH2.WRONG_INPUT€
			%  ST.CHECKPROP(SettingsText, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsText.
			%   Error id: €BRAPH2.STR€:SettingsText:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(ST) and Element.CHECKPROP('SettingsText')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsText.getPropProp(pointer);
			
			switch prop
				case SettingsText.VISIBLE % __SettingsText.VISIBLE__
					check = Format.checkFormat(Format.LOGICAL, value, SettingsText.getPropSettings(prop));
				case SettingsText.X % __SettingsText.X__
					check = Format.checkFormat(Format.SCALAR, value, SettingsText.getPropSettings(prop));
				case SettingsText.Y % __SettingsText.Y__
					check = Format.checkFormat(Format.SCALAR, value, SettingsText.getPropSettings(prop));
				case SettingsText.Z % __SettingsText.Z__
					check = Format.checkFormat(Format.SCALAR, value, SettingsText.getPropSettings(prop));
				case SettingsText.TXT % __SettingsText.TXT__
					check = Format.checkFormat(Format.STRING, value, SettingsText.getPropSettings(prop));
				case SettingsText.FONTSIZE % __SettingsText.FONTSIZE__
					check = Format.checkFormat(Format.SIZE, value, SettingsText.getPropSettings(prop));
				case SettingsText.FONTNAME % __SettingsText.FONTNAME__
					check = Format.checkFormat(Format.STRING, value, SettingsText.getPropSettings(prop));
				case SettingsText.FONTCOLOR % __SettingsText.FONTCOLOR__
					check = Format.checkFormat(Format.COLOR, value, SettingsText.getPropSettings(prop));
				case SettingsText.FONTWEIGHT % __SettingsText.FONTWEIGHT__
					check = Format.checkFormat(Format.OPTION, value, SettingsText.getPropSettings(prop));
				case SettingsText.INTERPRETER % __SettingsText.INTERPRETER__
					check = Format.checkFormat(Format.OPTION, value, SettingsText.getPropSettings(prop));
				case SettingsText.HALIGN % __SettingsText.HALIGN__
					check = Format.checkFormat(Format.OPTION, value, SettingsText.getPropSettings(prop));
				case SettingsText.VALIGN % __SettingsText.VALIGN__
					check = Format.checkFormat(Format.OPTION, value, SettingsText.getPropSettings(prop));
				case SettingsText.ROTATION % __SettingsText.ROTATION__
					check = Format.checkFormat(Format.SCALAR, value, SettingsText.getPropSettings(prop));
				case SettingsText.TEMPLATE % __SettingsText.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, SettingsText.getPropSettings(prop));
				otherwise
					if prop <= Settings.getPropNumber()
						check = checkProp@Settings(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsText:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsText:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsText.getPropTag(prop) ' (' SettingsText.getFormatTag(SettingsText.getPropFormat(prop)) ').'] ...
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
				case SettingsText.VISIBLE % __SettingsText.VISIBLE__
					h = st.get('H');
					if check_graphics(h, 'text') && ( ...
					        get(h, 'Visible') ~= st.get('VISIBLE') || ...
					        ~isequal(get(h, 'Position'), [st.get('X') st.get('Y') st.get('Z')]) || ...
					        ~isequal(get(h, 'String'), st.get('TXT')) || ...
					        get(h, 'FontSize') ~= st.get('FONTSIZE') || ...
					        ~isequal(get(h, 'FontName'), st.get('FONTNAME')) || ...
					        ~isequal(get(h, 'Color'), st.get('FONTCOLOR')) || ...
					        ~isequal(get(h, 'FontWeight'), st.get('FONTWEIGHT')) || ...        
					        ~isequal(get(h, 'Interpreter'), st.get('INTERPRETER')) || ...
					        ~isequal(get(h, 'HorizontalAlignment'), st.get('HALIGN')) || ...
					        ~isequal(get(h, 'VerticalAlignment'), st.get('VALIGN')) || ...
					        get(h, 'Rotation') ~= st.get('ROTATION') ...
					        )
					    if st.get('VISIBLE')
					        set(h, ...
					            'Position', [st.get('X') st.get('Y') st.get('Z')], ...
					            'String', st.get('TXT'), ...
					            'FontSize', st.get('FONTSIZE'), ...
					            'FontName', st.get('FONTNAME'), ...
					            'Color', st.get('FONTCOLOR'), ...
					            'FontWeight', st.get('FONTWEIGHT'), ...
					            'Interpreter', st.get('INTERPRETER'), ...
					            'HorizontalAlignment', st.get('HALIGN'), ...
					            'VerticalAlignment', st.get('VALIGN'), ...
					            'Rotation', st.get('ROTATION'), ...
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
