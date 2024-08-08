classdef SettingsLinePP < SettingsPP
	%SettingsLinePP is the panel with line settings.
	% It is a subclass of <a href="matlab:help SettingsPP">SettingsPP</a>.
	%
	% A Prop Panel for Line Settings (SettingsLinePP) plots the panel for 
	%  line settings, including visibility, line style, size and color, 
	%  and symbol style, size, edge color, and face color.
	% It works for all categories.
	%
	% SettingsLinePP methods (constructor):
	%  SettingsLinePP - constructor
	%
	% SettingsLinePP methods:
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
	% SettingsLinePP methods (display):
	%  tostring - string with information about the prop panel for line settings
	%  disp - displays information about the prop panel for line settings
	%  tree - displays the tree of the prop panel for line settings
	%
	% SettingsLinePP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two prop panel for line settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the prop panel for line settings
	%
	% SettingsLinePP methods (save/load, Static):
	%  save - saves BRAPH2 prop panel for line settings as b2 file
	%  load - loads a BRAPH2 prop panel for line settings from a b2 file
	%
	% SettingsLinePP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the prop panel for line settings
	%
	% SettingsLinePP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the prop panel for line settings
	%
	% SettingsLinePP methods (inspection, Static):
	%  getClass - returns the class of the prop panel for line settings
	%  getSubclasses - returns all subclasses of SettingsLinePP
	%  getProps - returns the property list of the prop panel for line settings
	%  getPropNumber - returns the property number of the prop panel for line settings
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
	% SettingsLinePP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsLinePP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsLinePP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsLinePP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsLinePP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsLinePP constants</a>.
	%
	%
	% See also SettingsLine, uicheckbox, uidropdown, uieditfield, uipushbutton.
	
	properties (Constant) % properties
		ENABLE = SettingsPP.getPropNumber() + 1;
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = Category.GUI;
		ENABLE_FORMAT = Format.LOGICAL;
		
		CHECKBOX_VISIBLE = SettingsPP.getPropNumber() + 2;
		CHECKBOX_VISIBLE_TAG = 'CHECKBOX_VISIBLE';
		CHECKBOX_VISIBLE_CATEGORY = Category.EVANESCENT;
		CHECKBOX_VISIBLE_FORMAT = Format.HANDLE;
		
		DROPDOWN_LINESTYLE = SettingsPP.getPropNumber() + 3;
		DROPDOWN_LINESTYLE_TAG = 'DROPDOWN_LINESTYLE';
		DROPDOWN_LINESTYLE_CATEGORY = Category.EVANESCENT;
		DROPDOWN_LINESTYLE_FORMAT = Format.HANDLE;
		
		EDITFIELD_LINEWIDTH = SettingsPP.getPropNumber() + 4;
		EDITFIELD_LINEWIDTH_TAG = 'EDITFIELD_LINEWIDTH';
		EDITFIELD_LINEWIDTH_CATEGORY = Category.EVANESCENT;
		EDITFIELD_LINEWIDTH_FORMAT = Format.HANDLE;
		
		BUTTON_LINECOLOR = SettingsPP.getPropNumber() + 5;
		BUTTON_LINECOLOR_TAG = 'BUTTON_LINECOLOR';
		BUTTON_LINECOLOR_CATEGORY = Category.EVANESCENT;
		BUTTON_LINECOLOR_FORMAT = Format.HANDLE;
		
		DROPDOWN_SYMBOL = SettingsPP.getPropNumber() + 6;
		DROPDOWN_SYMBOL_TAG = 'DROPDOWN_SYMBOL';
		DROPDOWN_SYMBOL_CATEGORY = Category.EVANESCENT;
		DROPDOWN_SYMBOL_FORMAT = Format.HANDLE;
		
		EDITFIELD_SYMBOLSIZE = SettingsPP.getPropNumber() + 7;
		EDITFIELD_SYMBOLSIZE_TAG = 'EDITFIELD_SYMBOLSIZE';
		EDITFIELD_SYMBOLSIZE_CATEGORY = Category.EVANESCENT;
		EDITFIELD_SYMBOLSIZE_FORMAT = Format.HANDLE;
		
		BUTTON_FACECOLOR = SettingsPP.getPropNumber() + 8;
		BUTTON_FACECOLOR_TAG = 'BUTTON_FACECOLOR';
		BUTTON_FACECOLOR_CATEGORY = Category.EVANESCENT;
		BUTTON_FACECOLOR_FORMAT = Format.HANDLE;
		
		BUTTON_EDGECOLOR = SettingsPP.getPropNumber() + 9;
		BUTTON_EDGECOLOR_TAG = 'BUTTON_EDGECOLOR';
		BUTTON_EDGECOLOR_CATEGORY = Category.EVANESCENT;
		BUTTON_EDGECOLOR_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = SettingsLinePP(varargin)
			%SettingsLinePP() creates a prop panel for line settings.
			%
			% SettingsLinePP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsLinePP(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the prop panel for line settings.
			%
			% CLASS = SettingsLinePP.GETCLASS() returns the class 'SettingsLinePP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the prop panel for line settings PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('SettingsLinePP') returns 'SettingsLinePP'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('SettingsLinePP')
			%  are less computationally efficient.
			
			pr_class = 'SettingsLinePP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the prop panel for line settings.
			%
			% LIST = SettingsLinePP.GETSUBCLASSES() returns all subclasses of 'SettingsLinePP'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the prop panel for line settings PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('SettingsLinePP') returns all subclasses of 'SettingsLinePP'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SettingsLinePP', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of prop panel for line settings.
			%
			% PROPS = SettingsLinePP.GETPROPS() returns the property list of prop panel for line settings
			%  as a row vector.
			%
			% PROPS = SettingsLinePP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the prop panel for line settings PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('SettingsLinePP'[, CATEGORY]) returns the property list of 'SettingsLinePP'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					SettingsPP.getProps() ...
						SettingsLinePP.ENABLE ...
						SettingsLinePP.CHECKBOX_VISIBLE ...
						SettingsLinePP.DROPDOWN_LINESTYLE ...
						SettingsLinePP.EDITFIELD_LINEWIDTH ...
						SettingsLinePP.BUTTON_LINECOLOR ...
						SettingsLinePP.DROPDOWN_SYMBOL ...
						SettingsLinePP.EDITFIELD_SYMBOLSIZE ...
						SettingsLinePP.BUTTON_FACECOLOR ...
						SettingsLinePP.BUTTON_EDGECOLOR ...
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
						SettingsLinePP.CHECKBOX_VISIBLE ...
						SettingsLinePP.DROPDOWN_LINESTYLE ...
						SettingsLinePP.EDITFIELD_LINEWIDTH ...
						SettingsLinePP.BUTTON_LINECOLOR ...
						SettingsLinePP.DROPDOWN_SYMBOL ...
						SettingsLinePP.EDITFIELD_SYMBOLSIZE ...
						SettingsLinePP.BUTTON_FACECOLOR ...
						SettingsLinePP.BUTTON_EDGECOLOR ...
						];
				case Category.FIGURE
					prop_list = [ ...
						SettingsPP.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						SettingsPP.getProps(Category.GUI) ...
						SettingsLinePP.ENABLE ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of prop panel for line settings.
			%
			% N = SettingsLinePP.GETPROPNUMBER() returns the property number of prop panel for line settings.
			%
			% N = SettingsLinePP.GETPROPNUMBER(CATEGORY) returns the property number of prop panel for line settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the prop panel for line settings PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('SettingsLinePP') returns the property number of 'SettingsLinePP'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SettingsLinePP.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in prop panel for line settings/error.
			%
			% CHECK = SettingsLinePP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(SettingsLinePP, PROP) checks whether PROP exists for SettingsLinePP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsLinePP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsLinePP:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsLinePP:WrongInput]
			%  Element.EXISTSPROP(SettingsLinePP, PROP) throws error if PROP does NOT exist for SettingsLinePP.
			%   Error id: [BRAPH2:SettingsLinePP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SettingsLinePP.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsLinePP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsLinePP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsLinePP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in prop panel for line settings/error.
			%
			% CHECK = SettingsLinePP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(SettingsLinePP, TAG) checks whether TAG exists for SettingsLinePP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsLinePP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsLinePP:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsLinePP:WrongInput]
			%  Element.EXISTSTAG(SettingsLinePP, TAG) throws error if TAG does NOT exist for SettingsLinePP.
			%   Error id: [BRAPH2:SettingsLinePP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			settingslinepp_tag_list = cellfun(@(x) SettingsLinePP.getPropTag(x), num2cell(SettingsLinePP.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, settingslinepp_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsLinePP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsLinePP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SettingsLinePP.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsLinePP, POINTER) returns property number of POINTER of SettingsLinePP.
			%  PROPERTY = PR.GETPROPPROP(SettingsLinePP, POINTER) returns property number of POINTER of SettingsLinePP.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				settingslinepp_tag_list = cellfun(@(x) SettingsLinePP.getPropTag(x), num2cell(SettingsLinePP.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, settingslinepp_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(SettingsLinePP, POINTER) returns tag of POINTER of SettingsLinePP.
			%  TAG = PR.GETPROPTAG(SettingsLinePP, POINTER) returns tag of POINTER of SettingsLinePP.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SettingsLinePP.ENABLE
						tag = SettingsLinePP.ENABLE_TAG;
					case SettingsLinePP.CHECKBOX_VISIBLE
						tag = SettingsLinePP.CHECKBOX_VISIBLE_TAG;
					case SettingsLinePP.DROPDOWN_LINESTYLE
						tag = SettingsLinePP.DROPDOWN_LINESTYLE_TAG;
					case SettingsLinePP.EDITFIELD_LINEWIDTH
						tag = SettingsLinePP.EDITFIELD_LINEWIDTH_TAG;
					case SettingsLinePP.BUTTON_LINECOLOR
						tag = SettingsLinePP.BUTTON_LINECOLOR_TAG;
					case SettingsLinePP.DROPDOWN_SYMBOL
						tag = SettingsLinePP.DROPDOWN_SYMBOL_TAG;
					case SettingsLinePP.EDITFIELD_SYMBOLSIZE
						tag = SettingsLinePP.EDITFIELD_SYMBOLSIZE_TAG;
					case SettingsLinePP.BUTTON_FACECOLOR
						tag = SettingsLinePP.BUTTON_FACECOLOR_TAG;
					case SettingsLinePP.BUTTON_EDGECOLOR
						tag = SettingsLinePP.BUTTON_EDGECOLOR_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsLinePP, POINTER) returns category of POINTER of SettingsLinePP.
			%  CATEGORY = PR.GETPROPCATEGORY(SettingsLinePP, POINTER) returns category of POINTER of SettingsLinePP.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsLinePP.getPropProp(pointer);
			
			switch prop
				case SettingsLinePP.ENABLE
					prop_category = SettingsLinePP.ENABLE_CATEGORY;
				case SettingsLinePP.CHECKBOX_VISIBLE
					prop_category = SettingsLinePP.CHECKBOX_VISIBLE_CATEGORY;
				case SettingsLinePP.DROPDOWN_LINESTYLE
					prop_category = SettingsLinePP.DROPDOWN_LINESTYLE_CATEGORY;
				case SettingsLinePP.EDITFIELD_LINEWIDTH
					prop_category = SettingsLinePP.EDITFIELD_LINEWIDTH_CATEGORY;
				case SettingsLinePP.BUTTON_LINECOLOR
					prop_category = SettingsLinePP.BUTTON_LINECOLOR_CATEGORY;
				case SettingsLinePP.DROPDOWN_SYMBOL
					prop_category = SettingsLinePP.DROPDOWN_SYMBOL_CATEGORY;
				case SettingsLinePP.EDITFIELD_SYMBOLSIZE
					prop_category = SettingsLinePP.EDITFIELD_SYMBOLSIZE_CATEGORY;
				case SettingsLinePP.BUTTON_FACECOLOR
					prop_category = SettingsLinePP.BUTTON_FACECOLOR_CATEGORY;
				case SettingsLinePP.BUTTON_EDGECOLOR
					prop_category = SettingsLinePP.BUTTON_EDGECOLOR_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsLinePP, POINTER) returns format of POINTER of SettingsLinePP.
			%  FORMAT = PR.GETPROPFORMAT(SettingsLinePP, POINTER) returns format of POINTER of SettingsLinePP.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsLinePP.getPropProp(pointer);
			
			switch prop
				case SettingsLinePP.ENABLE
					prop_format = SettingsLinePP.ENABLE_FORMAT;
				case SettingsLinePP.CHECKBOX_VISIBLE
					prop_format = SettingsLinePP.CHECKBOX_VISIBLE_FORMAT;
				case SettingsLinePP.DROPDOWN_LINESTYLE
					prop_format = SettingsLinePP.DROPDOWN_LINESTYLE_FORMAT;
				case SettingsLinePP.EDITFIELD_LINEWIDTH
					prop_format = SettingsLinePP.EDITFIELD_LINEWIDTH_FORMAT;
				case SettingsLinePP.BUTTON_LINECOLOR
					prop_format = SettingsLinePP.BUTTON_LINECOLOR_FORMAT;
				case SettingsLinePP.DROPDOWN_SYMBOL
					prop_format = SettingsLinePP.DROPDOWN_SYMBOL_FORMAT;
				case SettingsLinePP.EDITFIELD_SYMBOLSIZE
					prop_format = SettingsLinePP.EDITFIELD_SYMBOLSIZE_FORMAT;
				case SettingsLinePP.BUTTON_FACECOLOR
					prop_format = SettingsLinePP.BUTTON_FACECOLOR_FORMAT;
				case SettingsLinePP.BUTTON_EDGECOLOR
					prop_format = SettingsLinePP.BUTTON_EDGECOLOR_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsLinePP, POINTER) returns description of POINTER of SettingsLinePP.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(SettingsLinePP, POINTER) returns description of POINTER of SettingsLinePP.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsLinePP.getPropProp(pointer);
			
			switch prop
				case SettingsLinePP.ENABLE
					prop_description = 'ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.';
				case SettingsLinePP.CHECKBOX_VISIBLE
					prop_description = 'CHECKBOX_VISIBLE (evanescent, handle) determines whether the line is visible.';
				case SettingsLinePP.DROPDOWN_LINESTYLE
					prop_description = 'DROPDOWN_LINESTYLE (evanescent, handle) is the line style dropdown.';
				case SettingsLinePP.EDITFIELD_LINEWIDTH
					prop_description = 'EDITFIELD_LINEWIDTH (evanescent, handle) is the line width edit field.';
				case SettingsLinePP.BUTTON_LINECOLOR
					prop_description = 'BUTTON_LINECOLOR (evanescent, handle) is the line color button.';
				case SettingsLinePP.DROPDOWN_SYMBOL
					prop_description = 'DROPDOWN_SYMBOL (evanescent, handle) is the marker value dropdown.';
				case SettingsLinePP.EDITFIELD_SYMBOLSIZE
					prop_description = 'EDITFIELD_SYMBOLSIZE (evanescent, handle) is the symbol size edit field.';
				case SettingsLinePP.BUTTON_FACECOLOR
					prop_description = 'BUTTON_FACECOLOR (evanescent, handle) is the marker face color button.';
				case SettingsLinePP.BUTTON_EDGECOLOR
					prop_description = 'BUTTON_EDGECOLOR (evanescent, handle) is the marker edge color button.';
				case SettingsLinePP.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the property panel for line settings.';
				case SettingsLinePP.NAME
					prop_description = 'NAME (constant, string) is the name of the property panel for line settings.';
				case SettingsLinePP.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the property panel for line settings.';
				case SettingsLinePP.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the property panel for line settings.';
				case SettingsLinePP.ID
					prop_description = 'ID (data, string) is a few-letter code for the property panel for line settings.';
				case SettingsLinePP.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the property panel for line settings.';
				case SettingsLinePP.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the property panel for line settings.';
				case SettingsLinePP.EL
					prop_description = 'EL (data, item) is the element.';
				case SettingsLinePP.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case SettingsLinePP.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the settings position panel.';
				case SettingsLinePP.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case SettingsLinePP.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.';
				case SettingsLinePP.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case SettingsLinePP.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsLinePP, POINTER) returns settings of POINTER of SettingsLinePP.
			%  SETTINGS = PR.GETPROPSETTINGS(SettingsLinePP, POINTER) returns settings of POINTER of SettingsLinePP.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsLinePP.getPropProp(pointer);
			
			switch prop
				case SettingsLinePP.ENABLE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SettingsLinePP.CHECKBOX_VISIBLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsLinePP.DROPDOWN_LINESTYLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsLinePP.EDITFIELD_LINEWIDTH
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsLinePP.BUTTON_LINECOLOR
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsLinePP.DROPDOWN_SYMBOL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsLinePP.EDITFIELD_SYMBOLSIZE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsLinePP.BUTTON_FACECOLOR
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsLinePP.BUTTON_EDGECOLOR
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsLinePP.TEMPLATE
					prop_settings = 'SettingsLinePP';
				otherwise
					prop_settings = getPropSettings@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsLinePP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsLinePP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsLinePP, POINTER) returns the default value of POINTER of SettingsLinePP.
			%  DEFAULT = PR.GETPROPDEFAULT(SettingsLinePP, POINTER) returns the default value of POINTER of SettingsLinePP.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsLinePP.getPropProp(pointer);
			
			switch prop
				case SettingsLinePP.ENABLE
					prop_default = true;
				case SettingsLinePP.CHECKBOX_VISIBLE
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsLinePP.getPropSettings(prop));
				case SettingsLinePP.DROPDOWN_LINESTYLE
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsLinePP.getPropSettings(prop));
				case SettingsLinePP.EDITFIELD_LINEWIDTH
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsLinePP.getPropSettings(prop));
				case SettingsLinePP.BUTTON_LINECOLOR
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsLinePP.getPropSettings(prop));
				case SettingsLinePP.DROPDOWN_SYMBOL
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsLinePP.getPropSettings(prop));
				case SettingsLinePP.EDITFIELD_SYMBOLSIZE
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsLinePP.getPropSettings(prop));
				case SettingsLinePP.BUTTON_FACECOLOR
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsLinePP.getPropSettings(prop));
				case SettingsLinePP.BUTTON_EDGECOLOR
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsLinePP.getPropSettings(prop));
				case SettingsLinePP.ELCLASS
					prop_default = 'SettingsLinePP';
				case SettingsLinePP.NAME
					prop_default = 'Prop Panel for Line Settings';
				case SettingsLinePP.DESCRIPTION
					prop_default = 'A Prop Panel for Line Settings (SettingsLinePP) plots the panel for line settings, including visibility, line style, size and color, and symbol style, size, edge color, and face color. It works for all categories.';
				case SettingsLinePP.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, SettingsLinePP.getPropSettings(prop));
				case SettingsLinePP.ID
					prop_default = 'SettingsLinePP ID';
				case SettingsLinePP.LABEL
					prop_default = 'SettingsLinePP label';
				case SettingsLinePP.NOTES
					prop_default = 'SettingsLinePP notes';
				case SettingsLinePP.EL
					prop_default = GraphHistPF();
				case SettingsLinePP.PROP
					prop_default = GraphHistPF.ST_DENSITY_LINE;
				case SettingsLinePP.HEIGHT
					prop_default = s(9.2);
				otherwise
					prop_default = getPropDefault@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsLinePP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsLinePP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsLinePP, POINTER) returns the conditioned default value of POINTER of SettingsLinePP.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(SettingsLinePP, POINTER) returns the conditioned default value of POINTER of SettingsLinePP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsLinePP.getPropProp(pointer);
			
			prop_default = SettingsLinePP.conditioning(prop, SettingsLinePP.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsLinePP, PROP, VALUE) checks VALUE format for PROP of SettingsLinePP.
			%  CHECK = PR.CHECKPROP(SettingsLinePP, PROP, VALUE) checks VALUE format for PROP of SettingsLinePP.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SettingsLinePP:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:SettingsLinePP:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SettingsLinePP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsLinePP.
			%   Error id: €BRAPH2.STR€:SettingsLinePP:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(SettingsLinePP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsLinePP.
			%   Error id: €BRAPH2.STR€:SettingsLinePP:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('SettingsLinePP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsLinePP.getPropProp(pointer);
			
			switch prop
				case SettingsLinePP.ENABLE % __SettingsLinePP.ENABLE__
					check = Format.checkFormat(Format.LOGICAL, value, SettingsLinePP.getPropSettings(prop));
				case SettingsLinePP.CHECKBOX_VISIBLE % __SettingsLinePP.CHECKBOX_VISIBLE__
					check = Format.checkFormat(Format.HANDLE, value, SettingsLinePP.getPropSettings(prop));
				case SettingsLinePP.DROPDOWN_LINESTYLE % __SettingsLinePP.DROPDOWN_LINESTYLE__
					check = Format.checkFormat(Format.HANDLE, value, SettingsLinePP.getPropSettings(prop));
				case SettingsLinePP.EDITFIELD_LINEWIDTH % __SettingsLinePP.EDITFIELD_LINEWIDTH__
					check = Format.checkFormat(Format.HANDLE, value, SettingsLinePP.getPropSettings(prop));
				case SettingsLinePP.BUTTON_LINECOLOR % __SettingsLinePP.BUTTON_LINECOLOR__
					check = Format.checkFormat(Format.HANDLE, value, SettingsLinePP.getPropSettings(prop));
				case SettingsLinePP.DROPDOWN_SYMBOL % __SettingsLinePP.DROPDOWN_SYMBOL__
					check = Format.checkFormat(Format.HANDLE, value, SettingsLinePP.getPropSettings(prop));
				case SettingsLinePP.EDITFIELD_SYMBOLSIZE % __SettingsLinePP.EDITFIELD_SYMBOLSIZE__
					check = Format.checkFormat(Format.HANDLE, value, SettingsLinePP.getPropSettings(prop));
				case SettingsLinePP.BUTTON_FACECOLOR % __SettingsLinePP.BUTTON_FACECOLOR__
					check = Format.checkFormat(Format.HANDLE, value, SettingsLinePP.getPropSettings(prop));
				case SettingsLinePP.BUTTON_EDGECOLOR % __SettingsLinePP.BUTTON_EDGECOLOR__
					check = Format.checkFormat(Format.HANDLE, value, SettingsLinePP.getPropSettings(prop));
				case SettingsLinePP.TEMPLATE % __SettingsLinePP.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, SettingsLinePP.getPropSettings(prop));
				otherwise
					if prop <= SettingsPP.getPropNumber()
						check = checkProp@SettingsPP(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsLinePP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsLinePP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsLinePP.getPropTag(prop) ' (' SettingsLinePP.getFormatTag(SettingsLinePP.getPropFormat(prop)) ').'] ...
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
				case SettingsLinePP.CHECKBOX_VISIBLE % __SettingsLinePP.CHECKBOX_VISIBLE__
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
					
				case SettingsLinePP.DROPDOWN_LINESTYLE % __SettingsLinePP.DROPDOWN_LINESTYLE__
					el = pr.get('EL');
					prop = pr.get('PROP');
					dropdown_linestyle = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN_LINESTYLE', ...
					    'Items', el.get(prop).getPropSettings('LINESTYLE'), ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LINESTYLE')) ' ' el.get(prop).getPropDescription('LINESTYLE')], ...
					    'ValueChangedFcn', {@cb_dropdown_linestyle} ...
					    );
					
					value = dropdown_linestyle;
					
				case SettingsLinePP.EDITFIELD_LINEWIDTH % __SettingsLinePP.EDITFIELD_LINEWIDTH__
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_linewidth = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'EDITFIELD_LINEWIDTH', ...
					    'Limits', [0 +Inf], ...
					    'LowerLimitInclusive', false, ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LINEWIDTH')) ' ' el.get(prop).getPropDescription('LINEWIDTH')], ...
					    'ValueChangedFcn', {@cb_editfield_linewidth} ...
					    );
					
					value = editfield_linewidth;
					
				case SettingsLinePP.BUTTON_LINECOLOR % __SettingsLinePP.BUTTON_LINECOLOR__
					el = pr.get('EL');
					prop = pr.get('PROP');
					button_linecolor = uibutton( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'BUTTON_LINECOLOR', ...
					    'Text', 'line', ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LINECOLOR')) ' ' el.get(prop).getPropDescription('LINECOLOR')], ...
					    'ButtonPushedFcn', {@cb_button_linecolor}, ...
					    'Interruptible', 'off', ...
					    'BusyAction', 'cancel' ...
					    );
					value = button_linecolor;
					
				case SettingsLinePP.DROPDOWN_SYMBOL % __SettingsLinePP.DROPDOWN_SYMBOL__
					el = pr.get('EL');
					prop = pr.get('PROP');
					dropdown_symbol = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN_SYMBOL', ...
					    'Items', el.get(prop).getPropSettings('SYMBOL'), ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('SYMBOL')) ' ' el.get(prop).getPropDescription('SYMBOL')], ...
					    'ValueChangedFcn', {@cb_dropdown_symbol} ...
					    );
					
					value = dropdown_symbol;
					
				case SettingsLinePP.EDITFIELD_SYMBOLSIZE % __SettingsLinePP.EDITFIELD_SYMBOLSIZE__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					editfield_symbolsize = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'EDITFIELD_SYMBOLSIZE', ...
					    'Limits', [0 +Inf], ...
					    'LowerLimitInclusive', false, ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('SYMBOLSIZE')) ' ' el.get(prop).getPropDescription('SYMBOLSIZE')], ...
					    'ValueChangedFcn', {@cb_editfield_symbolsize} ...
					    );
					
					value = editfield_symbolsize;
					
				case SettingsLinePP.BUTTON_FACECOLOR % __SettingsLinePP.BUTTON_FACECOLOR__
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
					
				case SettingsLinePP.BUTTON_EDGECOLOR % __SettingsLinePP.BUTTON_EDGECOLOR__
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
					
				case SettingsLinePP.X_DRAW % __SettingsLinePP.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('CHECKBOX_VISIBLE')
					
					    pr.memorize('DROPDOWN_LINESTYLE')
					    pr.memorize('EDITFIELD_LINEWIDTH')
					    pr.memorize('BUTTON_LINECOLOR')
					    
					    pr.memorize('DROPDOWN_SYMBOL')
					    pr.memorize('EDITFIELD_SYMBOLSIZE')
					    pr.memorize('BUTTON_FACECOLOR')
					    pr.memorize('BUTTON_EDGECOLOR')
					end
					
				case SettingsLinePP.UPDATE % __SettingsLinePP.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    if el.isLocked(prop)
					        set(pr.get('CHECKBOX_VISIBLE'), 'Enable', pr.get('ENABLE'))
					        
					        set(pr.get('DROPDOWN_LINESTYLE'), 'Enable', 'off')
					        set(pr.get('EDITFIELD_LINEWIDTH'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('BUTTON_LINECOLOR'), 'Enable', pr.get('ENABLE'))        
					
					        set(pr.get('DROPDOWN_SYMBOL'), 'Enable', 'off')
					        set(pr.get('EDITFIELD_SYMBOLSIZE'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('BUTTON_FACECOLOR'), 'Enable', pr.get('ENABLE'))        
					        set(pr.get('BUTTON_EDGECOLOR'), 'Enable', pr.get('ENABLE'))
					    end
					
					    switch el.getPropCategory(prop)
					        case Category.METADATA
					            set(pr.get('CHECKBOX_VISIBLE'), 'Value', el.get(prop).get('VISIBLE'))
					            
					            set(pr.get('DROPDOWN_LINESTYLE'), 'Value', el.get(prop).get('LINESTYLE'))
					            set(pr.get('EDITFIELD_LINEWIDTH'), 'Value', el.get(prop).get('LINEWIDTH'))
					            set(pr.get('BUTTON_LINECOLOR'), 'BackgroundColor', el.get(prop).get('LINECOLOR'))
					
					            set(pr.get('DROPDOWN_SYMBOL'), 'Value', el.get(prop).get('SYMBOL'))
					            set(pr.get('EDITFIELD_SYMBOLSIZE'), 'Value', el.get(prop).get('SYMBOLSIZE'))
					            set(pr.get('BUTTON_FACECOLOR'), 'BackgroundColor', el.get(prop).get('FACECOLOR'))
					            set(pr.get('BUTTON_EDGECOLOR'), 'BackgroundColor', el.get(prop).get('EDGECOLOR'))
					            
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('CHECKBOX_VISIBLE'), 'Value', el.get(prop).get('VISIBLE'))
					
					            set(pr.get('DROPDOWN_LINESTYLE'), 'Value', el.get(prop).get('LINESTYLE'))
					            set(pr.get('EDITFIELD_LINEWIDTH'), 'Value', el.get(prop).get('LINEWIDTH'))
					            set(pr.get('BUTTON_LINECOLOR'), 'BackgroundColor', el.get(prop).get('LINECOLOR'))
					
					            set(pr.get('DROPDOWN_SYMBOL'), 'Value', el.get(prop).get('SYMBOL'))
					            set(pr.get('EDITFIELD_SYMBOLSIZE'), 'Value', el.get(prop).get('SYMBOLSIZE'))
					            set(pr.get('BUTTON_FACECOLOR'), 'BackgroundColor', el.get(prop).get('FACECOLOR'))
					            set(pr.get('BUTTON_EDGECOLOR'), 'BackgroundColor', el.get(prop).get('EDGECOLOR'))
					            
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('VISIBLE'), 'Callback')
					                set(pr.get('CHECKBOX_VISIBLE'), 'Enable', pr.get('ENABLE'))
					            end
					            
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('LINESTYLE'), 'Callback')
					                set(pr.get('DROPDOWN_LINESTYLE'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('LINEWIDTH'), 'Callback')
					                set(pr.get('EDITFIELD_LINEWIDTH'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('LINECOLOR'), 'Callback')
					                set(pr.get('BUTTON_LINECOLOR'), 'Enable', pr.get('ENABLE'))
					            end
					            
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('SYMBOL'), 'Callback')
					                set(pr.get('DROPDOWN_SYMBOL'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('SYMBOLSIZE'), 'Callback')
					                set(pr.get('EDITFIELD_SYMBOLSIZE'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end            
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FACECOLOR'), 'Callback')
					                set(pr.get('BUTTON_FACECOLOR'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('EDGECOLOR'), 'Callback')
					                set(pr.get('BUTTON_EDGECOLOR'), 'Enable', pr.get('ENABLE'))
					            end
					            
					        case Category.RESULT
					            value = el.getr(prop);
					
					            if isa(value, 'NoValue')
					                set(pr.get('CHECKBOX_VISIBLE'), ...
					                    'Value', el.get(prop).getPropDefault('VISIBLE'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                
					                set(pr.get('DROPDOWN_LINESTYLE'), ...
					                    'Value', el.get(prop).getPropDefault('LINESTYLE'), ...
					                    'Enable', 'off' ...
					                    )
					                set(pr.get('EDITFIELD_LINEWIDTH'), ...
					                    'Value', el.get(prop).getPropDefault('LINEWIDTH'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('BUTTON_LINECOLOR'), ...
					                    'BackgroundColor', el.get(prop).getPropDefault('LINECOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                
					                set(pr.get('DROPDOWN_SYMBOL'), ...
					                    'Value', el.get(prop).getPropDefault('SYMBOL'), ...
					                    'Enable', 'off' ...
					                    )
					                set(pr.get('EDITFIELD_SYMBOLSIZE'), ...
					                    'Value', el.get(prop).getPropDefault('SYMBOLSIZE'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('BUTTON_FACECOLOR'), ...
					                    'BackgroundColor', el.get(prop).getPropDefault('FACECOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('BUTTON_EDGECOLOR'), ...
					                    'BackgroundColor', el.get(prop).getPropDefault('EDGECOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            else
					                set(pr.get('CHECKBOX_VISIBLE'), ...
					                    'Value', el.get(prop).get('VISIBLE'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                
					                set(pr.get('DROPDOWN_LINESTYLE'), ...
					                    'Value', el.get(prop).get('LINESTYLE'), ...
					                    'Enable', 'off' ...
					                    )
					                set(pr.get('EDITFIELD_LINEWIDTH'), ...
					                    'Value', el.get(prop).get('LINEWIDTH'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('BUTTON_LINECOLOR'), ...
					                    'BackgroundColor', el.get(prop).get('LINECOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					
					                set(pr.get('DROPDOWN_SYMBOL'), ...
					                    'Value', el.get(prop).get('SYMBOL'), ...
					                    'Enable', 'off' ...
					                    )
					                set(pr.get('EDITFIELD_SYMBOLSIZE'), ...
					                    'Value', el.get(prop).get('SYMBOLSIZE'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('BUTTON_FACECOLOR'), ...
					                    'BackgroundColor', el.get(prop).get('FACECOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('BUTTON_EDGECOLOR'), ...
					                    'BackgroundColor', el.get(prop).get('EDGECOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					    end
					end
					
				case SettingsLinePP.REDRAW % __SettingsLinePP.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('CHECKBOX_VISIBLE'), 'Position', [s(.3) s(5.7) .30*w_p s(1.7)])
					
					    set(pr.get('DROPDOWN_LINESTYLE'),   'Position', [s(.3)          s(3.2) .15*w_p s(1.75)])
					    set(pr.get('EDITFIELD_LINEWIDTH'),  'Position', [s(.3)+.20*w_p  s(3.2) .15*w_p s(1.75)])
					    set(pr.get('BUTTON_LINECOLOR'),     'Position', [s(.3)+.40*w_p  s(3.2) .20*w_p s(1.7)])
					    
					    set(pr.get('DROPDOWN_SYMBOL'),      'Position', [s(.3)          s(.7) .15*w_p s(1.75)])
					    set(pr.get('EDITFIELD_SYMBOLSIZE'), 'Position', [s(.3)+.20*w_p  s(.7) .15*w_p s(1.75)])
					    set(pr.get('BUTTON_FACECOLOR'),     'Position', [s(.3)+.40*w_p  s(.7) .20*w_p s(1.7)])
					    set(pr.get('BUTTON_EDGECOLOR'),     'Position', [s(.3)+.65*w_p  s(.7) .20*w_p s(1.7)])
					end
					
				case SettingsLinePP.DELETE % __SettingsLinePP.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
						pr.set('CHECKBOX_VISIBLE', Element.getNoValue())
					    
					    pr.set('DROPDOWN_LINESTYLE', Element.getNoValue())
					    pr.set('EDITFIELD_LINEWIDTH', Element.getNoValue())
					    pr.set('BUTTON_LINECOLOR', Element.getNoValue())
					    
					    pr.set('DROPDOWN_SYMBOL', Element.getNoValue())
					    pr.set('EDITFIELD_SYMBOLSIZE', Element.getNoValue())
					    pr.set('BUTTON_FACECOLOR', Element.getNoValue())
					    pr.set('BUTTON_EDGECOLOR', Element.getNoValue())
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
			function cb_dropdown_linestyle(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('LINESTYLE', get(pr.get('DROPDOWN_LINESTYLE'), 'Value'))
			end
			function cb_editfield_linewidth(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('LINEWIDTH', get(pr.get('EDITFIELD_LINEWIDTH'), 'Value'))
			end
			function cb_button_linecolor(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    new_color = uisetcolor(el.get(prop).get('LINECOLOR'));
			    if ~isequal(new_color, el.get(prop).get('LINECOLOR'))
			        el.get(prop).set('LINECOLOR', new_color)
			
			        pr.get('UPDATE')
			    end
			end
			function cb_dropdown_symbol(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('SYMBOL', get(pr.get('DROPDOWN_SYMBOL'), 'Value'))
			end
			function cb_editfield_symbolsize(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    el.get(prop).set('SYMBOLSIZE', get(pr.get('EDITFIELD_SYMBOLSIZE'), 'Value'))
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
			function cb_button_edgecolor(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    new_color = uisetcolor(el.get(prop).get('EDGECOLOR'));
			    if ~isequal(new_color, el.get(prop).get('EDGECOLOR'))
			        el.get(prop).set('EDGECOLOR', new_color)
			
			        pr.get('UPDATE')
			    end
			end
		end
	end
end
