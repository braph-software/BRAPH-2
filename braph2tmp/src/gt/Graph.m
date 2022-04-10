classdef Graph < Element
	% Graph is a graph.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% Graph provides the methods necessary for all graphs.
	% Instances of this class should not be created. 
	% Use one of its subclasses instead.
	%
	% The list of Graph properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph.
	%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph.
	%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph.
	%  <strong>4</strong> <strong>brainatlas</strong> 	BRAINATLAS (data, item) is a atlas associated with the graph.
	%  <strong>5</strong> <strong>a</strong> 	A (result, cell) is the graph adjacency matrix. 
	%  <strong>6</strong> <strong>m_dict</strong> 	M_DICT (result, idict) contains the calculated measures of the graph.
	%
	% Graph methods (constructor):
	% Graph - constructor
	%
	% Graph methods (Static):
	%  edgeattack - removes given edges from a graph
	%  nodeattack - removes given nodes from a graph
	%  subgraph - extracts subgraph
	%  getCompatibleMeasureList - T returns the list of measures
	%  checkNegativity - checks if adjacency matrix A is correct for the negativity type.
	%  checkSelfConnectivity - checks if adjacency matrix A is correct for the self-connectivity type.
	%  checkDirectionality - checks if adjacency matrix A is correct for the directionality type.
	%  checkConnectivity - checks if adjacency matrix A is correct for the connectivity type.
	%  checkA - checks whether adjacency matrix A is correct for the type of graph.
	%  is_negative - checks whether graph allows negative values.
	%  is_nonnegative - checks whether graph allows non-negative values.
	%  getNegativityType - returns the negativity type of the graph.
	%  is_not_selfconnected - checks if graph is not self-connected.
	%  is_selfconnected - checks if graph is self-connected.
	%  getSelfConnectivityType - returns the self-connectivity type of the graph.
	%  is_undirected - checks if graph is undirected.
	%  is_directed - checks if graph is directed
	%  getDirectionalityType - returns the directionality type of the graph.
	%  is_binary - checks if graph is binary
	%  is_weighted - checks if graph is weighted.
	%  getConnectivityType - returns the connectivity type of the graph.
	%  is_multilayer - checks if graph is multilayer
	%  is_ordered_multilayer - checks if graph is ordered multilayer.
	%  is_multiplex - checks if graph is multiplex.
	%  is_ordered_multiplex - checks if graph is ordered multiplex.
	%  is_multigraph - checks if graph is multigraph.
	%  is_graph - checks if graph is graph (single layer).
	%  getGraphType - returns the graph type.
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in graph/error.
	%  existsProp - checks whether property exists in graph/error.
	%  getPropNumber - returns the property number of graph.
	%  getProps - returns the property list of graph.
	%  getDescription - returns the description of the graph.
	%  getName - returns the name of the graph.
	%  getClass - returns the class of the graph.
	%
	% Graph methods:
	%  getMeasure - returns measure.
	%  layernumber - returns the number of layers in the graph.
	%  nodenumber - returns the number of nodes in the graph.
	%  set - sets the value of a property
	%  check - checks the values of all properties
	%  getr - returns the raw value of a property
	%  get - returns the value of a property
	%  memorize - returns and memorizes the value of a property
	%  getPropSeed - returns the seed of a property
	%  isLocked - returns whether a property is locked
	%  lock - locks unreversibly a property
	%  isChecked - returns whether a property is checked
	%  checked - sets a property to checked
	%  unchecked - sets a property to NOT checked
	%
	% Graph methods (operators):
	%  isequal - determines whether two Graph are equal (values, locked)
	%
	% Graph methods (display):
	%  tostring - string with information about the Graph
	%  disp - displays information about the Graph
	%  tree - displays the element of Graph
	%
	% Graph method (element list):
	%  getElementList - returns a list with all subelements of Graph
	%
	% Graph method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the Graph
	%
	% Graph method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the Graph
	%
	% Graph methods (copy):
	%  copy - copies the Graph
	%  deepclone - deep-clones the Graph
	%  clone - clones the Graph
	%
	% Graph methods (inspection, Static):
	%  getClass - returns Graph
	%  getName - returns the name of Graph
	%  getDescription - returns the description of Graph
	%  getProps - returns the property list of Graph
	%  getPropNumber - returns the property number of Graph
	%  existsProp - checks whether property exists/error
	%  existsTag - checks whether tag exists/error
	%  getPropProp - returns the property number of a property
	%  getPropTag - returns the tag of a property
	%  getPropCategory - returns the category of a property
	%  getPropFormat - returns the format of a property
	%  getPropDescription - returns the description of a property
	%  getPropSettings - returns the settings of a property
	%  getPropDefault - returns the default value of a property
	%  getPropDefaultConditioned - returns the conditione default value of a property
	%  checkProp - checks whether a value has the correct format/error
	%
	% Graph methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Graph methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% Graph methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% Graph methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% Graph properties (Constant).
	%  GRAPH - 1
	%  GRAPH_NAME - 'Graph'
	%  GRAPH_DESCRIPTION - 'A graph consists of a single layer.'
	%  MULTIGRAPH - 2
	%  MULTIGRAPH_NAME - 'Multigraph'
	%  MULTIGRAPH_DESCRIPTION - 'A multigraph consists of multiple unconnected layers.'
	%  ORDERED_MULTIPLEX - 3
	%  ORDERED_MULTIPLEX_NAME - 'Ordered Multipex'
	%  ORDERED_MULTIPLEX_DESCRIPTION - 'An ordered multiplex consists of a sequence of layers with ordinal connectionsbetween corresponding nodes in subsequent layers.'
	%  MULTIPLEX - 4
	%  MULTIPLEX_NAME - 'Multiplex'
	%  MULTIPLEX_DESCRIPTION - 'A multiplex consists of multiple layers with categorical connections between corresponding nodes in different layers.'
	%  ORDERED_MULTILAYER - 5
	%  ORDERED_MULTILAYER_NAME - 'Ordered Multilayer'
	%  ORDERED_MULTILAYER_DESCRIPTION - 'An ordered multilayer consists of multiple layers with ordinal connections between any nodes.'
	%  MULTILAYER - 6
	%  MULTILAYER_NAME - 'Multilayer'
	%  MULTILAYER_DESCRIPTION - 'A multilayer consists of multiple layers with categorical between any nodes.'
	%  TYPE_NUMBER - 6
	%  TYPE_NAME - cell[6 1] { 'Graph' 'Multigraph' 'Ordered Multipex' 'Multiplex' 'Ordered Multilayer' 'Multilayer' }
	%  TYPE_DESCRIPTION - cell[6 1] { 'A graph consists of a single layer.' 'A multigraph consists of multiple unconnected layers.' 'An ordered multiplex consists of a sequence of layers with ordinal connectionsbetween corresponding nodes in subsequent layers.' 'A multiplex consists of multiple layers with categorical connections between corresponding nodes in different layers.' 'An ordered multilayer consists of multiple layers with ordinal connections between any nodes.' 'A multilayer consists of multiple layers with categorical between any nodes.' }
	%  WEIGHTED - 1
	%  WEIGHTED_NAME - 'Weighted'
	%  WEIGHTED_DESCRIPTION - 'Graph with weighted connections.'
	%  BINARY - 2
	%  BINARY_NAME - 'Binary'
	%  BINARY_DESCRIPTION - 'Graph with binary (0 or 1) connections.'
	%  CONNECTIVITY_TYPE_NUMBER - 2
	%  CONNECTIVITY_TYPE_NAME - cell[2 1] { 'Weighted' 'Binary' }
	%  CONNECTIVITY_TYPE_DESCRIPTION - cell[2 1] { 'Graph with weighted connections.' 'Graph with binary (0 or 1) connections.' }
	%  DIRECTED - 1
	%  DIRECTED_NAME - 'Directed'
	%  DIRECTED_DESCRIPTION - 'Graph with directed edges.'
	%  UNDIRECTED - 2
	%  UNDIRECTED_NAME - 'Undirected'
	%  UNDIRECTED_DESCRIPTION - 'Graph with undirected edges.'
	%  DIRECTIONALITY_TYPE_NUMBER - 2
	%  DIRECTIONALITY_TYPE_NAME - cell[2 1] { 'Directed' 'Undirected' }
	%  DIRECTIONALITY_TYPE_DESCRIPTION - cell[2 1] { 'Graph with directed edges.' 'Graph with undirected edges.' }
	%  NONSELFCONNECTED - 1
	%  NONSELFCONNECTED_NAME - 'Non-self-connected'
	%  NONSELFCONNECTED_DESCRIPTION - 'Graph without self-connections.'
	%  SELFCONNECTED - 2
	%  SELFCONNECTED_NAME - 'Self-connected'
	%  SELFCONNECTED_DESCRIPTION - 'Graph with self-connections.'
	%  SELFCONNECTIVITY_TYPE_NUMBER - 2
	%  SELFCONNECTIVITY_TYPE_NAME - cell[2 1] { 'Non-self-connected' 'Self-connected' }
	%  SELFCONNECTIVITY_TYPE_DESCRIPTION - cell[2 1] { 'Graph without self-connections.' 'Graph with self-connections.' }
	%  NONNEGATIVE - 1
	%  NONNEGATIVE_NAME - 'Non-negative'
	%  NONNEGATIVE_DESCRIPTION - 'Graph without negative edges.'
	%  NEGATIVE - 2
	%  NEGATIVE_NAME - 'Negative'
	%  NEGATIVE_DESCRIPTION - 'Graph allowing negative edges.'
	%  NEGATIVITY_TYPE_NUMBER - 2
	%  NEGATIVITY_TYPE_NAME - cell[2 1] { 'Non-negative' 'Negative' }
	%  NEGATIVITY_TYPE_DESCRIPTION - cell[2 1] { 'Graph without negative edges.' 'Graph allowing negative edges.' }
	%  ID - 1
	%  ID_TAG - 'id'
	%  ID_CATEGORY - 'd'
	%  ID_FORMAT - 'st'
	%  LABEL - 2
	%  LABEL_TAG - 'label'
	%  LABEL_CATEGORY - 'm'
	%  LABEL_FORMAT - 'st'
	%  NOTES - 3
	%  NOTES_TAG - 'notes'
	%  NOTES_CATEGORY - 'm'
	%  NOTES_FORMAT - 'st'
	%  BRAINATLAS - 4
	%  BRAINATLAS_TAG - 'brainatlas'
	%  BRAINATLAS_CATEGORY - 'd'
	%  BRAINATLAS_FORMAT - 'it'
	%  A - 5
	%  A_TAG - 'a'
	%  A_CATEGORY - 'r'
	%  A_FORMAT - 'll'
	%  M_DICT - 6
	%  M_DICT_TAG - 'm_dict'
	%  M_DICT_CATEGORY - 'r'
	%  M_DICT_FORMAT - 'di'
	%  METADATA - 'm'
	%  METADATA_NAME - 'metadata'
	%  METADATA_DESCRIPTION - 'Metadata NOT used in the calculation of the results (does not allow callbacks, not cloned).'
	%  PARAMETER - 'p'
	%  PARAMETER_NAME - 'parameter'
	%  PARAMETER_DESCRIPTION - 'Parameter used to calculate the results of the element (allows incoming and outgoing callbacks, cloned).'
	%  DATA - 'd'
	%  DATA_NAME - 'data'
	%  DATA_DESCRIPTION - 'Data used to calculate the results of the element (can be NoResult when not set, allows incoming and outgoing callbacks, not cloned).'
	%  RESULT - 'r'
	%  RESULT_NAME - 'result'
	%  RESULT_DESCRIPTION - 'Result calculated by the element using parameters and data (can be NoResult when not calculated, allows incoming callbacks).'
	%  FIGURE - 'f'
	%  FIGURE_NAME - 'figure'
	%  FIGURE_DESCRIPTION - 'Parameter used to plot the results in a figure (allows incoming and outgoing callbacks, not cloned).'
	%  GUI - 'g'
	%  GUI_NAME - 'gui'
	%  GUI_DESCRIPTION - 'Parameter used by the graphical user interface (allows incoming and outgoing callbacks, not cloned).'
	%  EMPTY - 'em'
	%  EMPTY_NAME - 'empty'
	%  EMPTY_DESCRIPTION - 'Empty has an empty value and is typically used as a result to execute some code.'
	%  STRING - 'st'
	%  STRING_NAME - 'string'
	%  STRING_DESCRIPTION - 'String is a char array.'
	%  LOGICAL - 'lo'
	%  LOGICAL_NAME - 'logical'
	%  LOGICAL_DESCRIPTION - 'Logical is a boolean value.'
	%  OPTION - 'op'
	%  OPTION_NAME - 'option'
	%  OPTION_DESCRIPTION - 'Option is a char array representing an option within a set defined in the element.'
	%  CLASS - 'ca'
	%  CLASS_NAME - 'class'
	%  CLASS_DESCRIPTION - 'Class is a char array corresponding to an element class.'
	%  CLASSLIST - 'cl'
	%  CLASSLIST_NAME - 'classlist'
	%  CLASSLIST_DESCRIPTION - 'ClassList is a cell array with char arrays corresponding to element classes.'
	%  ITEM - 'it'
	%  ITEM_NAME - 'item'
	%  ITEM_DESCRIPTION - 'Item is a pointer to an element of a class defined in the element.'
	%  ITEMLIST - 'il'
	%  ITEMLIST_NAME - 'itemlist'
	%  ITEMLIST_DESCRIPTION - 'ItemList is a cell array with pointers to elements of a class defined in the element.'
	%  IDICT - 'di'
	%  IDICT_NAME - 'idict'
	%  IDICT_DESCRIPTION - 'Idict is an indexed dictionary of elements of a class defined in the element.'
	%  SCALAR - 'nn'
	%  SCALAR_NAME - 'scalar'
	%  SCALAR_DESCRIPTION - 'Scalar is a scalar numerical value.'
	%  RVECTOR - 'nr'
	%  RVECTOR_NAME - 'rvector'
	%  RVECTOR_DESCRIPTION - 'Rvector is a numerical row vector.'
	%  CVECTOR - 'nc'
	%  CVECTOR_NAME - 'cvector'
	%  CVECTOR_DESCRIPTION - 'Cvector is a numerical column vector.'
	%  MATRIX - 'nm'
	%  MATRIX_NAME - 'matrix'
	%  MATRIX_DESCRIPTION - 'Matrix is a numerical matrix.'
	%  SMATRIX - 'ns'
	%  SMATRIX_NAME - 'smatrix'
	%  SMATRIX_DESCRIPTION - 'Smatrix is a numerical square matrix.'
	%  CELL - 'll'
	%  CELL_NAME - 'cell'
	%  CELL_DESCRIPTION - 'Cell is a 2D cell array of numeric data, typically used for adjaciency matrices and measures.'
	%  NET - 'ml'
	%  NET_NAME - 'net'
	%  NET_DESCRIPTION - 'Net is a MatLab neural network object.'
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
	methods (Static) % static methods
		% basic methods
		function graph_type = getGraphType(g)
		    %GETGRAPHTYPE returns the graph type.
		    %
		    % GRAPH_TYPE = GETGRAPHTYPE(G) returns the graph type of graph G (e.g.,
		    %  GRAPH, MULTIGRAPH, ORDERED_MULTIPLEX, MULTIPLEX, ORDERED_MULTILAYER,
		    %  MULTILAYER)
		    %
		    % GRAPH_TYPE = GETGRAPHTYPE(GRAPH_CLASS) returns the graph type of the
		    %  graph whose class is GRAPH_CLASS (e.g., GRAPH, MULTIGRAPH,
		    %  ORDERED_MULTIPLEX, MULTIPLEX, ORDERED_MULTILAYER, MULTILAYER)
		    %
		    % See also is_graph, is_multigraph, is_multilayer, is_multiplex,
		    % is_ordered_multilayer, is_ordered_multiplex.
		    
		    % % %TODO: Improve this (connected with MeasurePatam in AnalyzeEnsemble and CompareEnsemble)
		    if nargin < 1
		        graph_type = 0;
		        return;
		    end
		
		    if strcmp(Element.getClass(g), 'Graph')
		        graph_type = Graph.GRAPH;
		    else
		        graph_type = eval([Element.getClass(g) '.getGraphType()']);
		    end
		end
		function bool = is_graph(g)
		    %IS_GRAPH checks if graph is graph (single layer).
		    %
		    % BOOL = IS_GRAPH(G) returns if the instance of the concrete graph G is
		    %  graph (single layer).
		    %
		    % BOOL = IS_GRAPH(GRAPH_CLASS) returns true if graph whose class is
		    %  GRAPH_CLASS is graph (single layer). 
		    %
		    % See also getGraphType, is_multigraph, is_multilayer, is_multiplex,
		    % is_ordered_multilayer, is_ordered_multiplex. 
		
		    bool = Graph.getGraphType(g) == Graph.GRAPH;
		end
		function bool = is_multigraph(g)
		    %IS_MULTIGRAPH checks if graph is multigraph.
		    %
		    % BOOL = IS_MULTIGRAPH(G) returns if the instance of the concrete graph G
		    %  is multigraph.
		    %
		    % BOOL = IS_MULTIGRAPH(GRAPH_CLASS) returns true if graph whose class is
		    %  GRAPH_CLASS is multigraph.
		    %
		    % See also getGraphType, is_graph, is_multilayer, is_multiplex,
		    % is_ordered_multilayer, is_ordered_multiplex.
		
		    bool = g.getGraphType() == Graph.MULTIGRAPH;
		end
		function bool = is_ordered_multiplex(g)
		    %IS_ORDERED_MULTIPLEX checks if graph is ordered multiplex.
		    %
		    % BOOL = IS_ORDERED_MULTIPLEX(G) returns if the instance of the concrete
		    %  graph G is ordered multiplex.
		    %
		    % BOOL = IS_ORDERED_MULTIPLEX(GRAPH_CLASS) returns true if graph whose
		    %  class is GRAPH_CLASS is ordered multiplex.
		    %
		    % See also getGraphType, is_graph, is_multigraph, is_multilayer,
		    % is_multiplex, is_ordered_multilayer.
		
		    bool = Graph.getGraphType(g) == Graph.ORDERED_MULTIPLEX;
		end
		function bool = is_multiplex(g)
		    %IS_MULTIPLEX checks if graph is multiplex.
		    %
		    % BOOL = IS_MULTIPLEX(G) returns if the instance of the concrete graph G is
		    %  multiplex.
		    %
		    % BOOL = IS_MULTIPLEX(GRAPH_CLASS) returns true if graph whose class is
		    %  GRAPH_CLASS is multiplex.
		    %
		    % See also getGraphType, is_graph, is_multigraph, is_multilayer,
		    % is_ordered_multilayer, is_ordered_multiplex.
		
		    bool = Graph.getGraphType(g) == Graph.MULTIPLEX;
		end
		function bool = is_ordered_multilayer(g)
		    %IS_ORDERED_MULTILAYER checks if graph is ordered multilayer.
		    %
		    % BOOL = IS_ORDERED_MULTILAYER(G) returns if the instance of the concrete
		    %  graph G is ordered multilayer.
		    %
		    % BOOL = IS_ORDERED_MULTILAYER(GRAPH_CLASS) returns true if graph whose
		    %  class is GRAPH_CLASS is ordered multilayer.
		    %
		    % See also getGraphType, is_graph, is_multigraph, is_multilayer,
		    % is_multiplex, is_ordered_multiplex.
		
		    bool = Graph.getGraphType(g) == Graph.ORDERED_MULTILAYER;
		end
		function bool = is_multilayer(g)
		    %IS_MULTILAYER checks if graph is multilayer
		    %
		    % BOOL = IS_MULTILAYER(G) returns if the instance of the concrete graph G
		    %  is multilayer.
		    %
		    % BOOL = IS_MULTILAYER(GRAPH_CLASS) returns true if graph whose class is
		    %  GRAPH_CLASS is multilayer.
		    %
		    % See also getGraphType, is_graph, is_multigraph, is_multiplex,
		    % is_ordered_multilayer, is_ordered_multiplex.
		
		    bool = Graph.getGraphType(g) == Graph.MULTILAYER;
		end
		function connectivity_type = getConnectivityType(g, varargin)
		    %GETCONNECTIVITYTYPE returns the connectivity type of the graph.
		    %
		    % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE(G) returns the connectivity type
		    %  of the instance of the concrete graph G.
		    %
		    % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE(GRAPH_CLASS) returns the
		    %  connectivity type of the graph whose class is GRAPH_CLASS.
		    %
		    % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE(G | GRAPH_CLASS, LAYERNUMBER)
		    %  returns a matrix with the connectivity type of each layer in
		    %  a multiple layer graph.
		    %
		    % See also is_binary, is_weighted.
		
		    if isnumeric(g) || strcmp(Element.getClass(g), 'Graph')
		        connectivity_type = Graph.WEIGHTED;
		    else
		        connectivity_type = eval([Element.getClass(g) '.getConnectivityType(varargin{:})']);
		    end
		end
		function bool = is_weighted(g, varargin)
		    %IS_WEIGHTED checks if graph is weighted.
		    %
		    % BOOL = IS_WEIGHTED(G) returns if the instance of the concrete graph G is
		    %  weighted.
		    %
		    % BOOL = IS_WEIGHTED(GRAPH_CLASS) returns true if graph whose class is
		    %  GRAPH_CLASS is weighted.
		    %
		    % See also getConnectivityType, is_binary.
		
		    bool = Graph.getConnectivityType(g, varargin{:}) == Graph.WEIGHTED;
		end
		function bool = is_binary(g, varargin)
		    %IS_BINARY checks if graph is binary
		    %
		    % BOOL = IS_BINARY(G) returns if the instance of the concrete graph G is
		    %  binary.
		    %
		    % BOOL = IS_BINARY(GRAPH_CLASS) returns true if graph whose class is
		    %  GRAPH_CLASS is binary.
		    %
		    % See also getConnectivityType, is_weighted.
		
		    bool = Graph.getConnectivityType(g, varargin{:}) == Graph.BINARY;
		end
		function directionality_type = getDirectionalityType(g, varargin)
		    %GETDIRECTIONALITYTYPE returns the directionality type of the graph.
		    %
		    % DIRECTIONALITY_TYPE = GETDIRECTIONALITYTYPE(G) returns the directionality
		    %  type of the instance of the concrete graph G.
		    %
		    % DIRECTIONALITY_TYPE = GETDIRECTIONALITYTYPE(GRAPH_CLASS) returns the
		    %  directionality type of the graph whose class is GRAPH_CLASS.
		    %
		    % DIRECTIONALITY_TYPE = GETDIRECTIONALITYTYPE(G | GRAPH_CLASS, LAYERNUMBER)
		    %  returns a matrix with the directionality type of each layer
		    %  in a multiple layer graph.
		    %
		    % See also is_directed, is_undirected.
		
		    if isnumeric(g) || strcmp(Element.getClass(g), 'Graph')
		        directionality_type = Graph.DIRECTED;
		    else
		        directionality_type = eval([Element.getClass(g) '.getDirectionalityType(varargin{:})']);
		    end
		end
		function bool = is_directed(g, varargin)
		    %IS_DIRECTED checks if graph is directed
		    %
		    % BOOL = IS_DIRECTED(G) returns if the instance of the concrete graph G is
		    %  directed.
		    %
		    % BOOL = IS_DIRECTED(GRAPH_CLASS) returns true if graph whose class is
		    %  GRAPH_CLASS is directed.
		    %
		    % See also getDirectionalityType, is_undirected.
		
		    bool = Graph.getDirectionalityType(g, varargin{:}) == Graph.DIRECTED;
		end
		function bool = is_undirected(g, varargin)
		    %IS_UNDIRECTED checks if graph is undirected.
		    %
		    % BOOL = IS_UNDIRECTED(G) returns if the instance of the concrete graph G
		    %  is undirected.
		    %
		    % BOOL = IS_UNDIRECTED(GRAPH_CLASS) returns true if graph whose class is
		    %  GRAPH_CLASS is undirected.
		    %
		    % See also getDirectionalityType, is_directed.
		
		    bool = Graph.getDirectionalityType(g, varargin{:}) == Graph.UNDIRECTED;
		end
		function selfconnectivity_type = getSelfConnectivityType(g, varargin)
		    %GETSELFCONNECTIVITYTYPE returns the self-connectivity type of the graph.
		    %
		    % SELFCONNECTIVITY_TYPE = GETSELFCONNECTIVITYTYPE(G) returns the
		    %  self-connectivity type of the instance of the concrete graph G.
		    %
		    % SELFCONNECTIVITY_TYPE = GETSELFCONNECTIVITYTYPE(GRAPH_CLASS) returns the
		    %  self-connectivity type of the graph whose class is GRAPH_CLASS.
		    %
		    % SELFCONNECTIVITY_TYPE = GETSELFCONNECTIVITYTYPE(G | GRAPH_CLASS, LAYERNUMBER)
		    %  returns a matrix with the self-connectivity  type of each layer
		    %  in a multiple layer graph.
		    %
		    % See also is_selfconnected, is_not_selfconnected.
		
		    if isnumeric(g) || strcmp(Element.getClass(g), 'Graph')
		        selfconnectivity_type = Graph.SELFCONNECTED;
		    else
		        selfconnectivity_type = eval([Element.getClass(g) '.getSelfConnectivityType(varargin{:})']);
		    end
		end
		function bool = is_selfconnected(g, varargin)
		    %IS_SELFCONNECTED checks if graph is self-connected.
		    %
		    % BOOL = IS_SELFCONNECTED(G) returns true if the instance of the concrete
		    %  graph G is self-connected and false otherwise.
		    %
		    % BOOL = IS_SELFCONNECTED(GRAPH_CLASS) returns true if graph whose class is
		    %  GRAPH_CLASS is self-connected and false otherwise.
		    %
		    % See also getSelfConnectivityType, is_not_selfconnected.
		
		    bool = Graph.getSelfConnectivityType(g, varargin{:}) == Graph.SELFCONNECTED;
		end
		function bool = is_not_selfconnected(g, varargin)
		    %IS_NONSELFCONNECTED checks if graph is not self-connected.
		    %
		    % BOOL = IS_NONSELFCONNECTED(G) returns true if the instance of the
		    %  concrete graph G is not self-connected and false otherwise.
		    %
		    % BOOL = IS_NONSELFCONNECTED(GRAPH_CLASS) returns true if graph whose class
		    %  is GRAPH_CLASS is not self-connected and false otherwise.
		    %
		    % See also getSelfConnectivityType, is_selfconnected.
		
		    bool = Graph.getSelfConnectivityType(g, varargin{:}) == Graph.NONSELFCONNECTED;
		end
		function negativity_type = getNegativityType(g, varargin)
		    %GETNEGATIVITYTYPE returns the negativity type of the graph.
		    %
		    % NEGATIVITY_TYPE = GETNEGATIVITYTYPE(G) returns the negativity type of the
		    %  instance of the concrete graph G.
		    %
		    % NEGATIVITY_TYPE = GETNEGATIVITYTYPE(GRAPH_CLASS) returns the negativity
		    %  type of the graph whose class is GRAPH_CLASS.
		    %
		    % NEGATIVITY_TYPE = GETNEGATIVITYTYPE(G | GRAPH_CLASS, LAYERNUMBER)
		    %  returns a matrix with the negativity  type of each layer in
		    %  a multiple layer graph.
		    %
		    % See also is_negative, is_nonnegative.
		
		    if isnumeric(g) || strcmp(Element.getClass(g), 'Graph')
		        negativity_type = Graph.NEGATIVE;
		    else
		        negativity_type = eval([Element.getClass(g) '.getNegativityType(varargin{:})']);
		    end
		end
		function bool = is_nonnegative(g, varargin)
		    %IS_NONNEGATIVE checks whether graph allows non-negative values.
		    %
		    % BOOL = IS_NONNEGATIVE(G) returns true if the concrete instance of graph G
		    %  allows non-negative values and false otherwise.
		    %
		    % BOOL = IS_NONNEGATIVE(GRAPH_CLASS) returns true if the graph whose class
		    % is GRAPH_CLASS allows non-negative values and false otherwise.
		    %
		    % See also getNegativityType, is_negative.
		
		    bool = Graph.getNegativityType(g, varargin{:}) == Graph.NONNEGATIVE;
		end
		function bool = is_negative(g, varargin)
		    %IS_NEGATIVE checks whether graph allows negative values.
		    %
		    % BOOL = IS_NEGATIVE(G) returns true if the concrete instance of graph G
		    %  allows negative values and false otherwise.
		    %
		    % BOOL = IS_NEGATIVE(GRAPH_CLASS) returns true if the graph whose class is
		    % GRAPH_CLASS allows negative values and false otherwise.
		    %
		    % See also getNegativityType, is_nonnegative.
		
		    bool = Graph.getNegativityType(g, varargin{:}) == Graph.NEGATIVE;
		end
		% check methods
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
		    assert(iscell(A) && ismatrix(A) && size(A, 1) == size(A, 2), ...
		        [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		        'A must be a superadjacency matrix (square cell array of matrices).')
		    % all submatrices in the diagonal are square
		    assert(all(cellfun(@(a) size(a, 1) == size(a, 2), A(1:length(A)+1:end))), ...
		        [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		        'All submatrices in the cell diagonal must be square.')
		
		    % Additional checks
		    switch graph_type
		        case Graph.GRAPH
		            % no additional checks
		
		        case  Graph.MULTIGRAPH
		            % no additional checks
		
		        case Graph.ORDERED_MULTIPLEX
		            % all matrixes in diagonal +/- 1 same dimensions
		            assert(all(cellfun(@(a) size(a, 1), A(1:length(A)+1:end)) == cellfun(@(a) size(a, 1), A(1, 1))), ...
		                [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		                'In a sequence, submatrices in the cell diagonal must have the same dimensions.')
		            assert(all(cellfun(@(a) size(a, 1), A(2:length(A)+1:end)) == cellfun(@(a) size(a, 1), A(1, 1))), ...
		                [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		                'In a sequence, submatrices in the cell sub-diagonal must have the same dimensions.')
		            assert(all(cellfun(@(a) size(a, 1), A(length(A)+1:length(A)+1:end)) == cellfun(@(a) size(a, 1), A(1, 1))), ...
		                [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		                'In a sequence, submatrices in the cell super-diagonal must have the same dimensions.')
		
		        case Graph.MULTIPLEX
		            assert(all(cellfun(@(a) size(a, 1) == size(a, 2), A(:))), ...
		                [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		                'In a multiplex, all submatrices must be square.')
		            % check they are all submatrices have same dimensions.
		            assert(all(cellfun(@(a) size(a, 1), A(:)) == cellfun(@(a) size(a, 1), A(1, 1))), ...
		                [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		                'In a multiplex, all submatrices must have the same dimensions.')
		
		        case Graph.ORDERED_MULTILAYER
		            assert(all(cellfun(@(a) size(a, 1), A(2:length(A)+1:end)) == cellfun(@(a) size(a, 1), A(length(A)+2:length(A)+1:end))), ...
		                [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		                'Sub-diagonal submatrices in the same row must have the same number of rows.')
		            assert(all(cellfun(@(a) size(a, 2), A(2:length(A)+1:end)) == cellfun(@(a) size(a, 2), A(1:length(A)+1:length(A)*2-1))), ...
		                [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		                'Sub-diagonal submatrices in the same column must have the same number of columns.')
		            assert(all(cellfun(@(a) size(a, 1), A(length(A)+1:length(A)+1:end)) == cellfun(@(a) size(a, 1), A(1:length(A)+1:length(A)*2-1))), ...
		                [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		                'Super-diagonal submatrices in the same row must have the same number of rows.')
		            assert(all(cellfun(@(a) size(a, 2), A(length(A)+1:length(A)+1:end)) == cellfun(@(a) size(a, 2), A(length(A)+2:length(A)+1:end))), ...
		                [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		                'Super-diagonal submatrices in the same column must have the same number of columns.')
		
		        case Graph.MULTILAYER
		            assert(all(all(cellfun(@(a) size(a, 1), A) == cellfun(@(a) size(a, 1), A(:, 1)))), ...
		                [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		                'All submatrices in the same row must have the same number of rows.')
		            assert(all(all(cellfun(@(a) size(a, 2), A) == cellfun(@(a) size(a, 2), A(1, :)))), ...
		                [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		                'All submatrices in the same column must have the same number of columns.')
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
		            case Graph.BINARY
		                assert(all(all(A == 0 | A == 1)), ...
		                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		                    ['For connectivity type Graph.BINARY, A must be binary (0s and 1s),' ...
		                    ' while it is ' tostring(A)])
		
		            case Graph.WEIGHTED
		                % no further check needed
		
		            otherwise
		                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		                    ['Connectivity type must be Graph.BINARY (%i) or Graph.WEIGHTED (%i),' ...
		                    ' while it is ' tostring(connectivity_type)], ...
		                    Graph.BINARY, Graph.WEIGHTED)
		        end
		    else  % A is 2D cell array
		
		        if numel(connectivity_type) == 1
		            connectivity_type = connectivity_type * ones(size(A));
		        end
		
		        for i = 1:1:size(A, 1)
		            for j = 1:1:size(A, 2)
		                Graph.checkConnectivity(connectivity_type(i, j), A{i, j});
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
		            case Graph.UNDIRECTED
		                assert(all(all(A == At)), ...
		                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		                    ['For directionality type Graph.UNDIRECTED, A must equal to At,' ...
		                    ' while it is A = ' tostring(A) ...
		                    ' and At = ' tostring(At)])
		
		            case Graph.DIRECTED
		                % no further check needed
		
		            otherwise
		                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		                    ['Directionality type must be Graph.DIRECTED (%i) or Graph.UNDIRECTED (%i),' ...
		                    ' while it is ' tostring(directionality_type)], ...
		                    Graph.DIRECTED, Graph.UNDIRECTED)
		        end
		    else  % A is 2D cell array
		
		        if numel(directionality_type) == 1
		            directionality_type = directionality_type * ones(size(A));
		        end
		        assert(all(all(directionality_type == directionality_type')), ...
		            [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		            ['The directionality type must be symmetric,' ...
		            ' while it is ' tostring(directionality_type)])
		
		        for i = 1:1:size(A, 1)
		            for j = 1:1:size(A, 2)
		                Graph.checkDirectionality(directionality_type(i, j), A{i, j}, A{j, i}');
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
		            case Graph.NONSELFCONNECTED
		                assert(all(all(A(1:length(A)+1:end) == 0)), ...
		                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		                    ['For self-connectivity type Graph.NONSELFCONNECTED, A must have' ...
		                    ' 0 values along the diagonal while it is ' tostring(A)])
		
		            case Graph.SELFCONNECTED
		                % no further check needed
		
		            otherwise
		                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		                    ['Self-connectivity type must be Graph.SELFCONNECTED (%i) or' ...
		                    ' Graph.NONSELFCONNECTED (%i), while it is ' tostring(selfconnectivity_type)], ...
		                    Graph.SELFCONNECTED, Graph.NONSELFCONNECTED)
		        end
		    else  % A is 2D cell array
		
		        if numel(selfconnectivity_type) == 1
		            selfconnectivity_type = selfconnectivity_type * ones(size(A));
		        end
		
		        for i = 1:1:size(A, 1)
		            Graph.checkSelfConnectivity(selfconnectivity_type(i, i), A{i, i});
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
		            case Graph.NONNEGATIVE
		                assert(all(all(A >= 0)), ...
		                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		                    ['For negativity type Graph.NONNEGATIVE, A must have' ...
		                    ' non-negative values, while it is ' tostring(A)])
		
		            case Graph.NEGATIVE
		                % no further check needed
		
		            otherwise
		                error([BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		                    ['Negativity type must be Graph.NEGATIVE (%i) or' ...
		                    ' Graph.NONNEGATIVE (%i), while it is ' tostring(negativity_type)], ...
		                    Graph.NEGATIVE, Graph.NONNEGATIVE)
		        end
		    else  % A is 2D cell array
		
		        if numel(negativity_type) == 1
		            negativity_type = negativity_type * ones(size(A));
		        end
		
		        for i = 1:1:size(A, 1)
		            for j = 1:1:size(A, 2)
		                Graph.checkNegativity(negativity_type(i, j), A{i, j});
		            end
		        end
		    end
		end
		function list = getCompatibleMeasureList(g)
		    % GETCOMPATIBLEMEASURELIST returns the list of measures
		    %
		    % CELL ARRAY = GETCOMPATIBLEMEASURELIST(G) returns a cell array of
		    % compatible measures to the concrete graph G.
		    %
		    % CELL ARRAY = GETCOMPATIBLEMEASURELIST(GRAPH_CLASS) returns a
		    % cell array of compatible measures to a graph whose class is
		    % GRAPH_CLASS.
		    %
		    % See also Measure.
		
		    graph_class = g.getClass();
		
		    measure_code_list = Measure.getList();
		
		    list = cell(1, length(measure_code_list));
		    for i = 1:1:length(measure_code_list)
		        measure_code = measure_code_list{i};
		        compatible_graph_list = Measure.getCompatibleGraphList(measure_code);
		
		        if any(strcmp(compatible_graph_list, graph_class))
		            list{i} = measure_code;
		        end
		    end
		    list(cellfun('isempty', list)) = [];
		end
		% subgraphs
		function sg = subgraph(g, nodes)
		    %SUBGRAPH extracts subgraph
		    %
		    % SG = SUBGRAPH(G, NODES) extracts the graph SG as a subgraph of G
		    %  containing only the nodes specified by NODES.
		    %  If NODES is a vector, the specified nodes are kept from
		    %  all layers. If NODES is a cell array of vectors, the
		    %  specified nodes are kept from each layer.
		    % 
		    % see also nodeattack, edgeattack.
		
		A = g.get('A');
		L = g.layernumber();
		
		if ~iscell(nodes)
		    nodes = repmat({nodes}, 1, L);
		end
		
		switch Graph.getGraphType(g)
		    case Graph.GRAPH
		        B = A{1};
		        B = B(nodes{1}, nodes{1});
		        
		    otherwise  % multigraph, multiplex 
		        for li = 1:1:L
		            Aii = A{li, li};
		            if ~isempty(Aii)
		                B(li) = {Aii(nodes{li}, nodes{li})};
		            end
		        end
		end
		
		sg = eval([g.getClass() '(''B'', B)']);
		
		end
		function ga = nodeattack(g, nodes, layernumbers)
		    %NODEATTACK removes given nodes from a graph
		    %
		    % GA = NODEATTACK(G, NODES) creates the graph GA resulting by removing
		    %  the nodes specified by NODES from G. For non single layer
		    %  graphs, it removes NODES in every layer.
		    %
		    % GA = NODEATTACK(G, NODES, LAYERNUMBERS) creates the graph GA
		    %  resulting by removing the nodes specified by NODES from G.
		    %  For non single layer graphs, it removes NODES in the layers
		    %  specified by LAYERNUMBERS.
		    %
		    % NODES are removed by setting all the connections from and to
		    %  the nodes in the connection matrix to 0.
		    %
		    % See also edgeattack, subgraphs.
		
		if nargin < 3
		    layernumbers = 1:1:g.layernumber();
		end
		
		A = g.get('A');
		
		switch Graph.getGraphType(g)
		    case Graph.GRAPH
		        A = A{1};
		        A(nodes(:), :) = 0;
		        A(:, nodes(:)) = 0;
		      
		    otherwise
		        for li = layernumbers
		            Aii = A{li, li};
		            Aii(nodes(:), :) = 0;
		            Aii(:, nodes(:)) = 0;
		            A(li, li) = {Aii};
		            if Graph.getGraphType(g) ~= Graph.MULTIGRAPH
		                for lj = 1:1:g.layernumber()
		                    Aij = A{li, lj};  % li cell row
		                    Aji = A{lj, li};  % li cell column
		                    if isempty(Aij) == 0
		                        Aij(nodes(:), :) = 0;
		                        Aij(:, nodes(:)) = 0;
		                    end
		                    if isempty(Aji) == 0
		                        Aji(nodes(:), :) = 0;
		                        Aji(:, nodes(:)) = 0;
		                    end
		                    A(li, lj) = {Aij};
		                    A(lj, li) = {Aji};
		                end
		            end
		        end
		end
		ga = eval([g.getClass()  '(''B'', A)']);
		end
		function ga = edgeattack(g, nodes1, nodes2, layernumbers1, layernumbers2)
		    %EDGEATTACK removes given edges from a graph
		    %
		    % GA = EDGEATTACK(G, NODES1, NODES2) creates the graph GA resulting
		    %  by removing the edges going from NODES1 to NODES2 from G. For
		    %  non single layer graphs, it removes the edges from NODES1 to
		    %  NODES2 in every layer.
		    %
		    % GA = EDGEATTACK(G, NODES1, NODES2, LAYERNUMBERS_I) creates the graph GA
		    %  resulting by removing the edges going from NODES1 to NODES2 from G.
		    %  For non single layer graphs, it removes the edges from NODES1 to
		    %  NODES2 in the layers specified by LAYERNUMBERS.
		    %
		    % GA = EDGEATTACK(G, NODES1, NODES2, LAYERNUMBERS_I, LAYERNUMBERS_J)
		    %  creates the graph GA resulting by removing the edges going
		    %  from NODES1 to NODES2 from G. For non single layer graphs, it
		    %  removes the edges from NODES1 to NODES2 in and between the layers
		    %  specified by LAYERNUMBERS_I and LAYERNUMBERS_J.
		    %
		    % EDGES are removed by setting all the connections from NODES1 to
		    %  NODES2 in the connection matrix to 0.
		    %
		    % NODES1 and NODES2 must have the same dimensions.
		    %
		    % See also nodeattack, subgraphs.
		
		if nargin < 4
		    layernumbers1 = 1:1:g.layernumber();
		end
		
		if nargin < 5
		    layernumbers2 = layernumbers1;
		end
		
		A = g.get('A');
		
		switch Graph.getGraphType(g)
		    case Graph.GRAPH
		        if iscell(A)
		            A = A{1};
		        end
		        A(sub2ind(size(A), nodes1, nodes2)) = 0;
		        
		        if g.is_undirected(g)
		            A(sub2ind(size(A), nodes2, nodes1)) = 0;
		        end
		        
		    otherwise
		        directionality = g.getDirectionalityType(g.layernumber());
		        for n = 1:1:length(layernumbers1)
		            li = layernumbers1(n);
		            lj = layernumbers2(n);
		            
		            Aij = A{li, lj};
		            Aij(sub2ind(size(Aij), nodes1, nodes2)) = 0;
		            A(li, lj) = {Aij};
		            
		            if directionality(li, lj) == Graph.UNDIRECTED
		                Aji = A{lj, li};
		                Aji(sub2ind(size(Aji), nodes2, nodes1)) = 0;
		                A(lj, li) = {Aji};
		            end
		        end
		end
		ga = eval([g.getClass()  '(''B'', A)']);
		end
	end
	properties (Constant) % properties
		ID = 1;
		ID_TAG = 'id';
		ID_CATEGORY = Category.DATA;
		ID_FORMAT = Format.STRING;
		
		LABEL = 2;
		LABEL_TAG = 'label';
		LABEL_CATEGORY = Category.METADATA;
		LABEL_FORMAT = Format.STRING;
		
		NOTES = 3;
		NOTES_TAG = 'notes';
		NOTES_CATEGORY = Category.METADATA;
		NOTES_FORMAT = Format.STRING;
		
		BRAINATLAS = 4;
		BRAINATLAS_TAG = 'brainatlas';
		BRAINATLAS_CATEGORY = Category.DATA;
		BRAINATLAS_FORMAT = Format.ITEM;
		
		A = 5;
		A_TAG = 'a';
		A_CATEGORY = Category.RESULT;
		A_FORMAT = Format.CELL;
		
		M_DICT = 6;
		M_DICT_TAG = 'm_dict';
		M_DICT_CATEGORY = Category.RESULT;
		M_DICT_FORMAT = Format.IDICT;
	end
	methods (Static) % inspection methods
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
			% See also getName, getDescription.
			
			g_class = 'Graph';
		end
		function g_name = getName()
			%GETNAME returns the name of the graph.
			%
			% NAME = Graph.GETNAME() returns the name of the 'graph'.
			%  Graph.
			%
			% Alternative forms to call this method are:
			%  NAME = G.GETNAME() returns the name of the graph G.
			%  NAME = Element.GETNAME(G) returns the name of 'G'.
			%  NAME = Element.GETNAME('Graph') returns the name of 'Graph'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			g_name = 'Graph';
		end
		function g_description = getDescription()
			%GETDESCRIPTION returns the description of the graph.
			%
			% STR = Graph.GETDESCRIPTION() returns the description of the 'graph'.
			%  which is:
			%
			%  Graph provides the methods necessary for all graphs.
			%  Instances of this class should not be created. 
			%  Use one of its subclasses instead.
			%
			% Alternative forms to call this method are:
			%  STR = G.GETDESCRIPTION() returns the description of the graph G.
			%  STR = Element.GETDESCRIPTION(G) returns the description of 'G'.
			%  STR = Element.GETDESCRIPTION('Graph') returns the description of 'Graph'.
			%
			% See also getClass, getName.
			
			g_description = [
				'Graph provides the methods necessary for all graphs.' ...
				'Instances of this class should not be created. ' ...
				'Use one of its subclasses instead.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph.
			%
			% PROPS = Graph.GETPROPS() returns the property list of graph.
			%
			% PROPS = Graph.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = G.GETPROPS([CATEGORY]) returns the property list of the graph G.
			%  PROPS = Element.GETPROPS(G[, CATEGORY]) returns the property list of 'G'.
			%  PROPS = Element.GETPROPS('Graph'[, CATEGORY]) returns the property list of 'Graph'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						Graph.LABEL
						Graph.NOTES
						];
				case Category.PARAMETER
					prop_list = [
						];
				case Category.DATA
					prop_list = [
						Graph.ID
						Graph.BRAINATLAS
						];
				case Category.RESULT
					prop_list = [
						Graph.A
						Graph.M_DICT
						];
				case Category.FIGURE
					prop_list = [
						];
				case Category.GUI
					prop_list = [
						];
				otherwise
					prop_list = [
						Graph.ID
						Graph.LABEL
						Graph.NOTES
						Graph.BRAINATLAS
						Graph.A
						Graph.M_DICT
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of graph.
			%
			% N = Graph.GETPROPNUMBER() returns the property number of graph.
			%
			% Alternative forms to call this method are:
			%  N = G.GETPROPNUMBER() returns the property number of the graph G.
			%  N = Element.GETPROPNUMBER(G) returns the property number of 'G'.
			%  N = Element.GETPROPNUMBER('Graph') returns the property number of 'Graph'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 6;
		end
		function check = existsProp(prop)
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
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6 ]);
			else
				assert( ...
					Graph.existsProp(prop), ...
					[BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Graph.'] ...
					)
			end
		end
		function check = existsTag(tag)
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
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				graph_tag_list = { 'id'  'label'  'notes'  'brainatlas'  'a'  'm_dict' };
				
				check = any(strcmpi(tag, graph_tag_list));
			else
				assert( ...
					Graph.existsTag(tag), ...
					[BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for Graph'] ...
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
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				graph_tag_list = { 'id'  'label'  'notes'  'brainatlas'  'a'  'm_dict' };
				
				tag = pointer;
				Graph.existsTag(tag);
				
				prop = find(strcmpi(tag, graph_tag_list));
			else % numeric
				prop = pointer;
				Graph.existsProp(prop);
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
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				Graph.existsTag(tag);
			else % numeric
				prop = pointer;
				Graph.existsProp(prop);
				
				switch prop
					case Graph.ID
						tag = Graph.ID_TAG;
					case Graph.LABEL
						tag = Graph.LABEL_TAG;
					case Graph.NOTES
						tag = Graph.NOTES_TAG;
					case Graph.BRAINATLAS
						tag = Graph.BRAINATLAS_TAG;
					case Graph.A
						tag = Graph.A_TAG;
					case Graph.M_DICT
						tag = Graph.M_DICT_TAG;
				end
			end
		end
		function prop_category = getPropCategory(pointer)
			%GETPROPCATEGORY returns the category of a property.
			%
			% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the
			%  category of the property PROP.
			%
			% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the
			%  category of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CATEGORY = G.GETPROPCATEGORY(POINTER) returns category of POINTER of G.
			%  CATEGORY = Element.GETPROPCATEGORY(Graph, POINTER) returns category of POINTER of Graph.
			%  CATEGORY = G.GETPROPCATEGORY(Graph, POINTER) returns category of POINTER of Graph.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = Graph.getPropProp(pointer);
			
			switch prop
				case Graph.ID
					prop_category = Graph.ID_CATEGORY;
				case Graph.LABEL
					prop_category = Graph.LABEL_CATEGORY;
				case Graph.NOTES
					prop_category = Graph.NOTES_CATEGORY;
				case Graph.BRAINATLAS
					prop_category = Graph.BRAINATLAS_CATEGORY;
				case Graph.A
					prop_category = Graph.A_CATEGORY;
				case Graph.M_DICT
					prop_category = Graph.M_DICT_CATEGORY;
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
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = Graph.getPropProp(pointer);
			
			switch prop
				case Graph.ID
					prop_format = Graph.ID_FORMAT;
				case Graph.LABEL
					prop_format = Graph.LABEL_FORMAT;
				case Graph.NOTES
					prop_format = Graph.NOTES_FORMAT;
				case Graph.BRAINATLAS
					prop_format = Graph.BRAINATLAS_FORMAT;
				case Graph.A
					prop_format = Graph.A_FORMAT;
				case Graph.M_DICT
					prop_format = Graph.M_DICT_FORMAT;
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
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = Graph.getPropProp(pointer);
			
			switch prop
				case Graph.ID
					prop_description = 'ID (data, string) is a few-letter code for the graph.';
				case Graph.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the graph.';
				case Graph.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the graph.';
				case Graph.BRAINATLAS
					prop_description = 'BRAINATLAS (data, item) is a atlas associated with the graph.';
				case Graph.A
					prop_description = 'A (result, cell) is the graph adjacency matrix. ';
				case Graph.M_DICT
					prop_description = 'M_DICT (result, idict) contains the calculated measures of the graph.';
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
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = Graph.getPropProp(pointer);
			
			switch prop
				case Graph.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Graph.LABEL
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Graph.NOTES
					prop_settings = Format.getFormatSettings(Format.STRING);
				case Graph.BRAINATLAS
					prop_settings = 'BrainAtlas';
				case Graph.A
					prop_settings = Format.getFormatSettings(Format.CELL);
				case Graph.M_DICT
					prop_settings = 'Measure';
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
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Graph.getPropProp(pointer);
			
			switch prop
				case Graph.ID
					prop_default = Format.getFormatDefault(Format.STRING, Graph.getPropSettings(prop));
				case Graph.LABEL
					prop_default = Format.getFormatDefault(Format.STRING, Graph.getPropSettings(prop));
				case Graph.NOTES
					prop_default = Format.getFormatDefault(Format.STRING, Graph.getPropSettings(prop));
				case Graph.BRAINATLAS
					prop_default = Format.getFormatDefault(Format.ITEM, Graph.getPropSettings(prop));
				case Graph.A
					prop_default = Format.getFormatDefault(Format.CELL, Graph.getPropSettings(prop));
				case Graph.M_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, Graph.getPropSettings(prop));
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
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Graph.getPropProp(pointer);
			
			prop_default = Graph.conditioning(prop, Graph.getPropDefault(prop));
		end
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
			%  Error id: [BRAPH2:Graph:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  G.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of G.
			%   Error id: [BRAPH2:Graph:WrongInput]
			%  Element.CHECKPROP(Graph, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Graph.
			%   Error id: [BRAPH2:Graph:WrongInput]
			%  G.CHECKPROP(Graph, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Graph.
			%   Error id: [BRAPH2:Graph:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = Graph.getPropProp(pointer);
			
			switch prop
				case Graph.ID
					check = Format.checkFormat(Format.STRING, value, Graph.getPropSettings(prop));
				case Graph.LABEL
					check = Format.checkFormat(Format.STRING, value, Graph.getPropSettings(prop));
				case Graph.NOTES
					check = Format.checkFormat(Format.STRING, value, Graph.getPropSettings(prop));
				case Graph.BRAINATLAS
					check = Format.checkFormat(Format.ITEM, value, Graph.getPropSettings(prop));
				case Graph.A
					check = Format.checkFormat(Format.CELL, value, Graph.getPropSettings(prop));
				case Graph.M_DICT
					check = Format.checkFormat(Format.IDICT, value, Graph.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Graph.getPropTag(prop) ' (' Graph.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function g = Graph(varargin)
			% Graph() creates a graph.
			%
			% Graph(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Graph(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Graph properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code for the graph.
			%  <strong>2</strong> <strong>label</strong> 	LABEL (metadata, string) is an extended label of the graph.
			%  <strong>3</strong> <strong>notes</strong> 	NOTES (metadata, string) are some specific notes about the graph.
			%  <strong>4</strong> <strong>brainatlas</strong> 	BRAINATLAS (data, item) is a atlas associated with the graph.
			%  <strong>5</strong> <strong>a</strong> 	A (result, cell) is the graph adjacency matrix. 
			%  <strong>6</strong> <strong>m_dict</strong> 	M_DICT (result, idict) contains the calculated measures of the graph.
			%
			% See also Category, Format, set, check.
			
			g = g@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = Graph.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(g, prop, value)
			check = true;
			msg = ['Error while checking' tostring(g) ' ' g.getPropTag(prop) '.'];
			
			switch prop
				case Graph.A
					A = value;
					Graph.checkA(Graph.getGraphType(g), A);  % performs all necessary checks on A
					Graph.checkConnectivity(Graph.getConnectivityType(g, length(A)), A);
					Graph.checkDirectionality(Graph.getDirectionalityType(g, length(A)), A);
					Graph.checkSelfConnectivity(Graph.getSelfConnectivityType(g, length(A)), A);
					Graph.checkNegativity(Graph.getNegativityType(g, length(A)), A);
					check = true; % only if no error is thrown by the previous code!
					
				otherwise
					[check, msg] = checkValue@Element(g, prop, value);
					
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(g, prop)
		
			switch prop
				case Graph.A
					rng(g.getPropSeed(Graph.A), 'twister')
					
					value = {};
					
				case Graph.M_DICT
					rng(g.getPropSeed(Graph.M_DICT), 'twister')
					
					value = IndexedDictionary('IT_CLASS', 'Measure', 'IT_KEY', 1);
					
				otherwise
					value = calculateValue@Element(g, prop);
					
			end
		end
	end
	methods % methods
		function n = nodenumber(g)
		    %NODENUMBER returns the number of nodes in the graph.
		    %
		    % N = NODENUMBER(G) returns the number of nodes in graph G. For non single
		    %  layer graphs it returns an array with the number of nodes in each layer.
		    %
		    % See also layernumber.
		
		    A = g.get('A'); %#ok<PROP>
		    n = cellfun(@(a) length(a), A(1:length(A)+1:end)); %#ok<PROP>
		end
		function [l, ls] = layernumber(g)
		    %LAYERNUMBER returns the number of layers in the graph.
		    %
		    % L = LAYERNUMBER(G) returns the number of layers in graph G. L is a scalar.
		    %
		    % [~, LS] = LAYERNUMBER(G) returns the number of layers in the partitions
		    %  of graph G. LS is a vector of integers. By default LS = L, but this
		    %  method should be redefined where needed.
		    %
		    % See also nodenumber.
		
		    l = length(g.get('A'));
		    ls = l;
		end
		function m = getMeasure(g, measure_class, varargin)
		    %GETMEASURE returns measure.
		    %
		    % M = GETMEASURE(G, MEASURE_CLASS) checks if the measure exists in the
		    %  property M_DICT. If not it creates a new measure M of class MEASURE_CLASS
		    %  with properties defined by the graph settings. The user must call
		    %  getValue() for the new measure M to retrieve the value of measure M.
		    
		    m_list = Graph.getCompatibleMeasureList(g);
		    
		    assert( ...
		        contains(measure_class, m_list), ...
		        [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
		        [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT ' '], ...
		        [measure_class ' is not a compatible Measure with ' g.getClass() '. Please use Graph function getCompatibleMeasureList for more information.'])
		    
		    m_dict = g.memorize('M_DICT');
		    if m_dict.containsKey(measure_class)
		        m = m_dict.getItem(measure_class);
		    else
		        m = eval([measure_class '(''ID'', measure_class, ''G'', g, varargin{:})']);
		        m_dict.add(m);
		    end
		end
	end
end
