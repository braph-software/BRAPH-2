classdef CompareGroupPP_CpDict < PanelProp
	%CompareGroupPP_CpDict plots the panel to manage the comparisons of a group analysis.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% CompareGroupPP_CpDict plots the panel to manage the comparisons of a group analysis.
	% It is intended to be used only with the property CP_DICT of CompareGroup.
	%
	% CompareGroupPP_CpDict methods (constructor):
	%  CompareGroupPP_CpDict - constructor
	%
	% CompareGroupPP_CpDict methods:
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
	% CompareGroupPP_CpDict methods (display):
	%  tostring - string with information about the comparison plot
	%  disp - displays information about the comparison plot
	%  tree - displays the tree of the comparison plot
	%
	% CompareGroupPP_CpDict methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two comparison plot are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the comparison plot
	%
	% CompareGroupPP_CpDict methods (save/load, Static):
	%  save - saves BRAPH2 comparison plot as b2 file
	%  load - loads a BRAPH2 comparison plot from a b2 file
	%
	% CompareGroupPP_CpDict method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the comparison plot
	%
	% CompareGroupPP_CpDict method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the comparison plot
	%
	% CompareGroupPP_CpDict methods (inspection, Static):
	%  getClass - returns the class of the comparison plot
	%  getSubclasses - returns all subclasses of CompareGroupPP_CpDict
	%  getProps - returns the property list of the comparison plot
	%  getPropNumber - returns the property number of the comparison plot
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
	% CompareGroupPP_CpDict methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% CompareGroupPP_CpDict methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% CompareGroupPP_CpDict methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% CompareGroupPP_CpDict methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?CompareGroupPP_CpDict; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">CompareGroupPP_CpDict constants</a>.
	%
	%
	% See also uitable, CompareGroup, ComparisonGroup.
	
	properties (Constant) % properties
		TABLE_HEIGHT = PanelProp.getPropNumber() + 1;
		TABLE_HEIGHT_TAG = 'TABLE_HEIGHT';
		TABLE_HEIGHT_CATEGORY = Category.GUI;
		TABLE_HEIGHT_FORMAT = Format.SIZE;
		
		SELECTED = PanelProp.getPropNumber() + 2;
		SELECTED_TAG = 'SELECTED';
		SELECTED_CATEGORY = Category.GUI;
		SELECTED_FORMAT = Format.CVECTOR;
		
		TABLE = PanelProp.getPropNumber() + 3;
		TABLE_TAG = 'TABLE';
		TABLE_CATEGORY = Category.EVANESCENT;
		TABLE_FORMAT = Format.HANDLE;
		
		CONTEXTMENU = PanelProp.getPropNumber() + 4;
		CONTEXTMENU_TAG = 'CONTEXTMENU';
		CONTEXTMENU_CATEGORY = Category.EVANESCENT;
		CONTEXTMENU_FORMAT = Format.HANDLE;
		
		GUI_F_DICT = PanelProp.getPropNumber() + 5;
		GUI_F_DICT_TAG = 'GUI_F_DICT';
		GUI_F_DICT_CATEGORY = Category.GUI;
		GUI_F_DICT_FORMAT = Format.IDICT;
		
		GUI_CP_DICT = PanelProp.getPropNumber() + 6;
		GUI_CP_DICT_TAG = 'GUI_CP_DICT';
		GUI_CP_DICT_CATEGORY = Category.GUI;
		GUI_CP_DICT_FORMAT = Format.IDICT;
		
		GUI_B_DICT = PanelProp.getPropNumber() + 7;
		GUI_B_DICT_TAG = 'GUI_B_DICT';
		GUI_B_DICT_CATEGORY = Category.GUI;
		GUI_B_DICT_FORMAT = Format.IDICT;
		
		GUI_BG_DICT = PanelProp.getPropNumber() + 8;
		GUI_BG_DICT_TAG = 'GUI_BG_DICT';
		GUI_BG_DICT_CATEGORY = Category.GUI;
		GUI_BG_DICT_FORMAT = Format.IDICT;
	end
	methods % constructor
		function pr = CompareGroupPP_CpDict(varargin)
			%CompareGroupPP_CpDict() creates a comparison plot.
			%
			% CompareGroupPP_CpDict(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% CompareGroupPP_CpDict(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pr = pr@PanelProp(varargin{:});
		end
	end
	methods (Static) % inspection
		function pr_class = getClass()
			%GETCLASS returns the class of the comparison plot.
			%
			% CLASS = CompareGroupPP_CpDict.GETCLASS() returns the class 'CompareGroupPP_CpDict'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the comparison plot PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('CompareGroupPP_CpDict') returns 'CompareGroupPP_CpDict'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('CompareGroupPP_CpDict')
			%  are less computationally efficient.
			
			pr_class = 'CompareGroupPP_CpDict';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the comparison plot.
			%
			% LIST = CompareGroupPP_CpDict.GETSUBCLASSES() returns all subclasses of 'CompareGroupPP_CpDict'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the comparison plot PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('CompareGroupPP_CpDict') returns all subclasses of 'CompareGroupPP_CpDict'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('CompareGroupPP_CpDict')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('CompareGroupPP_CpDict', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of comparison plot.
			%
			% PROPS = CompareGroupPP_CpDict.GETPROPS() returns the property list of comparison plot
			%  as a row vector.
			%
			% PROPS = CompareGroupPP_CpDict.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the comparison plot PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('CompareGroupPP_CpDict'[, CATEGORY]) returns the property list of 'CompareGroupPP_CpDict'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('CompareGroupPP_CpDict')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						CompareGroupPP_CpDict.TABLE_HEIGHT ...
						CompareGroupPP_CpDict.SELECTED ...
						CompareGroupPP_CpDict.TABLE ...
						CompareGroupPP_CpDict.CONTEXTMENU ...
						CompareGroupPP_CpDict.GUI_F_DICT ...
						CompareGroupPP_CpDict.GUI_CP_DICT ...
						CompareGroupPP_CpDict.GUI_B_DICT ...
						CompareGroupPP_CpDict.GUI_BG_DICT ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						PanelProp.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						PanelProp.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						PanelProp.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						PanelProp.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						PanelProp.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						PanelProp.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelProp.getProps(Category.EVANESCENT) ...
						CompareGroupPP_CpDict.TABLE ...
						CompareGroupPP_CpDict.CONTEXTMENU ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						CompareGroupPP_CpDict.TABLE_HEIGHT ...
						CompareGroupPP_CpDict.SELECTED ...
						CompareGroupPP_CpDict.GUI_F_DICT ...
						CompareGroupPP_CpDict.GUI_CP_DICT ...
						CompareGroupPP_CpDict.GUI_B_DICT ...
						CompareGroupPP_CpDict.GUI_BG_DICT ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of comparison plot.
			%
			% N = CompareGroupPP_CpDict.GETPROPNUMBER() returns the property number of comparison plot.
			%
			% N = CompareGroupPP_CpDict.GETPROPNUMBER(CATEGORY) returns the property number of comparison plot
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the comparison plot PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('CompareGroupPP_CpDict') returns the property number of 'CompareGroupPP_CpDict'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('CompareGroupPP_CpDict')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(CompareGroupPP_CpDict.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in comparison plot/error.
			%
			% CHECK = CompareGroupPP_CpDict.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(CompareGroupPP_CpDict, PROP) checks whether PROP exists for CompareGroupPP_CpDict.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:CompareGroupPP_CpDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:CompareGroupPP_CpDict:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:CompareGroupPP_CpDict:WrongInput]
			%  Element.EXISTSPROP(CompareGroupPP_CpDict, PROP) throws error if PROP does NOT exist for CompareGroupPP_CpDict.
			%   Error id: [BRAPH2:CompareGroupPP_CpDict:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('CompareGroupPP_CpDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == CompareGroupPP_CpDict.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':CompareGroupPP_CpDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CompareGroupPP_CpDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for CompareGroupPP_CpDict.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in comparison plot/error.
			%
			% CHECK = CompareGroupPP_CpDict.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(CompareGroupPP_CpDict, TAG) checks whether TAG exists for CompareGroupPP_CpDict.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:CompareGroupPP_CpDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:CompareGroupPP_CpDict:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:CompareGroupPP_CpDict:WrongInput]
			%  Element.EXISTSTAG(CompareGroupPP_CpDict, TAG) throws error if TAG does NOT exist for CompareGroupPP_CpDict.
			%   Error id: [BRAPH2:CompareGroupPP_CpDict:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('CompareGroupPP_CpDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			comparegrouppp_cpdict_tag_list = cellfun(@(x) CompareGroupPP_CpDict.getPropTag(x), num2cell(CompareGroupPP_CpDict.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, comparegrouppp_cpdict_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':CompareGroupPP_CpDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CompareGroupPP_CpDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for CompareGroupPP_CpDict.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(CompareGroupPP_CpDict, POINTER) returns property number of POINTER of CompareGroupPP_CpDict.
			%  PROPERTY = PR.GETPROPPROP(CompareGroupPP_CpDict, POINTER) returns property number of POINTER of CompareGroupPP_CpDict.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('CompareGroupPP_CpDict')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				comparegrouppp_cpdict_tag_list = cellfun(@(x) CompareGroupPP_CpDict.getPropTag(x), num2cell(CompareGroupPP_CpDict.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, comparegrouppp_cpdict_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(CompareGroupPP_CpDict, POINTER) returns tag of POINTER of CompareGroupPP_CpDict.
			%  TAG = PR.GETPROPTAG(CompareGroupPP_CpDict, POINTER) returns tag of POINTER of CompareGroupPP_CpDict.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('CompareGroupPP_CpDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case CompareGroupPP_CpDict.TABLE_HEIGHT
						tag = CompareGroupPP_CpDict.TABLE_HEIGHT_TAG;
					case CompareGroupPP_CpDict.SELECTED
						tag = CompareGroupPP_CpDict.SELECTED_TAG;
					case CompareGroupPP_CpDict.TABLE
						tag = CompareGroupPP_CpDict.TABLE_TAG;
					case CompareGroupPP_CpDict.CONTEXTMENU
						tag = CompareGroupPP_CpDict.CONTEXTMENU_TAG;
					case CompareGroupPP_CpDict.GUI_F_DICT
						tag = CompareGroupPP_CpDict.GUI_F_DICT_TAG;
					case CompareGroupPP_CpDict.GUI_CP_DICT
						tag = CompareGroupPP_CpDict.GUI_CP_DICT_TAG;
					case CompareGroupPP_CpDict.GUI_B_DICT
						tag = CompareGroupPP_CpDict.GUI_B_DICT_TAG;
					case CompareGroupPP_CpDict.GUI_BG_DICT
						tag = CompareGroupPP_CpDict.GUI_BG_DICT_TAG;
					otherwise
						tag = getPropTag@PanelProp(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(CompareGroupPP_CpDict, POINTER) returns category of POINTER of CompareGroupPP_CpDict.
			%  CATEGORY = PR.GETPROPCATEGORY(CompareGroupPP_CpDict, POINTER) returns category of POINTER of CompareGroupPP_CpDict.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('CompareGroupPP_CpDict')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = CompareGroupPP_CpDict.getPropProp(pointer);
			
			switch prop
				case CompareGroupPP_CpDict.TABLE_HEIGHT
					prop_category = CompareGroupPP_CpDict.TABLE_HEIGHT_CATEGORY;
				case CompareGroupPP_CpDict.SELECTED
					prop_category = CompareGroupPP_CpDict.SELECTED_CATEGORY;
				case CompareGroupPP_CpDict.TABLE
					prop_category = CompareGroupPP_CpDict.TABLE_CATEGORY;
				case CompareGroupPP_CpDict.CONTEXTMENU
					prop_category = CompareGroupPP_CpDict.CONTEXTMENU_CATEGORY;
				case CompareGroupPP_CpDict.GUI_F_DICT
					prop_category = CompareGroupPP_CpDict.GUI_F_DICT_CATEGORY;
				case CompareGroupPP_CpDict.GUI_CP_DICT
					prop_category = CompareGroupPP_CpDict.GUI_CP_DICT_CATEGORY;
				case CompareGroupPP_CpDict.GUI_B_DICT
					prop_category = CompareGroupPP_CpDict.GUI_B_DICT_CATEGORY;
				case CompareGroupPP_CpDict.GUI_BG_DICT
					prop_category = CompareGroupPP_CpDict.GUI_BG_DICT_CATEGORY;
				otherwise
					prop_category = getPropCategory@PanelProp(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(CompareGroupPP_CpDict, POINTER) returns format of POINTER of CompareGroupPP_CpDict.
			%  FORMAT = PR.GETPROPFORMAT(CompareGroupPP_CpDict, POINTER) returns format of POINTER of CompareGroupPP_CpDict.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('CompareGroupPP_CpDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = CompareGroupPP_CpDict.getPropProp(pointer);
			
			switch prop
				case CompareGroupPP_CpDict.TABLE_HEIGHT
					prop_format = CompareGroupPP_CpDict.TABLE_HEIGHT_FORMAT;
				case CompareGroupPP_CpDict.SELECTED
					prop_format = CompareGroupPP_CpDict.SELECTED_FORMAT;
				case CompareGroupPP_CpDict.TABLE
					prop_format = CompareGroupPP_CpDict.TABLE_FORMAT;
				case CompareGroupPP_CpDict.CONTEXTMENU
					prop_format = CompareGroupPP_CpDict.CONTEXTMENU_FORMAT;
				case CompareGroupPP_CpDict.GUI_F_DICT
					prop_format = CompareGroupPP_CpDict.GUI_F_DICT_FORMAT;
				case CompareGroupPP_CpDict.GUI_CP_DICT
					prop_format = CompareGroupPP_CpDict.GUI_CP_DICT_FORMAT;
				case CompareGroupPP_CpDict.GUI_B_DICT
					prop_format = CompareGroupPP_CpDict.GUI_B_DICT_FORMAT;
				case CompareGroupPP_CpDict.GUI_BG_DICT
					prop_format = CompareGroupPP_CpDict.GUI_BG_DICT_FORMAT;
				otherwise
					prop_format = getPropFormat@PanelProp(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(CompareGroupPP_CpDict, POINTER) returns description of POINTER of CompareGroupPP_CpDict.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(CompareGroupPP_CpDict, POINTER) returns description of POINTER of CompareGroupPP_CpDict.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('CompareGroupPP_CpDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = CompareGroupPP_CpDict.getPropProp(pointer);
			
			switch prop
				case CompareGroupPP_CpDict.TABLE_HEIGHT
					prop_description = 'TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.';
				case CompareGroupPP_CpDict.SELECTED
					prop_description = 'SELECTED (gui, cvector) is the list of selected items.';
				case CompareGroupPP_CpDict.TABLE
					prop_description = 'TABLE (evanescent, handle) is the table.';
				case CompareGroupPP_CpDict.CONTEXTMENU
					prop_description = 'CONTEXTMENU (evanescent, handle) is the context menu.';
				case CompareGroupPP_CpDict.GUI_F_DICT
					prop_description = 'GUI_F_DICT (gui, idict) contains the GUIs for the comparison figures.';
				case CompareGroupPP_CpDict.GUI_CP_DICT
					prop_description = 'GUI_CP_DICT (gui, idict) contains the GUIs for the comparison.';
				case CompareGroupPP_CpDict.GUI_B_DICT
					prop_description = 'GUI_B_DICT (gui, idict) contains the GUIs for the brain measures comparison figures.';
				case CompareGroupPP_CpDict.GUI_BG_DICT
					prop_description = 'GUI_BG_DICT (gui, idict) contains the GUIs for the brain graph comparison figures.';
				case CompareGroupPP_CpDict.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case CompareGroupPP_CpDict.NAME
					prop_description = 'NAME (constant, string) is the name of the comparison panel.';
				case CompareGroupPP_CpDict.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the comparison panel.';
				case CompareGroupPP_CpDict.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the comparison panel.';
				case CompareGroupPP_CpDict.ID
					prop_description = 'ID (data, string) is a few-letter code for the comparison panel.';
				case CompareGroupPP_CpDict.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the comparison panel.';
				case CompareGroupPP_CpDict.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the comparison panel.';
				case CompareGroupPP_CpDict.EL
					prop_description = 'EL (data, item) is the element.';
				case CompareGroupPP_CpDict.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case CompareGroupPP_CpDict.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case CompareGroupPP_CpDict.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the table.';
				case CompareGroupPP_CpDict.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case CompareGroupPP_CpDict.SHOW
					prop_description = 'SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.';
				case CompareGroupPP_CpDict.HIDE
					prop_description = 'HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.';
				case CompareGroupPP_CpDict.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
				case CompareGroupPP_CpDict.CLOSE
					prop_description = 'CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figures.';
				otherwise
					prop_description = getPropDescription@PanelProp(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(CompareGroupPP_CpDict, POINTER) returns settings of POINTER of CompareGroupPP_CpDict.
			%  SETTINGS = PR.GETPROPSETTINGS(CompareGroupPP_CpDict, POINTER) returns settings of POINTER of CompareGroupPP_CpDict.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('CompareGroupPP_CpDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = CompareGroupPP_CpDict.getPropProp(pointer);
			
			switch prop
				case CompareGroupPP_CpDict.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case CompareGroupPP_CpDict.SELECTED
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case CompareGroupPP_CpDict.TABLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case CompareGroupPP_CpDict.CONTEXTMENU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case CompareGroupPP_CpDict.GUI_F_DICT
					prop_settings = 'GUIFig';
				case CompareGroupPP_CpDict.GUI_CP_DICT
					prop_settings = 'GUIElement';
				case CompareGroupPP_CpDict.GUI_B_DICT
					prop_settings = 'GUIFig';
				case CompareGroupPP_CpDict.GUI_BG_DICT
					prop_settings = 'GUIFig';
				case CompareGroupPP_CpDict.TEMPLATE
					prop_settings = 'CompareGroupPP_CpDict';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = CompareGroupPP_CpDict.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = CompareGroupPP_CpDict.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(CompareGroupPP_CpDict, POINTER) returns the default value of POINTER of CompareGroupPP_CpDict.
			%  DEFAULT = PR.GETPROPDEFAULT(CompareGroupPP_CpDict, POINTER) returns the default value of POINTER of CompareGroupPP_CpDict.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('CompareGroupPP_CpDict')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = CompareGroupPP_CpDict.getPropProp(pointer);
			
			switch prop
				case CompareGroupPP_CpDict.TABLE_HEIGHT
					prop_default = s(30);
				case CompareGroupPP_CpDict.SELECTED
					prop_default = Format.getFormatDefault(Format.CVECTOR, CompareGroupPP_CpDict.getPropSettings(prop));
				case CompareGroupPP_CpDict.TABLE
					prop_default = Format.getFormatDefault(Format.HANDLE, CompareGroupPP_CpDict.getPropSettings(prop));
				case CompareGroupPP_CpDict.CONTEXTMENU
					prop_default = Format.getFormatDefault(Format.HANDLE, CompareGroupPP_CpDict.getPropSettings(prop));
				case CompareGroupPP_CpDict.GUI_F_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, CompareGroupPP_CpDict.getPropSettings(prop));
				case CompareGroupPP_CpDict.GUI_CP_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, CompareGroupPP_CpDict.getPropSettings(prop));
				case CompareGroupPP_CpDict.GUI_B_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, CompareGroupPP_CpDict.getPropSettings(prop));
				case CompareGroupPP_CpDict.GUI_BG_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, CompareGroupPP_CpDict.getPropSettings(prop));
				case CompareGroupPP_CpDict.ELCLASS
					prop_default = 'CompareGroupPP_CpDict';
				case CompareGroupPP_CpDict.NAME
					prop_default = 'CompareGroupPP_CpDict';
				case CompareGroupPP_CpDict.DESCRIPTION
					prop_default = 'CompareGroupPP_CpDict plots the panel to manage the comparisons of a group analysis.';
				case CompareGroupPP_CpDict.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, CompareGroupPP_CpDict.getPropSettings(prop));
				case CompareGroupPP_CpDict.ID
					prop_default = 'CompareGroupPP_CpDict';
				case CompareGroupPP_CpDict.LABEL
					prop_default = 'CompareGroupPP_CpDict label';
				case CompareGroupPP_CpDict.NOTES
					prop_default = 'CompareGroupPP_CpDict';
				case CompareGroupPP_CpDict.EL
					prop_default = CompareGroup();
				case CompareGroupPP_CpDict.PROP
					prop_default = CompareGroup.CP_DICT;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = CompareGroupPP_CpDict.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = CompareGroupPP_CpDict.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(CompareGroupPP_CpDict, POINTER) returns the conditioned default value of POINTER of CompareGroupPP_CpDict.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(CompareGroupPP_CpDict, POINTER) returns the conditioned default value of POINTER of CompareGroupPP_CpDict.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('CompareGroupPP_CpDict')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = CompareGroupPP_CpDict.getPropProp(pointer);
			
			prop_default = CompareGroupPP_CpDict.conditioning(prop, CompareGroupPP_CpDict.getPropDefault(prop));
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
			
			prop = CompareGroupPP_CpDict.getPropProp(pointer);
			
			switch prop
				case CompareGroupPP_CpDict.SELECTED % __CompareGroupPP_CpDict.SELECTED__
					if isrow(value)
					    value = value';
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = conditioning@PanelProp(pointer, value);
					end
			end
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
			%  CHECK = Element.CHECKPROP(CompareGroupPP_CpDict, PROP, VALUE) checks VALUE format for PROP of CompareGroupPP_CpDict.
			%  CHECK = PR.CHECKPROP(CompareGroupPP_CpDict, PROP, VALUE) checks VALUE format for PROP of CompareGroupPP_CpDict.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:CompareGroupPP_CpDict:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:CompareGroupPP_CpDict:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(CompareGroupPP_CpDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CompareGroupPP_CpDict.
			%   Error id: €BRAPH2.STR€:CompareGroupPP_CpDict:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(CompareGroupPP_CpDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CompareGroupPP_CpDict.
			%   Error id: €BRAPH2.STR€:CompareGroupPP_CpDict:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('CompareGroupPP_CpDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = CompareGroupPP_CpDict.getPropProp(pointer);
			
			switch prop
				case CompareGroupPP_CpDict.TABLE_HEIGHT % __CompareGroupPP_CpDict.TABLE_HEIGHT__
					check = Format.checkFormat(Format.SIZE, value, CompareGroupPP_CpDict.getPropSettings(prop));
				case CompareGroupPP_CpDict.SELECTED % __CompareGroupPP_CpDict.SELECTED__
					check = Format.checkFormat(Format.CVECTOR, value, CompareGroupPP_CpDict.getPropSettings(prop));
				case CompareGroupPP_CpDict.TABLE % __CompareGroupPP_CpDict.TABLE__
					check = Format.checkFormat(Format.HANDLE, value, CompareGroupPP_CpDict.getPropSettings(prop));
				case CompareGroupPP_CpDict.CONTEXTMENU % __CompareGroupPP_CpDict.CONTEXTMENU__
					check = Format.checkFormat(Format.HANDLE, value, CompareGroupPP_CpDict.getPropSettings(prop));
				case CompareGroupPP_CpDict.GUI_F_DICT % __CompareGroupPP_CpDict.GUI_F_DICT__
					check = Format.checkFormat(Format.IDICT, value, CompareGroupPP_CpDict.getPropSettings(prop));
				case CompareGroupPP_CpDict.GUI_CP_DICT % __CompareGroupPP_CpDict.GUI_CP_DICT__
					check = Format.checkFormat(Format.IDICT, value, CompareGroupPP_CpDict.getPropSettings(prop));
				case CompareGroupPP_CpDict.GUI_B_DICT % __CompareGroupPP_CpDict.GUI_B_DICT__
					check = Format.checkFormat(Format.IDICT, value, CompareGroupPP_CpDict.getPropSettings(prop));
				case CompareGroupPP_CpDict.GUI_BG_DICT % __CompareGroupPP_CpDict.GUI_BG_DICT__
					check = Format.checkFormat(Format.IDICT, value, CompareGroupPP_CpDict.getPropSettings(prop));
				case CompareGroupPP_CpDict.TEMPLATE % __CompareGroupPP_CpDict.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, CompareGroupPP_CpDict.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':CompareGroupPP_CpDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CompareGroupPP_CpDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' CompareGroupPP_CpDict.getPropTag(prop) ' (' CompareGroupPP_CpDict.getFormatTag(CompareGroupPP_CpDict.getPropFormat(prop)) ').'] ...
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
				case CompareGroupPP_CpDict.TABLE % __CompareGroupPP_CpDict.TABLE__
					table = uitable( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'table', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'ColumnSortable', true, ...
					    'ColumnName', {'', 'Measure', 'Shape', 'Scope', 'Notes'}, ...
					    'ColumnFormat', {'logical',  'char', 'char', 'char', 'char'}, ...
					    'ColumnWidth', {30, 'auto', 'auto', 'auto', 'auto'}, ...
					    'ColumnEditable', [true false false false false], ...
					    'CellEditCallback', {@cb_table} ...
					    );
					value = table;
					
				case CompareGroupPP_CpDict.CONTEXTMENU % __CompareGroupPP_CpDict.CONTEXTMENU__
					contextmenu = uicontextmenu( ...
					    'Parent', ancestor(pr.get('H'), 'figure'), ...
					    'Tag', 'CONTEXTMENU' ...
					    );
					menu_select_all = uimenu( ...
						'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_SELECT_ALL', ...
					    'Text', 'Select All Comparisons', ...
					    'MenuSelectedFcn', {@cb_select_all} ...
					    );
					menu_clear_selection = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_CLEAR_SELECTION', ...
					    'Text', 'Clear Selection', ...
					    'MenuSelectedFcn', {@cb_clear_selection} ...
					    );
					menu_invert_selection = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_INVERT_SELECTION', ...
					    'Text', 'Invert Selection', ...
					    'MenuSelectedFcn', {@cb_invert_selection} ...
					    );
					menu_calculate = uimenu( ...
						'Separator', 'on', ...
						'Parent', contextmenu, ...
						'Tag', 'MENU_CALCULATE', ...
					    'Text', 'Calculate Selected Comparisons', ...
						'MenuSelectedFcn', {@cb_calculate} ...
					    );
					menu_open_mbrain = uimenu( ...
						'Separator', 'on', ...
						'Parent', contextmenu, ...
						'Tag', 'MENU_OPEN_MBRAIN', ...
						'Text', 'Plot Selected Comparisons on Brain ...', ...
						'MenuSelectedFcn', {@cb_open_mbrain} ... % % %
						);
					menu_hide_mbrain = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_MBRAIN', ...
					    'Text', 'Hide Selected Brain-Plots', ...
					    'MenuSelectedFcn', {@cb_hide_mbrain} ... % % %
						);
					menu_open_plots = uimenu( ...
						'Parent', contextmenu, ...
						'Tag', 'MENU_OPEN_PLOTS', ...
						'Text', 'Plot Selected Comparisons ...', ...
						'MenuSelectedFcn', {@cb_open_plots} ...
						);
					menu_hide_plots = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_PLOTS', ...
					    'Text', 'Hide Selected Plots', ...
					    'MenuSelectedFcn', {@cb_hide_plots} ...
						);
					menu_open_elements = uimenu( ...
						'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_OPEN_ELEMENTS', ...
					    'Text', 'Data Selected Comparisons ...', ...
					    'MenuSelectedFcn', {@cb_open_elements} ...
					    );
					menu_hide_elements = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_ELEMENTS', ...
					    'Text', 'Hide Selected Data', ...
						'MenuSelectedFcn', {@cb_hide_elements} ...
					    );
					menu_open_mbrain = uimenu( ...
						'Separator', 'on', ...
						'Parent', contextmenu, ...
						'Tag', 'MENU_OPEN_MBRAIN', ...
						'Text', 'Brain Graphs Selected Comparisons ...', ...
						'MenuSelectedFcn', {@cb_open_mbrain} ... % % %
						);
					menu_hide_mbrain = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_MBRAIN', ...
					    'Text', 'Hide Selected Brain-Plots', ...
					    'MenuSelectedFcn', {@cb_hide_mbrain} ... % % %
						);
					
					set(pr.get('TABLE'), 'ContextMenu', contextmenu)
					
					value = contextmenu;
					
				case CompareGroupPP_CpDict.X_DRAW % __CompareGroupPP_CpDict.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					end
					
				case CompareGroupPP_CpDict.UPDATE % __CompareGroupPP_CpDict.UPDATE__
					value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
					if value
						el = pr.get('EL');
						prop = pr.get('PROP');
					        
						if isa(el.getr(prop), 'NoValue')
					        % don't plot anything for a result not yet calculated
					        pr.set('HEIGHT', pr.getPropDefault('HEIGHT'))
					        set(pr.get('TABLE'), 'Visible', 'off')
					    else
					        set_table()
					        pr.set('HEIGHT', pr.getPropDefault('HEIGHT') + pr.get('TABLE_HEIGHT'))
					        set(pr.get('TABLE'), 'Visible', 'on')
					    end
					end
					
				case CompareGroupPP_CpDict.REDRAW % __CompareGroupPP_CpDict.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('TABLE'), 'Position', [s(.3) s(.3) w_p-s(.6) max(1, pr.get('HEIGHT')-s(2.2))])
					end
					
				case CompareGroupPP_CpDict.SHOW % __CompareGroupPP_CpDict.SHOW__
					value = calculateValue@PanelProp(pr, PanelProp.SHOW, varargin{:}); % also warning
					if value    
					    % figures for comparison figures
					    gui_f_dict = pr.get('GUI_F_DICT');
					    for i = 1:1:gui_f_dict.get('LENGTH')
					        gui = gui_f_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('SHOW')
					        end
					    end
					    
					    % figures for comparison data
					    gui_cp_dict = pr.get('GUI_CP_DICT');
					    for i = 1:1:gui_cp_dict.get('LENGTH')
					        gui = gui_cp_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('SHOW')
					        end
					    end
					    % figures for brain measures comparison figures
					    gui_b_dict = pr.get('GUI_B_DICT');
					    for i = 1:1:gui_b_dict.get('LENGTH')
					        gui = gui_b_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('SHOW')
					        end
					    end
					    % figures for brain graph comparison figures
					    gui_bg_dict = pr.get('GUI_BG_DICT');
					    for i = 1:1:gui_bg_dict.get('LENGTH')
					        gui = gui_bg_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('SHOW')
					        end
					    end
					end
					
				case CompareGroupPP_CpDict.HIDE % __CompareGroupPP_CpDict.HIDE__
					value = calculateValue@PanelProp(pr, PanelProp.HIDE, varargin{:}); % also warning
					if value
					    % figures for measure figures
					    gui_f_dict = pr.get('GUI_F_DICT');
					    for i = 1:1:gui_f_dict.get('LENGTH')
					        gui = gui_f_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('HIDE')
					        end
					    end
					    
					    % figures for measure data
					    gui_cp_dict = pr.get('GUI_CP_DICT');
					    for i = 1:1:gui_cp_dict.get('LENGTH')
					        gui = gui_cp_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('HIDE')
					        end
					    end
					
					    % figures for measure figures
					    gui_b_dict = pr.get('GUI_B_DICT');
					    for i = 1:1:gui_b_dict.get('LENGTH')
					        gui = gui_b_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('HIDE')
					        end
					    end
					
					    % figures for measure figures
					    gui_bg_dict = pr.get('GUI_BG_DICT');
					    for i = 1:1:gui_bg_dict.get('LENGTH')
					        gui = gui_bg_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('HIDE')
					        end
					    end
					end
					
				case CompareGroupPP_CpDict.DELETE % __CompareGroupPP_CpDict.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('TABLE', Element.getNoValue())
					    pr.set('CONTEXTMENU', Element.getNoValue())
					end
					
				case CompareGroupPP_CpDict.CLOSE % __CompareGroupPP_CpDict.CLOSE__
					value = calculateValue@PanelProp(pr, PanelProp.CLOSE, varargin{:}); % also warning
					if value
					    % figures for measure figures
					    gui_f_dict = pr.get('GUI_F_DICT');
					    for i = 1:1:gui_f_dict.get('LENGTH')
					        gui = gui_f_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('CLOSE')
					        end
					    end
					    
					    % figures for measure data
					    gui_cp_dict = pr.get('GUI_CP_DICT');
					    for i = 1:1:gui_cp_dict.get('LENGTH')
					        gui = gui_cp_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('CLOSE')
					        end
					    end
					
					    % figures for measure figures
					    gui_b_dict = pr.get('GUI_B_DICT');
					    for i = 1:1:gui_b_dict.get('LENGTH')
					        gui = gui_b_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('CLOSE')
					        end
					    end
					    
					    % figures for measure figures
					    gui_bg_dict = pr.get('GUI_BG_DICT');
					    for i = 1:1:gui_bg_dict.get('LENGTH')
					        gui = gui_bg_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('CLOSE')
					        end
					    end
					end
					
				otherwise
					if prop <= PanelProp.getPropNumber()
						value = calculateValue@PanelProp(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_table(~, event) % (src, event)
			    % only needs to update the selector
			
			        i = event.Indices(1);
			        
			        selected = pr.get('SELECTED');
			        if event.NewData == 1
			            pr.set('SELECTED', sort(unique([selected; i])));
			        else
			            pr.set('SELECTED', selected(selected ~= i));
			        end
			        
			        pr.get('UPDATE')    
			end
			function cb_select_all(~, ~) 
			    c = pr.get('EL');
			    g = c.get('A1').get('G');
			    m_list = g.get('COMPATIBLE_MEASURES');
			
			    pr.set('SELECTED', [1:1:length(m_list)])
			
			    pr.get('UPDATE')
			end
			function cb_clear_selection(~, ~) 
			    pr.set('SELECTED', [])
			
			    pr.get('UPDATE')
			end
			function cb_invert_selection(~, ~) 
			    c = pr.get('EL');
			    g = c.get('A1').get('G');
			    m_list = g.get('COMPATIBLE_MEASURES');
			
			    selected_tmp = [1:1:length(m_list)];
			    selected_tmp(pr.get('SELECTED')) = [];
			    pr.set('SELECTED', selected_tmp);
			
			    pr.get('UPDATE')
			end
			function cb_calculate(~, ~) 
			    c = pr.get('EL');
			    g = c.get('A1').get('G');
			    m_list = g.get('COMPATIBLE_MEASURES');
			    selected = pr.get('SELECTED');
			    
			    wb = braph2waitbar(pr.get('WAITBAR'), 0, ['Calculating ' num2str(length(selected))  ' comparisons ...']);
			    if check_graphics(wb, 'figure')
			        set(wb, 'Position', [x0(wb) y0(wb)+h(wb) w(wb) h(wb)])
			    end
			
			    for i = 1:1:length(m_list)
			        if ismember(i, selected)
			            measure = m_list{i};
			
			            braph2waitbar(wb, .1 + .9 * i / length(selected), ['Calculating comparison ' int2str(sum(selected <= i)) ' (' measure ') of ' int2str(length(selected)) ' ...'])
			
			            if isa(c.get('COMPARISON', measure).getr('DIFF'), 'NoValue')
			                c.get('COMPARISON', measure).memorize('DIFF');
			                c.get('COMPARISON', measure).memorize('P1');
			                c.get('COMPARISON', measure).memorize('P2');
			                c.get('COMPARISON', measure).memorize('CIL');
			                c.get('COMPARISON', measure).memorize('CIU');
			            end
			        end
			    end
			    
				braph2waitbar(wb, 'close')
			
				pr.get('UPDATE');
			end
			function cb_open_mbrain(~, ~)
			    c = pr.get('EL');
			    g = c.get('A1').get('G');
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
			    N = ceil(sqrt(length(m_list))); % number of row and columns of figures
			
			    gui_b_dict = pr.memorize('GUI_B_DICT');
			    
			    selected = pr.get('SELECTED');
				for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			
			        cp = c.get('COMPARISON', measure);
			        
			        if ~gui_b_dict.get('CONTAINS_KEY', measure)
						sub_list = c.get('A1').get('GR').get('SUB_DICT').get('IT_LIST');
			            sub = sub_list{1};
			            brain_atlas = sub.get('BA');
			
			            switch Element.getPropDefault(measure, 'SHAPE')
			                case Measure.GLOBAL % __Measure.GLOBAL__
			                    switch Element.getPropDefault(measure, 'SCOPE')
			                        case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
			                            mGBPF = ComparisonGroupBrainPF_GS('CP', cp, 'BA', brain_atlas);
			                        case Measure.UNILAYER % __Measure.UNILAYER__
			                            mGBPF = ComparisonGroupBrainPF_GU('CP', cp, 'BA', brain_atlas);
			                        case Measure.BILAYER % __Measure.BILAYER__
			                            mGBPF = ComparisonGroupBrainPF_GB('CP', cp, 'BA', brain_atlas);
			                    end
			                case Measure.NODAL % __Measure.NODAL__
			                    switch Element.getPropDefault(measure, 'SCOPE')
			                        case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
			                            mGBPF = ComparisonGroupBrainPF_NS('CP', cp, 'BA', brain_atlas);
			                        case Measure.UNILAYER % __Measure.UNILAYER__
			                            mGBPF = ComparisonGroupBrainPF_NU('CP', cp, 'BA', brain_atlas);
			                        case Measure.BILAYER % __Measure.BILAYER__
			                            mGBPF = ComparisonGroupBrainPF_NB('CP', cp, 'BA', brain_atlas);
			                    end
			                case Measure.BINODAL % __Measure.BINODAL__
			                    switch Element.getPropDefault(measure, 'SCOPE')
			                        case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
			                            mGBPF = ComparisonGroupBrainPF_BS('CP', cp, 'BA', brain_atlas);
			                        case Measure.UNILAYER % __Measure.UNILAYER__
			                            mGBPF = omparisonGroupBrainPF_BU('CP', cp, 'BA', brain_atlas);
			                        case Measure.BILAYER % __Measure.BILAYER__
			                            mGBPF = ComparisonGroupBrainPF_BB('CP', cp, 'BA', brain_atlas);
			                    end
			            end
			
			            gui = GUIFig( ...
			                'ID', measure, ... % this is the dictionary key
			                'PF', mGBPF, ...
			                'POSITION', [ ...
			                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ...
			                    y0(f, 'normalized') ...
			                    w(f, 'normalized') * 3 ...
			                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ...
			                    ], ...
			                'WAITBAR', pr.getCallback('WAITBAR'), ...
			                'CLOSEREQ', false ...
			                );
			            gui_b_dict.get('ADD', gui)
			        end
			        
			        gui = gui_b_dict.get('IT', measure);
			        if ~gui.get('DRAWN')
			            gui.get('DRAW')
			        end
			        gui.get('SHOW')
			    end
			end
			
			function cb_hide_mbrain(~, ~)
			    c = pr.get('EL');
			    g = c.get('A1').get('G');
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    gui_b_dict = pr.memorize('GUI_B_DICT');
			    
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			    
			        measure = m_list{i}; % also key
			    
			        if gui_b_dict.get('CONTAINS_KEY', measure)
			            gui = gui_b_dict.get('IT', measure);
			            if gui.get('DRAWN')
			                gui.get('HIDE')
			            end
			        end
			    end
			end
			
			
			function cb_open_plots(~, ~)
			    c = pr.get('EL');
			    g = c.get('A1').get('G');
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
			    N = ceil(sqrt(length(m_list))); % number of row and columns of figures
			
			    gui_f_dict = pr.memorize('GUI_F_DICT');
			    
			    selected = pr.get('SELECTED');
				for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			
			        cp = c.get('COMPARISON', measure);
			        
			        if ~gui_f_dict.get('CONTAINS_KEY', measure)
			            gui = GUIFig( ...
			                'ID', measure, ... % this is the dictionary key
			                'PF', cp.get('PFC'), ...
			                'POSITION', [ ...
			                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ...
			                    y0(f, 'normalized') ...
			                    w(f, 'normalized') * 3 ...
			                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ...
			                    ], ...
			                'WAITBAR', pr.getCallback('WAITBAR'), ...
			                'CLOSEREQ', false ...
			                );
			            gui_f_dict.get('ADD', gui)
			        end
			        
			        gui = gui_f_dict.get('IT', measure);
			        if ~gui.get('DRAWN')
			            gui.get('DRAW')
			        end
			        gui.get('SHOW')
			    end
			end
			function cb_hide_plots(~, ~)
			    c = pr.get('EL');
			    g = c.get('A1').get('G');
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    gui_f_dict = pr.memorize('GUI_F_DICT');
			
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			        
			        if gui_f_dict.get('CONTAINS_KEY', measure)
			            gui = gui_f_dict.get('IT', measure);
			            if gui.get('DRAWN')
			                gui.get('HIDE')
			            end
			        end
			    end
			end
			function cb_open_elements(~, ~)
			    c = pr.get('EL');
			    g = c.get('A1').get('G');
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
			    N = ceil(sqrt(length(m_list))); % number of row and columns of figures
			
			    gui_cp_dict = pr.memorize('GUI_CP_DICT');
			    
			    selected = pr.get('SELECTED');
				for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			
			        cp = c.get('COMPARISON', measure);
			        cp.get('C').get('A1').memorize('G').memorize('A'); % memorizing A to get correct ALAYERLABELS
			        
			        if ~gui_cp_dict.get('CONTAINS_KEY', measure)
			            gui = GUIElement( ...
			                'ID', measure, ... % this is the dictionary key
			                'PE', cp, ... 
			                'POSITION', [ ...
			                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ... % x = (f_gr_x + f_gr_w) / screen_w + mod(selected_it - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
			                    y0(f, 'normalized') ... % y = f_gr_y / screen_h;
			                    w(f, 'normalized') ... % w = f_gr_w / screen_w;
			                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ... % h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_it - .5) / N)) / N / screen_h;
			                    ], ...
			                'WAITBAR', pr.getCallback('WAITBAR'), ...
			                'CLOSEREQ', false ...
			                );
			            gui_cp_dict.get('ADD', gui)
			        end
			        
			        gui = gui_cp_dict.get('IT', measure);
			        if ~gui.get('DRAWN')
			            gui.get('DRAW')
			        end
			        gui.get('SHOW')
				end
			end
			function cb_hide_elements(~, ~)
			    c = pr.get('EL');
			    g = c.get('A1').get('G');
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    gui_m_dict = pr.memorize('GUI_CP_DICT');
			
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			        
			        if gui_m_dict.get('CONTAINS_KEY', measure)
			            gui = gui_m_dict.get('IT', measure);
			            if gui.get('DRAWN')
			                gui.get('HIDE')
			            end
			        end
			    end
			end
			function cb_open_brains(~, ~)
			    c = pr.get('EL');
			    g = c.get('A1').get('G');
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
			    N = ceil(sqrt(length(m_list))); % number of row and columns of figures
			
			    gui_bg_dict = pr.memorize('GUI_BG_DICT');
			    
			    selected = pr.get('SELECTED');
				for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			
			        cp = c.get('COMPARISON', measure);
			        
			        if ~gui_bg_dict.get('CONTAINS_KEY', measure)
			            gui = GUIFig( ...
			                'ID', measure, ... % this is the dictionary key
			                'PF', cp.get('PFBG'), ...
			                'POSITION', [ ...
			                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ...
			                    y0(f, 'normalized') ...
			                    w(f, 'normalized') * 3 ...
			                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ...
			                    ], ...
			                'WAITBAR', pr.getCallback('WAITBAR'), ...
			                'CLOSEREQ', false ...
			                );
			            gui_bg_dict.get('ADD', gui)
			        end
			        
			        gui = gui_bg_dict.get('IT', measure);
			        if ~gui.get('DRAWN')
			            gui.get('DRAW')
			        end
			        gui.get('SHOW')
			    end
			end
			function cb_hide_brains(~, ~)
			    c = pr.get('EL');
			    g = c.get('A1').get('G');
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    gui_f_dict = pr.memorize('GUI_F_DICT');
			
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			        
			        if gui_f_dict.get('CONTAINS_KEY', measure)
			            gui = gui_f_dict.get('IT', measure);
			            if gui.get('DRAWN')
			                gui.get('HIDE')
			            end
			        end
			    end
			end
			function set_table()
			    c = pr.get('EL');
			    g = c.get('A1').get('G');
			
			    m_list = g.get('COMPATIBLE_MEASURES');
			    cplist_already_calculated = cellfun(@(x) x.get('MEASURE'), c.get('CP_DICT').get('IT_LIST'), 'UniformOutput', false);
			
			    rowname = cell(length(m_list), 1);
			    data = cell(length(m_list), 5);
			    for mi = 1:1:length(m_list)
			        if any(cellfun(@(y) isequal(m_list{mi}, y), cplist_already_calculated)) && ~isa(c.get('COMPARISON', m_list{mi}).getr('DIFF'), 'NoValue')
			            rowname{mi} = 'C';
			        else
			            rowname{mi} = '';
			        end                
			
			        if any(pr.get('SELECTED') == mi)
			            data{mi, 1} = true;
			        else
			            data{mi, 1} = false;
			        end
			
			        data{mi, 2} = eval([m_list{mi} '.getPropDefault(''NAME'')']);
			
			        if Element.getPropDefault(m_list{mi}, 'SHAPE') == Measure.NODAL
			            data{mi, 3} = 'NODAL';
			        elseif Element.getPropDefault(m_list{mi}, 'SHAPE') == Measure.GLOBAL
			            data{mi, 3} = 'GLOBAL';
			        elseif Element.getPropDefault(m_list{mi}, 'SHAPE') == Measure.BINODAL
			            data{mi, 3} = 'BINODAL';
			        end
			
			        if Element.getPropDefault(m_list{mi}, 'SCOPE') == Measure.SUPERGLOBAL
			            data{mi, 4} = 'SUPERGLOBAL';
			        elseif Element.getPropDefault(m_list{mi}, 'SCOPE') == Measure.UNILAYER
			            data{mi, 4} = 'UNILAYER';
			        elseif Element.getPropDefault(m_list{mi}, 'SCOPE') == Measure.BILAYER
			            data{mi, 4} = 'BILAYER';
			        end
			        
			        data{mi, 5} = eval([m_list{mi} '.getPropDefault(''DESCRIPTION'')']);
			    end
			
			    set(pr.get('TABLE'), ...
			        'RowName', rowname, ...
			        'Data', data ...
			        )
			
			    % style SELECTED
			    styles_row = find(pr.get('TABLE').StyleConfigurations.Target == 'row');
			    if ~isempty(styles_row)
			        removeStyle(pr.get('TABLE'), styles_row)
			    end
			    if ~isempty(pr.get('SELECTED'))
			        addStyle(pr.get('TABLE'), uistyle('FontWeight', 'bold'), 'row', pr.get('SELECTED'))
			    end
			end
		end
	end
end
