classdef SettingsAmbientPP < SettingsPP
	%SettingsAmbientPP is the panel with ambient settings.
	% It is a subclass of <a href="matlab:help SettingsPP">SettingsPP</a>.
	%
	% A Prop Panel for Ambient Settings (SettingsAmbientPP) plots the panel 
	%  for ambient settings, including drop-down lists for lighting, material, 
	%  camlight, shading, and colormap.
	% It works for all categories.
	%
	% SettingsAmbientPP methods (constructor):
	%  SettingsAmbientPP - constructor
	%
	% SettingsAmbientPP methods:
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
	% SettingsAmbientPP methods (display):
	%  tostring - string with information about the prop panel for ambient settings
	%  disp - displays information about the prop panel for ambient settings
	%  tree - displays the tree of the prop panel for ambient settings
	%
	% SettingsAmbientPP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two prop panel for ambient settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the prop panel for ambient settings
	%
	% SettingsAmbientPP methods (save/load, Static):
	%  save - saves BRAPH2 prop panel for ambient settings as b2 file
	%  load - loads a BRAPH2 prop panel for ambient settings from a b2 file
	%
	% SettingsAmbientPP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the prop panel for ambient settings
	%
	% SettingsAmbientPP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the prop panel for ambient settings
	%
	% SettingsAmbientPP methods (inspection, Static):
	%  getClass - returns the class of the prop panel for ambient settings
	%  getSubclasses - returns all subclasses of SettingsAmbientPP
	%  getProps - returns the property list of the prop panel for ambient settings
	%  getPropNumber - returns the property number of the prop panel for ambient settings
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
	% SettingsAmbientPP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsAmbientPP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsAmbientPP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsAmbientPP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsAmbientPP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsAmbientPP constants</a>.
	%
	%
	% See also SettingsAmbient, uidropdown.
	
	properties (Constant) % properties
		ENABLE = SettingsPP.getPropNumber() + 1;
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = Category.GUI;
		ENABLE_FORMAT = Format.LOGICAL;
		
		LABEL_LIGHTING = SettingsPP.getPropNumber() + 2;
		LABEL_LIGHTING_TAG = 'LABEL_LIGHTING';
		LABEL_LIGHTING_CATEGORY = Category.EVANESCENT;
		LABEL_LIGHTING_FORMAT = Format.HANDLE;
		
		DROPDOWN_LIGHTING = SettingsPP.getPropNumber() + 3;
		DROPDOWN_LIGHTING_TAG = 'DROPDOWN_LIGHTING';
		DROPDOWN_LIGHTING_CATEGORY = Category.EVANESCENT;
		DROPDOWN_LIGHTING_FORMAT = Format.HANDLE;
		
		LABEL_MATERIAL = SettingsPP.getPropNumber() + 4;
		LABEL_MATERIAL_TAG = 'LABEL_MATERIAL';
		LABEL_MATERIAL_CATEGORY = Category.EVANESCENT;
		LABEL_MATERIAL_FORMAT = Format.HANDLE;
		
		DROPDOWN_MATERIAL = SettingsPP.getPropNumber() + 5;
		DROPDOWN_MATERIAL_TAG = 'DROPDOWN_MATERIAL';
		DROPDOWN_MATERIAL_CATEGORY = Category.EVANESCENT;
		DROPDOWN_MATERIAL_FORMAT = Format.HANDLE;
		
		LABEL_CAMLIGHT = SettingsPP.getPropNumber() + 6;
		LABEL_CAMLIGHT_TAG = 'LABEL_CAMLIGHT';
		LABEL_CAMLIGHT_CATEGORY = Category.EVANESCENT;
		LABEL_CAMLIGHT_FORMAT = Format.HANDLE;
		
		DROPDOWN_CAMLIGHT = SettingsPP.getPropNumber() + 7;
		DROPDOWN_CAMLIGHT_TAG = 'DROPDOWN_CAMLIGHT';
		DROPDOWN_CAMLIGHT_CATEGORY = Category.EVANESCENT;
		DROPDOWN_CAMLIGHT_FORMAT = Format.HANDLE;
		
		LABEL_SHADING = SettingsPP.getPropNumber() + 8;
		LABEL_SHADING_TAG = 'LABEL_SHADING';
		LABEL_SHADING_CATEGORY = Category.EVANESCENT;
		LABEL_SHADING_FORMAT = Format.HANDLE;
		
		DROPDOWN_SHADING = SettingsPP.getPropNumber() + 9;
		DROPDOWN_SHADING_TAG = 'DROPDOWN_SHADING';
		DROPDOWN_SHADING_CATEGORY = Category.EVANESCENT;
		DROPDOWN_SHADING_FORMAT = Format.HANDLE;
		
		LABEL_COLORMAP = SettingsPP.getPropNumber() + 10;
		LABEL_COLORMAP_TAG = 'LABEL_COLORMAP';
		LABEL_COLORMAP_CATEGORY = Category.EVANESCENT;
		LABEL_COLORMAP_FORMAT = Format.HANDLE;
		
		DROPDOWN_COLORMAP = SettingsPP.getPropNumber() + 11;
		DROPDOWN_COLORMAP_TAG = 'DROPDOWN_COLORMAP';
		DROPDOWN_COLORMAP_CATEGORY = Category.EVANESCENT;
		DROPDOWN_COLORMAP_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = SettingsAmbientPP(varargin)
			%SettingsAmbientPP() creates a prop panel for ambient settings.
			%
			% SettingsAmbientPP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsAmbientPP(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the prop panel for ambient settings.
			%
			% CLASS = SettingsAmbientPP.GETCLASS() returns the class 'SettingsAmbientPP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the prop panel for ambient settings PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('SettingsAmbientPP') returns 'SettingsAmbientPP'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('SettingsAmbientPP')
			%  are less computationally efficient.
			
			pr_class = 'SettingsAmbientPP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the prop panel for ambient settings.
			%
			% LIST = SettingsAmbientPP.GETSUBCLASSES() returns all subclasses of 'SettingsAmbientPP'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the prop panel for ambient settings PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('SettingsAmbientPP') returns all subclasses of 'SettingsAmbientPP'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SettingsAmbientPP', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of prop panel for ambient settings.
			%
			% PROPS = SettingsAmbientPP.GETPROPS() returns the property list of prop panel for ambient settings
			%  as a row vector.
			%
			% PROPS = SettingsAmbientPP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the prop panel for ambient settings PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('SettingsAmbientPP'[, CATEGORY]) returns the property list of 'SettingsAmbientPP'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					SettingsPP.getProps() ...
						SettingsAmbientPP.ENABLE ...
						SettingsAmbientPP.LABEL_LIGHTING ...
						SettingsAmbientPP.DROPDOWN_LIGHTING ...
						SettingsAmbientPP.LABEL_MATERIAL ...
						SettingsAmbientPP.DROPDOWN_MATERIAL ...
						SettingsAmbientPP.LABEL_CAMLIGHT ...
						SettingsAmbientPP.DROPDOWN_CAMLIGHT ...
						SettingsAmbientPP.LABEL_SHADING ...
						SettingsAmbientPP.DROPDOWN_SHADING ...
						SettingsAmbientPP.LABEL_COLORMAP ...
						SettingsAmbientPP.DROPDOWN_COLORMAP ...
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
						SettingsAmbientPP.LABEL_LIGHTING ...
						SettingsAmbientPP.DROPDOWN_LIGHTING ...
						SettingsAmbientPP.LABEL_MATERIAL ...
						SettingsAmbientPP.DROPDOWN_MATERIAL ...
						SettingsAmbientPP.LABEL_CAMLIGHT ...
						SettingsAmbientPP.DROPDOWN_CAMLIGHT ...
						SettingsAmbientPP.LABEL_SHADING ...
						SettingsAmbientPP.DROPDOWN_SHADING ...
						SettingsAmbientPP.LABEL_COLORMAP ...
						SettingsAmbientPP.DROPDOWN_COLORMAP ...
						];
				case Category.FIGURE
					prop_list = [ ...
						SettingsPP.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						SettingsPP.getProps(Category.GUI) ...
						SettingsAmbientPP.ENABLE ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of prop panel for ambient settings.
			%
			% N = SettingsAmbientPP.GETPROPNUMBER() returns the property number of prop panel for ambient settings.
			%
			% N = SettingsAmbientPP.GETPROPNUMBER(CATEGORY) returns the property number of prop panel for ambient settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the prop panel for ambient settings PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('SettingsAmbientPP') returns the property number of 'SettingsAmbientPP'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SettingsAmbientPP.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in prop panel for ambient settings/error.
			%
			% CHECK = SettingsAmbientPP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(SettingsAmbientPP, PROP) checks whether PROP exists for SettingsAmbientPP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsAmbientPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAmbientPP:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAmbientPP:WrongInput]
			%  Element.EXISTSPROP(SettingsAmbientPP, PROP) throws error if PROP does NOT exist for SettingsAmbientPP.
			%   Error id: [BRAPH2:SettingsAmbientPP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SettingsAmbientPP.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsAmbientPP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsAmbientPP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsAmbientPP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in prop panel for ambient settings/error.
			%
			% CHECK = SettingsAmbientPP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(SettingsAmbientPP, TAG) checks whether TAG exists for SettingsAmbientPP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsAmbientPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAmbientPP:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAmbientPP:WrongInput]
			%  Element.EXISTSTAG(SettingsAmbientPP, TAG) throws error if TAG does NOT exist for SettingsAmbientPP.
			%   Error id: [BRAPH2:SettingsAmbientPP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			settingsambientpp_tag_list = cellfun(@(x) SettingsAmbientPP.getPropTag(x), num2cell(SettingsAmbientPP.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, settingsambientpp_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsAmbientPP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsAmbientPP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SettingsAmbientPP.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsAmbientPP, POINTER) returns property number of POINTER of SettingsAmbientPP.
			%  PROPERTY = PR.GETPROPPROP(SettingsAmbientPP, POINTER) returns property number of POINTER of SettingsAmbientPP.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				settingsambientpp_tag_list = cellfun(@(x) SettingsAmbientPP.getPropTag(x), num2cell(SettingsAmbientPP.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, settingsambientpp_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(SettingsAmbientPP, POINTER) returns tag of POINTER of SettingsAmbientPP.
			%  TAG = PR.GETPROPTAG(SettingsAmbientPP, POINTER) returns tag of POINTER of SettingsAmbientPP.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SettingsAmbientPP.ENABLE
						tag = SettingsAmbientPP.ENABLE_TAG;
					case SettingsAmbientPP.LABEL_LIGHTING
						tag = SettingsAmbientPP.LABEL_LIGHTING_TAG;
					case SettingsAmbientPP.DROPDOWN_LIGHTING
						tag = SettingsAmbientPP.DROPDOWN_LIGHTING_TAG;
					case SettingsAmbientPP.LABEL_MATERIAL
						tag = SettingsAmbientPP.LABEL_MATERIAL_TAG;
					case SettingsAmbientPP.DROPDOWN_MATERIAL
						tag = SettingsAmbientPP.DROPDOWN_MATERIAL_TAG;
					case SettingsAmbientPP.LABEL_CAMLIGHT
						tag = SettingsAmbientPP.LABEL_CAMLIGHT_TAG;
					case SettingsAmbientPP.DROPDOWN_CAMLIGHT
						tag = SettingsAmbientPP.DROPDOWN_CAMLIGHT_TAG;
					case SettingsAmbientPP.LABEL_SHADING
						tag = SettingsAmbientPP.LABEL_SHADING_TAG;
					case SettingsAmbientPP.DROPDOWN_SHADING
						tag = SettingsAmbientPP.DROPDOWN_SHADING_TAG;
					case SettingsAmbientPP.LABEL_COLORMAP
						tag = SettingsAmbientPP.LABEL_COLORMAP_TAG;
					case SettingsAmbientPP.DROPDOWN_COLORMAP
						tag = SettingsAmbientPP.DROPDOWN_COLORMAP_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsAmbientPP, POINTER) returns category of POINTER of SettingsAmbientPP.
			%  CATEGORY = PR.GETPROPCATEGORY(SettingsAmbientPP, POINTER) returns category of POINTER of SettingsAmbientPP.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsAmbientPP.getPropProp(pointer);
			
			switch prop
				case SettingsAmbientPP.ENABLE
					prop_category = SettingsAmbientPP.ENABLE_CATEGORY;
				case SettingsAmbientPP.LABEL_LIGHTING
					prop_category = SettingsAmbientPP.LABEL_LIGHTING_CATEGORY;
				case SettingsAmbientPP.DROPDOWN_LIGHTING
					prop_category = SettingsAmbientPP.DROPDOWN_LIGHTING_CATEGORY;
				case SettingsAmbientPP.LABEL_MATERIAL
					prop_category = SettingsAmbientPP.LABEL_MATERIAL_CATEGORY;
				case SettingsAmbientPP.DROPDOWN_MATERIAL
					prop_category = SettingsAmbientPP.DROPDOWN_MATERIAL_CATEGORY;
				case SettingsAmbientPP.LABEL_CAMLIGHT
					prop_category = SettingsAmbientPP.LABEL_CAMLIGHT_CATEGORY;
				case SettingsAmbientPP.DROPDOWN_CAMLIGHT
					prop_category = SettingsAmbientPP.DROPDOWN_CAMLIGHT_CATEGORY;
				case SettingsAmbientPP.LABEL_SHADING
					prop_category = SettingsAmbientPP.LABEL_SHADING_CATEGORY;
				case SettingsAmbientPP.DROPDOWN_SHADING
					prop_category = SettingsAmbientPP.DROPDOWN_SHADING_CATEGORY;
				case SettingsAmbientPP.LABEL_COLORMAP
					prop_category = SettingsAmbientPP.LABEL_COLORMAP_CATEGORY;
				case SettingsAmbientPP.DROPDOWN_COLORMAP
					prop_category = SettingsAmbientPP.DROPDOWN_COLORMAP_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsAmbientPP, POINTER) returns format of POINTER of SettingsAmbientPP.
			%  FORMAT = PR.GETPROPFORMAT(SettingsAmbientPP, POINTER) returns format of POINTER of SettingsAmbientPP.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsAmbientPP.getPropProp(pointer);
			
			switch prop
				case SettingsAmbientPP.ENABLE
					prop_format = SettingsAmbientPP.ENABLE_FORMAT;
				case SettingsAmbientPP.LABEL_LIGHTING
					prop_format = SettingsAmbientPP.LABEL_LIGHTING_FORMAT;
				case SettingsAmbientPP.DROPDOWN_LIGHTING
					prop_format = SettingsAmbientPP.DROPDOWN_LIGHTING_FORMAT;
				case SettingsAmbientPP.LABEL_MATERIAL
					prop_format = SettingsAmbientPP.LABEL_MATERIAL_FORMAT;
				case SettingsAmbientPP.DROPDOWN_MATERIAL
					prop_format = SettingsAmbientPP.DROPDOWN_MATERIAL_FORMAT;
				case SettingsAmbientPP.LABEL_CAMLIGHT
					prop_format = SettingsAmbientPP.LABEL_CAMLIGHT_FORMAT;
				case SettingsAmbientPP.DROPDOWN_CAMLIGHT
					prop_format = SettingsAmbientPP.DROPDOWN_CAMLIGHT_FORMAT;
				case SettingsAmbientPP.LABEL_SHADING
					prop_format = SettingsAmbientPP.LABEL_SHADING_FORMAT;
				case SettingsAmbientPP.DROPDOWN_SHADING
					prop_format = SettingsAmbientPP.DROPDOWN_SHADING_FORMAT;
				case SettingsAmbientPP.LABEL_COLORMAP
					prop_format = SettingsAmbientPP.LABEL_COLORMAP_FORMAT;
				case SettingsAmbientPP.DROPDOWN_COLORMAP
					prop_format = SettingsAmbientPP.DROPDOWN_COLORMAP_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsAmbientPP, POINTER) returns description of POINTER of SettingsAmbientPP.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(SettingsAmbientPP, POINTER) returns description of POINTER of SettingsAmbientPP.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsAmbientPP.getPropProp(pointer);
			
			switch prop
				case SettingsAmbientPP.ENABLE
					prop_description = 'ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.';
				case SettingsAmbientPP.LABEL_LIGHTING
					prop_description = 'LABEL_LIGHTING (evanescent, handle) is the label of the lighting dropdown menu.';
				case SettingsAmbientPP.DROPDOWN_LIGHTING
					prop_description = 'DROPDOWN_LIGHTING (evanescent, handle) is the lighting dropdown menu.';
				case SettingsAmbientPP.LABEL_MATERIAL
					prop_description = 'LABEL_MATERIAL (evanescent, handle) is the label of the of the material dropdown menu.';
				case SettingsAmbientPP.DROPDOWN_MATERIAL
					prop_description = 'DROPDOWN_MATERIAL (evanescent, handle) is the material dropdown menu.';
				case SettingsAmbientPP.LABEL_CAMLIGHT
					prop_description = 'LABEL_CAMLIGHT (evanescent, handle) is the label of the camlight dropdown menu.';
				case SettingsAmbientPP.DROPDOWN_CAMLIGHT
					prop_description = 'DROPDOWN_CAMLIGHT (evanescent, handle) is the camlight dropdown menu.';
				case SettingsAmbientPP.LABEL_SHADING
					prop_description = 'LABEL_SHADING (evanescent, handle) is the label of the shading dropdown menu.';
				case SettingsAmbientPP.DROPDOWN_SHADING
					prop_description = 'DROPDOWN_SHADING (evanescent, handle) is the shading dropdown menu.';
				case SettingsAmbientPP.LABEL_COLORMAP
					prop_description = 'LABEL_COLORMAP (evanescent, handle) is the label of the colormap dropdown menu.';
				case SettingsAmbientPP.DROPDOWN_COLORMAP
					prop_description = 'DROPDOWN_COLORMAP (evanescent, handle) is the colormap dropdown menu.';
				case SettingsAmbientPP.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the concrete element.';
				case SettingsAmbientPP.NAME
					prop_description = 'NAME (constant, string) is the name of the prop panel for ambient settings.';
				case SettingsAmbientPP.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the prop panel for ambient settings.';
				case SettingsAmbientPP.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the prop panel for ambient settings.';
				case SettingsAmbientPP.ID
					prop_description = 'ID (data, string) is a few-letter code for the prop panel for ambient settings.';
				case SettingsAmbientPP.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the prop panel for ambient settings.';
				case SettingsAmbientPP.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the prop panel for ambient settings.';
				case SettingsAmbientPP.EL
					prop_description = 'EL (data, item) is the element.';
				case SettingsAmbientPP.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case SettingsAmbientPP.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the settings position panel.';
				case SettingsAmbientPP.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case SettingsAmbientPP.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.';
				case SettingsAmbientPP.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case SettingsAmbientPP.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsAmbientPP, POINTER) returns settings of POINTER of SettingsAmbientPP.
			%  SETTINGS = PR.GETPROPSETTINGS(SettingsAmbientPP, POINTER) returns settings of POINTER of SettingsAmbientPP.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsAmbientPP.getPropProp(pointer);
			
			switch prop
				case SettingsAmbientPP.ENABLE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SettingsAmbientPP.LABEL_LIGHTING
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAmbientPP.DROPDOWN_LIGHTING
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAmbientPP.LABEL_MATERIAL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAmbientPP.DROPDOWN_MATERIAL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAmbientPP.LABEL_CAMLIGHT
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAmbientPP.DROPDOWN_CAMLIGHT
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAmbientPP.LABEL_SHADING
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAmbientPP.DROPDOWN_SHADING
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAmbientPP.LABEL_COLORMAP
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAmbientPP.DROPDOWN_COLORMAP
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAmbientPP.TEMPLATE
					prop_settings = 'SettingsAmbientPP';
				otherwise
					prop_settings = getPropSettings@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsAmbientPP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsAmbientPP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsAmbientPP, POINTER) returns the default value of POINTER of SettingsAmbientPP.
			%  DEFAULT = PR.GETPROPDEFAULT(SettingsAmbientPP, POINTER) returns the default value of POINTER of SettingsAmbientPP.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsAmbientPP.getPropProp(pointer);
			
			switch prop
				case SettingsAmbientPP.ENABLE
					prop_default = true;
				case SettingsAmbientPP.LABEL_LIGHTING
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.DROPDOWN_LIGHTING
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.LABEL_MATERIAL
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.DROPDOWN_MATERIAL
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.LABEL_CAMLIGHT
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.DROPDOWN_CAMLIGHT
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.LABEL_SHADING
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.DROPDOWN_SHADING
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.LABEL_COLORMAP
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.DROPDOWN_COLORMAP
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.ELCLASS
					prop_default = 'SettingsAmbientPP';
				case SettingsAmbientPP.NAME
					prop_default = 'Prop Panel for Ambient Settings';
				case SettingsAmbientPP.DESCRIPTION
					prop_default = 'A Prop Panel for Ambient Settings (SettingsAmbientPP) plots the panel for ambient settings, including drop-down lists for lighting, material, camlight, shading, and colormap. It works for all categories.';
				case SettingsAmbientPP.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.ID
					prop_default = 'SettingsAmbientPP ID';
				case SettingsAmbientPP.LABEL
					prop_default = 'SettingsAmbientPP label';
				case SettingsAmbientPP.NOTES
					prop_default = 'SettingsAmbientPP notes';
				case SettingsAmbientPP.EL
					prop_default = BrainSurfacePF();
				case SettingsAmbientPP.PROP
					prop_default = BrainSurfacePF.ST_AMBIENT;
				case SettingsAmbientPP.HEIGHT
					prop_default = s(12.5);
				otherwise
					prop_default = getPropDefault@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsAmbientPP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsAmbientPP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsAmbientPP, POINTER) returns the conditioned default value of POINTER of SettingsAmbientPP.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(SettingsAmbientPP, POINTER) returns the conditioned default value of POINTER of SettingsAmbientPP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsAmbientPP.getPropProp(pointer);
			
			prop_default = SettingsAmbientPP.conditioning(prop, SettingsAmbientPP.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsAmbientPP, PROP, VALUE) checks VALUE format for PROP of SettingsAmbientPP.
			%  CHECK = PR.CHECKPROP(SettingsAmbientPP, PROP, VALUE) checks VALUE format for PROP of SettingsAmbientPP.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SettingsAmbientPP:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:SettingsAmbientPP:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SettingsAmbientPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsAmbientPP.
			%   Error id: €BRAPH2.STR€:SettingsAmbientPP:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(SettingsAmbientPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsAmbientPP.
			%   Error id: €BRAPH2.STR€:SettingsAmbientPP:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('SettingsAmbientPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsAmbientPP.getPropProp(pointer);
			
			switch prop
				case SettingsAmbientPP.ENABLE % __SettingsAmbientPP.ENABLE__
					check = Format.checkFormat(Format.LOGICAL, value, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.LABEL_LIGHTING % __SettingsAmbientPP.LABEL_LIGHTING__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.DROPDOWN_LIGHTING % __SettingsAmbientPP.DROPDOWN_LIGHTING__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.LABEL_MATERIAL % __SettingsAmbientPP.LABEL_MATERIAL__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.DROPDOWN_MATERIAL % __SettingsAmbientPP.DROPDOWN_MATERIAL__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.LABEL_CAMLIGHT % __SettingsAmbientPP.LABEL_CAMLIGHT__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.DROPDOWN_CAMLIGHT % __SettingsAmbientPP.DROPDOWN_CAMLIGHT__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.LABEL_SHADING % __SettingsAmbientPP.LABEL_SHADING__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.DROPDOWN_SHADING % __SettingsAmbientPP.DROPDOWN_SHADING__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.LABEL_COLORMAP % __SettingsAmbientPP.LABEL_COLORMAP__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.DROPDOWN_COLORMAP % __SettingsAmbientPP.DROPDOWN_COLORMAP__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAmbientPP.getPropSettings(prop));
				case SettingsAmbientPP.TEMPLATE % __SettingsAmbientPP.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, SettingsAmbientPP.getPropSettings(prop));
				otherwise
					if prop <= SettingsPP.getPropNumber()
						check = checkProp@SettingsPP(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsAmbientPP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsAmbientPP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsAmbientPP.getPropTag(prop) ' (' SettingsAmbientPP.getFormatTag(SettingsAmbientPP.getPropFormat(prop)) ').'] ...
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
				case SettingsAmbientPP.LABEL_LIGHTING % __SettingsAmbientPP.LABEL_LIGHTING__
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_lighting =  uilabel( ...
					    'Parent', pr.memorize('H'), ...
						'Tag', 'LABEL_LIGHTING', ...
						'Text', 'lighting', ...
						'Interpreter', 'html', ...
						'FontSize', BRAPH2.FONTSIZE, ...
						'HorizontalAlignment', 'right', ...
						'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LIGHTING')) ' ' el.get(prop).getPropDescription('LIGHTING')], ...
						'BackgroundColor', pr.get('BKGCOLOR') ...
						);
					value = label_lighting;
					
				case SettingsAmbientPP.DROPDOWN_LIGHTING % __SettingsAmbientPP.DROPDOWN_LIGHTING__
					el = pr.get('EL');
					prop = pr.get('PROP');
					dropdown_lighting = uidropdown( ...
					    'Parent', pr.memorize('H'), ...
						'Tag', 'DROPDOWN_LIGHTING', ...
						'Items', el.get(prop).getPropSettings('LIGHTING'), ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LIGHTING')) ' ' el.get(prop).getPropDescription('LIGHTING')], ...
					    'ValueChangedFcn', {@cb_ambient} ...
					    );
					value = dropdown_lighting;
					
				case SettingsAmbientPP.LABEL_MATERIAL % __SettingsAmbientPP.LABEL_MATERIAL__
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_material =  uilabel( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'LABEL_MATERIAL', ...
					    'Text', 'material', ...
					    'Interpreter', 'html', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'HorizontalAlignment', 'right', ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('MATERIAL')) ' ' el.get(prop).getPropDescription('MATERIAL')], ...
					    'BackgroundColor', pr.get('BKGCOLOR') ...
					    );
					value = label_material;
					
				case SettingsAmbientPP.DROPDOWN_MATERIAL % __SettingsAmbientPP.DROPDOWN_MATERIAL__
					el = pr.get('EL');
					prop = pr.get('PROP');
					dropdown_material = uidropdown( ...
					    'Parent', pr.memorize('H'), ...
					        'Tag', 'DROPDOWN_MATERIAL', ...
					        'Items', el.get(prop).getPropSettings('MATERIAL'), ...
					        'FontSize', BRAPH2.FONTSIZE, ...
					        'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('MATERIAL')) ' ' el.get(prop).getPropDescription('MATERIAL')], ...
					        'ValueChangedFcn', {@cb_ambient} ... % callback in DROPBOX_LIGHTING
					        );
					value = dropdown_material;
					
				case SettingsAmbientPP.LABEL_CAMLIGHT % __SettingsAmbientPP.LABEL_CAMLIGHT__
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_camlight =  uilabel( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'LABEL_CAMLIGHT', ...
					    'Text', 'camera light', ...
					    'Interpreter', 'html', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'HorizontalAlignment', 'right', ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('CAMLIGHT')) ' ' el.get(prop).getPropDescription('CAMLIGHT')], ...
					    'BackgroundColor', pr.get('BKGCOLOR') ...
					    );
					value = label_camlight;
					
				case SettingsAmbientPP.DROPDOWN_CAMLIGHT % __SettingsAmbientPP.DROPDOWN_CAMLIGHT__
					el = pr.get('EL');
					prop = pr.get('PROP');
					dropdown_camlight = uidropdown( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'DROPDOWN_CAMLIGHT', ...
					    'Items', el.get(prop).getPropSettings('CAMLIGHT'), ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('CAMLIGHT')) ' ' el.get(prop).getPropDescription('CAMLIGHT')], ...
					    'ValueChangedFcn', {@cb_ambient} ... % callback in DROPBOX_LIGHTING
					    );
					value = dropdown_camlight;
					
				case SettingsAmbientPP.LABEL_SHADING % __SettingsAmbientPP.LABEL_SHADING__
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_shading =  uilabel( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'LABEL_SHADING', ...
					    'Text', 'shading', ...
					    'Interpreter', 'html', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'HorizontalAlignment', 'right', ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('SHADING')) ' ' el.get(prop).getPropDescription('SHADING')], ...
					    'BackgroundColor', pr.get('BKGCOLOR') ...
					    );
					value = label_shading;
					
				case SettingsAmbientPP.DROPDOWN_SHADING % __SettingsAmbientPP.DROPDOWN_SHADING__
					el = pr.get('EL');
					prop = pr.get('PROP');
					dropdown_shading = uidropdown( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'DROPDOWN_SHADING', ...
					    'Items', el.get(prop).getPropSettings('SHADING'), ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('SHADING')) ' ' el.get(prop).getPropDescription('SHADING')], ...
					    'ValueChangedFcn', {@cb_ambient} ... % callback in DROPBOX_LIGHTING
					    );
					value = dropdown_shading;
					
				case SettingsAmbientPP.LABEL_COLORMAP % __SettingsAmbientPP.LABEL_COLORMAP__
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_colormap =  uilabel( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'LABEL_COLORMAP', ...
					    'Text', 'colormap', ...
					    'Interpreter', 'html', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'HorizontalAlignment', 'right', ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('COLORMAP')) ' ' el.get(prop).getPropDescription('COLORMAP')], ...
					    'BackgroundColor', pr.get('BKGCOLOR') ...
					    );
					value = label_colormap;
					
				case SettingsAmbientPP.DROPDOWN_COLORMAP % __SettingsAmbientPP.DROPDOWN_COLORMAP__
					el = pr.get('EL');
					prop = pr.get('PROP');
					dropdown_colormap = uidropdown( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'DROPDOWN_COLORMAP', ...
					    'Items', el.get(prop).getPropSettings('COLORMAP'), ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('COLORMAP')) ' ' el.get(prop).getPropDescription('COLORMAP')], ...
					    'ValueChangedFcn', {@cb_ambient} ... % callback in DROPBOX_LIGHTING
					    );
					value = dropdown_colormap;
					
				case SettingsAmbientPP.X_DRAW % __SettingsAmbientPP.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('LABEL_LIGHTING')
					    pr.memorize('DROPDOWN_LIGHTING')
					
					    pr.memorize('LABEL_MATERIAL')
					    pr.memorize('DROPDOWN_MATERIAL')
					
					    pr.memorize('LABEL_CAMLIGHT')
					    pr.memorize('DROPDOWN_CAMLIGHT')
					
					    pr.memorize('LABEL_SHADING')
					    pr.memorize('DROPDOWN_SHADING')
					
					    pr.memorize('LABEL_COLORMAP')
					    pr.memorize('DROPDOWN_COLORMAP')
					end
					
				case SettingsAmbientPP.UPDATE % __SettingsAmbientPP.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					
						el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    if el.isLocked(prop)
					        set(pr.get('DROPDOWN_LIGHTING'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('DROPDOWN_MATERIAL'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('DROPDOWN_CAMLIGHT'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('DROPDOWN_SHADING'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('DROPDOWN_COLORMAP'), 'Enable', pr.get('ENABLE'))
					    end
					
					    switch el.getPropCategory(prop)
					        case Category.METADATA
					            set(pr.get('DROPDOWN_LIGHTING'), 'Value', el.get(prop).get('LIGHTING'))
					            set(pr.get('DROPDOWN_MATERIAL'), 'Value', el.get(prop).get('MATERIAL'))
					            set(pr.get('DROPDOWN_CAMLIGHT'), 'Value', el.get(prop).get('CAMLIGHT'))
					            set(pr.get('DROPDOWN_SHADING'), 'Value', el.get(prop).get('SHADING'))
					            set(pr.get('DROPDOWN_COLORMAP'), 'Value', el.get(prop).get('COLORMAP'))
					
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('DROPDOWN_LIGHTING'), 'Value', el.get(prop).get('LIGHTING'))
					            set(pr.get('DROPDOWN_MATERIAL'), 'Value', el.get(prop).get('MATERIAL'))
					            set(pr.get('DROPDOWN_CAMLIGHT'), 'Value', el.get(prop).get('CAMLIGHT'))
					            set(pr.get('DROPDOWN_SHADING'), 'Value', el.get(prop).get('SHADING'))
					            set(pr.get('DROPDOWN_COLORMAP'), 'Value', el.get(prop).get('COLORMAP'))
					
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('LIGHTING'), 'Callback')
					                set(pr.get('DROPDOWN_LIGHTING'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('MATERIAL'), 'Callback')
					                set(pr.get('DROPDOWN_MATERIAL'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('CAMLIGHT'), 'Callback')
					                set(pr.get('DROPDOWN_CAMLIGHT'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('SHADING'), 'Callback')
					                set(pr.get('DROPDOWN_SHADING'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('COLORMAP'), 'Callback')
					                set(pr.get('DROPDOWN_COLORMAP'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            
					        case Category.RESULT
					            value = el.getr(prop);
					
					            if isa(value, 'NoValue')
					                set(pr.get('DROPDOWN_LIGHTING'), ...
					                    'Value', el.get(prop).getPropDefault('LIGHTING'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('DROPDOWN_MATERIAL'), ...
					                    'Value', el.get(prop).getPropDefault('MATERIAL'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('DROPDOWN_CAMLIGHT'), ...
					                    'Value', el.get(prop).getPropDefault('CAMLIGHT'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('DROPDOWN_SHADING'), ...
					                    'Value', el.get(prop).getPropDefault('SHADING'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('DROPDOWN_COLORMAP'), ...
					                    'Value', el.get(prop).getPropDefault('COLORMAP'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )                
					            else
					                set(pr.get('DROPDOWN_LIGHTING'), ...
					                    'Value', el.get(prop).get('LIGHTING'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('DROPDOWN_MATERIAL'), ...
					                    'Value', el.get(prop).get('MATERIAL'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('DROPDOWN_CAMLIGHT'), ...
					                    'Value', el.get(prop).get('CAMLIGHT'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('DROPDOWN_SHADING'), ...
					                    'Value', el.get(prop).get('SHADING'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('DROPDOWN_COLORMAP'), ...
					                    'Value', el.get(prop).get('COLORMAP'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )                
					            end
					    end
					end
					
				case SettingsAmbientPP.REDRAW % __SettingsAmbientPP.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('LABEL_LIGHTING'), 'Position', [s(.3) s(8.3) s(8) s(1.7)])
					    set(pr.get('DROPDOWN_LIGHTING'), 'Position', [s(8.6) s(8.3) w_p-s(10) s(1.7)])
					
					    set(pr.get('LABEL_MATERIAL'), 'Position', [s(.3) s(6.3) s(8) s(1.7)])
					    set(pr.get('DROPDOWN_MATERIAL'), 'Position', [s(8.6) s(6.3) w_p-s(10) s(1.7)])
					
					    set(pr.get('LABEL_CAMLIGHT'), 'Position', [s(.3) s(4.3) s(8) s(1.7)])
					    set(pr.get('DROPDOWN_CAMLIGHT'), 'Position', [s(8.6) s(4.3) w_p-s(10) s(1.7)])
					
					    set(pr.get('LABEL_SHADING'), 'Position', [s(.3) s(2.3) s(8) s(1.7)])
					    set(pr.get('DROPDOWN_SHADING'), 'Position', [s(8.6) s(2.3) w_p-s(10) s(1.7)])
					
					    set(pr.get('LABEL_COLORMAP'), 'Position', [s(.3) s(.3) s(8) s(1.7)])
					    set(pr.get('DROPDOWN_COLORMAP'), 'Position', [s(8.6) s(.3) w_p-s(10) s(1.7)])
					end
					
				case SettingsAmbientPP.DELETE % __SettingsAmbientPP.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('LABEL_LIGHTING', Element.getNoValue())
					    pr.set('DROPDOWN_LIGHTING', Element.getNoValue())
					
					    pr.set('LABEL_MATERIAL', Element.getNoValue())
					    pr.set('DROPDOWN_MATERIAL', Element.getNoValue())
					
					    pr.set('LABEL_CAMLIGHT', Element.getNoValue())
					    pr.set('DROPDOWN_CAMLIGHT', Element.getNoValue())
					
					    pr.set('LABEL_SHADING', Element.getNoValue())
					    pr.set('DROPDOWN_SHADING', Element.getNoValue())
					
					    pr.set('LABEL_COLORMAP', Element.getNoValue())
					    pr.set('DROPDOWN_COLORMAP', Element.getNoValue())
					end
					
				otherwise
					if prop <= SettingsPP.getPropNumber()
						value = calculateValue@SettingsPP(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_ambient(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    el.get(prop).set( ...
			        'LIGHTING', get(pr.get('DROPDOWN_LIGHTING'), 'Value'), ...
			        'MATERIAL', get(pr.get('DROPDOWN_MATERIAL'), 'Value'), ...
			        'CAMLIGHT', get(pr.get('DROPDOWN_CAMLIGHT'), 'Value'), ...
			        'SHADING', get(pr.get('DROPDOWN_SHADING'), 'Value'), ...
			        'COLORMAP', get(pr.get('DROPDOWN_COLORMAP'), 'Value') ...
			        )
			end
		end
	end
end
