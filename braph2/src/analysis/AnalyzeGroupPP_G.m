classdef AnalyzeGroupPP_G < PanelProp
	%AnalyzeGroupPP_G plots the panel to manage the graph and measures of a group analysis.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% AnalyzeGroupPP_G plots the panel to manage the graph and measures of a group analysis.
	% It is intended to be used only with the property G of AnalyzeGroup.
	%
	% AnalyzeGroupPP_G methods (constructor):
	%  AnalyzeGroupPP_G - constructor
	%
	% AnalyzeGroupPP_G methods:
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
	% AnalyzeGroupPP_G methods (display):
	%  tostring - string with information about the graph and measure plot
	%  disp - displays information about the graph and measure plot
	%  tree - displays the tree of the graph and measure plot
	%
	% AnalyzeGroupPP_G methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graph and measure plot are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graph and measure plot
	%
	% AnalyzeGroupPP_G methods (save/load, Static):
	%  save - saves BRAPH2 graph and measure plot as b2 file
	%  load - loads a BRAPH2 graph and measure plot from a b2 file
	%
	% AnalyzeGroupPP_G method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graph and measure plot
	%
	% AnalyzeGroupPP_G method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graph and measure plot
	%
	% AnalyzeGroupPP_G methods (inspection, Static):
	%  getClass - returns the class of the graph and measure plot
	%  getSubclasses - returns all subclasses of AnalyzeGroupPP_G
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
	% AnalyzeGroupPP_G methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% AnalyzeGroupPP_G methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% AnalyzeGroupPP_G methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% AnalyzeGroupPP_G methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?AnalyzeGroupPP_G; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">AnalyzeGroupPP_G constants</a>.
	%
	%
	% See also uitable, AnalyzeGroup, Graph, Measure.
	
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
		function pr = AnalyzeGroupPP_G(varargin)
			%AnalyzeGroupPP_G() creates a graph and measure plot.
			%
			% AnalyzeGroupPP_G(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% AnalyzeGroupPP_G(TAG, VALUE, ...) with property TAG set to VALUE.
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
			% CLASS = AnalyzeGroupPP_G.GETCLASS() returns the class 'AnalyzeGroupPP_G'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the graph and measure plot PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('AnalyzeGroupPP_G') returns 'AnalyzeGroupPP_G'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('AnalyzeGroupPP_G')
			%  are less computationally efficient.
			
			pr_class = 'AnalyzeGroupPP_G';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graph and measure plot.
			%
			% LIST = AnalyzeGroupPP_G.GETSUBCLASSES() returns all subclasses of 'AnalyzeGroupPP_G'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the graph and measure plot PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('AnalyzeGroupPP_G') returns all subclasses of 'AnalyzeGroupPP_G'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('AnalyzeGroupPP_G')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('AnalyzeGroupPP_G', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph and measure plot.
			%
			% PROPS = AnalyzeGroupPP_G.GETPROPS() returns the property list of graph and measure plot
			%  as a row vector.
			%
			% PROPS = AnalyzeGroupPP_G.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the graph and measure plot PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('AnalyzeGroupPP_G'[, CATEGORY]) returns the property list of 'AnalyzeGroupPP_G'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('AnalyzeGroupPP_G')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						AnalyzeGroupPP_G.TABLE_HEIGHT ...
						AnalyzeGroupPP_G.SELECTED ...
						AnalyzeGroupPP_G.TABLE ...
						AnalyzeGroupPP_G.CONTEXTMENU ...
						AnalyzeGroupPP_G.GUI_G_EL ...
						AnalyzeGroupPP_G.GUI_M_DICT ...
						AnalyzeGroupPP_G.GUI_B_DICT ...
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
						AnalyzeGroupPP_G.TABLE ...
						AnalyzeGroupPP_G.CONTEXTMENU ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						AnalyzeGroupPP_G.TABLE_HEIGHT ...
						AnalyzeGroupPP_G.SELECTED ...
						AnalyzeGroupPP_G.GUI_G_EL ...
						AnalyzeGroupPP_G.GUI_M_DICT ...
						AnalyzeGroupPP_G.GUI_B_DICT ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graph and measure plot.
			%
			% N = AnalyzeGroupPP_G.GETPROPNUMBER() returns the property number of graph and measure plot.
			%
			% N = AnalyzeGroupPP_G.GETPROPNUMBER(CATEGORY) returns the property number of graph and measure plot
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the graph and measure plot PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('AnalyzeGroupPP_G') returns the property number of 'AnalyzeGroupPP_G'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('AnalyzeGroupPP_G')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(AnalyzeGroupPP_G.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph and measure plot/error.
			%
			% CHECK = AnalyzeGroupPP_G.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(AnalyzeGroupPP_G, PROP) checks whether PROP exists for AnalyzeGroupPP_G.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:AnalyzeGroupPP_G:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:AnalyzeGroupPP_G:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:AnalyzeGroupPP_G:WrongInput]
			%  Element.EXISTSPROP(AnalyzeGroupPP_G, PROP) throws error if PROP does NOT exist for AnalyzeGroupPP_G.
			%   Error id: [BRAPH2:AnalyzeGroupPP_G:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('AnalyzeGroupPP_G')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == AnalyzeGroupPP_G.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeGroupPP_G:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeGroupPP_G:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for AnalyzeGroupPP_G.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph and measure plot/error.
			%
			% CHECK = AnalyzeGroupPP_G.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(AnalyzeGroupPP_G, TAG) checks whether TAG exists for AnalyzeGroupPP_G.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:AnalyzeGroupPP_G:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:AnalyzeGroupPP_G:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:AnalyzeGroupPP_G:WrongInput]
			%  Element.EXISTSTAG(AnalyzeGroupPP_G, TAG) throws error if TAG does NOT exist for AnalyzeGroupPP_G.
			%   Error id: [BRAPH2:AnalyzeGroupPP_G:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('AnalyzeGroupPP_G')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			analyzegrouppp_g_tag_list = cellfun(@(x) AnalyzeGroupPP_G.getPropTag(x), num2cell(AnalyzeGroupPP_G.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, analyzegrouppp_g_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeGroupPP_G:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeGroupPP_G:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for AnalyzeGroupPP_G.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(AnalyzeGroupPP_G, POINTER) returns property number of POINTER of AnalyzeGroupPP_G.
			%  PROPERTY = PR.GETPROPPROP(AnalyzeGroupPP_G, POINTER) returns property number of POINTER of AnalyzeGroupPP_G.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('AnalyzeGroupPP_G')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				analyzegrouppp_g_tag_list = cellfun(@(x) AnalyzeGroupPP_G.getPropTag(x), num2cell(AnalyzeGroupPP_G.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, analyzegrouppp_g_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(AnalyzeGroupPP_G, POINTER) returns tag of POINTER of AnalyzeGroupPP_G.
			%  TAG = PR.GETPROPTAG(AnalyzeGroupPP_G, POINTER) returns tag of POINTER of AnalyzeGroupPP_G.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('AnalyzeGroupPP_G')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case AnalyzeGroupPP_G.TABLE_HEIGHT
						tag = AnalyzeGroupPP_G.TABLE_HEIGHT_TAG;
					case AnalyzeGroupPP_G.SELECTED
						tag = AnalyzeGroupPP_G.SELECTED_TAG;
					case AnalyzeGroupPP_G.TABLE
						tag = AnalyzeGroupPP_G.TABLE_TAG;
					case AnalyzeGroupPP_G.CONTEXTMENU
						tag = AnalyzeGroupPP_G.CONTEXTMENU_TAG;
					case AnalyzeGroupPP_G.GUI_G_EL
						tag = AnalyzeGroupPP_G.GUI_G_EL_TAG;
					case AnalyzeGroupPP_G.GUI_M_DICT
						tag = AnalyzeGroupPP_G.GUI_M_DICT_TAG;
					case AnalyzeGroupPP_G.GUI_B_DICT
						tag = AnalyzeGroupPP_G.GUI_B_DICT_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(AnalyzeGroupPP_G, POINTER) returns category of POINTER of AnalyzeGroupPP_G.
			%  CATEGORY = PR.GETPROPCATEGORY(AnalyzeGroupPP_G, POINTER) returns category of POINTER of AnalyzeGroupPP_G.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('AnalyzeGroupPP_G')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeGroupPP_G.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroupPP_G.TABLE_HEIGHT
					prop_category = AnalyzeGroupPP_G.TABLE_HEIGHT_CATEGORY;
				case AnalyzeGroupPP_G.SELECTED
					prop_category = AnalyzeGroupPP_G.SELECTED_CATEGORY;
				case AnalyzeGroupPP_G.TABLE
					prop_category = AnalyzeGroupPP_G.TABLE_CATEGORY;
				case AnalyzeGroupPP_G.CONTEXTMENU
					prop_category = AnalyzeGroupPP_G.CONTEXTMENU_CATEGORY;
				case AnalyzeGroupPP_G.GUI_G_EL
					prop_category = AnalyzeGroupPP_G.GUI_G_EL_CATEGORY;
				case AnalyzeGroupPP_G.GUI_M_DICT
					prop_category = AnalyzeGroupPP_G.GUI_M_DICT_CATEGORY;
				case AnalyzeGroupPP_G.GUI_B_DICT
					prop_category = AnalyzeGroupPP_G.GUI_B_DICT_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(AnalyzeGroupPP_G, POINTER) returns format of POINTER of AnalyzeGroupPP_G.
			%  FORMAT = PR.GETPROPFORMAT(AnalyzeGroupPP_G, POINTER) returns format of POINTER of AnalyzeGroupPP_G.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('AnalyzeGroupPP_G')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeGroupPP_G.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroupPP_G.TABLE_HEIGHT
					prop_format = AnalyzeGroupPP_G.TABLE_HEIGHT_FORMAT;
				case AnalyzeGroupPP_G.SELECTED
					prop_format = AnalyzeGroupPP_G.SELECTED_FORMAT;
				case AnalyzeGroupPP_G.TABLE
					prop_format = AnalyzeGroupPP_G.TABLE_FORMAT;
				case AnalyzeGroupPP_G.CONTEXTMENU
					prop_format = AnalyzeGroupPP_G.CONTEXTMENU_FORMAT;
				case AnalyzeGroupPP_G.GUI_G_EL
					prop_format = AnalyzeGroupPP_G.GUI_G_EL_FORMAT;
				case AnalyzeGroupPP_G.GUI_M_DICT
					prop_format = AnalyzeGroupPP_G.GUI_M_DICT_FORMAT;
				case AnalyzeGroupPP_G.GUI_B_DICT
					prop_format = AnalyzeGroupPP_G.GUI_B_DICT_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(AnalyzeGroupPP_G, POINTER) returns description of POINTER of AnalyzeGroupPP_G.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(AnalyzeGroupPP_G, POINTER) returns description of POINTER of AnalyzeGroupPP_G.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('AnalyzeGroupPP_G')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeGroupPP_G.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroupPP_G.TABLE_HEIGHT
					prop_description = 'TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.';
				case AnalyzeGroupPP_G.SELECTED
					prop_description = 'SELECTED (gui, cvector) is the list of selected items.';
				case AnalyzeGroupPP_G.TABLE
					prop_description = 'TABLE (evanescent, handle) is the table.';
				case AnalyzeGroupPP_G.CONTEXTMENU
					prop_description = 'CONTEXTMENU (evanescent, handle) is the context menu.';
				case AnalyzeGroupPP_G.GUI_G_EL
					prop_description = 'GUI_G_EL (gui, item) contains the GUI for the graph.';
				case AnalyzeGroupPP_G.GUI_M_DICT
					prop_description = 'GUI_M_DICT (gui, idict) contains the GUIs for the measures.';
				case AnalyzeGroupPP_G.GUI_B_DICT
					prop_description = 'GUI_B_DICT (gui, idict) contains the GUIs for the brain measures.';
				case AnalyzeGroupPP_G.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case AnalyzeGroupPP_G.NAME
					prop_description = 'NAME (constant, string) is the name of the graph and measure panel.';
				case AnalyzeGroupPP_G.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the graph and measure panel.';
				case AnalyzeGroupPP_G.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the graph and measure panel.';
				case AnalyzeGroupPP_G.ID
					prop_description = 'ID (data, string) is a few-letter code for the graph and measure panel.';
				case AnalyzeGroupPP_G.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the graph and measure panel.';
				case AnalyzeGroupPP_G.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the graph and measure panel.';
				case AnalyzeGroupPP_G.EL
					prop_description = 'EL (data, item) is the element.';
				case AnalyzeGroupPP_G.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case AnalyzeGroupPP_G.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case AnalyzeGroupPP_G.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the table.';
				case AnalyzeGroupPP_G.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case AnalyzeGroupPP_G.SHOW
					prop_description = 'SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.';
				case AnalyzeGroupPP_G.HIDE
					prop_description = 'HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.';
				case AnalyzeGroupPP_G.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
				case AnalyzeGroupPP_G.CLOSE
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
			%  SETTINGS = Element.GETPROPSETTINGS(AnalyzeGroupPP_G, POINTER) returns settings of POINTER of AnalyzeGroupPP_G.
			%  SETTINGS = PR.GETPROPSETTINGS(AnalyzeGroupPP_G, POINTER) returns settings of POINTER of AnalyzeGroupPP_G.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('AnalyzeGroupPP_G')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeGroupPP_G.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroupPP_G.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case AnalyzeGroupPP_G.SELECTED
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case AnalyzeGroupPP_G.TABLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case AnalyzeGroupPP_G.CONTEXTMENU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case AnalyzeGroupPP_G.GUI_G_EL
					prop_settings = 'GUIElement';
				case AnalyzeGroupPP_G.GUI_M_DICT
					prop_settings = 'GUIElement';
				case AnalyzeGroupPP_G.GUI_B_DICT
					prop_settings = 'GUIFig';
				case AnalyzeGroupPP_G.TEMPLATE
					prop_settings = 'AnalyzeGroupPP_G';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = AnalyzeGroupPP_G.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeGroupPP_G.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(AnalyzeGroupPP_G, POINTER) returns the default value of POINTER of AnalyzeGroupPP_G.
			%  DEFAULT = PR.GETPROPDEFAULT(AnalyzeGroupPP_G, POINTER) returns the default value of POINTER of AnalyzeGroupPP_G.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('AnalyzeGroupPP_G')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeGroupPP_G.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroupPP_G.TABLE_HEIGHT
					prop_default = s(30);
				case AnalyzeGroupPP_G.SELECTED
					prop_default = Format.getFormatDefault(Format.CVECTOR, AnalyzeGroupPP_G.getPropSettings(prop));
				case AnalyzeGroupPP_G.TABLE
					prop_default = Format.getFormatDefault(Format.HANDLE, AnalyzeGroupPP_G.getPropSettings(prop));
				case AnalyzeGroupPP_G.CONTEXTMENU
					prop_default = Format.getFormatDefault(Format.HANDLE, AnalyzeGroupPP_G.getPropSettings(prop));
				case AnalyzeGroupPP_G.GUI_G_EL
					prop_default = Format.getFormatDefault(Format.ITEM, AnalyzeGroupPP_G.getPropSettings(prop));
				case AnalyzeGroupPP_G.GUI_M_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, AnalyzeGroupPP_G.getPropSettings(prop));
				case AnalyzeGroupPP_G.GUI_B_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, AnalyzeGroupPP_G.getPropSettings(prop));
				case AnalyzeGroupPP_G.ELCLASS
					prop_default = 'AnalyzeGroupPP_G';
				case AnalyzeGroupPP_G.NAME
					prop_default = 'AnalyzeGroupPP_G';
				case AnalyzeGroupPP_G.DESCRIPTION
					prop_default = 'AnalyzeGroupPP_G plots the panel to manage the graph and measures of a group analysis.';
				case AnalyzeGroupPP_G.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, AnalyzeGroupPP_G.getPropSettings(prop));
				case AnalyzeGroupPP_G.ID
					prop_default = 'AnalyzeGroupPP_G';
				case AnalyzeGroupPP_G.LABEL
					prop_default = 'AnalyzeGroupPP_G label';
				case AnalyzeGroupPP_G.NOTES
					prop_default = 'AnalyzeGroupPP_G';
				case AnalyzeGroupPP_G.EL
					prop_default = AnalyzeGroup();
				case AnalyzeGroupPP_G.PROP
					prop_default = AnalyzeGroup.G;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = AnalyzeGroupPP_G.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeGroupPP_G.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(AnalyzeGroupPP_G, POINTER) returns the conditioned default value of POINTER of AnalyzeGroupPP_G.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(AnalyzeGroupPP_G, POINTER) returns the conditioned default value of POINTER of AnalyzeGroupPP_G.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('AnalyzeGroupPP_G')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = AnalyzeGroupPP_G.getPropProp(pointer);
			
			prop_default = AnalyzeGroupPP_G.conditioning(prop, AnalyzeGroupPP_G.getPropDefault(prop));
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
			
			prop = AnalyzeGroupPP_G.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroupPP_G.SELECTED % __AnalyzeGroupPP_G.SELECTED__
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
			%  CHECK = Element.CHECKPROP(AnalyzeGroupPP_G, PROP, VALUE) checks VALUE format for PROP of AnalyzeGroupPP_G.
			%  CHECK = PR.CHECKPROP(AnalyzeGroupPP_G, PROP, VALUE) checks VALUE format for PROP of AnalyzeGroupPP_G.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:AnalyzeGroupPP_G:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:AnalyzeGroupPP_G:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(AnalyzeGroupPP_G, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeGroupPP_G.
			%   Error id: €BRAPH2.STR€:AnalyzeGroupPP_G:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(AnalyzeGroupPP_G, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeGroupPP_G.
			%   Error id: €BRAPH2.STR€:AnalyzeGroupPP_G:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('AnalyzeGroupPP_G')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = AnalyzeGroupPP_G.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroupPP_G.TABLE_HEIGHT % __AnalyzeGroupPP_G.TABLE_HEIGHT__
					check = Format.checkFormat(Format.SIZE, value, AnalyzeGroupPP_G.getPropSettings(prop));
				case AnalyzeGroupPP_G.SELECTED % __AnalyzeGroupPP_G.SELECTED__
					check = Format.checkFormat(Format.CVECTOR, value, AnalyzeGroupPP_G.getPropSettings(prop));
				case AnalyzeGroupPP_G.TABLE % __AnalyzeGroupPP_G.TABLE__
					check = Format.checkFormat(Format.HANDLE, value, AnalyzeGroupPP_G.getPropSettings(prop));
				case AnalyzeGroupPP_G.CONTEXTMENU % __AnalyzeGroupPP_G.CONTEXTMENU__
					check = Format.checkFormat(Format.HANDLE, value, AnalyzeGroupPP_G.getPropSettings(prop));
				case AnalyzeGroupPP_G.GUI_G_EL % __AnalyzeGroupPP_G.GUI_G_EL__
					check = Format.checkFormat(Format.ITEM, value, AnalyzeGroupPP_G.getPropSettings(prop));
				case AnalyzeGroupPP_G.GUI_M_DICT % __AnalyzeGroupPP_G.GUI_M_DICT__
					check = Format.checkFormat(Format.IDICT, value, AnalyzeGroupPP_G.getPropSettings(prop));
				case AnalyzeGroupPP_G.GUI_B_DICT % __AnalyzeGroupPP_G.GUI_B_DICT__
					check = Format.checkFormat(Format.IDICT, value, AnalyzeGroupPP_G.getPropSettings(prop));
				case AnalyzeGroupPP_G.TEMPLATE % __AnalyzeGroupPP_G.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, AnalyzeGroupPP_G.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeGroupPP_G:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeGroupPP_G:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' AnalyzeGroupPP_G.getPropTag(prop) ' (' AnalyzeGroupPP_G.getFormatTag(AnalyzeGroupPP_G.getPropFormat(prop)) ').'] ...
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
				case AnalyzeGroupPP_G.TABLE % __AnalyzeGroupPP_G.TABLE__
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
					
				case AnalyzeGroupPP_G.CONTEXTMENU % __AnalyzeGroupPP_G.CONTEXTMENU__
					contextmenu = uicontextmenu( ...
					    'Parent', ancestor(pr.get('H'), 'figure'), ...
					    'Tag', 'CONTEXTMENU' ...
					    );
					menu_open_g_pl = uimenu( ...
						'Parent', contextmenu, ...
						'Tag', 'MENU_OPEN_G_PL', ...
						'Text', 'Plot Graph Plot ...', ...
						'MenuSelectedFcn', {@cb_open_g_pl} ...
						);
					
					menu_hide_g_pl = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_G_PL', ...
					    'Text', 'Hide Graph Plot', ...
					    'MenuSelectedFcn', {@cb_hide_g_pl} ...
						);
					menu_open_g_el = uimenu( ...
						'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_OPEN_G_EL', ...
					    'Text', 'Data Graph ...', ...
					    'MenuSelectedFcn', {@cb_open_g_el} ...
					    );
					menu_hide_g_el = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_G_EL', ...
					    'Text', 'Hide Graph Data', ...
						'MenuSelectedFcn', {@cb_hide_g_el} ...
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
					menu_open_mbrain = uimenu( ...
						'Separator', 'on', ...
						'Parent', contextmenu, ...
						'Tag', 'MENU_OPEN_MBRAIN', ...
						'Text', 'Plot Selected Measures on Brain ...', ...
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
						'Text', 'Line-Plot Selected Measures ...', ...
						'MenuSelectedFcn', {@cb_open_plots} ...
						);
					menu_hide_plots = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_PLOTS', ...
					    'Text', 'Hide Selected Line-Plots', ...
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
					
					set(pr.get('TABLE'), 'ContextMenu', contextmenu)
					
					value = contextmenu;
					
				case AnalyzeGroupPP_G.X_DRAW % __AnalyzeGroupPP_G.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					end
					
				case AnalyzeGroupPP_G.UPDATE % __AnalyzeGroupPP_G.UPDATE__
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
					
				case AnalyzeGroupPP_G.REDRAW % __AnalyzeGroupPP_G.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('TABLE'), 'Position', [s(.3) s(.3) w_p-s(.6) max(1, pr.get('HEIGHT')-s(2.2))])
					end
					
				case AnalyzeGroupPP_G.SHOW % __AnalyzeGroupPP_G.SHOW__
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
					
					    % figures for brain figure
					    gui_b_dict = pr.get('GUI_B_DICT');
					    for i = 1:1:gui_b_dict.get('LENGTH')
					        gui = gui_b_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('SHOW')
					        end
					    end
					end
					
				case AnalyzeGroupPP_G.HIDE % __AnalyzeGroupPP_G.HIDE__
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
					
					    % figures for brain figures
					    gui_b_dict = pr.get('GUI_B_DICT');
					    for i = 1:1:gui_b_dict.get('LENGTH')
					        gui = gui_b_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('HIDE')
					        end
					    end
					end
					
				case AnalyzeGroupPP_G.DELETE % __AnalyzeGroupPP_G.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('TABLE', Element.getNoValue())
					    pr.set('CONTEXTMENU', Element.getNoValue())
					end
					
				case AnalyzeGroupPP_G.CLOSE % __AnalyzeGroupPP_G.CLOSE__
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
					
					    % figures for brain figures
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
			function cb_open_g_pl(~, ~)
			    if isa(pr.getr('GUI_G_EL'), 'NoValue')
			        f = ancestor(pr.get('H'), 'figure');
			
			        el = pr.get('EL'); % AnalyzeGroup
			        prop = pr.get('PROP'); % G
			
			        gui = GUIElement( ...
			            'PE', el.memorize(prop), ... % ensure that the property is stored -- this is the graph G
			            'POSITION', [ ...
			                x0(f, 'normalized')+w(f, 'normalized') ...
			                y0(f, 'normalized') ...
			                w(f, 'normalized') ...
			                h(f, 'normalized') ...
			                ], ...
			            'WAITBAR', pr.getCallback('WAITBAR'), ...
			            'CLOSEREQ', false ...
			            );
			        
			        pr.set('GUI_G_EL', gui)
			    else
			        gui = pr.get('GUI_G_EL');
			    end
			
			    if ~gui.get('DRAWN')
			        gui.get('DRAW')
			    end
			
			    gui_pfga = gui.get('PE').get('PR_DICT').get('IT', 'PFGA').memorize('GUI_ITEM');
			    
			    if ~gui_pfga.get('DRAWN')
			        gui_pfga.get('DRAW')
			    end
			
			    gui_pfga.get('SHOW')
			end
			function cb_hide_g_pl(~, ~)
			    gui = pr.getr('GUI_G_EL');
			    gui_pfga = gui.get('PE').get('PR_DICT').get('IT', 'PFGA').memorize('GUI_ITEM');
			    
			    if gui.get('DRAWN')
			        gui_pfga.get('HIDE')
			    end
			end
			function cb_open_g_el(~, ~)
			    if isa(pr.getr('GUI_G_EL'), 'NoValue')
			        f = ancestor(pr.get('H'), 'figure');
			
			        el = pr.get('EL'); % AnalyzeGroup
			        prop = pr.get('PROP'); % G
			
			        gui = GUIElement( ...
			            'PE', el.memorize(prop), ... % ensure that the property is stored -- this is the graph G
			            'POSITION', [ ...
			                x0(f, 'normalized')+w(f, 'normalized') ...
			                y0(f, 'normalized') ...
			                w(f, 'normalized') ...
			                h(f, 'normalized') ...
			                ], ...
			            'WAITBAR', pr.getCallback('WAITBAR'), ...
			            'CLOSEREQ', false ...
			            );
			        
			        pr.set('GUI_G_EL', gui)
			    else
			        gui = pr.get('GUI_G_EL');
			    end
			
			    if ~gui.get('DRAWN')
			        gui.get('DRAW')
			    end
			    gui.get('SHOW')
			end
			function cb_hide_g_el(~, ~)
			    gui = pr.getr('GUI_G_EL');
			    if isa(gui, 'GUIElement') && gui.get('DRAWN')
			        gui.get('HIDE')
			    end
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
			    g = pr.get('EL').getPropDefaultConditioned(pr.get('PROP')); % default graph
			    m_list = g.get('COMPATIBLE_MEASURES');
			
			    selected_tmp = [1:1:length(m_list)];
			    selected_tmp(pr.get('SELECTED')) = [];
			    pr.set('SELECTED', selected_tmp);
			
			    pr.get('UPDATE')
			end
			function cb_calculate(~, ~) 
			    g = pr.get('EL').get(pr.get('PROP')); % actual graph
			    m_list = g.get('COMPATIBLE_MEASURES');
			    selected = pr.get('SELECTED');
			    
			    wb = braph2waitbar(pr.get('WAITBAR'), 0, ['Calculating ' num2str(length(selected))  ' measures ...']);
			
			    for i = 1:1:length(m_list)
			        if ismember(i, selected)
			            measure = m_list{i};
			
			            braph2waitbar(wb, .1 + .9 * i / length(selected), ['Calculating measure ' int2str(i) ' (' measure ') of ' int2str(length(selected)) ' ...'])
			
			            if isa(g.get('MEASURE', measure).getr('M'), 'NoValue')
			                g.get('MEASURE', measure).memorize('M');
			            end
			        end
			    end
			    
				braph2waitbar(wb, 'close')
			
				pr.get('UPDATE');
			end
			function cb_open_mbrain(~, ~)
			    g = pr.get('EL').get(pr.get('PROP'));
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI
			    N = ceil(sqrt(length(m_list))); % number of row and columns of figures
			    
			    gui_b_dict = pr.memorize('GUI_B_DICT');
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			    
			        measure = m_list{i}; % also key
			    
			        m = g.get('MEASURE', measure);
			    
			        if ~gui_b_dict.get('CONTAINS_KEY', measure)
			            gr = pr.get('EL').get('GR');
			            if gr.get('SUB_DICT').get('LENGTH')
			                sub = gr.get('SUB_DICT').get('IT', 1);
			                brain_atlas = sub.get('BA');
			            else
			                brain_atlas = BrainAtlas();
			            end
			            brain_atlas = sub.get('BA');
			            switch Element.getPropDefault(measure, 'SHAPE')
			                case Measure.GLOBAL % __Measure.GLOBAL__
			                    switch Element.getPropDefault(measure, 'SCOPE')
			                        case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
			                            mgbpf = MeasureGroupBrainPF_GS('M', m, 'BA', brain_atlas);
			                        case Measure.UNILAYER % __Measure.UNILAYER__
			                            mgbpf = MeasureGroupBrainPF_GU('M', m, 'BA', brain_atlas);
			                        case Measure.BILAYER % __Measure.BILAYER__
			                            mgbpf = MeasureGroupBrainPF_GB('M', m, 'BA', brain_atlas);
			                    end
			                case Measure.NODAL % __Measure.NODAL__
			                    switch Element.getPropDefault(measure, 'SCOPE')
			                        case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
			                            mgbpf = MeasureGroupBrainPF_NS('M', m, 'BA', brain_atlas);
			                        case Measure.UNILAYER % __Measure.UNILAYER__
			                            mgbpf = MeasureGroupBrainPF_NU('M', m, 'BA', brain_atlas);
			                        case Measure.BILAYER % __Measure.BILAYER__
			                            mgbpf = MeasureGroupBrainPF_NB('M', m, 'BA', brain_atlas);
			                    end
			                case Measure.BINODAL % __Measure.BINODAL__
			                    switch Element.getPropDefault(measure, 'SCOPE')
			                        case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
			                            mgbpf = MeasureGroupBrainPF_BS('M', m, 'BA', brain_atlas);
			                        case Measure.UNILAYER % __Measure.UNILAYER__
			                            mgbpf = MeasureGroupBrainPF_BU('M', m, 'BA', brain_atlas);
			                        case Measure.BILAYER % __Measure.BILAYER__
			                            mgbpf = MeasureGroupBrainPF_BB('M', m, 'BA', brain_atlas);
			                    end
			            end
			    
			            gui = GUIFig( ...
			                'ID', measure, ... % this is the dictionary key
			                'PF', mgbpf, ...
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
			    g = pr.get('EL').getPropDefaultConditioned(pr.get('PROP')); % default graph
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
			    g = pr.get('EL').get(pr.get('PROP')); % actual graph
			    g.memorize('A'); % memorizing A to get correct ALAYERLABELS
			    
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
			    N = ceil(sqrt(length(m_list))); % number of row and columns of figures
			
			    gui_m_dict = pr.memorize('GUI_M_DICT');
			    
			    selected = pr.get('SELECTED');
				for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			
			        m = g.get('MEASURE', measure);
			        
			        if ~gui_m_dict.get('CONTAINS_KEY', measure)
			            gui = GUIElement( ...
			                'ID', measure, ... % this is the dictionary key
			                'PE', m, ... 
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
			
			        gui_pfm = gui.get('PE').get('PR_DICT').get('IT', 'PFM').memorize('GUI_ITEM');
			    
			        if ~gui_pfm.get('DRAWN')
			            gui_pfm.get('DRAW')
			        end
			
			        gui_pfm.get('SHOW')
				end
			end
			function cb_hide_plots(~, ~)
			    g = pr.get('EL').getPropDefaultConditioned(pr.get('PROP')); % default graph
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    gui_m_dict = pr.memorize('GUI_M_DICT');
			
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			        
			        if gui_m_dict.get('CONTAINS_KEY', measure)
			            gui = gui_m_dict.get('IT', measure);
			            gui_pfm = gui.get('PE').get('PR_DICT').get('IT', 'PFM').memorize('GUI_ITEM');
			            if gui.get('DRAWN')
			                gui_pfm.get('HIDE')
			            end
			        end
			    end
			end
			function cb_open_elements(~, ~)
			    g = pr.get('EL').get(pr.get('PROP')); % actual graph
			    g.memorize('A'); % memorizing A to get correct ALAYERLABELS
			    
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
			    N = ceil(sqrt(length(m_list))); % number of row and columns of figures
			
			    gui_m_dict = pr.memorize('GUI_M_DICT');
			    
			    selected = pr.get('SELECTED');
				for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			
			        m = g.get('MEASURE', measure);
			        
			        if ~gui_m_dict.get('CONTAINS_KEY', measure)
			            gui = GUIElement( ...
			                'ID', measure, ... % this is the dictionary key
			                'PE', m, ... 
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
			    g = pr.get('EL').getPropDefaultConditioned(pr.get('PROP')); % default graph
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
			function set_table()
			    a = pr.get('EL');
			    prop = pr.get('PROP');
			    if isa(a.getr(prop), 'NoValue')
			        g = a.getPropDefaultConditioned(prop); % default graph
			    else
			        g = a.get(prop); % actual graph
			    end
			
			    m_list = g.get('COMPATIBLE_MEASURES');
			
			    if isa(g.getr('M_DICT'), 'NoValue')
			        mlist_already_calculated = {};
			    else
			        mlist_already_calculated = cellfun(@(x) x.get('ELCLASS'), g.get('M_DICT').get('IT_LIST'), 'UniformOutput', false);
			    end
			    
			    rowname = cell(length(m_list), 1);
			    data = cell(length(m_list), 5);
			    for mi = 1:1:length(m_list)
			        if any(cellfun(@(y) isequal(m_list{mi}, y), mlist_already_calculated)) && ~isa(g.get('MEASURE', m_list{mi}).getr('M'), 'NoValue')
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
