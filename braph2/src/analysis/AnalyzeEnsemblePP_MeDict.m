classdef AnalyzeEnsemblePP_MeDict < PanelProp
	%AnalyzeEnsemblePP_MeDict plots the panel to manage the graph and measures of an ensemble analysis.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% AnalyzeEnsemblePP_MeDict plots the panel to manage the graph and measures of an ensemble analysis.
	% It is intended to be used only with the property ME_DICT of AnalyzeEnsemble.
	%
	% AnalyzeEnsemblePP_MeDict methods (constructor):
	%  AnalyzeEnsemblePP_MeDict - constructor
	%
	% AnalyzeEnsemblePP_MeDict methods:
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
	% AnalyzeEnsemblePP_MeDict methods (display):
	%  tostring - string with information about the graph and measure plot
	%  disp - displays information about the graph and measure plot
	%  tree - displays the tree of the graph and measure plot
	%
	% AnalyzeEnsemblePP_MeDict methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graph and measure plot are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graph and measure plot
	%
	% AnalyzeEnsemblePP_MeDict methods (save/load, Static):
	%  save - saves BRAPH2 graph and measure plot as b2 file
	%  load - loads a BRAPH2 graph and measure plot from a b2 file
	%
	% AnalyzeEnsemblePP_MeDict method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graph and measure plot
	%
	% AnalyzeEnsemblePP_MeDict method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graph and measure plot
	%
	% AnalyzeEnsemblePP_MeDict methods (inspection, Static):
	%  getClass - returns the class of the graph and measure plot
	%  getSubclasses - returns all subclasses of AnalyzeEnsemblePP_MeDict
	%  getProps - returns the property list of the graph and measure plot
	%  getPropNumber - returns the property number of the graph and measure plot
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
	% AnalyzeEnsemblePP_MeDict methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% AnalyzeEnsemblePP_MeDict methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% AnalyzeEnsemblePP_MeDict methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% AnalyzeEnsemblePP_MeDict methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?AnalyzeEnsemblePP_MeDict; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">AnalyzeEnsemblePP_MeDict constants</a>.
	%
	%
	% See also uitable, AnalyzeEnsemble, Graph, Measure.
	
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
		
		GUI_G_EL = PanelProp.getPropNumber() + 5;
		GUI_G_EL_TAG = 'GUI_G_EL';
		GUI_G_EL_CATEGORY = Category.GUI;
		GUI_G_EL_FORMAT = Format.ITEM;
		
		GUI_M_DICT = PanelProp.getPropNumber() + 6;
		GUI_M_DICT_TAG = 'GUI_M_DICT';
		GUI_M_DICT_CATEGORY = Category.GUI;
		GUI_M_DICT_FORMAT = Format.IDICT;
		
		GUI_B_DICT = PanelProp.getPropNumber() + 7;
		GUI_B_DICT_TAG = 'GUI_B_DICT';
		GUI_B_DICT_CATEGORY = Category.GUI;
		GUI_B_DICT_FORMAT = Format.IDICT;
	end
	methods % constructor
		function pr = AnalyzeEnsemblePP_MeDict(varargin)
			%AnalyzeEnsemblePP_MeDict() creates a graph and measure plot.
			%
			% AnalyzeEnsemblePP_MeDict(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% AnalyzeEnsemblePP_MeDict(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the graph and measure plot.
			%
			% CLASS = AnalyzeEnsemblePP_MeDict.GETCLASS() returns the class 'AnalyzeEnsemblePP_MeDict'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the graph and measure plot PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('AnalyzeEnsemblePP_MeDict') returns 'AnalyzeEnsemblePP_MeDict'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('AnalyzeEnsemblePP_MeDict')
			%  are less computationally efficient.
			
			pr_class = 'AnalyzeEnsemblePP_MeDict';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graph and measure plot.
			%
			% LIST = AnalyzeEnsemblePP_MeDict.GETSUBCLASSES() returns all subclasses of 'AnalyzeEnsemblePP_MeDict'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the graph and measure plot PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('AnalyzeEnsemblePP_MeDict') returns all subclasses of 'AnalyzeEnsemblePP_MeDict'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('AnalyzeEnsemblePP_MeDict')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('AnalyzeEnsemblePP_MeDict', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph and measure plot.
			%
			% PROPS = AnalyzeEnsemblePP_MeDict.GETPROPS() returns the property list of graph and measure plot
			%  as a row vector.
			%
			% PROPS = AnalyzeEnsemblePP_MeDict.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the graph and measure plot PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('AnalyzeEnsemblePP_MeDict'[, CATEGORY]) returns the property list of 'AnalyzeEnsemblePP_MeDict'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('AnalyzeEnsemblePP_MeDict')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						AnalyzeEnsemblePP_MeDict.TABLE_HEIGHT ...
						AnalyzeEnsemblePP_MeDict.SELECTED ...
						AnalyzeEnsemblePP_MeDict.TABLE ...
						AnalyzeEnsemblePP_MeDict.CONTEXTMENU ...
						AnalyzeEnsemblePP_MeDict.GUI_G_EL ...
						AnalyzeEnsemblePP_MeDict.GUI_M_DICT ...
						AnalyzeEnsemblePP_MeDict.GUI_B_DICT ...
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
						AnalyzeEnsemblePP_MeDict.TABLE ...
						AnalyzeEnsemblePP_MeDict.CONTEXTMENU ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						AnalyzeEnsemblePP_MeDict.TABLE_HEIGHT ...
						AnalyzeEnsemblePP_MeDict.SELECTED ...
						AnalyzeEnsemblePP_MeDict.GUI_G_EL ...
						AnalyzeEnsemblePP_MeDict.GUI_M_DICT ...
						AnalyzeEnsemblePP_MeDict.GUI_B_DICT ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graph and measure plot.
			%
			% N = AnalyzeEnsemblePP_MeDict.GETPROPNUMBER() returns the property number of graph and measure plot.
			%
			% N = AnalyzeEnsemblePP_MeDict.GETPROPNUMBER(CATEGORY) returns the property number of graph and measure plot
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the graph and measure plot PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('AnalyzeEnsemblePP_MeDict') returns the property number of 'AnalyzeEnsemblePP_MeDict'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('AnalyzeEnsemblePP_MeDict')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(AnalyzeEnsemblePP_MeDict.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph and measure plot/error.
			%
			% CHECK = AnalyzeEnsemblePP_MeDict.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(AnalyzeEnsemblePP_MeDict, PROP) checks whether PROP exists for AnalyzeEnsemblePP_MeDict.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemblePP_MeDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:AnalyzeEnsemblePP_MeDict:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:AnalyzeEnsemblePP_MeDict:WrongInput]
			%  Element.EXISTSPROP(AnalyzeEnsemblePP_MeDict, PROP) throws error if PROP does NOT exist for AnalyzeEnsemblePP_MeDict.
			%   Error id: [BRAPH2:AnalyzeEnsemblePP_MeDict:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('AnalyzeEnsemblePP_MeDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == AnalyzeEnsemblePP_MeDict.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeEnsemblePP_MeDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeEnsemblePP_MeDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for AnalyzeEnsemblePP_MeDict.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph and measure plot/error.
			%
			% CHECK = AnalyzeEnsemblePP_MeDict.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(AnalyzeEnsemblePP_MeDict, TAG) checks whether TAG exists for AnalyzeEnsemblePP_MeDict.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemblePP_MeDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:AnalyzeEnsemblePP_MeDict:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:AnalyzeEnsemblePP_MeDict:WrongInput]
			%  Element.EXISTSTAG(AnalyzeEnsemblePP_MeDict, TAG) throws error if TAG does NOT exist for AnalyzeEnsemblePP_MeDict.
			%   Error id: [BRAPH2:AnalyzeEnsemblePP_MeDict:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('AnalyzeEnsemblePP_MeDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			analyzeensemblepp_medict_tag_list = cellfun(@(x) AnalyzeEnsemblePP_MeDict.getPropTag(x), num2cell(AnalyzeEnsemblePP_MeDict.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, analyzeensemblepp_medict_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeEnsemblePP_MeDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeEnsemblePP_MeDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for AnalyzeEnsemblePP_MeDict.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(AnalyzeEnsemblePP_MeDict, POINTER) returns property number of POINTER of AnalyzeEnsemblePP_MeDict.
			%  PROPERTY = PR.GETPROPPROP(AnalyzeEnsemblePP_MeDict, POINTER) returns property number of POINTER of AnalyzeEnsemblePP_MeDict.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('AnalyzeEnsemblePP_MeDict')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				analyzeensemblepp_medict_tag_list = cellfun(@(x) AnalyzeEnsemblePP_MeDict.getPropTag(x), num2cell(AnalyzeEnsemblePP_MeDict.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, analyzeensemblepp_medict_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(AnalyzeEnsemblePP_MeDict, POINTER) returns tag of POINTER of AnalyzeEnsemblePP_MeDict.
			%  TAG = PR.GETPROPTAG(AnalyzeEnsemblePP_MeDict, POINTER) returns tag of POINTER of AnalyzeEnsemblePP_MeDict.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('AnalyzeEnsemblePP_MeDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case AnalyzeEnsemblePP_MeDict.TABLE_HEIGHT
						tag = AnalyzeEnsemblePP_MeDict.TABLE_HEIGHT_TAG;
					case AnalyzeEnsemblePP_MeDict.SELECTED
						tag = AnalyzeEnsemblePP_MeDict.SELECTED_TAG;
					case AnalyzeEnsemblePP_MeDict.TABLE
						tag = AnalyzeEnsemblePP_MeDict.TABLE_TAG;
					case AnalyzeEnsemblePP_MeDict.CONTEXTMENU
						tag = AnalyzeEnsemblePP_MeDict.CONTEXTMENU_TAG;
					case AnalyzeEnsemblePP_MeDict.GUI_G_EL
						tag = AnalyzeEnsemblePP_MeDict.GUI_G_EL_TAG;
					case AnalyzeEnsemblePP_MeDict.GUI_M_DICT
						tag = AnalyzeEnsemblePP_MeDict.GUI_M_DICT_TAG;
					case AnalyzeEnsemblePP_MeDict.GUI_B_DICT
						tag = AnalyzeEnsemblePP_MeDict.GUI_B_DICT_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(AnalyzeEnsemblePP_MeDict, POINTER) returns category of POINTER of AnalyzeEnsemblePP_MeDict.
			%  CATEGORY = PR.GETPROPCATEGORY(AnalyzeEnsemblePP_MeDict, POINTER) returns category of POINTER of AnalyzeEnsemblePP_MeDict.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('AnalyzeEnsemblePP_MeDict')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemblePP_MeDict.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemblePP_MeDict.TABLE_HEIGHT
					prop_category = AnalyzeEnsemblePP_MeDict.TABLE_HEIGHT_CATEGORY;
				case AnalyzeEnsemblePP_MeDict.SELECTED
					prop_category = AnalyzeEnsemblePP_MeDict.SELECTED_CATEGORY;
				case AnalyzeEnsemblePP_MeDict.TABLE
					prop_category = AnalyzeEnsemblePP_MeDict.TABLE_CATEGORY;
				case AnalyzeEnsemblePP_MeDict.CONTEXTMENU
					prop_category = AnalyzeEnsemblePP_MeDict.CONTEXTMENU_CATEGORY;
				case AnalyzeEnsemblePP_MeDict.GUI_G_EL
					prop_category = AnalyzeEnsemblePP_MeDict.GUI_G_EL_CATEGORY;
				case AnalyzeEnsemblePP_MeDict.GUI_M_DICT
					prop_category = AnalyzeEnsemblePP_MeDict.GUI_M_DICT_CATEGORY;
				case AnalyzeEnsemblePP_MeDict.GUI_B_DICT
					prop_category = AnalyzeEnsemblePP_MeDict.GUI_B_DICT_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(AnalyzeEnsemblePP_MeDict, POINTER) returns format of POINTER of AnalyzeEnsemblePP_MeDict.
			%  FORMAT = PR.GETPROPFORMAT(AnalyzeEnsemblePP_MeDict, POINTER) returns format of POINTER of AnalyzeEnsemblePP_MeDict.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('AnalyzeEnsemblePP_MeDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemblePP_MeDict.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemblePP_MeDict.TABLE_HEIGHT
					prop_format = AnalyzeEnsemblePP_MeDict.TABLE_HEIGHT_FORMAT;
				case AnalyzeEnsemblePP_MeDict.SELECTED
					prop_format = AnalyzeEnsemblePP_MeDict.SELECTED_FORMAT;
				case AnalyzeEnsemblePP_MeDict.TABLE
					prop_format = AnalyzeEnsemblePP_MeDict.TABLE_FORMAT;
				case AnalyzeEnsemblePP_MeDict.CONTEXTMENU
					prop_format = AnalyzeEnsemblePP_MeDict.CONTEXTMENU_FORMAT;
				case AnalyzeEnsemblePP_MeDict.GUI_G_EL
					prop_format = AnalyzeEnsemblePP_MeDict.GUI_G_EL_FORMAT;
				case AnalyzeEnsemblePP_MeDict.GUI_M_DICT
					prop_format = AnalyzeEnsemblePP_MeDict.GUI_M_DICT_FORMAT;
				case AnalyzeEnsemblePP_MeDict.GUI_B_DICT
					prop_format = AnalyzeEnsemblePP_MeDict.GUI_B_DICT_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(AnalyzeEnsemblePP_MeDict, POINTER) returns description of POINTER of AnalyzeEnsemblePP_MeDict.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(AnalyzeEnsemblePP_MeDict, POINTER) returns description of POINTER of AnalyzeEnsemblePP_MeDict.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('AnalyzeEnsemblePP_MeDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemblePP_MeDict.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemblePP_MeDict.TABLE_HEIGHT
					prop_description = 'TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.';
				case AnalyzeEnsemblePP_MeDict.SELECTED
					prop_description = 'SELECTED (gui, cvector) is the list of selected items.';
				case AnalyzeEnsemblePP_MeDict.TABLE
					prop_description = 'TABLE (evanescent, handle) is the table.';
				case AnalyzeEnsemblePP_MeDict.CONTEXTMENU
					prop_description = 'CONTEXTMENU (evanescent, handle) is the context menu.';
				case AnalyzeEnsemblePP_MeDict.GUI_G_EL
					prop_description = 'GUI_G_EL (gui, item) contains the GUI for the graph.';
				case AnalyzeEnsemblePP_MeDict.GUI_M_DICT
					prop_description = 'GUI_M_DICT (gui, idict) contains the GUIs for the measures.';
				case AnalyzeEnsemblePP_MeDict.GUI_B_DICT
					prop_description = 'GUI_B_DICT (gui, idict) contains the GUIs for the brain surface.';
				case AnalyzeEnsemblePP_MeDict.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case AnalyzeEnsemblePP_MeDict.NAME
					prop_description = 'NAME (constant, string) is the name of the graph and measure panel.';
				case AnalyzeEnsemblePP_MeDict.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the graph and measure panel.';
				case AnalyzeEnsemblePP_MeDict.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the graph and measure panel.';
				case AnalyzeEnsemblePP_MeDict.ID
					prop_description = 'ID (data, string) is a few-letter code for the graph and measure panel.';
				case AnalyzeEnsemblePP_MeDict.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the graph and measure panel.';
				case AnalyzeEnsemblePP_MeDict.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the graph and measure panel.';
				case AnalyzeEnsemblePP_MeDict.EL
					prop_description = 'EL (data, item) is the element.';
				case AnalyzeEnsemblePP_MeDict.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case AnalyzeEnsemblePP_MeDict.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case AnalyzeEnsemblePP_MeDict.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the table.';
				case AnalyzeEnsemblePP_MeDict.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case AnalyzeEnsemblePP_MeDict.SHOW
					prop_description = 'SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.';
				case AnalyzeEnsemblePP_MeDict.HIDE
					prop_description = 'HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.';
				case AnalyzeEnsemblePP_MeDict.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
				case AnalyzeEnsemblePP_MeDict.CLOSE
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
			%  SETTINGS = Element.GETPROPSETTINGS(AnalyzeEnsemblePP_MeDict, POINTER) returns settings of POINTER of AnalyzeEnsemblePP_MeDict.
			%  SETTINGS = PR.GETPROPSETTINGS(AnalyzeEnsemblePP_MeDict, POINTER) returns settings of POINTER of AnalyzeEnsemblePP_MeDict.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('AnalyzeEnsemblePP_MeDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemblePP_MeDict.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemblePP_MeDict.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case AnalyzeEnsemblePP_MeDict.SELECTED
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case AnalyzeEnsemblePP_MeDict.TABLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case AnalyzeEnsemblePP_MeDict.CONTEXTMENU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case AnalyzeEnsemblePP_MeDict.GUI_G_EL
					prop_settings = 'GUIElement';
				case AnalyzeEnsemblePP_MeDict.GUI_M_DICT
					prop_settings = 'GUIElement';
				case AnalyzeEnsemblePP_MeDict.GUI_B_DICT
					prop_settings = 'GUIFig';
				case AnalyzeEnsemblePP_MeDict.TEMPLATE
					prop_settings = 'AnalyzeEnsemblePP_MeDict';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = AnalyzeEnsemblePP_MeDict.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemblePP_MeDict.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(AnalyzeEnsemblePP_MeDict, POINTER) returns the default value of POINTER of AnalyzeEnsemblePP_MeDict.
			%  DEFAULT = PR.GETPROPDEFAULT(AnalyzeEnsemblePP_MeDict, POINTER) returns the default value of POINTER of AnalyzeEnsemblePP_MeDict.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('AnalyzeEnsemblePP_MeDict')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeEnsemblePP_MeDict.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemblePP_MeDict.TABLE_HEIGHT
					prop_default = s(30);
				case AnalyzeEnsemblePP_MeDict.SELECTED
					prop_default = Format.getFormatDefault(Format.CVECTOR, AnalyzeEnsemblePP_MeDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_MeDict.TABLE
					prop_default = Format.getFormatDefault(Format.HANDLE, AnalyzeEnsemblePP_MeDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_MeDict.CONTEXTMENU
					prop_default = Format.getFormatDefault(Format.HANDLE, AnalyzeEnsemblePP_MeDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_MeDict.GUI_G_EL
					prop_default = Format.getFormatDefault(Format.ITEM, AnalyzeEnsemblePP_MeDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_MeDict.GUI_M_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, AnalyzeEnsemblePP_MeDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_MeDict.GUI_B_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, AnalyzeEnsemblePP_MeDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_MeDict.ELCLASS
					prop_default = 'AnalyzeEnsemblePP_MeDict';
				case AnalyzeEnsemblePP_MeDict.NAME
					prop_default = 'AnalyzeEnsemblePP_MeDict';
				case AnalyzeEnsemblePP_MeDict.DESCRIPTION
					prop_default = 'AnalyzeEnsemblePP_MeDict plots the panel to manage the graph and measures of an ensemble analysis.';
				case AnalyzeEnsemblePP_MeDict.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, AnalyzeEnsemblePP_MeDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_MeDict.ID
					prop_default = 'AnalyzeEnsemblePP_MeDict';
				case AnalyzeEnsemblePP_MeDict.LABEL
					prop_default = 'AnalyzeEnsemblePP_MeDict label';
				case AnalyzeEnsemblePP_MeDict.NOTES
					prop_default = 'AnalyzeEnsemblePP_MeDict';
				case AnalyzeEnsemblePP_MeDict.EL
					prop_default = AnalyzeEnsemble();
				case AnalyzeEnsemblePP_MeDict.PROP
					prop_default = AnalyzeEnsemble.ME_DICT;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = AnalyzeEnsemblePP_MeDict.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemblePP_MeDict.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemblePP_MeDict, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemblePP_MeDict.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemblePP_MeDict, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemblePP_MeDict.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('AnalyzeEnsemblePP_MeDict')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = AnalyzeEnsemblePP_MeDict.getPropProp(pointer);
			
			prop_default = AnalyzeEnsemblePP_MeDict.conditioning(prop, AnalyzeEnsemblePP_MeDict.getPropDefault(prop));
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
			
			prop = AnalyzeEnsemblePP_MeDict.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemblePP_MeDict.SELECTED % __AnalyzeEnsemblePP_MeDict.SELECTED__
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
			%  CHECK = Element.CHECKPROP(AnalyzeEnsemblePP_MeDict, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemblePP_MeDict.
			%  CHECK = PR.CHECKPROP(AnalyzeEnsemblePP_MeDict, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemblePP_MeDict.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:AnalyzeEnsemblePP_MeDict:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:AnalyzeEnsemblePP_MeDict:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(AnalyzeEnsemblePP_MeDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemblePP_MeDict.
			%   Error id: €BRAPH2.STR€:AnalyzeEnsemblePP_MeDict:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(AnalyzeEnsemblePP_MeDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemblePP_MeDict.
			%   Error id: €BRAPH2.STR€:AnalyzeEnsemblePP_MeDict:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('AnalyzeEnsemblePP_MeDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = AnalyzeEnsemblePP_MeDict.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemblePP_MeDict.TABLE_HEIGHT % __AnalyzeEnsemblePP_MeDict.TABLE_HEIGHT__
					check = Format.checkFormat(Format.SIZE, value, AnalyzeEnsemblePP_MeDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_MeDict.SELECTED % __AnalyzeEnsemblePP_MeDict.SELECTED__
					check = Format.checkFormat(Format.CVECTOR, value, AnalyzeEnsemblePP_MeDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_MeDict.TABLE % __AnalyzeEnsemblePP_MeDict.TABLE__
					check = Format.checkFormat(Format.HANDLE, value, AnalyzeEnsemblePP_MeDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_MeDict.CONTEXTMENU % __AnalyzeEnsemblePP_MeDict.CONTEXTMENU__
					check = Format.checkFormat(Format.HANDLE, value, AnalyzeEnsemblePP_MeDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_MeDict.GUI_G_EL % __AnalyzeEnsemblePP_MeDict.GUI_G_EL__
					check = Format.checkFormat(Format.ITEM, value, AnalyzeEnsemblePP_MeDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_MeDict.GUI_M_DICT % __AnalyzeEnsemblePP_MeDict.GUI_M_DICT__
					check = Format.checkFormat(Format.IDICT, value, AnalyzeEnsemblePP_MeDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_MeDict.GUI_B_DICT % __AnalyzeEnsemblePP_MeDict.GUI_B_DICT__
					check = Format.checkFormat(Format.IDICT, value, AnalyzeEnsemblePP_MeDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_MeDict.TEMPLATE % __AnalyzeEnsemblePP_MeDict.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, AnalyzeEnsemblePP_MeDict.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeEnsemblePP_MeDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeEnsemblePP_MeDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' AnalyzeEnsemblePP_MeDict.getPropTag(prop) ' (' AnalyzeEnsemblePP_MeDict.getFormatTag(AnalyzeEnsemblePP_MeDict.getPropFormat(prop)) ').'] ...
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
				case AnalyzeEnsemblePP_MeDict.TABLE % __AnalyzeEnsemblePP_MeDict.TABLE__
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
					
				case AnalyzeEnsemblePP_MeDict.CONTEXTMENU % __AnalyzeEnsemblePP_MeDict.CONTEXTMENU__
					contextmenu = uicontextmenu( ...
					    'Parent', ancestor(pr.get('H'), 'figure'), ...
					    'Tag', 'CONTEXTMENU' ...
					    );
					menu_select_all = uimenu( ...
						'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_SELECT_ALL', ...
					    'Text', 'Select All Measures', ...
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
					    'Text', 'Calculate Selected Measures', ...
						'MenuSelectedFcn', {@cb_calculate} ...
					    );
					menu_open_plots = uimenu( ... 
						'Separator', 'on', ...
						'Parent', contextmenu, ...
						'Tag', 'MENU_OPEN_PLOTS', ...
						'Text', 'Plot Selected Measures ...', ...
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
					    'Text', 'Data Selected Measures ...', ...
					    'MenuSelectedFcn', {@cb_open_elements} ...
					    );
					menu_hide_elements = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_ELEMENTS', ...
					    'Text', 'Hide Selected Data', ...
						'MenuSelectedFcn', {@cb_hide_elements} ...
					    );
					menu_open_elements = uimenu( ...
						'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_OPEN_ELEMENTS', ...
					    'Text', 'Plot Selected Measures on Brain ...', ...
					    'MenuSelectedFcn', {@cb_open_mbrain} ...
					    );
					menu_hide_elements = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_ELEMENTS', ...
					    'Text', 'Hide Selected Brain-Plots', ...
						'MenuSelectedFcn', {@cb_hide_mbrain} ...
					    );
					
					set(pr.get('TABLE'), 'ContextMenu', contextmenu)
					
					value = contextmenu;
					
				case AnalyzeEnsemblePP_MeDict.X_DRAW % __AnalyzeEnsemblePP_MeDict.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					end
					
				case AnalyzeEnsemblePP_MeDict.UPDATE % __AnalyzeEnsemblePP_MeDict.UPDATE__
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
					
				case AnalyzeEnsemblePP_MeDict.REDRAW % __AnalyzeEnsemblePP_MeDict.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('TABLE'), 'Position', [s(.3) s(.3) w_p-s(.6) max(1, pr.get('HEIGHT')-s(2.2))])
					end
					
				case AnalyzeEnsemblePP_MeDict.SHOW % __AnalyzeEnsemblePP_MeDict.SHOW__
					value = calculateValue@PanelProp(pr, PanelProp.SHOW, varargin{:}); % also warning
					if value
					    % figure for graph data
					    if isa(pr.getr('GUI_G_EL'), 'GUIElement') && pr.get('GUI_G_EL').get('DRAWN')
					        pr.get('GUI_G_EL').get('SHOW')
					    end
					    
					    % figures for measure data
					    gui_m_dict = pr.get('GUI_M_DICT');
					    for i = 1:1:gui_m_dict.get('LENGTH')
					        gui = gui_m_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('SHOW')
					        end
					    end
					
					    % figures for measure data
					    gui_b_dict = pr.get('GUI_B_DICT');
					    for i = 1:1:gui_b_dict.get('LENGTH')
					        gui = gui_b_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('SHOW')
					        end
					    end
					end
					
				case AnalyzeEnsemblePP_MeDict.HIDE % __AnalyzeEnsemblePP_MeDict.HIDE__
					value = calculateValue@PanelProp(pr, PanelProp.HIDE, varargin{:}); % also warning
					if value
					    % figure for graph data
					    if isa(pr.getr('GUI_G_EL'), 'GUI') && pr.get('GUI_G_EL').get('DRAWN')
					        pr.get('GUI_G_EL').get('HIDE')
					    end
					
					    % figures for measure data
					    gui_m_dict = pr.get('GUI_M_DICT');
					    for i = 1:1:gui_m_dict.get('LENGTH')
					        gui = gui_m_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('HIDE')
					        end
					    end
					
					    % figures for measure data
					    gui_b_dict = pr.get('GUI_B_DICT');
					    for i = 1:1:gui_b_dict.get('LENGTH')
					        gui = gui_b_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('HIDE')
					        end
					    end
					end
					
				case AnalyzeEnsemblePP_MeDict.DELETE % __AnalyzeEnsemblePP_MeDict.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('TABLE', Element.getNoValue())
					    pr.set('CONTEXTMENU', Element.getNoValue())
					end
					
				case AnalyzeEnsemblePP_MeDict.CLOSE % __AnalyzeEnsemblePP_MeDict.CLOSE__
					value = calculateValue@PanelProp(pr, PanelProp.CLOSE, varargin{:}); % also warning
					if value
					    % figure for graph data
					    if isa(pr.getr('GUI_G_EL'), 'GUIElement') && pr.get('GUI_G_EL').get('DRAWN')
					        pr.get('GUI_G_EL').get('CLOSE')
					    end
					    
					    % figures for measure data
					    gui_m_dict = pr.get('GUI_M_DICT');
					    for i = 1:1:gui_m_dict.get('LENGTH')
					        gui = gui_m_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('CLOSE')
					        end
					    end
					
					    % figures for measure data
					    gui_b_dict = pr.get('GUI_B_DICT');
					    for i = 1:1:gui_b_dict.get('LENGTH')
					        gui = gui_b_dict.get('IT', i);
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
			    g = pr.get('EL').getPropDefaultConditioned(pr.get('PROP'));
			    m_list = g.get('COMPATIBLE_MEASURES');
			
			    pr.set('SELECTED', [1:1:length(m_list)])
			
			    pr.get('UPDATE')
			end
			function cb_clear_selection(~, ~) 
			    pr.set('SELECTED', [])
			
			    pr.get('UPDATE')
			end
			function cb_invert_selection(~, ~) 
			    g = pr.get('EL').get('GRAPH_TEMPLATE'); % default graph
			    m_list = g.get('COMPATIBLE_MEASURES');
			
			    selected_tmp = [1:1:length(m_list)];
			    selected_tmp(pr.get('SELECTED')) = [];
			    pr.set('SELECTED', selected_tmp);
			
			    pr.get('UPDATE')
			end
			function cb_calculate(~, ~) 
			    a = pr.get('EL');
			    g = a.get('GRAPH_TEMPLATE'); 
			    m_list = g.get('COMPATIBLE_MEASURES');
			    selected = pr.get('SELECTED');
			    
			    wb = braph2waitbar(pr.get('WAITBAR'), 0, ['Calculating ' num2str(length(selected))  ' measures ...']);
			
			    for s = 1:1:length(selected)
			        measure = m_list{selected(s)};
			        me = a.get('MEASUREENSEMBLE', measure);
			
			        braph2waitbar(wb, .1 + s / length(selected), ['Calculating measure ' int2str(s) ' (' measure ') of ' int2str(length(selected)) ' ...'])
			
			        if isa(me.getr('M'), 'NoValue')
			            a.get('MEASUREENSEMBLE', measure).memorize('M');
			        end
			    end
			    
				braph2waitbar(wb, 'close')
			
				pr.get('UPDATE');
			end
			function cb_open_plots(~, ~)
			    a = pr.get('EL');   
			    g = a.get('GRAPH_TEMPLATE'); 
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
			    N = ceil(sqrt(length(m_list))); % number of row and columns of figures
			
			    gui_m_dict = pr.memorize('GUI_M_DICT');
			    
			    selected = pr.get('SELECTED');
				for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			
			        me = a.get('MEASUREENSEMBLE', measure);
			        
			        if ~gui_m_dict.get('CONTAINS_KEY', measure)
			            gui = GUIElement( ...
			                'ID', measure, ... % this is the dictionary key
			                'PE', me, ... %.get('PFME'), ...
			                'POSITION', [ ...
			                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ...
			                    y0(f, 'normalized') ...
			                    w(f, 'normalized') ...
			                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ...
			                    ], ...
			                'WAITBAR', pr.getCallback('WAITBAR'), ...
			                'CLOSEREQ', false ...
			                );
			            gui_m_dict.get('ADD', gui)
			        end
			        
			        gui = gui_m_dict.get('IT', measure);
			        if ~gui.get('DRAWN')
			            gui.get('DRAW')
			        end
			        gui_pfm = gui.get('PE').get('PR_DICT').get('IT', 'PFME').memorize('GUI_ITEM');
			        set(gui_pfm, 'TITLE', ['Measure plot - ' g.get('MEASURE', measure).get('NAME')]);
			        if ~gui_pfm.get('DRAW')
			            gui_pfm.get('DRAW')
			        end
			        gui_pfm.get('SHOW')
			    end
			end
			function cb_hide_plots(~, ~)
			    g = pr.get('EL').get('GRAPH_TEMPLATE'); % default graph
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    gui_m_dict = pr.memorize('GUI_M_DICT');
			
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			        
			        if gui_m_dict.get('CONTAINS_KEY', measure)
			            gui = gui_m_dict.get('IT', measure);
			            gui_pfm = gui.get('PE').get('PR_DICT').get('IT', 'PFME').memorize('GUI_ITEM');
			            if gui.get('DRAWN')
			                gui_pfm.get('HIDE')
			            end
			        end
			    end
			end
			function cb_open_elements(~, ~)
			    a = pr.get('EL');    
			    g = a.get('GRAPH_TEMPLATE'); % actual graph
			    g.memorize('A'); % memorizing A to get correct ALAYERLABELS
			    
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
			    N = ceil(sqrt(length(m_list))); % number of row and columns of figures
			
			    gui_m_dict = pr.memorize('GUI_M_DICT');
			    
			    selected = pr.get('SELECTED');
				for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			
			        me = a.get('MEASUREENSEMBLE', measure);
			        
			        if ~gui_m_dict.get('CONTAINS_KEY', measure)
			            gui = GUIElement( ...
			                'ID', measure, ... % this is the dictionary key
			                'PE', me, ... 
			                'POSITION', [ ...
			                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ... % x = (f_gr_x + f_gr_w) / screen_w + mod(selected_it - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
			                    y0(f, 'normalized') ... % y = f_gr_y / screen_h;
			                    w(f, 'normalized') ... % w = f_gr_w / screen_w;
			                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ... % h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_it - .5) / N)) / N / screen_h;
			                    ], ...
			                'WAITBAR', pr.getCallback('WAITBAR'), ...
			                'CLOSEREQ', false ...
			                );
			            gui_m_dict.get('ADD', gui)
			        end
			        
			        gui = gui_m_dict.get('IT', measure);
			        if ~gui.get('DRAWN')
			            gui.get('DRAW')
			        end
			        gui.get('SHOW')
				end
			end
			function cb_hide_elements(~, ~)
			    g = pr.get('EL').get('GRAPH_TEMPLATE'); % default graph
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    gui_m_dict = pr.memorize('GUI_M_DICT');
			
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
			function cb_open_mbrain(~, ~)
			    a = pr.get('EL'); 
			    g = a.get('GRAPH_TEMPLATE'); % actual graph
			    g.memorize('A'); % memorizing A to get correct ALAYERLABELS
			    
			    m_list = g.get('COMPATIBLE_MEASURES');
			
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI
			    N = ceil(sqrt(length(m_list))); % number of row and columns of figures
			    
			    gui_b_dict = pr.memorize('GUI_B_DICT');
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			    
			        measure = m_list{i}; % also key
			    
			        me = a.get('MEASUREENSEMBLE', measure);
			    
			        if ~gui_b_dict.get('CONTAINS_KEY', measure)
			            gr = a.get('GR');
			            if gr.get('SUB_DICT').get('LENGTH')
			                sub = gr.get('SUB_DICT').get('IT', 1);
			                brain_atlas = sub.get('BA');
			            else
			                brain_atlas = BrainAtlas();
			            end
			
			            switch Element.getPropDefault(measure, 'SHAPE')
			                case Measure.GLOBAL % __Measure.GLOBAL__
			                    switch Element.getPropDefault(measure, 'SCOPE')
			                        case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
			                            mebpf = MeasureEnsembleBrainPF_GS('ME', me, 'BA', brain_atlas);
			                        case Measure.UNILAYER % __Measure.UNILAYER__
			                            mebpf = MeasureEnsembleBrainPF_GU('ME', me, 'BA', brain_atlas);
			                        case Measure.BILAYER % __Measure.BILAYER__
			                            mebpf = MeasureEnsembleBrainPF_GB('ME', me, 'BA', brain_atlas);
			                    end
			                case Measure.NODAL % __Measure.NODAL__
			                    switch Element.getPropDefault(measure, 'SCOPE')
			                        case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
			                            mebpf = MeasureEnsembleBrainPF_NS('ME', me, 'BA', brain_atlas);
			                        case Measure.UNILAYER % __Measure.UNILAYER__
			                            mebpf = MeasureEnsembleBrainPF_NU('ME', me, 'BA', brain_atlas);
			                        case Measure.BILAYER % __Measure.BILAYER__
			                            mebpf = MeasureEnsembleBrainPF_NB('ME', me, 'BA', brain_atlas);
			                    end
			                case Measure.BINODAL % __Measure.BINODAL__
			                    switch Element.getPropDefault(measure, 'SCOPE')
			                        case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
			                            mebpf = MeasureEnsembleBrainPF_BS('ME', me, 'BA', brain_atlas);
			                        case Measure.UNILAYER % __Measure.UNILAYER__
			                            mebpf = MeasureEnsembleBrainPF_BU('ME', me, 'BA', brain_atlas);
			                        case Measure.BILAYER % __Measure.BILAYER__
			                            mebpf = MeasureEnsembleBrainPF_BB('ME', me, 'BA', brain_atlas);
			                    end
			            end
			
			            gui = GUIFig( ...
			                'TITLE', ['Brain plot - ' g.get('MEASURE', measure).get('NAME')], ...
			                'ID', measure, ... % this is the dictionary key
			                'PF', mebpf, ... 
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
			    a = pr.get('EL'); 
			    g = a.get('GRAPH_TEMPLATE'); % actual graph
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
			function set_table()
			    a = pr.get('EL');
			    prop = pr.get('PROP');
			    if isa(a.getr('GRAPH_TEMPLATE'), 'NoValue')
			        g = a.getPropDefaultConditioned('GRAPH_TEMPLATE'); % default graph
			    else
			        g = a.get('GRAPH_TEMPLATE'); % actual graph
			    end
			    
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    if isempty(a.getr(prop).get('IT_LIST'))
			        m_list_already_calculated = {};
			    else
			        m_list_already_calculated = cellfun(@(x) x.get('ID'), a.get('ME_DICT').get('IT_LIST'), 'UniformOutput', false);
			    end
			    
			    rowname = cell(length(m_list), 1);
			    data = cell(length(m_list), 5);
			    for mi = 1:1:length(m_list)
			        if any(cellfun(@(y) isequal(m_list{mi}, y), m_list_already_calculated)) && ~isa(a.get('ME_DICT').get('IT', m_list{mi}).getr('M'), 'NoValue')
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
end
