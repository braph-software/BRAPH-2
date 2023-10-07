classdef GraphAdjPF < PanelFig
	%GraphAdjPF is a plot of a graph adjacency matrix.
	% It is a subclass of <a href="matlab:help PanelFig">PanelFig</a>.
	%
	% A Panel Figure for Graph Adjacency Matrix (GraphAdjPF) manages the plot of an adjacency matrix.
	%
	% GraphAdjPF methods (constructor):
	%  GraphAdjPF - constructor
	%
	% GraphAdjPF methods:
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
	% GraphAdjPF methods (display):
	%  tostring - string with information about the panel figure for graph adjacency matrix
	%  disp - displays information about the panel figure for graph adjacency matrix
	%  tree - displays the tree of the panel figure for graph adjacency matrix
	%
	% GraphAdjPF methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure for graph adjacency matrix are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure for graph adjacency matrix
	%
	% GraphAdjPF methods (save/load, Static):
	%  save - saves BRAPH2 panel figure for graph adjacency matrix as b2 file
	%  load - loads a BRAPH2 panel figure for graph adjacency matrix from a b2 file
	%
	% GraphAdjPF method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure for graph adjacency matrix
	%
	% GraphAdjPF method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure for graph adjacency matrix
	%
	% GraphAdjPF methods (inspection, Static):
	%  getClass - returns the class of the panel figure for graph adjacency matrix
	%  getSubclasses - returns all subclasses of GraphAdjPF
	%  getProps - returns the property list of the panel figure for graph adjacency matrix
	%  getPropNumber - returns the property number of the panel figure for graph adjacency matrix
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
	% GraphAdjPF methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GraphAdjPF methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GraphAdjPF methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GraphAdjPF methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GraphAdjPF; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GraphAdjPF constants</a>.
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
		
		WEIGHTED = PanelFig.getPropNumber() + 7;
		WEIGHTED_TAG = 'WEIGHTED';
		WEIGHTED_CATEGORY = Category.FIGURE;
		WEIGHTED_FORMAT = Format.LOGICAL;
		
		COLORBAR = PanelFig.getPropNumber() + 8;
		COLORBAR_TAG = 'COLORBAR';
		COLORBAR_CATEGORY = Category.FIGURE;
		COLORBAR_FORMAT = Format.LOGICAL;
		
		ST_AMBIENT = PanelFig.getPropNumber() + 9;
		ST_AMBIENT_TAG = 'ST_AMBIENT';
		ST_AMBIENT_CATEGORY = Category.FIGURE;
		ST_AMBIENT_FORMAT = Format.ITEM;
		
		SETUP = PanelFig.getPropNumber() + 10;
		SETUP_TAG = 'SETUP';
		SETUP_CATEGORY = Category.QUERY;
		SETUP_FORMAT = Format.EMPTY;
		
		H_ADJ = PanelFig.getPropNumber() + 11;
		H_ADJ_TAG = 'H_ADJ';
		H_ADJ_CATEGORY = Category.EVANESCENT;
		H_ADJ_FORMAT = Format.HANDLE;
	end
	methods % constructor
		function pf = GraphAdjPF(varargin)
			%GraphAdjPF() creates a panel figure for graph adjacency matrix.
			%
			% GraphAdjPF(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GraphAdjPF(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the panel figure for graph adjacency matrix.
			%
			% CLASS = GraphAdjPF.GETCLASS() returns the class 'GraphAdjPF'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure for graph adjacency matrix PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('GraphAdjPF') returns 'GraphAdjPF'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('GraphAdjPF')
			%  are less computationally efficient.
			
			pf_class = 'GraphAdjPF';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure for graph adjacency matrix.
			%
			% LIST = GraphAdjPF.GETSUBCLASSES() returns all subclasses of 'GraphAdjPF'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure for graph adjacency matrix PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('GraphAdjPF') returns all subclasses of 'GraphAdjPF'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GraphAdjPF', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure for graph adjacency matrix.
			%
			% PROPS = GraphAdjPF.GETPROPS() returns the property list of panel figure for graph adjacency matrix
			%  as a row vector.
			%
			% PROPS = GraphAdjPF.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure for graph adjacency matrix PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('GraphAdjPF'[, CATEGORY]) returns the property list of 'GraphAdjPF'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelFig.getProps() ...
						GraphAdjPF.H_AXES ...
						GraphAdjPF.ST_AXIS ...
						GraphAdjPF.LISTENER_ST_AXIS ...
						GraphAdjPF.G ...
						GraphAdjPF.LAYERS ...
						GraphAdjPF.LAYERLOCK ...
						GraphAdjPF.WEIGHTED ...
						GraphAdjPF.COLORBAR ...
						GraphAdjPF.ST_AMBIENT ...
						GraphAdjPF.SETUP ...
						GraphAdjPF.H_ADJ ...
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
						GraphAdjPF.G ...
						GraphAdjPF.LAYERLOCK ...
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
						GraphAdjPF.SETUP ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelFig.getProps(Category.EVANESCENT) ...
						GraphAdjPF.H_AXES ...
						GraphAdjPF.LISTENER_ST_AXIS ...
						GraphAdjPF.H_ADJ ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelFig.getProps(Category.FIGURE) ...
						GraphAdjPF.ST_AXIS ...
						GraphAdjPF.LAYERS ...
						GraphAdjPF.WEIGHTED ...
						GraphAdjPF.COLORBAR ...
						GraphAdjPF.ST_AMBIENT ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelFig.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel figure for graph adjacency matrix.
			%
			% N = GraphAdjPF.GETPROPNUMBER() returns the property number of panel figure for graph adjacency matrix.
			%
			% N = GraphAdjPF.GETPROPNUMBER(CATEGORY) returns the property number of panel figure for graph adjacency matrix
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure for graph adjacency matrix PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('GraphAdjPF') returns the property number of 'GraphAdjPF'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GraphAdjPF.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel figure for graph adjacency matrix/error.
			%
			% CHECK = GraphAdjPF.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(GraphAdjPF, PROP) checks whether PROP exists for GraphAdjPF.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GraphAdjPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:GraphAdjPF:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:GraphAdjPF:WrongInput]
			%  Element.EXISTSPROP(GraphAdjPF, PROP) throws error if PROP does NOT exist for GraphAdjPF.
			%   Error id: [BRAPH2:GraphAdjPF:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GraphAdjPF.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GraphAdjPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GraphAdjPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GraphAdjPF.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure for graph adjacency matrix/error.
			%
			% CHECK = GraphAdjPF.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(GraphAdjPF, TAG) checks whether TAG exists for GraphAdjPF.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GraphAdjPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:GraphAdjPF:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:GraphAdjPF:WrongInput]
			%  Element.EXISTSTAG(GraphAdjPF, TAG) throws error if TAG does NOT exist for GraphAdjPF.
			%   Error id: [BRAPH2:GraphAdjPF:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			graphadjpf_tag_list = cellfun(@(x) GraphAdjPF.getPropTag(x), num2cell(GraphAdjPF.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, graphadjpf_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GraphAdjPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GraphAdjPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GraphAdjPF.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GraphAdjPF, POINTER) returns property number of POINTER of GraphAdjPF.
			%  PROPERTY = PF.GETPROPPROP(GraphAdjPF, POINTER) returns property number of POINTER of GraphAdjPF.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				graphadjpf_tag_list = cellfun(@(x) GraphAdjPF.getPropTag(x), num2cell(GraphAdjPF.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, graphadjpf_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GraphAdjPF, POINTER) returns tag of POINTER of GraphAdjPF.
			%  TAG = PF.GETPROPTAG(GraphAdjPF, POINTER) returns tag of POINTER of GraphAdjPF.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GraphAdjPF.H_AXES
						tag = GraphAdjPF.H_AXES_TAG;
					case GraphAdjPF.ST_AXIS
						tag = GraphAdjPF.ST_AXIS_TAG;
					case GraphAdjPF.LISTENER_ST_AXIS
						tag = GraphAdjPF.LISTENER_ST_AXIS_TAG;
					case GraphAdjPF.G
						tag = GraphAdjPF.G_TAG;
					case GraphAdjPF.LAYERS
						tag = GraphAdjPF.LAYERS_TAG;
					case GraphAdjPF.LAYERLOCK
						tag = GraphAdjPF.LAYERLOCK_TAG;
					case GraphAdjPF.WEIGHTED
						tag = GraphAdjPF.WEIGHTED_TAG;
					case GraphAdjPF.COLORBAR
						tag = GraphAdjPF.COLORBAR_TAG;
					case GraphAdjPF.ST_AMBIENT
						tag = GraphAdjPF.ST_AMBIENT_TAG;
					case GraphAdjPF.SETUP
						tag = GraphAdjPF.SETUP_TAG;
					case GraphAdjPF.H_ADJ
						tag = GraphAdjPF.H_ADJ_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(GraphAdjPF, POINTER) returns category of POINTER of GraphAdjPF.
			%  CATEGORY = PF.GETPROPCATEGORY(GraphAdjPF, POINTER) returns category of POINTER of GraphAdjPF.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GraphAdjPF.getPropProp(pointer);
			
			switch prop
				case GraphAdjPF.H_AXES
					prop_category = GraphAdjPF.H_AXES_CATEGORY;
				case GraphAdjPF.ST_AXIS
					prop_category = GraphAdjPF.ST_AXIS_CATEGORY;
				case GraphAdjPF.LISTENER_ST_AXIS
					prop_category = GraphAdjPF.LISTENER_ST_AXIS_CATEGORY;
				case GraphAdjPF.G
					prop_category = GraphAdjPF.G_CATEGORY;
				case GraphAdjPF.LAYERS
					prop_category = GraphAdjPF.LAYERS_CATEGORY;
				case GraphAdjPF.LAYERLOCK
					prop_category = GraphAdjPF.LAYERLOCK_CATEGORY;
				case GraphAdjPF.WEIGHTED
					prop_category = GraphAdjPF.WEIGHTED_CATEGORY;
				case GraphAdjPF.COLORBAR
					prop_category = GraphAdjPF.COLORBAR_CATEGORY;
				case GraphAdjPF.ST_AMBIENT
					prop_category = GraphAdjPF.ST_AMBIENT_CATEGORY;
				case GraphAdjPF.SETUP
					prop_category = GraphAdjPF.SETUP_CATEGORY;
				case GraphAdjPF.H_ADJ
					prop_category = GraphAdjPF.H_ADJ_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(GraphAdjPF, POINTER) returns format of POINTER of GraphAdjPF.
			%  FORMAT = PF.GETPROPFORMAT(GraphAdjPF, POINTER) returns format of POINTER of GraphAdjPF.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GraphAdjPF.getPropProp(pointer);
			
			switch prop
				case GraphAdjPF.H_AXES
					prop_format = GraphAdjPF.H_AXES_FORMAT;
				case GraphAdjPF.ST_AXIS
					prop_format = GraphAdjPF.ST_AXIS_FORMAT;
				case GraphAdjPF.LISTENER_ST_AXIS
					prop_format = GraphAdjPF.LISTENER_ST_AXIS_FORMAT;
				case GraphAdjPF.G
					prop_format = GraphAdjPF.G_FORMAT;
				case GraphAdjPF.LAYERS
					prop_format = GraphAdjPF.LAYERS_FORMAT;
				case GraphAdjPF.LAYERLOCK
					prop_format = GraphAdjPF.LAYERLOCK_FORMAT;
				case GraphAdjPF.WEIGHTED
					prop_format = GraphAdjPF.WEIGHTED_FORMAT;
				case GraphAdjPF.COLORBAR
					prop_format = GraphAdjPF.COLORBAR_FORMAT;
				case GraphAdjPF.ST_AMBIENT
					prop_format = GraphAdjPF.ST_AMBIENT_FORMAT;
				case GraphAdjPF.SETUP
					prop_format = GraphAdjPF.SETUP_FORMAT;
				case GraphAdjPF.H_ADJ
					prop_format = GraphAdjPF.H_ADJ_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GraphAdjPF, POINTER) returns description of POINTER of GraphAdjPF.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(GraphAdjPF, POINTER) returns description of POINTER of GraphAdjPF.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GraphAdjPF.getPropProp(pointer);
			
			switch prop
				case GraphAdjPF.H_AXES
					prop_description = 'H_AXES (evanescent, handle) is the handle for the axes.';
				case GraphAdjPF.ST_AXIS
					prop_description = 'ST_AXIS (figure, item) determines the axis settings.';
				case GraphAdjPF.LISTENER_ST_AXIS
					prop_description = 'LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.';
				case GraphAdjPF.G
					prop_description = 'G (metadata, item) is the graph.';
				case GraphAdjPF.LAYERS
					prop_description = 'LAYERS (figure, rvector) determines the indices of the layers.';
				case GraphAdjPF.LAYERLOCK
					prop_description = 'LAYERLOCK (metadata, logical) is whether the two layers are locked so that only the diagonal is shown.';
				case GraphAdjPF.WEIGHTED
					prop_description = 'WEIGHTED (figure, logical) determines whether to show the weighted or binary adjacency matrix.';
				case GraphAdjPF.COLORBAR
					prop_description = 'COLORBAR (figure, logical) detemines whether to show the colorbar.';
				case GraphAdjPF.ST_AMBIENT
					prop_description = 'ST_AMBIENT (figure, item) determines the ambient settings.';
				case GraphAdjPF.SETUP
					prop_description = 'SETUP (query, empty) calculates the adjacency matrix ans stores it.';
				case GraphAdjPF.H_ADJ
					prop_description = 'H_ADJ (evanescent, handle) is the handle for weighted adjacency matrix.';
				case GraphAdjPF.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the panel figure for graph adjacency matrix.';
				case GraphAdjPF.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure for graph adjacency matrix.';
				case GraphAdjPF.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure for graph adjacency matrix.';
				case GraphAdjPF.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure for graph adjacency matrix.';
				case GraphAdjPF.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure for graph adjacency matrix.';
				case GraphAdjPF.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure for graph adjacency matrix.';
				case GraphAdjPF.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure for graph adjacency matrix.';
				case GraphAdjPF.DRAW
					prop_description = 'DRAW (query, logical) draws the figure graph adjacency matrix.';
				case GraphAdjPF.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel figure graph is deleted.';
				case GraphAdjPF.H_TOOLS
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
			%  SETTINGS = Element.GETPROPSETTINGS(GraphAdjPF, POINTER) returns settings of POINTER of GraphAdjPF.
			%  SETTINGS = PF.GETPROPSETTINGS(GraphAdjPF, POINTER) returns settings of POINTER of GraphAdjPF.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GraphAdjPF.getPropProp(pointer);
			
			switch prop
				case GraphAdjPF.H_AXES
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GraphAdjPF.ST_AXIS
					prop_settings = 'SettingsAxis';
				case GraphAdjPF.LISTENER_ST_AXIS
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GraphAdjPF.G
					prop_settings = 'Graph';
				case GraphAdjPF.LAYERS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case GraphAdjPF.LAYERLOCK
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GraphAdjPF.WEIGHTED
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GraphAdjPF.COLORBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case GraphAdjPF.ST_AMBIENT
					prop_settings = 'SettingsAmbient';
				case GraphAdjPF.SETUP
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case GraphAdjPF.H_ADJ
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case GraphAdjPF.TEMPLATE
					prop_settings = 'GraphAdjPF';
				otherwise
					prop_settings = getPropSettings@PanelFig(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GraphAdjPF.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GraphAdjPF.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(GraphAdjPF, POINTER) returns the default value of POINTER of GraphAdjPF.
			%  DEFAULT = PF.GETPROPDEFAULT(GraphAdjPF, POINTER) returns the default value of POINTER of GraphAdjPF.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GraphAdjPF.getPropProp(pointer);
			
			switch prop
				case GraphAdjPF.H_AXES
					prop_default = Format.getFormatDefault(Format.HANDLE, GraphAdjPF.getPropSettings(prop));
				case GraphAdjPF.ST_AXIS
					prop_default = SettingsAxis('GRID', false, 'AXIS', false, 'BOX', true);
				case GraphAdjPF.LISTENER_ST_AXIS
					prop_default = Format.getFormatDefault(Format.HANDLE, GraphAdjPF.getPropSettings(prop));
				case GraphAdjPF.G
					prop_default = Format.getFormatDefault(Format.ITEM, GraphAdjPF.getPropSettings(prop));
				case GraphAdjPF.LAYERS
					prop_default = [1 1];
				case GraphAdjPF.LAYERLOCK
					prop_default = false;
				case GraphAdjPF.WEIGHTED
					prop_default = true;
				case GraphAdjPF.COLORBAR
					prop_default = true;
				case GraphAdjPF.ST_AMBIENT
					prop_default = SettingsAmbient('LIGHTING', 'none', 'MATERIAL', 'dull', 'CAMLIGHT', 'none', 'SHADING', 'flat', 'COLORMAP', 'jet');
				case GraphAdjPF.SETUP
					prop_default = Format.getFormatDefault(Format.EMPTY, GraphAdjPF.getPropSettings(prop));
				case GraphAdjPF.H_ADJ
					prop_default = Format.getFormatDefault(Format.HANDLE, GraphAdjPF.getPropSettings(prop));
				case GraphAdjPF.ELCLASS
					prop_default = 'GraphAdjPF';
				case GraphAdjPF.NAME
					prop_default = 'Panel Figure for Graph Adjacency Matrix';
				case GraphAdjPF.DESCRIPTION
					prop_default = 'A Panel Figure for Graph Adjacency Matrix (GraphAdjPF) manages the plot of an adjacency matrix.';
				case GraphAdjPF.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, GraphAdjPF.getPropSettings(prop));
				case GraphAdjPF.ID
					prop_default = 'GraphAdjPF ID';
				case GraphAdjPF.LABEL
					prop_default = 'GraphAdjPF label';
				case GraphAdjPF.NOTES
					prop_default = 'GraphAdjPF notes';
				otherwise
					prop_default = getPropDefault@PanelFig(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GraphAdjPF.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GraphAdjPF.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GraphAdjPF, POINTER) returns the conditioned default value of POINTER of GraphAdjPF.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(GraphAdjPF, POINTER) returns the conditioned default value of POINTER of GraphAdjPF.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GraphAdjPF.getPropProp(pointer);
			
			prop_default = GraphAdjPF.conditioning(prop, GraphAdjPF.getPropDefault(prop));
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
				case GraphAdjPF.LAYERS % __GraphAdjPF.LAYERS__
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
			%  CHECK = Element.CHECKPROP(GraphAdjPF, PROP, VALUE) checks VALUE format for PROP of GraphAdjPF.
			%  CHECK = PF.CHECKPROP(GraphAdjPF, PROP, VALUE) checks VALUE format for PROP of GraphAdjPF.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GraphAdjPF:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:GraphAdjPF:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GraphAdjPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GraphAdjPF.
			%   Error id: €BRAPH2.STR€:GraphAdjPF:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(GraphAdjPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GraphAdjPF.
			%   Error id: €BRAPH2.STR€:GraphAdjPF:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('GraphAdjPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GraphAdjPF.getPropProp(pointer);
			
			switch prop
				case GraphAdjPF.H_AXES % __GraphAdjPF.H_AXES__
					check = Format.checkFormat(Format.HANDLE, value, GraphAdjPF.getPropSettings(prop));
				case GraphAdjPF.ST_AXIS % __GraphAdjPF.ST_AXIS__
					check = Format.checkFormat(Format.ITEM, value, GraphAdjPF.getPropSettings(prop));
				case GraphAdjPF.LISTENER_ST_AXIS % __GraphAdjPF.LISTENER_ST_AXIS__
					check = Format.checkFormat(Format.HANDLE, value, GraphAdjPF.getPropSettings(prop));
				case GraphAdjPF.G % __GraphAdjPF.G__
					check = Format.checkFormat(Format.ITEM, value, GraphAdjPF.getPropSettings(prop));
				case GraphAdjPF.LAYERS % __GraphAdjPF.LAYERS__
					check = Format.checkFormat(Format.RVECTOR, value, GraphAdjPF.getPropSettings(prop));
				case GraphAdjPF.LAYERLOCK % __GraphAdjPF.LAYERLOCK__
					check = Format.checkFormat(Format.LOGICAL, value, GraphAdjPF.getPropSettings(prop));
				case GraphAdjPF.WEIGHTED % __GraphAdjPF.WEIGHTED__
					check = Format.checkFormat(Format.LOGICAL, value, GraphAdjPF.getPropSettings(prop));
				case GraphAdjPF.COLORBAR % __GraphAdjPF.COLORBAR__
					check = Format.checkFormat(Format.LOGICAL, value, GraphAdjPF.getPropSettings(prop));
				case GraphAdjPF.ST_AMBIENT % __GraphAdjPF.ST_AMBIENT__
					check = Format.checkFormat(Format.ITEM, value, GraphAdjPF.getPropSettings(prop));
				case GraphAdjPF.SETUP % __GraphAdjPF.SETUP__
					check = Format.checkFormat(Format.EMPTY, value, GraphAdjPF.getPropSettings(prop));
				case GraphAdjPF.H_ADJ % __GraphAdjPF.H_ADJ__
					check = Format.checkFormat(Format.HANDLE, value, GraphAdjPF.getPropSettings(prop));
				case GraphAdjPF.TEMPLATE % __GraphAdjPF.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, GraphAdjPF.getPropSettings(prop));
				otherwise
					if prop <= PanelFig.getPropNumber()
						check = checkProp@PanelFig(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GraphAdjPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GraphAdjPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GraphAdjPF.getPropTag(prop) ' (' GraphAdjPF.getFormatTag(GraphAdjPF.getPropFormat(prop)) ').'] ...
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
				case GraphAdjPF.ST_AXIS % __GraphAdjPF.ST_AXIS__
					if pf.get('DRAWN')
					    toolbar = pf.get('H_TOOLBAR');
					    if check_graphics(toolbar, 'uitoolbar')
					        set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
					        set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
					    end
					end
					
				case GraphAdjPF.LAYERS % __GraphAdjPF.LAYERS__
					pf.get('SETUP')
					
				case GraphAdjPF.LAYERLOCK % __GraphAdjPF.LAYERLOCK__
					if pf.get('LAYERLOCK')
					    layers = pf.get('LAYERS');
					    if layers(1) ~= layers(2)
					        pf.set('LAYERS', [layers(1) layers(1)])
					    end
					end
					
				case GraphAdjPF.WEIGHTED % __GraphAdjPF.WEIGHTED__
					if pf.get('DRAWN')
					    pf.get('SETUP')
					    
					    toolbar = pf.get('H_TOOLBAR');
					    if check_graphics(toolbar, 'uitoolbar')
					        set(findobj(toolbar, 'Tag', 'TOOL.Weighted'), 'State', pf.get('WEIGHTED'))
					        set(findobj(toolbar, 'Tag', 'TOOL.Binary'), 'State', ~pf.get('WEIGHTED'))
					    end
					end
					
				case GraphAdjPF.COLORBAR % __GraphAdjPF.COLORBAR__
					if pf.get('DRAWN')
					    if pf.get('COLORBAR')
					        colorbar(pf.get('H_AXES'))
					    else
					        colorbar(pf.get('H_AXES'), 'off')
					    end
					
					    toolbar = pf.get('H_TOOLBAR');
					    if check_graphics(toolbar, 'uitoolbar')
					        set(findobj(toolbar, 'Tag', 'TOOL.Colormap'), 'State', pf.get('COLORBAR'))
					    end
					end
					
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
				case GraphAdjPF.H_AXES % __GraphAdjPF.H_AXES__
					h_axes = uiaxes( ...
					    'Parent', pf.memorize('H'), ...
					    'Tag', 'H_AXES', ...
					    'Units', 'normalized', ...
					    'OuterPosition', [0 0 1 1], ...
					    'XAxisLocation', 'top', ...
						'YAxisLocation', 'left', ...
					    'YDir', 'Reverse' ...
					    );
					h_axes.Toolbar.Visible = 'off';
					h_axes.Interactions = [];
					value = h_axes;
					
				case GraphAdjPF.LISTENER_ST_AXIS % __GraphAdjPF.LISTENER_ST_AXIS__
					value = listener(pf.get('ST_AXIS'), 'PropSet', @cb_listener_st_axis);
					
				case GraphAdjPF.SETUP % __GraphAdjPF.SETUP__
					A = pf.get('G').get('A');
					if numel(A) <= 1
					    A = cell2mat(A);
					else
					    layers = pf.get('LAYERS');
					    A = A{layers(1), layers(2)};
					end
					
					row_number = size(A, 1);
					column_number = size(A, 2);
					
					pf.get('H_ADJ').set( ...
					    'XData', (0:1:column_number), ...
					    'YData', (0:1:row_number), ...
					    'ZData', [A, zeros(row_number, 1); zeros(1, column_number + 1)] ...
					    );
					
					pf.set('COLORBAR', pf.get('COLORBAR'))
					pf.get('ST_AMBIENT').get('SETUP')
					
					nodelabels = pf.get('G').get('ANODELABELS');
					if isequal(nodelabels, {'numbered'})
					    nodelabels = 'numbered';
					end
					
					set(pf.get('H_AXES'), ...
					    'XTickLabelRotation', 90, ...
					    'XTick', (1:1:column_number) - .5, ...
					    'XTickLabel', nodelabels, ...
					    'YTick', (1:1:row_number) - .5, ...    
					    'YTickLabels', nodelabels ...
					    )
					
					value = [];
					
				case GraphAdjPF.H_ADJ % __GraphAdjPF.H_ADJ__
					value = surf(pf.get('H_AXES'), [], [], []);
					
				case GraphAdjPF.DRAW % __GraphAdjPF.DRAW__
					value = calculateValue@PanelFig(pf, PanelFig.DRAW, varargin{:}); % also warning
					if value
					    pf.memorize('H_AXES')
					    
					    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', GraphAdjPF.H_AXES).get('SETUP')
					    pf.memorize('LISTENER_ST_AXIS');
					    
					    pf.memorize('ST_AMBIENT').set('PANEL', pf, 'PROP', GraphAdjPF.H_AXES).get('SETUP')
					    
					    pf.memorize('H_ADJ')
					
					    pf.get('SETUP')
					end
					
				case GraphAdjPF.DELETE % __GraphAdjPF.DELETE__
					value = calculateValue@PanelFig(pf, PanelFig.DELETE, varargin{:}); % also warning
					if value
					    pf.set('H_AXES', Element.getNoValue())
					
					    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
					    
					    pf.set('H_ADJ', Element.getNoValue())
					end
					
				case GraphAdjPF.H_TOOLS % __GraphAdjPF.H_TOOLS__
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
					    
					    % Weighted
					    tool_weighted = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Weighted', ...
					        'Separator', 'on', ...
					        'State', pf.get('WEIGHTED'), ...
					        'Tooltip', 'Show weighted adjacency matrix', ...
					        'CData', imread('icon_weighted.png'), ...
					        'OnCallback', {@cb_weighted, true}, ...
					        'OffCallback', {@cb_weighted, false});
					
					    % Binary
					    tool_binary = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Binary', ...
					        'State', ~pf.get('WEIGHTED'), ...
					        'Tooltip', 'Show binary adjacency matrix', ...
					        'CData', imread('icon_binary.png'), ...
					        'OnCallback', {@cb_weighted, false}, ...
					        'OffCallback', {@cb_weighted, true});
					
					    % Colormap
					    tool_colorbar = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Colormap', ...
					        'State', pf.get('COLORBAR'), ...
					        'Tooltip', 'Show colorbar', ... 
					        'CData', imread('icon_colorbar.png'), ...
					        'OnCallback', {@cb_colorbar, true}, ...
					        'OffCallback', {@cb_colorbar, false});
					    
					    value = {value{:}, ...
					        tool_separator_1, ...
					        tool_axis, tool_grid, ...
					        tool_separator_2, tool_weighted, tool_binary, tool_colorbar ...
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
			function cb_weighted(~, ~, weighted) % (src, event)
			    pf.set('WEIGHTED', weighted)
			end
			function cb_colorbar(~, ~, colorbar) % (src, event)
			    pf.set('COLORBAR', colorbar)
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
				case GraphAdjPF.ST_AXIS % __GraphAdjPF.ST_AXIS__
					pr = SettingsAxisPP('EL', pf, 'PROP', GraphAdjPF.ST_AXIS, varargin{:});
					
				case GraphAdjPF.LAYERS % __GraphAdjPF.LAYERS__
					pr = LayersPP('EL', pf, 'PROP', GraphAdjPF.LAYERS, ...
					    'G_PROP', GraphAdjPF.G, ...
					    varargin{:});
					
				case GraphAdjPF.ST_AMBIENT % __GraphAdjPF.ST_AMBIENT__
					pr = SettingsAmbientPP('EL', pf, 'PROP', GraphAdjPF.ST_AMBIENT, varargin{:});
					
				otherwise
					pr = getPanelProp@PanelFig(pf, prop, varargin{:});
					
			end
		end
	end
end
