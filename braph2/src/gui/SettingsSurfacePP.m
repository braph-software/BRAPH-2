classdef SettingsSurfacePP < SettingsPP
	%SettingsSurfacePP is the panel with surface settings.
	% It is a subclass of <a href="matlab:help SettingsPP">SettingsPP</a>.
	%
	% A Prop Panel for Surface Settings (SettingsSurfacePP) plots the panel 
	%  for surface settings, including face color, face alpha, edge color, 
	%  and edge alpha.
	% It works for all categories.
	%
	% SettingsSurfacePP methods (constructor):
	%  SettingsSurfacePP - constructor
	%
	% SettingsSurfacePP methods:
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
	% SettingsSurfacePP methods (display):
	%  tostring - string with information about the prop panel for surface settings
	%  disp - displays information about the prop panel for surface settings
	%  tree - displays the tree of the prop panel for surface settings
	%
	% SettingsSurfacePP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two prop panel for surface settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the prop panel for surface settings
	%
	% SettingsSurfacePP methods (save/load, Static):
	%  save - saves BRAPH2 prop panel for surface settings as b2 file
	%  load - loads a BRAPH2 prop panel for surface settings from a b2 file
	%
	% SettingsSurfacePP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the prop panel for surface settings
	%
	% SettingsSurfacePP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the prop panel for surface settings
	%
	% SettingsSurfacePP methods (inspection, Static):
	%  getClass - returns the class of the prop panel for surface settings
	%  getSubclasses - returns all subclasses of SettingsSurfacePP
	%  getProps - returns the property list of the prop panel for surface settings
	%  getPropNumber - returns the property number of the prop panel for surface settings
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
	% SettingsSurfacePP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsSurfacePP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsSurfacePP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsSurfacePP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsSurfacePP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsSurfacePP constants</a>.
	%
	%
	% See also SettingsPosition, uipushbutton, uieditfield, uislider.
	
	properties (Constant) % properties
		ENABLE = SettingsPP.getPropNumber() + 1;
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = Category.GUI;
		ENABLE_FORMAT = Format.LOGICAL;
		
		BUTTON_FACECOLOR = SettingsPP.getPropNumber() + 2;
		BUTTON_FACECOLOR_TAG = 'BUTTON_FACECOLOR';
		BUTTON_FACECOLOR_CATEGORY = Category.EVANESCENT;
		BUTTON_FACECOLOR_FORMAT = Format.HANDLE;
		
		EDITFIELD_FACEALPHA = SettingsPP.getPropNumber() + 3;
		EDITFIELD_FACEALPHA_TAG = 'EDITFIELD_FACEALPHA';
		EDITFIELD_FACEALPHA_CATEGORY = Category.EVANESCENT;
		EDITFIELD_FACEALPHA_FORMAT = Format.HANDLE;
		
		SLIDER_FACEALPHA = SettingsPP.getPropNumber() + 4;
		SLIDER_FACEALPHA_TAG = 'SLIDER_FACEALPHA';
		SLIDER_FACEALPHA_CATEGORY = Category.EVANESCENT;
		SLIDER_FACEALPHA_FORMAT = Format.HANDLE;
		
		BUTTON_EDGECOLOR = SettingsPP.getPropNumber() + 5;
		BUTTON_EDGECOLOR_TAG = 'BUTTON_EDGECOLOR';
		BUTTON_EDGECOLOR_CATEGORY = Category.EVANESCENT;
		BUTTON_EDGECOLOR_FORMAT = Format.HANDLE;
		
		EDITFIELD_EDGEALPHA = SettingsPP.getPropNumber() + 6;
		EDITFIELD_EDGEALPHA_TAG = 'EDITFIELD_EDGEALPHA';
		EDITFIELD_EDGEALPHA_CATEGORY = Category.EVANESCENT;
		EDITFIELD_EDGEALPHA_FORMAT = Format.HANDLE;
		
		SLIDER_EDGEALPHA = SettingsPP.getPropNumber() + 7;
		SLIDER_EDGEALPHA_TAG = 'SLIDER_EDGEALPHA';
		SLIDER_EDGEALPHA_CATEGORY = Category.EVANESCENT;
		SLIDER_EDGEALPHA_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = SettingsSurfacePP(varargin)
			%SettingsSurfacePP() creates a prop panel for surface settings.
			%
			% SettingsSurfacePP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsSurfacePP(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the prop panel for surface settings.
			%
			% CLASS = SettingsSurfacePP.GETCLASS() returns the class 'SettingsSurfacePP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the prop panel for surface settings PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('SettingsSurfacePP') returns 'SettingsSurfacePP'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('SettingsSurfacePP')
			%  are less computationally efficient.
			
			pr_class = 'SettingsSurfacePP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the prop panel for surface settings.
			%
			% LIST = SettingsSurfacePP.GETSUBCLASSES() returns all subclasses of 'SettingsSurfacePP'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the prop panel for surface settings PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('SettingsSurfacePP') returns all subclasses of 'SettingsSurfacePP'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('SettingsSurfacePP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SettingsSurfacePP', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of prop panel for surface settings.
			%
			% PROPS = SettingsSurfacePP.GETPROPS() returns the property list of prop panel for surface settings
			%  as a row vector.
			%
			% PROPS = SettingsSurfacePP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the prop panel for surface settings PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('SettingsSurfacePP'[, CATEGORY]) returns the property list of 'SettingsSurfacePP'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('SettingsSurfacePP')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					SettingsPP.getProps() ...
						SettingsSurfacePP.ENABLE ...
						SettingsSurfacePP.BUTTON_FACECOLOR ...
						SettingsSurfacePP.EDITFIELD_FACEALPHA ...
						SettingsSurfacePP.SLIDER_FACEALPHA ...
						SettingsSurfacePP.BUTTON_EDGECOLOR ...
						SettingsSurfacePP.EDITFIELD_EDGEALPHA ...
						SettingsSurfacePP.SLIDER_EDGEALPHA ...
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
						SettingsSurfacePP.BUTTON_FACECOLOR ...
						SettingsSurfacePP.EDITFIELD_FACEALPHA ...
						SettingsSurfacePP.SLIDER_FACEALPHA ...
						SettingsSurfacePP.BUTTON_EDGECOLOR ...
						SettingsSurfacePP.EDITFIELD_EDGEALPHA ...
						SettingsSurfacePP.SLIDER_EDGEALPHA ...
						];
				case Category.FIGURE
					prop_list = [ ...
						SettingsPP.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						SettingsPP.getProps(Category.GUI) ...
						SettingsSurfacePP.ENABLE ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of prop panel for surface settings.
			%
			% N = SettingsSurfacePP.GETPROPNUMBER() returns the property number of prop panel for surface settings.
			%
			% N = SettingsSurfacePP.GETPROPNUMBER(CATEGORY) returns the property number of prop panel for surface settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the prop panel for surface settings PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('SettingsSurfacePP') returns the property number of 'SettingsSurfacePP'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('SettingsSurfacePP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SettingsSurfacePP.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in prop panel for surface settings/error.
			%
			% CHECK = SettingsSurfacePP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(SettingsSurfacePP, PROP) checks whether PROP exists for SettingsSurfacePP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsSurfacePP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsSurfacePP:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsSurfacePP:WrongInput]
			%  Element.EXISTSPROP(SettingsSurfacePP, PROP) throws error if PROP does NOT exist for SettingsSurfacePP.
			%   Error id: [BRAPH2:SettingsSurfacePP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('SettingsSurfacePP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SettingsSurfacePP.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsSurfacePP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsSurfacePP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsSurfacePP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in prop panel for surface settings/error.
			%
			% CHECK = SettingsSurfacePP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(SettingsSurfacePP, TAG) checks whether TAG exists for SettingsSurfacePP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsSurfacePP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsSurfacePP:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsSurfacePP:WrongInput]
			%  Element.EXISTSTAG(SettingsSurfacePP, TAG) throws error if TAG does NOT exist for SettingsSurfacePP.
			%   Error id: [BRAPH2:SettingsSurfacePP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('SettingsSurfacePP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			settingssurfacepp_tag_list = cellfun(@(x) SettingsSurfacePP.getPropTag(x), num2cell(SettingsSurfacePP.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, settingssurfacepp_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsSurfacePP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsSurfacePP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SettingsSurfacePP.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsSurfacePP, POINTER) returns property number of POINTER of SettingsSurfacePP.
			%  PROPERTY = PR.GETPROPPROP(SettingsSurfacePP, POINTER) returns property number of POINTER of SettingsSurfacePP.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('SettingsSurfacePP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				settingssurfacepp_tag_list = cellfun(@(x) SettingsSurfacePP.getPropTag(x), num2cell(SettingsSurfacePP.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, settingssurfacepp_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(SettingsSurfacePP, POINTER) returns tag of POINTER of SettingsSurfacePP.
			%  TAG = PR.GETPROPTAG(SettingsSurfacePP, POINTER) returns tag of POINTER of SettingsSurfacePP.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('SettingsSurfacePP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SettingsSurfacePP.ENABLE
						tag = SettingsSurfacePP.ENABLE_TAG;
					case SettingsSurfacePP.BUTTON_FACECOLOR
						tag = SettingsSurfacePP.BUTTON_FACECOLOR_TAG;
					case SettingsSurfacePP.EDITFIELD_FACEALPHA
						tag = SettingsSurfacePP.EDITFIELD_FACEALPHA_TAG;
					case SettingsSurfacePP.SLIDER_FACEALPHA
						tag = SettingsSurfacePP.SLIDER_FACEALPHA_TAG;
					case SettingsSurfacePP.BUTTON_EDGECOLOR
						tag = SettingsSurfacePP.BUTTON_EDGECOLOR_TAG;
					case SettingsSurfacePP.EDITFIELD_EDGEALPHA
						tag = SettingsSurfacePP.EDITFIELD_EDGEALPHA_TAG;
					case SettingsSurfacePP.SLIDER_EDGEALPHA
						tag = SettingsSurfacePP.SLIDER_EDGEALPHA_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsSurfacePP, POINTER) returns category of POINTER of SettingsSurfacePP.
			%  CATEGORY = PR.GETPROPCATEGORY(SettingsSurfacePP, POINTER) returns category of POINTER of SettingsSurfacePP.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('SettingsSurfacePP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsSurfacePP.getPropProp(pointer);
			
			switch prop
				case SettingsSurfacePP.ENABLE
					prop_category = SettingsSurfacePP.ENABLE_CATEGORY;
				case SettingsSurfacePP.BUTTON_FACECOLOR
					prop_category = SettingsSurfacePP.BUTTON_FACECOLOR_CATEGORY;
				case SettingsSurfacePP.EDITFIELD_FACEALPHA
					prop_category = SettingsSurfacePP.EDITFIELD_FACEALPHA_CATEGORY;
				case SettingsSurfacePP.SLIDER_FACEALPHA
					prop_category = SettingsSurfacePP.SLIDER_FACEALPHA_CATEGORY;
				case SettingsSurfacePP.BUTTON_EDGECOLOR
					prop_category = SettingsSurfacePP.BUTTON_EDGECOLOR_CATEGORY;
				case SettingsSurfacePP.EDITFIELD_EDGEALPHA
					prop_category = SettingsSurfacePP.EDITFIELD_EDGEALPHA_CATEGORY;
				case SettingsSurfacePP.SLIDER_EDGEALPHA
					prop_category = SettingsSurfacePP.SLIDER_EDGEALPHA_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsSurfacePP, POINTER) returns format of POINTER of SettingsSurfacePP.
			%  FORMAT = PR.GETPROPFORMAT(SettingsSurfacePP, POINTER) returns format of POINTER of SettingsSurfacePP.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('SettingsSurfacePP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsSurfacePP.getPropProp(pointer);
			
			switch prop
				case SettingsSurfacePP.ENABLE
					prop_format = SettingsSurfacePP.ENABLE_FORMAT;
				case SettingsSurfacePP.BUTTON_FACECOLOR
					prop_format = SettingsSurfacePP.BUTTON_FACECOLOR_FORMAT;
				case SettingsSurfacePP.EDITFIELD_FACEALPHA
					prop_format = SettingsSurfacePP.EDITFIELD_FACEALPHA_FORMAT;
				case SettingsSurfacePP.SLIDER_FACEALPHA
					prop_format = SettingsSurfacePP.SLIDER_FACEALPHA_FORMAT;
				case SettingsSurfacePP.BUTTON_EDGECOLOR
					prop_format = SettingsSurfacePP.BUTTON_EDGECOLOR_FORMAT;
				case SettingsSurfacePP.EDITFIELD_EDGEALPHA
					prop_format = SettingsSurfacePP.EDITFIELD_EDGEALPHA_FORMAT;
				case SettingsSurfacePP.SLIDER_EDGEALPHA
					prop_format = SettingsSurfacePP.SLIDER_EDGEALPHA_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsSurfacePP, POINTER) returns description of POINTER of SettingsSurfacePP.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(SettingsSurfacePP, POINTER) returns description of POINTER of SettingsSurfacePP.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('SettingsSurfacePP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsSurfacePP.getPropProp(pointer);
			
			switch prop
				case SettingsSurfacePP.ENABLE
					prop_description = 'ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.';
				case SettingsSurfacePP.BUTTON_FACECOLOR
					prop_description = 'BUTTON_FACECOLOR (evanescent, handle) is the face color button.';
				case SettingsSurfacePP.EDITFIELD_FACEALPHA
					prop_description = 'EDITFIELD_FACEALPHA (evanescent, handle) is the face alpha edit field.';
				case SettingsSurfacePP.SLIDER_FACEALPHA
					prop_description = 'SLIDER_FACEALPHA (evanescent, handle) is the face alpha slider.';
				case SettingsSurfacePP.BUTTON_EDGECOLOR
					prop_description = 'BUTTON_EDGECOLOR (evanescent, handle) is the edge color button.';
				case SettingsSurfacePP.EDITFIELD_EDGEALPHA
					prop_description = 'EDITFIELD_EDGEALPHA (evanescent, handle) is the edge alpha edit field.';
				case SettingsSurfacePP.SLIDER_EDGEALPHA
					prop_description = 'SLIDER_EDGEALPHA (evanescent, handle) is the edge alpha slider.';
				case SettingsSurfacePP.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the property panel for surface settings.';
				case SettingsSurfacePP.NAME
					prop_description = 'NAME (constant, string) is the name of the property panel for surface settings.';
				case SettingsSurfacePP.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the property panel for surface settings.';
				case SettingsSurfacePP.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the property panel for surface settings.';
				case SettingsSurfacePP.ID
					prop_description = 'ID (data, string) is a few-letter code for the property panel for surface settings.';
				case SettingsSurfacePP.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the property panel for surface settings.';
				case SettingsSurfacePP.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the property panel for surface settings.';
				case SettingsSurfacePP.EL
					prop_description = 'EL (data, item) is the element.';
				case SettingsSurfacePP.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case SettingsSurfacePP.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the property panel for surface settings.';
				case SettingsSurfacePP.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case SettingsSurfacePP.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.';
				case SettingsSurfacePP.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case SettingsSurfacePP.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsSurfacePP, POINTER) returns settings of POINTER of SettingsSurfacePP.
			%  SETTINGS = PR.GETPROPSETTINGS(SettingsSurfacePP, POINTER) returns settings of POINTER of SettingsSurfacePP.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('SettingsSurfacePP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsSurfacePP.getPropProp(pointer);
			
			switch prop
				case SettingsSurfacePP.ENABLE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SettingsSurfacePP.BUTTON_FACECOLOR
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsSurfacePP.EDITFIELD_FACEALPHA
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsSurfacePP.SLIDER_FACEALPHA
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsSurfacePP.BUTTON_EDGECOLOR
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsSurfacePP.EDITFIELD_EDGEALPHA
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsSurfacePP.SLIDER_EDGEALPHA
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsSurfacePP.TEMPLATE
					prop_settings = 'SettingsSurfacePP';
				otherwise
					prop_settings = getPropSettings@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsSurfacePP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsSurfacePP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsSurfacePP, POINTER) returns the default value of POINTER of SettingsSurfacePP.
			%  DEFAULT = PR.GETPROPDEFAULT(SettingsSurfacePP, POINTER) returns the default value of POINTER of SettingsSurfacePP.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('SettingsSurfacePP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsSurfacePP.getPropProp(pointer);
			
			switch prop
				case SettingsSurfacePP.ENABLE
					prop_default = true;
				case SettingsSurfacePP.BUTTON_FACECOLOR
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsSurfacePP.getPropSettings(prop));
				case SettingsSurfacePP.EDITFIELD_FACEALPHA
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsSurfacePP.getPropSettings(prop));
				case SettingsSurfacePP.SLIDER_FACEALPHA
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsSurfacePP.getPropSettings(prop));
				case SettingsSurfacePP.BUTTON_EDGECOLOR
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsSurfacePP.getPropSettings(prop));
				case SettingsSurfacePP.EDITFIELD_EDGEALPHA
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsSurfacePP.getPropSettings(prop));
				case SettingsSurfacePP.SLIDER_EDGEALPHA
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsSurfacePP.getPropSettings(prop));
				case SettingsSurfacePP.ELCLASS
					prop_default = 'SettingsSurfacePP';
				case SettingsSurfacePP.NAME
					prop_default = 'Prop Panel for Surface Settings';
				case SettingsSurfacePP.DESCRIPTION
					prop_default = 'A Prop Panel for Surface Settings (SettingsSurfacePP) plots the panel for surface settings, including face color, face alpha, edge color, and edge alpha. It works for all categories.';
				case SettingsSurfacePP.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, SettingsSurfacePP.getPropSettings(prop));
				case SettingsSurfacePP.ID
					prop_default = 'SettingsSurfacePP ID';
				case SettingsSurfacePP.LABEL
					prop_default = 'SettingsSurfacePP label';
				case SettingsSurfacePP.NOTES
					prop_default = 'SettingsSurfacePP notes';
				case SettingsSurfacePP.EL
					prop_default = BrainSurfacePF();
				case SettingsSurfacePP.PROP
					prop_default = BrainSurfacePF.ST_SURFACE;
				case SettingsSurfacePP.HEIGHT
					prop_default = s(6.7);
				otherwise
					prop_default = getPropDefault@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsSurfacePP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsSurfacePP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsSurfacePP, POINTER) returns the conditioned default value of POINTER of SettingsSurfacePP.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(SettingsSurfacePP, POINTER) returns the conditioned default value of POINTER of SettingsSurfacePP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('SettingsSurfacePP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsSurfacePP.getPropProp(pointer);
			
			prop_default = SettingsSurfacePP.conditioning(prop, SettingsSurfacePP.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsSurfacePP, PROP, VALUE) checks VALUE format for PROP of SettingsSurfacePP.
			%  CHECK = PR.CHECKPROP(SettingsSurfacePP, PROP, VALUE) checks VALUE format for PROP of SettingsSurfacePP.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SettingsSurfacePP:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:SettingsSurfacePP:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SettingsSurfacePP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsSurfacePP.
			%   Error id: €BRAPH2.STR€:SettingsSurfacePP:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(SettingsSurfacePP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsSurfacePP.
			%   Error id: €BRAPH2.STR€:SettingsSurfacePP:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('SettingsSurfacePP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsSurfacePP.getPropProp(pointer);
			
			switch prop
				case SettingsSurfacePP.ENABLE % __SettingsSurfacePP.ENABLE__
					check = Format.checkFormat(Format.LOGICAL, value, SettingsSurfacePP.getPropSettings(prop));
				case SettingsSurfacePP.BUTTON_FACECOLOR % __SettingsSurfacePP.BUTTON_FACECOLOR__
					check = Format.checkFormat(Format.HANDLE, value, SettingsSurfacePP.getPropSettings(prop));
				case SettingsSurfacePP.EDITFIELD_FACEALPHA % __SettingsSurfacePP.EDITFIELD_FACEALPHA__
					check = Format.checkFormat(Format.HANDLE, value, SettingsSurfacePP.getPropSettings(prop));
				case SettingsSurfacePP.SLIDER_FACEALPHA % __SettingsSurfacePP.SLIDER_FACEALPHA__
					check = Format.checkFormat(Format.HANDLE, value, SettingsSurfacePP.getPropSettings(prop));
				case SettingsSurfacePP.BUTTON_EDGECOLOR % __SettingsSurfacePP.BUTTON_EDGECOLOR__
					check = Format.checkFormat(Format.HANDLE, value, SettingsSurfacePP.getPropSettings(prop));
				case SettingsSurfacePP.EDITFIELD_EDGEALPHA % __SettingsSurfacePP.EDITFIELD_EDGEALPHA__
					check = Format.checkFormat(Format.HANDLE, value, SettingsSurfacePP.getPropSettings(prop));
				case SettingsSurfacePP.SLIDER_EDGEALPHA % __SettingsSurfacePP.SLIDER_EDGEALPHA__
					check = Format.checkFormat(Format.HANDLE, value, SettingsSurfacePP.getPropSettings(prop));
				case SettingsSurfacePP.TEMPLATE % __SettingsSurfacePP.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, SettingsSurfacePP.getPropSettings(prop));
				otherwise
					if prop <= SettingsPP.getPropNumber()
						check = checkProp@SettingsPP(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsSurfacePP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsSurfacePP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsSurfacePP.getPropTag(prop) ' (' SettingsSurfacePP.getFormatTag(SettingsSurfacePP.getPropFormat(prop)) ').'] ...
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
				case SettingsSurfacePP.BUTTON_FACECOLOR % __SettingsSurfacePP.BUTTON_FACECOLOR__
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
					
				case SettingsSurfacePP.EDITFIELD_FACEALPHA % __SettingsSurfacePP.EDITFIELD_FACEALPHA__
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
					
				case SettingsSurfacePP.SLIDER_FACEALPHA % __SettingsSurfacePP.SLIDER_FACEALPHA__
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
					
				case SettingsSurfacePP.BUTTON_EDGECOLOR % __SettingsSurfacePP.BUTTON_EDGECOLOR__
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
					
				case SettingsSurfacePP.EDITFIELD_EDGEALPHA % __SettingsSurfacePP.EDITFIELD_EDGEALPHA__
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
					
				case SettingsSurfacePP.SLIDER_EDGEALPHA % __SettingsSurfacePP.SLIDER_EDGEALPHA__
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
					
				case SettingsSurfacePP.X_DRAW % __SettingsSurfacePP.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('BUTTON_FACECOLOR')
					    pr.memorize('EDITFIELD_FACEALPHA')
					    pr.memorize('SLIDER_FACEALPHA')
					
					    pr.memorize('BUTTON_EDGECOLOR')
					    pr.memorize('EDITFIELD_EDGEALPHA')
					    pr.memorize('SLIDER_EDGEALPHA')
					end
					
				case SettingsSurfacePP.UPDATE % __SettingsSurfacePP.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    if el.isLocked(prop)
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
					            set(pr.get('BUTTON_FACECOLOR'), 'BackgroundColor', el.get(prop).get('FACECOLOR'))
					            set(pr.get('EDITFIELD_FACEALPHA'), 'Value', el.get(prop).get('FACEALPHA'))
					            set(pr.get('SLIDER_FACEALPHA'), 'Value', el.get(prop).get('FACEALPHA'))
					            
					            set(pr.get('BUTTON_EDGECOLOR'), 'BackgroundColor', el.get(prop).get('EDGECOLOR'))
					            set(pr.get('EDITFIELD_EDGEALPHA'), 'Value', el.get(prop).get('EDGEALPHA'))
					            set(pr.get('SLIDER_EDGEALPHA'), 'Value', el.get(prop).get('EDGEALPHA'))
					
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('BUTTON_FACECOLOR'), 'BackgroundColor', el.get(prop).get('FACECOLOR'))
					            set(pr.get('EDITFIELD_FACEALPHA'), 'Value', el.get(prop).get('FACEALPHA'))
					            set(pr.get('SLIDER_FACEALPHA'), 'Value', el.get(prop).get('FACEALPHA'))
					
					            set(pr.get('BUTTON_EDGECOLOR'), 'BackgroundColor', el.get(prop).get('EDGECOLOR'))
					            set(pr.get('EDITFIELD_EDGEALPHA'), 'Value', el.get(prop).get('EDGEALPHA'))
					            set(pr.get('SLIDER_EDGEALPHA'), 'Value', el.get(prop).get('EDGEALPHA'))
					
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
					
				case SettingsSurfacePP.REDRAW % __SettingsSurfacePP.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('BUTTON_FACECOLOR'),    'Position', [s(.3)                  s(3.2)  .20*w_p   s(1.7)])
					    set(pr.get('EDITFIELD_FACEALPHA'), 'Position', [s(.6)+.20*w_p          s(3.2)  .15*w_p   s(1.7)])
					    set(pr.get('SLIDER_FACEALPHA'),    'Position', [s(.6)+.35*w_p+s(1.7)   s(4.75) .50*w_p   3]) % the height of a slider cannot be changed
					    
					    set(pr.get('BUTTON_EDGECOLOR'),    'Position', [s(.3)                  s(.7)   .20*w_p   s(1.7)])
					    set(pr.get('EDITFIELD_EDGEALPHA'), 'Position', [s(.6)+.20*w_p          s(.7)   .15*w_p   s(1.7)])
					    set(pr.get('SLIDER_EDGEALPHA'),    'Position', [s(.6)+.35*w_p+s(1.7)   s(2.25) .50*w_p   3]) % the height of a slider cannot be changed
					end
					
				case SettingsSurfacePP.DELETE % __SettingsSurfacePP.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
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
