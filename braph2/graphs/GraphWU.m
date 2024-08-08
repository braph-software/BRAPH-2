classdef GraphWU < Graph
	%GraphWU is a weighted undirected graph.
	% It is a subclass of <a href="matlab:help Graph">Graph</a>.
	%
	% In a weighted undirected graph (GraphWU), the edges are are undirected and associated 
	%  with a real number between 0 and 1 indicating the strength of the connection.
	% The connectivity matrix is symmetric.
	%
	% GraphWU methods (constructor):
	%  GraphWU - constructor
	%
	% GraphWU methods:
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
	% GraphWU methods (display):
	%  tostring - string with information about the weighted undirected graph
	%  disp - displays information about the weighted undirected graph
	%  tree - displays the tree of the weighted undirected graph
	%
	% GraphWU methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two weighted undirected graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the weighted undirected graph
	%
	% GraphWU methods (save/load, Static):
	%  save - saves BRAPH2 weighted undirected graph as b2 file
	%  load - loads a BRAPH2 weighted undirected graph from a b2 file
	%
	% GraphWU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the weighted undirected graph
	%
	% GraphWU method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the weighted undirected graph
	%
	% GraphWU methods (inspection, Static):
	%  getClass - returns the class of the weighted undirected graph
	%  getSubclasses - returns all subclasses of GraphWU
	%  getProps - returns the property list of the weighted undirected graph
	%  getPropNumber - returns the property number of the weighted undirected graph
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
	% GraphWU methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GraphWU methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GraphWU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GraphWU methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GraphWU; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GraphWU constants</a>.
	%
	
	properties (Constant) % properties
		B = Graph.getPropNumber() + 1;
		B_TAG = 'B';
		B_CATEGORY = Category.DATA;
		B_FORMAT = Format.SMATRIX;
		
		SYMMETRIZE_RULE = Graph.getPropNumber() + 2;
		SYMMETRIZE_RULE_TAG = 'SYMMETRIZE_RULE';
		SYMMETRIZE_RULE_CATEGORY = Category.PARAMETER;
		SYMMETRIZE_RULE_FORMAT = Format.OPTION;
		
		SEMIPOSITIVIZE_RULE = Graph.getPropNumber() + 3;
		SEMIPOSITIVIZE_RULE_TAG = 'SEMIPOSITIVIZE_RULE';
		SEMIPOSITIVIZE_RULE_CATEGORY = Category.PARAMETER;
		SEMIPOSITIVIZE_RULE_FORMAT = Format.OPTION;
		
		STANDARDIZE_RULE = Graph.getPropNumber() + 4;
		STANDARDIZE_RULE_TAG = 'STANDARDIZE_RULE';
		STANDARDIZE_RULE_CATEGORY = Category.PARAMETER;
		STANDARDIZE_RULE_FORMAT = Format.OPTION;
		
		ATTEMPTSPEREDGE = Graph.getPropNumber() + 5;
		ATTEMPTSPEREDGE_TAG = 'ATTEMPTSPEREDGE';
		ATTEMPTSPEREDGE_CATEGORY = Category.PARAMETER;
		ATTEMPTSPEREDGE_FORMAT = Format.SCALAR;
		
		NUMBEROFWEIGHTS = Graph.getPropNumber() + 6;
		NUMBEROFWEIGHTS_TAG = 'NUMBEROFWEIGHTS';
		NUMBEROFWEIGHTS_CATEGORY = Category.PARAMETER;
		NUMBEROFWEIGHTS_FORMAT = Format.SCALAR;
		
		RANDOMIZATION = Graph.getPropNumber() + 7;
		RANDOMIZATION_TAG = 'RANDOMIZATION';
		RANDOMIZATION_CATEGORY = Category.QUERY;
		RANDOMIZATION_FORMAT = Format.CELL;
	end
	methods % constructor
		function g = GraphWU(varargin)
			%GraphWU() creates a weighted undirected graph.
			%
			% GraphWU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GraphWU(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			g = g@Graph(varargin{:});
		end
	end
	methods (Static) % inspection
		function g_class = getClass()
			%GETCLASS returns the class of the weighted undirected graph.
			%
			% CLASS = GraphWU.GETCLASS() returns the class 'GraphWU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the weighted undirected graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('GraphWU') returns 'GraphWU'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('GraphWU')
			%  are less computationally efficient.
			
			g_class = 'GraphWU';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the weighted undirected graph.
			%
			% LIST = GraphWU.GETSUBCLASSES() returns all subclasses of 'GraphWU'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the weighted undirected graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('GraphWU') returns all subclasses of 'GraphWU'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('GraphWU')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GraphWU', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of weighted undirected graph.
			%
			% PROPS = GraphWU.GETPROPS() returns the property list of weighted undirected graph
			%  as a row vector.
			%
			% PROPS = GraphWU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the weighted undirected graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('GraphWU'[, CATEGORY]) returns the property list of 'GraphWU'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('GraphWU')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Graph.getProps() ...
						GraphWU.B ...
						GraphWU.SYMMETRIZE_RULE ...
						GraphWU.SEMIPOSITIVIZE_RULE ...
						GraphWU.STANDARDIZE_RULE ...
						GraphWU.ATTEMPTSPEREDGE ...
						GraphWU.NUMBEROFWEIGHTS ...
						GraphWU.RANDOMIZATION ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Graph.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Graph.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Graph.getProps(Category.PARAMETER) ...
						GraphWU.SYMMETRIZE_RULE ...
						GraphWU.SEMIPOSITIVIZE_RULE ...
						GraphWU.STANDARDIZE_RULE ...
						GraphWU.ATTEMPTSPEREDGE ...
						GraphWU.NUMBEROFWEIGHTS ...
						];
				case Category.DATA
					prop_list = [ ...
						Graph.getProps(Category.DATA) ...
						GraphWU.B ...
						];
				case Category.RESULT
					prop_list = [
						Graph.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Graph.getProps(Category.QUERY) ...
						GraphWU.RANDOMIZATION ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Graph.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Graph.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Graph.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of weighted undirected graph.
			%
			% N = GraphWU.GETPROPNUMBER() returns the property number of weighted undirected graph.
			%
			% N = GraphWU.GETPROPNUMBER(CATEGORY) returns the property number of weighted undirected graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the weighted undirected graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('GraphWU') returns the property number of 'GraphWU'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('GraphWU')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GraphWU.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in weighted undirected graph/error.
			%
			% CHECK = GraphWU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(GraphWU, PROP) checks whether PROP exists for GraphWU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GraphWU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:GraphWU:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:GraphWU:WrongInput]
			%  Element.EXISTSPROP(GraphWU, PROP) throws error if PROP does NOT exist for GraphWU.
			%   Error id: [BRAPH2:GraphWU:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('GraphWU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GraphWU.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GraphWU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GraphWU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GraphWU.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in weighted undirected graph/error.
			%
			% CHECK = GraphWU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(GraphWU, TAG) checks whether TAG exists for GraphWU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GraphWU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:GraphWU:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:GraphWU:WrongInput]
			%  Element.EXISTSTAG(GraphWU, TAG) throws error if TAG does NOT exist for GraphWU.
			%   Error id: [BRAPH2:GraphWU:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('GraphWU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			graphwu_tag_list = cellfun(@(x) GraphWU.getPropTag(x), num2cell(GraphWU.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, graphwu_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GraphWU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GraphWU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GraphWU.'] ...
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
			%  PROPERTY = G.GETPROPPROP(POINTER) returns property number of POINTER of G.
			%  PROPERTY = Element.GETPROPPROP(GraphWU, POINTER) returns property number of POINTER of GraphWU.
			%  PROPERTY = G.GETPROPPROP(GraphWU, POINTER) returns property number of POINTER of GraphWU.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('GraphWU')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				graphwu_tag_list = cellfun(@(x) GraphWU.getPropTag(x), num2cell(GraphWU.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, graphwu_tag_list)); % tag = pointer
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
			%  TAG = G.GETPROPTAG(POINTER) returns tag of POINTER of G.
			%  TAG = Element.GETPROPTAG(GraphWU, POINTER) returns tag of POINTER of GraphWU.
			%  TAG = G.GETPROPTAG(GraphWU, POINTER) returns tag of POINTER of GraphWU.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('GraphWU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case GraphWU.B
						tag = GraphWU.B_TAG;
					case GraphWU.SYMMETRIZE_RULE
						tag = GraphWU.SYMMETRIZE_RULE_TAG;
					case GraphWU.SEMIPOSITIVIZE_RULE
						tag = GraphWU.SEMIPOSITIVIZE_RULE_TAG;
					case GraphWU.STANDARDIZE_RULE
						tag = GraphWU.STANDARDIZE_RULE_TAG;
					case GraphWU.ATTEMPTSPEREDGE
						tag = GraphWU.ATTEMPTSPEREDGE_TAG;
					case GraphWU.NUMBEROFWEIGHTS
						tag = GraphWU.NUMBEROFWEIGHTS_TAG;
					case GraphWU.RANDOMIZATION
						tag = GraphWU.RANDOMIZATION_TAG;
					otherwise
						tag = getPropTag@Graph(prop);
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
			%  CATEGORY = G.GETPROPCATEGORY(POINTER) returns category of POINTER of G.
			%  CATEGORY = Element.GETPROPCATEGORY(GraphWU, POINTER) returns category of POINTER of GraphWU.
			%  CATEGORY = G.GETPROPCATEGORY(GraphWU, POINTER) returns category of POINTER of GraphWU.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('GraphWU')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GraphWU.getPropProp(pointer);
			
			switch prop
				case GraphWU.B
					prop_category = GraphWU.B_CATEGORY;
				case GraphWU.SYMMETRIZE_RULE
					prop_category = GraphWU.SYMMETRIZE_RULE_CATEGORY;
				case GraphWU.SEMIPOSITIVIZE_RULE
					prop_category = GraphWU.SEMIPOSITIVIZE_RULE_CATEGORY;
				case GraphWU.STANDARDIZE_RULE
					prop_category = GraphWU.STANDARDIZE_RULE_CATEGORY;
				case GraphWU.ATTEMPTSPEREDGE
					prop_category = GraphWU.ATTEMPTSPEREDGE_CATEGORY;
				case GraphWU.NUMBEROFWEIGHTS
					prop_category = GraphWU.NUMBEROFWEIGHTS_CATEGORY;
				case GraphWU.RANDOMIZATION
					prop_category = GraphWU.RANDOMIZATION_CATEGORY;
				otherwise
					prop_category = getPropCategory@Graph(prop);
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
			%  FORMAT = G.GETPROPFORMAT(POINTER) returns format of POINTER of G.
			%  FORMAT = Element.GETPROPFORMAT(GraphWU, POINTER) returns format of POINTER of GraphWU.
			%  FORMAT = G.GETPROPFORMAT(GraphWU, POINTER) returns format of POINTER of GraphWU.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('GraphWU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GraphWU.getPropProp(pointer);
			
			switch prop
				case GraphWU.B
					prop_format = GraphWU.B_FORMAT;
				case GraphWU.SYMMETRIZE_RULE
					prop_format = GraphWU.SYMMETRIZE_RULE_FORMAT;
				case GraphWU.SEMIPOSITIVIZE_RULE
					prop_format = GraphWU.SEMIPOSITIVIZE_RULE_FORMAT;
				case GraphWU.STANDARDIZE_RULE
					prop_format = GraphWU.STANDARDIZE_RULE_FORMAT;
				case GraphWU.ATTEMPTSPEREDGE
					prop_format = GraphWU.ATTEMPTSPEREDGE_FORMAT;
				case GraphWU.NUMBEROFWEIGHTS
					prop_format = GraphWU.NUMBEROFWEIGHTS_FORMAT;
				case GraphWU.RANDOMIZATION
					prop_format = GraphWU.RANDOMIZATION_FORMAT;
				otherwise
					prop_format = getPropFormat@Graph(prop);
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
			%  DESCRIPTION = G.GETPROPDESCRIPTION(POINTER) returns description of POINTER of G.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GraphWU, POINTER) returns description of POINTER of GraphWU.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(GraphWU, POINTER) returns description of POINTER of GraphWU.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('GraphWU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GraphWU.getPropProp(pointer);
			
			switch prop
				case GraphWU.B
					prop_description = 'B (data, smatrix) is the input graph adjacency matrix.';
				case GraphWU.SYMMETRIZE_RULE
					prop_description = 'SYMMETRIZE_RULE (parameter, option) determines how to symmetrize the matrix.';
				case GraphWU.SEMIPOSITIVIZE_RULE
					prop_description = 'SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.';
				case GraphWU.STANDARDIZE_RULE
					prop_description = 'STANDARDIZE_RULE (parameter, option) determines how to normalize the weights between 0 and 1.';
				case GraphWU.ATTEMPTSPEREDGE
					prop_description = 'ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.';
				case GraphWU.NUMBEROFWEIGHTS
					prop_description = 'NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.';
				case GraphWU.RANDOMIZATION
					prop_description = 'RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.';
				case GraphWU.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the weighted undirected graph.';
				case GraphWU.NAME
					prop_description = 'NAME (constant, string) is the name of the weighted undirected graph.';
				case GraphWU.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the weighted undirected graph.';
				case GraphWU.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the weighted undirected graph.';
				case GraphWU.ID
					prop_description = 'ID (data, string) is a few-letter code for the weighted undirected graph.';
				case GraphWU.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the weighted undirected graph.';
				case GraphWU.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the weighted undirected graph.';
				case GraphWU.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) returns the graph type __Graph.GRAPH__.';
				case GraphWU.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.WEIGHTED__.';
				case GraphWU.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__.';
				case GraphWU.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__.';
				case GraphWU.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__.';
				case GraphWU.A
					prop_description = 'A (result, cell) is the symmetric non-negative adjacency matrix of the weighted undirected graph.';
				case GraphWU.COMPATIBLE_MEASURES
					prop_description = 'COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.';
				otherwise
					prop_description = getPropDescription@Graph(prop);
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
			%  SETTINGS = G.GETPROPSETTINGS(POINTER) returns settings of POINTER of G.
			%  SETTINGS = Element.GETPROPSETTINGS(GraphWU, POINTER) returns settings of POINTER of GraphWU.
			%  SETTINGS = G.GETPROPSETTINGS(GraphWU, POINTER) returns settings of POINTER of GraphWU.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('GraphWU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GraphWU.getPropProp(pointer);
			
			switch prop
				case GraphWU.B
					prop_settings = Format.getFormatSettings(Format.SMATRIX);
				case GraphWU.SYMMETRIZE_RULE
					prop_settings = {'max', 'sum', 'average', 'min'};
				case GraphWU.SEMIPOSITIVIZE_RULE
					prop_settings = {'zero', 'absolute'};
				case GraphWU.STANDARDIZE_RULE
					prop_settings = {'threshold' 'range'};
				case GraphWU.ATTEMPTSPEREDGE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case GraphWU.NUMBEROFWEIGHTS
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case GraphWU.RANDOMIZATION
					prop_settings = Format.getFormatSettings(Format.CELL);
				case GraphWU.TEMPLATE
					prop_settings = 'GraphWU';
				otherwise
					prop_settings = getPropSettings@Graph(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GraphWU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GraphWU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(GraphWU, POINTER) returns the default value of POINTER of GraphWU.
			%  DEFAULT = G.GETPROPDEFAULT(GraphWU, POINTER) returns the default value of POINTER of GraphWU.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('GraphWU')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GraphWU.getPropProp(pointer);
			
			switch prop
				case GraphWU.B
					prop_default = Format.getFormatDefault(Format.SMATRIX, GraphWU.getPropSettings(prop));
				case GraphWU.SYMMETRIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, GraphWU.getPropSettings(prop));
				case GraphWU.SEMIPOSITIVIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, GraphWU.getPropSettings(prop));
				case GraphWU.STANDARDIZE_RULE
					prop_default = Format.getFormatDefault(Format.OPTION, GraphWU.getPropSettings(prop));
				case GraphWU.ATTEMPTSPEREDGE
					prop_default = 5;
				case GraphWU.NUMBEROFWEIGHTS
					prop_default = 10;
				case GraphWU.RANDOMIZATION
					prop_default = Format.getFormatDefault(Format.CELL, GraphWU.getPropSettings(prop));
				case GraphWU.ELCLASS
					prop_default = 'GraphWU';
				case GraphWU.NAME
					prop_default = 'Graph Weighted Undirected';
				case GraphWU.DESCRIPTION
					prop_default = 'In a weighted undirected graph (GraphWU), the edges are are undirected and associated with a real number between 0 and 1 indicating the strength of the connection. The connectivity matrix is symmetric.';
				case GraphWU.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, GraphWU.getPropSettings(prop));
				case GraphWU.ID
					prop_default = 'GraphWU ID';
				case GraphWU.LABEL
					prop_default = 'GraphWU label';
				case GraphWU.NOTES
					prop_default = 'GraphWU notes';
				case GraphWU.GRAPH_TYPE
					prop_default = Graph.GRAPH;
				case GraphWU.COMPATIBLE_MEASURES
					prop_default = getCompatibleMeasures('GraphWU');
				otherwise
					prop_default = getPropDefault@Graph(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GraphWU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GraphWU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GraphWU, POINTER) returns the conditioned default value of POINTER of GraphWU.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(GraphWU, POINTER) returns the conditioned default value of POINTER of GraphWU.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('GraphWU')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GraphWU.getPropProp(pointer);
			
			prop_default = GraphWU.conditioning(prop, GraphWU.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = G.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = G.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of G.
			%  CHECK = Element.CHECKPROP(GraphWU, PROP, VALUE) checks VALUE format for PROP of GraphWU.
			%  CHECK = G.CHECKPROP(GraphWU, PROP, VALUE) checks VALUE format for PROP of GraphWU.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GraphWU:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:GraphWU:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GraphWU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GraphWU.
			%   Error id: €BRAPH2.STR€:GraphWU:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(GraphWU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GraphWU.
			%   Error id: €BRAPH2.STR€:GraphWU:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('GraphWU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GraphWU.getPropProp(pointer);
			
			switch prop
				case GraphWU.B % __GraphWU.B__
					check = Format.checkFormat(Format.SMATRIX, value, GraphWU.getPropSettings(prop));
				case GraphWU.SYMMETRIZE_RULE % __GraphWU.SYMMETRIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, GraphWU.getPropSettings(prop));
				case GraphWU.SEMIPOSITIVIZE_RULE % __GraphWU.SEMIPOSITIVIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, GraphWU.getPropSettings(prop));
				case GraphWU.STANDARDIZE_RULE % __GraphWU.STANDARDIZE_RULE__
					check = Format.checkFormat(Format.OPTION, value, GraphWU.getPropSettings(prop));
				case GraphWU.ATTEMPTSPEREDGE % __GraphWU.ATTEMPTSPEREDGE__
					check = Format.checkFormat(Format.SCALAR, value, GraphWU.getPropSettings(prop));
				case GraphWU.NUMBEROFWEIGHTS % __GraphWU.NUMBEROFWEIGHTS__
					check = Format.checkFormat(Format.SCALAR, value, GraphWU.getPropSettings(prop));
				case GraphWU.RANDOMIZATION % __GraphWU.RANDOMIZATION__
					check = Format.checkFormat(Format.CELL, value, GraphWU.getPropSettings(prop));
				case GraphWU.TEMPLATE % __GraphWU.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, GraphWU.getPropSettings(prop));
				otherwise
					if prop <= Graph.getPropNumber()
						check = checkProp@Graph(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GraphWU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GraphWU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GraphWU.getPropTag(prop) ' (' GraphWU.getFormatTag(GraphWU.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(g, prop, varargin)
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
				case GraphWU.RANDOMIZATION % __GraphWU.RANDOMIZATION__
					rng(g.get('RANDOM_SEED'), 'twister')
					
					if isempty(varargin)
					    value = {};
					    return
					end
					
					A = cell2mat(varargin{1});
					
					if g.get('GRAPH_TYPE') ~= 1
					    value = A;
					    return;
					end
					
					attempts_per_edge = g.get('ATTEMPTSPEREDGE');
					number_of_weights = g.get('NUMBEROFWEIGHTS');
					
					W = A;  % swaps with A
					tmp_g = GraphBU('ATTEMPTSPEREDGE', attempts_per_edge);
					W = tmp_g.get('RANDOMIZATION', {W});
					
					% remove self connections
					W(1:length(W)+1:numel(W)) = 0;
					W_bin = W > 0;
					N = size(W,1); % number of nodes
					random_A = zeros(N); % intialize null model matrix
					
					S = sum(W,2); % nodal strength
					W_sorted = sort(W(triu(W_bin))); % sorted weights vector
					% find all the edges
					[I_edges, J_edges] = find(triu(W));
					edges = I_edges + (J_edges-1)*N;
					% expected weights matrix
					P = (S*S.');
					
					for m = numel(W_sorted):-number_of_weights:1
					
					    % sort the expected weights matrix
					    [~, ind] = sort(P(edges));
					
					    % random index of sorted expected weight
					    selected_indices = randperm(m, min(m,number_of_weights)).';
					    selected_edges = ind(selected_indices);
					
					    % assign corresponding sorted weight at this index
					    random_A(edges(selected_edges)) = W_sorted(selected_indices);
					
					    % recalculate expected weight for node I_edges(selected_edge)
					    % cumulative weight
					    WA = accumarray([I_edges(selected_edges); J_edges(selected_edges)], W_sorted([selected_indices; selected_indices]), [N,1]);
					    IJu = any(WA,2);
					    F = 1 - WA(IJu)./S(IJu);
					    F = F(:,ones(1,N));
					    % readjust expected weight probabilities
					    P(IJu,:) = P(IJu,:).*F;
					    P(:,IJu) = P(:,IJu).*F.';
					    % re-adjust strengths
					    S(IJu) = S(IJu) - WA(IJu);
					
					    % remove the edge/weight from further consideration
					    selected_edges = ind(selected_indices);
					    edges(selected_edges) = [];
					    I_edges(selected_edges) = [];
					    J_edges(selected_edges) = [];
					    W_sorted(selected_indices) = [];
					end
					
					% calculate the final matrix
					random_A = (random_A + transpose(random_A))/2;
					
					% calculate correlation of original vs reassinged strength
					% rpos = corrcoef(sum(W), sum(random_A));
					% correlation_coefficients = rpos(2);
					value = random_A;
					
				case GraphWU.CONNECTIVITY_TYPE % __GraphWU.CONNECTIVITY_TYPE__
					value = Graph.WEIGHTED;
					
				case GraphWU.DIRECTIONALITY_TYPE % __GraphWU.DIRECTIONALITY_TYPE__
					value = Graph.UNDIRECTED;
					
				case GraphWU.SELFCONNECTIVITY_TYPE % __GraphWU.SELFCONNECTIVITY_TYPE__
					value = Graph.NONSELFCONNECTED;
					
				case GraphWU.NEGATIVITY_TYPE % __GraphWU.NEGATIVITY_TYPE__
					value = Graph.NONNEGATIVE;
					
				case GraphWU.A % __GraphWU.A__
					rng_settings_ = rng(); rng(g.getPropSeed(GraphWU.A), 'twister')
					
					B = g.get('B'); %#ok<PROPLC>
					
					B = symmetrize(B, 'SymmetrizeRule', g.get('SYMMETRIZE_RULE')); %#ok<PROPLC> % enforces symmetry of adjacency matrix
					B = dediagonalize(B); %#ok<PROPLC> % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(B, 'DediagonalizeRule', 0)
					B = semipositivize(B, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); %#ok<PROPLC> % removes negative weights
					B = standardize(B, 'StandardizeRule', g.get('STANDARDIZE_RULE')); %#ok<PROPLC> % ensures all weights are between 0 and 1
					
					A = {B}; %#ok<PROPLC>
					
					if g.get('GRAPH_TYPE') ~= 1
					
					else
					    if g.get('RANDOMIZE')
					        random_A = g.get('RANDOMIZATION', A);
					        A = {random_A};
					    end
					end
					value = A;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Graph.getPropNumber()
						value = calculateValue@Graph(g, prop, varargin{:});
					else
						value = calculateValue@Element(g, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(g, prop, varargin)
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
				case GraphWU.B % __GraphWU.B__
					pr = PanelPropMatrix('EL', g, 'PROP', GraphWU.B, ...
					    'TABLE_HEIGHT', s(40), ...    
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				case GraphWU.A % __GraphWU.A__
					pr = PanelPropCell('EL', g, 'PROP', GraphWU.A, ...
					    'TABLE_HEIGHT', s(40), ...
					    'XSLIDERSHOW', false, ...
					    'YSLIDERSHOW', false, ...
					    'ROWNAME', g.getCallback('ANODELABELS'), ...
					    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@Graph(g, prop, varargin{:});
					
			end
		end
	end
end
