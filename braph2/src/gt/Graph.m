classdef Graph < ConcreteElement
	%Graph is a graph.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Graph provides the methods necessary for all graphs.
	%  Instances of this class should not be created. 
	%  Use one of its subclasses instead.
	% 
	% The kinds of graphs are:
	%  
	%  Graph.GRAPH. <strong>€Graph.GRAPH_NAME€</strong>: €Graph.GRAPH_DESCRIPTION€
	% 
	%  Graph.MULTIGRAPH. <strong>€Graph.MULTIGRAPH_NAME€</strong>: €Graph.MULTIGRAPH_DESCRIPTION€
	%  
	%  Graph.ORDERED_MULTIPLEX. <strong>€Graph.ORDERED_MULTIPLEX_NAME€</strong>: €Graph.ORDERED_MULTIPLEX_DESCRIPTION€
	% 
	%  Graph.MULTIPLEX. <strong>€Graph.MULTIPLEX_NAME€</strong>: €Graph.MULTIPLEX_DESCRIPTION€
	% 
	%  Graph.ORDERED_MULTILAYER. <strong>€Graph.ORDERED_MULTILAYER_NAME€</strong>: €Graph.ORDERED_MULTILAYER_DESCRIPTION€
	% 
	%  Graph.MULTILAYER. <strong>€Graph.MULTILAYER_NAME€</strong>: €Graph.MULTILAYER_DESCRIPTION€
	%
	% Graph methods (constructor):
	%  Graph - constructor
	%
	% Graph methods:
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
	% Graph methods (display):
	%  tostring - string with information about the graph
	%  disp - displays information about the graph
	%  tree - displays the tree of the graph
	%
	% Graph methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graph are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graph
	%
	% Graph methods (save/load, Static):
	%  save - saves BRAPH2 graph as b2 file
	%  load - loads a BRAPH2 graph from a b2 file
	%
	% Graph method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graph
	%
	% Graph method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graph
	%
	% Graph methods (inspection, Static):
	%  getClass - returns the class of the graph
	%  getSubclasses - returns all subclasses of Graph
	%  getProps - returns the property list of the graph
	%  getPropNumber - returns the property number of the graph
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
	% Graph methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Graph methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Graph methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Graph methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Graph; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Graph constants</a>.
	%
	%
	% See also Measure.
	
	properties (Constant) % constants
		% Graph types
		GRAPH = 1
		GRAPH_NAME = 'Graph'
		GRAPH_DESCRIPTION = 'A graph consists of a single layer.'
		
		MULTIGRAPH = 2
		MULTIGRAPH_NAME = 'Multigraph'
		MULTIGRAPH_DESCRIPTION = 'A multigraph consists of multiple unconnected layers.'
		
		ORDERED_MULTIPLEX = 3
		ORDERED_MULTIPLEX_NAME = 'Ordered Multipex'
		ORDERED_MULTIPLEX_DESCRIPTION = ['An ordered multiplex consists of ' ...
		    'a sequence of layers with ordinal connections' ...
		    'between corresponding nodes in subsequent layers.']
		
		MULTIPLEX = 4
		MULTIPLEX_NAME = 'Multiplex'
		MULTIPLEX_DESCRIPTION = ['A multiplex consists of ' ...
		    'multiple layers with categorical connections ' ...
		    'between corresponding nodes in different layers.']
		
		ORDERED_MULTILAYER = 5
		ORDERED_MULTILAYER_NAME = 'Ordered Multilayer'
		ORDERED_MULTILAYER_DESCRIPTION = ['An ordered multilayer consists of ' ...
		    'multiple layers with ordinal connections between any nodes.']
		
		MULTILAYER = 6
		MULTILAYER_NAME = 'Multilayer'
		MULTILAYER_DESCRIPTION = ['A multilayer consists of ' ...
		    'multiple layers with categorical between any nodes.']
		
		TYPE_NUMBER = 6
		
		TYPE_NAME = {
		    Graph.GRAPH_NAME
		    Graph.MULTIGRAPH_NAME
		    Graph.ORDERED_MULTIPLEX_NAME
		    Graph.MULTIPLEX_NAME
		    Graph.ORDERED_MULTILAYER_NAME
		    Graph.MULTILAYER_NAME
		    }
		
		TYPE_DESCRIPTION = {
		    Graph.GRAPH_DESCRIPTION
		    Graph.MULTIGRAPH_DESCRIPTION
		    Graph.ORDERED_MULTIPLEX_DESCRIPTION
		    Graph.MULTIPLEX_DESCRIPTION
		    Graph.ORDERED_MULTILAYER_DESCRIPTION
		    Graph.MULTILAYER_DESCRIPTION
		    }
		
		% Connectivity types
		WEIGHTED = 1
		WEIGHTED_NAME = 'Weighted'
		WEIGHTED_DESCRIPTION = 'Graph with weighted connections.'
		
		BINARY = 2
		BINARY_NAME = 'Binary'
		BINARY_DESCRIPTION = 'Graph with binary (0 or 1) connections.'
		
		CONNECTIVITY_TYPE_NUMBER = 2
		
		CONNECTIVITY_TYPE_NAME = {
		    Graph.WEIGHTED_NAME
		    Graph.BINARY_NAME
		    }
		
		CONNECTIVITY_TYPE_DESCRIPTION = {
		    Graph.WEIGHTED_DESCRIPTION
		    Graph.BINARY_DESCRIPTION
		    }
		
		% Directionality types
		DIRECTED = 1
		DIRECTED_NAME = 'Directed'
		DIRECTED_DESCRIPTION = 'Graph with directed edges.'
		
		UNDIRECTED = 2
		UNDIRECTED_NAME = 'Undirected'
		UNDIRECTED_DESCRIPTION = 'Graph with undirected edges.'
		
		DIRECTIONALITY_TYPE_NUMBER = 2
		
		DIRECTIONALITY_TYPE_NAME = {
		    Graph.DIRECTED_NAME
		    Graph.UNDIRECTED_NAME
		    }
		
		DIRECTIONALITY_TYPE_DESCRIPTION = {
		    Graph.DIRECTED_DESCRIPTION
		    Graph.UNDIRECTED_DESCRIPTION
		    }
		
		% Selfconnectedness types
		NONSELFCONNECTED = 1
		NONSELFCONNECTED_NAME = 'Non-self-connected'
		NONSELFCONNECTED_DESCRIPTION = 'Graph without self-connections.';
		
		SELFCONNECTED = 2
		SELFCONNECTED_NAME = 'Self-connected'
		SELFCONNECTED_DESCRIPTION = 'Graph with self-connections.';
		
		SELFCONNECTIVITY_TYPE_NUMBER = 2
		
		SELFCONNECTIVITY_TYPE_NAME = {
		    Graph.NONSELFCONNECTED_NAME
		    Graph.SELFCONNECTED_NAME
		    }
		
		SELFCONNECTIVITY_TYPE_DESCRIPTION = {
		    Graph.NONSELFCONNECTED_DESCRIPTION
		    Graph.SELFCONNECTED_DESCRIPTION
		    }
		
		% Negativity
		NONNEGATIVE = 1
		NONNEGATIVE_NAME = 'Non-negative';
		NONNEGATIVE_DESCRIPTION = 'Graph without negative edges.';
		
		NEGATIVE = 2
		NEGATIVE_NAME = 'Negative';
		NEGATIVE_DESCRIPTION = 'Graph allowing negative edges.';
		
		NEGATIVITY_TYPE_NUMBER = 2
		
		NEGATIVITY_TYPE_NAME = {
		    Graph.NONNEGATIVE_NAME
		    Graph.NEGATIVE_NAME
		    }
		
		NEGATIVITY_TYPE_DESCRIPTION = {
		    Graph.NONNEGATIVE_DESCRIPTION
		    Graph.NEGATIVE_DESCRIPTION
		    }
	end
	properties (Constant) % properties
		GRAPH_TYPE = ConcreteElement.getPropNumber() + 1;
		GRAPH_TYPE_TAG = 'GRAPH_TYPE';
		GRAPH_TYPE_CATEGORY = Category.CONSTANT;
		GRAPH_TYPE_FORMAT = Format.SCALAR;
		
		CONNECTIVITY_TYPE = ConcreteElement.getPropNumber() + 2;
		CONNECTIVITY_TYPE_TAG = 'CONNECTIVITY_TYPE';
		CONNECTIVITY_TYPE_CATEGORY = Category.QUERY;
		CONNECTIVITY_TYPE_FORMAT = Format.SMATRIX;
		
		DIRECTIONALITY_TYPE = ConcreteElement.getPropNumber() + 3;
		DIRECTIONALITY_TYPE_TAG = 'DIRECTIONALITY_TYPE';
		DIRECTIONALITY_TYPE_CATEGORY = Category.QUERY;
		DIRECTIONALITY_TYPE_FORMAT = Format.SMATRIX;
		
		SELFCONNECTIVITY_TYPE = ConcreteElement.getPropNumber() + 4;
		SELFCONNECTIVITY_TYPE_TAG = 'SELFCONNECTIVITY_TYPE';
		SELFCONNECTIVITY_TYPE_CATEGORY = Category.QUERY;
		SELFCONNECTIVITY_TYPE_FORMAT = Format.SMATRIX;
		
		NEGATIVITY_TYPE = ConcreteElement.getPropNumber() + 5;
		NEGATIVITY_TYPE_TAG = 'NEGATIVITY_TYPE';
		NEGATIVITY_TYPE_CATEGORY = Category.QUERY;
		NEGATIVITY_TYPE_FORMAT = Format.SCALAR;
		
		LAYERTICKS = ConcreteElement.getPropNumber() + 6;
		LAYERTICKS_TAG = 'LAYERTICKS';
		LAYERTICKS_CATEGORY = Category.METADATA;
		LAYERTICKS_FORMAT = Format.RVECTOR;
		
		ALAYERTICKS = ConcreteElement.getPropNumber() + 7;
		ALAYERTICKS_TAG = 'ALAYERTICKS';
		ALAYERTICKS_CATEGORY = Category.QUERY;
		ALAYERTICKS_FORMAT = Format.RVECTOR;
		
		LAYERLABELS = ConcreteElement.getPropNumber() + 8;
		LAYERLABELS_TAG = 'LAYERLABELS';
		LAYERLABELS_CATEGORY = Category.METADATA;
		LAYERLABELS_FORMAT = Format.STRINGLIST;
		
		ALAYERLABELS = ConcreteElement.getPropNumber() + 9;
		ALAYERLABELS_TAG = 'ALAYERLABELS';
		ALAYERLABELS_CATEGORY = Category.QUERY;
		ALAYERLABELS_FORMAT = Format.STRINGLIST;
		
		PARTITIONTICKS = ConcreteElement.getPropNumber() + 10;
		PARTITIONTICKS_TAG = 'PARTITIONTICKS';
		PARTITIONTICKS_CATEGORY = Category.METADATA;
		PARTITIONTICKS_FORMAT = Format.RVECTOR;
		
		APARTITIONTICKS = ConcreteElement.getPropNumber() + 11;
		APARTITIONTICKS_TAG = 'APARTITIONTICKS';
		APARTITIONTICKS_CATEGORY = Category.QUERY;
		APARTITIONTICKS_FORMAT = Format.RVECTOR;
		
		PARTITIONLABELS = ConcreteElement.getPropNumber() + 12;
		PARTITIONLABELS_TAG = 'PARTITIONLABELS';
		PARTITIONLABELS_CATEGORY = Category.METADATA;
		PARTITIONLABELS_FORMAT = Format.STRINGLIST;
		
		APARTITIONLABELS = ConcreteElement.getPropNumber() + 13;
		APARTITIONLABELS_TAG = 'APARTITIONLABELS';
		APARTITIONLABELS_CATEGORY = Category.QUERY;
		APARTITIONLABELS_FORMAT = Format.STRINGLIST;
		
		NODELABELS = ConcreteElement.getPropNumber() + 14;
		NODELABELS_TAG = 'NODELABELS';
		NODELABELS_CATEGORY = Category.METADATA;
		NODELABELS_FORMAT = Format.STRINGLIST;
		
		ANODELABELS = ConcreteElement.getPropNumber() + 15;
		ANODELABELS_TAG = 'ANODELABELS';
		ANODELABELS_CATEGORY = Category.QUERY;
		ANODELABELS_FORMAT = Format.STRINGLIST;
		
		RANDOMIZE = ConcreteElement.getPropNumber() + 16;
		RANDOMIZE_TAG = 'RANDOMIZE';
		RANDOMIZE_CATEGORY = Category.PARAMETER;
		RANDOMIZE_FORMAT = Format.LOGICAL;
		
		RANDOM_SEED = ConcreteElement.getPropNumber() + 17;
		RANDOM_SEED_TAG = 'RANDOM_SEED';
		RANDOM_SEED_CATEGORY = Category.PARAMETER;
		RANDOM_SEED_FORMAT = Format.SCALAR;
		
		A = ConcreteElement.getPropNumber() + 18;
		A_TAG = 'A';
		A_CATEGORY = Category.RESULT;
		A_FORMAT = Format.CELL;
		
		A_CHECK = ConcreteElement.getPropNumber() + 19;
		A_CHECK_TAG = 'A_CHECK';
		A_CHECK_CATEGORY = Category.QUERY;
		A_CHECK_FORMAT = Format.LOGICAL;
		
		NODENUMBER = ConcreteElement.getPropNumber() + 20;
		NODENUMBER_TAG = 'NODENUMBER';
		NODENUMBER_CATEGORY = Category.RESULT;
		NODENUMBER_FORMAT = Format.RVECTOR;
		
		LAYERNUMBER = ConcreteElement.getPropNumber() + 21;
		LAYERNUMBER_TAG = 'LAYERNUMBER';
		LAYERNUMBER_CATEGORY = Category.RESULT;
		LAYERNUMBER_FORMAT = Format.SCALAR;
		
		PARTITIONS = ConcreteElement.getPropNumber() + 22;
		PARTITIONS_TAG = 'PARTITIONS';
		PARTITIONS_CATEGORY = Category.RESULT;
		PARTITIONS_FORMAT = Format.RVECTOR;
		
		M_DICT = ConcreteElement.getPropNumber() + 23;
		M_DICT_TAG = 'M_DICT';
		M_DICT_CATEGORY = Category.RESULT;
		M_DICT_FORMAT = Format.IDICT;
		
		COMPATIBLE_MEASURES = ConcreteElement.getPropNumber() + 24;
		COMPATIBLE_MEASURES_TAG = 'COMPATIBLE_MEASURES';
		COMPATIBLE_MEASURES_CATEGORY = Category.CONSTANT;
		COMPATIBLE_MEASURES_FORMAT = Format.CLASSLIST;
		
		MEASURE = ConcreteElement.getPropNumber() + 25;
		MEASURE_TAG = 'MEASURE';
		MEASURE_CATEGORY = Category.QUERY;
		MEASURE_FORMAT = Format.ITEM;
		
		PFGA = ConcreteElement.getPropNumber() + 26;
		PFGA_TAG = 'PFGA';
		PFGA_CATEGORY = Category.GUI;
		PFGA_FORMAT = Format.ITEM;
		
		PFGH = ConcreteElement.getPropNumber() + 27;
		PFGH_TAG = 'PFGH';
		PFGH_CATEGORY = Category.GUI;
		PFGH_FORMAT = Format.ITEM;
	end
	methods % constructor
		function g = Graph(varargin)
			%Graph() creates a graph.
			%
			% Graph(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Graph(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			g = g@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function g_class = getClass()
			%GETCLASS returns the class of the graph.
			%
			% CLASS = Graph.GETCLASS() returns the class 'Graph'.
			%
			% Alternative forms to call this method are:
			%  CLASS = G.GETCLASS() returns the class of the graph G.
			%  CLASS = Element.GETCLASS(G) returns the class of 'G'.
			%  CLASS = Element.GETCLASS('Graph') returns 'Graph'.
			%
			% Note that the Element.GETCLASS(G) and Element.GETCLASS('Graph')
			%  are less computationally efficient.
			
			g_class = 'Graph';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graph.
			%
			% LIST = Graph.GETSUBCLASSES() returns all subclasses of 'Graph'.
			%
			% Alternative forms to call this method are:
			%  LIST = G.GETSUBCLASSES() returns all subclasses of the graph G.
			%  LIST = Element.GETSUBCLASSES(G) returns all subclasses of 'G'.
			%  LIST = Element.GETSUBCLASSES('Graph') returns all subclasses of 'Graph'.
			%
			% Note that the Element.GETSUBCLASSES(G) and Element.GETSUBCLASSES('Graph')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('Graph', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph.
			%
			% PROPS = Graph.GETPROPS() returns the property list of graph
			%  as a row vector.
			%
			% PROPS = Graph.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('Graph'[, CATEGORY]) returns the property list of 'Graph'.
			%
			% Note that the Element.GETPROPS(G) and Element.GETPROPS('Graph')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						Graph.GRAPH_TYPE ...
						Graph.CONNECTIVITY_TYPE ...
						Graph.DIRECTIONALITY_TYPE ...
						Graph.SELFCONNECTIVITY_TYPE ...
						Graph.NEGATIVITY_TYPE ...
						Graph.LAYERTICKS ...
						Graph.ALAYERTICKS ...
						Graph.LAYERLABELS ...
						Graph.ALAYERLABELS ...
						Graph.PARTITIONTICKS ...
						Graph.APARTITIONTICKS ...
						Graph.PARTITIONLABELS ...
						Graph.APARTITIONLABELS ...
						Graph.NODELABELS ...
						Graph.ANODELABELS ...
						Graph.RANDOMIZE ...
						Graph.RANDOM_SEED ...
						Graph.A ...
						Graph.A_CHECK ...
						Graph.NODENUMBER ...
						Graph.LAYERNUMBER ...
						Graph.PARTITIONS ...
						Graph.M_DICT ...
						Graph.COMPATIBLE_MEASURES ...
						Graph.MEASURE ...
						Graph.PFGA ...
						Graph.PFGH ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						Graph.GRAPH_TYPE ...
						Graph.COMPATIBLE_MEASURES ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						Graph.LAYERTICKS ...
						Graph.LAYERLABELS ...
						Graph.PARTITIONTICKS ...
						Graph.PARTITIONLABELS ...
						Graph.NODELABELS ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						Graph.RANDOMIZE ...
						Graph.RANDOM_SEED ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						Graph.A ...
						Graph.NODENUMBER ...
						Graph.LAYERNUMBER ...
						Graph.PARTITIONS ...
						Graph.M_DICT ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						Graph.CONNECTIVITY_TYPE ...
						Graph.DIRECTIONALITY_TYPE ...
						Graph.SELFCONNECTIVITY_TYPE ...
						Graph.NEGATIVITY_TYPE ...
						Graph.ALAYERTICKS ...
						Graph.ALAYERLABELS ...
						Graph.APARTITIONTICKS ...
						Graph.APARTITIONLABELS ...
						Graph.ANODELABELS ...
						Graph.A_CHECK ...
						Graph.MEASURE ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						Graph.PFGA ...
						Graph.PFGH ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graph.
			%
			% N = Graph.GETPROPNUMBER() returns the property number of graph.
			%
			% N = Graph.GETPROPNUMBER(CATEGORY) returns the property number of graph
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER([CATEGORY]) returns the property number of the graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('Graph') returns the property number of 'Graph'.
			%
			% Note that the Element.GETPROPNUMBER(G) and Element.GETPROPNUMBER('Graph')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(Graph.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph/error.
			%
			% CHECK = Graph.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSPROP(PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(G, PROP) checks whether PROP exists for G.
			%  CHECK = Element.EXISTSPROP(Graph, PROP) checks whether PROP exists for Graph.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Graph:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSPROP(PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:Graph:WrongInput]
			%  Element.EXISTSPROP(G, PROP) throws error if PROP does NOT exist for G.
			%   Error id: [BRAPH2:Graph:WrongInput]
			%  Element.EXISTSPROP(Graph, PROP) throws error if PROP does NOT exist for Graph.
			%   Error id: [BRAPH2:Graph:WrongInput]
			%
			% Note that the Element.EXISTSPROP(G) and Element.EXISTSPROP('Graph')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == Graph.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Graph.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph/error.
			%
			% CHECK = Graph.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = G.EXISTSTAG(TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(G, TAG) checks whether TAG exists for G.
			%  CHECK = Element.EXISTSTAG(Graph, TAG) checks whether TAG exists for Graph.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Graph:WrongInput]
			%
			% Alternative forms to call this method are:
			%  G.EXISTSTAG(TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:Graph:WrongInput]
			%  Element.EXISTSTAG(G, TAG) throws error if TAG does NOT exist for G.
			%   Error id: [BRAPH2:Graph:WrongInput]
			%  Element.EXISTSTAG(Graph, TAG) throws error if TAG does NOT exist for Graph.
			%   Error id: [BRAPH2:Graph:WrongInput]
			%
			% Note that the Element.EXISTSTAG(G) and Element.EXISTSTAG('Graph')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			graph_tag_list = cellfun(@(x) Graph.getPropTag(x), num2cell(Graph.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, graph_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for Graph.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Graph, POINTER) returns property number of POINTER of Graph.
			%  PROPERTY = G.GETPROPPROP(Graph, POINTER) returns property number of POINTER of Graph.
			%
			% Note that the Element.GETPROPPROP(G) and Element.GETPROPPROP('Graph')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				graph_tag_list = cellfun(@(x) Graph.getPropTag(x), num2cell(Graph.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, graph_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(Graph, POINTER) returns tag of POINTER of Graph.
			%  TAG = G.GETPROPTAG(Graph, POINTER) returns tag of POINTER of Graph.
			%
			% Note that the Element.GETPROPTAG(G) and Element.GETPROPTAG('Graph')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case Graph.GRAPH_TYPE
						tag = Graph.GRAPH_TYPE_TAG;
					case Graph.CONNECTIVITY_TYPE
						tag = Graph.CONNECTIVITY_TYPE_TAG;
					case Graph.DIRECTIONALITY_TYPE
						tag = Graph.DIRECTIONALITY_TYPE_TAG;
					case Graph.SELFCONNECTIVITY_TYPE
						tag = Graph.SELFCONNECTIVITY_TYPE_TAG;
					case Graph.NEGATIVITY_TYPE
						tag = Graph.NEGATIVITY_TYPE_TAG;
					case Graph.LAYERTICKS
						tag = Graph.LAYERTICKS_TAG;
					case Graph.ALAYERTICKS
						tag = Graph.ALAYERTICKS_TAG;
					case Graph.LAYERLABELS
						tag = Graph.LAYERLABELS_TAG;
					case Graph.ALAYERLABELS
						tag = Graph.ALAYERLABELS_TAG;
					case Graph.PARTITIONTICKS
						tag = Graph.PARTITIONTICKS_TAG;
					case Graph.APARTITIONTICKS
						tag = Graph.APARTITIONTICKS_TAG;
					case Graph.PARTITIONLABELS
						tag = Graph.PARTITIONLABELS_TAG;
					case Graph.APARTITIONLABELS
						tag = Graph.APARTITIONLABELS_TAG;
					case Graph.NODELABELS
						tag = Graph.NODELABELS_TAG;
					case Graph.ANODELABELS
						tag = Graph.ANODELABELS_TAG;
					case Graph.RANDOMIZE
						tag = Graph.RANDOMIZE_TAG;
					case Graph.RANDOM_SEED
						tag = Graph.RANDOM_SEED_TAG;
					case Graph.A
						tag = Graph.A_TAG;
					case Graph.A_CHECK
						tag = Graph.A_CHECK_TAG;
					case Graph.NODENUMBER
						tag = Graph.NODENUMBER_TAG;
					case Graph.LAYERNUMBER
						tag = Graph.LAYERNUMBER_TAG;
					case Graph.PARTITIONS
						tag = Graph.PARTITIONS_TAG;
					case Graph.M_DICT
						tag = Graph.M_DICT_TAG;
					case Graph.COMPATIBLE_MEASURES
						tag = Graph.COMPATIBLE_MEASURES_TAG;
					case Graph.MEASURE
						tag = Graph.MEASURE_TAG;
					case Graph.PFGA
						tag = Graph.PFGA_TAG;
					case Graph.PFGH
						tag = Graph.PFGH_TAG;
					otherwise
						tag = getPropTag@ConcreteElement(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(Graph, POINTER) returns category of POINTER of Graph.
			%  CATEGORY = G.GETPROPCATEGORY(Graph, POINTER) returns category of POINTER of Graph.
			%
			% Note that the Element.GETPROPCATEGORY(G) and Element.GETPROPCATEGORY('Graph')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Graph.getPropProp(pointer);
			
			switch prop
				case Graph.GRAPH_TYPE
					prop_category = Graph.GRAPH_TYPE_CATEGORY;
				case Graph.CONNECTIVITY_TYPE
					prop_category = Graph.CONNECTIVITY_TYPE_CATEGORY;
				case Graph.DIRECTIONALITY_TYPE
					prop_category = Graph.DIRECTIONALITY_TYPE_CATEGORY;
				case Graph.SELFCONNECTIVITY_TYPE
					prop_category = Graph.SELFCONNECTIVITY_TYPE_CATEGORY;
				case Graph.NEGATIVITY_TYPE
					prop_category = Graph.NEGATIVITY_TYPE_CATEGORY;
				case Graph.LAYERTICKS
					prop_category = Graph.LAYERTICKS_CATEGORY;
				case Graph.ALAYERTICKS
					prop_category = Graph.ALAYERTICKS_CATEGORY;
				case Graph.LAYERLABELS
					prop_category = Graph.LAYERLABELS_CATEGORY;
				case Graph.ALAYERLABELS
					prop_category = Graph.ALAYERLABELS_CATEGORY;
				case Graph.PARTITIONTICKS
					prop_category = Graph.PARTITIONTICKS_CATEGORY;
				case Graph.APARTITIONTICKS
					prop_category = Graph.APARTITIONTICKS_CATEGORY;
				case Graph.PARTITIONLABELS
					prop_category = Graph.PARTITIONLABELS_CATEGORY;
				case Graph.APARTITIONLABELS
					prop_category = Graph.APARTITIONLABELS_CATEGORY;
				case Graph.NODELABELS
					prop_category = Graph.NODELABELS_CATEGORY;
				case Graph.ANODELABELS
					prop_category = Graph.ANODELABELS_CATEGORY;
				case Graph.RANDOMIZE
					prop_category = Graph.RANDOMIZE_CATEGORY;
				case Graph.RANDOM_SEED
					prop_category = Graph.RANDOM_SEED_CATEGORY;
				case Graph.A
					prop_category = Graph.A_CATEGORY;
				case Graph.A_CHECK
					prop_category = Graph.A_CHECK_CATEGORY;
				case Graph.NODENUMBER
					prop_category = Graph.NODENUMBER_CATEGORY;
				case Graph.LAYERNUMBER
					prop_category = Graph.LAYERNUMBER_CATEGORY;
				case Graph.PARTITIONS
					prop_category = Graph.PARTITIONS_CATEGORY;
				case Graph.M_DICT
					prop_category = Graph.M_DICT_CATEGORY;
				case Graph.COMPATIBLE_MEASURES
					prop_category = Graph.COMPATIBLE_MEASURES_CATEGORY;
				case Graph.MEASURE
					prop_category = Graph.MEASURE_CATEGORY;
				case Graph.PFGA
					prop_category = Graph.PFGA_CATEGORY;
				case Graph.PFGH
					prop_category = Graph.PFGH_CATEGORY;
				otherwise
					prop_category = getPropCategory@ConcreteElement(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(Graph, POINTER) returns format of POINTER of Graph.
			%  FORMAT = G.GETPROPFORMAT(Graph, POINTER) returns format of POINTER of Graph.
			%
			% Note that the Element.GETPROPFORMAT(G) and Element.GETPROPFORMAT('Graph')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Graph.getPropProp(pointer);
			
			switch prop
				case Graph.GRAPH_TYPE
					prop_format = Graph.GRAPH_TYPE_FORMAT;
				case Graph.CONNECTIVITY_TYPE
					prop_format = Graph.CONNECTIVITY_TYPE_FORMAT;
				case Graph.DIRECTIONALITY_TYPE
					prop_format = Graph.DIRECTIONALITY_TYPE_FORMAT;
				case Graph.SELFCONNECTIVITY_TYPE
					prop_format = Graph.SELFCONNECTIVITY_TYPE_FORMAT;
				case Graph.NEGATIVITY_TYPE
					prop_format = Graph.NEGATIVITY_TYPE_FORMAT;
				case Graph.LAYERTICKS
					prop_format = Graph.LAYERTICKS_FORMAT;
				case Graph.ALAYERTICKS
					prop_format = Graph.ALAYERTICKS_FORMAT;
				case Graph.LAYERLABELS
					prop_format = Graph.LAYERLABELS_FORMAT;
				case Graph.ALAYERLABELS
					prop_format = Graph.ALAYERLABELS_FORMAT;
				case Graph.PARTITIONTICKS
					prop_format = Graph.PARTITIONTICKS_FORMAT;
				case Graph.APARTITIONTICKS
					prop_format = Graph.APARTITIONTICKS_FORMAT;
				case Graph.PARTITIONLABELS
					prop_format = Graph.PARTITIONLABELS_FORMAT;
				case Graph.APARTITIONLABELS
					prop_format = Graph.APARTITIONLABELS_FORMAT;
				case Graph.NODELABELS
					prop_format = Graph.NODELABELS_FORMAT;
				case Graph.ANODELABELS
					prop_format = Graph.ANODELABELS_FORMAT;
				case Graph.RANDOMIZE
					prop_format = Graph.RANDOMIZE_FORMAT;
				case Graph.RANDOM_SEED
					prop_format = Graph.RANDOM_SEED_FORMAT;
				case Graph.A
					prop_format = Graph.A_FORMAT;
				case Graph.A_CHECK
					prop_format = Graph.A_CHECK_FORMAT;
				case Graph.NODENUMBER
					prop_format = Graph.NODENUMBER_FORMAT;
				case Graph.LAYERNUMBER
					prop_format = Graph.LAYERNUMBER_FORMAT;
				case Graph.PARTITIONS
					prop_format = Graph.PARTITIONS_FORMAT;
				case Graph.M_DICT
					prop_format = Graph.M_DICT_FORMAT;
				case Graph.COMPATIBLE_MEASURES
					prop_format = Graph.COMPATIBLE_MEASURES_FORMAT;
				case Graph.MEASURE
					prop_format = Graph.MEASURE_FORMAT;
				case Graph.PFGA
					prop_format = Graph.PFGA_FORMAT;
				case Graph.PFGH
					prop_format = Graph.PFGH_FORMAT;
				otherwise
					prop_format = getPropFormat@ConcreteElement(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Graph, POINTER) returns description of POINTER of Graph.
			%  DESCRIPTION = G.GETPROPDESCRIPTION(Graph, POINTER) returns description of POINTER of Graph.
			%
			% Note that the Element.GETPROPDESCRIPTION(G) and Element.GETPROPDESCRIPTION('Graph')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Graph.getPropProp(pointer);
			
			switch prop
				case Graph.GRAPH_TYPE
					prop_description = 'GRAPH_TYPE (constant, scalar) is the graph type.';
				case Graph.CONNECTIVITY_TYPE
					prop_description = 'CONNECTIVITY_TYPE (query, smatrix) is the connectivity type of the graph.';
				case Graph.DIRECTIONALITY_TYPE
					prop_description = 'DIRECTIONALITY_TYPE (query, smatrix) is the directionality type of the graph.';
				case Graph.SELFCONNECTIVITY_TYPE
					prop_description = 'SELFCONNECTIVITY_TYPE (query, smatrix) is the self-connectivity type of the graph.';
				case Graph.NEGATIVITY_TYPE
					prop_description = 'NEGATIVITY_TYPE (query, scalar) is the negativity type of the graph.';
				case Graph.LAYERTICKS
					prop_description = 'LAYERTICKS (metadata, rvector) are the layer tick values.';
				case Graph.ALAYERTICKS
					prop_description = 'ALAYERTICKS (query, rvector) returns the layer tick values.';
				case Graph.LAYERLABELS
					prop_description = 'LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.';
				case Graph.ALAYERLABELS
					prop_description = 'ALAYERLABELS (query, stringlist) returns the layer labels for A.';
				case Graph.PARTITIONTICKS
					prop_description = 'PARTITIONTICKS (metadata, rvector) are the partition tick values.';
				case Graph.APARTITIONTICKS
					prop_description = 'APARTITIONTICKS (query, rvector) returns the partition tick values.';
				case Graph.PARTITIONLABELS
					prop_description = 'PARTITIONLABELS (metadata, stringlist) are the partition labels provided by the user.';
				case Graph.APARTITIONLABELS
					prop_description = 'APARTITIONLABELS (query, stringlist) returns the partition labels for A.';
				case Graph.NODELABELS
					prop_description = 'NODELABELS (metadata, stringlist) are the node labels provided by the user.';
				case Graph.ANODELABELS
					prop_description = 'ANODELABELS (query, stringlist) returns the nodel labels for each layer.';
				case Graph.RANDOMIZE
					prop_description = 'RANDOMIZE (parameter, logical) determines whether to randomize the graph.';
				case Graph.RANDOM_SEED
					prop_description = 'RANDOM_SEED (parameter, scalar) is the randomization seed.';
				case Graph.A
					prop_description = 'A (result, cell) is the graph adjacency matrix. ';
				case Graph.A_CHECK
					prop_description = 'A_CHECK (query, logical) checks the format of the adjacency matrix.';
				case Graph.NODENUMBER
					prop_description = 'NODENUMBER (result, rvector) returns the number of nodes in the graph; for non single layer graphs it returns an array with the number of nodes in each layer.';
				case Graph.LAYERNUMBER
					prop_description = 'LAYERNUMBER (result, scalar) returns the number of layers in the graph.';
				case Graph.PARTITIONS
					prop_description = 'PARTITIONS (result, rvector) returns the number of layers in the partitions of the graph.';
				case Graph.M_DICT
					prop_description = 'M_DICT (result, idict) contains the calculated measures of the graph.';
				case Graph.COMPATIBLE_MEASURES
					prop_description = 'COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.';
				case Graph.MEASURE
					prop_description = 'MEASURE (query, item) returns a measure.';
				case Graph.PFGA
					prop_description = 'PFGA (gui, item) contains the panel figure of the graph adjacency matrix.';
				case Graph.PFGH
					prop_description = 'PFGH (gui, item) contains the panel figure of the graph histogram.';
				case Graph.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the graph (Graph).';
				case Graph.NAME
					prop_description = 'NAME (constant, string) is the name of the graph.';
				case Graph.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the graph.';
				case Graph.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the graph.';
				case Graph.ID
					prop_description = 'ID (data, string) is a few-letter code for the graph.';
				case Graph.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the graph.';
				case Graph.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the graph.';
				otherwise
					prop_description = getPropDescription@ConcreteElement(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(Graph, POINTER) returns settings of POINTER of Graph.
			%  SETTINGS = G.GETPROPSETTINGS(Graph, POINTER) returns settings of POINTER of Graph.
			%
			% Note that the Element.GETPROPSETTINGS(G) and Element.GETPROPSETTINGS('Graph')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Graph.getPropProp(pointer);
			
			switch prop
				case Graph.GRAPH_TYPE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case Graph.CONNECTIVITY_TYPE
					prop_settings = Format.getFormatSettings(Format.SMATRIX);
				case Graph.DIRECTIONALITY_TYPE
					prop_settings = Format.getFormatSettings(Format.SMATRIX);
				case Graph.SELFCONNECTIVITY_TYPE
					prop_settings = Format.getFormatSettings(Format.SMATRIX);
				case Graph.NEGATIVITY_TYPE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case Graph.LAYERTICKS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case Graph.ALAYERTICKS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case Graph.LAYERLABELS
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case Graph.ALAYERLABELS
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case Graph.PARTITIONTICKS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case Graph.APARTITIONTICKS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case Graph.PARTITIONLABELS
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case Graph.APARTITIONLABELS
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case Graph.NODELABELS
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case Graph.ANODELABELS
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case Graph.RANDOMIZE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case Graph.RANDOM_SEED
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case Graph.A
					prop_settings = Format.getFormatSettings(Format.CELL);
				case Graph.A_CHECK
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case Graph.NODENUMBER
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case Graph.LAYERNUMBER
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case Graph.PARTITIONS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case Graph.M_DICT
					prop_settings = 'Measure';
				case Graph.COMPATIBLE_MEASURES
					prop_settings = 'Measure';
				case Graph.MEASURE
					prop_settings = 'Measure';
				case Graph.PFGA
					prop_settings = 'GraphAdjPF';
				case Graph.PFGH
					prop_settings = 'GraphHistPF';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Graph.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Graph.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULT(POINTER) returns the default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULT(Graph, POINTER) returns the default value of POINTER of Graph.
			%  DEFAULT = G.GETPROPDEFAULT(Graph, POINTER) returns the default value of POINTER of Graph.
			%
			% Note that the Element.GETPROPDEFAULT(G) and Element.GETPROPDEFAULT('Graph')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Graph.getPropProp(pointer);
			
			switch prop
				case Graph.GRAPH_TYPE
					prop_default = Graph.GRAPH;
				case Graph.CONNECTIVITY_TYPE
					prop_default = Format.getFormatDefault(Format.SMATRIX, Graph.getPropSettings(prop));
				case Graph.DIRECTIONALITY_TYPE
					prop_default = Format.getFormatDefault(Format.SMATRIX, Graph.getPropSettings(prop));
				case Graph.SELFCONNECTIVITY_TYPE
					prop_default = Format.getFormatDefault(Format.SMATRIX, Graph.getPropSettings(prop));
				case Graph.NEGATIVITY_TYPE
					prop_default = Format.getFormatDefault(Format.SCALAR, Graph.getPropSettings(prop));
				case Graph.LAYERTICKS
					prop_default = Format.getFormatDefault(Format.RVECTOR, Graph.getPropSettings(prop));
				case Graph.ALAYERTICKS
					prop_default = Format.getFormatDefault(Format.RVECTOR, Graph.getPropSettings(prop));
				case Graph.LAYERLABELS
					prop_default = Format.getFormatDefault(Format.STRINGLIST, Graph.getPropSettings(prop));
				case Graph.ALAYERLABELS
					prop_default = Format.getFormatDefault(Format.STRINGLIST, Graph.getPropSettings(prop));
				case Graph.PARTITIONTICKS
					prop_default = Format.getFormatDefault(Format.RVECTOR, Graph.getPropSettings(prop));
				case Graph.APARTITIONTICKS
					prop_default = Format.getFormatDefault(Format.RVECTOR, Graph.getPropSettings(prop));
				case Graph.PARTITIONLABELS
					prop_default = Format.getFormatDefault(Format.STRINGLIST, Graph.getPropSettings(prop));
				case Graph.APARTITIONLABELS
					prop_default = Format.getFormatDefault(Format.STRINGLIST, Graph.getPropSettings(prop));
				case Graph.NODELABELS
					prop_default = {'numbered'};
				case Graph.ANODELABELS
					prop_default = Format.getFormatDefault(Format.STRINGLIST, Graph.getPropSettings(prop));
				case Graph.RANDOMIZE
					prop_default = Format.getFormatDefault(Format.LOGICAL, Graph.getPropSettings(prop));
				case Graph.RANDOM_SEED
					prop_default = Format.getFormatDefault(Format.SCALAR, Graph.getPropSettings(prop));
				case Graph.A
					prop_default = Format.getFormatDefault(Format.CELL, Graph.getPropSettings(prop));
				case Graph.A_CHECK
					prop_default = Format.getFormatDefault(Format.LOGICAL, Graph.getPropSettings(prop));
				case Graph.NODENUMBER
					prop_default = Format.getFormatDefault(Format.RVECTOR, Graph.getPropSettings(prop));
				case Graph.LAYERNUMBER
					prop_default = Format.getFormatDefault(Format.SCALAR, Graph.getPropSettings(prop));
				case Graph.PARTITIONS
					prop_default = Format.getFormatDefault(Format.RVECTOR, Graph.getPropSettings(prop));
				case Graph.M_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, Graph.getPropSettings(prop));
				case Graph.COMPATIBLE_MEASURES
					prop_default = Format.getFormatDefault(Format.CLASSLIST, Graph.getPropSettings(prop));
				case Graph.MEASURE
					prop_default = Format.getFormatDefault(Format.ITEM, Graph.getPropSettings(prop));
				case Graph.PFGA
					prop_default = Format.getFormatDefault(Format.ITEM, Graph.getPropSettings(prop));
				case Graph.PFGH
					prop_default = Format.getFormatDefault(Format.ITEM, Graph.getPropSettings(prop));
				case Graph.ELCLASS
					prop_default = 'Graph';
				case Graph.NAME
					prop_default = 'Graph';
				case Graph.DESCRIPTION
					prop_default = 'A Graph provides the methods necessary for all graphs. Instances of this class should not be created. Use one of its subclasses instead.';
				case Graph.ID
					prop_default = 'Graph ID';
				case Graph.LABEL
					prop_default = 'Graph label';
				case Graph.NOTES
					prop_default = 'Graph notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Graph.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Graph.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of G.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Graph, POINTER) returns the conditioned default value of POINTER of Graph.
			%  DEFAULT = G.GETPROPDEFAULTCONDITIONED(Graph, POINTER) returns the conditioned default value of POINTER of Graph.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(G) and Element.GETPROPDEFAULTCONDITIONED('Graph')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Graph.getPropProp(pointer);
			
			prop_default = Graph.conditioning(prop, Graph.getPropDefault(prop));
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
			
			prop = Graph.getPropProp(pointer);
			
			switch prop
				case Graph.NODELABELS % __Graph.NODELABELS__
					if isa(value, 'BrainAtlas')
					    value = value.get('BR_DICT').get('KEYS');
					end
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = conditioning@ConcreteElement(pointer, value);
					end
			end
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
			%  CHECK = Element.CHECKPROP(Graph, PROP, VALUE) checks VALUE format for PROP of Graph.
			%  CHECK = G.CHECKPROP(Graph, PROP, VALUE) checks VALUE format for PROP of Graph.
			% 
			% G.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:Graph:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: €BRAPH2.STR€:Graph:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(Graph, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Graph.
			%   Error id: €BRAPH2.STR€:Graph:€BRAPH2.WRONG_INPUT€
			%  G.CHECKPROP(Graph, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Graph.
			%   Error id: €BRAPH2.STR€:Graph:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(G) and Element.CHECKPROP('Graph')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Graph.getPropProp(pointer);
			
			switch prop
				case Graph.GRAPH_TYPE % __Graph.GRAPH_TYPE__
					check = Format.checkFormat(Format.SCALAR, value, Graph.getPropSettings(prop));
				case Graph.CONNECTIVITY_TYPE % __Graph.CONNECTIVITY_TYPE__
					check = Format.checkFormat(Format.SMATRIX, value, Graph.getPropSettings(prop));
				case Graph.DIRECTIONALITY_TYPE % __Graph.DIRECTIONALITY_TYPE__
					check = Format.checkFormat(Format.SMATRIX, value, Graph.getPropSettings(prop));
				case Graph.SELFCONNECTIVITY_TYPE % __Graph.SELFCONNECTIVITY_TYPE__
					check = Format.checkFormat(Format.SMATRIX, value, Graph.getPropSettings(prop));
				case Graph.NEGATIVITY_TYPE % __Graph.NEGATIVITY_TYPE__
					check = Format.checkFormat(Format.SCALAR, value, Graph.getPropSettings(prop));
				case Graph.LAYERTICKS % __Graph.LAYERTICKS__
					check = Format.checkFormat(Format.RVECTOR, value, Graph.getPropSettings(prop));
				case Graph.ALAYERTICKS % __Graph.ALAYERTICKS__
					check = Format.checkFormat(Format.RVECTOR, value, Graph.getPropSettings(prop));
				case Graph.LAYERLABELS % __Graph.LAYERLABELS__
					check = Format.checkFormat(Format.STRINGLIST, value, Graph.getPropSettings(prop));
				case Graph.ALAYERLABELS % __Graph.ALAYERLABELS__
					check = Format.checkFormat(Format.STRINGLIST, value, Graph.getPropSettings(prop));
				case Graph.PARTITIONTICKS % __Graph.PARTITIONTICKS__
					check = Format.checkFormat(Format.RVECTOR, value, Graph.getPropSettings(prop));
				case Graph.APARTITIONTICKS % __Graph.APARTITIONTICKS__
					check = Format.checkFormat(Format.RVECTOR, value, Graph.getPropSettings(prop));
				case Graph.PARTITIONLABELS % __Graph.PARTITIONLABELS__
					check = Format.checkFormat(Format.STRINGLIST, value, Graph.getPropSettings(prop));
				case Graph.APARTITIONLABELS % __Graph.APARTITIONLABELS__
					check = Format.checkFormat(Format.STRINGLIST, value, Graph.getPropSettings(prop));
				case Graph.NODELABELS % __Graph.NODELABELS__
					check = Format.checkFormat(Format.STRINGLIST, value, Graph.getPropSettings(prop));
				case Graph.ANODELABELS % __Graph.ANODELABELS__
					check = Format.checkFormat(Format.STRINGLIST, value, Graph.getPropSettings(prop));
				case Graph.RANDOMIZE % __Graph.RANDOMIZE__
					check = Format.checkFormat(Format.LOGICAL, value, Graph.getPropSettings(prop));
				case Graph.RANDOM_SEED % __Graph.RANDOM_SEED__
					check = Format.checkFormat(Format.SCALAR, value, Graph.getPropSettings(prop));
				case Graph.A % __Graph.A__
					check = Format.checkFormat(Format.CELL, value, Graph.getPropSettings(prop));
				case Graph.A_CHECK % __Graph.A_CHECK__
					check = Format.checkFormat(Format.LOGICAL, value, Graph.getPropSettings(prop));
				case Graph.NODENUMBER % __Graph.NODENUMBER__
					check = Format.checkFormat(Format.RVECTOR, value, Graph.getPropSettings(prop));
				case Graph.LAYERNUMBER % __Graph.LAYERNUMBER__
					check = Format.checkFormat(Format.SCALAR, value, Graph.getPropSettings(prop));
				case Graph.PARTITIONS % __Graph.PARTITIONS__
					check = Format.checkFormat(Format.RVECTOR, value, Graph.getPropSettings(prop));
				case Graph.M_DICT % __Graph.M_DICT__
					check = Format.checkFormat(Format.IDICT, value, Graph.getPropSettings(prop));
				case Graph.COMPATIBLE_MEASURES % __Graph.COMPATIBLE_MEASURES__
					check = Format.checkFormat(Format.CLASSLIST, value, Graph.getPropSettings(prop));
				case Graph.MEASURE % __Graph.MEASURE__
					check = Format.checkFormat(Format.ITEM, value, Graph.getPropSettings(prop));
				case Graph.PFGA % __Graph.PFGA__
					check = Format.checkFormat(Format.ITEM, value, Graph.getPropSettings(prop));
				case Graph.PFGH % __Graph.PFGH__
					check = Format.checkFormat(Format.ITEM, value, Graph.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Graph.getPropTag(prop) ' (' Graph.getFormatTag(Graph.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(g, prop)
			%POSTPROCESSING postprocessesing after setting.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing of PROP after setting. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% The postprocessing of all properties occurs each time set is called.
			%
			% See also conditioning, preset, checkProp, postset, calculateValue,
			%  checkValue.
			
			switch prop
				case Graph.PFGA % __Graph.PFGA__
					if isa(g.getr('PFGA'), 'NoValue')
					    g.memorize('PFGA').set('G', g)
					end
					
				case Graph.PFGH % __Graph.PFGH__
					if isa(g.getr('PFGH'), 'NoValue')
					    g.memorize('PFGH').set('G', g)
					end
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						postprocessing@ConcreteElement(g, prop);
					end
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
				case Graph.CONNECTIVITY_TYPE % __Graph.CONNECTIVITY_TYPE__
					value = Graph.WEIGHTED;
					
				case Graph.DIRECTIONALITY_TYPE % __Graph.DIRECTIONALITY_TYPE__
					value = Graph.DIRECTED;
					
				case Graph.SELFCONNECTIVITY_TYPE % __Graph.SELFCONNECTIVITY_TYPE__
					value = Graph.SELFCONNECTED;
					
				case Graph.NEGATIVITY_TYPE % __Graph.NEGATIVITY_TYPE__
					value = Graph.NEGATIVE;
					
				case Graph.ALAYERTICKS % __Graph.ALAYERTICKS__
					alayerticks = g.get('LAYERTICKS');
					if isempty(alayerticks) && ~isa(g.getr('A'), 'NoValue') % ensures that it's not unecessarily calculated
					    alayerticks = [1:1:g.get('LAYERNUMBER')];
					end
					value = alayerticks;
					
				case Graph.ALAYERLABELS % __Graph.ALAYERLABELS__
					value = g.get('LAYERLABELS');
					
				case Graph.APARTITIONTICKS % __Graph.APARTITIONTICKS__
					value = g.get('PARTITIONTICKS');
					
				case Graph.APARTITIONLABELS % __Graph.APARTITIONLABELS__
					value = g.get('PARTITIONLABELS');
					
				case Graph.ANODELABELS % __Graph.ANODELABELS__
					value = g.get('NODELABELS');
					
				case Graph.A % __Graph.A__
					rng_settings_ = rng(); rng(g.getPropSeed(Graph.A), 'twister')
					
					value = {};
					
					rng(rng_settings_)
					
				case Graph.A_CHECK % __Graph.A_CHECK__
					A = g.get('A');
					checkA(g.get('GRAPH_TYPE'), A);  % performs all necessary checks on A
					checkConnectivity(g.get('CONNECTIVITY_TYPE', length(A)), A);
					checkDirectionality(g.get('DIRECTIONALITY_TYPE', length(A)), A);
					checkSelfConnectivity(g.get('SELFCONNECTIVITY_TYPE', length(A)), A);
					checkNegativity(g.get('NEGATIVITY_TYPE', length(A)), A);
					value = true; % only if no error is thrown by the previous code!
					
				case Graph.NODENUMBER % __Graph.NODENUMBER__
					rng_settings_ = rng(); rng(g.getPropSeed(Graph.NODENUMBER), 'twister')
					
					A = g.get('A');
					value = cellfun(@(a) length(a), A(1:length(A)+1:end)); % vector with number of nodes per layer
					
					rng(rng_settings_)
					
				case Graph.LAYERNUMBER % __Graph.LAYERNUMBER__
					rng_settings_ = rng(); rng(g.getPropSeed(Graph.LAYERNUMBER), 'twister')
					
					value = length(g.get('A')); % number of layers
					
					rng(rng_settings_)
					
				case Graph.PARTITIONS % __Graph.PARTITIONS__
					rng_settings_ = rng(); rng(g.getPropSeed(Graph.PARTITIONS), 'twister')
					
					value = g.get('LAYERNUMBER'); % by default, there is a single partition
					
					rng(rng_settings_)
					
				case Graph.M_DICT % __Graph.M_DICT__
					rng_settings_ = rng(); rng(g.getPropSeed(Graph.M_DICT), 'twister')
					
					value = IndexedDictionary('IT_CLASS', 'Measure', 'IT_KEY', Measure.ELCLASS);
					
					rng(rng_settings_)
					
				case Graph.MEASURE % __Graph.MEASURE__
					% M = g.get('MEASURE', MEASURE_CLASS) checks whether the measure exists in the
					%  property M_DICT. If not, it creates a new measure M of class MEASURE_CLASS
					%  with properties defined by the graph settings. The user must call
					%  getValue() for the new measure M to retrieve the value of measure M.
					if isempty(varargin)
					    value = Measure();
					    
					    % % Warning commented because it most likely will lead to an error anyways
					    % warning( ...
					    %     [BRAPH2.STR ':' class(g)], ...
					    %     [BRAPH2.STR ':' class(g) '\n' ...
					    %     'Missing argument MEASURE_CLASS when using Graph.get(''MEASURE'', MEASURE_CLASS).'] ...
					    %     )
					    
					    return
					end
					measure_class = varargin{1};
					
					m_list = g.get('COMPATIBLE_MEASURES');
					if ~contains(measure_class, m_list)
					    error(...
					        [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
					        [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT ' \n' ...
					        measure_class ' is not a compatible Measure with ' g.getClass() '. \n' ...
					        'Use ' g.getClass() '().get(''COMPATIBLE_MEASURES'') for a list of compatible measures.'])
					end
					
					m_dict = g.memorize('M_DICT');
					if m_dict.get('CONTAINS_KEY', measure_class)
					    m = m_dict.get('IT', measure_class);
					else
					    if isa(g.getr('TEMPLATE'), 'NoValue')
					        m = eval([measure_class '(''ID'', measure_class, ''G'', g)']);
					    else % the graph has a template
					        m_template = g.get('TEMPLATE').get('MEASURE', measure_class); %#ok<NASGU>
					        
					        m = eval([measure_class '(''ID'', measure_class, ''G'', g, ''TEMPLATE'', m_template)']);
					    end
					
					    m_dict.get('ADD', m);
					end
					
					value = m;
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(g, prop, varargin{:});
					else
						value = calculateValue@Element(g, prop, varargin{:});
					end
			end
			
			function checkA(graph_type, A)
			    %CHECKA checks whether adjacency matrix A is correct for the type of graph.
			    %
			    % CHECKA(GRAPH_TYPE, A) checks if adjacency matrix A is correct for the
			    %  GRAPH_TYPE.
			    %
			    % See also checkConnectivity, checkDirectionality, checkNegativity,
			    % checkSelfConnectivity.
			
			    % Basic checks
			    % square cell array of matrices
			    if ~iscell(A) || ~ismatrix(A) || size(A, 1) ~= size(A, 2)
			        error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			            [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\n' ...
			            'A must be a superadjacency matrix (square cell array of matrices).'])
			    end
			    % all submatrices in the diagonal are square
			    if any(cellfun(@(a) size(a, 1) ~= size(a, 2), A(1:length(A)+1:end)))
			        error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			            [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\n' ...
			            'All submatrices in the cell diagonal must be square.'])
			    end
			
			    % Additional checks
			    switch graph_type
			        case Graph.GRAPH % __Graph.GRAPH__
			            % no additional checks
			
			        case  Graph.MULTIGRAPH % __Graph.MULTIGRAPH__
			            % no additional checks
			
			        case Graph.ORDERED_MULTIPLEX % __Graph.ORDERED_MULTIPLEX__
			            if ~isempty(A) && any(cellfun(@(a) size(a, 1), A(1:length(A)+1:end)) ~= cellfun(@(a) size(a, 1), A(1, 1)))
			                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\n' ...
			                    'In a sequence, submatrices in the cell diagonal must have the same dimensions.'])
			            end
			            if ~isempty(A) && any(cellfun(@(a) size(a, 1), A(2:length(A)+1:end)) ~= cellfun(@(a) size(a, 1), A(1, 1)))
			                erro([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\n' ...
			                    'In a sequence, submatrices in the cell sub-diagonal must have the same dimensions.'])
			            end
			            if ~isempty(A) && any(cellfun(@(a) size(a, 1), A(length(A)+1:length(A)+1:end)) ~= cellfun(@(a) size(a, 1), A(1, 1)))
			                erro([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT
			                    'In a sequence, submatrices in the cell super-diagonal must have the same dimensions.'])
			            end
			
			        case Graph.MULTIPLEX % __Graph.MULTIPLEX__
			            % all submatrices must be square.
			            if any(cellfun(@(a) size(a, 1) ~= size(a, 2), A(:)))
			                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\n' ...
			                    'In a multiplex, all submatrices must be square.'])
			            end
			            % all submatrices have same dimensions.
			            if ~isempty(A) && any(cellfun(@(a) size(a, 1), A(:)) ~= cellfun(@(a) size(a, 1), A(1, 1)))
			                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\n' ...
			                    'In a multiplex, all submatrices must have the same dimensions.'])
			            end
			
			        case Graph.ORDERED_MULTILAYER % __Graph.ORDERED_MULTILAYER__
			            if any(cellfun(@(a) size(a, 1), A(2:length(A)+1:end)) ~= cellfun(@(a) size(a, 1), A(length(A)+2:length(A)+1:end)))
			                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\n' ...
			                    'Sub-diagonal submatrices in the same row must have the same number of rows.'])
			            end
			            if any(cellfun(@(a) size(a, 2), A(2:length(A)+1:end)) ~= cellfun(@(a) size(a, 2), A(1:length(A)+1:end-1)))
			                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\n' ...
			                    'Sub-diagonal submatrices in the same column must have the same number of columns.'])
			            end
			            if any(cellfun(@(a) size(a, 1), A(length(A)+1:length(A)+1:end)) ~= cellfun(@(a) size(a, 1), A(1:length(A)+1:end-1)))
			                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\n' ...
			                    'Super-diagonal submatrices in the same row must have the same number of rows.'])
			            end
			            if any(cellfun(@(a) size(a, 2), A(length(A)+1:length(A)+1:end)) ~= cellfun(@(a) size(a, 2), A(length(A)+2:length(A)+1:end)))
			                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\n' ...
			                    'Super-diagonal submatrices in the same column must have the same number of columns.'])
			            end
			
			        case Graph.MULTILAYER % __Graph.MULTILAYER__
			            if any(any(cellfun(@(a) size(a, 1), A) ~= cellfun(@(a) size(a, 1), A(:, 1))))
			                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\n' ...
			                    'All submatrices in the same row must have the same number of rows.'])
			            end
			            if any(any(cellfun(@(a) size(a, 2), A) ~= cellfun(@(a) size(a, 2), A(1, :))))
			                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\n' ...
			                    'All submatrices in the same column must have the same number of columns.'])
			            end
			    end
			end
			function checkConnectivity(connectivity_type, A)
			    %CHECKCONNECTIVITY checks if adjacency matrix A is correct for the connectivity type.
			    %
			    % CHECKCONNECTIVITY(CONNECTIVITY_TYPE, A) checks if adjacency matrix A is
			    %  correct for the CONNECTIVITY_TYPE of the graph.
			    %  This check assumes that checkA has already been passed.
			    %
			    % See also checkA, checkDirectionality, checkNegativity, checkSelfConnectivity.
			
			    if isnumeric(A)  % A is a matrix
			        switch connectivity_type
			            case Graph.BINARY % __Graph.BINARY__
			                if any(any(A ~= 0 & A ~= 1))
			                    error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			                        [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\n' ...
			                        'For connectivity type __Graph.BINARY__ (%i), A must be binary (0s and 1s),' ...
			                        ' while it is ' mat2str(A)], ...
			                        Graph.BINARY)
			                end
			
			            case Graph.WEIGHTED % __Graph.WEIGHTED__
			                % no further check needed
			
			            otherwise
			                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			                    ['Connectivity type must be __Graph.BINARY__ (%i) or __Graph.WEIGHTED__ (%i),' ...
			                    ' while it is ' mat2str(connectivity_type)], ...
			                    Graph.BINARY, Graph.WEIGHTED)
			        end
			    else  % A is 2D cell array
			
			        if numel(connectivity_type) == 1
			            connectivity_type = connectivity_type * ones(size(A));
			        end
			
			        for i = 1:1:size(A, 1)
			            for j = 1:1:size(A, 2)
			                checkConnectivity(connectivity_type(i, j), A{i, j});
			            end
			        end
			    end
			end
			function checkDirectionality(directionality_type, A, At)
			    %CHECKDIRECTIONALITY checks if adjacency matrix A is correct for the directionality type.
			    %
			    % CHECKDIRECTIONALITY(DIRECTIONALITY_TYPE, A) checks if adjacency matrix A
			    %  is correct for the DIRECTIONALITY_TYPE of the graph.
			    %  This check assumes that checkA has already been passed.
			    %
			    % See also checkA, checkConnectivity, checkNegativity, checkSelfConnectivity.
			
			    if nargin < 3
			        At = A';
			    end
			
			    if isnumeric(A)  % A is a matrix
			        switch directionality_type
			            case Graph.UNDIRECTED % __Graph.UNDIRECTED__
			                assert(all(all(A == At)), ...
			                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			                    ['For directionality type _Graph.UNDIRECTED_ (%i), A must equal to At,' ...
			                    ' while it is A = ' mat2str(A) ...
			                    ' and At = ' mat2str(At)], ...
			                    Graph.UNDIRECTED)
			
			            case Graph.DIRECTED % __Graph.DIRECTED__
			                % no further check needed
			
			            otherwise
			                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			                    ['Directionality type must be __Graph.DIRECTED__ (%i) or __Graph.UNDIRECTED__ (%i),' ...
			                    ' while it is ' mat2str(directionality_type)], ...
			                    Graph.DIRECTED, Graph.UNDIRECTED)
			        end
			    else  % A is 2D cell array
			
			        if numel(directionality_type) == 1
			            directionality_type = directionality_type * ones(size(A));
			        end
			        assert(all(all(directionality_type == directionality_type')), ...
			            [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			            ['The directionality type must be symmetric,' ...
			            ' while it is ' mat2str(directionality_type)])
			
			        for i = 1:1:size(A, 1)
			            for j = 1:1:size(A, 2)
			                checkDirectionality(directionality_type(i, j), A{i, j}, A{j, i}');
			            end
			        end
			    end
			end
			function checkSelfConnectivity(selfconnectivity_type, A)
			    %CHECKSELFCONNECTIVITY checks if adjacency matrix A is correct for the self-connectivity type.
			    %
			    % CHECKSELFCONNECTIVITY(SELFCONNECTIVITY_TYPE, A) checks if adjacency
			    %  matrix A is correct for the SELFCONNECTIVITY_TYPE of the graph.
			    %  This check assumes that checkA has already been passed.
			    %
			    % See also checkA, checkConnectivity, checkDirectionality, checkNegativity.
			
			    if isnumeric(A)  % A is a matrix
			        switch selfconnectivity_type
			            case Graph.NONSELFCONNECTED % __Graph.NONSELFCONNECTED__
			                if any(any(A(1:length(A)+1:end) ~= 0))
			                    error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			                        [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\n' ...
			                        'For self-connectivity type __Graph.NONSELFCONNECTED__ (%i), A must have' ...
			                        ' 0 values along the diagonal while it is ' mat2str(A)], ...
			                        Graph.NONSELFCONNECTED)
			                end
			
			            case Graph.SELFCONNECTED % __Graph.SELFCONNECTED__
			                % no further check needed
			
			            otherwise
			                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			                    ['Self-connectivity type must be __Graph.SELFCONNECTED__ (%i) or' ...
			                    ' __Graph.NONSELFCONNECTED__ (%i), while it is ' mat2str(selfconnectivity_type)], ...
			                    Graph.SELFCONNECTED, Graph.NONSELFCONNECTED)
			        end
			    else  % A is 2D cell array
			
			        if numel(selfconnectivity_type) == 1
			            selfconnectivity_type = selfconnectivity_type * ones(size(A));
			        end
			
			        for i = 1:1:size(A, 1)
			            checkSelfConnectivity(selfconnectivity_type(i, i), A{i, i});
			        end
			    end
			end
			function checkNegativity(negativity_type, A)
			    %CHECKNEGATIVITY checks if adjacency matrix A is correct for the negativity type.
			    %
			    % CHECKNEGATIVITY(NEGATIVITY_TYPE, A) checks if adjacency matrix A is
			    %  correct for the NEGATIVITY_TYPE of the graph.
			    %  This check assumes that checkA has already been passed.
			    %
			    % See also checkA, checkConnectivity, checkDirectionality, checkSelfConnectivity.
			
			    if isnumeric(A)  % A is a matrix
			        switch negativity_type
			            case Graph.NONNEGATIVE % __Graph.NONNEGATIVE__
			                if any(any(A < 0))
			                    error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			                        [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT '\n' ...
			                        'For negativity type __Graph.NONNEGATIVE__ (%i), A must have' ...
			                        ' non-negative values, while it is ' mat2str(A)], ...
			                        Graph.NONNEGATIVE)
			                end
			                
			            case Graph.NEGATIVE % __Graph.NEGATIVE__
			                % no further check needed
			
			            otherwise
			                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
			                    ['Negativity type must be __Graph.NEGATIVE__ (%i) or' ...
			                    ' __Graph.NONNEGATIVE__ (%i), while it is ' mat2str(negativity_type)], ...
			                    Graph.NEGATIVE, Graph.NONNEGATIVE)
			        end
			    else  % A is 2D cell array
			
			        if numel(negativity_type) == 1
			            negativity_type = negativity_type * ones(size(A));
			        end
			
			        for i = 1:1:size(A, 1)
			            for j = 1:1:size(A, 2)
			                checkNegativity(negativity_type(i, j), A{i, j});
			            end
			        end
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
				case Graph.LAYERTICKS % __Graph.LAYERTICKS__
					pr = PanelPropRVectorSmart('EL', g, 'PROP', Graph.LAYERTICKS, varargin{:});
					
				case Graph.PARTITIONTICKS % __Graph.PARTITIONTICKS__
					pr = PanelPropRVectorSmart('EL', g, 'PROP', Graph.PARTITIONTICKS, varargin{:});
					
				case Graph.M_DICT % __Graph.M_DICT__
					pr = GraphPP_MDict('EL', g, 'PROP', Graph.M_DICT, varargin{:});
					
				case Graph.PFGA % __Graph.PFGA__
					pr = PanelPropItem('EL', g, 'PROP', Graph.PFGA, ...
					    'GUICLASS', 'GUIFig', ...
					    'BUTTON_TEXT', 'Plot Adjacency Matrix', ...
					    varargin{:});
					
				case Graph.PFGH % __Graph.PFGH__
					pr = PanelPropItem('EL', g, 'PROP', Graph.PFGH, ...
					    'GUICLASS', 'GUIFig', ...
					    'BUTTON_TEXT', 'Plot Histogram', ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(g, prop, varargin{:});
					
			end
		end
	end
end
