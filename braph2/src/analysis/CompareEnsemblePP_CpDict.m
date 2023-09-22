classdef CompareEnsemblePP_CpDict < PanelProp
	%CompareEnsemblePP_CpDict plots the panel to manage the comparisons of an ensemble analysis.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% CompareEnsemblePP_CpDict plots the panel to manage the comparisons of an ensemble analysis.
	% It is intended to be used only with the property CP_DICT of CompareEnsemble.
	%
	% CompareEnsemblePP_CpDict methods (constructor):
	%  CompareEnsemblePP_CpDict - constructor
	%
	% CompareEnsemblePP_CpDict methods:
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
	% CompareEnsemblePP_CpDict methods (display):
	%  tostring - string with information about the comparison plot
	%  disp - displays information about the comparison plot
	%  tree - displays the tree of the comparison plot
	%
	% CompareEnsemblePP_CpDict methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two comparison plot are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the comparison plot
	%
	% CompareEnsemblePP_CpDict methods (save/load, Static):
	%  save - saves BRAPH2 comparison plot as b2 file
	%  load - loads a BRAPH2 comparison plot from a b2 file
	%
	% CompareEnsemblePP_CpDict method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the comparison plot
	%
	% CompareEnsemblePP_CpDict method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the comparison plot
	%
	% CompareEnsemblePP_CpDict methods (inspection, Static):
	%  getClass - returns the class of the comparison plot
	%  getSubclasses - returns all subclasses of CompareEnsemblePP_CpDict
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
	% CompareEnsemblePP_CpDict methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% CompareEnsemblePP_CpDict methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% CompareEnsemblePP_CpDict methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% CompareEnsemblePP_CpDict methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?CompareEnsemblePP_CpDict; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">CompareEnsemblePP_CpDict constants</a>.
	%
	%
	% See also uitable, CompareEnsemble, ComparisonEnsemble.
	
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
		
		GUI_BG_DICT = PanelProp.getPropNumber() + 7;
		GUI_BG_DICT_TAG = 'GUI_BG_DICT';
		GUI_BG_DICT_CATEGORY = Category.GUI;
		GUI_BG_DICT_FORMAT = Format.IDICT;
	end
	methods % constructor
		function pr = CompareEnsemblePP_CpDict(varargin)
			%CompareEnsemblePP_CpDict() creates a comparison plot.
			%
			% CompareEnsemblePP_CpDict(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% CompareEnsemblePP_CpDict(TAG, VALUE, ...) with property TAG set to VALUE.
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
			% CLASS = CompareEnsemblePP_CpDict.GETCLASS() returns the class 'CompareEnsemblePP_CpDict'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the comparison plot PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('CompareEnsemblePP_CpDict') returns 'CompareEnsemblePP_CpDict'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			
			pr_class = 'CompareEnsemblePP_CpDict';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the comparison plot.
			%
			% LIST = CompareEnsemblePP_CpDict.GETSUBCLASSES() returns all subclasses of 'CompareEnsemblePP_CpDict'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the comparison plot PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('CompareEnsemblePP_CpDict') returns all subclasses of 'CompareEnsemblePP_CpDict'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('CompareEnsemblePP_CpDict', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of comparison plot.
			%
			% PROPS = CompareEnsemblePP_CpDict.GETPROPS() returns the property list of comparison plot
			%  as a row vector.
			%
			% PROPS = CompareEnsemblePP_CpDict.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the comparison plot PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('CompareEnsemblePP_CpDict'[, CATEGORY]) returns the property list of 'CompareEnsemblePP_CpDict'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						CompareEnsemblePP_CpDict.TABLE_HEIGHT ...
						CompareEnsemblePP_CpDict.SELECTED ...
						CompareEnsemblePP_CpDict.TABLE ...
						CompareEnsemblePP_CpDict.CONTEXTMENU ...
						CompareEnsemblePP_CpDict.GUI_F_DICT ...
						CompareEnsemblePP_CpDict.GUI_CP_DICT ...
						CompareEnsemblePP_CpDict.GUI_BG_DICT ...
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
						CompareEnsemblePP_CpDict.TABLE ...
						CompareEnsemblePP_CpDict.CONTEXTMENU ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						CompareEnsemblePP_CpDict.TABLE_HEIGHT ...
						CompareEnsemblePP_CpDict.SELECTED ...
						CompareEnsemblePP_CpDict.GUI_F_DICT ...
						CompareEnsemblePP_CpDict.GUI_CP_DICT ...
						CompareEnsemblePP_CpDict.GUI_BG_DICT ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of comparison plot.
			%
			% N = CompareEnsemblePP_CpDict.GETPROPNUMBER() returns the property number of comparison plot.
			%
			% N = CompareEnsemblePP_CpDict.GETPROPNUMBER(CATEGORY) returns the property number of comparison plot
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the comparison plot PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('CompareEnsemblePP_CpDict') returns the property number of 'CompareEnsemblePP_CpDict'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(CompareEnsemblePP_CpDict.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in comparison plot/error.
			%
			% CHECK = CompareEnsemblePP_CpDict.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(CompareEnsemblePP_CpDict, PROP) checks whether PROP exists for CompareEnsemblePP_CpDict.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:CompareEnsemblePP_CpDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:CompareEnsemblePP_CpDict:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:CompareEnsemblePP_CpDict:WrongInput]
			%  Element.EXISTSPROP(CompareEnsemblePP_CpDict, PROP) throws error if PROP does NOT exist for CompareEnsemblePP_CpDict.
			%   Error id: [BRAPH2:CompareEnsemblePP_CpDict:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == CompareEnsemblePP_CpDict.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':CompareEnsemblePP_CpDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CompareEnsemblePP_CpDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for CompareEnsemblePP_CpDict.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in comparison plot/error.
			%
			% CHECK = CompareEnsemblePP_CpDict.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(CompareEnsemblePP_CpDict, TAG) checks whether TAG exists for CompareEnsemblePP_CpDict.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:CompareEnsemblePP_CpDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:CompareEnsemblePP_CpDict:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:CompareEnsemblePP_CpDict:WrongInput]
			%  Element.EXISTSTAG(CompareEnsemblePP_CpDict, TAG) throws error if TAG does NOT exist for CompareEnsemblePP_CpDict.
			%   Error id: [BRAPH2:CompareEnsemblePP_CpDict:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			compareensemblepp_cpdict_tag_list = cellfun(@(x) CompareEnsemblePP_CpDict.getPropTag(x), num2cell(CompareEnsemblePP_CpDict.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, compareensemblepp_cpdict_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':CompareEnsemblePP_CpDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CompareEnsemblePP_CpDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for CompareEnsemblePP_CpDict.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(CompareEnsemblePP_CpDict, POINTER) returns property number of POINTER of CompareEnsemblePP_CpDict.
			%  PROPERTY = PR.GETPROPPROP(CompareEnsemblePP_CpDict, POINTER) returns property number of POINTER of CompareEnsemblePP_CpDict.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				compareensemblepp_cpdict_tag_list = cellfun(@(x) CompareEnsemblePP_CpDict.getPropTag(x), num2cell(CompareEnsemblePP_CpDict.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, compareensemblepp_cpdict_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(CompareEnsemblePP_CpDict, POINTER) returns tag of POINTER of CompareEnsemblePP_CpDict.
			%  TAG = PR.GETPROPTAG(CompareEnsemblePP_CpDict, POINTER) returns tag of POINTER of CompareEnsemblePP_CpDict.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case CompareEnsemblePP_CpDict.TABLE_HEIGHT
						tag = CompareEnsemblePP_CpDict.TABLE_HEIGHT_TAG;
					case CompareEnsemblePP_CpDict.SELECTED
						tag = CompareEnsemblePP_CpDict.SELECTED_TAG;
					case CompareEnsemblePP_CpDict.TABLE
						tag = CompareEnsemblePP_CpDict.TABLE_TAG;
					case CompareEnsemblePP_CpDict.CONTEXTMENU
						tag = CompareEnsemblePP_CpDict.CONTEXTMENU_TAG;
					case CompareEnsemblePP_CpDict.GUI_F_DICT
						tag = CompareEnsemblePP_CpDict.GUI_F_DICT_TAG;
					case CompareEnsemblePP_CpDict.GUI_CP_DICT
						tag = CompareEnsemblePP_CpDict.GUI_CP_DICT_TAG;
					case CompareEnsemblePP_CpDict.GUI_BG_DICT
						tag = CompareEnsemblePP_CpDict.GUI_BG_DICT_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(CompareEnsemblePP_CpDict, POINTER) returns category of POINTER of CompareEnsemblePP_CpDict.
			%  CATEGORY = PR.GETPROPCATEGORY(CompareEnsemblePP_CpDict, POINTER) returns category of POINTER of CompareEnsemblePP_CpDict.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = CompareEnsemblePP_CpDict.getPropProp(pointer);
			
			switch prop
				case CompareEnsemblePP_CpDict.TABLE_HEIGHT
					prop_category = CompareEnsemblePP_CpDict.TABLE_HEIGHT_CATEGORY;
				case CompareEnsemblePP_CpDict.SELECTED
					prop_category = CompareEnsemblePP_CpDict.SELECTED_CATEGORY;
				case CompareEnsemblePP_CpDict.TABLE
					prop_category = CompareEnsemblePP_CpDict.TABLE_CATEGORY;
				case CompareEnsemblePP_CpDict.CONTEXTMENU
					prop_category = CompareEnsemblePP_CpDict.CONTEXTMENU_CATEGORY;
				case CompareEnsemblePP_CpDict.GUI_F_DICT
					prop_category = CompareEnsemblePP_CpDict.GUI_F_DICT_CATEGORY;
				case CompareEnsemblePP_CpDict.GUI_CP_DICT
					prop_category = CompareEnsemblePP_CpDict.GUI_CP_DICT_CATEGORY;
				case CompareEnsemblePP_CpDict.GUI_BG_DICT
					prop_category = CompareEnsemblePP_CpDict.GUI_BG_DICT_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(CompareEnsemblePP_CpDict, POINTER) returns format of POINTER of CompareEnsemblePP_CpDict.
			%  FORMAT = PR.GETPROPFORMAT(CompareEnsemblePP_CpDict, POINTER) returns format of POINTER of CompareEnsemblePP_CpDict.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = CompareEnsemblePP_CpDict.getPropProp(pointer);
			
			switch prop
				case CompareEnsemblePP_CpDict.TABLE_HEIGHT
					prop_format = CompareEnsemblePP_CpDict.TABLE_HEIGHT_FORMAT;
				case CompareEnsemblePP_CpDict.SELECTED
					prop_format = CompareEnsemblePP_CpDict.SELECTED_FORMAT;
				case CompareEnsemblePP_CpDict.TABLE
					prop_format = CompareEnsemblePP_CpDict.TABLE_FORMAT;
				case CompareEnsemblePP_CpDict.CONTEXTMENU
					prop_format = CompareEnsemblePP_CpDict.CONTEXTMENU_FORMAT;
				case CompareEnsemblePP_CpDict.GUI_F_DICT
					prop_format = CompareEnsemblePP_CpDict.GUI_F_DICT_FORMAT;
				case CompareEnsemblePP_CpDict.GUI_CP_DICT
					prop_format = CompareEnsemblePP_CpDict.GUI_CP_DICT_FORMAT;
				case CompareEnsemblePP_CpDict.GUI_BG_DICT
					prop_format = CompareEnsemblePP_CpDict.GUI_BG_DICT_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(CompareEnsemblePP_CpDict, POINTER) returns description of POINTER of CompareEnsemblePP_CpDict.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(CompareEnsemblePP_CpDict, POINTER) returns description of POINTER of CompareEnsemblePP_CpDict.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = CompareEnsemblePP_CpDict.getPropProp(pointer);
			
			switch prop
				case CompareEnsemblePP_CpDict.TABLE_HEIGHT
					prop_description = 'TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.';
				case CompareEnsemblePP_CpDict.SELECTED
					prop_description = 'SELECTED (gui, cvector) is the list of selected items.';
				case CompareEnsemblePP_CpDict.TABLE
					prop_description = 'TABLE (evanescent, handle) is the table.';
				case CompareEnsemblePP_CpDict.CONTEXTMENU
					prop_description = 'CONTEXTMENU (evanescent, handle) is the context menu.';
				case CompareEnsemblePP_CpDict.GUI_F_DICT
					prop_description = 'GUI_F_DICT (gui, idict) contains the GUIs for the comparison figures.';
				case CompareEnsemblePP_CpDict.GUI_CP_DICT
					prop_description = 'GUI_CP_DICT (gui, idict) contains the GUIs for the comparison.';
				case CompareEnsemblePP_CpDict.GUI_BG_DICT
					prop_description = 'GUI_BG_DICT (gui, idict) contains the GUIs for the brain graph comparison figures.';
				case CompareEnsemblePP_CpDict.NAME
					prop_description = 'NAME (constant, string) is the name of the comparison panel.';
				case CompareEnsemblePP_CpDict.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the comparison panel.';
				case CompareEnsemblePP_CpDict.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the comparison panel.';
				case CompareEnsemblePP_CpDict.ID
					prop_description = 'ID (data, string) is a few-letter code for the comparison panel.';
				case CompareEnsemblePP_CpDict.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the comparison panel.';
				case CompareEnsemblePP_CpDict.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the comparison panel.';
				case CompareEnsemblePP_CpDict.EL
					prop_description = 'EL (data, item) is the element.';
				case CompareEnsemblePP_CpDict.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case CompareEnsemblePP_CpDict.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case CompareEnsemblePP_CpDict.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the table.';
				case CompareEnsemblePP_CpDict.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case CompareEnsemblePP_CpDict.SHOW
					prop_description = 'SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.';
				case CompareEnsemblePP_CpDict.HIDE
					prop_description = 'HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.';
				case CompareEnsemblePP_CpDict.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
				case CompareEnsemblePP_CpDict.CLOSE
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
			%  SETTINGS = Element.GETPROPSETTINGS(CompareEnsemblePP_CpDict, POINTER) returns settings of POINTER of CompareEnsemblePP_CpDict.
			%  SETTINGS = PR.GETPROPSETTINGS(CompareEnsemblePP_CpDict, POINTER) returns settings of POINTER of CompareEnsemblePP_CpDict.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = CompareEnsemblePP_CpDict.getPropProp(pointer);
			
			switch prop
				case CompareEnsemblePP_CpDict.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case CompareEnsemblePP_CpDict.SELECTED
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case CompareEnsemblePP_CpDict.TABLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case CompareEnsemblePP_CpDict.CONTEXTMENU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case CompareEnsemblePP_CpDict.GUI_F_DICT
					prop_settings = 'GUIFig';
				case CompareEnsemblePP_CpDict.GUI_CP_DICT
					prop_settings = 'GUIElement';
				case CompareEnsemblePP_CpDict.GUI_BG_DICT
					prop_settings = 'GUIFig';
				case CompareEnsemblePP_CpDict.TEMPLATE
					prop_settings = 'CompareEnsemblePP_CpDict';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = CompareEnsemblePP_CpDict.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = CompareEnsemblePP_CpDict.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(CompareEnsemblePP_CpDict, POINTER) returns the default value of POINTER of CompareEnsemblePP_CpDict.
			%  DEFAULT = PR.GETPROPDEFAULT(CompareEnsemblePP_CpDict, POINTER) returns the default value of POINTER of CompareEnsemblePP_CpDict.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = CompareEnsemblePP_CpDict.getPropProp(pointer);
			
			switch prop
				case CompareEnsemblePP_CpDict.TABLE_HEIGHT
					prop_default = s(30);
				case CompareEnsemblePP_CpDict.SELECTED
					prop_default = Format.getFormatDefault(Format.CVECTOR, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case CompareEnsemblePP_CpDict.TABLE
					prop_default = Format.getFormatDefault(Format.HANDLE, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case CompareEnsemblePP_CpDict.CONTEXTMENU
					prop_default = Format.getFormatDefault(Format.HANDLE, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case CompareEnsemblePP_CpDict.GUI_F_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case CompareEnsemblePP_CpDict.GUI_CP_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case CompareEnsemblePP_CpDict.GUI_BG_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case CompareEnsemblePP_CpDict.NAME
					prop_default = 'CompareEnsemblePP_CpDict';
				case CompareEnsemblePP_CpDict.DESCRIPTION
					prop_default = 'CompareEnsemblePP_CpDict plots the panel to manage the comparisons of an ensemble analysis.';
				case CompareEnsemblePP_CpDict.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case CompareEnsemblePP_CpDict.ID
					prop_default = 'CompareEnsemblePP_CpDict';
				case CompareEnsemblePP_CpDict.LABEL
					prop_default = 'CompareEnsemblePP_CpDict label';
				case CompareEnsemblePP_CpDict.NOTES
					prop_default = 'CompareEnsemblePP_CpDict';
				case CompareEnsemblePP_CpDict.EL
					prop_default = CompareEnsemble();
				case CompareEnsemblePP_CpDict.PROP
					prop_default = CompareEnsemble.CP_DICT;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = CompareEnsemblePP_CpDict.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = CompareEnsemblePP_CpDict.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(CompareEnsemblePP_CpDict, POINTER) returns the conditioned default value of POINTER of CompareEnsemblePP_CpDict.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(CompareEnsemblePP_CpDict, POINTER) returns the conditioned default value of POINTER of CompareEnsemblePP_CpDict.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = CompareEnsemblePP_CpDict.getPropProp(pointer);
			
			prop_default = CompareEnsemblePP_CpDict.conditioning(prop, CompareEnsemblePP_CpDict.getPropDefault(prop));
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
			
			prop = CompareEnsemblePP_CpDict.getPropProp(pointer);
			
			switch prop
				case CompareEnsemblePP_CpDict.SELECTED % __CompareEnsemblePP_CpDict.SELECTED__
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
			%  CHECK = Element.CHECKPROP(CompareEnsemblePP_CpDict, PROP, VALUE) checks VALUE format for PROP of CompareEnsemblePP_CpDict.
			%  CHECK = PR.CHECKPROP(CompareEnsemblePP_CpDict, PROP, VALUE) checks VALUE format for PROP of CompareEnsemblePP_CpDict.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:CompareEnsemblePP_CpDict:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:CompareEnsemblePP_CpDict:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(CompareEnsemblePP_CpDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CompareEnsemblePP_CpDict.
			%   Error id: €BRAPH2.STR€:CompareEnsemblePP_CpDict:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(CompareEnsemblePP_CpDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CompareEnsemblePP_CpDict.
			%   Error id: €BRAPH2.STR€:CompareEnsemblePP_CpDict:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('CompareEnsemblePP_CpDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = CompareEnsemblePP_CpDict.getPropProp(pointer);
			
			switch prop
				case CompareEnsemblePP_CpDict.TABLE_HEIGHT % __CompareEnsemblePP_CpDict.TABLE_HEIGHT__
					check = Format.checkFormat(Format.SIZE, value, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case CompareEnsemblePP_CpDict.SELECTED % __CompareEnsemblePP_CpDict.SELECTED__
					check = Format.checkFormat(Format.CVECTOR, value, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case CompareEnsemblePP_CpDict.TABLE % __CompareEnsemblePP_CpDict.TABLE__
					check = Format.checkFormat(Format.HANDLE, value, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case CompareEnsemblePP_CpDict.CONTEXTMENU % __CompareEnsemblePP_CpDict.CONTEXTMENU__
					check = Format.checkFormat(Format.HANDLE, value, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case CompareEnsemblePP_CpDict.GUI_F_DICT % __CompareEnsemblePP_CpDict.GUI_F_DICT__
					check = Format.checkFormat(Format.IDICT, value, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case CompareEnsemblePP_CpDict.GUI_CP_DICT % __CompareEnsemblePP_CpDict.GUI_CP_DICT__
					check = Format.checkFormat(Format.IDICT, value, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case CompareEnsemblePP_CpDict.GUI_BG_DICT % __CompareEnsemblePP_CpDict.GUI_BG_DICT__
					check = Format.checkFormat(Format.IDICT, value, CompareEnsemblePP_CpDict.getPropSettings(prop));
				case CompareEnsemblePP_CpDict.TEMPLATE % __CompareEnsemblePP_CpDict.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, CompareEnsemblePP_CpDict.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':CompareEnsemblePP_CpDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CompareEnsemblePP_CpDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' CompareEnsemblePP_CpDict.getPropTag(prop) ' (' CompareEnsemblePP_CpDict.getFormatTag(CompareEnsemblePP_CpDict.getPropFormat(prop)) ').'] ...
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
				case CompareEnsemblePP_CpDict.TABLE % __CompareEnsemblePP_CpDict.TABLE__
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
					
				case CompareEnsemblePP_CpDict.CONTEXTMENU % __CompareEnsemblePP_CpDict.CONTEXTMENU__
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
					menu_open_plots = uimenu( ...
						'Separator', 'on', ...
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
					menu_open_brains = uimenu( ...
						'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_OPEN_BRAINS', ...
					    'Text', 'Brain Graphs Selected Comparisons ...', ...
					    'MenuSelectedFcn', {@cb_open_brains} ...
					    );
					menu_hide_brains = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_BRAINS', ...
					    'Text', 'Hide Selected Brain Graphs', ...
						'MenuSelectedFcn', {@cb_hide_brains} ...
					    );
					
					set(pr.get('TABLE'), 'ContextMenu', contextmenu)
					
					value = contextmenu;
					
				case CompareEnsemblePP_CpDict.X_DRAW % __CompareEnsemblePP_CpDict.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					end
					
				case CompareEnsemblePP_CpDict.UPDATE % __CompareEnsemblePP_CpDict.UPDATE__
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
					
				case CompareEnsemblePP_CpDict.REDRAW % __CompareEnsemblePP_CpDict.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('TABLE'), 'Position', [s(.3) s(.3) w_p-s(.6) max(1, pr.get('HEIGHT')-s(2.2))])
					end
					
				case CompareEnsemblePP_CpDict.SHOW % __CompareEnsemblePP_CpDict.SHOW__
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
					    
					    % figures for brain graph comparison figures
					    gui_bg_dict = pr.get('GUI_BG_DICT');
					    for i = 1:1:gui_bg_dict.get('LENGTH')
					        gui = gui_bg_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('SHOW')
					        end
					    end
					end
					
				case CompareEnsemblePP_CpDict.HIDE % __CompareEnsemblePP_CpDict.HIDE__
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
					    gui_bg_dict = pr.get('GUI_BG_DICT');
					    for i = 1:1:gui_bg_dict.get('LENGTH')
					        gui = gui_bg_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('HIDE')
					        end
					    end
					end
					
				case CompareEnsemblePP_CpDict.DELETE % __CompareEnsemblePP_CpDict.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('TABLE', Element.getNoValue())
					    pr.set('CONTEXTMENU', Element.getNoValue())
					end
					
				case CompareEnsemblePP_CpDict.CLOSE % __CompareEnsemblePP_CpDict.CLOSE__
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
			    g = c.get('A1').get('GRAPH_TEMPLATE');
			    mlist = g.get('COMPATIBLE_MEASURES');
			
			    pr.set('SELECTED', [1:1:length(mlist)])
			
			    pr.get('UPDATE')
			end
			function cb_clear_selection(~, ~) 
			    pr.set('SELECTED', [])
			
			    pr.get('UPDATE')
			end
			function cb_invert_selection(~, ~) 
			    c = pr.get('EL');
			    g = c.get('A1').get('GRAPH_TEMPLATE');
			    mlist = g.get('COMPATIBLE_MEASURES');
			
			    selected_tmp = [1:1:length(mlist)];
			    selected_tmp(pr.get('SELECTED')) = [];
			    pr.set('SELECTED', selected_tmp);
			
			    pr.get('UPDATE')
			end
			function cb_calculate(~, ~) 
			    c = pr.get('EL');
			    g = c.get('A1').get('GRAPH_TEMPLATE');
			    mlist = g.get('COMPATIBLE_MEASURES');
			    selected = pr.get('SELECTED');
			    
			    wb = braph2waitbar(pr.get('WAITBAR'), 0, ['Calculating ' num2str(length(selected))  ' comparisons ...']);
			    if check_graphics(wb, 'figure')
			        set(wb, 'Position', [x0(wb) y0(wb)+h(wb) w(wb) h(wb)])
			    end
			
			    for i = 1:1:length(mlist)
			        if ismember(i, selected)
			            measure = mlist{i};
			
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
			function cb_open_plots(~, ~)
			    c = pr.get('EL');
			    g = c.get('A1').get('GRAPH_TEMPLATE');
			    mlist = g.get('COMPATIBLE_MEASURES');
			    
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
			    N = ceil(sqrt(length(mlist))); % number of row and columns of figures
			
			    gui_f_dict = pr.memorize('GUI_F_DICT');
			    
			    selected = pr.get('SELECTED');
				for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = mlist{i}; % also key
			
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
			    g = c.get('A1').get('GRAPH_TEMPLATE');
			    mlist = g.get('COMPATIBLE_MEASURES');
			    
			    gui_f_dict = pr.memorize('GUI_F_DICT');
			
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = mlist{i}; % also key
			        
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
			    g = c.get('A1').get('GRAPH_TEMPLATE');
			    mlist = g.get('COMPATIBLE_MEASURES');
			    
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
			    N = ceil(sqrt(length(mlist))); % number of row and columns of figures
			
			    gui_cp_dict = pr.memorize('GUI_CP_DICT');
			    
			    selected = pr.get('SELECTED');
				for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = mlist{i}; % also key
			
			        cp = c.get('COMPARISON', measure);
			        
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
			    g = c.get('A1').get('GRAPH_TEMPLATE');
			    mlist = g.get('COMPATIBLE_MEASURES');
			    
			    gui_m_dict = pr.memorize('GUI_CP_DICT');
			
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = mlist{i}; % also key
			        
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
			    g = c.get('A1').get('GRAPH_TEMPLATE');
			    mlist = g.get('COMPATIBLE_MEASURES');
			    
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
			    N = ceil(sqrt(length(mlist))); % number of row and columns of figures
			
			    gui_bg_dict = pr.memorize('GUI_BG_DICT');
			    
			    selected = pr.get('SELECTED');
				for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = mlist{i}; % also key
			
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
			    g = c.get('A1').get('GRAPH_TEMPLATE');
			    mlist = g.get('COMPATIBLE_MEASURES');
			    
			    gui_f_dict = pr.memorize('GUI_F_DICT');
			
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = mlist{i}; % also key
			        
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
			    g = c.get('A1').get('GRAPH_TEMPLATE');
			
			    mlist = g.get('COMPATIBLE_MEASURES');
                mlist2 = getCompatibleMeasures(g); % to have the complete name in the table
			    cplist_already_calculated = cellfun(@(x) x.get('MEASURE'), c.get('CP_DICT').get('IT_LIST'), 'UniformOutput', false);
			
			    rowname = cell(length(mlist), 1);
			    data = cell(length(mlist), 5);
			    for mi = 1:1:length(mlist)
			        if any(cellfun(@(y) isequal(mlist{mi}, y), cplist_already_calculated)) && ~isa(c.get('COMPARISON', mlist{mi}).getr('DIFF'), 'NoValue')
			            rowname{mi} = 'C';
			        else
			            rowname{mi} = '';
			        end                
			
			        if any(pr.get('SELECTED') == mi)
			            data{mi, 1} = true;
			        else
			            data{mi, 1} = false;
			        end
			
			        data{mi, 2} = mlist2{mi};
			
			        if Element.getPropDefault(mlist{mi}, 'SHAPE') == Measure.NODAL
			            data{mi, 3} = 'NODAL';
			        elseif Element.getPropDefault(mlist{mi}, 'SHAPE') == Measure.GLOBAL
			            data{mi, 3} = 'GLOBAL';
			        elseif Element.getPropDefault(mlist{mi}, 'SHAPE') == Measure.BINODAL
			            data{mi, 3} = 'BINODAL';
			        end
			
			        if Element.getPropDefault(mlist{mi}, 'SCOPE') == Measure.SUPERGLOBAL
			            data{mi, 4} = 'SUPERGLOBAL';
			        elseif Element.getPropDefault(mlist{mi}, 'SCOPE') == Measure.UNILAYER
			            data{mi, 4} = 'UNILAYER';
			        elseif Element.getPropDefault(mlist{mi}, 'SCOPE') == Measure.BILAYER
			            data{mi, 4} = 'BILAYER';
			        end
			        
			        data{mi, 5} = eval([mlist{mi} '.getPropDefault(''DESCRIPTION'')']);
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
