classdef SettingsSurface < Settings
	%SettingsSurface contains the surface settings.
	% It is a subclass of <a href="matlab:help Settings">Settings</a>.
	%
	% A Surface Settings (SettingsSurface) provides the settings for a surface, 
	%  including face color, face alpha, edge color, and edge alpha.
	% The handle can be either a patch or a surface.
	%
	% SettingsSurface methods (constructor):
	%  SettingsSurface - constructor
	%
	% SettingsSurface methods:
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
	% SettingsSurface methods (display):
	%  tostring - string with information about the surface settings
	%  disp - displays information about the surface settings
	%  tree - displays the tree of the surface settings
	%
	% SettingsSurface methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two surface settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the surface settings
	%
	% SettingsSurface methods (save/load, Static):
	%  save - saves BRAPH2 surface settings as b2 file
	%  load - loads a BRAPH2 surface settings from a b2 file
	%
	% SettingsSurface method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the surface settings
	%
	% SettingsSurface method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the surface settings
	%
	% SettingsSurface methods (inspection, Static):
	%  getClass - returns the class of the surface settings
	%  getSubclasses - returns all subclasses of SettingsSurface
	%  getProps - returns the property list of the surface settings
	%  getPropNumber - returns the property number of the surface settings
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
	% SettingsSurface methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsSurface methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsSurface methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsSurface methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsSurface; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsSurface constants</a>.
	%
	%
	% See also patch, surface, SettingsSurfacePP, PanelFig, GUIFig, check_graphics.
	
	properties (Constant) % properties
		EDGECOLOR = Settings.getPropNumber() + 1;
		EDGECOLOR_TAG = 'EDGECOLOR';
		EDGECOLOR_CATEGORY = Category.FIGURE;
		EDGECOLOR_FORMAT = Format.COLOR;
		
		EDGEALPHA = Settings.getPropNumber() + 2;
		EDGEALPHA_TAG = 'EDGEALPHA';
		EDGEALPHA_CATEGORY = Category.FIGURE;
		EDGEALPHA_FORMAT = Format.ALPHA;
		
		FACECOLOR = Settings.getPropNumber() + 3;
		FACECOLOR_TAG = 'FACECOLOR';
		FACECOLOR_CATEGORY = Category.FIGURE;
		FACECOLOR_FORMAT = Format.COLOR;
		
		FACEALPHA = Settings.getPropNumber() + 4;
		FACEALPHA_TAG = 'FACEALPHA';
		FACEALPHA_CATEGORY = Category.FIGURE;
		FACEALPHA_FORMAT = Format.ALPHA;
	end
	methods % constructor
		function st = SettingsSurface(varargin)
			%SettingsSurface() creates a surface settings.
			%
			% SettingsSurface(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsSurface(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the surface settings.
			%
			% CLASS = SettingsSurface.GETCLASS() returns the class 'SettingsSurface'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ST.GETCLASS() returns the class of the surface settings ST.
			%  CLASS = Element.GETCLASS(ST) returns the class of 'ST'.
			%  CLASS = Element.GETCLASS('SettingsSurface') returns 'SettingsSurface'.
			%
			% Note that the Element.GETCLASS(ST) and Element.GETCLASS('SettingsSurface')
			%  are less computationally efficient.
			
			st_class = 'SettingsSurface';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the surface settings.
			%
			% LIST = SettingsSurface.GETSUBCLASSES() returns all subclasses of 'SettingsSurface'.
			%
			% Alternative forms to call this method are:
			%  LIST = ST.GETSUBCLASSES() returns all subclasses of the surface settings ST.
			%  LIST = Element.GETSUBCLASSES(ST) returns all subclasses of 'ST'.
			%  LIST = Element.GETSUBCLASSES('SettingsSurface') returns all subclasses of 'SettingsSurface'.
			%
			% Note that the Element.GETSUBCLASSES(ST) and Element.GETSUBCLASSES('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SettingsSurface', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of surface settings.
			%
			% PROPS = SettingsSurface.GETPROPS() returns the property list of surface settings
			%  as a row vector.
			%
			% PROPS = SettingsSurface.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ST.GETPROPS([CATEGORY]) returns the property list of the surface settings ST.
			%  PROPS = Element.GETPROPS(ST[, CATEGORY]) returns the property list of 'ST'.
			%  PROPS = Element.GETPROPS('SettingsSurface'[, CATEGORY]) returns the property list of 'SettingsSurface'.
			%
			% Note that the Element.GETPROPS(ST) and Element.GETPROPS('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Settings.getProps() ...
						SettingsSurface.EDGECOLOR ...
						SettingsSurface.EDGEALPHA ...
						SettingsSurface.FACECOLOR ...
						SettingsSurface.FACEALPHA ...
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
						SettingsSurface.EDGECOLOR ...
						SettingsSurface.EDGEALPHA ...
						SettingsSurface.FACECOLOR ...
						SettingsSurface.FACEALPHA ...
						];
				case Category.GUI
					prop_list = [ ...
						Settings.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of surface settings.
			%
			% N = SettingsSurface.GETPROPNUMBER() returns the property number of surface settings.
			%
			% N = SettingsSurface.GETPROPNUMBER(CATEGORY) returns the property number of surface settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ST.GETPROPNUMBER([CATEGORY]) returns the property number of the surface settings ST.
			%  N = Element.GETPROPNUMBER(ST) returns the property number of 'ST'.
			%  N = Element.GETPROPNUMBER('SettingsSurface') returns the property number of 'SettingsSurface'.
			%
			% Note that the Element.GETPROPNUMBER(ST) and Element.GETPROPNUMBER('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SettingsSurface.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in surface settings/error.
			%
			% CHECK = SettingsSurface.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSPROP(PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(ST, PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(SettingsSurface, PROP) checks whether PROP exists for SettingsSurface.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsSurface:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSPROP(PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSurface:WrongInput]
			%  Element.EXISTSPROP(ST, PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSurface:WrongInput]
			%  Element.EXISTSPROP(SettingsSurface, PROP) throws error if PROP does NOT exist for SettingsSurface.
			%   Error id: [BRAPH2:SettingsSurface:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ST) and Element.EXISTSPROP('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SettingsSurface.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsSurface:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsSurface:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsSurface.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in surface settings/error.
			%
			% CHECK = SettingsSurface.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSTAG(TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(ST, TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(SettingsSurface, TAG) checks whether TAG exists for SettingsSurface.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsSurface:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSTAG(TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSurface:WrongInput]
			%  Element.EXISTSTAG(ST, TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSurface:WrongInput]
			%  Element.EXISTSTAG(SettingsSurface, TAG) throws error if TAG does NOT exist for SettingsSurface.
			%   Error id: [BRAPH2:SettingsSurface:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ST) and Element.EXISTSTAG('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			settingssurface_tag_list = cellfun(@(x) SettingsSurface.getPropTag(x), num2cell(SettingsSurface.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, settingssurface_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsSurface:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsSurface:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SettingsSurface.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsSurface, POINTER) returns property number of POINTER of SettingsSurface.
			%  PROPERTY = ST.GETPROPPROP(SettingsSurface, POINTER) returns property number of POINTER of SettingsSurface.
			%
			% Note that the Element.GETPROPPROP(ST) and Element.GETPROPPROP('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				settingssurface_tag_list = cellfun(@(x) SettingsSurface.getPropTag(x), num2cell(SettingsSurface.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, settingssurface_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(SettingsSurface, POINTER) returns tag of POINTER of SettingsSurface.
			%  TAG = ST.GETPROPTAG(SettingsSurface, POINTER) returns tag of POINTER of SettingsSurface.
			%
			% Note that the Element.GETPROPTAG(ST) and Element.GETPROPTAG('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SettingsSurface.EDGECOLOR
						tag = SettingsSurface.EDGECOLOR_TAG;
					case SettingsSurface.EDGEALPHA
						tag = SettingsSurface.EDGEALPHA_TAG;
					case SettingsSurface.FACECOLOR
						tag = SettingsSurface.FACECOLOR_TAG;
					case SettingsSurface.FACEALPHA
						tag = SettingsSurface.FACEALPHA_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsSurface, POINTER) returns category of POINTER of SettingsSurface.
			%  CATEGORY = ST.GETPROPCATEGORY(SettingsSurface, POINTER) returns category of POINTER of SettingsSurface.
			%
			% Note that the Element.GETPROPCATEGORY(ST) and Element.GETPROPCATEGORY('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsSurface.getPropProp(pointer);
			
			switch prop
				case SettingsSurface.EDGECOLOR
					prop_category = SettingsSurface.EDGECOLOR_CATEGORY;
				case SettingsSurface.EDGEALPHA
					prop_category = SettingsSurface.EDGEALPHA_CATEGORY;
				case SettingsSurface.FACECOLOR
					prop_category = SettingsSurface.FACECOLOR_CATEGORY;
				case SettingsSurface.FACEALPHA
					prop_category = SettingsSurface.FACEALPHA_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsSurface, POINTER) returns format of POINTER of SettingsSurface.
			%  FORMAT = ST.GETPROPFORMAT(SettingsSurface, POINTER) returns format of POINTER of SettingsSurface.
			%
			% Note that the Element.GETPROPFORMAT(ST) and Element.GETPROPFORMAT('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsSurface.getPropProp(pointer);
			
			switch prop
				case SettingsSurface.EDGECOLOR
					prop_format = SettingsSurface.EDGECOLOR_FORMAT;
				case SettingsSurface.EDGEALPHA
					prop_format = SettingsSurface.EDGEALPHA_FORMAT;
				case SettingsSurface.FACECOLOR
					prop_format = SettingsSurface.FACECOLOR_FORMAT;
				case SettingsSurface.FACEALPHA
					prop_format = SettingsSurface.FACEALPHA_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsSurface, POINTER) returns description of POINTER of SettingsSurface.
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(SettingsSurface, POINTER) returns description of POINTER of SettingsSurface.
			%
			% Note that the Element.GETPROPDESCRIPTION(ST) and Element.GETPROPDESCRIPTION('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsSurface.getPropProp(pointer);
			
			switch prop
				case SettingsSurface.EDGECOLOR
					prop_description = 'EDGECOLOR (figure, color) is the RGB edge color.';
				case SettingsSurface.EDGEALPHA
					prop_description = 'EDGEALPHA (figure, alpha) is the edge transparency.';
				case SettingsSurface.FACECOLOR
					prop_description = 'FACECOLOR (figure, color) is the RGB face color.';
				case SettingsSurface.FACEALPHA
					prop_description = 'FACEALPHA (figure, alpha) is the face transparency.';
				case SettingsSurface.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the surface settings.';
				case SettingsSurface.NAME
					prop_description = 'NAME (constant, string) is the name of the surface settings.';
				case SettingsSurface.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the surface settings.';
				case SettingsSurface.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the surface settings.';
				case SettingsSurface.ID
					prop_description = 'ID (data, string) is a few-letter code for the surface settings.';
				case SettingsSurface.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the surface settings.';
				case SettingsSurface.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the surface settings.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsSurface, POINTER) returns settings of POINTER of SettingsSurface.
			%  SETTINGS = ST.GETPROPSETTINGS(SettingsSurface, POINTER) returns settings of POINTER of SettingsSurface.
			%
			% Note that the Element.GETPROPSETTINGS(ST) and Element.GETPROPSETTINGS('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsSurface.getPropProp(pointer);
			
			switch prop
				case SettingsSurface.EDGECOLOR
					prop_settings = Format.getFormatSettings(Format.COLOR);
				case SettingsSurface.EDGEALPHA
					prop_settings = Format.getFormatSettings(Format.ALPHA);
				case SettingsSurface.FACECOLOR
					prop_settings = Format.getFormatSettings(Format.COLOR);
				case SettingsSurface.FACEALPHA
					prop_settings = Format.getFormatSettings(Format.ALPHA);
				case SettingsSurface.TEMPLATE
					prop_settings = 'SettingsSurface';
				otherwise
					prop_settings = getPropSettings@Settings(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsSurface.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsSurface.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsSurface, POINTER) returns the default value of POINTER of SettingsSurface.
			%  DEFAULT = ST.GETPROPDEFAULT(SettingsSurface, POINTER) returns the default value of POINTER of SettingsSurface.
			%
			% Note that the Element.GETPROPDEFAULT(ST) and Element.GETPROPDEFAULT('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsSurface.getPropProp(pointer);
			
			switch prop
				case SettingsSurface.EDGECOLOR
					prop_default = [0 0 0];
				case SettingsSurface.EDGEALPHA
					prop_default = 0;
				case SettingsSurface.FACECOLOR
					prop_default = [.5 .5 .5];
				case SettingsSurface.FACEALPHA
					prop_default = .5;
				case SettingsSurface.ELCLASS
					prop_default = 'SettingsSurface';
				case SettingsSurface.NAME
					prop_default = 'Surface Settings';
				case SettingsSurface.DESCRIPTION
					prop_default = 'A Surface Settings (SettingsSurface) provides the settings for a surface, including face color, face alpha, edge color, and edge alpha.';
				case SettingsSurface.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, SettingsSurface.getPropSettings(prop));
				case SettingsSurface.ID
					prop_default = 'SettingsSurface ID';
				case SettingsSurface.LABEL
					prop_default = 'SettingsSurface label';
				case SettingsSurface.NOTES
					prop_default = 'SettingsSurface notes';
				otherwise
					prop_default = getPropDefault@Settings(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsSurface.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsSurface.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsSurface, POINTER) returns the conditioned default value of POINTER of SettingsSurface.
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(SettingsSurface, POINTER) returns the conditioned default value of POINTER of SettingsSurface.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ST) and Element.GETPROPDEFAULTCONDITIONED('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsSurface.getPropProp(pointer);
			
			prop_default = SettingsSurface.conditioning(prop, SettingsSurface.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsSurface, PROP, VALUE) checks VALUE format for PROP of SettingsSurface.
			%  CHECK = ST.CHECKPROP(SettingsSurface, PROP, VALUE) checks VALUE format for PROP of SettingsSurface.
			% 
			% ST.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SettingsSurface:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ST.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ST.
			%   Error id: €BRAPH2.STR€:SettingsSurface:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SettingsSurface, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsSurface.
			%   Error id: €BRAPH2.STR€:SettingsSurface:€BRAPH2.WRONG_INPUT€
			%  ST.CHECKPROP(SettingsSurface, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsSurface.
			%   Error id: €BRAPH2.STR€:SettingsSurface:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(ST) and Element.CHECKPROP('SettingsSurface')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsSurface.getPropProp(pointer);
			
			switch prop
				case SettingsSurface.EDGECOLOR % __SettingsSurface.EDGECOLOR__
					check = Format.checkFormat(Format.COLOR, value, SettingsSurface.getPropSettings(prop));
				case SettingsSurface.EDGEALPHA % __SettingsSurface.EDGEALPHA__
					check = Format.checkFormat(Format.ALPHA, value, SettingsSurface.getPropSettings(prop));
				case SettingsSurface.FACECOLOR % __SettingsSurface.FACECOLOR__
					check = Format.checkFormat(Format.COLOR, value, SettingsSurface.getPropSettings(prop));
				case SettingsSurface.FACEALPHA % __SettingsSurface.FACEALPHA__
					check = Format.checkFormat(Format.ALPHA, value, SettingsSurface.getPropSettings(prop));
				case SettingsSurface.TEMPLATE % __SettingsSurface.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, SettingsSurface.getPropSettings(prop));
				otherwise
					if prop <= Settings.getPropNumber()
						check = checkProp@Settings(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsSurface:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsSurface:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsSurface.getPropTag(prop) ' (' SettingsSurface.getFormatTag(SettingsSurface.getPropFormat(prop)) ').'] ...
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
				case SettingsSurface.EDGECOLOR % __SettingsSurface.EDGECOLOR__
					h = st.get('H');
					if check_graphics(h, 'patch') || check_graphics(h, 'surface')
					    set(h, 'EdgeColor', st.get('EDGECOLOR'))
					end
					
				case SettingsSurface.EDGEALPHA % __SettingsSurface.EDGEALPHA__
					h = st.get('H');
					if check_graphics(h, 'patch') || check_graphics(h, 'surface')
					    set(h, 'EdgeAlpha', st.get('EDGEALPHA'))
					end
					
				case SettingsSurface.FACECOLOR % __SettingsSurface.FACECOLOR__
					h = st.get('H');
					if check_graphics(h, 'patch') || check_graphics(h, 'surface')
					    set(h, 'FaceColor', st.get('FACECOLOR'))
					end
					
				case SettingsSurface.FACEALPHA % __SettingsSurface.FACEALPHA__
					h = st.get('H');
					if check_graphics(h, 'patch') || check_graphics(h, 'surface')
					    set(h, 'FaceAlpha', st.get('FACEALPHA'))
					end
					
				otherwise
					if prop <= Settings.getPropNumber()
						postset@Settings(st, prop);
					end
			end
		end
	end
end
