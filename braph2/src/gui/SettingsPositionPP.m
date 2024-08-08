classdef SettingsPositionPP < SettingsPP
	%SettingsPositionPP is the panel with position settings.
	% It is a subclass of <a href="matlab:help SettingsPP">SettingsPP</a>.
	%
	% A Prop Panel for Position Settings (SettingsPositionPP) plots the panel 
	%  for position settings, including a checkbox for autopositioning 
	%  and numeric edit fields for x0, y0, height and width.
	% It works for all categories.
	%
	% SettingsPositionPP methods (constructor):
	%  SettingsPositionPP - constructor
	%
	% SettingsPositionPP methods:
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
	% SettingsPositionPP methods (display):
	%  tostring - string with information about the prop panel for position settings
	%  disp - displays information about the prop panel for position settings
	%  tree - displays the tree of the prop panel for position settings
	%
	% SettingsPositionPP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two prop panel for position settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the prop panel for position settings
	%
	% SettingsPositionPP methods (save/load, Static):
	%  save - saves BRAPH2 prop panel for position settings as b2 file
	%  load - loads a BRAPH2 prop panel for position settings from a b2 file
	%
	% SettingsPositionPP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the prop panel for position settings
	%
	% SettingsPositionPP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the prop panel for position settings
	%
	% SettingsPositionPP methods (inspection, Static):
	%  getClass - returns the class of the prop panel for position settings
	%  getSubclasses - returns all subclasses of SettingsPositionPP
	%  getProps - returns the property list of the prop panel for position settings
	%  getPropNumber - returns the property number of the prop panel for position settings
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
	% SettingsPositionPP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsPositionPP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsPositionPP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsPositionPP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsPositionPP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsPositionPP constants</a>.
	%
	%
	% See also SettingsPosition, uicheckbox, uieditfield.
	
	properties (Constant) % properties
		ENABLE = SettingsPP.getPropNumber() + 1;
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = Category.GUI;
		ENABLE_FORMAT = Format.LOGICAL;
		
		CHECKBOX_AUTOPOS = SettingsPP.getPropNumber() + 2;
		CHECKBOX_AUTOPOS_TAG = 'CHECKBOX_AUTOPOS';
		CHECKBOX_AUTOPOS_CATEGORY = Category.EVANESCENT;
		CHECKBOX_AUTOPOS_FORMAT = Format.HANDLE;
		
		LABEL_X0 = SettingsPP.getPropNumber() + 3;
		LABEL_X0_TAG = 'LABEL_X0';
		LABEL_X0_CATEGORY = Category.EVANESCENT;
		LABEL_X0_FORMAT = Format.HANDLE;
		
		EDITFIELD_X0 = SettingsPP.getPropNumber() + 4;
		EDITFIELD_X0_TAG = 'EDITFIELD_X0';
		EDITFIELD_X0_CATEGORY = Category.EVANESCENT;
		EDITFIELD_X0_FORMAT = Format.HANDLE;
		
		LABEL_Y0 = SettingsPP.getPropNumber() + 5;
		LABEL_Y0_TAG = 'LABEL_Y0';
		LABEL_Y0_CATEGORY = Category.EVANESCENT;
		LABEL_Y0_FORMAT = Format.HANDLE;
		
		EDITFIELD_Y0 = SettingsPP.getPropNumber() + 6;
		EDITFIELD_Y0_TAG = 'EDITFIELD_Y0';
		EDITFIELD_Y0_CATEGORY = Category.EVANESCENT;
		EDITFIELD_Y0_FORMAT = Format.HANDLE;
		
		LABEL_W = SettingsPP.getPropNumber() + 7;
		LABEL_W_TAG = 'LABEL_W';
		LABEL_W_CATEGORY = Category.EVANESCENT;
		LABEL_W_FORMAT = Format.HANDLE;
		
		EDITFIELD_W = SettingsPP.getPropNumber() + 8;
		EDITFIELD_W_TAG = 'EDITFIELD_W';
		EDITFIELD_W_CATEGORY = Category.EVANESCENT;
		EDITFIELD_W_FORMAT = Format.HANDLE;
		
		LABEL_H = SettingsPP.getPropNumber() + 9;
		LABEL_H_TAG = 'LABEL_H';
		LABEL_H_CATEGORY = Category.EVANESCENT;
		LABEL_H_FORMAT = Format.HANDLE;
		
		EDITFIELD_H = SettingsPP.getPropNumber() + 10;
		EDITFIELD_H_TAG = 'EDITFIELD_H';
		EDITFIELD_H_CATEGORY = Category.EVANESCENT;
		EDITFIELD_H_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = SettingsPositionPP(varargin)
			%SettingsPositionPP() creates a prop panel for position settings.
			%
			% SettingsPositionPP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsPositionPP(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the prop panel for position settings.
			%
			% CLASS = SettingsPositionPP.GETCLASS() returns the class 'SettingsPositionPP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the prop panel for position settings PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('SettingsPositionPP') returns 'SettingsPositionPP'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('SettingsPositionPP')
			%  are less computationally efficient.
			
			pr_class = 'SettingsPositionPP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the prop panel for position settings.
			%
			% LIST = SettingsPositionPP.GETSUBCLASSES() returns all subclasses of 'SettingsPositionPP'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the prop panel for position settings PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('SettingsPositionPP') returns all subclasses of 'SettingsPositionPP'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SettingsPositionPP', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of prop panel for position settings.
			%
			% PROPS = SettingsPositionPP.GETPROPS() returns the property list of prop panel for position settings
			%  as a row vector.
			%
			% PROPS = SettingsPositionPP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the prop panel for position settings PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('SettingsPositionPP'[, CATEGORY]) returns the property list of 'SettingsPositionPP'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					SettingsPP.getProps() ...
						SettingsPositionPP.ENABLE ...
						SettingsPositionPP.CHECKBOX_AUTOPOS ...
						SettingsPositionPP.LABEL_X0 ...
						SettingsPositionPP.EDITFIELD_X0 ...
						SettingsPositionPP.LABEL_Y0 ...
						SettingsPositionPP.EDITFIELD_Y0 ...
						SettingsPositionPP.LABEL_W ...
						SettingsPositionPP.EDITFIELD_W ...
						SettingsPositionPP.LABEL_H ...
						SettingsPositionPP.EDITFIELD_H ...
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
						SettingsPositionPP.CHECKBOX_AUTOPOS ...
						SettingsPositionPP.LABEL_X0 ...
						SettingsPositionPP.EDITFIELD_X0 ...
						SettingsPositionPP.LABEL_Y0 ...
						SettingsPositionPP.EDITFIELD_Y0 ...
						SettingsPositionPP.LABEL_W ...
						SettingsPositionPP.EDITFIELD_W ...
						SettingsPositionPP.LABEL_H ...
						SettingsPositionPP.EDITFIELD_H ...
						];
				case Category.FIGURE
					prop_list = [ ...
						SettingsPP.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						SettingsPP.getProps(Category.GUI) ...
						SettingsPositionPP.ENABLE ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of prop panel for position settings.
			%
			% N = SettingsPositionPP.GETPROPNUMBER() returns the property number of prop panel for position settings.
			%
			% N = SettingsPositionPP.GETPROPNUMBER(CATEGORY) returns the property number of prop panel for position settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the prop panel for position settings PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('SettingsPositionPP') returns the property number of 'SettingsPositionPP'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SettingsPositionPP.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in prop panel for position settings/error.
			%
			% CHECK = SettingsPositionPP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(SettingsPositionPP, PROP) checks whether PROP exists for SettingsPositionPP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsPositionPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsPositionPP:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsPositionPP:WrongInput]
			%  Element.EXISTSPROP(SettingsPositionPP, PROP) throws error if PROP does NOT exist for SettingsPositionPP.
			%   Error id: [BRAPH2:SettingsPositionPP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SettingsPositionPP.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsPositionPP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsPositionPP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsPositionPP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in prop panel for position settings/error.
			%
			% CHECK = SettingsPositionPP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(SettingsPositionPP, TAG) checks whether TAG exists for SettingsPositionPP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsPositionPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsPositionPP:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsPositionPP:WrongInput]
			%  Element.EXISTSTAG(SettingsPositionPP, TAG) throws error if TAG does NOT exist for SettingsPositionPP.
			%   Error id: [BRAPH2:SettingsPositionPP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			settingspositionpp_tag_list = cellfun(@(x) SettingsPositionPP.getPropTag(x), num2cell(SettingsPositionPP.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, settingspositionpp_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsPositionPP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsPositionPP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SettingsPositionPP.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsPositionPP, POINTER) returns property number of POINTER of SettingsPositionPP.
			%  PROPERTY = PR.GETPROPPROP(SettingsPositionPP, POINTER) returns property number of POINTER of SettingsPositionPP.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				settingspositionpp_tag_list = cellfun(@(x) SettingsPositionPP.getPropTag(x), num2cell(SettingsPositionPP.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, settingspositionpp_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(SettingsPositionPP, POINTER) returns tag of POINTER of SettingsPositionPP.
			%  TAG = PR.GETPROPTAG(SettingsPositionPP, POINTER) returns tag of POINTER of SettingsPositionPP.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SettingsPositionPP.ENABLE
						tag = SettingsPositionPP.ENABLE_TAG;
					case SettingsPositionPP.CHECKBOX_AUTOPOS
						tag = SettingsPositionPP.CHECKBOX_AUTOPOS_TAG;
					case SettingsPositionPP.LABEL_X0
						tag = SettingsPositionPP.LABEL_X0_TAG;
					case SettingsPositionPP.EDITFIELD_X0
						tag = SettingsPositionPP.EDITFIELD_X0_TAG;
					case SettingsPositionPP.LABEL_Y0
						tag = SettingsPositionPP.LABEL_Y0_TAG;
					case SettingsPositionPP.EDITFIELD_Y0
						tag = SettingsPositionPP.EDITFIELD_Y0_TAG;
					case SettingsPositionPP.LABEL_W
						tag = SettingsPositionPP.LABEL_W_TAG;
					case SettingsPositionPP.EDITFIELD_W
						tag = SettingsPositionPP.EDITFIELD_W_TAG;
					case SettingsPositionPP.LABEL_H
						tag = SettingsPositionPP.LABEL_H_TAG;
					case SettingsPositionPP.EDITFIELD_H
						tag = SettingsPositionPP.EDITFIELD_H_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsPositionPP, POINTER) returns category of POINTER of SettingsPositionPP.
			%  CATEGORY = PR.GETPROPCATEGORY(SettingsPositionPP, POINTER) returns category of POINTER of SettingsPositionPP.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsPositionPP.getPropProp(pointer);
			
			switch prop
				case SettingsPositionPP.ENABLE
					prop_category = SettingsPositionPP.ENABLE_CATEGORY;
				case SettingsPositionPP.CHECKBOX_AUTOPOS
					prop_category = SettingsPositionPP.CHECKBOX_AUTOPOS_CATEGORY;
				case SettingsPositionPP.LABEL_X0
					prop_category = SettingsPositionPP.LABEL_X0_CATEGORY;
				case SettingsPositionPP.EDITFIELD_X0
					prop_category = SettingsPositionPP.EDITFIELD_X0_CATEGORY;
				case SettingsPositionPP.LABEL_Y0
					prop_category = SettingsPositionPP.LABEL_Y0_CATEGORY;
				case SettingsPositionPP.EDITFIELD_Y0
					prop_category = SettingsPositionPP.EDITFIELD_Y0_CATEGORY;
				case SettingsPositionPP.LABEL_W
					prop_category = SettingsPositionPP.LABEL_W_CATEGORY;
				case SettingsPositionPP.EDITFIELD_W
					prop_category = SettingsPositionPP.EDITFIELD_W_CATEGORY;
				case SettingsPositionPP.LABEL_H
					prop_category = SettingsPositionPP.LABEL_H_CATEGORY;
				case SettingsPositionPP.EDITFIELD_H
					prop_category = SettingsPositionPP.EDITFIELD_H_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsPositionPP, POINTER) returns format of POINTER of SettingsPositionPP.
			%  FORMAT = PR.GETPROPFORMAT(SettingsPositionPP, POINTER) returns format of POINTER of SettingsPositionPP.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsPositionPP.getPropProp(pointer);
			
			switch prop
				case SettingsPositionPP.ENABLE
					prop_format = SettingsPositionPP.ENABLE_FORMAT;
				case SettingsPositionPP.CHECKBOX_AUTOPOS
					prop_format = SettingsPositionPP.CHECKBOX_AUTOPOS_FORMAT;
				case SettingsPositionPP.LABEL_X0
					prop_format = SettingsPositionPP.LABEL_X0_FORMAT;
				case SettingsPositionPP.EDITFIELD_X0
					prop_format = SettingsPositionPP.EDITFIELD_X0_FORMAT;
				case SettingsPositionPP.LABEL_Y0
					prop_format = SettingsPositionPP.LABEL_Y0_FORMAT;
				case SettingsPositionPP.EDITFIELD_Y0
					prop_format = SettingsPositionPP.EDITFIELD_Y0_FORMAT;
				case SettingsPositionPP.LABEL_W
					prop_format = SettingsPositionPP.LABEL_W_FORMAT;
				case SettingsPositionPP.EDITFIELD_W
					prop_format = SettingsPositionPP.EDITFIELD_W_FORMAT;
				case SettingsPositionPP.LABEL_H
					prop_format = SettingsPositionPP.LABEL_H_FORMAT;
				case SettingsPositionPP.EDITFIELD_H
					prop_format = SettingsPositionPP.EDITFIELD_H_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsPositionPP, POINTER) returns description of POINTER of SettingsPositionPP.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(SettingsPositionPP, POINTER) returns description of POINTER of SettingsPositionPP.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsPositionPP.getPropProp(pointer);
			
			switch prop
				case SettingsPositionPP.ENABLE
					prop_description = 'ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.';
				case SettingsPositionPP.CHECKBOX_AUTOPOS
					prop_description = 'CHECKBOX_AUTOPOS (evanescent, handle) is the autopositioning checkbox.';
				case SettingsPositionPP.LABEL_X0
					prop_description = 'LABEL_X0 (evanescent, handle) is the label of the x0 edit field.';
				case SettingsPositionPP.EDITFIELD_X0
					prop_description = 'EDITFIELD_X0 (evanescent, handle) is the x0 edit field.';
				case SettingsPositionPP.LABEL_Y0
					prop_description = 'LABEL_Y0 (evanescent, handle) is the label of the y0 edit field.';
				case SettingsPositionPP.EDITFIELD_Y0
					prop_description = 'EDITFIELD_Y0 (evanescent, handle) is the y0 edit field.';
				case SettingsPositionPP.LABEL_W
					prop_description = 'LABEL_W (evanescent, handle) is the label of the witdth edit field.';
				case SettingsPositionPP.EDITFIELD_W
					prop_description = 'EDITFIELD_W (evanescent, handle) is the width edit field.';
				case SettingsPositionPP.LABEL_H
					prop_description = 'LABEL_H (evanescent, handle) is the label of the height edit field.';
				case SettingsPositionPP.EDITFIELD_H
					prop_description = 'EDITFIELD_H (evanescent, handle) is the height edit field.';
				case SettingsPositionPP.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the property panel for position settings.';
				case SettingsPositionPP.NAME
					prop_description = 'NAME (constant, string) is the name of the property panel for position settings.';
				case SettingsPositionPP.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the property panel for position settings.';
				case SettingsPositionPP.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the property panel for position settings.';
				case SettingsPositionPP.ID
					prop_description = 'ID (data, string) is a few-letter code for the property panel for position settings.';
				case SettingsPositionPP.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the property panel for position settings.';
				case SettingsPositionPP.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the property panel for position settings.';
				case SettingsPositionPP.EL
					prop_description = 'EL (data, item) is the element.';
				case SettingsPositionPP.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case SettingsPositionPP.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the property panel for position settings.';
				case SettingsPositionPP.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case SettingsPositionPP.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the checkbox and editfields.';
				case SettingsPositionPP.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case SettingsPositionPP.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsPositionPP, POINTER) returns settings of POINTER of SettingsPositionPP.
			%  SETTINGS = PR.GETPROPSETTINGS(SettingsPositionPP, POINTER) returns settings of POINTER of SettingsPositionPP.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsPositionPP.getPropProp(pointer);
			
			switch prop
				case SettingsPositionPP.ENABLE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SettingsPositionPP.CHECKBOX_AUTOPOS
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsPositionPP.LABEL_X0
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsPositionPP.EDITFIELD_X0
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsPositionPP.LABEL_Y0
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsPositionPP.EDITFIELD_Y0
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsPositionPP.LABEL_W
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsPositionPP.EDITFIELD_W
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsPositionPP.LABEL_H
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsPositionPP.EDITFIELD_H
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsPositionPP.TEMPLATE
					prop_settings = 'SettingsPositionPP';
				otherwise
					prop_settings = getPropSettings@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsPositionPP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsPositionPP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsPositionPP, POINTER) returns the default value of POINTER of SettingsPositionPP.
			%  DEFAULT = PR.GETPROPDEFAULT(SettingsPositionPP, POINTER) returns the default value of POINTER of SettingsPositionPP.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsPositionPP.getPropProp(pointer);
			
			switch prop
				case SettingsPositionPP.ENABLE
					prop_default = true;
				case SettingsPositionPP.CHECKBOX_AUTOPOS
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsPositionPP.getPropSettings(prop));
				case SettingsPositionPP.LABEL_X0
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsPositionPP.getPropSettings(prop));
				case SettingsPositionPP.EDITFIELD_X0
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsPositionPP.getPropSettings(prop));
				case SettingsPositionPP.LABEL_Y0
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsPositionPP.getPropSettings(prop));
				case SettingsPositionPP.EDITFIELD_Y0
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsPositionPP.getPropSettings(prop));
				case SettingsPositionPP.LABEL_W
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsPositionPP.getPropSettings(prop));
				case SettingsPositionPP.EDITFIELD_W
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsPositionPP.getPropSettings(prop));
				case SettingsPositionPP.LABEL_H
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsPositionPP.getPropSettings(prop));
				case SettingsPositionPP.EDITFIELD_H
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsPositionPP.getPropSettings(prop));
				case SettingsPositionPP.ELCLASS
					prop_default = 'SettingsPositionPP';
				case SettingsPositionPP.NAME
					prop_default = 'Prop Panel for Position Settings';
				case SettingsPositionPP.DESCRIPTION
					prop_default = 'A Prop Panel for Position Settings (SettingsPositionPP) plots the panel for position settings, including a checkbox for autopositioning and numeric edit fields for x0, y0, height and width. It works for all categories.';
				case SettingsPositionPP.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, SettingsPositionPP.getPropSettings(prop));
				case SettingsPositionPP.ID
					prop_default = 'SettingsPositionPP ID';
				case SettingsPositionPP.LABEL
					prop_default = 'SettingsPositionPP label';
				case SettingsPositionPP.NOTES
					prop_default = 'SettingsPositionPP notes';
				case SettingsPositionPP.EL
					prop_default = PanelFig();
				case SettingsPositionPP.PROP
					prop_default = PanelFig.ST_POSITION;
				case SettingsPositionPP.HEIGHT
					prop_default = s(4);
				otherwise
					prop_default = getPropDefault@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsPositionPP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsPositionPP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsPositionPP, POINTER) returns the conditioned default value of POINTER of SettingsPositionPP.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(SettingsPositionPP, POINTER) returns the conditioned default value of POINTER of SettingsPositionPP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsPositionPP.getPropProp(pointer);
			
			prop_default = SettingsPositionPP.conditioning(prop, SettingsPositionPP.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsPositionPP, PROP, VALUE) checks VALUE format for PROP of SettingsPositionPP.
			%  CHECK = PR.CHECKPROP(SettingsPositionPP, PROP, VALUE) checks VALUE format for PROP of SettingsPositionPP.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SettingsPositionPP:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:SettingsPositionPP:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SettingsPositionPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsPositionPP.
			%   Error id: €BRAPH2.STR€:SettingsPositionPP:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(SettingsPositionPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsPositionPP.
			%   Error id: €BRAPH2.STR€:SettingsPositionPP:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('SettingsPositionPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsPositionPP.getPropProp(pointer);
			
			switch prop
				case SettingsPositionPP.ENABLE % __SettingsPositionPP.ENABLE__
					check = Format.checkFormat(Format.LOGICAL, value, SettingsPositionPP.getPropSettings(prop));
				case SettingsPositionPP.CHECKBOX_AUTOPOS % __SettingsPositionPP.CHECKBOX_AUTOPOS__
					check = Format.checkFormat(Format.HANDLE, value, SettingsPositionPP.getPropSettings(prop));
				case SettingsPositionPP.LABEL_X0 % __SettingsPositionPP.LABEL_X0__
					check = Format.checkFormat(Format.HANDLE, value, SettingsPositionPP.getPropSettings(prop));
				case SettingsPositionPP.EDITFIELD_X0 % __SettingsPositionPP.EDITFIELD_X0__
					check = Format.checkFormat(Format.HANDLE, value, SettingsPositionPP.getPropSettings(prop));
				case SettingsPositionPP.LABEL_Y0 % __SettingsPositionPP.LABEL_Y0__
					check = Format.checkFormat(Format.HANDLE, value, SettingsPositionPP.getPropSettings(prop));
				case SettingsPositionPP.EDITFIELD_Y0 % __SettingsPositionPP.EDITFIELD_Y0__
					check = Format.checkFormat(Format.HANDLE, value, SettingsPositionPP.getPropSettings(prop));
				case SettingsPositionPP.LABEL_W % __SettingsPositionPP.LABEL_W__
					check = Format.checkFormat(Format.HANDLE, value, SettingsPositionPP.getPropSettings(prop));
				case SettingsPositionPP.EDITFIELD_W % __SettingsPositionPP.EDITFIELD_W__
					check = Format.checkFormat(Format.HANDLE, value, SettingsPositionPP.getPropSettings(prop));
				case SettingsPositionPP.LABEL_H % __SettingsPositionPP.LABEL_H__
					check = Format.checkFormat(Format.HANDLE, value, SettingsPositionPP.getPropSettings(prop));
				case SettingsPositionPP.EDITFIELD_H % __SettingsPositionPP.EDITFIELD_H__
					check = Format.checkFormat(Format.HANDLE, value, SettingsPositionPP.getPropSettings(prop));
				case SettingsPositionPP.TEMPLATE % __SettingsPositionPP.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, SettingsPositionPP.getPropSettings(prop));
				otherwise
					if prop <= SettingsPP.getPropNumber()
						check = checkProp@SettingsPP(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsPositionPP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsPositionPP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsPositionPP.getPropTag(prop) ' (' SettingsPositionPP.getFormatTag(SettingsPositionPP.getPropFormat(prop)) ').'] ...
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
				case SettingsPositionPP.CHECKBOX_AUTOPOS % __SettingsPositionPP.CHECKBOX_AUTOPOS__
					el = pr.get('EL');
					prop = pr.get('PROP');
					checkbox_autopos = uicheckbox( ...
						'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'CHECKBOX_AUTOPOS', ...
					    'Text', 'auto', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('AUTOPOS')) ' ' el.get(prop).getPropDescription('AUTOPOS')], ...
					    'ValueChangedFcn', {@cb_position} ...
					    );
					value = checkbox_autopos;
					
				case SettingsPositionPP.LABEL_X0 % __SettingsPositionPP.LABEL_X0__
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_x0 =  uilabel( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'LABEL_X0', ...
					    'Text', 'x<sub>0</sub>', ...
					    'Interpreter', 'html', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'HorizontalAlignment', 'right', ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('X0')) ' ' el.get(prop).getPropDescription('X0')], ...
					    'BackgroundColor', pr.get('BKGCOLOR') ...
					    );
					value = label_x0;
					
				case SettingsPositionPP.EDITFIELD_X0 % __SettingsPositionPP.EDITFIELD_X0__
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_x0 = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'EDITFIELD_X0', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('X0')) ' ' el.get(prop).getPropDescription('X0')], ...
					    'ValueChangedFcn', {@cb_position} ... % callback in CHECKBOX_AUTOPOS
					    );
					value = editfield_x0;
					
				case SettingsPositionPP.LABEL_Y0 % __SettingsPositionPP.LABEL_Y0__
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_y0 =  uilabel( ...
						'Parent', pr.memorize('H'), ... % H = p for Panel
						'Tag', 'LABEL_Y0', ...
						'Text', 'y<sub>0</sub>', ...
						'Interpreter', 'html', ...
						'FontSize', BRAPH2.FONTSIZE, ...
						'HorizontalAlignment', 'right', ...
						'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('Y0')) ' ' el.get(prop).getPropDescription('Y0')], ...
						'BackgroundColor', pr.get('BKGCOLOR') ...
						);
					value = label_y0;
					
				case SettingsPositionPP.EDITFIELD_Y0 % __SettingsPositionPP.EDITFIELD_Y0__
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_y0 = uieditfield('numeric', ...
						'Parent', pr.memorize('H'), ... % H = p for Panel
						'Tag', 'EDITFIELD_Y0', ...
						'FontSize', BRAPH2.FONTSIZE, ...
						'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('Y0')) ' ' el.get(prop).getPropDescription('Y0')], ...
						'ValueChangedFcn', {@cb_position} ... % callback in CHECKBOX_AUTOPOS
						);
					value = editfield_y0;
					
				case SettingsPositionPP.LABEL_W % __SettingsPositionPP.LABEL_W__
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_w =  uilabel( ...
						'Parent', pr.memorize('H'), ... % H = p for Panel
						'Tag', 'LABEL_W', ...
						'Text', 'w', ...
						'Interpreter', 'html', ...
						'FontSize', BRAPH2.FONTSIZE, ...
						'HorizontalAlignment', 'right', ...
						'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('WIDTH')) ' ' el.get(prop).getPropDescription('WIDTH')], ...
						'BackgroundColor', pr.get('BKGCOLOR') ...
						);
					value = label_w;
					
				case SettingsPositionPP.EDITFIELD_W % __SettingsPositionPP.EDITFIELD_W__
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_w = uieditfield('numeric', ...
						'Parent', pr.memorize('H'), ... % H = p for Panel
						'Tag', 'EDITFIELD_W', ...
						'Limits', [0 +Inf], ...
						'FontSize', BRAPH2.FONTSIZE, ...
						'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('WIDTH')) ' ' el.get(prop).getPropDescription('WIDTH')], ...
						'ValueChangedFcn', {@cb_position} ... % callback in CHECKBOX_AUTOPOS
						);
					value = editfield_w;
					
				case SettingsPositionPP.LABEL_H % __SettingsPositionPP.LABEL_H__
					el = pr.get('EL');
					prop = pr.get('PROP');
					label_h =  uilabel( ...
						'Parent', pr.memorize('H'), ... % H = p for Panel
						'Tag', 'LABEL_H', ...
						'Text', 'h', ...
						'Interpreter', 'html', ...
						'FontSize', BRAPH2.FONTSIZE, ...
						'HorizontalAlignment', 'right', ...
						'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('HEIGHT')) ' ' el.get(prop).getPropDescription('HEIGHT')], ...
						'BackgroundColor', pr.get('BKGCOLOR') ...
						);
					value = label_h;
					
				case SettingsPositionPP.EDITFIELD_H % __SettingsPositionPP.EDITFIELD_H__
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_h = uieditfield('numeric', ...
						'Parent', pr.memorize('H'), ... % H = p for Panel
						'Tag', 'EDITFIELD_H', ...
						'Limits', [0 +Inf], ...
						'FontSize', BRAPH2.FONTSIZE, ...
						'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('HEIGHT')) ' ' el.get(prop).getPropDescription('HEIGHT')], ...
						'ValueChangedFcn', {@cb_position} ... % callback in CHECKBOX_AUTOPOS
					    );
					value = editfield_h;
					
				case SettingsPositionPP.X_DRAW % __SettingsPositionPP.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('CHECKBOX_AUTOPOS')
					    
					    pr.memorize('LABEL_X0')
					    pr.memorize('EDITFIELD_X0')
					    
					    pr.memorize('LABEL_Y0')
					    pr.memorize('EDITFIELD_Y0')
					    
					    pr.memorize('LABEL_W')
					    pr.memorize('EDITFIELD_W')
					    
					    pr.memorize('LABEL_H')
					    pr.memorize('EDITFIELD_H')
					end
					
				case SettingsPositionPP.UPDATE % __SettingsPositionPP.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    if el.isLocked(prop) || el.getPropCategory(prop) == Category.CONSTANT
					        set(pr.checkbox_autopos, 'Enable', pr.get('ENABLE'))
					        set(pr.editfield_x0, ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.editfield_y0, ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.editfield_w, ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.editfield_h, ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )        
					    end
					    
					    switch el.getPropCategory(prop)
					        case Category.CONSTANT
					            set(pr.get('CHECKBOX_AUTOPOS'), 'Value', el.get(prop).get('AUTOPOS'))
					            set(pr.get('EDITFIELD_X0'), 'Value', el.get(prop).get('X0'))
					            set(pr.get('EDITFIELD_Y0'), 'Value', el.get(prop).get('Y0'))
					            set(pr.get('EDITFIELD_W'), 'Value', el.get(prop).get('WIDTH'))
					            set(pr.get('EDITFIELD_H'), 'Value', el.get(prop).get('HEIGHT'))
					            
					        case Category.METADATA
					            set(pr.get('CHECKBOX_AUTOPOS'), 'Value', el.get(prop).get('AUTOPOS'))
					            set(pr.get('EDITFIELD_X0'), 'Value', el.get(prop).get('X0'))
					            set(pr.get('EDITFIELD_Y0'), 'Value', el.get(prop).get('Y0'))
					            set(pr.get('EDITFIELD_W'), 'Value', el.get(prop).get('WIDTH'))
					            set(pr.get('EDITFIELD_H'), 'Value', el.get(prop).get('HEIGHT'))
					
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('CHECKBOX_AUTOPOS'), 'Value', el.get(prop).get('AUTOPOS'))
					            set(pr.get('EDITFIELD_X0'), 'Value', el.get(prop).get('X0'))
					            set(pr.get('EDITFIELD_Y0'), 'Value', el.get(prop).get('Y0'))
					            set(pr.get('EDITFIELD_W'), 'Value', el.get(prop).get('WIDTH'))
					            set(pr.get('EDITFIELD_H'), 'Value', el.get(prop).get('HEIGHT'))
					            
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('AUTOPOS'), 'Callback')
					                set(pr.get('CHECKBOX_AUTOPOS'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('X0'), 'Callback')
					                set(pr.get('EDITFIELD_X0'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('Y0'), 'Callback')
					                set(pr.get('EDITFIELD_Y0'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('WIDTH'), 'Callback')
					                set(pr.get('EDITFIELD_W'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('HEIGHT'), 'Callback')
					                set(pr.get('EDITFIELD_H'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					
					        case {Category.RESULT Category.QUERY Category.EVANESCENT}
					            value = el.getr(prop);
					
					            if isa(value, 'NoValue')
					                set(pr.get('CHECKBOX_AUTOPOS'), ...
					                    el.getPropDefault(prop).getPropDefault('AUTOPOS'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_X0'), ...
					                    'Value', el.getPropDefault(prop).getPropDefault('X0'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_Y0'), ...
					                    'Value', el.getPropDefault(prop).getPropDefault('Y0'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_W'), ...
					                    'Value', el.getPropDefault(prop).getPropDefault('WIDTH'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_H'), ...
					                    'Value', el.getPropDefault(prop).getPropDefault('HEIGHT'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            else
					                set(pr.get('CHECKBOX_AUTOPOS'), ...
					                    el.get(prop).get('AUTOPOS'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_X0'), ...
					                    'Value', el.get(prop).get('X0'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_Y0'), ...
					                    'Value', el.get(prop).get('Y0'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_W'), ...
					                    'Value', el.get(prop).get('WIDTH'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_H'), ...
					                    'Value', el.get(prop).get('HEIGHT'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
						end
					end
					
				case SettingsPositionPP.REDRAW % __SettingsPositionPP.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('CHECKBOX_AUTOPOS'), 'Position', [s(.3) s(.3) .15*w_p s(1.7)])
					
					    set(pr.get('LABEL_X0'), 'Position', [.20*w_p s(.3) .04*w_p s(1.7)])
					    set(pr.get('EDITFIELD_X0'), 'Position', [.25*w_p s(.3) .12*w_p s(1.7)])
					    
					    set(pr.get('LABEL_Y0'), 'Position', [.40*w_p s(.3) .04*w_p s(1.7)])
					    set(pr.get('EDITFIELD_Y0'), 'Position', [.45*w_p s(.3) .12*w_p s(1.7)])
					
					    set(pr.get('LABEL_W'), 'Position', [.60*w_p s(.3) .04*w_p s(1.7)])
					    set(pr.get('EDITFIELD_W'), 'Position', [.65*w_p s(.3) .12*w_p s(1.7)])
					
					    set(pr.get('LABEL_H'), 'Position', [.80*w_p s(.3) .04*w_p s(1.7)])
					    set(pr.get('EDITFIELD_H'), 'Position', [.85*w_p s(.3) .12*w_p s(1.7)])
					end
					
				case SettingsPositionPP.DELETE % __SettingsPositionPP.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('CHECKBOX_AUTOPOS', Element.getNoValue())
					    
					    pr.set('LABEL_X0', Element.getNoValue())
					    pr.set('EDITFIELD_X0', Element.getNoValue())
					    
					    pr.set('LABEL_Y0', Element.getNoValue())
					    pr.set('EDITFIELD_Y0', Element.getNoValue())
					    
					    pr.set('LABEL_W', Element.getNoValue())
					    pr.set('EDITFIELD_W', Element.getNoValue())
					    
					    pr.set('LABEL_H', Element.getNoValue())
					    pr.set('EDITFIELD_H', Element.getNoValue())
					end
					
				otherwise
					if prop <= SettingsPP.getPropNumber()
						value = calculateValue@SettingsPP(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_position(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set( ...
			        'AUTOPOS', get(pr.get('CHECKBOX_AUTOPOS'), 'Value'), ...
			        'X0', get(pr.get('EDITFIELD_X0'), 'Value'), ...
			        'Y0', get(pr.get('EDITFIELD_Y0'), 'Value'), ...
			        'WIDTH', get(pr.get('EDITFIELD_W'), 'Value'), ...
			        'HEIGHT', get(pr.get('EDITFIELD_H'), 'Value') ...
			        )
			end
		end
	end
end
