%% ¡header!
Graph < Element (g, graph) is a graph.

%%% ¡description!
Graph provides the methods necessary for all graphs.
Instances of this class should not be created. 
Use one of its subclasses instead.

%%% ¡seealso!
Measure

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the graph.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph.

%%% ¡prop!
G_DICT (data, idict) contains an ensemble of graphs (only used by graph ensembles).
%%%% ¡settings!
'Graph'

%%% ¡prop!
A (result, cell) is the graph adjacency matrix. 
%%%% ¡calculate!
value = {};
%%%% ¡check_value!
A = value;
Graph.checkA(Graph.getGraphType(g), A);  % performs all necessary checks on A
Graph.checkConnectivity(Graph.getConnectivityType(g, length(A)), A);
Graph.checkDirectionality(Graph.getDirectionalityType(g, length(A)), A);
Graph.checkSelfConnectivity(Graph.getSelfConnectivityType(g, length(A)), A);
Graph.checkNegativity(Graph.getNegativityType(g, length(A)), A);
check = true; % only if no error is thrown by the previous code!

%%% ¡prop!
M_DICT (result, idict) contains the calculated measures of the graph.
%%%% ¡settings!
'Measure'
%%%% ¡calculate!
value = IndexedDictionary('IT_CLASS', 'Measure', 'IT_KEY', 1);

%% ¡constants!

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

%% ¡staticmethods!
% basic methods
function bool = is_ensemble(g)
    %IS_ENSEMBLE returns whther a graph is an ensemble of graphs.
    %
    % BOOL = IS_ENSEMBLE(G) returns whether the instance of the concrete graph
    %  G is an ensemble of graphs. 
    %
    % BOOL = IS_ENSEMBLE(GRAPH_CLASS) returns true if graph whose class is
    % GRAPH_CLASS is an ensemble of graphs.

    if strcmp(Element.getClass(g), 'Graph')
        bool = false;
    else
        bool = eval([Element.is_ensemble(g) '.is_ensemble()']);
    end    
end
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
% subgraphs
function sg = subgraph(g, nodes)
% SUBGRAPH extracts subgraph
%
% SG = SUBGRAPH(G, NODES) extracts the graph SG as a subgraph of G
% containing only the nodes specified by NODES.
% If NODES is a vector, the specified nodes are removed from
% all layers. If NODES is a cell array of vectors, the
% specified nodes are removed from each layer.

A = g.get('B');
L = g.layernumber();

if ~iscell(nodes)
    nodes = repmat({nodes}, 1, L);
end

switch Graph.getGraphType(g)
    case Graph.GRAPH
        A = A(nodes{1}, nodes{1});
        
    otherwise  % multigraph, multiplex and multilayer
        for li = 1:1:L
            Aij = A{li};
            if ~isempty(Aij)
                A(li) = {Aij(nodes{li})};
            end
        end
end

sg = eval([g.getClass() '(''B'', A)']);

end

%% ¡methods!
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
function n = layernumber(g)
    %LAYERNUMBER returns the number of layers in the graph.
    %
    % N = LAYERNUMBER(G) returns the number of layers in graph G.
    %
    % See also nodenumber.

    n = length(g.get('A'));
end
function m = getMeasure(g, measure_class, varargin)
    %GETMEASURE returns measure.
    %
    % M = GETMEASURE(G, MEASURE_CLASS) checks if the measure exists in the
    % property MDICT. If not it creates a new measure M of class MEASURE_CLASS
    % with properties defined by the graph settings. The user must call
    % getValue() for the new measure M to retrieve the value of measure M.

    m_dict = g.memorize('M_DICT');
    if m_dict.containsKey(measure_class)
        m = m_dict.getItem(measure_class);
    else
        m = eval([measure_class '(''ID'', measure_class, ''G'', g, varargin{:})']);
        m_dict.add(m);
    end
end