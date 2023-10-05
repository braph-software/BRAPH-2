classdef SettingsTextPP < SettingsPP
	%SettingsTextPP is the panel with text settings.
	% It is a subclass of <a href="matlab:help SettingsPP">SettingsPP</a>.
	%
	% A Prop Panel for Text Settings (SettingsTextPP) plots the panel 
	%  for text settings, including text, x, y, and z position, 
	%  font color, size, rotation and weight, 
	%  interpreter, horizontal and vertical alignment.
	% It works for all categories.
	%
	% SettingsTextPP methods (constructor):
	%  SettingsTextPP - constructor
	%
	% SettingsTextPP methods:
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
	% SettingsTextPP methods (display):
	%  tostring - string with information about the prop panel for text settings
	%  disp - displays information about the prop panel for text settings
	%  tree - displays the tree of the prop panel for text settings
	%
	% SettingsTextPP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two prop panel for text settings are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the prop panel for text settings
	%
	% SettingsTextPP methods (save/load, Static):
	%  save - saves BRAPH2 prop panel for text settings as b2 file
	%  load - loads a BRAPH2 prop panel for text settings from a b2 file
	%
	% SettingsTextPP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the prop panel for text settings
	%
	% SettingsTextPP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the prop panel for text settings
	%
	% SettingsTextPP methods (inspection, Static):
	%  getClass - returns the class of the prop panel for text settings
	%  getSubclasses - returns all subclasses of SettingsTextPP
	%  getProps - returns the property list of the prop panel for text settings
	%  getPropNumber - returns the property number of the prop panel for text settings
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
	% SettingsTextPP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SettingsTextPP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SettingsTextPP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SettingsTextPP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SettingsTextPP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SettingsTextPP constants</a>.
	%
	%
	% See also SettingsText, uieditfield, uipushbutton, uislider.
	
	properties (Constant) % properties
		ENABLE = SettingsPP.getPropNumber() + 1;
		ENABLE_TAG = 'ENABLE';
		ENABLE_CATEGORY = Category.GUI;
		ENABLE_FORMAT = Format.LOGICAL;
		
		EDITFIELD_X = SettingsPP.getPropNumber() + 2;
		EDITFIELD_X_TAG = 'EDITFIELD_X';
		EDITFIELD_X_CATEGORY = Category.EVANESCENT;
		EDITFIELD_X_FORMAT = Format.HANDLE;
		
		EDITFIELD_Y = SettingsPP.getPropNumber() + 3;
		EDITFIELD_Y_TAG = 'EDITFIELD_Y';
		EDITFIELD_Y_CATEGORY = Category.EVANESCENT;
		EDITFIELD_Y_FORMAT = Format.HANDLE;
		
		EDITFIELD_Z = SettingsPP.getPropNumber() + 4;
		EDITFIELD_Z_TAG = 'EDITFIELD_Z';
		EDITFIELD_Z_CATEGORY = Category.EVANESCENT;
		EDITFIELD_Z_FORMAT = Format.HANDLE;
		
		EDITFIELD_TXT = SettingsPP.getPropNumber() + 5;
		EDITFIELD_TXT_TAG = 'EDITFIELD_TXT';
		EDITFIELD_TXT_CATEGORY = Category.EVANESCENT;
		EDITFIELD_TXT_FORMAT = Format.HANDLE;
		
		BUTTON_FONTCOLOR = SettingsPP.getPropNumber() + 6;
		BUTTON_FONTCOLOR_TAG = 'BUTTON_FONTCOLOR';
		BUTTON_FONTCOLOR_CATEGORY = Category.EVANESCENT;
		BUTTON_FONTCOLOR_FORMAT = Format.HANDLE;
		
		EDITFIELD_FONTSIZE = SettingsPP.getPropNumber() + 7;
		EDITFIELD_FONTSIZE_TAG = 'EDITFIELD_FONTSIZE';
		EDITFIELD_FONTSIZE_CATEGORY = Category.EVANESCENT;
		EDITFIELD_FONTSIZE_FORMAT = Format.HANDLE;
		
		SLIDER_FONTSIZE = SettingsPP.getPropNumber() + 8;
		SLIDER_FONTSIZE_TAG = 'SLIDER_FONTSIZE';
		SLIDER_FONTSIZE_CATEGORY = Category.EVANESCENT;
		SLIDER_FONTSIZE_FORMAT = Format.HANDLE;
		
		EDITFIELD_ROTATION = SettingsPP.getPropNumber() + 9;
		EDITFIELD_ROTATION_TAG = 'EDITFIELD_ROTATION';
		EDITFIELD_ROTATION_CATEGORY = Category.EVANESCENT;
		EDITFIELD_ROTATION_FORMAT = Format.HANDLE;
		
		SLIDER_ROTATION = SettingsPP.getPropNumber() + 10;
		SLIDER_ROTATION_TAG = 'SLIDER_ROTATION';
		SLIDER_ROTATION_CATEGORY = Category.EVANESCENT;
		SLIDER_ROTATION_FORMAT = Format.HANDLE;
		
		EDITFIELD_FONTNAME = SettingsPP.getPropNumber() + 11;
		EDITFIELD_FONTNAME_TAG = 'EDITFIELD_FONTNAME';
		EDITFIELD_FONTNAME_CATEGORY = Category.EVANESCENT;
		EDITFIELD_FONTNAME_FORMAT = Format.HANDLE;
		
		DROPDOWN_FONTWEIGHT = SettingsPP.getPropNumber() + 12;
		DROPDOWN_FONTWEIGHT_TAG = 'DROPDOWN_FONTWEIGHT';
		DROPDOWN_FONTWEIGHT_CATEGORY = Category.EVANESCENT;
		DROPDOWN_FONTWEIGHT_FORMAT = Format.HANDLE;
		
		DROPDOWN_INTERPRETER = SettingsPP.getPropNumber() + 13;
		DROPDOWN_INTERPRETER_TAG = 'DROPDOWN_INTERPRETER';
		DROPDOWN_INTERPRETER_CATEGORY = Category.EVANESCENT;
		DROPDOWN_INTERPRETER_FORMAT = Format.HANDLE;
		
		DROPDOWN_HALIGN = SettingsPP.getPropNumber() + 14;
		DROPDOWN_HALIGN_TAG = 'DROPDOWN_HALIGN';
		DROPDOWN_HALIGN_CATEGORY = Category.EVANESCENT;
		DROPDOWN_HALIGN_FORMAT = Format.HANDLE;
		
		DROPDOWN_VALIGN = SettingsPP.getPropNumber() + 15;
		DROPDOWN_VALIGN_TAG = 'DROPDOWN_VALIGN';
		DROPDOWN_VALIGN_CATEGORY = Category.EVANESCENT;
		DROPDOWN_VALIGN_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pr = SettingsTextPP(varargin)
			%SettingsTextPP() creates a prop panel for text settings.
			%
			% SettingsTextPP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SettingsTextPP(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the prop panel for text settings.
			%
			% CLASS = SettingsTextPP.GETCLASS() returns the class 'SettingsTextPP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the prop panel for text settings PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('SettingsTextPP') returns 'SettingsTextPP'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('SettingsTextPP')
			%  are less computationally efficient.
			
			pr_class = 'SettingsTextPP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the prop panel for text settings.
			%
			% LIST = SettingsTextPP.GETSUBCLASSES() returns all subclasses of 'SettingsTextPP'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the prop panel for text settings PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('SettingsTextPP') returns all subclasses of 'SettingsTextPP'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('SettingsTextPP', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of prop panel for text settings.
			%
			% PROPS = SettingsTextPP.GETPROPS() returns the property list of prop panel for text settings
			%  as a row vector.
			%
			% PROPS = SettingsTextPP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the prop panel for text settings PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('SettingsTextPP'[, CATEGORY]) returns the property list of 'SettingsTextPP'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					SettingsPP.getProps() ...
						SettingsTextPP.ENABLE ...
						SettingsTextPP.EDITFIELD_X ...
						SettingsTextPP.EDITFIELD_Y ...
						SettingsTextPP.EDITFIELD_Z ...
						SettingsTextPP.EDITFIELD_TXT ...
						SettingsTextPP.BUTTON_FONTCOLOR ...
						SettingsTextPP.EDITFIELD_FONTSIZE ...
						SettingsTextPP.SLIDER_FONTSIZE ...
						SettingsTextPP.EDITFIELD_ROTATION ...
						SettingsTextPP.SLIDER_ROTATION ...
						SettingsTextPP.EDITFIELD_FONTNAME ...
						SettingsTextPP.DROPDOWN_FONTWEIGHT ...
						SettingsTextPP.DROPDOWN_INTERPRETER ...
						SettingsTextPP.DROPDOWN_HALIGN ...
						SettingsTextPP.DROPDOWN_VALIGN ...
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
						SettingsTextPP.EDITFIELD_X ...
						SettingsTextPP.EDITFIELD_Y ...
						SettingsTextPP.EDITFIELD_Z ...
						SettingsTextPP.EDITFIELD_TXT ...
						SettingsTextPP.BUTTON_FONTCOLOR ...
						SettingsTextPP.EDITFIELD_FONTSIZE ...
						SettingsTextPP.SLIDER_FONTSIZE ...
						SettingsTextPP.EDITFIELD_ROTATION ...
						SettingsTextPP.SLIDER_ROTATION ...
						SettingsTextPP.EDITFIELD_FONTNAME ...
						SettingsTextPP.DROPDOWN_FONTWEIGHT ...
						SettingsTextPP.DROPDOWN_INTERPRETER ...
						SettingsTextPP.DROPDOWN_HALIGN ...
						SettingsTextPP.DROPDOWN_VALIGN ...
						];
				case Category.FIGURE
					prop_list = [ ...
						SettingsPP.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						SettingsPP.getProps(Category.GUI) ...
						SettingsTextPP.ENABLE ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of prop panel for text settings.
			%
			% N = SettingsTextPP.GETPROPNUMBER() returns the property number of prop panel for text settings.
			%
			% N = SettingsTextPP.GETPROPNUMBER(CATEGORY) returns the property number of prop panel for text settings
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the prop panel for text settings PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('SettingsTextPP') returns the property number of 'SettingsTextPP'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(SettingsTextPP.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in prop panel for text settings/error.
			%
			% CHECK = SettingsTextPP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(SettingsTextPP, PROP) checks whether PROP exists for SettingsTextPP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SettingsTextPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsTextPP:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsTextPP:WrongInput]
			%  Element.EXISTSPROP(SettingsTextPP, PROP) throws error if PROP does NOT exist for SettingsTextPP.
			%   Error id: [BRAPH2:SettingsTextPP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == SettingsTextPP.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsTextPP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsTextPP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SettingsTextPP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in prop panel for text settings/error.
			%
			% CHECK = SettingsTextPP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(SettingsTextPP, TAG) checks whether TAG exists for SettingsTextPP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SettingsTextPP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsTextPP:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:SettingsTextPP:WrongInput]
			%  Element.EXISTSTAG(SettingsTextPP, TAG) throws error if TAG does NOT exist for SettingsTextPP.
			%   Error id: [BRAPH2:SettingsTextPP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			settingstextpp_tag_list = cellfun(@(x) SettingsTextPP.getPropTag(x), num2cell(SettingsTextPP.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, settingstextpp_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsTextPP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsTextPP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for SettingsTextPP.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(SettingsTextPP, POINTER) returns property number of POINTER of SettingsTextPP.
			%  PROPERTY = PR.GETPROPPROP(SettingsTextPP, POINTER) returns property number of POINTER of SettingsTextPP.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				settingstextpp_tag_list = cellfun(@(x) SettingsTextPP.getPropTag(x), num2cell(SettingsTextPP.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, settingstextpp_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(SettingsTextPP, POINTER) returns tag of POINTER of SettingsTextPP.
			%  TAG = PR.GETPROPTAG(SettingsTextPP, POINTER) returns tag of POINTER of SettingsTextPP.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case SettingsTextPP.ENABLE
						tag = SettingsTextPP.ENABLE_TAG;
					case SettingsTextPP.EDITFIELD_X
						tag = SettingsTextPP.EDITFIELD_X_TAG;
					case SettingsTextPP.EDITFIELD_Y
						tag = SettingsTextPP.EDITFIELD_Y_TAG;
					case SettingsTextPP.EDITFIELD_Z
						tag = SettingsTextPP.EDITFIELD_Z_TAG;
					case SettingsTextPP.EDITFIELD_TXT
						tag = SettingsTextPP.EDITFIELD_TXT_TAG;
					case SettingsTextPP.BUTTON_FONTCOLOR
						tag = SettingsTextPP.BUTTON_FONTCOLOR_TAG;
					case SettingsTextPP.EDITFIELD_FONTSIZE
						tag = SettingsTextPP.EDITFIELD_FONTSIZE_TAG;
					case SettingsTextPP.SLIDER_FONTSIZE
						tag = SettingsTextPP.SLIDER_FONTSIZE_TAG;
					case SettingsTextPP.EDITFIELD_ROTATION
						tag = SettingsTextPP.EDITFIELD_ROTATION_TAG;
					case SettingsTextPP.SLIDER_ROTATION
						tag = SettingsTextPP.SLIDER_ROTATION_TAG;
					case SettingsTextPP.EDITFIELD_FONTNAME
						tag = SettingsTextPP.EDITFIELD_FONTNAME_TAG;
					case SettingsTextPP.DROPDOWN_FONTWEIGHT
						tag = SettingsTextPP.DROPDOWN_FONTWEIGHT_TAG;
					case SettingsTextPP.DROPDOWN_INTERPRETER
						tag = SettingsTextPP.DROPDOWN_INTERPRETER_TAG;
					case SettingsTextPP.DROPDOWN_HALIGN
						tag = SettingsTextPP.DROPDOWN_HALIGN_TAG;
					case SettingsTextPP.DROPDOWN_VALIGN
						tag = SettingsTextPP.DROPDOWN_VALIGN_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(SettingsTextPP, POINTER) returns category of POINTER of SettingsTextPP.
			%  CATEGORY = PR.GETPROPCATEGORY(SettingsTextPP, POINTER) returns category of POINTER of SettingsTextPP.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsTextPP.getPropProp(pointer);
			
			switch prop
				case SettingsTextPP.ENABLE
					prop_category = SettingsTextPP.ENABLE_CATEGORY;
				case SettingsTextPP.EDITFIELD_X
					prop_category = SettingsTextPP.EDITFIELD_X_CATEGORY;
				case SettingsTextPP.EDITFIELD_Y
					prop_category = SettingsTextPP.EDITFIELD_Y_CATEGORY;
				case SettingsTextPP.EDITFIELD_Z
					prop_category = SettingsTextPP.EDITFIELD_Z_CATEGORY;
				case SettingsTextPP.EDITFIELD_TXT
					prop_category = SettingsTextPP.EDITFIELD_TXT_CATEGORY;
				case SettingsTextPP.BUTTON_FONTCOLOR
					prop_category = SettingsTextPP.BUTTON_FONTCOLOR_CATEGORY;
				case SettingsTextPP.EDITFIELD_FONTSIZE
					prop_category = SettingsTextPP.EDITFIELD_FONTSIZE_CATEGORY;
				case SettingsTextPP.SLIDER_FONTSIZE
					prop_category = SettingsTextPP.SLIDER_FONTSIZE_CATEGORY;
				case SettingsTextPP.EDITFIELD_ROTATION
					prop_category = SettingsTextPP.EDITFIELD_ROTATION_CATEGORY;
				case SettingsTextPP.SLIDER_ROTATION
					prop_category = SettingsTextPP.SLIDER_ROTATION_CATEGORY;
				case SettingsTextPP.EDITFIELD_FONTNAME
					prop_category = SettingsTextPP.EDITFIELD_FONTNAME_CATEGORY;
				case SettingsTextPP.DROPDOWN_FONTWEIGHT
					prop_category = SettingsTextPP.DROPDOWN_FONTWEIGHT_CATEGORY;
				case SettingsTextPP.DROPDOWN_INTERPRETER
					prop_category = SettingsTextPP.DROPDOWN_INTERPRETER_CATEGORY;
				case SettingsTextPP.DROPDOWN_HALIGN
					prop_category = SettingsTextPP.DROPDOWN_HALIGN_CATEGORY;
				case SettingsTextPP.DROPDOWN_VALIGN
					prop_category = SettingsTextPP.DROPDOWN_VALIGN_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(SettingsTextPP, POINTER) returns format of POINTER of SettingsTextPP.
			%  FORMAT = PR.GETPROPFORMAT(SettingsTextPP, POINTER) returns format of POINTER of SettingsTextPP.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsTextPP.getPropProp(pointer);
			
			switch prop
				case SettingsTextPP.ENABLE
					prop_format = SettingsTextPP.ENABLE_FORMAT;
				case SettingsTextPP.EDITFIELD_X
					prop_format = SettingsTextPP.EDITFIELD_X_FORMAT;
				case SettingsTextPP.EDITFIELD_Y
					prop_format = SettingsTextPP.EDITFIELD_Y_FORMAT;
				case SettingsTextPP.EDITFIELD_Z
					prop_format = SettingsTextPP.EDITFIELD_Z_FORMAT;
				case SettingsTextPP.EDITFIELD_TXT
					prop_format = SettingsTextPP.EDITFIELD_TXT_FORMAT;
				case SettingsTextPP.BUTTON_FONTCOLOR
					prop_format = SettingsTextPP.BUTTON_FONTCOLOR_FORMAT;
				case SettingsTextPP.EDITFIELD_FONTSIZE
					prop_format = SettingsTextPP.EDITFIELD_FONTSIZE_FORMAT;
				case SettingsTextPP.SLIDER_FONTSIZE
					prop_format = SettingsTextPP.SLIDER_FONTSIZE_FORMAT;
				case SettingsTextPP.EDITFIELD_ROTATION
					prop_format = SettingsTextPP.EDITFIELD_ROTATION_FORMAT;
				case SettingsTextPP.SLIDER_ROTATION
					prop_format = SettingsTextPP.SLIDER_ROTATION_FORMAT;
				case SettingsTextPP.EDITFIELD_FONTNAME
					prop_format = SettingsTextPP.EDITFIELD_FONTNAME_FORMAT;
				case SettingsTextPP.DROPDOWN_FONTWEIGHT
					prop_format = SettingsTextPP.DROPDOWN_FONTWEIGHT_FORMAT;
				case SettingsTextPP.DROPDOWN_INTERPRETER
					prop_format = SettingsTextPP.DROPDOWN_INTERPRETER_FORMAT;
				case SettingsTextPP.DROPDOWN_HALIGN
					prop_format = SettingsTextPP.DROPDOWN_HALIGN_FORMAT;
				case SettingsTextPP.DROPDOWN_VALIGN
					prop_format = SettingsTextPP.DROPDOWN_VALIGN_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SettingsTextPP, POINTER) returns description of POINTER of SettingsTextPP.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(SettingsTextPP, POINTER) returns description of POINTER of SettingsTextPP.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SettingsTextPP.getPropProp(pointer);
			
			switch prop
				case SettingsTextPP.ENABLE
					prop_description = 'ENABLE (gui, logical) switches the checkbox and editfields between active and inactive appearance when not editable.';
				case SettingsTextPP.EDITFIELD_X
					prop_description = 'EDITFIELD_X (evanescent, handle) is the text value edit field for the X property.';
				case SettingsTextPP.EDITFIELD_Y
					prop_description = 'EDITFIELD_Y (evanescent, handle) is the text value edit field for the Y property.';
				case SettingsTextPP.EDITFIELD_Z
					prop_description = 'EDITFIELD_Z (evanescent, handle) is the text value edit field for the Z property.';
				case SettingsTextPP.EDITFIELD_TXT
					prop_description = 'EDITFIELD_TXT (evanescent, handle) is the text value edit field for the TXT property.';
				case SettingsTextPP.BUTTON_FONTCOLOR
					prop_description = 'BUTTON_FONTCOLOR (evanescent, handle) is the text color button.';
				case SettingsTextPP.EDITFIELD_FONTSIZE
					prop_description = 'EDITFIELD_FONTSIZE (evanescent, handle) is the font size edit field.';
				case SettingsTextPP.SLIDER_FONTSIZE
					prop_description = 'SLIDER_FONTSIZE (evanescent, handle) is the font size slider.';
				case SettingsTextPP.EDITFIELD_ROTATION
					prop_description = 'EDITFIELD_ROTATION (evanescent, handle) is the rotation edit field.';
				case SettingsTextPP.SLIDER_ROTATION
					prop_description = 'SLIDER_ROTATION (evanescent, handle) is the rotation slider.';
				case SettingsTextPP.EDITFIELD_FONTNAME
					prop_description = 'EDITFIELD_FONTNAME (evanescent, handle) is the text value edit field for the FONTNAME property.';
				case SettingsTextPP.DROPDOWN_FONTWEIGHT
					prop_description = 'DROPDOWN_FONTWEIGHT (evanescent, handle) is the font weight dropdown.';
				case SettingsTextPP.DROPDOWN_INTERPRETER
					prop_description = 'DROPDOWN_INTERPRETER (evanescent, handle) is the interpreter dropdown.';
				case SettingsTextPP.DROPDOWN_HALIGN
					prop_description = 'DROPDOWN_HALIGN (evanescent, handle) is the horizontal alignment dropdown.';
				case SettingsTextPP.DROPDOWN_VALIGN
					prop_description = 'DROPDOWN_VALIGN (evanescent, handle) is the vertical alignment dropdown.';
				case SettingsTextPP.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the prop panel for text settings.';
				case SettingsTextPP.NAME
					prop_description = 'NAME (constant, string) is the name of the prop panel for text settings.';
				case SettingsTextPP.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the prop panel for text settings.';
				case SettingsTextPP.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the prop panel for text settings.';
				case SettingsTextPP.ID
					prop_description = 'ID (data, string) is a few-letter code for the prop panel for text settings.';
				case SettingsTextPP.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the prop panel for text settings.';
				case SettingsTextPP.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the prop panel for text settings.';
				case SettingsTextPP.EL
					prop_description = 'EL (data, item) is the element.';
				case SettingsTextPP.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case SettingsTextPP.HEIGHT
					prop_description = 'HEIGHT (gui, size) is the pixel height of the prop panel for text settings.';
				case SettingsTextPP.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case SettingsTextPP.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the property panel.';
				case SettingsTextPP.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case SettingsTextPP.DELETE
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
			%  SETTINGS = Element.GETPROPSETTINGS(SettingsTextPP, POINTER) returns settings of POINTER of SettingsTextPP.
			%  SETTINGS = PR.GETPROPSETTINGS(SettingsTextPP, POINTER) returns settings of POINTER of SettingsTextPP.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SettingsTextPP.getPropProp(pointer);
			
			switch prop
				case SettingsTextPP.ENABLE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case SettingsTextPP.EDITFIELD_X
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsTextPP.EDITFIELD_Y
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsTextPP.EDITFIELD_Z
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsTextPP.EDITFIELD_TXT
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsTextPP.BUTTON_FONTCOLOR
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsTextPP.EDITFIELD_FONTSIZE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsTextPP.SLIDER_FONTSIZE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsTextPP.EDITFIELD_ROTATION
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsTextPP.SLIDER_ROTATION
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsTextPP.EDITFIELD_FONTNAME
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsTextPP.DROPDOWN_FONTWEIGHT
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsTextPP.DROPDOWN_INTERPRETER
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsTextPP.DROPDOWN_HALIGN
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsTextPP.DROPDOWN_VALIGN
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case SettingsTextPP.TEMPLATE
					prop_settings = 'SettingsTextPP';
				otherwise
					prop_settings = getPropSettings@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SettingsTextPP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsTextPP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(SettingsTextPP, POINTER) returns the default value of POINTER of SettingsTextPP.
			%  DEFAULT = PR.GETPROPDEFAULT(SettingsTextPP, POINTER) returns the default value of POINTER of SettingsTextPP.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SettingsTextPP.getPropProp(pointer);
			
			switch prop
				case SettingsTextPP.ENABLE
					prop_default = true;
				case SettingsTextPP.EDITFIELD_X
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.EDITFIELD_Y
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.EDITFIELD_Z
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.EDITFIELD_TXT
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.BUTTON_FONTCOLOR
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.EDITFIELD_FONTSIZE
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.SLIDER_FONTSIZE
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.EDITFIELD_ROTATION
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.SLIDER_ROTATION
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.EDITFIELD_FONTNAME
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.DROPDOWN_FONTWEIGHT
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.DROPDOWN_INTERPRETER
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.DROPDOWN_HALIGN
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.DROPDOWN_VALIGN
					prop_default = Format.getFormatDefault(Format.HANDLE, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.ELCLASS
					prop_default = 'SettingsTextPP';
				case SettingsTextPP.NAME
					prop_default = 'Prop Panel for Text Settings';
				case SettingsTextPP.DESCRIPTION
					prop_default = 'A Prop Panel for Text Settings (SettingsTextPP) plots the panel for text settings, including text, x, y, and z position, font color, size, rotation and weight, interpreter, horizontal and vertical alignment. It works for all categories.';
				case SettingsTextPP.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.ID
					prop_default = 'SettingsTextPP ID';
				case SettingsTextPP.LABEL
					prop_default = 'SettingsTextPP label';
				case SettingsTextPP.NOTES
					prop_default = 'SettingsTextPP notes';
				case SettingsTextPP.EL
					prop_default = MeasurePF();
				case SettingsTextPP.PROP
					prop_default = MeasurePF.ST_TITLE;
				case SettingsTextPP.HEIGHT
					prop_default = s(9.2);
				otherwise
					prop_default = getPropDefault@SettingsPP(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SettingsTextPP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SettingsTextPP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SettingsTextPP, POINTER) returns the conditioned default value of POINTER of SettingsTextPP.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(SettingsTextPP, POINTER) returns the conditioned default value of POINTER of SettingsTextPP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SettingsTextPP.getPropProp(pointer);
			
			prop_default = SettingsTextPP.conditioning(prop, SettingsTextPP.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(SettingsTextPP, PROP, VALUE) checks VALUE format for PROP of SettingsTextPP.
			%  CHECK = PR.CHECKPROP(SettingsTextPP, PROP, VALUE) checks VALUE format for PROP of SettingsTextPP.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:SettingsTextPP:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:SettingsTextPP:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(SettingsTextPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsTextPP.
			%   Error id: €BRAPH2.STR€:SettingsTextPP:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(SettingsTextPP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SettingsTextPP.
			%   Error id: €BRAPH2.STR€:SettingsTextPP:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('SettingsTextPP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SettingsTextPP.getPropProp(pointer);
			
			switch prop
				case SettingsTextPP.ENABLE % __SettingsTextPP.ENABLE__
					check = Format.checkFormat(Format.LOGICAL, value, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.EDITFIELD_X % __SettingsTextPP.EDITFIELD_X__
					check = Format.checkFormat(Format.HANDLE, value, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.EDITFIELD_Y % __SettingsTextPP.EDITFIELD_Y__
					check = Format.checkFormat(Format.HANDLE, value, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.EDITFIELD_Z % __SettingsTextPP.EDITFIELD_Z__
					check = Format.checkFormat(Format.HANDLE, value, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.EDITFIELD_TXT % __SettingsTextPP.EDITFIELD_TXT__
					check = Format.checkFormat(Format.HANDLE, value, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.BUTTON_FONTCOLOR % __SettingsTextPP.BUTTON_FONTCOLOR__
					check = Format.checkFormat(Format.HANDLE, value, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.EDITFIELD_FONTSIZE % __SettingsTextPP.EDITFIELD_FONTSIZE__
					check = Format.checkFormat(Format.HANDLE, value, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.SLIDER_FONTSIZE % __SettingsTextPP.SLIDER_FONTSIZE__
					check = Format.checkFormat(Format.HANDLE, value, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.EDITFIELD_ROTATION % __SettingsTextPP.EDITFIELD_ROTATION__
					check = Format.checkFormat(Format.HANDLE, value, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.SLIDER_ROTATION % __SettingsTextPP.SLIDER_ROTATION__
					check = Format.checkFormat(Format.HANDLE, value, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.EDITFIELD_FONTNAME % __SettingsTextPP.EDITFIELD_FONTNAME__
					check = Format.checkFormat(Format.HANDLE, value, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.DROPDOWN_FONTWEIGHT % __SettingsTextPP.DROPDOWN_FONTWEIGHT__
					check = Format.checkFormat(Format.HANDLE, value, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.DROPDOWN_INTERPRETER % __SettingsTextPP.DROPDOWN_INTERPRETER__
					check = Format.checkFormat(Format.HANDLE, value, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.DROPDOWN_HALIGN % __SettingsTextPP.DROPDOWN_HALIGN__
					check = Format.checkFormat(Format.HANDLE, value, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.DROPDOWN_VALIGN % __SettingsTextPP.DROPDOWN_VALIGN__
					check = Format.checkFormat(Format.HANDLE, value, SettingsTextPP.getPropSettings(prop));
				case SettingsTextPP.TEMPLATE % __SettingsTextPP.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, SettingsTextPP.getPropSettings(prop));
				otherwise
					if prop <= SettingsPP.getPropNumber()
						check = checkProp@SettingsPP(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':SettingsTextPP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':SettingsTextPP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SettingsTextPP.getPropTag(prop) ' (' SettingsTextPP.getFormatTag(SettingsTextPP.getPropFormat(prop)) ').'] ...
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
				case SettingsTextPP.EDITFIELD_X % __SettingsTextPP.EDITFIELD_X__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					editfield = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'EDITFIELD_X', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('X')) ' ' el.get(prop).getPropDescription('X')], ...
					    'ValueChangedFcn', {@cb_editfield_x} ...
					    );
					
					value = editfield;
					
				case SettingsTextPP.EDITFIELD_Y % __SettingsTextPP.EDITFIELD_Y__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					editfield = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'EDITFIELD_Y', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('Y')) ' ' el.get(prop).getPropDescription('Y')], ...
					    'ValueChangedFcn', {@cb_editfield_y} ...
					    );
					
					value = editfield;
					
				case SettingsTextPP.EDITFIELD_Z % __SettingsTextPP.EDITFIELD_Z__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					editfield = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'EDITFIELD_Z', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('Z')) ' ' el.get(prop).getPropDescription('Z')], ...
					    'ValueChangedFcn', {@cb_editfield_Z} ...
					    );
					
					value = editfield;
					
				case SettingsTextPP.EDITFIELD_TXT % __SettingsTextPP.EDITFIELD_TXT__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					editfield = uieditfield( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'EDITFIELD_TXT', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('TXT')) ' ' el.get(prop).getPropDescription('TXT')], ...
					    'ValueChangedFcn', {@cb_editfield_txt} ...
					    );
					
					value = editfield;
					
				case SettingsTextPP.BUTTON_FONTCOLOR % __SettingsTextPP.BUTTON_FONTCOLOR__
					el = pr.get('EL');
					prop = pr.get('PROP');
					button_fontcolor = uibutton( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'BUTTON_FONTCOLOR', ...
					    'Text', 'face', ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FONTCOLOR')) ' ' el.get(prop).getPropDescription('FONTCOLOR')], ...
					    'ButtonPushedFcn', {@cb_button_fontcolor}, ...
					    'Interruptible', 'off', ...
					    'BusyAction', 'cancel' ...
					    );
					value = button_fontcolor;
					
				case SettingsTextPP.EDITFIELD_FONTSIZE % __SettingsTextPP.EDITFIELD_FONTSIZE__
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_fontsize = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'EDITFIELD_FONTSIZE', ...
					    'Limits', [0 100], ...
					    'LowerLimitInclusive', 'off', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FONTSIZE')) ' ' el.get(prop).getPropDescription('FONTSIZE')], ...
					    'ValueChangedFcn', {@cb_editfield_fontsize} ...
					    );
					value = editfield_fontsize;
					
				case SettingsTextPP.SLIDER_FONTSIZE % __SettingsTextPP.SLIDER_FONTSIZE__
					el = pr.get('EL');
					prop = pr.get('PROP');
					slider_fontsize = uislider( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'SLIDER_FONTSIZE', ...
					    'Limits', [0 100], ...
					    'FontSize', BRAPH2.FONTSIZE / 2, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FONTSIZE')) ' ' el.get(prop).getPropDescription('FONTSIZE')], ...
					    'ValueChangedFcn', {@cb_slider_fontsize} ...
					    );
					value = slider_fontsize;
					
				case SettingsTextPP.EDITFIELD_ROTATION % __SettingsTextPP.EDITFIELD_ROTATION__
					el = pr.get('EL');
					prop = pr.get('PROP');
					editfield_rotation = uieditfield('numeric', ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'EDITFIELD_ROTATION', ...
					    'Limits', [-180 180], ...
					    'LowerLimitInclusive', 'on', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('ROTATION')) ' ' el.get(prop).getPropDescription('ROTATION')], ...
					    'ValueChangedFcn', {@cb_editfield_rotation} ...
					    );
					value = editfield_rotation;
					
				case SettingsTextPP.SLIDER_ROTATION % __SettingsTextPP.SLIDER_ROTATION__
					el = pr.get('EL');
					prop = pr.get('PROP');
					slider_rotation = uislider( ...
					    'Parent', pr.memorize('H'), ...
					    'Tag', 'SLIDER_ROTATION', ...
					    'Limits', [-180 180], ...
					    'FontSize', BRAPH2.FONTSIZE / 2, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('ROTATION')) ' ' el.get(prop).getPropDescription('ROTATION')], ...
					    'ValueChangedFcn', {@cb_slider_rotation} ...
					    );
					value = slider_rotation;
					
				case SettingsTextPP.EDITFIELD_FONTNAME % __SettingsTextPP.EDITFIELD_FONTNAME__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					editfield_fontname = uieditfield( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'EDITFIELD_FONTNAME', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FONTNAME')) ' ' el.get(prop).getPropDescription('FONTNAME')], ...
					    'ValueChangedFcn', {@cb_editfield_fontname} ...
					    );
					
					value = editfield_fontname;
					
				case SettingsTextPP.DROPDOWN_FONTWEIGHT % __SettingsTextPP.DROPDOWN_FONTWEIGHT__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					dropdown_fontweight = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN_FONTWEIGHT', ...
					    'Items', el.get(prop).getPropSettings('FONTWEIGHT'), ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FONTWEIGHT')) ' ' el.get(prop).getPropDescription('FONTWEIGHT')], ...
					    'ValueChangedFcn', {@cb_dropdown_fontweight} ...
					    );
					
					value = dropdown_fontweight;
					
				case SettingsTextPP.DROPDOWN_INTERPRETER % __SettingsTextPP.DROPDOWN_INTERPRETER__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					dropdown_interpreter = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN_INTERPRETER', ...
					    'Items', el.get(prop).getPropSettings('INTERPRETER'), ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('INTERPRETER')) ' ' el.get(prop).getPropDescription('INTERPRETER')], ...
					    'ValueChangedFcn', {@cb_dropdown_interpreter} ...
					    );
					
					value = dropdown_interpreter;
					
				case SettingsTextPP.DROPDOWN_HALIGN % __SettingsTextPP.DROPDOWN_HALIGN__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					dropdown_halign = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN_HALIGN', ...
					    'Items', el.get(prop).getPropSettings('HALIGN'), ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('HALIGN')) ' ' el.get(prop).getPropDescription('HALIGN')], ...
					    'ValueChangedFcn', {@cb_dropdown_halign} ...
					    );
					
					value = dropdown_halign;
					
				case SettingsTextPP.DROPDOWN_VALIGN % __SettingsTextPP.DROPDOWN_VALIGN__
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					dropdown_valign = uidropdown( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'DROPDOWN_VALIGN', ...
					    'Items', el.get(prop).getPropSettings('VALIGN'), ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('VALIGN')) ' ' el.get(prop).getPropDescription('VALIGN')], ...
					    'ValueChangedFcn', {@cb_dropdown_valign} ...
					    );
					
					value = dropdown_valign;
					
				case SettingsTextPP.X_DRAW % __SettingsTextPP.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('EDITFIELD_X')
					    pr.memorize('EDITFIELD_Y')
					    pr.memorize('EDITFIELD_Z')
					    pr.memorize('EDITFIELD_TXT')
					    
					    pr.memorize('BUTTON_FONTCOLOR')
					    pr.memorize('EDITFIELD_FONTSIZE')
					    pr.memorize('SLIDER_FONTSIZE')
					    pr.memorize('EDITFIELD_ROTATION')
					    pr.memorize('SLIDER_ROTATION')
					        
					    pr.memorize('EDITFIELD_FONTNAME')
					    pr.memorize('DROPDOWN_FONTWEIGHT')
					    pr.memorize('DROPDOWN_INTERPRETER')
					    pr.memorize('DROPDOWN_HALIGN')
					    pr.memorize('DROPDOWN_VALIGN')
					end
					
				case SettingsTextPP.UPDATE % __SettingsTextPP.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    if el.isLocked(prop)
					        set(pr.get('EDITFIELD_X'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('EDITFIELD_Y'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('EDITFIELD_Z'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('EDITFIELD_TXT'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )        
					        
					        set(pr.get('BUTTON_FONTCOLOR'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('EDITFIELD_FONTSIZE'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('SLIDER_FONTSIZE'), 'Enable', pr.get('ENABLE'))
					        set(pr.get('EDITFIELD_ROTATION'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('SLIDER_ROTATION'), 'Enable', pr.get('ENABLE'))
					        
					        set(pr.get('EDITFIELD_FONTNAME'), ...
					            'Editable', 'off', ...
					            'Enable', pr.get('ENABLE') ...
					            )
					        set(pr.get('DROPDOWN_FONTWEIGHT'), 'Enable', 'off')
					        set(pr.get('DROPDOWN_INTERPRETER'), 'Enable', 'off')
					        set(pr.get('DROPDOWN_HALIGN'), 'Enable', 'off')
					        set(pr.get('DROPDOWN_VALIGN'), 'Enable', 'off')
					    end
					
					    switch el.getPropCategory(prop)
					        case Category.METADATA
					            set(pr.get('EDITFIELD_X'), 'Value', el.get(prop).get('X'))
					            set(pr.get('EDITFIELD_Y'), 'Value', el.get(prop).get('Y'))
					            set(pr.get('EDITFIELD_Z'), 'Value', el.get(prop).get('Z'))
					            set(pr.get('EDITFIELD_TXT'), 'Value', el.get(prop).get('TXT'))
					            
					            set(pr.get('BUTTON_FONTCOLOR'), 'BackgroundColor', el.get(prop).get('COLOR'))
					            set(pr.get('EDITFIELD_FONTSIZE'), 'Value', el.get(prop).get('FONTSIZE'))
					            set(pr.get('SLIDER_FONTSIZE'), 'Value', el.get(prop).get('FONTSIZE'))
					            set(pr.get('EDITFIELD_ROTATION'), 'Value', el.get(prop).get('ROTATION'))
					            set(pr.get('SLIDER_ROTATION'), 'Value', el.get(prop).get('ROTATION'))
					
					            set(pr.get('EDITFIELD_FONTNAME'), 'Value', el.get(prop).get('FONTNAME'))
					            set(pr.get('DROPDOWN_FONTWEIGHT'), 'Value', el.get(prop).get('FONTWEIGHT'))
					            set(pr.get('DROPDOWN_INTERPRETER'), 'Value', el.get(prop).get('INTERPRETER'))
					            set(pr.get('DROPDOWN_HALIGN'), 'Value', el.get(prop).get('HALIGN'))
					            set(pr.get('DROPDOWN_VALIGN'), 'Value', el.get(prop).get('VALIGN'))
					            
					        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
					            set(pr.get('EDITFIELD_X'), 'Value', el.get(prop).get('X'))
					            set(pr.get('EDITFIELD_Y'), 'Value', el.get(prop).get('Y'))
					            set(pr.get('EDITFIELD_Z'), 'Value', el.get(prop).get('Z'))
					            set(pr.get('EDITFIELD_TXT'), 'Value', el.get(prop).get('TXT'))
					            
					            set(pr.get('BUTTON_FONTCOLOR'), 'BackgroundColor', el.get(prop).get('FONTCOLOR'))
					            set(pr.get('EDITFIELD_FONTSIZE'), 'Value', el.get(prop).get('FONTSIZE'))
					            set(pr.get('SLIDER_FONTSIZE'), 'Value', el.get(prop).get('FONTSIZE'))
					            set(pr.get('EDITFIELD_ROTATION'), 'Value', el.get(prop).get('ROTATION'))
					            set(pr.get('SLIDER_ROTATION'), 'Value', el.get(prop).get('ROTATION'))
					
					            set(pr.get('EDITFIELD_FONTNAME'), 'Value', el.get(prop).get('FONTNAME'))
					            set(pr.get('DROPDOWN_FONTWEIGHT'), 'Value', el.get(prop).get('FONTWEIGHT'))
					            set(pr.get('DROPDOWN_INTERPRETER'), 'Value', el.get(prop).get('INTERPRETER'))
					            set(pr.get('DROPDOWN_HALIGN'), 'Value', el.get(prop).get('HALIGN'))
					            set(pr.get('DROPDOWN_VALIGN'), 'Value', el.get(prop).get('VALIGN'))
					
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('X'), 'Callback')
					                set(pr.get('EDITFIELD_X'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('Y'), 'Callback')
					                set(pr.get('EDITFIELD_Y'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('Z'), 'Callback')
					                set(pr.get('EDITFIELD_Z'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('TXT'), 'Callback')
					                set(pr.get('EDITFIELD_TXT'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FONTSIZE'), 'Callback')
					                set(pr.get('BUTTON_FONTCOLOR'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FONTSIZE'), 'Callback')
					                set(pr.get('EDITFIELD_FONTSIZE'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_FONTSIZE'), 'Enable', pr.get('ENABLE'))
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('ROTATION'), 'Callback')
					                set(pr.get('EDITFIELD_ROTATION'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_ROTATION'), 'Enable', pr.get('ENABLE'))
					            end
					            
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FONTNAME'), 'Callback')
					                set(pr.get('EDITFIELD_FONTNAME'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FONTWEIGHT'), 'Callback')
					                set(pr.get('DROPDOWN_FONTWEIGHT'), 'Enable', 'off')
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('INTERPRETER'), 'Callback')
					                set(pr.get('DROPDOWN_INTERPRETER'), 'Enable', 'off')
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('HALIGN'), 'Callback')
					                set(pr.get('DROPDOWN_HALIGN'), 'Enable', 'off')
					            end
					            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('VALIGN'), 'Callback')
					                set(pr.get('DROPDOWN_VALIGN'), 'Enable', 'off')
					            end
					            
					        case Category.RESULT
					            value = el.getr(prop);
					            
					            if isa(value, 'NoValue')
					                set(pr.get('EDITFIELD_X'), ...
					                    'Value', el.get(prop).getPropDefault('X'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_Y'), ...
					                    'Value', el.get(prop).getPropDefault('Y'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_Z'), ...
					                    'Value', el.get(prop).getPropDefault('Z'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_TXT'), ...
					                    'Value', el.get(prop).getPropDefault('TXT'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					
					                set(pr.get('BUTTON_FONTCOLOR'), ...
					                    'BackgroundColor', el.get(prop).getPropDefault('FONTCOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_FONTSIZE'), ...
					                    'Value', el.get(prop).getPropDefault('FONTSIZE'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_FONTSIZE'), ...
					                    'Value', el.get(prop).getPropDefault('FONTSIZE'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_ROTATION'), ...
					                    'Value', el.get(prop).getPropDefault('ROTATION'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_ROTATION'), ...
					                    'Value', el.get(prop).getPropDefault('ROTATION'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					
					                set(pr.get('EDITFIELD_FONTNAME'), ...
					                    'Value', el.get(prop).getPropDefault('FONTNAME'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('DROPDOWN_FONTWEIGHT'), ...
					                    'Value', el.get(prop).getPropDefault('FONTWEIGHT'), ...
					                    'Editable', 'off' ...
					                    )
					                set(pr.get('DROPDOWN_INTERPRETER'), ...
					                    'Value', el.get(prop).getPropDefault('INTERPRETER'), ...
					                    'Editable', 'off' ...
					                    )
					                set(pr.get('DROPDOWN_HALIGN'), ...
					                    'Value', el.get(prop).getPropDefault('HALIGN'), ...
					                    'Editable', 'off' ...
					                    )
					                set(pr.get('DROPDOWN_VALIGN'), ...
					                    'Value', el.get(prop).getPropDefault('VALIGN'), ...
					                    'Editable', 'off' ...
					                    )
					            else
					                set(pr.get('EDITFIELD_X'), ...
					                    'Value', el.get(prop).get('X'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_Y'), ...
					                    'Value', el.get(prop).get('Y'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_Z'), ...
					                    'Value', el.get(prop).get('Z'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_TXT'), ...
					                    'Value', el.get(prop).get('TXT'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					
					                set(pr.get('BUTTON_FONTCOLOR'), ...
					                    'BackgroundColor', el.get(prop).get('FONTCOLOR'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_FONTSIZE'), ...
					                    'Value', el.get(prop).get('FONTSIZE'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_FONTSIZE'), ...
					                    'Value', el.get(prop).get('FONTSIZE'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('EDITFIELD_ROTATION'), ...
					                    'Value', el.get(prop).get('ROTATION'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('SLIDER_ROTATION'), ...
					                    'Value', el.get(prop).get('ROTATION'), ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					
					                set(pr.get('EDITFIELD_FONTNAME'), ...
					                    'Value', el.get(prop).get('FONTNAME'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					                set(pr.get('DROPDOWN_FONTWEIGHT'), ...
					                    'Value', el.get(prop).get('FONTWEIGHT'), ...
					                    'Editable', 'off' ...
					                    )
					                set(pr.get('DROPDOWN_INTERPRETER'), ...
					                    'Value', el.get(prop).get('INTERPRETER'), ...
					                    'Editable', 'off' ...
					                    )
					                set(pr.get('DROPDOWN_HALIGN'), ...
					                    'Value', el.get(prop).get('HALIGN'), ...
					                    'Editable', 'off' ...
					                    )
					                set(pr.get('DROPDOWN_VALIGN'), ...
					                    'Value', el.get(prop).get('VALIGN'), ...
					                    'Editable', 'off' ...
					                    )
					            end
					    end
					end
					
				case SettingsTextPP.REDRAW % __SettingsTextPP.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
						w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					
					    set(pr.get('EDITFIELD_X'),   'Position', [s(.3)           s(6.1)   .10*w_p     s(1.75)])
					    set(pr.get('EDITFIELD_Y'),   'Position', [s(.6)+.10*w_p   s(6.1)   .10*w_p     s(1.75)])
					    set(pr.get('EDITFIELD_Z'),   'Position', [s(.9)+.20*w_p   s(6.1)   .10*w_p     s(1.75)])
					    set(pr.get('EDITFIELD_TXT'), 'Position', [s(1.2)+.30*w_p  s(6.1)  .60*w_p     s(1.75)])
					    
					    set(pr.get('BUTTON_FONTCOLOR'),   'Position', [s(.3)            s(3.2)  .20*w_p   s(1.7)])
					    set(pr.get('EDITFIELD_FONTSIZE'), 'Position', [s(.6)+.20*w_p	s(3.2)  .15*w_p   s(1.7)])
					    set(pr.get('SLIDER_FONTSIZE'),    'Position', [s(.9)+.35*w_p	s(4.75) .20*w_p   3]) % the height of a slider cannot be changed
					    set(pr.get('EDITFIELD_ROTATION'), 'Position', [s(1.5)+.55*w_p	s(3.2)  .15*w_p   s(1.7)])
					    set(pr.get('SLIDER_ROTATION'),    'Position', [s(1.8)+.70*w_p	s(4.75) .20*w_p   3]) % the height of a slider cannot be changed
					    
					    set(pr.get('EDITFIELD_FONTNAME'),   'Position', [s(.3)          s(.3)   .20*w_p     s(1.75)])    
					    set(pr.get('DROPDOWN_FONTWEIGHT'),  'Position', [s(.6)+.20*w_p  s(.3)   .18*w_p     s(1.75)])    
					    set(pr.get('DROPDOWN_INTERPRETER'), 'Position', [s(.9)+.38*w_p  s(.3)   .18*w_p     s(1.75)])    
					    set(pr.get('DROPDOWN_HALIGN'),      'Position', [s(1.2)+.56*w_p	s(.3)   .18*w_p     s(1.75)])    
					    set(pr.get('DROPDOWN_VALIGN'),      'Position', [s(1.5)+.74*w_p	s(.3)   .18*w_p     s(1.75)])    
					end
					
				case SettingsTextPP.DELETE % __SettingsTextPP.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('EDITFIELD_X', Element.getNoValue())
					    pr.set('EDITFIELD_Y', Element.getNoValue())
					    pr.set('EDITFIELD_Z', Element.getNoValue())
					    pr.set('EDITFIELD_TXT', Element.getNoValue())
					    
					    pr.set('BUTTON_FONTCOLOR', Element.getNoValue())
					    pr.set('EDITFIELD_FONTSIZE', Element.getNoValue())
					    pr.set('SLIDER_FONTSIZE', Element.getNoValue())
					    pr.set('EDITFIELD_ROTATION', Element.getNoValue())
					    pr.set('SLIDER_ROTATION', Element.getNoValue())
					
					    pr.set('EDITFIELD_FONTNAME', Element.getNoValue())
					    pr.set('DROPDOWN_FONTWEIGHT', Element.getNoValue())
					    pr.set('DROPDOWN_INTERPRETER', Element.getNoValue())
					    pr.set('DROPDOWN_HALIGN', Element.getNoValue())
					    pr.set('DROPDOWN_VALIGN', Element.getNoValue())
					end
					
				otherwise
					if prop <= SettingsPP.getPropNumber()
						value = calculateValue@SettingsPP(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_editfield_x(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    el.get(prop).set('X', get(pr.get('EDITFIELD_X'), 'Value'))
			end
			function cb_editfield_y(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    el.get(prop).set('Y', get(pr.get('EDITFIELD_Y'), 'Value'))
			end
			function cb_editfield_z(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    el.get(prop).set('Z', get(pr.get('EDITFIELD_Z'), 'Value'))
			end
			function cb_editfield_txt(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    el.get(prop).set('TXT', get(pr.get('EDITFIELD_TXT'), 'Value'))
			end
			function cb_button_fontcolor(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    new_color = uisetcolor(el.get(prop).get('FONTCOLOR'));
			    if ~isequal(new_color, el.get(prop).get('FONTCOLOR'))
			        el.get(prop).set('FONTCOLOR', new_color)
			
			        pr.get('UPDATE')
			    end
			end
			function cb_editfield_fontsize(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('FONTSIZE', get(pr.get('EDITFIELD_FONTSIZE'), 'Value'))
			
				pr.get('UPDATE')
			end
			function cb_slider_fontsize(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('FONTSIZE', max(0.01, get(pr.get('SLIDER_FONTSIZE'), 'Value')))
			
				pr.get('UPDATE')
			end
			function cb_editfield_rotation(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('ROTATION', get(pr.get('EDITFIELD_ROTATION'), 'Value'))
			
				pr.get('UPDATE')
			end
			function cb_slider_rotation(~, ~)
			
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			    
			    el.get(prop).set('ROTATION', get(pr.get('SLIDER_ROTATION'), 'Value'))
			
				pr.get('UPDATE')
			end
			function cb_editfield_fontname(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    el.get(prop).set('FONTNAME', get(pr.get('EDITFIELD_FONTNAME'), 'Value'))
			end
			function cb_dropdown_fontweight(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    el.get(prop).set('FONTWEIGHT', get(pr.get('DROPDOWN_FONTWEIGHT'), 'Value'))
			end
			function cb_dropdown_interpreter(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    el.get(prop).set('INTERPRETER', get(pr.get('DROPDOWN_INTERPRETER'), 'Value'))
			end
			function cb_dropdown_halign(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    el.get(prop).set('HALIGN', get(pr.get('DROPDOWN_HALIGN'), 'Value'))
			end
			function cb_dropdown_valign(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    el.get(prop).set('VALIGN', get(pr.get('DROPDOWN_VALIGN'), 'Value'))
			end
		end
	end
end
