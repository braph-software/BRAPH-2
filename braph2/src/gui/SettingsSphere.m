classdef SettingsSphere < SettingsSurface
	%SettingsSphere contains the sphere settings.
	% It is a subclass of <a href="matlab:help SettingsSurface">SettingsSurface</a>.
	%
	% A Sphere Settings (SettingsSphere) provides the settings for a sphere, 
	%  including visibility, x, y, z, radius, face color and alpha, edge color and alpha.
	% The handle can be either a patch or a surface.
	%
	% SettingsSphere methods (constructor):
	%  SettingsSphere - constructor
	%
	% SettingsSphere methods:
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
	% SettingsSphere methods (display):
	%  tostring - string with information about the sphere settings
	%  disp - displays information about the sphere settings
	%  tree - displays the tree of the sphere settings
	%
	% SettingsSphere methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two sphere settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the sphere settings
	%
	% SettingsSphere methods (save/load, Static):
	%  save - saves BRAPH2 sphere settings as b2 file
	%  load - loads a BRAPH2 sphere settings from a b2 file
	%
	% SettingsSphere method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the sphere settings
	%
	% SettingsSphere method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the sphere settings
	%
	% SettingsSphere methods (inspection, Static):
	%  getClass - returns the class of the sphere settings
	%  getSubclasses - returns all subclasses of SettingsSphere
	%  getProps - returns the property list of the sphere settings
	%  getPropNumber - returns the property number of the sphere settings
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
	% SettingsSphere methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsSphere methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsSphere methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsSphere methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsSphere; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsSphere constants</a>.
	%
	%
	% See also patch, surface, PanelFig, GUIFig, check_graphics.
	
	properties (Constant) % properties
		VISIBLE = SettingsSurface.getPropNumber() + 1;
		VISIBLE_TAG = 'VISIBLE';
		VISIBLE_CATEGORY = Category.FIGURE;
		VISIBLE_FORMAT = Format.LOGICAL;
		
		X = SettingsSurface.getPropNumber() + 2;
		X_TAG = 'X';
		X_CATEGORY = Category.FIGURE;
		X_FORMAT = Format.SCALAR;
		
		Y = SettingsSurface.getPropNumber() + 3;
		Y_TAG = 'Y';
		Y_CATEGORY = Category.FIGURE;
		Y_FORMAT = Format.SCALAR;
		
		Z = SettingsSurface.getPropNumber() + 4;
		Z_TAG = 'Z';
		Z_CATEGORY = Category.FIGURE;
		Z_FORMAT = Format.SCALAR;
		
		SPHERESIZE = SettingsSurface.getPropNumber() + 5;
		SPHERESIZE_TAG = 'SPHERESIZE';
		SPHERESIZE_CATEGORY = Category.FIGURE;
		SPHERESIZE_FORMAT = Format.SIZE;
	end
	methods % constructor
		function st = SettingsSphere(varargin)
			%SettingsSphere() creates a sphere settings.
			%
			% SettingsSphere(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsSphere(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			st = st@SettingsSurface(varargin{:});
		end
	end
	methods (Static) % inspection
		function st_class = getClass()
			%GETCLASS returns the class of the sphere settings.
			%
			% CLASS = SettingsSphere.GETCLASS() returns the class 'SettingsSphere'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ST.GETCLASS() returns the class of the sphere settings ST.
			%  CLASS = Element.GETCLASS(ST) returns the class of 'ST'.
			%  CLASS = Element.GETCLASS('SettingsSphere') returns 'SettingsSphere'.
			%
			% Note that the Element.GETCLASS(ST) and Element.GETCLASS('SettingsSphere')
			%  are less computationally efficient.
			
			st_class = 'SettingsSphere';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the sphere settings.
			%
			% LIST = SettingsSphere.GETSUBCLASSES() returns all subclasses of 'SettingsSphere'.
			%
			% Alternative forms to call this method are:
			%  LIST = ST.GETSUBCLASSES() returns all subclasses of the sphere settings ST.
			%  LIST = Element.GETSUBCLASSES(ST) returns all subclasses of 'ST'.
			%  LIST = Element.GETSUBCLASSES('SettingsSphere') returns all subclasses of 'SettingsSphere'.
			%
			% Note that the Element.GETSUBCLASSES(ST) and Element.GETSUBCLASSES('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SettingsSphere', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of sphere settings.
			%
			% PROPS = SettingsSphere.GETPROPS() returns the property list of sphere settings
			%  as a row vector.
			%
			% PROPS = SettingsSphere.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ST.GETPROPS([CATEGORY]) returns the property list of the sphere settings ST.
			%  PROPS = Element.GETPROPS(ST[, CATEGORY]) returns the property list of 'ST'.
			%  PROPS = Element.GETPROPS('SettingsSphere'[, CATEGORY]) returns the property list of 'SettingsSphere'.
			%
			% Note that the Element.GETPROPS(ST) and Element.GETPROPS('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					SettingsSurface.getProps() ...
						SettingsSphere.VISIBLE ...
						SettingsSphere.X ...
						SettingsSphere.Y ...
						SettingsSphere.Z ...
						SettingsSphere.SPHERESIZE ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						SettingsSurface.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						SettingsSurface.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						SettingsSurface.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						SettingsSurface.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						SettingsSurface.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						SettingsSurface.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						SettingsSurface.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						SettingsSurface.getProps(Category.FIGURE) ...
						SettingsSphere.VISIBLE ...
						SettingsSphere.X ...
						SettingsSphere.Y ...
						SettingsSphere.Z ...
						SettingsSphere.SPHERESIZE ...
						];
				case Category.GUI
					prop_list = [ ...
						SettingsSurface.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of sphere settings.
			%
			% N = SettingsSphere.GETPROPNUMBER() returns the property number of sphere settings.
			%
			% N = SettingsSphere.GETPROPNUMBER(CATEGORY) returns the property number of sphere settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ST.GETPROPNUMBER([CATEGORY]) returns the property number of the sphere settings ST.
			%  N = Element.GETPROPNUMBER(ST) returns the property number of 'ST'.
			%  N = Element.GETPROPNUMBER('SettingsSphere') returns the property number of 'SettingsSphere'.
			%
			% Note that the Element.GETPROPNUMBER(ST) and Element.GETPROPNUMBER('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SettingsSphere.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in sphere settings/error.
			%
			% CHECK = SettingsSphere.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSPROP(PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(ST, PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(SettingsSphere, PROP) checks whether PROP exists for SettingsSphere.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsSphere:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSPROP(PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSphere:WrongInput]
			%  Element.EXISTSPROP(ST, PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSphere:WrongInput]
			%  Element.EXISTSPROP(SettingsSphere, PROP) throws error if PROP does NOT exist for SettingsSphere.
			%   Error id: [BRAPH2:SettingsSphere:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ST) and Element.EXISTSPROP('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SettingsSphere.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsSphere:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsSphere:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsSphere.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in sphere settings/error.
			%
			% CHECK = SettingsSphere.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSTAG(TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(ST, TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(SettingsSphere, TAG) checks whether TAG exists for SettingsSphere.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsSphere:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSTAG(TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSphere:WrongInput]
			%  Element.EXISTSTAG(ST, TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SettingsSphere:WrongInput]
			%  Element.EXISTSTAG(SettingsSphere, TAG) throws error if TAG does NOT exist for SettingsSphere.
			%   Error id: [BRAPH2:SettingsSphere:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ST) and Element.EXISTSTAG('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			settingssphere_tag_list = cellfun(@(x) SettingsSphere.getPropTag(x), num2cell(SettingsSphere.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, settingssphere_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsSphere:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsSphere:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SettingsSphere.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsSphere, POINTER) returns property number of POINTER of SettingsSphere.
			%  PROPERTY = ST.GETPROPPROP(SettingsSphere, POINTER) returns property number of POINTER of SettingsSphere.
			%
			% Note that the Element.GETPROPPROP(ST) and Element.GETPROPPROP('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				settingssphere_tag_list = cellfun(@(x) SettingsSphere.getPropTag(x), num2cell(SettingsSphere.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, settingssphere_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(SettingsSphere, POINTER) returns tag of POINTER of SettingsSphere.
			%  TAG = ST.GETPROPTAG(SettingsSphere, POINTER) returns tag of POINTER of SettingsSphere.
			%
			% Note that the Element.GETPROPTAG(ST) and Element.GETPROPTAG('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SettingsSphere.VISIBLE
						tag = SettingsSphere.VISIBLE_TAG;
					case SettingsSphere.X
						tag = SettingsSphere.X_TAG;
					case SettingsSphere.Y
						tag = SettingsSphere.Y_TAG;
					case SettingsSphere.Z
						tag = SettingsSphere.Z_TAG;
					case SettingsSphere.SPHERESIZE
						tag = SettingsSphere.SPHERESIZE_TAG;
					otherwise
						tag = getPropTag@SettingsSurface(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsSphere, POINTER) returns category of POINTER of SettingsSphere.
			%  CATEGORY = ST.GETPROPCATEGORY(SettingsSphere, POINTER) returns category of POINTER of SettingsSphere.
			%
			% Note that the Element.GETPROPCATEGORY(ST) and Element.GETPROPCATEGORY('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsSphere.getPropProp(pointer);
			
			switch prop
				case SettingsSphere.VISIBLE
					prop_category = SettingsSphere.VISIBLE_CATEGORY;
				case SettingsSphere.X
					prop_category = SettingsSphere.X_CATEGORY;
				case SettingsSphere.Y
					prop_category = SettingsSphere.Y_CATEGORY;
				case SettingsSphere.Z
					prop_category = SettingsSphere.Z_CATEGORY;
				case SettingsSphere.SPHERESIZE
					prop_category = SettingsSphere.SPHERESIZE_CATEGORY;
				otherwise
					prop_category = getPropCategory@SettingsSurface(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsSphere, POINTER) returns format of POINTER of SettingsSphere.
			%  FORMAT = ST.GETPROPFORMAT(SettingsSphere, POINTER) returns format of POINTER of SettingsSphere.
			%
			% Note that the Element.GETPROPFORMAT(ST) and Element.GETPROPFORMAT('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsSphere.getPropProp(pointer);
			
			switch prop
				case SettingsSphere.VISIBLE
					prop_format = SettingsSphere.VISIBLE_FORMAT;
				case SettingsSphere.X
					prop_format = SettingsSphere.X_FORMAT;
				case SettingsSphere.Y
					prop_format = SettingsSphere.Y_FORMAT;
				case SettingsSphere.Z
					prop_format = SettingsSphere.Z_FORMAT;
				case SettingsSphere.SPHERESIZE
					prop_format = SettingsSphere.SPHERESIZE_FORMAT;
				otherwise
					prop_format = getPropFormat@SettingsSurface(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsSphere, POINTER) returns description of POINTER of SettingsSphere.
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(SettingsSphere, POINTER) returns description of POINTER of SettingsSphere.
			%
			% Note that the Element.GETPROPDESCRIPTION(ST) and Element.GETPROPDESCRIPTION('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsSphere.getPropProp(pointer);
			
			switch prop
				case SettingsSphere.VISIBLE
					prop_description = 'VISIBLE (figure, logical) determines whether the sphere is visible.';
				case SettingsSphere.X
					prop_description = 'X (figure, scalar) is the x-coordinate.';
				case SettingsSphere.Y
					prop_description = 'Y (figure, scalar) is the y-coordinate.';
				case SettingsSphere.Z
					prop_description = 'Z (figure, scalar) is the z-coordinate.';
				case SettingsSphere.SPHERESIZE
					prop_description = 'SPHERESIZE (figure, size) is the sphere size.';
				case SettingsSphere.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the sphere settings.';
				case SettingsSphere.NAME
					prop_description = 'NAME (constant, string) is the name of the sphere settings.';
				case SettingsSphere.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the sphere settings.';
				case SettingsSphere.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the sphere settings.';
				case SettingsSphere.ID
					prop_description = 'ID (data, string) is a few-letter code for the sphere settings.';
				case SettingsSphere.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the sphere settings.';
				case SettingsSphere.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the sphere settings.';
				otherwise
					prop_description = getPropDescription@SettingsSurface(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsSphere, POINTER) returns settings of POINTER of SettingsSphere.
			%  SETTINGS = ST.GETPROPSETTINGS(SettingsSphere, POINTER) returns settings of POINTER of SettingsSphere.
			%
			% Note that the Element.GETPROPSETTINGS(ST) and Element.GETPROPSETTINGS('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsSphere.getPropProp(pointer);
			
			switch prop
				case SettingsSphere.VISIBLE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SettingsSphere.X
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case SettingsSphere.Y
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case SettingsSphere.Z
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case SettingsSphere.SPHERESIZE
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case SettingsSphere.TEMPLATE
					prop_settings = 'SettingsSphere';
				otherwise
					prop_settings = getPropSettings@SettingsSurface(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsSphere.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsSphere.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsSphere, POINTER) returns the default value of POINTER of SettingsSphere.
			%  DEFAULT = ST.GETPROPDEFAULT(SettingsSphere, POINTER) returns the default value of POINTER of SettingsSphere.
			%
			% Note that the Element.GETPROPDEFAULT(ST) and Element.GETPROPDEFAULT('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsSphere.getPropProp(pointer);
			
			switch prop
				case SettingsSphere.VISIBLE
					prop_default = Format.getFormatDefault(Format.LOGICAL, SettingsSphere.getPropSettings(prop));
				case SettingsSphere.X
					prop_default = Format.getFormatDefault(Format.SCALAR, SettingsSphere.getPropSettings(prop));
				case SettingsSphere.Y
					prop_default = Format.getFormatDefault(Format.SCALAR, SettingsSphere.getPropSettings(prop));
				case SettingsSphere.Z
					prop_default = Format.getFormatDefault(Format.SCALAR, SettingsSphere.getPropSettings(prop));
				case SettingsSphere.SPHERESIZE
					prop_default = 5;
				case SettingsSphere.ELCLASS
					prop_default = 'SettingsSphere';
				case SettingsSphere.NAME
					prop_default = 'Sphere Settings';
				case SettingsSphere.DESCRIPTION
					prop_default = 'A Sphere Settings (SettingsSphere) provides the settings for a sphere, including visibility, x, y, z, radius, face color and alpha, edge color and alpha.';
				case SettingsSphere.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, SettingsSphere.getPropSettings(prop));
				case SettingsSphere.ID
					prop_default = 'SettingsSphere ID';
				case SettingsSphere.LABEL
					prop_default = 'SettingsSphere label';
				case SettingsSphere.NOTES
					prop_default = 'SettingsSphere notes';
				otherwise
					prop_default = getPropDefault@SettingsSurface(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsSphere.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsSphere.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsSphere, POINTER) returns the conditioned default value of POINTER of SettingsSphere.
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(SettingsSphere, POINTER) returns the conditioned default value of POINTER of SettingsSphere.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ST) and Element.GETPROPDEFAULTCONDITIONED('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsSphere.getPropProp(pointer);
			
			prop_default = SettingsSphere.conditioning(prop, SettingsSphere.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsSphere, PROP, VALUE) checks VALUE format for PROP of SettingsSphere.
			%  CHECK = ST.CHECKPROP(SettingsSphere, PROP, VALUE) checks VALUE format for PROP of SettingsSphere.
			% 
			% ST.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SettingsSphere:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ST.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ST.
			%   Error id: €BRAPH2.STR€:SettingsSphere:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SettingsSphere, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsSphere.
			%   Error id: €BRAPH2.STR€:SettingsSphere:€BRAPH2.WRONG_INPUT€
			%  ST.CHECKPROP(SettingsSphere, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsSphere.
			%   Error id: €BRAPH2.STR€:SettingsSphere:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(ST) and Element.CHECKPROP('SettingsSphere')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsSphere.getPropProp(pointer);
			
			switch prop
				case SettingsSphere.VISIBLE % __SettingsSphere.VISIBLE__
					check = Format.checkFormat(Format.LOGICAL, value, SettingsSphere.getPropSettings(prop));
				case SettingsSphere.X % __SettingsSphere.X__
					check = Format.checkFormat(Format.SCALAR, value, SettingsSphere.getPropSettings(prop));
				case SettingsSphere.Y % __SettingsSphere.Y__
					check = Format.checkFormat(Format.SCALAR, value, SettingsSphere.getPropSettings(prop));
				case SettingsSphere.Z % __SettingsSphere.Z__
					check = Format.checkFormat(Format.SCALAR, value, SettingsSphere.getPropSettings(prop));
				case SettingsSphere.SPHERESIZE % __SettingsSphere.SPHERESIZE__
					check = Format.checkFormat(Format.SIZE, value, SettingsSphere.getPropSettings(prop));
				case SettingsSphere.TEMPLATE % __SettingsSphere.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, SettingsSphere.getPropSettings(prop));
				otherwise
					if prop <= SettingsSurface.getPropNumber()
						check = checkProp@SettingsSurface(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsSphere:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsSphere:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsSphere.getPropTag(prop) ' (' SettingsSphere.getFormatTag(SettingsSphere.getPropFormat(prop)) ').'] ...
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
				case SettingsSphere.VISIBLE % __SettingsSphere.VISIBLE__
					h = st.get('H');
					if (check_graphics(h, 'patch') || check_graphics(h, 'surface')) && ( ...
					        get(h, 'Visible') ~= st.get('VISIBLE') || ...
					        ~isequal(get(h, 'UserData'), [st.get('X') st.get('Y') st.get('Z') st.get('SPHERESIZE')]) ...
					        )
					    if st.get('VISIBLE')
					        [sx, sy, sz] = sphere();
					        set(h, ...
					            'XData', st.get('X') + st.get('SPHERESIZE') * sx, ...
					            'YData', st.get('Y') + st.get('SPHERESIZE') * sy, ...
					            'ZData', st.get('Z') + st.get('SPHERESIZE') * sz, ...
					            'UserData', [st.get('X') st.get('Y') st.get('Z') st.get('SPHERESIZE')], ...
					            'Visible', true ...
					            )
					    else
					        set(h, 'Visible', false)
					    end
					end
					
				otherwise
					if prop <= SettingsSurface.getPropNumber()
						postprocessing@SettingsSurface(st, prop);
					end
			end
		end
	end
end
