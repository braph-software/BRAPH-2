classdef AnalyzeEnsemblePP_GDict < PanelProp
	%AnalyzeEnsemblePP_GDict plots the panel to manage the graph of an ensemble analysis.
	% It is a subclass of <a href="matlab:help PanelProp">PanelProp</a>.
	%
	% AnalyzeEnsemblePP_GDict plots the panel to manage the graph and measures of an ensemble analysis.
	% It is intended to be used only with the property ME_DICT of AnalyzeEnsemble.
	%
	% AnalyzeEnsemblePP_GDict methods (constructor):
	%  AnalyzeEnsemblePP_GDict - constructor
	%
	% AnalyzeEnsemblePP_GDict methods:
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
	% AnalyzeEnsemblePP_GDict methods (display):
	%  tostring - string with information about the graph and measure plot
	%  disp - displays information about the graph and measure plot
	%  tree - displays the tree of the graph and measure plot
	%
	% AnalyzeEnsemblePP_GDict methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graph and measure plot are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graph and measure plot
	%
	% AnalyzeEnsemblePP_GDict methods (save/load, Static):
	%  save - saves BRAPH2 graph and measure plot as b2 file
	%  load - loads a BRAPH2 graph and measure plot from a b2 file
	%
	% AnalyzeEnsemblePP_GDict method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graph and measure plot
	%
	% AnalyzeEnsemblePP_GDict method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graph and measure plot
	%
	% AnalyzeEnsemblePP_GDict methods (inspection, Static):
	%  getClass - returns the class of the graph and measure plot
	%  getSubclasses - returns all subclasses of AnalyzeEnsemblePP_GDict
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
	% AnalyzeEnsemblePP_GDict methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% AnalyzeEnsemblePP_GDict methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% AnalyzeEnsemblePP_GDict methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% AnalyzeEnsemblePP_GDict methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?AnalyzeEnsemblePP_GDict; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">AnalyzeEnsemblePP_GDict constants</a>.
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
		
		GUI_G_DICT = PanelProp.getPropNumber() + 5;
		GUI_G_DICT_TAG = 'GUI_G_DICT';
		GUI_G_DICT_CATEGORY = Category.GUI;
		GUI_G_DICT_FORMAT = Format.IDICT;
	end
	methods % constructor
		function pr = AnalyzeEnsemblePP_GDict(varargin)
			%AnalyzeEnsemblePP_GDict() creates a graph and measure plot.
			%
			% AnalyzeEnsemblePP_GDict(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% AnalyzeEnsemblePP_GDict(TAG, VALUE, ...) with property TAG set to VALUE.
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
			% CLASS = AnalyzeEnsemblePP_GDict.GETCLASS() returns the class 'AnalyzeEnsemblePP_GDict'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the graph and measure plot PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('AnalyzeEnsemblePP_GDict') returns 'AnalyzeEnsemblePP_GDict'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			
			pr_class = 'AnalyzeEnsemblePP_GDict';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graph and measure plot.
			%
			% LIST = AnalyzeEnsemblePP_GDict.GETSUBCLASSES() returns all subclasses of 'AnalyzeEnsemblePP_GDict'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the graph and measure plot PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('AnalyzeEnsemblePP_GDict') returns all subclasses of 'AnalyzeEnsemblePP_GDict'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('AnalyzeEnsemblePP_GDict', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph and measure plot.
			%
			% PROPS = AnalyzeEnsemblePP_GDict.GETPROPS() returns the property list of graph and measure plot
			%  as a row vector.
			%
			% PROPS = AnalyzeEnsemblePP_GDict.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the graph and measure plot PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('AnalyzeEnsemblePP_GDict'[, CATEGORY]) returns the property list of 'AnalyzeEnsemblePP_GDict'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelProp.getProps() ...
						AnalyzeEnsemblePP_GDict.TABLE_HEIGHT ...
						AnalyzeEnsemblePP_GDict.SELECTED ...
						AnalyzeEnsemblePP_GDict.TABLE ...
						AnalyzeEnsemblePP_GDict.CONTEXTMENU ...
						AnalyzeEnsemblePP_GDict.GUI_G_DICT ...
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
						AnalyzeEnsemblePP_GDict.TABLE ...
						AnalyzeEnsemblePP_GDict.CONTEXTMENU ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelProp.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelProp.getProps(Category.GUI) ...
						AnalyzeEnsemblePP_GDict.TABLE_HEIGHT ...
						AnalyzeEnsemblePP_GDict.SELECTED ...
						AnalyzeEnsemblePP_GDict.GUI_G_DICT ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graph and measure plot.
			%
			% N = AnalyzeEnsemblePP_GDict.GETPROPNUMBER() returns the property number of graph and measure plot.
			%
			% N = AnalyzeEnsemblePP_GDict.GETPROPNUMBER(CATEGORY) returns the property number of graph and measure plot
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the graph and measure plot PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('AnalyzeEnsemblePP_GDict') returns the property number of 'AnalyzeEnsemblePP_GDict'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(AnalyzeEnsemblePP_GDict.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph and measure plot/error.
			%
			% CHECK = AnalyzeEnsemblePP_GDict.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(AnalyzeEnsemblePP_GDict, PROP) checks whether PROP exists for AnalyzeEnsemblePP_GDict.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemblePP_GDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:AnalyzeEnsemblePP_GDict:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:AnalyzeEnsemblePP_GDict:WrongInput]
			%  Element.EXISTSPROP(AnalyzeEnsemblePP_GDict, PROP) throws error if PROP does NOT exist for AnalyzeEnsemblePP_GDict.
			%   Error id: [BRAPH2:AnalyzeEnsemblePP_GDict:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == AnalyzeEnsemblePP_GDict.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeEnsemblePP_GDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeEnsemblePP_GDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for AnalyzeEnsemblePP_GDict.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph and measure plot/error.
			%
			% CHECK = AnalyzeEnsemblePP_GDict.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(AnalyzeEnsemblePP_GDict, TAG) checks whether TAG exists for AnalyzeEnsemblePP_GDict.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:AnalyzeEnsemblePP_GDict:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:AnalyzeEnsemblePP_GDict:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:AnalyzeEnsemblePP_GDict:WrongInput]
			%  Element.EXISTSTAG(AnalyzeEnsemblePP_GDict, TAG) throws error if TAG does NOT exist for AnalyzeEnsemblePP_GDict.
			%   Error id: [BRAPH2:AnalyzeEnsemblePP_GDict:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			analyzeensemblepp_gdict_tag_list = cellfun(@(x) AnalyzeEnsemblePP_GDict.getPropTag(x), num2cell(AnalyzeEnsemblePP_GDict.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, analyzeensemblepp_gdict_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeEnsemblePP_GDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeEnsemblePP_GDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for AnalyzeEnsemblePP_GDict.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(AnalyzeEnsemblePP_GDict, POINTER) returns property number of POINTER of AnalyzeEnsemblePP_GDict.
			%  PROPERTY = PR.GETPROPPROP(AnalyzeEnsemblePP_GDict, POINTER) returns property number of POINTER of AnalyzeEnsemblePP_GDict.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				analyzeensemblepp_gdict_tag_list = cellfun(@(x) AnalyzeEnsemblePP_GDict.getPropTag(x), num2cell(AnalyzeEnsemblePP_GDict.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, analyzeensemblepp_gdict_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(AnalyzeEnsemblePP_GDict, POINTER) returns tag of POINTER of AnalyzeEnsemblePP_GDict.
			%  TAG = PR.GETPROPTAG(AnalyzeEnsemblePP_GDict, POINTER) returns tag of POINTER of AnalyzeEnsemblePP_GDict.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case AnalyzeEnsemblePP_GDict.TABLE_HEIGHT
						tag = AnalyzeEnsemblePP_GDict.TABLE_HEIGHT_TAG;
					case AnalyzeEnsemblePP_GDict.SELECTED
						tag = AnalyzeEnsemblePP_GDict.SELECTED_TAG;
					case AnalyzeEnsemblePP_GDict.TABLE
						tag = AnalyzeEnsemblePP_GDict.TABLE_TAG;
					case AnalyzeEnsemblePP_GDict.CONTEXTMENU
						tag = AnalyzeEnsemblePP_GDict.CONTEXTMENU_TAG;
					case AnalyzeEnsemblePP_GDict.GUI_G_DICT
						tag = AnalyzeEnsemblePP_GDict.GUI_G_DICT_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(AnalyzeEnsemblePP_GDict, POINTER) returns category of POINTER of AnalyzeEnsemblePP_GDict.
			%  CATEGORY = PR.GETPROPCATEGORY(AnalyzeEnsemblePP_GDict, POINTER) returns category of POINTER of AnalyzeEnsemblePP_GDict.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemblePP_GDict.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemblePP_GDict.TABLE_HEIGHT
					prop_category = AnalyzeEnsemblePP_GDict.TABLE_HEIGHT_CATEGORY;
				case AnalyzeEnsemblePP_GDict.SELECTED
					prop_category = AnalyzeEnsemblePP_GDict.SELECTED_CATEGORY;
				case AnalyzeEnsemblePP_GDict.TABLE
					prop_category = AnalyzeEnsemblePP_GDict.TABLE_CATEGORY;
				case AnalyzeEnsemblePP_GDict.CONTEXTMENU
					prop_category = AnalyzeEnsemblePP_GDict.CONTEXTMENU_CATEGORY;
				case AnalyzeEnsemblePP_GDict.GUI_G_DICT
					prop_category = AnalyzeEnsemblePP_GDict.GUI_G_DICT_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(AnalyzeEnsemblePP_GDict, POINTER) returns format of POINTER of AnalyzeEnsemblePP_GDict.
			%  FORMAT = PR.GETPROPFORMAT(AnalyzeEnsemblePP_GDict, POINTER) returns format of POINTER of AnalyzeEnsemblePP_GDict.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemblePP_GDict.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemblePP_GDict.TABLE_HEIGHT
					prop_format = AnalyzeEnsemblePP_GDict.TABLE_HEIGHT_FORMAT;
				case AnalyzeEnsemblePP_GDict.SELECTED
					prop_format = AnalyzeEnsemblePP_GDict.SELECTED_FORMAT;
				case AnalyzeEnsemblePP_GDict.TABLE
					prop_format = AnalyzeEnsemblePP_GDict.TABLE_FORMAT;
				case AnalyzeEnsemblePP_GDict.CONTEXTMENU
					prop_format = AnalyzeEnsemblePP_GDict.CONTEXTMENU_FORMAT;
				case AnalyzeEnsemblePP_GDict.GUI_G_DICT
					prop_format = AnalyzeEnsemblePP_GDict.GUI_G_DICT_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(AnalyzeEnsemblePP_GDict, POINTER) returns description of POINTER of AnalyzeEnsemblePP_GDict.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(AnalyzeEnsemblePP_GDict, POINTER) returns description of POINTER of AnalyzeEnsemblePP_GDict.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemblePP_GDict.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemblePP_GDict.TABLE_HEIGHT
					prop_description = 'TABLE_HEIGHT (gui, size) is the pixel height of the property panel when the table is shown.';
				case AnalyzeEnsemblePP_GDict.SELECTED
					prop_description = 'SELECTED (gui, cvector) is the list of selected items.';
				case AnalyzeEnsemblePP_GDict.TABLE
					prop_description = 'TABLE (evanescent, handle) is the table.';
				case AnalyzeEnsemblePP_GDict.CONTEXTMENU
					prop_description = 'CONTEXTMENU (evanescent, handle) is the context menu.';
				case AnalyzeEnsemblePP_GDict.GUI_G_DICT
					prop_description = 'GUI_G_DICT (gui, idict) contains the GUIs for the graph.';
				case AnalyzeEnsemblePP_GDict.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case AnalyzeEnsemblePP_GDict.NAME
					prop_description = 'NAME (constant, string) is the name of the graph and measure panel.';
				case AnalyzeEnsemblePP_GDict.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the graph and measure panel.';
				case AnalyzeEnsemblePP_GDict.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the graph and measure panel.';
				case AnalyzeEnsemblePP_GDict.ID
					prop_description = 'ID (data, string) is a few-letter code for the graph and measure panel.';
				case AnalyzeEnsemblePP_GDict.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the graph and measure panel.';
				case AnalyzeEnsemblePP_GDict.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the graph and measure panel.';
				case AnalyzeEnsemblePP_GDict.EL
					prop_description = 'EL (data, item) is the element.';
				case AnalyzeEnsemblePP_GDict.PROP
					prop_description = 'PROP (data, scalar) is the property number.';
				case AnalyzeEnsemblePP_GDict.X_DRAW
					prop_description = 'X_DRAW (query, logical) draws the property panel.';
				case AnalyzeEnsemblePP_GDict.UPDATE
					prop_description = 'UPDATE (query, logical) updates the content and permissions of the table.';
				case AnalyzeEnsemblePP_GDict.REDRAW
					prop_description = 'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.';
				case AnalyzeEnsemblePP_GDict.SHOW
					prop_description = 'SHOW (query, logical) shows the figure containing the panel and, possibly, the item figures.';
				case AnalyzeEnsemblePP_GDict.HIDE
					prop_description = 'HIDE (query, logical) hides the figure containing the panel and, possibly, the item figures.';
				case AnalyzeEnsemblePP_GDict.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel is deleted.';
				case AnalyzeEnsemblePP_GDict.CLOSE
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
			%  SETTINGS = Element.GETPROPSETTINGS(AnalyzeEnsemblePP_GDict, POINTER) returns settings of POINTER of AnalyzeEnsemblePP_GDict.
			%  SETTINGS = PR.GETPROPSETTINGS(AnalyzeEnsemblePP_GDict, POINTER) returns settings of POINTER of AnalyzeEnsemblePP_GDict.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeEnsemblePP_GDict.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemblePP_GDict.TABLE_HEIGHT
					prop_settings = Format.getFormatSettings(Format.SIZE);
				case AnalyzeEnsemblePP_GDict.SELECTED
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case AnalyzeEnsemblePP_GDict.TABLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case AnalyzeEnsemblePP_GDict.CONTEXTMENU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case AnalyzeEnsemblePP_GDict.GUI_G_DICT
					prop_settings = 'GUIElement';
				case AnalyzeEnsemblePP_GDict.TEMPLATE
					prop_settings = 'AnalyzeEnsemblePP_GDict';
				otherwise
					prop_settings = getPropSettings@PanelProp(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = AnalyzeEnsemblePP_GDict.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemblePP_GDict.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(AnalyzeEnsemblePP_GDict, POINTER) returns the default value of POINTER of AnalyzeEnsemblePP_GDict.
			%  DEFAULT = PR.GETPROPDEFAULT(AnalyzeEnsemblePP_GDict, POINTER) returns the default value of POINTER of AnalyzeEnsemblePP_GDict.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeEnsemblePP_GDict.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemblePP_GDict.TABLE_HEIGHT
					prop_default = s(30);
				case AnalyzeEnsemblePP_GDict.SELECTED
					prop_default = Format.getFormatDefault(Format.CVECTOR, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_GDict.TABLE
					prop_default = Format.getFormatDefault(Format.HANDLE, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_GDict.CONTEXTMENU
					prop_default = Format.getFormatDefault(Format.HANDLE, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_GDict.GUI_G_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_GDict.ELCLASS
					prop_default = 'AnalyzeEnsemblePP_GDict';
				case AnalyzeEnsemblePP_GDict.NAME
					prop_default = 'AnalyzeEnsemblePP_GDict';
				case AnalyzeEnsemblePP_GDict.DESCRIPTION
					prop_default = 'AnalyzeEnsemblePP_GDict plots the panel to manage the graph and measures of an ensemble analysis.';
				case AnalyzeEnsemblePP_GDict.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_GDict.ID
					prop_default = 'AnalyzeEnsemblePP_GDict';
				case AnalyzeEnsemblePP_GDict.LABEL
					prop_default = 'AnalyzeEnsemblePP_GDict label';
				case AnalyzeEnsemblePP_GDict.NOTES
					prop_default = 'AnalyzeEnsemblePP_GDict';
				case AnalyzeEnsemblePP_GDict.EL
					prop_default = AnalyzeEnsemble();
				case AnalyzeEnsemblePP_GDict.PROP
					prop_default = AnalyzeEnsemble.G_DICT;
				otherwise
					prop_default = getPropDefault@PanelProp(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = AnalyzeEnsemblePP_GDict.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeEnsemblePP_GDict.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemblePP_GDict, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemblePP_GDict.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(AnalyzeEnsemblePP_GDict, POINTER) returns the conditioned default value of POINTER of AnalyzeEnsemblePP_GDict.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = AnalyzeEnsemblePP_GDict.getPropProp(pointer);
			
			prop_default = AnalyzeEnsemblePP_GDict.conditioning(prop, AnalyzeEnsemblePP_GDict.getPropDefault(prop));
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
			
			prop = AnalyzeEnsemblePP_GDict.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemblePP_GDict.SELECTED % __AnalyzeEnsemblePP_GDict.SELECTED__
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
			%  CHECK = Element.CHECKPROP(AnalyzeEnsemblePP_GDict, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemblePP_GDict.
			%  CHECK = PR.CHECKPROP(AnalyzeEnsemblePP_GDict, PROP, VALUE) checks VALUE format for PROP of AnalyzeEnsemblePP_GDict.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:AnalyzeEnsemblePP_GDict:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: €BRAPH2.STR€:AnalyzeEnsemblePP_GDict:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(AnalyzeEnsemblePP_GDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemblePP_GDict.
			%   Error id: €BRAPH2.STR€:AnalyzeEnsemblePP_GDict:€BRAPH2.WRONG_INPUT€
			%  PR.CHECKPROP(AnalyzeEnsemblePP_GDict, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeEnsemblePP_GDict.
			%   Error id: €BRAPH2.STR€:AnalyzeEnsemblePP_GDict:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('AnalyzeEnsemblePP_GDict')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = AnalyzeEnsemblePP_GDict.getPropProp(pointer);
			
			switch prop
				case AnalyzeEnsemblePP_GDict.TABLE_HEIGHT % __AnalyzeEnsemblePP_GDict.TABLE_HEIGHT__
					check = Format.checkFormat(Format.SIZE, value, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_GDict.SELECTED % __AnalyzeEnsemblePP_GDict.SELECTED__
					check = Format.checkFormat(Format.CVECTOR, value, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_GDict.TABLE % __AnalyzeEnsemblePP_GDict.TABLE__
					check = Format.checkFormat(Format.HANDLE, value, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_GDict.CONTEXTMENU % __AnalyzeEnsemblePP_GDict.CONTEXTMENU__
					check = Format.checkFormat(Format.HANDLE, value, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_GDict.GUI_G_DICT % __AnalyzeEnsemblePP_GDict.GUI_G_DICT__
					check = Format.checkFormat(Format.IDICT, value, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				case AnalyzeEnsemblePP_GDict.TEMPLATE % __AnalyzeEnsemblePP_GDict.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, AnalyzeEnsemblePP_GDict.getPropSettings(prop));
				otherwise
					if prop <= PanelProp.getPropNumber()
						check = checkProp@PanelProp(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeEnsemblePP_GDict:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeEnsemblePP_GDict:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' AnalyzeEnsemblePP_GDict.getPropTag(prop) ' (' AnalyzeEnsemblePP_GDict.getFormatTag(AnalyzeEnsemblePP_GDict.getPropFormat(prop)) ').'] ...
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
				case AnalyzeEnsemblePP_GDict.TABLE % __AnalyzeEnsemblePP_GDict.TABLE__
					table = uitable( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'table', ...
					    'FontSize', BRAPH2.FONTSIZE, ...
					    'ColumnSortable', true, ...
					    'ColumnName', {'', 'Subject', 'Notes'}, ...
					    'ColumnFormat', {'logical',  'char', 'char'}, ...
					    'ColumnWidth', {30, 'auto', 'auto'}, ...
					    'ColumnEditable', [true false false], ...
					    'CellEditCallback', {@cb_table} ...
					    );
					value = table;
					
				case AnalyzeEnsemblePP_GDict.CONTEXTMENU % __AnalyzeEnsemblePP_GDict.CONTEXTMENU__
					contextmenu = uicontextmenu( ...
					    'Parent', ancestor(pr.get('H'), 'figure'), ...
					    'Tag', 'CONTEXTMENU' ...
					    );
					menu_select_all = uimenu( ...
						'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_SELECT_ALL', ...
					    'Text', 'Select All Graphs', ...
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
					menu_open_g_pl = uimenu( ...
						'Parent', contextmenu, ...
						'Tag', 'MENU_OPEN_G_PL', ...
						'Text', 'Plot Selected Adjacency Matrices', ...
						'MenuSelectedFcn', {@cb_open_g_pl} ...
						);
					menu_hide_g_pl = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_G_PL', ...
					    'Text', 'Hide Selected Adjacency Matrices', ...
					    'MenuSelectedFcn', {@cb_hide_g_pl} ...
						);
					menu_open_g_h = uimenu( ...
						'Parent', contextmenu, ...
						'Tag', 'MENU_OPEN_G_H', ...
						'Text', 'Plot Selected Histograms', ...
						'MenuSelectedFcn', {@cb_open_g_h} ...
						);
					menu_hide_g_pl = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_G_H', ...
					    'Text', 'Hide Selected Histograms', ...
					    'MenuSelectedFcn', {@cb_hide_g_h} ...
						);
					menu_open_g_el = uimenu( ...
						'Separator', 'on', ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_OPEN_G_EL', ...
					    'Text', 'Data Selected Graph ...', ...
					    'MenuSelectedFcn', {@cb_open_g_el} ...
					    );
					menu_hide_g_el = uimenu( ...
					    'Parent', contextmenu, ...
					    'Tag', 'MENU_HIDE_G_EL', ...
					    'Text', 'Hide Selected Graph Data', ...
						'MenuSelectedFcn', {@cb_hide_g_el} ...
					    );
					
					set(pr.get('TABLE'), 'ContextMenu', contextmenu)
					
					value = contextmenu;
					
				case AnalyzeEnsemblePP_GDict.X_DRAW % __AnalyzeEnsemblePP_GDict.X_DRAW__
					value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
					if value
					    pr.memorize('TABLE')
					    pr.memorize('CONTEXTMENU')
					end
					
				case AnalyzeEnsemblePP_GDict.UPDATE % __AnalyzeEnsemblePP_GDict.UPDATE__
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
					
				case AnalyzeEnsemblePP_GDict.REDRAW % __AnalyzeEnsemblePP_GDict.REDRAW__
					value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
					if value
					    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
					    
					    set(pr.get('TABLE'), 'Position', [s(.3) s(.3) w_p-s(.6) max(1, pr.get('HEIGHT')-s(2.2))])
					end
					
				case AnalyzeEnsemblePP_GDict.SHOW % __AnalyzeEnsemblePP_GDict.SHOW__
					value = calculateValue@PanelProp(pr, PanelProp.SHOW, varargin{:}); % also warning
					if value
					    % Graph
					    gui_g_dict = pr.get('GUI_G_DICT');
					    for i = 1:1:gui_g_dict.get('LENGTH')
					        gui = gui_g_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('SHOW')
					        end
					    end
					end
					
				case AnalyzeEnsemblePP_GDict.HIDE % __AnalyzeEnsemblePP_GDict.HIDE__
					value = calculateValue@PanelProp(pr, PanelProp.HIDE, varargin{:}); % also warning
					if value
					    % Graph
					    gui_g_dict = pr.get('GUI_G_DICT');
					    for i = 1:1:gui_g_dict.get('LENGTH')
					        gui = gui_g_dict.get('IT', i);
					        if gui.get('DRAWN')
					            gui.get('HIDE')
					        end
					    end
					end
					
				case AnalyzeEnsemblePP_GDict.DELETE % __AnalyzeEnsemblePP_GDict.DELETE__
					value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
					if value
					    pr.set('TABLE', Element.getNoValue())
					    pr.set('CONTEXTMENU', Element.getNoValue())
					end
					
				case AnalyzeEnsemblePP_GDict.CLOSE % __AnalyzeEnsemblePP_GDict.CLOSE__
					value = calculateValue@PanelProp(pr, PanelProp.CLOSE, varargin{:}); % also warning
					if value
					    % Graph
					    gui_g_dict = pr.get('GUI_G_DICT');
					    for i = 1:1:gui_g_dict.get('LENGTH')
					        gui = gui_g_dict.get('IT', i);
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
			    a = pr.get('EL');
			    g_dict = a.get(pr.get('PROP')); 
			    g_key_list = cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false); % The graph ID is the key
			
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI
			    N = ceil(sqrt(length(g_key_list))); % number of row and columns of figures
			
			    selected = pr.get('SELECTED');
			    gui_g_dict = pr.memorize('GUI_G_DICT');
			    
			    for s = 1:1:length(selected)
			        i = selected(s);
			        g_key = g_key_list{i}; % key for graph
			        if ~gui_g_dict.get('CONTAINS_KEY', g_key)
			            g = g_dict.get('IT', g_key); % actual graph
			            gui = GUIElement( ...
			                'ID', g_key, ... % this is the dictionary key for graph
			                'PE', g, ...
			                'POSITION', [ ...
			                x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ... % x = (f_gr_x + f_gr_w) / screen_w + mod(selected_it - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
			                y0(f, 'normalized') ... % y = f_gr_y / screen_h;
			                w(f, 'normalized') ... % w = f_gr_w / screen_w;
			                .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ... % h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_it - .5) / N)) / N / screen_h;
			                ], ...
			                'WAITBAR', pr.getCallback('WAITBAR'), ...
			                'CLOSEREQ', false ...
			                );
			            gui_g_dict.get('ADD', gui)
			        end
			
			        gui = gui_g_dict.get('IT', g_key);
			        if ~gui.get('DRAWN')
			            gui.get('DRAW')
			        end
			
			        gui_pfga = gui.get('PE').get('PR_DICT').get('IT', 'PFGA').memorize('GUI_ITEM');
			        set(gui_pfga, 'TITLE', ['Adjacency matrices plot - ' g_key]);
			        if ~gui_pfga.get('DRAWN')
			            gui_pfga.get('DRAW')
			        end
			
			        gui_pfga.get('SHOW')
			    end
			end
			function cb_hide_g_pl(~, ~)
			    g_dict = pr.get('EL').get(pr.get('PROP'));
			    g_key_list =  cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false); % The graph ID is the key
			    
			    gui_g_dict = pr.memorize('GUI_G_DICT');
			
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			        
			        g_key = g_key_list{i}; % key for graph
			        
			        if gui_g_dict.get('CONTAINS_KEY', g_key)
			            gui = gui_g_dict.get('IT', g_key);
			            gui_pfga = gui.get('PE').get('PR_DICT').get('IT', 'PFGA').memorize('GUI_ITEM');
			            if gui.get('DRAWN')
			                gui_pfga.get('HIDE')
			            end
			        end
			    end
			end
			function cb_open_g_h(~, ~)
			    a = pr.get('EL');
			    g_dict = a.get(pr.get('PROP')); 
			    g_key_list = cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false); % The graph ID is the key
			
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI
			    N = ceil(sqrt(length(g_key_list))); % number of row and columns of figures
			
			    selected = pr.get('SELECTED');
			    gui_g_dict = pr.memorize('GUI_G_DICT');
			    
			    for s = 1:1:length(selected)
			        i = selected(s);
			        g_key = g_key_list{i}; % key for graph
			        if ~gui_g_dict.get('CONTAINS_KEY', g_key)
			            g = g_dict.get('IT', g_key); % actual graph
			            gui = GUIElement( ...
			                'ID', g_key, ... % this is the dictionary key for graph
			                'PE', g, ...
			                'POSITION', [ ...
			                x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ... % x = (f_gr_x + f_gr_w) / screen_w + mod(selected_it - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
			                y0(f, 'normalized') ... % y = f_gr_y / screen_h;
			                w(f, 'normalized') ... % w = f_gr_w / screen_w;
			                .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ... % h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_it - .5) / N)) / N / screen_h;
			                ], ...
			                'WAITBAR', pr.getCallback('WAITBAR'), ...
			                'CLOSEREQ', false ...
			                );
			            gui_g_dict.get('ADD', gui)
			        end
			
			        gui = gui_g_dict.get('IT', g_key);
			        if ~gui.get('DRAWN')
			            gui.get('DRAW')
			        end
			
			        gui_pfgh = gui.get('PE').get('PR_DICT').get('IT', 'PFGH').memorize('GUI_ITEM');
			        set(gui_pfgh, 'TITLE', ['Histograms plot - ' g_key]);
			        if ~gui_pfgh.get('DRAWN')
			            gui_pfgh.get('DRAW')
			        end
			        
			        gui_pfgh.get('SHOW')
			    end
			end
			function cb_hide_g_h(~, ~)
			    g_dict = pr.get('EL').get(pr.get('PROP'));
			    g_key_list =  cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false); % The graph ID is the key
			    
			    gui_g_dict = pr.memorize('GUI_G_DICT');
			
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			        
			        g_key = g_key_list{i}; % key for graph
			        
			        if gui_g_dict.get('CONTAINS_KEY', g_key)
			            gui = gui_g_dict.get('IT', g_key);
			            gui_pfgh = gui.get('PE').get('PR_DICT').get('IT', 'PFGH').memorize('GUI_ITEM');
			            if gui.get('DRAWN')
			                gui_pfgh.get('HIDE')
			            end
			        end
			    end
			end
			function cb_open_g_el(~, ~)
			    a = pr.get('EL');
			    g_dict = a.get(pr.get('PROP'));
			    g_key_list = cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false); % The graph ID is the key
			    
			    f = ancestor(pr.get('H'), 'figure'); % parent GUI
			    N = ceil(sqrt(length(g_key_list))); % number of row and columns of figures
			    
			    gui_g_dict = pr.memorize('GUI_G_DICT');
			    
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			    
			        g_key = g_key_list{i}; % key for graph
			    
			        if ~gui_g_dict.get('CONTAINS_KEY', g_key)
			            g = g_dict.get('IT', g_key); % actural graph
			            gui = GUIElement( ...
			                'ID', g_key, ... % this is the dictionary key for graph
			                'PE', g, ... 
			                'POSITION', [ ...
			                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ... % x = (f_gr_x + f_gr_w) / screen_w + mod(selected_it - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
			                    y0(f, 'normalized') ... % y = f_gr_y / screen_h;
			                    w(f, 'normalized') ... % w = f_gr_w / screen_w;
			                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ... % h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_it - .5) / N)) / N / screen_h;
			                    ], ...
			                'WAITBAR', pr.getCallback('WAITBAR'), ...
			                'CLOSEREQ', false ...
			                );
			            gui_g_dict.get('ADD', gui)
			        end
			        gui = gui_g_dict.get('IT', g_key);
			        if ~gui.get('DRAWN')
			            gui.get('DRAW')
			        end
			        gui.get('SHOW')
			    end
			end
			function cb_hide_g_el(~, ~)
			    g_dict = pr.get('EL').get(pr.get('PROP'));
			    g_key_list =  cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false); % The graph ID is the key
			    
			    gui_g_dict = pr.memorize('GUI_G_DICT');
			
			    selected = pr.get('SELECTED');
			    for s = 1:1:length(selected)
			        i = selected(s);
			        
			        g_key = g_key_list{i}; % key for graph
			        
			        if gui_g_dict.get('CONTAINS_KEY', g_key)
			            gui = gui_g_dict.get('IT', g_key);
			            if gui.get('DRAWN')
			                gui.get('HIDE')
			            end
			        end
			    end
			end
			function cb_select_all(~, ~) 
			    g_dict = pr.get('EL').get(pr.get('PROP'));
			    g_key_list = cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false);
			
			    pr.set('SELECTED', [1:1:length(g_key_list)])
			
			    pr.get('UPDATE')
			end
			function cb_clear_selection(~, ~) 
			    pr.set('SELECTED', [])
			
			    pr.get('UPDATE')
			end
			function cb_invert_selection(~, ~) 
			    g_dict = pr.get('EL').get(pr.get('PROP'));
			    g_key_list = cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false);
			
			    selected_tmp = [1:1:length(g_key_list)];
			    selected_tmp(pr.get('SELECTED')) = [];
			    pr.set('SELECTED', selected_tmp);
			
			    pr.get('UPDATE')
			end
			function set_table()
			    a = pr.get('EL');
			    prop = pr.get('PROP');
			    if isa(a.getr('GRAPH_TEMPLATE'), 'NoValue')
			        g = a.getPropDefaultConditioned('GRAPH_TEMPLATE'); % default graph
			    else
			        g = a.get('GRAPH_TEMPLATE'); % actual graph
			    end
			    
			    g_dict = a.get(prop);
			    g_key_list = cellfun(@(g) g.get('ID'), g_dict.get('IT_LIST'), 'UniformOutput', false);
			    
			    rowname = cell(length(g_key_list), 1);
			    data = cell(length(g_key_list), 3);
			    for gi = 1:1:length(g_key_list)
			        if any(pr.get('SELECTED') == gi)
			            data{gi, 1} = true;
			        else
			            data{gi, 1} = false;
			        end
			    
			        data{gi, 2} = g_key_list{gi};
			        data{gi, 3} = g_dict.get('IT', gi).get('NOTES');
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
