classdef GraphHistPF < PanelFig
	%GraphHistPF is a plot of a graph histogram.
	% It is a subclass of <a href="matlab:help PanelFig">PanelFig</a>.
	%
	% A Panel Figure for Graph Histogram (GraphHistPF) manages the plot of the histogram of an adjaciency matrix.
	%
	% GraphHistPF methods (constructor):
	%  GraphHistPF - constructor
	%
	% GraphHistPF methods:
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
	% GraphHistPF methods (display):
	%  tostring - string with information about the panel figure for graph histogram
	%  disp - displays information about the panel figure for graph histogram
	%  tree - displays the tree of the panel figure for graph histogram
	%
	% GraphHistPF methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure for graph histogram are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure for graph histogram
	%
	% GraphHistPF methods (save/load, Static):
	%  save - saves BRAPH2 panel figure for graph histogram as b2 file
	%  load - loads a BRAPH2 panel figure for graph histogram from a b2 file
	%
	% GraphHistPF method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure for graph histogram
	%
	% GraphHistPF method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure for graph histogram
	%
	% GraphHistPF methods (inspection, Static):
	%  getClass - returns the class of the panel figure for graph histogram
	%  getSubclasses - returns all subclasses of GraphHistPF
	%  getProps - returns the property list of the panel figure for graph histogram
	%  getPropNumber - returns the property number of the panel figure for graph histogram
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
	% GraphHistPF methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GraphHistPF methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GraphHistPF methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GraphHistPF methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GraphHistPF; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GraphHistPF constants</a>.
	%
	%
	% See also Graph, GraphAdjPF.
	
	properties (Constant) % properties
		H_AXES = PanelFig.getPropNumber() + 1;
		H_AXES_TAG = 'H_AXES';
		H_AXES_CATEGORY = Category.EVANESCENT;
		H_AXES_FORMAT = Format.HANDLE;
		
		ST_AXIS = PanelFig.getPropNumber() + 2;
		ST_AXIS_TAG = 'ST_AXIS';
		ST_AXIS_CATEGORY = Category.FIGURE;
		ST_AXIS_FORMAT = Format.ITEM;
		
		LISTENER_ST_AXIS = PanelFig.getPropNumber() + 3;
		LISTENER_ST_AXIS_TAG = 'LISTENER_ST_AXIS';
		LISTENER_ST_AXIS_CATEGORY = Category.EVANESCENT;
		LISTENER_ST_AXIS_FORMAT = Format.HANDLE;
		
		G = PanelFig.getPropNumber() + 4;
		G_TAG = 'G';
		G_CATEGORY = Category.METADATA;
		G_FORMAT = Format.ITEM;
		
		LAYERS = PanelFig.getPropNumber() + 5;
		LAYERS_TAG = 'LAYERS';
		LAYERS_CATEGORY = Category.FIGURE;
		LAYERS_FORMAT = Format.RVECTOR;
		
		LAYERLOCK = PanelFig.getPropNumber() + 6;
		LAYERLOCK_TAG = 'LAYERLOCK';
		LAYERLOCK_CATEGORY = Category.METADATA;
		LAYERLOCK_FORMAT = Format.LOGICAL;
		
		BINS = PanelFig.getPropNumber() + 7;
		BINS_TAG = 'BINS';
		BINS_CATEGORY = Category.FIGURE;
		BINS_FORMAT = Format.RVECTOR;
		
		DIAGONAL = PanelFig.getPropNumber() + 8;
		DIAGONAL_TAG = 'DIAGONAL';
		DIAGONAL_CATEGORY = Category.FIGURE;
		DIAGONAL_FORMAT = Format.OPTION;
		
		SETUP = PanelFig.getPropNumber() + 9;
		SETUP_TAG = 'SETUP';
		SETUP_CATEGORY = Category.QUERY;
		SETUP_FORMAT = Format.EMPTY;
		
		H_HIST_AREA = PanelFig.getPropNumber() + 10;
		H_HIST_AREA_TAG = 'H_HIST_AREA';
		H_HIST_AREA_CATEGORY = Category.EVANESCENT;
		H_HIST_AREA_FORMAT = Format.HANDLE;
		
		ST_HIST_AREA = PanelFig.getPropNumber() + 11;
		ST_HIST_AREA_TAG = 'ST_HIST_AREA';
		ST_HIST_AREA_CATEGORY = Category.FIGURE;
		ST_HIST_AREA_FORMAT = Format.ITEM;
		
		LISTENER_ST_HIST_AREA = PanelFig.getPropNumber() + 12;
		LISTENER_ST_HIST_AREA_TAG = 'LISTENER_ST_HIST_AREA';
		LISTENER_ST_HIST_AREA_CATEGORY = Category.EVANESCENT;
		LISTENER_ST_HIST_AREA_FORMAT = Format.HANDLE;
		
		H_DENSITY_LINE = PanelFig.getPropNumber() + 13;
		H_DENSITY_LINE_TAG = 'H_DENSITY_LINE';
		H_DENSITY_LINE_CATEGORY = Category.EVANESCENT;
		H_DENSITY_LINE_FORMAT = Format.HANDLE;
		
		ST_DENSITY_LINE = PanelFig.getPropNumber() + 14;
		ST_DENSITY_LINE_TAG = 'ST_DENSITY_LINE';
		ST_DENSITY_LINE_CATEGORY = Category.FIGURE;
		ST_DENSITY_LINE_FORMAT = Format.ITEM;
		
		LISTENER_ST_DENSITY_LINE = PanelFig.getPropNumber() + 15;
		LISTENER_ST_DENSITY_LINE_TAG = 'LISTENER_ST_DENSITY_LINE';
		LISTENER_ST_DENSITY_LINE_CATEGORY = Category.EVANESCENT;
		LISTENER_ST_DENSITY_LINE_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pf = GraphHistPF(varargin)
			%GraphHistPF() creates a panel figure for graph histogram.
			%
			% GraphHistPF(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GraphHistPF(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pf = pf@PanelFig(varargin{:});
		end
	end
	methods (Static) % inspection
		function pf_class = getClass()
			%GETCLASS returns the class of the panel figure for graph histogram.
			%
			% CLASS = GraphHistPF.GETCLASS() returns the class 'GraphHistPF'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure for graph histogram PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('GraphHistPF') returns 'GraphHistPF'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('GraphHistPF')
			%  are less computationally efficient.
			
			pf_class = 'GraphHistPF';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure for graph histogram.
			%
			% LIST = GraphHistPF.GETSUBCLASSES() returns all subclasses of 'GraphHistPF'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure for graph histogram PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('GraphHistPF') returns all subclasses of 'GraphHistPF'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GraphHistPF', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure for graph histogram.
			%
			% PROPS = GraphHistPF.GETPROPS() returns the property list of panel figure for graph histogram
			%  as a row vector.
			%
			% PROPS = GraphHistPF.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure for graph histogram PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('GraphHistPF'[, CATEGORY]) returns the property list of 'GraphHistPF'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelFig.getProps() ...
						GraphHistPF.H_AXES ...
						GraphHistPF.ST_AXIS ...
						GraphHistPF.LISTENER_ST_AXIS ...
						GraphHistPF.G ...
						GraphHistPF.LAYERS ...
						GraphHistPF.LAYERLOCK ...
						GraphHistPF.BINS ...
						GraphHistPF.DIAGONAL ...
						GraphHistPF.SETUP ...
						GraphHistPF.H_HIST_AREA ...
						GraphHistPF.ST_HIST_AREA ...
						GraphHistPF.LISTENER_ST_HIST_AREA ...
						GraphHistPF.H_DENSITY_LINE ...
						GraphHistPF.ST_DENSITY_LINE ...
						GraphHistPF.LISTENER_ST_DENSITY_LINE ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						PanelFig.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						PanelFig.getProps(Category.METADATA) ...
						GraphHistPF.G ...
						GraphHistPF.LAYERLOCK ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						PanelFig.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						PanelFig.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						PanelFig.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						PanelFig.getProps(Category.QUERY) ...
						GraphHistPF.SETUP ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelFig.getProps(Category.EVANESCENT) ...
						GraphHistPF.H_AXES ...
						GraphHistPF.LISTENER_ST_AXIS ...
						GraphHistPF.H_HIST_AREA ...
						GraphHistPF.LISTENER_ST_HIST_AREA ...
						GraphHistPF.H_DENSITY_LINE ...
						GraphHistPF.LISTENER_ST_DENSITY_LINE ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelFig.getProps(Category.FIGURE) ...
						GraphHistPF.ST_AXIS ...
						GraphHistPF.LAYERS ...
						GraphHistPF.BINS ...
						GraphHistPF.DIAGONAL ...
						GraphHistPF.ST_HIST_AREA ...
						GraphHistPF.ST_DENSITY_LINE ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelFig.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel figure for graph histogram.
			%
			% N = GraphHistPF.GETPROPNUMBER() returns the property number of panel figure for graph histogram.
			%
			% N = GraphHistPF.GETPROPNUMBER(CATEGORY) returns the property number of panel figure for graph histogram
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure for graph histogram PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('GraphHistPF') returns the property number of 'GraphHistPF'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GraphHistPF.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel figure for graph histogram/error.
			%
			% CHECK = GraphHistPF.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(GraphHistPF, PROP) checks whether PROP exists for GraphHistPF.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GraphHistPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:GraphHistPF:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:GraphHistPF:WrongInput]
			%  Element.EXISTSPROP(GraphHistPF, PROP) throws error if PROP does NOT exist for GraphHistPF.
			%   Error id: [BRAPH2:GraphHistPF:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GraphHistPF.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GraphHistPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GraphHistPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GraphHistPF.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure for graph histogram/error.
			%
			% CHECK = GraphHistPF.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(GraphHistPF, TAG) checks whether TAG exists for GraphHistPF.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GraphHistPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:GraphHistPF:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:GraphHistPF:WrongInput]
			%  Element.EXISTSTAG(GraphHistPF, TAG) throws error if TAG does NOT exist for GraphHistPF.
			%   Error id: [BRAPH2:GraphHistPF:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			graphhistpf_tag_list = cellfun(@(x) GraphHistPF.getPropTag(x), num2cell(GraphHistPF.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, graphhistpf_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GraphHistPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GraphHistPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GraphHistPF.'] ...
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
			%  PROPERTY = PF.GETPROPPROP(POINTER) returns property number of POINTER of PF.
			%  PROPERTY = Element.GETPROPPROP(GraphHistPF, POINTER) returns property number of POINTER of GraphHistPF.
			%  PROPERTY = PF.GETPROPPROP(GraphHistPF, POINTER) returns property number of POINTER of GraphHistPF.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				graphhistpf_tag_list = cellfun(@(x) GraphHistPF.getPropTag(x), num2cell(GraphHistPF.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, graphhistpf_tag_list)); % tag = pointer
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
			%  TAG = PF.GETPROPTAG(POINTER) returns tag of POINTER of PF.
			%  TAG = Element.GETPROPTAG(GraphHistPF, POINTER) returns tag of POINTER of GraphHistPF.
			%  TAG = PF.GETPROPTAG(GraphHistPF, POINTER) returns tag of POINTER of GraphHistPF.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GraphHistPF.H_AXES
						tag = GraphHistPF.H_AXES_TAG;
					case GraphHistPF.ST_AXIS
						tag = GraphHistPF.ST_AXIS_TAG;
					case GraphHistPF.LISTENER_ST_AXIS
						tag = GraphHistPF.LISTENER_ST_AXIS_TAG;
					case GraphHistPF.G
						tag = GraphHistPF.G_TAG;
					case GraphHistPF.LAYERS
						tag = GraphHistPF.LAYERS_TAG;
					case GraphHistPF.LAYERLOCK
						tag = GraphHistPF.LAYERLOCK_TAG;
					case GraphHistPF.BINS
						tag = GraphHistPF.BINS_TAG;
					case GraphHistPF.DIAGONAL
						tag = GraphHistPF.DIAGONAL_TAG;
					case GraphHistPF.SETUP
						tag = GraphHistPF.SETUP_TAG;
					case GraphHistPF.H_HIST_AREA
						tag = GraphHistPF.H_HIST_AREA_TAG;
					case GraphHistPF.ST_HIST_AREA
						tag = GraphHistPF.ST_HIST_AREA_TAG;
					case GraphHistPF.LISTENER_ST_HIST_AREA
						tag = GraphHistPF.LISTENER_ST_HIST_AREA_TAG;
					case GraphHistPF.H_DENSITY_LINE
						tag = GraphHistPF.H_DENSITY_LINE_TAG;
					case GraphHistPF.ST_DENSITY_LINE
						tag = GraphHistPF.ST_DENSITY_LINE_TAG;
					case GraphHistPF.LISTENER_ST_DENSITY_LINE
						tag = GraphHistPF.LISTENER_ST_DENSITY_LINE_TAG;
					otherwise
						tag = getPropTag@PanelFig(prop);
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
			%  CATEGORY = PF.GETPROPCATEGORY(POINTER) returns category of POINTER of PF.
			%  CATEGORY = Element.GETPROPCATEGORY(GraphHistPF, POINTER) returns category of POINTER of GraphHistPF.
			%  CATEGORY = PF.GETPROPCATEGORY(GraphHistPF, POINTER) returns category of POINTER of GraphHistPF.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GraphHistPF.getPropProp(pointer);
			
			switch prop
				case GraphHistPF.H_AXES
					prop_category = GraphHistPF.H_AXES_CATEGORY;
				case GraphHistPF.ST_AXIS
					prop_category = GraphHistPF.ST_AXIS_CATEGORY;
				case GraphHistPF.LISTENER_ST_AXIS
					prop_category = GraphHistPF.LISTENER_ST_AXIS_CATEGORY;
				case GraphHistPF.G
					prop_category = GraphHistPF.G_CATEGORY;
				case GraphHistPF.LAYERS
					prop_category = GraphHistPF.LAYERS_CATEGORY;
				case GraphHistPF.LAYERLOCK
					prop_category = GraphHistPF.LAYERLOCK_CATEGORY;
				case GraphHistPF.BINS
					prop_category = GraphHistPF.BINS_CATEGORY;
				case GraphHistPF.DIAGONAL
					prop_category = GraphHistPF.DIAGONAL_CATEGORY;
				case GraphHistPF.SETUP
					prop_category = GraphHistPF.SETUP_CATEGORY;
				case GraphHistPF.H_HIST_AREA
					prop_category = GraphHistPF.H_HIST_AREA_CATEGORY;
				case GraphHistPF.ST_HIST_AREA
					prop_category = GraphHistPF.ST_HIST_AREA_CATEGORY;
				case GraphHistPF.LISTENER_ST_HIST_AREA
					prop_category = GraphHistPF.LISTENER_ST_HIST_AREA_CATEGORY;
				case GraphHistPF.H_DENSITY_LINE
					prop_category = GraphHistPF.H_DENSITY_LINE_CATEGORY;
				case GraphHistPF.ST_DENSITY_LINE
					prop_category = GraphHistPF.ST_DENSITY_LINE_CATEGORY;
				case GraphHistPF.LISTENER_ST_DENSITY_LINE
					prop_category = GraphHistPF.LISTENER_ST_DENSITY_LINE_CATEGORY;
				otherwise
					prop_category = getPropCategory@PanelFig(prop);
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
			%  FORMAT = PF.GETPROPFORMAT(POINTER) returns format of POINTER of PF.
			%  FORMAT = Element.GETPROPFORMAT(GraphHistPF, POINTER) returns format of POINTER of GraphHistPF.
			%  FORMAT = PF.GETPROPFORMAT(GraphHistPF, POINTER) returns format of POINTER of GraphHistPF.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GraphHistPF.getPropProp(pointer);
			
			switch prop
				case GraphHistPF.H_AXES
					prop_format = GraphHistPF.H_AXES_FORMAT;
				case GraphHistPF.ST_AXIS
					prop_format = GraphHistPF.ST_AXIS_FORMAT;
				case GraphHistPF.LISTENER_ST_AXIS
					prop_format = GraphHistPF.LISTENER_ST_AXIS_FORMAT;
				case GraphHistPF.G
					prop_format = GraphHistPF.G_FORMAT;
				case GraphHistPF.LAYERS
					prop_format = GraphHistPF.LAYERS_FORMAT;
				case GraphHistPF.LAYERLOCK
					prop_format = GraphHistPF.LAYERLOCK_FORMAT;
				case GraphHistPF.BINS
					prop_format = GraphHistPF.BINS_FORMAT;
				case GraphHistPF.DIAGONAL
					prop_format = GraphHistPF.DIAGONAL_FORMAT;
				case GraphHistPF.SETUP
					prop_format = GraphHistPF.SETUP_FORMAT;
				case GraphHistPF.H_HIST_AREA
					prop_format = GraphHistPF.H_HIST_AREA_FORMAT;
				case GraphHistPF.ST_HIST_AREA
					prop_format = GraphHistPF.ST_HIST_AREA_FORMAT;
				case GraphHistPF.LISTENER_ST_HIST_AREA
					prop_format = GraphHistPF.LISTENER_ST_HIST_AREA_FORMAT;
				case GraphHistPF.H_DENSITY_LINE
					prop_format = GraphHistPF.H_DENSITY_LINE_FORMAT;
				case GraphHistPF.ST_DENSITY_LINE
					prop_format = GraphHistPF.ST_DENSITY_LINE_FORMAT;
				case GraphHistPF.LISTENER_ST_DENSITY_LINE
					prop_format = GraphHistPF.LISTENER_ST_DENSITY_LINE_FORMAT;
				otherwise
					prop_format = getPropFormat@PanelFig(prop);
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
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PF.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GraphHistPF, POINTER) returns description of POINTER of GraphHistPF.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(GraphHistPF, POINTER) returns description of POINTER of GraphHistPF.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GraphHistPF.getPropProp(pointer);
			
			switch prop
				case GraphHistPF.H_AXES
					prop_description = 'H_AXES (evanescent, handle) is the handle for the axes.';
				case GraphHistPF.ST_AXIS
					prop_description = 'ST_AXIS (figure, item) determines the axis settings.';
				case GraphHistPF.LISTENER_ST_AXIS
					prop_description = 'LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.';
				case GraphHistPF.G
					prop_description = 'G (metadata, item) is the graph.';
				case GraphHistPF.LAYERS
					prop_description = 'LAYERS (figure, rvector) determines the indices of the layers.';
				case GraphHistPF.LAYERLOCK
					prop_description = 'LAYERLOCK (metadata, logical) is whether the two layers are locked so that only the diagonal is shown.';
				case GraphHistPF.BINS
					prop_description = 'BINS (figure, rvector) is the vector of bins.';
				case GraphHistPF.DIAGONAL
					prop_description = 'DIAGONAL (figure, option) excludes or includes the diagonal in the density calculation.';
				case GraphHistPF.SETUP
					prop_description = 'SETUP (query, empty) calculates the histogram and density and stores them.';
				case GraphHistPF.H_HIST_AREA
					prop_description = 'H_HIST_AREA (evanescent, handle) is the handle for the histogram area.';
				case GraphHistPF.ST_HIST_AREA
					prop_description = 'ST_HIST_AREA (figure, item) determines the area settings.';
				case GraphHistPF.LISTENER_ST_HIST_AREA
					prop_description = 'LISTENER_ST_HIST_AREA (evanescent, handle) contains the listener to the histogram area settings to update the pushbutton.';
				case GraphHistPF.H_DENSITY_LINE
					prop_description = 'H_DENSITY_LINE (evanescent, handle) is the handle for the density line.';
				case GraphHistPF.ST_DENSITY_LINE
					prop_description = 'ST_DENSITY_LINE (figure, item) determines the line settings.';
				case GraphHistPF.LISTENER_ST_DENSITY_LINE
					prop_description = 'LISTENER_ST_DENSITY_LINE (evanescent, handle) contains the listener to the density line settings to update the pushbutton.';
				case GraphHistPF.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the panel figure for graph histogram.';
				case GraphHistPF.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure for graph histogram.';
				case GraphHistPF.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure for graph histogram.';
				case GraphHistPF.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure for graph histogram.';
				case GraphHistPF.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure for graph histogram.';
				case GraphHistPF.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure for graph histogram.';
				case GraphHistPF.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure for graph histogram.';
				case GraphHistPF.DRAW
					prop_description = 'DRAW (query, logical) draws the figure graph histogram.';
				case GraphHistPF.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel figure graph is deleted.';
				case GraphHistPF.H_TOOLS
					prop_description = 'H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.';
				otherwise
					prop_description = getPropDescription@PanelFig(prop);
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
			%  SETTINGS = PF.GETPROPSETTINGS(POINTER) returns settings of POINTER of PF.
			%  SETTINGS = Element.GETPROPSETTINGS(GraphHistPF, POINTER) returns settings of POINTER of GraphHistPF.
			%  SETTINGS = PF.GETPROPSETTINGS(GraphHistPF, POINTER) returns settings of POINTER of GraphHistPF.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GraphHistPF.getPropProp(pointer);
			
			switch prop
				case GraphHistPF.H_AXES
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GraphHistPF.ST_AXIS
					prop_settings = 'SettingsAxis';
				case GraphHistPF.LISTENER_ST_AXIS
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GraphHistPF.G
					prop_settings = 'Graph';
				case GraphHistPF.LAYERS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case GraphHistPF.LAYERLOCK
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GraphHistPF.BINS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case GraphHistPF.DIAGONAL
					prop_settings = {'exclude' 'include'};
				case GraphHistPF.SETUP
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case GraphHistPF.H_HIST_AREA
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GraphHistPF.ST_HIST_AREA
					prop_settings = 'SettingsArea';
				case GraphHistPF.LISTENER_ST_HIST_AREA
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GraphHistPF.H_DENSITY_LINE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GraphHistPF.ST_DENSITY_LINE
					prop_settings = 'SettingsLine';
				case GraphHistPF.LISTENER_ST_DENSITY_LINE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GraphHistPF.TEMPLATE
					prop_settings = 'GraphHistPF';
				otherwise
					prop_settings = getPropSettings@PanelFig(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GraphHistPF.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GraphHistPF.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(GraphHistPF, POINTER) returns the default value of POINTER of GraphHistPF.
			%  DEFAULT = PF.GETPROPDEFAULT(GraphHistPF, POINTER) returns the default value of POINTER of GraphHistPF.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GraphHistPF.getPropProp(pointer);
			
			switch prop
				case GraphHistPF.H_AXES
					prop_default = Format.getFormatDefault(Format.HANDLE, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.ST_AXIS
					prop_default = SettingsAxis('AXIS', true, 'GRID', false, 'EQUAL', false);
				case GraphHistPF.LISTENER_ST_AXIS
					prop_default = Format.getFormatDefault(Format.HANDLE, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.G
					prop_default = Format.getFormatDefault(Format.ITEM, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.LAYERS
					prop_default = [1 1];
				case GraphHistPF.LAYERLOCK
					prop_default = false;
				case GraphHistPF.BINS
					prop_default = [-1:.001:1];
				case GraphHistPF.DIAGONAL
					prop_default = Format.getFormatDefault(Format.OPTION, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.SETUP
					prop_default = Format.getFormatDefault(Format.EMPTY, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.H_HIST_AREA
					prop_default = Format.getFormatDefault(Format.HANDLE, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.ST_HIST_AREA
					prop_default = Format.getFormatDefault(Format.ITEM, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.LISTENER_ST_HIST_AREA
					prop_default = Format.getFormatDefault(Format.HANDLE, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.H_DENSITY_LINE
					prop_default = Format.getFormatDefault(Format.HANDLE, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.ST_DENSITY_LINE
					prop_default = Format.getFormatDefault(Format.ITEM, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.LISTENER_ST_DENSITY_LINE
					prop_default = Format.getFormatDefault(Format.HANDLE, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.ELCLASS
					prop_default = 'GraphHistPF';
				case GraphHistPF.NAME
					prop_default = 'Panel Figure for Graph Histogram';
				case GraphHistPF.DESCRIPTION
					prop_default = 'A Panel Figure for Graph Histogram (GraphHistPF) manages the plot of the histogram of an adjaciency matrix.';
				case GraphHistPF.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.ID
					prop_default = 'GraphHistPF ID';
				case GraphHistPF.LABEL
					prop_default = 'GraphHistPF label';
				case GraphHistPF.NOTES
					prop_default = 'GraphHistPF notes';
				otherwise
					prop_default = getPropDefault@PanelFig(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GraphHistPF.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GraphHistPF.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GraphHistPF, POINTER) returns the conditioned default value of POINTER of GraphHistPF.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(GraphHistPF, POINTER) returns the conditioned default value of POINTER of GraphHistPF.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GraphHistPF.getPropProp(pointer);
			
			prop_default = GraphHistPF.conditioning(prop, GraphHistPF.getPropDefault(prop));
		end
	end
	methods (Access=protected) % preset
		function value = preset(pf, prop, value)
			%PRESET preprocesses the value of a property before setting it.
			%
			% VALUE = PRESET(EL, PROP, VALUE) prepropcesses the VALUE of the property
			%  PROP. It works only with properties with Category.METADATA,
			%  Category.PARAMETER, Category.DATA, Category.FIGURE and Category.GUI. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% See also conditioning, checkProp, postset, postprocessing,
			%  calculateValue, checkValue.
			
			switch prop
				case GraphHistPF.LAYERS % __GraphHistPF.LAYERS__
					if pf.get('LAYERLOCK')
					    value = [value(1) value(1)];
					end
					
				otherwise
					if prop <= PanelFig.getPropNumber()
						value = preset@PanelFig(pf, prop, value);
					end
			end
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PF.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PF.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PF.
			%  CHECK = Element.CHECKPROP(GraphHistPF, PROP, VALUE) checks VALUE format for PROP of GraphHistPF.
			%  CHECK = PF.CHECKPROP(GraphHistPF, PROP, VALUE) checks VALUE format for PROP of GraphHistPF.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GraphHistPF:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:GraphHistPF:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GraphHistPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GraphHistPF.
			%   Error id: €BRAPH2.STR€:GraphHistPF:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(GraphHistPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GraphHistPF.
			%   Error id: €BRAPH2.STR€:GraphHistPF:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('GraphHistPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GraphHistPF.getPropProp(pointer);
			
			switch prop
				case GraphHistPF.H_AXES % __GraphHistPF.H_AXES__
					check = Format.checkFormat(Format.HANDLE, value, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.ST_AXIS % __GraphHistPF.ST_AXIS__
					check = Format.checkFormat(Format.ITEM, value, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.LISTENER_ST_AXIS % __GraphHistPF.LISTENER_ST_AXIS__
					check = Format.checkFormat(Format.HANDLE, value, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.G % __GraphHistPF.G__
					check = Format.checkFormat(Format.ITEM, value, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.LAYERS % __GraphHistPF.LAYERS__
					check = Format.checkFormat(Format.RVECTOR, value, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.LAYERLOCK % __GraphHistPF.LAYERLOCK__
					check = Format.checkFormat(Format.LOGICAL, value, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.BINS % __GraphHistPF.BINS__
					check = Format.checkFormat(Format.RVECTOR, value, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.DIAGONAL % __GraphHistPF.DIAGONAL__
					check = Format.checkFormat(Format.OPTION, value, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.SETUP % __GraphHistPF.SETUP__
					check = Format.checkFormat(Format.EMPTY, value, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.H_HIST_AREA % __GraphHistPF.H_HIST_AREA__
					check = Format.checkFormat(Format.HANDLE, value, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.ST_HIST_AREA % __GraphHistPF.ST_HIST_AREA__
					check = Format.checkFormat(Format.ITEM, value, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.LISTENER_ST_HIST_AREA % __GraphHistPF.LISTENER_ST_HIST_AREA__
					check = Format.checkFormat(Format.HANDLE, value, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.H_DENSITY_LINE % __GraphHistPF.H_DENSITY_LINE__
					check = Format.checkFormat(Format.HANDLE, value, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.ST_DENSITY_LINE % __GraphHistPF.ST_DENSITY_LINE__
					check = Format.checkFormat(Format.ITEM, value, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.LISTENER_ST_DENSITY_LINE % __GraphHistPF.LISTENER_ST_DENSITY_LINE__
					check = Format.checkFormat(Format.HANDLE, value, GraphHistPF.getPropSettings(prop));
				case GraphHistPF.TEMPLATE % __GraphHistPF.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, GraphHistPF.getPropSettings(prop));
				otherwise
					if prop <= PanelFig.getPropNumber()
						check = checkProp@PanelFig(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GraphHistPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GraphHistPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GraphHistPF.getPropTag(prop) ' (' GraphHistPF.getFormatTag(GraphHistPF.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(pf, prop)
			%POSTSET postprocessing after a prop has been set.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing after PROP has been set. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% This postprocessing occurs only when PROP is set.
			%
			% See also conditioning, preset, checkProp, postprocessing, calculateValue,
			%  checkValue.
			
			switch prop
				case GraphHistPF.ST_AXIS % __GraphHistPF.ST_AXIS__
					if pf.get('DRAWN')
					    toolbar = pf.get('H_TOOLBAR');
					    if check_graphics(toolbar, 'uitoolbar')
					        set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
					        set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
					    end
					end
					
				case GraphHistPF.LAYERS % __GraphHistPF.LAYERS__
					pf.get('SETUP')
					
				case GraphHistPF.LAYERLOCK % __GraphHistPF.LAYERLOCK__
					if pf.get('LAYERLOCK')
					    layers = pf.get('LAYERS');
					    if layers(1) ~= layers(2)
					        pf.set('LAYERS', [layers(1) layers(1)])
					    end
					end
					
				case GraphHistPF.BINS % __GraphHistPF.BINS__
					pf.get('SETUP')
					
				case GraphHistPF.DIAGONAL % __GraphHistPF.DIAGONAL__
					pf.get('SETUP')
					
				otherwise
					if prop <= PanelFig.getPropNumber()
						postset@PanelFig(pf, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pf, prop, varargin)
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
				case GraphHistPF.H_AXES % __GraphHistPF.H_AXES__
					h_axes = uiaxes( ...
					    'Parent', pf.memorize('H'), ...
					    'Tag', 'H_AXES', ...
					    'Units', 'normalized', ...
					    'OuterPosition', [0 0 1 1] ...
					    );
					h_axes.Toolbar.Visible = 'off';
					h_axes.Interactions = [];
					box(h_axes, 'on')
					hold(h_axes, 'on')
					value = h_axes;
					
				case GraphHistPF.LISTENER_ST_AXIS % __GraphHistPF.LISTENER_ST_AXIS__
					value = listener(pf.get('ST_AXIS'), 'PropSet', @cb_listener_st_axis);
					
				case GraphHistPF.SETUP % __GraphHistPF.SETUP__
					A = pf.get('G').get('A');
					if numel(A) <= 1
					    A = cell2mat(A);
					else
					    layers = pf.get('LAYERS');
					    A = A{layers(1), layers(2)};
					end
					
					[count, bins, density] = histogram(A, 'Bins', pf.get('BINS'), 'Diagonal', pf.get('DIAGONAL'));
					
					bins = [bins(1) bins bins(end)];
					count = [0 count 0];
					density = [100 density 0];
					
					pf.memorize('ST_HIST_AREA').set('X', bins, 'Y', count)
					
					pf.memorize('ST_DENSITY_LINE').set('X', bins, 'Y', density)
					
					if pf.get('ST_HIST_AREA').get('VISIBLE') && pf.get('ST_DENSITY_LINE').get('VISIBLE')
					    xlabel(pf.get('H_AXES'), 'coefficient value / threshold')
					    ylabel(pf.get('H_AXES'), 'coefficient count / density')
					elseif pf.get('ST_HIST_AREA').get('VISIBLE') && ~pf.get('ST_DENSITY_LINE').get('VISIBLE')
					    xlabel(pf.get('H_AXES'), 'coefficient value')
					    ylabel(pf.get('H_AXES'), 'coefficient count')
					elseif ~pf.get('ST_HIST_AREA').get('VISIBLE') && pf.get('ST_DENSITY_LINE').get('VISIBLE')
					    xlabel(pf.get('H_AXES'), 'threshold')
					    ylabel(pf.get('H_AXES'), 'density')
					else % ~pf.get('ST_HIST_AREA').get('VISIBLE') && ~pf.get('ST_DENSITY_LINE').get('VISIBLE')
					    xlabel(pf.get('H_AXES'), '')
					    ylabel(pf.get('H_AXES'), '')
					end
					
					value = [];
					
				case GraphHistPF.H_HIST_AREA % __GraphHistPF.H_HIST_AREA__
					value = fill(pf.get('H_AXES'), [0], [0], 'k');
					
				case GraphHistPF.LISTENER_ST_HIST_AREA % __GraphHistPF.LISTENER_ST_HIST_AREA__
					value = listener(pf.get('ST_HIST_AREA'), 'PropSet', @cb_listener_st_hist_area);
					
				case GraphHistPF.H_DENSITY_LINE % __GraphHistPF.H_DENSITY_LINE__
					value = plot(pf.get('H_AXES'), [0], [0], 'b', 'LineWidth', 2);
					
				case GraphHistPF.LISTENER_ST_DENSITY_LINE % __GraphHistPF.LISTENER_ST_DENSITY_LINE__
					value = listener(pf.get('ST_DENSITY_LINE'), 'PropSet', @cb_listener_st_density_line);
					
				case GraphHistPF.DRAW % __GraphHistPF.DRAW__
					value = calculateValue@PanelFig(pf, PanelFig.DRAW, varargin{:}); % also warning
					if value
					    pf.memorize('H_AXES')
					    
					    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', GraphHistPF.H_AXES).get('SETUP')
					    pf.memorize('LISTENER_ST_AXIS');
					    
					    pf.memorize('H_HIST_AREA')
					    pf.memorize('ST_HIST_AREA').set('PANEL', pf, 'PROP', GraphHistPF.H_HIST_AREA).get('SETUP')
					    pf.memorize('LISTENER_ST_HIST_AREA');
					
					    pf.memorize('H_DENSITY_LINE')
					    pf.memorize('ST_DENSITY_LINE').set('PANEL', pf, 'PROP', GraphHistPF.H_DENSITY_LINE).get('SETUP')
					    pf.memorize('LISTENER_ST_DENSITY_LINE');
					    
					    pf.get('SETUP')
					end
					
				case GraphHistPF.DELETE % __GraphHistPF.DELETE__
					value = calculateValue@PanelFig(pf, PanelFig.DELETE, varargin{:}); % also warning
					if value
					    pf.set('H_AXES', Element.getNoValue())
					
					    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
					    
					    pf.set('H_HIST_AREA', Element.getNoValue())
					    pf.set('LISTENER_ST_HIST_AREA', Element.getNoValue())
					 
					    pf.set('H_DENSITY_LINE', Element.getNoValue())
					    pf.set('LISTENER_ST_DENSITY_LINE', Element.getNoValue())
					end
					
				case GraphHistPF.H_TOOLS % __GraphHistPF.H_TOOLS__
					toolbar = pf.memorize('H_TOOLBAR');
					if check_graphics(toolbar, 'uitoolbar')
					    value = calculateValue@PanelFig(pf, PanelFig.H_TOOLS);
					    
					    tool_separator_1 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
					
					    % Axis
					    tool_axis = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Axis', ...
					        'Separator', 'on', ...
					        'State', pf.get('ST_AXIS').get('AXIS'), ...
					        'Tooltip', 'Show axis', ...
					        'CData', imread('icon_axis.png'), ...
					        'OnCallback', {@cb_axis, true}, ...
					        'OffCallback', {@cb_axis, false});
					
					    % Grid
					    tool_grid = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Grid', ...
					        'State', pf.get('ST_AXIS').get('GRID'), ...
					        'Tooltip', 'Show grid', ...
					        'CData', imread('icon_grid.png'), ...
					        'OnCallback', {@cb_grid, true}, ...
					        'OffCallback', {@cb_grid, false});
					
					    tool_separator_2 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
					
					    % Histogram Area
					    tool_hist_area = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.HistArea', ...
					        'State', pf.get('ST_HIST_AREA').get('VISIBLE'), ...
					        'Tooltip', 'Show histogram area', ...
					        'CData', imread('icon_area.png'), ...
					        'OnCallback', {@cb_hist_area, true}, ...
					        'OffCallback', {@cb_hist_area, false});
					    
					    % Histogram Line
					    tool_density_line = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.DensityLine', ...
					        'State', pf.get('ST_DENSITY_LINE').get('VISIBLE'), ...
					        'Tooltip', 'Show density line', ...
					        'CData', imread('icon_line.png'), ...
					        'OnCallback', {@cb_density_line, true}, ...
					        'OffCallback', {@cb_density_line, false});
					
					    value = {value{:}, ...
					        tool_separator_1, ...
					        tool_axis, tool_grid, ...
					        tool_separator_2, ...
					        tool_hist_area, tool_density_line ...
					        };
					else
					    value = {};
					end
					
				otherwise
					if prop <= PanelFig.getPropNumber()
						value = calculateValue@PanelFig(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
			function cb_listener_st_axis(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
			            set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
			        end
			    end
			end
			function cb_listener_st_hist_area(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.HistArea'), 'State', pf.get('ST_HIST_AREA').get('VISIBLE'))
			        end
			    end
			end
			function cb_listener_st_density_line(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.DensityLine'), 'State', pf.get('ST_DENSITY_LINE').get('VISIBLE'))
			        end
			    end
			end
			function cb_axis(~, ~, axis) % (src, event)
			    pf.get('ST_AXIS').set('AXIS', axis);
			    
			    % triggers the update of ST_AXIS
			    pf.set('ST_AXIS', pf.get('ST_AXIS'))
			end
			function cb_grid(~, ~, grid) % (src, event)
			    pf.get('ST_AXIS').set('GRID', grid);
			
			    % triggers the update of ST_AXIS
			    pf.set('ST_AXIS', pf.get('ST_AXIS'))
			end
			function cb_hist_area(~, ~, visible) % (src, event)
			    pf.get('ST_HIST_AREA').set('VISIBLE', visible)
			
			    % triggers the update of ST_HIST_AREA
			    pf.set('ST_HIST_AREA', pf.get('ST_HIST_AREA'))
			end
			function cb_density_line(~, ~, visible) % (src, event)
				pf.get('ST_DENSITY_LINE').set('VISIBLE', visible)
			
			    % triggers the update of ST_DENSITY_LINE
			    pf.set('ST_DENSITY_LINE', pf.get('ST_DENSITY_LINE'))
			end
		end
	end
	methods % GUI
		function pr = getPanelProp(pf, prop, varargin)
			%GETPANELPROP returns a prop panel.
			%
			% PR = GETPANELPROP(EL, PROP) returns the panel of prop PROP.
			%
			% PR = GETPANELPROP(EL, PROP, 'Name', Value, ...) sets the properties 
			%  of the panel prop.
			%
			% See also PanelProp, PanelPropAlpha, PanelPropCell, PanelPropClass,
			%  PanelPropClassList, PanelPropColor, PanelPropHandle,
			%  PanelPropHandleList, PanelPropIDict, PanelPropItem, PanelPropLine,
			%  PanelPropItemList, PanelPropLogical, PanelPropMarker, PanelPropMatrix,
			%  PanelPropNet, PanelPropOption, PanelPropScalar, PanelPropSize,
			%  PanelPropString, PanelPropStringList.
			
			switch prop
				case GraphHistPF.ST_AXIS % __GraphHistPF.ST_AXIS__
					pr = SettingsAxisPP('EL', pf, 'PROP', GraphHistPF.ST_AXIS, varargin{:});
					
				case GraphHistPF.LAYERS % __GraphHistPF.LAYERS__
					pr = LayersPP('EL', pf, 'PROP', GraphHistPF.LAYERS, ...
					    'G_PROP', GraphHistPF.G, ...
					    varargin{:});
					
				case GraphHistPF.BINS % __GraphHistPF.BINS__
					pr = PanelPropRVectorSmart('EL', pf, 'PROP', GraphHistPF.BINS, 'MAX', 1, 'MIN', -1, varargin{:});
					
				case GraphHistPF.ST_HIST_AREA % __GraphHistPF.ST_HIST_AREA__
					pr = SettingsAreaPP('EL', pf, 'PROP', GraphHistPF.ST_HIST_AREA, varargin{:});
					
				case GraphHistPF.ST_DENSITY_LINE % __GraphHistPF.ST_DENSITY_LINE__
					pr = SettingsLinePP('EL', pf, 'PROP', GraphHistPF.ST_DENSITY_LINE, varargin{:});
					
				otherwise
					pr = getPanelProp@PanelFig(pf, prop, varargin{:});
					
			end
		end
	end
end
