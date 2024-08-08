classdef SettingsAreaPP < SettingsPP
	%SettingsAreaPP is the panel with area settings.
	% It is a subclass of <a href="matlab:help SettingsPP">SettingsPP</a>.
	%
	% A Prop Panel for Area Settings (SettingsAreaPP) plots the panel for area settings,
	%  including visibility, face color, face alpha, edge color, and edge alpha.
	% It works for all categories.
	%
	% SettingsAreaPP methods (constructor):
	%  SettingsAreaPP - constructor
	%
	% SettingsAreaPP methods:
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
	% SettingsAreaPP methods (display):
	%  tostring - string with information about the prop panel for area settings
	%  disp - displays information about the prop panel for area settings
	%  tree - displays the tree of the prop panel for area settings
	%
	% SettingsAreaPP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two prop panel for area settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the prop panel for area settings
	%
	% SettingsAreaPP methods (save/load, Static):
	%  save - saves BRAPH2 prop panel for area settings as b2 file
	%  load - loads a BRAPH2 prop panel for area settings from a b2 file
	%
	% SettingsAreaPP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the prop panel for area settings
	%
	% SettingsAreaPP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the prop panel for area settings
	%
	% SettingsAreaPP methods (inspection, Static):
	%  getClass - returns the class of the prop panel for area settings
	%  getSubclasses - returns all subclasses of SettingsAreaPP
	%  getProps - returns the property list of the prop panel for area settings
	%  getPropNumber - returns the property number of the prop panel for area settings
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
	% SettingsAreaPP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsAreaPP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsAreaPP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsAreaPP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsAreaPP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsAreaPP constants</a>.
	%
	%
	% See also SettingsArea, uicheckbox, , uipushbutton, uieditfield, uislider.
	
	properties (Constant) % properties
		ENABLE = SettingsPP.getPropNumber() + 1;
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = Category.GUI;
		ENABLE_FORMAT = Format.LOGICAL;
		
		CHECKBOX_VISIBLE = SettingsPP.getPropNumber() + 2;
		CHECKBOX_VISIBLE_TAG = 'CHECKBOX_VISIBLE';
		CHECKBOX_VISIBLE_CATEGORY = Category.EVANESCENT;
		CHECKBOX_VISIBLE_FORMAT = Format.HANDLE;
		
		BUTTON_FACECOLOR = SettingsPP.getPropNumber() + 3;
		BUTTON_FACECOLOR_TAG = 'BUTTON_FACECOLOR';
		BUTTON_FACECOLOR_CATEGORY = Category.EVANESCENT;
		BUTTON_FACECOLOR_FORMAT = Format.HANDLE;
		
		EDITFIELD_FACEALPHA = SettingsPP.getPropNumber() + 4;
		EDITFIELD_FACEALPHA_TAG = 'EDITFIELD_FACEALPHA';
		EDITFIELD_FACEALPHA_CATEGORY = Category.EVANESCENT;
		EDITFIELD_FACEALPHA_FORMAT = Format.HANDLE;
		
		SLIDER_FACEALPHA = SettingsPP.getPropNumber() + 5;
		SLIDER_FACEALPHA_TAG = 'SLIDER_FACEALPHA';
		SLIDER_FACEALPHA_CATEGORY = Category.EVANESCENT;
		SLIDER_FACEALPHA_FORMAT = Format.HANDLE;
		
		BUTTON_EDGECOLOR = SettingsPP.getPropNumber() + 6;
		BUTTON_EDGECOLOR_TAG = 'BUTTON_EDGECOLOR';
		BUTTON_EDGECOLOR_CATEGORY = Category.EVANESCENT;
		BUTTON_EDGECOLOR_FORMAT = Format.HANDLE;
		
		EDITFIELD_EDGEALPHA = SettingsPP.getPropNumber() + 7;
		EDITFIELD_EDGEALPHA_TAG = 'EDITFIELD_EDGEALPHA';
		EDITFIELD_EDGEALPHA_CATEGORY = Category.EVANESCENT;
		EDITFIELD_EDGEALPHA_FORMAT = Format.HANDLE;
		
		SLIDER_EDGEALPHA = SettingsPP.getPropNumber() + 8;
		SLIDER_EDGEALPHA_TAG = 'SLIDER_EDGEALPHA';
		SLIDER_EDGEALPHA_CATEGORY = Category.EVANESCENT;
		SLIDER_EDGEALPHA_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = SettingsAreaPP(varargin)
			%SettingsAreaPP() creates a prop panel for area settings.
			%
			% SettingsAreaPP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsAreaPP(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the prop panel for area settings.
			%
			% CLASS = SettingsAreaPP.GETCLASS() returns the class 'SettingsAreaPP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the prop panel for area settings PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('SettingsAreaPP') returns 'SettingsAreaPP'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('SettingsAreaPP')
			%  are less computationally efficient.
			
			pr_class = 'SettingsAreaPP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the prop panel for area settings.
			%
			% LIST = SettingsAreaPP.GETSUBCLASSES() returns all subclasses of 'SettingsAreaPP'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the prop panel for area settings PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('SettingsAreaPP') returns all subclasses of 'SettingsAreaPP'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SettingsAreaPP', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of prop panel for area settings.
			%
			% PROPS = SettingsAreaPP.GETPROPS() returns the property list of prop panel for area settings
			%  as a row vector.
			%
			% PROPS = SettingsAreaPP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the prop panel for area settings PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('SettingsAreaPP'[, CATEGORY]) returns the property list of 'SettingsAreaPP'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					SettingsPP.getProps() ...
						SettingsAreaPP.ENABLE ...
						SettingsAreaPP.CHECKBOX_VISIBLE ...
						SettingsAreaPP.BUTTON_FACECOLOR ...
						SettingsAreaPP.EDITFIELD_FACEALPHA ...
						SettingsAreaPP.SLIDER_FACEALPHA ...
						SettingsAreaPP.BUTTON_EDGECOLOR ...
						SettingsAreaPP.EDITFIELD_EDGEALPHA ...
						SettingsAreaPP.SLIDER_EDGEALPHA ...
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
						SettingsAreaPP.CHECKBOX_VISIBLE ...
						SettingsAreaPP.BUTTON_FACECOLOR ...
						SettingsAreaPP.EDITFIELD_FACEALPHA ...
						SettingsAreaPP.SLIDER_FACEALPHA ...
						SettingsAreaPP.BUTTON_EDGECOLOR ...
						SettingsAreaPP.EDITFIELD_EDGEALPHA ...
						SettingsAreaPP.SLIDER_EDGEALPHA ...
						];
				case Category.FIGURE
					prop_list = [ ...
						SettingsPP.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						SettingsPP.getProps(Category.GUI) ...
						SettingsAreaPP.ENABLE ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of prop panel for area settings.
			%
			% N = SettingsAreaPP.GETPROPNUMBER() returns the property number of prop panel for area settings.
			%
			% N = SettingsAreaPP.GETPROPNUMBER(CATEGORY) returns the property number of prop panel for area settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the prop panel for area settings PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('SettingsAreaPP') returns the property number of 'SettingsAreaPP'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SettingsAreaPP.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in prop panel for area settings/error.
			%
			% CHECK = SettingsAreaPP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(SettingsAreaPP, PROP) checks whether PROP exists for SettingsAreaPP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsAreaPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAreaPP:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAreaPP:WrongInput]
			%  Element.EXISTSPROP(SettingsAreaPP, PROP) throws error if PROP does NOT exist for SettingsAreaPP.
			%   Error id: [BRAPH2:SettingsAreaPP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SettingsAreaPP.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsAreaPP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsAreaPP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsAreaPP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in prop panel for area settings/error.
			%
			% CHECK = SettingsAreaPP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(SettingsAreaPP, TAG) checks whether TAG exists for SettingsAreaPP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsAreaPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAreaPP:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsAreaPP:WrongInput]
			%  Element.EXISTSTAG(SettingsAreaPP, TAG) throws error if TAG does NOT exist for SettingsAreaPP.
			%   Error id: [BRAPH2:SettingsAreaPP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			settingsareapp_tag_list = cellfun(@(x) SettingsAreaPP.getPropTag(x), num2cell(SettingsAreaPP.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, settingsareapp_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsAreaPP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsAreaPP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SettingsAreaPP.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsAreaPP, POINTER) returns property number of POINTER of SettingsAreaPP.
			%  PROPERTY = PR.GETPROPPROP(SettingsAreaPP, POINTER) returns property number of POINTER of SettingsAreaPP.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				settingsareapp_tag_list = cellfun(@(x) SettingsAreaPP.getPropTag(x), num2cell(SettingsAreaPP.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, settingsareapp_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(SettingsAreaPP, POINTER) returns tag of POINTER of SettingsAreaPP.
			%  TAG = PR.GETPROPTAG(SettingsAreaPP, POINTER) returns tag of POINTER of SettingsAreaPP.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SettingsAreaPP.ENABLE
						tag = SettingsAreaPP.ENABLE_TAG;
					case SettingsAreaPP.CHECKBOX_VISIBLE
						tag = SettingsAreaPP.CHECKBOX_VISIBLE_TAG;
					case SettingsAreaPP.BUTTON_FACECOLOR
						tag = SettingsAreaPP.BUTTON_FACECOLOR_TAG;
					case SettingsAreaPP.EDITFIELD_FACEALPHA
						tag = SettingsAreaPP.EDITFIELD_FACEALPHA_TAG;
					case SettingsAreaPP.SLIDER_FACEALPHA
						tag = SettingsAreaPP.SLIDER_FACEALPHA_TAG;
					case SettingsAreaPP.BUTTON_EDGECOLOR
						tag = SettingsAreaPP.BUTTON_EDGECOLOR_TAG;
					case SettingsAreaPP.EDITFIELD_EDGEALPHA
						tag = SettingsAreaPP.EDITFIELD_EDGEALPHA_TAG;
					case SettingsAreaPP.SLIDER_EDGEALPHA
						tag = SettingsAreaPP.SLIDER_EDGEALPHA_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsAreaPP, POINTER) returns category of POINTER of SettingsAreaPP.
			%  CATEGORY = PR.GETPROPCATEGORY(SettingsAreaPP, POINTER) returns category of POINTER of SettingsAreaPP.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsAreaPP.getPropProp(pointer);
			
			switch prop
				case SettingsAreaPP.ENABLE
					prop_category = SettingsAreaPP.ENABLE_CATEGORY;
				case SettingsAreaPP.CHECKBOX_VISIBLE
					prop_category = SettingsAreaPP.CHECKBOX_VISIBLE_CATEGORY;
				case SettingsAreaPP.BUTTON_FACECOLOR
					prop_category = SettingsAreaPP.BUTTON_FACECOLOR_CATEGORY;
				case SettingsAreaPP.EDITFIELD_FACEALPHA
					prop_category = SettingsAreaPP.EDITFIELD_FACEALPHA_CATEGORY;
				case SettingsAreaPP.SLIDER_FACEALPHA
					prop_category = SettingsAreaPP.SLIDER_FACEALPHA_CATEGORY;
				case SettingsAreaPP.BUTTON_EDGECOLOR
					prop_category = SettingsAreaPP.BUTTON_EDGECOLOR_CATEGORY;
				case SettingsAreaPP.EDITFIELD_EDGEALPHA
					prop_category = SettingsAreaPP.EDITFIELD_EDGEALPHA_CATEGORY;
				case SettingsAreaPP.SLIDER_EDGEALPHA
					prop_category = SettingsAreaPP.SLIDER_EDGEALPHA_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsAreaPP, POINTER) returns format of POINTER of SettingsAreaPP.
			%  FORMAT = PR.GETPROPFORMAT(SettingsAreaPP, POINTER) returns format of POINTER of SettingsAreaPP.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsAreaPP.getPropProp(pointer);
			
			switch prop
				case SettingsAreaPP.ENABLE
					prop_format = SettingsAreaPP.ENABLE_FORMAT;
				case SettingsAreaPP.CHECKBOX_VISIBLE
					prop_format = SettingsAreaPP.CHECKBOX_VISIBLE_FORMAT;
				case SettingsAreaPP.BUTTON_FACECOLOR
					prop_format = SettingsAreaPP.BUTTON_FACECOLOR_FORMAT;
				case SettingsAreaPP.EDITFIELD_FACEALPHA
					prop_format = SettingsAreaPP.EDITFIELD_FACEALPHA_FORMAT;
				case SettingsAreaPP.SLIDER_FACEALPHA
					prop_format = SettingsAreaPP.SLIDER_FACEALPHA_FORMAT;
				case SettingsAreaPP.BUTTON_EDGECOLOR
					prop_format = SettingsAreaPP.BUTTON_EDGECOLOR_FORMAT;
				case SettingsAreaPP.EDITFIELD_EDGEALPHA
					prop_format = SettingsAreaPP.EDITFIELD_EDGEALPHA_FORMAT;
				case SettingsAreaPP.SLIDER_EDGEALPHA
					prop_format = SettingsAreaPP.SLIDER_EDGEALPHA_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsAreaPP, POINTER) returns description of POINTER of SettingsAreaPP.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(SettingsAreaPP, POINTER) returns description of POINTER of SettingsAreaPP.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsAreaPP.getPropProp(pointer);
			
			switch prop
				case SettingsAreaPP.ENABLE
					prop_description = 'ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.';
				case SettingsAreaPP.CHECKBOX_VISIBLE
					prop_description = 'CHECKBOX_VISIBLE (evanescent, handle) determines whether the area is visible.';
				case SettingsAreaPP.BUTTON_FACECOLOR
					prop_description = 'BUTTON_FACECOLOR (evanescent, handle) is the face color button.';
				case SettingsAreaPP.EDITFIELD_FACEALPHA
					prop_description = 'EDITFIELD_FACEALPHA (evanescent, handle) is the face alpha edit field.';
				case SettingsAreaPP.SLIDER_FACEALPHA
					prop_description = 'SLIDER_FACEALPHA (evanescent, handle) is the face alpha slider.';
				case SettingsAreaPP.BUTTON_EDGECOLOR
					prop_description = 'BUTTON_EDGECOLOR (evanescent, handle) is the edge color button.';
				case SettingsAreaPP.EDITFIELD_EDGEALPHA
					prop_description = 'EDITFIELD_EDGEALPHA (evanescent, handle) is the edge alpha edit field.';
				case SettingsAreaPP.SLIDER_EDGEALPHA
					prop_description = 'SLIDER_EDGEALPHA (evanescent, handle) is the edge alpha slider.';
				case SettingsAreaPP.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the property panel for area settings.';
				case SettingsAreaPP.NAME
					prop_description = 'NAME (constant, string) is the name of the property panel for area settings.';
				case SettingsAreaPP.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the property panel for area settings.';
				case SettingsAreaPP.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the property panel for area settings.';
				case SettingsAreaPP.ID
					prop_description = 'ID (data, string) is a few-letter code for the property panel for area settings.';
				case SettingsAreaPP.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the property panel for area settings.';
				case SettingsAreaPP.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the property panel for area settings.';
				case SettingsAreaPP.EL
					prop_description = 'EL (data, item) is the element.';
				case SettingsAreaPP.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case SettingsAreaPP.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the settings position panel.';
				case SettingsAreaPP.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case SettingsAreaPP.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.';
				case SettingsAreaPP.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case SettingsAreaPP.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsAreaPP, POINTER) returns settings of POINTER of SettingsAreaPP.
			%  SETTINGS = PR.GETPROPSETTINGS(SettingsAreaPP, POINTER) returns settings of POINTER of SettingsAreaPP.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsAreaPP.getPropProp(pointer);
			
			switch prop
				case SettingsAreaPP.ENABLE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SettingsAreaPP.CHECKBOX_VISIBLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAreaPP.BUTTON_FACECOLOR
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAreaPP.EDITFIELD_FACEALPHA
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAreaPP.SLIDER_FACEALPHA
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAreaPP.BUTTON_EDGECOLOR
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAreaPP.EDITFIELD_EDGEALPHA
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAreaPP.SLIDER_EDGEALPHA
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsAreaPP.TEMPLATE
					prop_settings = 'SettingsAreaPP';
				otherwise
					prop_settings = getPropSettings@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsAreaPP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsAreaPP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsAreaPP, POINTER) returns the default value of POINTER of SettingsAreaPP.
			%  DEFAULT = PR.GETPROPDEFAULT(SettingsAreaPP, POINTER) returns the default value of POINTER of SettingsAreaPP.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsAreaPP.getPropProp(pointer);
			
			switch prop
				case SettingsAreaPP.ENABLE
					prop_default = true;
				case SettingsAreaPP.CHECKBOX_VISIBLE
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAreaPP.getPropSettings(prop));
				case SettingsAreaPP.BUTTON_FACECOLOR
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAreaPP.getPropSettings(prop));
				case SettingsAreaPP.EDITFIELD_FACEALPHA
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAreaPP.getPropSettings(prop));
				case SettingsAreaPP.SLIDER_FACEALPHA
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAreaPP.getPropSettings(prop));
				case SettingsAreaPP.BUTTON_EDGECOLOR
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAreaPP.getPropSettings(prop));
				case SettingsAreaPP.EDITFIELD_EDGEALPHA
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAreaPP.getPropSettings(prop));
				case SettingsAreaPP.SLIDER_EDGEALPHA
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsAreaPP.getPropSettings(prop));
				case SettingsAreaPP.ELCLASS
					prop_default = 'SettingsAreaPP';
				case SettingsAreaPP.NAME
					prop_default = 'Prop Panel for Area Settings';
				case SettingsAreaPP.DESCRIPTION
					prop_default = 'A Prop Panel for Area Settings (SettingsAreaPP) plots the panel for area settings, including visibility, face color, face alpha, edge color, and edge alpha. It works for all categories.';
				case SettingsAreaPP.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, SettingsAreaPP.getPropSettings(prop));
				case SettingsAreaPP.ID
					prop_default = 'SettingsAreaPP ID';
				case SettingsAreaPP.LABEL
					prop_default = 'SettingsAreaPP label';
				case SettingsAreaPP.NOTES
					prop_default = 'SettingsAreaPP notes';
				case SettingsAreaPP.EL
					prop_default = GraphHistPF();
				case SettingsAreaPP.PROP
					prop_default = GraphHistPF.ST_HIST_AREA;
				case SettingsAreaPP.HEIGHT
					prop_default = s(9.2);
				otherwise
					prop_default = getPropDefault@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsAreaPP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsAreaPP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsAreaPP, POINTER) returns the conditioned default value of POINTER of SettingsAreaPP.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(SettingsAreaPP, POINTER) returns the conditioned default value of POINTER of SettingsAreaPP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsAreaPP.getPropProp(pointer);
			
			prop_default = SettingsAreaPP.conditioning(prop, SettingsAreaPP.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsAreaPP, PROP, VALUE) checks VALUE format for PROP of SettingsAreaPP.
			%  CHECK = PR.CHECKPROP(SettingsAreaPP, PROP, VALUE) checks VALUE format for PROP of SettingsAreaPP.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SettingsAreaPP:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:SettingsAreaPP:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SettingsAreaPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsAreaPP.
			%   Error id: €BRAPH2.STR€:SettingsAreaPP:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(SettingsAreaPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsAreaPP.
			%   Error id: €BRAPH2.STR€:SettingsAreaPP:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('SettingsAreaPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsAreaPP.getPropProp(pointer);
			
			switch prop
				case SettingsAreaPP.ENABLE % __SettingsAreaPP.ENABLE__
					check = Format.checkFormat(Format.LOGICAL, value, SettingsAreaPP.getPropSettings(prop));
				case SettingsAreaPP.CHECKBOX_VISIBLE % __SettingsAreaPP.CHECKBOX_VISIBLE__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAreaPP.getPropSettings(prop));
				case SettingsAreaPP.BUTTON_FACECOLOR % __SettingsAreaPP.BUTTON_FACECOLOR__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAreaPP.getPropSettings(prop));
				case SettingsAreaPP.EDITFIELD_FACEALPHA % __SettingsAreaPP.EDITFIELD_FACEALPHA__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAreaPP.getPropSettings(prop));
				case SettingsAreaPP.SLIDER_FACEALPHA % __SettingsAreaPP.SLIDER_FACEALPHA__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAreaPP.getPropSettings(prop));
				case SettingsAreaPP.BUTTON_EDGECOLOR % __SettingsAreaPP.BUTTON_EDGECOLOR__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAreaPP.getPropSettings(prop));
				case SettingsAreaPP.EDITFIELD_EDGEALPHA % __SettingsAreaPP.EDITFIELD_EDGEALPHA__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAreaPP.getPropSettings(prop));
				case SettingsAreaPP.SLIDER_EDGEALPHA % __SettingsAreaPP.SLIDER_EDGEALPHA__
					check = Format.checkFormat(Format.HANDLE, value, SettingsAreaPP.getPropSettings(prop));
				case SettingsAreaPP.TEMPLATE % __SettingsAreaPP.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, SettingsAreaPP.getPropSettings(prop));
				otherwise
					if prop <= SettingsPP.getPropNumber()
						check = checkProp@SettingsPP(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsAreaPP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsAreaPP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsAreaPP.getPropTag(prop) ' (' SettingsAreaPP.getFormatTag(SettingsAreaPP.getPropFormat(prop)) ').'] ...
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
				case SettingsAreaPP.CHECKBOX_VISIBLE % __SettingsAreaPP.CHECKBOX_VISIBLE__
					el = pr.get('EL');
					prop = pr.get('PROP');
					checkbox_visible = uicheckbox( ...
					    'Parent', pr.memorize('H'), ...
						'Tag', 'CHECKBOX_VISIBLE', ...
					    'Text', 'visible', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('VISIBLE')) ' ' el.get(prop).getPropDescription('VISIBLE')], ...
					    'ValueChangedFcn', {@cb_visible} ...
					    );
					value = checkbox_visible;
					
				case SettingsAreaPP.BUTTON_FACECOLOR % __SettingsAreaPP.BUTTON_FACECOLOR__
					el = pr.get('EL');
					prop = pr.get('PROP');
					button_facecolor = uibutton( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'BUTTON_FACECOLOR', ...
					    'Text', 'face', ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FACECOLOR')) ' ' el.get(prop).getPropDescription('FACECOLOR')], ...
					    'ButtonPushedFcn', {@cb_button_facecolor}, ...
					    'Interruptible', 'off', ...
					    'BusyAction', 'cancel' ...
					    );
					value = button_facecolor;
					
				case SettingsAreaPP.EDITFIELD_FACEALPHA % __SettingsAreaPP.EDITFIELD_FACEALPHA__
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_facealpha = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'EDITFIELD_FACEALPHA', ...
					    'Limits', [0 1], ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FACEALPHA')) ' ' el.get(prop).getPropDescription('FACEALPHA')], ...
					    'ValueChangedFcn', {@cb_editfield_facealpha} ...
					    );
					value = editfield_facealpha;
					
				case SettingsAreaPP.SLIDER_FACEALPHA % __SettingsAreaPP.SLIDER_FACEALPHA__
					el = pr.get('EL');
					prop = pr.get('PROP');
					slider_facealpha = uislider( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'SLIDER_FACEALPHA', ...
					    'Limits', [0 1], ...
					    'FontSize', BRAPH2.FONTSIZE / 2, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FACEALPHA')) ' ' el.get(prop).getPropDescription('FACEALPHA')], ...
					    'ValueChangedFcn', {@cb_slider_facealpha} ...
					    );
					value = slider_facealpha;
					
				case SettingsAreaPP.BUTTON_EDGECOLOR % __SettingsAreaPP.BUTTON_EDGECOLOR__
					el = pr.get('EL');
					prop = pr.get('PROP');
					button_edgecolor = uibutton( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'BUTTON_EDGECOLOR', ...
					    'Text', 'edge', ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('EDGECOLOR')) ' ' el.get(prop).getPropDescription('EDGECOLOR')], ...
					    'ButtonPushedFcn', {@cb_button_edgecolor}, ...
					    'Interruptible', 'off', ...
					    'BusyAction', 'cancel' ...
					    );
					value = button_edgecolor;
					
				case SettingsAreaPP.EDITFIELD_EDGEALPHA % __SettingsAreaPP.EDITFIELD_EDGEALPHA__
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_edgealpha = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'EDITFIELD_EDGEALPHA', ...
					    'Limits', [0 1], ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('EDGEALPHA')) ' ' el.get(prop).getPropDescription('EDGEALPHA')], ...
					    'ValueChangedFcn', {@cb_editfield_edgealpha} ...
					    );
					value = editfield_edgealpha;
					
				case SettingsAreaPP.SLIDER_EDGEALPHA % __SettingsAreaPP.SLIDER_EDGEALPHA__
					el = pr.get('EL');
					prop = pr.get('PROP');
					slider_edgealpha = uislider( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'SLIDER_EDGEALPHA', ...
					    'Limits', [0 1], ...
					    'FontSize', BRAPH2.FONTSIZE / 2, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('EDGEALPHA')) ' ' el.get(prop).getPropDescription('EDGEALPHA')], ...
					    'ValueChangedFcn', {@cb_slider_edgealpha} ...
					    );
					value = slider_edgealpha;
					
				case SettingsAreaPP.X_DRAW % __SettingsAreaPP.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('CHECKBOX_VISIBLE')
					
					    pr.memorize('BUTTON_FACECOLOR')
					    pr.memorize('EDITFIELD_FACEALPHA')
					    pr.memorize('SLIDER_FACEALPHA')
					    
					    pr.memorize('BUTTON_EDGECOLOR')
					    pr.memorize('EDITFIELD_EDGEALPHA')
					    pr.memorize('SLIDER_EDGEALPHA')
					end
					
				case SettingsAreaPP.UPDATE % __SettingsAreaPP.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    if el.isLocked(prop)
					        set(pr.get('CHECKBOX_VISIBLE'), 'Enable', pr.get('ENABLE'))
					
					        set(pr.get('BUTTON_FACECOLOR'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('EDITFIELD_FACEALPHA'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('SLIDER_FACEALPHA'), 'Enable', pr.get('ENABLE'))
					        
					        set(pr.get('BUTTON_EDGECOLOR'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('EDITFIELD_EDGEALPHA'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('SLIDER_EDGEALPHA'), 'Enable', pr.get('ENABLE'))
					    end
					
					    switch el.getPropCategory(prop)
					        case Category.METADATA
					            set(pr.get('CHECKBOX_VISIBLE'), 'Value', el.get(prop).get('VISIBLE'))
					
					            set(pr.get('BUTTON_FACECOLOR'), 'BackgroundColor', el.get(prop).get('FACECOLOR'))
					            set(pr.get('EDITFIELD_FACEALPHA'), 'Value', el.get(prop).get('FACEALPHA'))
					            set(pr.get('SLIDER_FACEALPHA'), 'Value', el.get(prop).get('FACEALPHA'))
					            
					            set(pr.get('BUTTON_EDGECOLOR'), 'BackgroundColor', el.get(prop).get('EDGECOLOR'))
					            set(pr.get('EDITFIELD_EDGEALPHA'), 'Value', el.get(prop).get('EDGEALPHA'))
					            set(pr.get('SLIDER_EDGEALPHA'), 'Value', el.get(prop).get('EDGEALPHA'))
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('CHECKBOX_VISIBLE'), 'Value', el.get(prop).get('VISIBLE'))
					
					            set(pr.get('BUTTON_FACECOLOR'), 'BackgroundColor', el.get(prop).get('FACECOLOR'))
					            set(pr.get('EDITFIELD_FACEALPHA'), 'Value', el.get(prop).get('FACEALPHA'))
					            set(pr.get('SLIDER_FACEALPHA'), 'Value', el.get(prop).get('FACEALPHA'))
					            
					            set(pr.get('BUTTON_EDGECOLOR'), 'BackgroundColor', el.get(prop).get('EDGECOLOR'))
					            set(pr.get('EDITFIELD_EDGEALPHA'), 'Value', el.get(prop).get('EDGEALPHA'))
					            set(pr.get('SLIDER_EDGEALPHA'), 'Value', el.get(prop).get('EDGEALPHA'))
					
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('VISIBLE'), 'Callback')
					                set(pr.get('CHECKBOX_VISIBLE'), 'Enable', pr.get('ENABLE'))
					            end
					
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FACECOLOR'), 'Callback')
					                set(pr.get('BUTTON_FACECOLOR'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FACEALPHA'), 'Callback')
					                set(pr.get('EDITFIELD_FACEALPHA'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_FACEALPHA'), 'Enable', pr.get('ENABLE'))
					            end
					            
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('EDGECOLOR'), 'Callback')
					                set(pr.get('BUTTON_EDGECOLOR'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('EDGEALPHA'), 'Callback')
					                set(pr.get('EDITFIELD_EDGEALPHA'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_EDGEALPHA'), 'Enable', pr.get('ENABLE'))
					            end
					            
					        case Category.RESULT
					            value = el.getr(prop);
					
					            if isa(value, 'NoValue')
					                set(pr.get('CHECKBOX_VISIBLE'), ...
					                    'Value', el.get(prop).getPropDefault('VISIBLE'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					
					                set(pr.get('BUTTON_FACECOLOR'), ...
					                    'BackgroundColor', el.get(prop).getPropDefault('FACECOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_FACEALPHA'), ...
					                    'Value', el.get(prop).getPropDefault('FACEALPHA'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_FACEALPHA'), ...
					                    'Value', el.get(prop).getPropDefault('FACEALPHA'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                
					                set(pr.get('BUTTON_EDGECOLOR'), ...
					                    'BackgroundColor', el.get(prop).getPropDefault('EDGECOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_EDGEALPHA'), ...
					                    'Value', el.get(prop).getPropDefault('EDGEALPHA'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_EDGEALPHA'), ...
					                    'Value', el.get(prop).getPropDefault('EDGEALPHA'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            else
					                set(pr.get('CHECKBOX_VISIBLE'), ...
					                    'Value', el.get(prop).get('VISIBLE'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                
					                set(pr.get('BUTTON_FACECOLOR'), ...
					                    'BackgroundColor', el.get(prop).get('FACECOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_FACEALPHA'), ...
					                    'Value', el.get(prop).get('FACEALPHA'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_FACEALPHA'), ...
					                    'Value', el.get(prop).get('FACEALPHA'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					
					                set(pr.get('BUTTON_EDGECOLOR'), ...
					                    'BackgroundColor', el.get(prop).get('EDGECOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_EDGEALPHA'), ...
					                    'Value', el.get(prop).get('EDGEALPHA'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_EDGEALPHA'), ...
					                    'Value', el.get(prop).get('EDGEALPHA'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					    end
					end
					
				case SettingsAreaPP.REDRAW % __SettingsAreaPP.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('CHECKBOX_VISIBLE'), 'Position', [s(.3) s(5.7) .30*w_p s(1.7)])
					
					    set(pr.get('BUTTON_FACECOLOR'),    'Position', [s(.3)                  s(3.2)  .20*w_p   s(1.7)])
					    set(pr.get('EDITFIELD_FACEALPHA'), 'Position', [s(.6)+.20*w_p          s(3.2)  .15*w_p   s(1.7)])
					    set(pr.get('SLIDER_FACEALPHA'),    'Position', [s(.6)+.35*w_p+s(1.7)   s(4.75) .50*w_p   3]) % the height of a slider cannot be changed
					
					    set(pr.get('BUTTON_EDGECOLOR'),    'Position', [s(.3)                  s(.7)   .20*w_p   s(1.7)])
					    set(pr.get('EDITFIELD_EDGEALPHA'), 'Position', [s(.6)+.20*w_p          s(.7)   .15*w_p   s(1.7)])
					    set(pr.get('SLIDER_EDGEALPHA'),    'Position', [s(.6)+.35*w_p+s(1.7)   s(2.25) .50*w_p   3]) % the height of a slider cannot be changed
					end
					
				case SettingsAreaPP.DELETE % __SettingsAreaPP.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('CHECKBOX_VISIBLE', Element.getNoValue())
					
					    pr.set('BUTTON_FACECOLOR', Element.getNoValue())
					    pr.set('EDITFIELD_FACEALPHA', Element.getNoValue())
					    pr.set('SLIDER_FACEALPHA', Element.getNoValue())
					
					    pr.set('BUTTON_EDGECOLOR', Element.getNoValue())
					    pr.set('EDITFIELD_EDGEALPHA', Element.getNoValue())
					    pr.set('SLIDER_EDGEALPHA', Element.getNoValue())
					end
					
				otherwise
					if prop <= SettingsPP.getPropNumber()
						value = calculateValue@SettingsPP(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_visible(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('VISIBLE', get(pr.get('CHECKBOX_VISIBLE'), 'Value'))
			end
			function cb_button_facecolor(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    new_color = uisetcolor(el.get(prop).get('FACECOLOR'));
			    if ~isequal(new_color, el.get(prop).get('FACECOLOR'))
			        el.get(prop).set('FACECOLOR', new_color)
			
			        pr.get('UPDATE')
			    end
			end
			function cb_editfield_facealpha(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('FACEALPHA', get(pr.get('EDITFIELD_FACEALPHA'), 'Value'))
			
				pr.get('UPDATE')
			end
			function cb_slider_facealpha(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('FACEALPHA', get(pr.get('SLIDER_FACEALPHA'), 'Value'))
			
				pr.get('UPDATE')
			end
			function cb_button_edgecolor(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    new_color = uisetcolor(el.get(prop).get('EDGECOLOR'));
			    if ~isequal(new_color, el.get(prop).get('EDGECOLOR'))
			        el.get(prop).set('EDGECOLOR', new_color)
			
			        pr.get('UPDATE')
			    end
			end
			function cb_editfield_edgealpha(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('EDGEALPHA', get(pr.get('EDITFIELD_EDGEALPHA'), 'Value'))
			
				pr.get('UPDATE')
			end
			function cb_slider_edgealpha(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('EDGEALPHA', get(pr.get('SLIDER_EDGEALPHA'), 'Value'))
			    
				pr.get('UPDATE')
			end
		end
	end
end
