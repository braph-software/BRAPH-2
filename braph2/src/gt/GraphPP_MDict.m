classdef GraphPP_MDict < PanelProp
	%GraphPP_MDict plots the measure dictionary property of a graph.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% A Measure Dictionary Plot (GraphPP_MDict) plots the panel of the M_DICT property of Graph.
	% It is intended to be used only with the property M_DICT of Graph.
	%
	% GraphPP_MDict methods (constructor):
	%  GraphPP_MDict - constructor
	%
	% GraphPP_MDict methods:
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
	% GraphPP_MDict methods (display):
	%  tostring - string with information about the measure dictionary plot
	%  disp - displays information about the measure dictionary plot
	%  tree - displays the tree of the measure dictionary plot
	%
	% GraphPP_MDict methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two measure dictionary plot are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the measure dictionary plot
	%
	% GraphPP_MDict methods (save/load, Static):
	%  save - saves BRAPH2 measure dictionary plot as b2 file
	%  load - loads a BRAPH2 measure dictionary plot from a b2 file
	%
	% GraphPP_MDict method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the measure dictionary plot
	%
	% GraphPP_MDict method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the measure dictionary plot
	%
	% GraphPP_MDict methods (inspection, Static):
	%  getClass - returns the class of the measure dictionary plot
	%  getSubclasses - returns all subclasses of GraphPP_MDict
	%  getProps - returns the property list of the measure dictionary plot
	%  getPropNumber - returns the property number of the measure dictionary plot
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
	% GraphPP_MDict methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GraphPP_MDict methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GraphPP_MDict methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GraphPP_MDict methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GraphPP_MDict; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GraphPP_MDict constants</a>.
	%
	%
	% See also uitable, Graph.
	
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
		
		GUI_M_DICT = PanelProp.getPropNumber() + 6;
		GUI_M_DICT_TAG = 'GUI_M_DICT';
		GUI_M_DICT_CATEGORY = Category.GUI;
		GUI_M_DICT_FORMAT = Format.IDICT;
	end
	methods % constructor
		function pr = GraphPP_MDict(varargin)
			%GraphPP_MDict() creates a measure dictionary plot.
			%
			% GraphPP_MDict(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GraphPP_MDict(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the measure dictionary plot.
			%
			% CLASS = GraphPP_MDict.GETCLASS() returns the class 'GraphPP_MDict'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the measure dictionary plot PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('GraphPP_MDict') returns 'GraphPP_MDict'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('GraphPP_MDict')
			%  are less computationally efficient.
			
			pr_class = 'GraphPP_MDict';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the measure dictionary plot.
			%
			% LIST = GraphPP_MDict.GETSUBCLASSES() returns all subclasses of 'GraphPP_MDict'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the measure dictionary plot PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('GraphPP_MDict') returns all subclasses of 'GraphPP_MDict'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('GraphPP_MDict')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GraphPP_MDict', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of measure dictionary plot.
			%
			% PROPS = GraphPP_MDict.GETPROPS() returns the property list of measure dictionary plot
			%  as a row vector.
			%
			% PROPS = GraphPP_MDict.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the measure dictionary plot PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('GraphPP_MDict'[, CATEGORY]) returns the property list of 'GraphPP_MDict'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('GraphPP_MDict')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						GraphPP_MDict.TABLE_HEIGHT ...
						GraphPP_MDict.SELECTED ...
						GraphPP_MDict.TABLE ...
						GraphPP_MDict.CONTEXTMENU ...
						GraphPP_MDict.GUI_F_DICT ...
						GraphPP_MDict.GUI_M_DICT ...
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
						GraphPP_MDict.TABLE ...
						GraphPP_MDict.CONTEXTMENU ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						GraphPP_MDict.TABLE_HEIGHT ...
						GraphPP_MDict.SELECTED ...
						GraphPP_MDict.GUI_F_DICT ...
						GraphPP_MDict.GUI_M_DICT ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of measure dictionary plot.
			%
			% N = GraphPP_MDict.GETPROPNUMBER() returns the property number of measure dictionary plot.
			%
			% N = GraphPP_MDict.GETPROPNUMBER(CATEGORY) returns the property number of measure dictionary plot
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the measure dictionary plot PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('GraphPP_MDict') returns the property number of 'GraphPP_MDict'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('GraphPP_MDict')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GraphPP_MDict.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in measure dictionary plot/error.
			%
			% CHECK = GraphPP_MDict.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(GraphPP_MDict, PROP) checks whether PROP exists for GraphPP_MDict.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GraphPP_MDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:GraphPP_MDict:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:GraphPP_MDict:WrongInput]
			%  Element.EXISTSPROP(GraphPP_MDict, PROP) throws error if PROP does NOT exist for GraphPP_MDict.
			%   Error id: [BRAPH2:GraphPP_MDict:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('GraphPP_MDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GraphPP_MDict.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GraphPP_MDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GraphPP_MDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GraphPP_MDict.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in measure dictionary plot/error.
			%
			% CHECK = GraphPP_MDict.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(GraphPP_MDict, TAG) checks whether TAG exists for GraphPP_MDict.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GraphPP_MDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:GraphPP_MDict:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:GraphPP_MDict:WrongInput]
			%  Element.EXISTSTAG(GraphPP_MDict, TAG) throws error if TAG does NOT exist for GraphPP_MDict.
			%   Error id: [BRAPH2:GraphPP_MDict:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('GraphPP_MDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			graphpp_mdict_tag_list = cellfun(@(x) GraphPP_MDict.getPropTag(x), num2cell(GraphPP_MDict.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, graphpp_mdict_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GraphPP_MDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GraphPP_MDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GraphPP_MDict.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GraphPP_MDict, POINTER) returns property number of POINTER of GraphPP_MDict.
			%  PROPERTY = PR.GETPROPPROP(GraphPP_MDict, POINTER) returns property number of POINTER of GraphPP_MDict.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('GraphPP_MDict')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				graphpp_mdict_tag_list = cellfun(@(x) GraphPP_MDict.getPropTag(x), num2cell(GraphPP_MDict.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, graphpp_mdict_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GraphPP_MDict, POINTER) returns tag of POINTER of GraphPP_MDict.
			%  TAG = PR.GETPROPTAG(GraphPP_MDict, POINTER) returns tag of POINTER of GraphPP_MDict.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('GraphPP_MDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GraphPP_MDict.TABLE_HEIGHT
						tag = GraphPP_MDict.TABLE_HEIGHT_TAG;
					case GraphPP_MDict.SELECTED
						tag = GraphPP_MDict.SELECTED_TAG;
					case GraphPP_MDict.TABLE
						tag = GraphPP_MDict.TABLE_TAG;
					case GraphPP_MDict.CONTEXTMENU
						tag = GraphPP_MDict.CONTEXTMENU_TAG;
					case GraphPP_MDict.GUI_F_DICT
						tag = GraphPP_MDict.GUI_F_DICT_TAG;
					case GraphPP_MDict.GUI_M_DICT
						tag = GraphPP_MDict.GUI_M_DICT_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(GraphPP_MDict, POINTER) returns category of POINTER of GraphPP_MDict.
			%  CATEGORY = PR.GETPROPCATEGORY(GraphPP_MDict, POINTER) returns category of POINTER of GraphPP_MDict.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('GraphPP_MDict')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GraphPP_MDict.getPropProp(pointer);
			
			switch prop
				case GraphPP_MDict.TABLE_HEIGHT
					prop_category = GraphPP_MDict.TABLE_HEIGHT_CATEGORY;
				case GraphPP_MDict.SELECTED
					prop_category = GraphPP_MDict.SELECTED_CATEGORY;
				case GraphPP_MDict.TABLE
					prop_category = GraphPP_MDict.TABLE_CATEGORY;
				case GraphPP_MDict.CONTEXTMENU
					prop_category = GraphPP_MDict.CONTEXTMENU_CATEGORY;
				case GraphPP_MDict.GUI_F_DICT
					prop_category = GraphPP_MDict.GUI_F_DICT_CATEGORY;
				case GraphPP_MDict.GUI_M_DICT
					prop_category = GraphPP_MDict.GUI_M_DICT_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(GraphPP_MDict, POINTER) returns format of POINTER of GraphPP_MDict.
			%  FORMAT = PR.GETPROPFORMAT(GraphPP_MDict, POINTER) returns format of POINTER of GraphPP_MDict.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('GraphPP_MDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GraphPP_MDict.getPropProp(pointer);
			
			switch prop
				case GraphPP_MDict.TABLE_HEIGHT
					prop_format = GraphPP_MDict.TABLE_HEIGHT_FORMAT;
				case GraphPP_MDict.SELECTED
					prop_format = GraphPP_MDict.SELECTED_FORMAT;
				case GraphPP_MDict.TABLE
					prop_format = GraphPP_MDict.TABLE_FORMAT;
				case GraphPP_MDict.CONTEXTMENU
					prop_format = GraphPP_MDict.CONTEXTMENU_FORMAT;
				case GraphPP_MDict.GUI_F_DICT
					prop_format = GraphPP_MDict.GUI_F_DICT_FORMAT;
				case GraphPP_MDict.GUI_M_DICT
					prop_format = GraphPP_MDict.GUI_M_DICT_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GraphPP_MDict, POINTER) returns description of POINTER of GraphPP_MDict.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(GraphPP_MDict, POINTER) returns description of POINTER of GraphPP_MDict.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('GraphPP_MDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GraphPP_MDict.getPropProp(pointer);
			
			switch prop
				case GraphPP_MDict.TABLE_HEIGHT
					prop_description = 'TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.';
				case GraphPP_MDict.SELECTED
					prop_description = 'SELECTED (gui, cvector) is the list of selected items.';
				case GraphPP_MDict.TABLE
					prop_description = 'TABLE (evanescent, handle) is the table.';
				case GraphPP_MDict.CONTEXTMENU
					prop_description = 'CONTEXTMENU (evanescent, handle) is the context menu.';
				case GraphPP_MDict.GUI_F_DICT
					prop_description = 'GUI_F_DICT (gui, idict) contains the GUIs for the measure figures.';
				case GraphPP_MDict.GUI_M_DICT
					prop_description = 'GUI_M_DICT (gui, idict) contains the GUIs for the measures.';
				case GraphPP_MDict.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the measure dictionary plot.';
				case GraphPP_MDict.NAME
					prop_description = 'NAME (constant, string) is the name of the measure dictionary plot.';
				case GraphPP_MDict.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the measure dictionary plot.';
				case GraphPP_MDict.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the measure dictionary plot.';
				case GraphPP_MDict.ID
					prop_description = 'ID (data, string) is a few-letter code for the measure dictionary plot.';
				case GraphPP_MDict.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the measure dictionary plot.';
				case GraphPP_MDict.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the measure dictionary plot.';
				case GraphPP_MDict.EL
					prop_description = 'EL (data, item) is the element.';
				case GraphPP_MDict.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case GraphPP_MDict.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case GraphPP_MDict.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the table.';
				case GraphPP_MDict.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case GraphPP_MDict.SHOW
					prop_description = 'SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.';
				case GraphPP_MDict.HIDE
					prop_description = 'HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.';
				case GraphPP_MDict.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
				case GraphPP_MDict.CLOSE
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
			%  SETTINGS = Element.GETPROPSETTINGS(GraphPP_MDict, POINTER) returns settings of POINTER of GraphPP_MDict.
			%  SETTINGS = PR.GETPROPSETTINGS(GraphPP_MDict, POINTER) returns settings of POINTER of GraphPP_MDict.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('GraphPP_MDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GraphPP_MDict.getPropProp(pointer);
			
			switch prop
				case GraphPP_MDict.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case GraphPP_MDict.SELECTED
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case GraphPP_MDict.TABLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GraphPP_MDict.CONTEXTMENU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GraphPP_MDict.GUI_F_DICT
					prop_settings = 'GUIFig';
				case GraphPP_MDict.GUI_M_DICT
					prop_settings = 'GUIElement';
				case GraphPP_MDict.TEMPLATE
					prop_settings = 'GraphPP_MDict';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GraphPP_MDict.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GraphPP_MDict.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(GraphPP_MDict, POINTER) returns the default value of POINTER of GraphPP_MDict.
			%  DEFAULT = PR.GETPROPDEFAULT(GraphPP_MDict, POINTER) returns the default value of POINTER of GraphPP_MDict.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('GraphPP_MDict')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GraphPP_MDict.getPropProp(pointer);
			
			switch prop
				case GraphPP_MDict.TABLE_HEIGHT
					prop_default = s(30);
				case GraphPP_MDict.SELECTED
					prop_default = Format.getFormatDefault(Format.CVECTOR, GraphPP_MDict.getPropSettings(prop));
				case GraphPP_MDict.TABLE
					prop_default = Format.getFormatDefault(Format.HANDLE, GraphPP_MDict.getPropSettings(prop));
				case GraphPP_MDict.CONTEXTMENU
					prop_default = Format.getFormatDefault(Format.HANDLE, GraphPP_MDict.getPropSettings(prop));
				case GraphPP_MDict.GUI_F_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, GraphPP_MDict.getPropSettings(prop));
				case GraphPP_MDict.GUI_M_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, GraphPP_MDict.getPropSettings(prop));
				case GraphPP_MDict.ELCLASS
					prop_default = 'GraphPP_MDict';
				case GraphPP_MDict.NAME
					prop_default = 'Measure Dictionary Plot';
				case GraphPP_MDict.DESCRIPTION
					prop_default = 'A Measure Dictionary Plot (GraphPP_MDict) plots the panel of the M_DICT property of Graph. It is intended to be used only with the property M_DICT of Graph.';
				case GraphPP_MDict.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, GraphPP_MDict.getPropSettings(prop));
				case GraphPP_MDict.ID
					prop_default = 'GraphPP_MDict';
				case GraphPP_MDict.LABEL
					prop_default = 'GraphPP_MDict label';
				case GraphPP_MDict.NOTES
					prop_default = 'GraphPP_MDict';
				case GraphPP_MDict.EL
					prop_default = Graph();
				case GraphPP_MDict.PROP
					prop_default = Graph.M_DICT;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GraphPP_MDict.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GraphPP_MDict.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GraphPP_MDict, POINTER) returns the conditioned default value of POINTER of GraphPP_MDict.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(GraphPP_MDict, POINTER) returns the conditioned default value of POINTER of GraphPP_MDict.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('GraphPP_MDict')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GraphPP_MDict.getPropProp(pointer);
			
			prop_default = GraphPP_MDict.conditioning(prop, GraphPP_MDict.getPropDefault(prop));
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
			
			prop = GraphPP_MDict.getPropProp(pointer);
			
			switch prop
				case GraphPP_MDict.SELECTED % __GraphPP_MDict.SELECTED__
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
			%  CHECK = Element.CHECKPROP(GraphPP_MDict, PROP, VALUE) checks VALUE format for PROP of GraphPP_MDict.
			%  CHECK = PR.CHECKPROP(GraphPP_MDict, PROP, VALUE) checks VALUE format for PROP of GraphPP_MDict.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GraphPP_MDict:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:GraphPP_MDict:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GraphPP_MDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GraphPP_MDict.
			%   Error id: €BRAPH2.STR€:GraphPP_MDict:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(GraphPP_MDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GraphPP_MDict.
			%   Error id: €BRAPH2.STR€:GraphPP_MDict:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('GraphPP_MDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GraphPP_MDict.getPropProp(pointer);
			
			switch prop
				case GraphPP_MDict.TABLE_HEIGHT % __GraphPP_MDict.TABLE_HEIGHT__
					check = Format.checkFormat(Format.SIZE, value, GraphPP_MDict.getPropSettings(prop));
				case GraphPP_MDict.SELECTED % __GraphPP_MDict.SELECTED__
					check = Format.checkFormat(Format.CVECTOR, value, GraphPP_MDict.getPropSettings(prop));
				case GraphPP_MDict.TABLE % __GraphPP_MDict.TABLE__
					check = Format.checkFormat(Format.HANDLE, value, GraphPP_MDict.getPropSettings(prop));
				case GraphPP_MDict.CONTEXTMENU % __GraphPP_MDict.CONTEXTMENU__
					check = Format.checkFormat(Format.HANDLE, value, GraphPP_MDict.getPropSettings(prop));
				case GraphPP_MDict.GUI_F_DICT % __GraphPP_MDict.GUI_F_DICT__
					check = Format.checkFormat(Format.IDICT, value, GraphPP_MDict.getPropSettings(prop));
				case GraphPP_MDict.GUI_M_DICT % __GraphPP_MDict.GUI_M_DICT__
					check = Format.checkFormat(Format.IDICT, value, GraphPP_MDict.getPropSettings(prop));
				case GraphPP_MDict.TEMPLATE % __GraphPP_MDict.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, GraphPP_MDict.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GraphPP_MDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GraphPP_MDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GraphPP_MDict.getPropTag(prop) ' (' GraphPP_MDict.getFormatTag(GraphPP_MDict.getPropFormat(prop)) ').'] ...
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
				case GraphPP_MDict.TABLE % __GraphPP_MDict.TABLE__
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
					
				case GraphPP_MDict.CONTEXTMENU % __GraphPP_MDict.CONTEXTMENU__
					contextmenu = uicontextmenu( ...
					    'Parent', ancestor(pr.get('H'), 'figure'), ...
					    'Tag', 'CONTEXTMENU' ...
					    );
					menu_select_all = uimenu( ...
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
					
					set(pr.get('TABLE'), 'ContextMenu', contextmenu)
					
					value = contextmenu;
					
				case GraphPP_MDict.X_DRAW % __GraphPP_MDict.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					end
					
				case GraphPP_MDict.UPDATE % __GraphPP_MDict.UPDATE__
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
					
				case GraphPP_MDict.REDRAW % __GraphPP_MDict.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('TABLE'), 'Position', [s(.3) s(.3) w_p-s(.6) max(1, pr.get('HEIGHT')-s(2.2))])
					end
					
				case GraphPP_MDict.SHOW % __GraphPP_MDict.SHOW__
					value = calculateValue@PanelProp(pr, PanelProp.SHOW, varargin{:}); % also warning
					if value
					    % figures for measure figures
					    gui_f_dict = pr.get('GUI_F_DICT');
					    for i = 1:1:gui_f_dict.get('LENGTH')
					        gui = gui_f_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('SHOW')
					        end
					    end
					    
					    % figures for measure data
					    gui_m_dict = pr.get('GUI_M_DICT');
					    for i = 1:1:gui_m_dict.get('LENGTH')
					        gui = gui_m_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('SHOW')
					        end
					    end
					end
					
				case GraphPP_MDict.HIDE % __GraphPP_MDict.HIDE__
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
					    gui_m_dict = pr.get('GUI_M_DICT');
					    for i = 1:1:gui_m_dict.get('LENGTH')
					        gui = gui_m_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('HIDE')
					        end
					    end
					end
					
				case GraphPP_MDict.DELETE % __GraphPP_MDict.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('TABLE', Element.getNoValue())
					    pr.set('CONTEXTMENU', Element.getNoValue())
					end
					
				case GraphPP_MDict.CLOSE % __GraphPP_MDict.CLOSE__
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
					    gui_m_dict = pr.get('GUI_M_DICT');
					    for i = 1:1:gui_m_dict.get('LENGTH')
					        gui = gui_m_dict.get('IT', i);
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
			    g = pr.get('EL');
			    m_list = g.get('COMPATIBLE_MEASURES');
			
			    pr.set('SELECTED', [1:1:length(m_list)])
			
			    pr.get('UPDATE')
			end
			function cb_clear_selection(~, ~) 
			    pr.set('SELECTED', [])
			
			    pr.get('UPDATE')
			end
			function cb_invert_selection(~, ~) 
			    g = pr.get('EL');
			    m_list = g.get('COMPATIBLE_MEASURES');
			
			    selected_tmp = [1:1:length(m_list)];
			    selected_tmp(pr.get('SELECTED')) = [];
			    pr.set('SELECTED', selected_tmp);
			
			    pr.get('UPDATE')
			end
			function cb_calculate(~, ~) 
			    g = pr.get('EL');
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
			function cb_open_plots(~, ~)
			    g = pr.get('EL');
			    m_list = g.get('COMPATIBLE_MEASURES');
			    
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI 
			    N = ceil(sqrt(length(m_list))); % number of row and columns of figures
			
			    gui_f_dict = pr.memorize('GUI_F_DICT');
			    
			    selected = pr.get('SELECTED');
				for s = 1:1:length(selected)
			        i = selected(s);
			        
			        measure = m_list{i}; % also key
			
			        m = g.get('MEASURE', measure);
			        
			        if ~gui_f_dict.get('CONTAINS_KEY', measure)
			            gui = GUIFig( ...
			                'ID', measure, ... % this is the dictionary key
			                'PF', m.get('PFM'), ...
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
			    g = pr.get('EL');
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
			    g = pr.get('EL');
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
			    g = pr.get('EL');
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
			    g = pr.get('EL');
			
			    m_list = g.get('COMPATIBLE_MEASURES');
			    mlist_already_calculated = cellfun(@(x) x.get('ID'), g.get('M_DICT').get('IT_LIST'), 'UniformOutput', false);
			
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
