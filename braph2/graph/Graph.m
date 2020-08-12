classdef Graph < handle & matlab.mixin.Copyable
    % Graph (Abstract) A graph
    % Graph provides the methods necessary for all graphs.
    % It is a subclass of handle and matlab.mixin.Copyable.
    %
    % Graph provides the methods necessary for all graphs.
    % Instances of this class cannot be created. Use one of the subclasses.
    % The subclasses must be created inside the folder
    % ./braph2/graph/graphs/.
    %
    % Graph properties (constants):
    %   GRAPH                       - single layer graph
    %   GRAPH_NAME                  - name of GRAPH
    %   GRAPH_DESCRIPTION           - description of GRAPH
    %
    %   MULTIGRAPH                  - multiple unconnected graphs
    %   MULTIGRAPH_NAME             - name of MULTIGRAPH
    %   MULTIGRAPH_DESCRIPTION      - description of MULTIGRAPH
    %
    %   ORDERED_MULTIPLEX           - ordered multiplex graph
    %   ORDERED_MULTIPLEX_NAME      - name of ORDERED_MULTIPLEX
    %   ORDERED_MULTIPLEX_DESCRIPTION - description of ORDERED_MULTIPLEX
    %
    %   MULTIPLEX                   - multiplex graph
    %   MULTIPLEX_NAME              - name of MULTIPLEX
    %   MULTIPLEX_DESCRIPTION       - description of MULTIPLEX
    %
    %   ORDERED_MULTILAYER          - ordered multilayer graph
    %   ORDERED_MULTILAYER_NAME     - name of ORDERED_MULTILAYER
    %   ORDERED_MULTILAYER_DESCRIPTION - description of ORDERED_MULTILAYER
    %
    %   MULTILAYER                  - multilayer graph
    %   MULTILAYER_NAME             - name of MULTILAYER
    %   MULTILAYER_DESCRIPTION      - description of MULTILAYER
    %
    %   TYPE_NUMBER                 - number of graph types
    %   TYPE_NAME                   - name of all graph types
    %   TYPE_DESCRIPTION            - description of all graph types
    %
    %   WEIGHTED                    - weighted graph
    %   WEIGHTED_NAME               - name of WEIGHTED
    %   WEIGHTED_DESCRIPTION        - description of WEIGHTED
    %
    %   BINARY                      - binary graph
    %   BINARY_NAME                 - name of BINARY
    %   BINARY_DESCRIPTION          - description of BINARY
    %
    %   CONNECTIVITY_TYPE_NUMBER    - number of graph connectivity types
    %   CONNECTIVITY_TYPE_NAME      - name of graph connectivity types
    %   CONNECTIVITY_TYPE_DESCRIPTION - description of graph connectivity types
    %
    %   DIRECTED                    - directed graph
    %   DIRECTED_NAME               - name of DIRECTED
    %   DIRECTED_DESCRIPTION        - description of DIRECTED
    %
    %   UNDIRECTED                  - undirected graph
    %   UNDIRECTED_NAME             - name of UNDIRECTED
    %   UNDIRECTED_DESCRIPTION      -  description of UNDIRECTED
    %
    %   DIRECTIONALITY_TYPE_NUMBER  - number of graph directionality types
    %   DIRECTIONALITY_TYPE_NAME    - name of graph directionality types
    %   DIRECTIONALITY_TYPE_DESCRIPTION - description of graph directionality types
    %
    %   NONSELFCONNECTED            - not self-connected graph
    %   NONSELFCONNECTED_NAME       - name of NONSELFCONNECTED
    %   NONSELFCONNECTED_DESCRIPTION - description of NONSELFCONNECTED
    %
    %   SELFCONNECTED               - self-connected graph
    %   SELFCONNECTED_NAME          - name of SELFCONNECTED
    %   SELFCONNECTED_DESCRIPTION   - description of SELFCONNECTED
    %
    %   SELFCONNECTIVITY_TYPE_NUMBER - number of graph self-connectivity types
    %   SELFCONNECTIVITY_TYPE_NAME  - name of graph self-connectivity types
    %   SELFCONNECTIVITY_TYPE_DESCRIPTION - description of graph self-connectivity types
    %
    %   NONNEGATIVE                 - non-negative graph
    %   NONNEGATIVE_NAME            - name of NONNEGATIVE
    %   NONNEGATIVE_DESCRIPTION     - description of NONNEGATIVE
    %
    %   NEGATIVE                    - negative graph
    %   NEGATIVE_NAME               - name of NEGATIVE
    %   NEGATIVE_DESCRIPTION        - description of NEGATIVE
    %
    %   NEGATIVITY_TYPE_NUMBER      - number of graph negativity types
    %   NEGATIVITY_TYPE_NAME        - name of graph negativity types
    %   NEGATIVITY_TYPE_DESCRIPTION - description of graph negativity types
    %
    % Graph check methods (static):
    %   checkA                      - checks if A is correct for the graph type
    %   checkConnectivity           - checks if A is correct for the connectivity type
    %   checkDirectionality         - checks if A is correct for the directionality type
    %   checkSelfConnectivity       - checks if A is correct for the self-connectivity type
    %   checkNegativity             - checks if A is correct for the negativity type
    %
    % Graph getGraph method (static):
    %   getGraph                    - returns a graph with the given inputs
    %
    % Graph descriptive methods (static):
    %   getList                     - returns a list with subclasses of graph
    %   getClass                    - returns the class type of the graph
    %   getName                     - returns the name of the graph
    %   getDescription              - returns the description of the graph
    %   getGraphType                - returns the graph type
    %   is_graph                    - checks if the graph is a single layer graph
    %   is_multigraph               - checks if the graph is a multigraph
    %   is_ordered_multiplex        - checks if the graph is an ordered multiplex graph
    %   is_multiplex                - checks if the graph is a multiplex graph
    %   is_ordered_multilayer       - checks if the graph is an ordered multilayer graph
    %   is_multilayer               - checks if the graph is a multilayer graph
    %   getConnectivityType         - returns the connectivity type of the graph
    %   is_weighted                 - checks if the graph is weighted
    %   is_binary                   - checks if the graph is binary
    %   getDirectionalityType       - returns the directionality type of the graph
    %   is_directed                 - checks if the graph is directed
    %   is_undirected               - checks if the graph is undirected
    %   getSelfConnectivityType     - returns the self-connectivity type of the graph
    %   is_selfconnected            - checks if the graph is self-connected
    %   is_not_selfconnected        - checks if the graph is not self-connected
    %   getNegativityType           - returns the negativity type of the graph
    %   is_nonnegative              - checks whether graph allows non-negative values
    %   is_negative                 - checks whether graph allows negative values
    %
    % Graph plot methods Static
    %   plot                        - chooses the corresponding type of plot
    %   plotw                       - plots a weighted graph
    %   plotb                       - plots a binary graph
    %   histogram                   - plots a histogram
    %
    % Graph basic methods:
    %   tostring                    - returns a string representing the graph
    %   disp                        - displays the graph
    %   getSettings                 - returns the settings of the graph
    %
    % Graph inspection methods:
    %   nodenumber                  - returns the number of nodes in a graph
    %   layernumber                 - returns the number of layers in a graph
    %   getA                        - returns the adjacency matrix or 2D-cell array of adjacency matrices
    %   getMeasure                  - returns measure
    %   is_measure_calculated       - checks if a measure is calculated
    %   getMeasureValue             - returns the value of a measure
    %   getCompatibleMeasureList    - returns a list with the compatible measures
    %   getCompatibleMeasureNumber  - returns a number of the compatible measures
    %
    % Graph attack and subgraph methods (static):
    %   nodeattack                  - removes given nodes from a graph
    %   edgeattack                  - removes given edges from a graph
    %   subgraph                    - extracts subgraph
    %
    % Graph randomization method (static):
    %   randomize                   - randomize graph
    %
    % Graph deep-copy method:
    %   copy                        - deep copy
    %
    % See also Measure, DummyGraph, DummyMultigraph, DummyMultilayer, DummyMultiplex, DummyOrderedMultilayer, DummyOrderedMultiplex.
    
    properties (Constant)
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
    properties (GetAccess=protected, SetAccess=protected)
        A  % adjacency matrix (for single-layer graphs) or 2D-cell array of adjacency matrices (for multi-layer graphs)
        settings  % structure with the constructor varagin
        measure_dict  % dictionary with calculated measures
    end
    methods (Access=protected)  % Contructor
        function g = Graph(A, varargin)
            % Graph(A) creates a graph with the default properties.
            % A is the adjacency matrix or the 2-D cell array of adjacency
            % matrices for multiple graphs. This method is only accessible
            % by the subclasses of Graph.
            %
            % Graph(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...)
            % creates a graph with properties and values. It initializes
            % the property settings with the properties and values.
            %
            % GRAPH(A, 'Settings', SETTINGS) ceates a graph and
            % initializes the property settings with SETTINGS.
            %
            % See also Measure, DummyGraph, DummyMultigraph, DummyMultilayer, DummyMultiplex, DummyOrderedMultilayer, DummyOrderedMultiplex.
            
            if length(varargin) == 1
                varargin = varargin{:};
            end
            
            settings = get_from_varargin(varargin, 'Settings', varargin{:});
            measure_dict = get_from_varargin(containers.Map, 'MeasureDictionary', varargin{:});
            
            Graph.checkA(Graph.getGraphType(g), A);  % performs all necessary checks on A
            if isnumeric(A)
                Graph.checkConnectivity(Graph.getConnectivityType(g), A);
                Graph.checkDirectionality(Graph.getDirectionalityType(g), A);
                Graph.checkSelfConnectivity(Graph.getSelfConnectivityType(g), A);
                Graph.checkNegativity(Graph.getNegativityType(g), A);
            else
                Graph.checkConnectivity(Graph.getConnectivityType(g, length(A)), A);
                Graph.checkDirectionality(Graph.getDirectionalityType(g, length(A)), A);
                Graph.checkSelfConnectivity(Graph.getSelfConnectivityType(g, length(A)), A);
                Graph.checkNegativity(Graph.getNegativityType(g, length(A)), A);
            end
            
            g.A = A;
            g.settings = settings;  % initialize the property settings
            g.measure_dict = measure_dict;  % initialize the property measure_dict
        end
    end
    methods (Static)  % Checks
        function checkA(graph_type, A)
            % CHECKA checks if adjacency matrix A or cell array of adjacency matrices A is correct for the type of graph
            %
            % CHECKA(GRAPH_TYPE, A) checks if adjacency matrix A or cell array of
            % adjacency matrices A is correct for the GRAPH_TYPE.
            %
            % See also checkConnectivity, checkDirectionality, checkNegativity, checkSelfConnectivity.
            
            % Basic checks
            if graph_type == Graph.GRAPH  % if graph, adjacency matrix
                assert(isnumeric(A) && ismatrix(A) && size(A, 1) == size(A, 2), ...
                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                    'A must be a square adjacency matrix.')
            else  % all other graph types, square cell array of matrices
                assert(iscell(A) && ismatrix(A) && size(A, 1) == size(A, 2), ...
                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                    'A must be a superadjacency matrix (square cell array of matrices).')
                % all submatrices in the diagonal are square
                assert(all(cellfun(@(a) size(a, 1) == size(a, 2), A(1:length(A)+1:end))), ...
                    [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT], ...
                    'All submatrices in the cell diagonal must be square.')
            end
            
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
            % CHECKCONNECTIVITY checks if adjacency matrix A or cell array of adjacency matrices A is correct for the connectivity type
            %
            % CHECKCONNECTIVITY(CONNECTIVITY_TYPE, A) checks if adjacency
            % matrix A or cell array of adjacency matrices A is correct for
            % the CONNECTIVITY_TYPE of the graph.
            % This check assumes that checkA has already been passed.
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
            % CHECKDIRECTIONALITY checks if adjacency matrix A or cell array of adjacency matrices A is correct for the directionality type
            %
            % CHECKDIRECTIONALITY(DIRECTIONALITY_TYPE, A) checks if adjacency
            % matrix A or cell array of adjacency matrices A is correct for
            % the DIRECTIONALITY_TYPE of the graph.
            % This check assumes that checkA has already been passed.
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
            % CHECKSELFCONNECTIVITY checks if adjacency matrix A or cell array of adjacency matrices A is correct for the self-connectivity type
            %
            % CHECKSELFCONNECTIVITY(SELFCONNECTIVITY_TYPE, A) checks if adjacency
            % matrix A or cell array of adjacency matrices A is correct for
            % the SELFCONNECTIVITY_TYPE of the graph.
            % This check assumes that checkA has already been passed.
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
            % CHECKNEGATIVITY checks if adjacency matrix A or cell array of adjacency matrices A is correct for the negativity type
            %
            % CHECKNEGATIVITY(NEGATIVITY_TYPE, A) checks if adjacency
            % matrix A or cell array of adjacency matrices A is correct for
            % the NEGATIVITY_TYPE of the graph.
            % This check assumes that checkA has already been passed.
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
    end
    methods (Static)  % getGraph
        function g_new = getGraph(g, A, varargin) %#ok<INUSD>
            % GETGRAPH returns a graph
            %
            % G = GETGRAPH(G, A) returns an instance
            % of the class of the graph G with adjacency matrix or cell
            % array of adjacency matrices A.
            %
            % G = GETGRAPH(GRAPH_CLASS, A) returns an instance
            % of the class whose class is GRAPH_CLASS with adjacency matrix
            % or cell array of adjacency matrices A.
            %
            % G = GETGRAPH(G, A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...)
            % G = GETGRAPH(GRAPH_CLASS, A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...)
            % initializes the property settings with the properties and values.
            %
            % G = GETGRAPH(G, A, 'Settings', SETTINGS)
            % G = GETGRAPH(GRAPH_CLASS, A, 'Settings', SETTINGS)
            % initializes the property settings with SETTINGS.
            %
            % See also getList, getCompatibleMeasureList.
            
            g_new = eval([Graph.getClass(g) '(A, varargin{:})']);
        end
    end
    methods (Static)  % Descriptive functions
        function graph_class_list = getList()
            % GETLIST returns the list of available graphs
            %
            % GRAPH_CLASS_LIST = GETLIST() returns the list of graphs
            % (cell array) that are subclasses of Graph.
            %
            % See also getClass, getCompatibleMeasureList.
            
            graph_class_list = subclasses( ...
                'Graph', ...
                [fileparts(which('Graph')) filesep 'graphs'] ...
                );
        end
        function graph_class = getClass(g)
            % GETCLASS returns the class of graphs
            %
            % GRAPH_CLASS = GETCLASS(G) returns the class of the concrete
            % instance of graph G.
            %
            % GRAPH_CLASS = GETCLASS(GRAPH_CLASS) returns the class of the
            % graph whose class is the string GRAPH_CLASS.
            %
            % See also getList, getCompatibleMeasureList.
            
            if isa(g, 'Graph')
                graph_class = class(g);
            else % g should be a string with the graph code
                graph_class = g;
            end
        end
        function name = getName(g)
            % GETNAME returns the name of the graph
            %
            % NAME = GETNAME(G) returns the name (string) of the concrete instance
            % of graph G.
            %
            % NAME = GETNAME(GRAPH_CLASS) returns the name (string) of the
            % graph whose class is the string GRAPH_CLASS.
            %
            % See also getList, getCompatibleMeasureList.
            
            name = eval([Graph.getClass(g) '.getName()']);
        end
        function name = getDescription(g)
            % GETDESCRIPTION returns the description of the graph
            %
            % DESCRIPTION = GETDESCRIPTION(G) returns the description
            % (string) of the concrete instance of graph G.
            %
            % DESCRIPTION = GETDESCRIPTION(GRAPH_CLASS) returns the
            % description (string) of the graph whose class is GRAPH_CLASS.
            %
            % See also getList, getCompatibleMeasureList.
            
            name = eval([Graph.getClass(g) '.getDescription()']);
        end
        function graph_type = getGraphType(g)
            % GETGRAPHTYPE returns the graph type
            %
            % GRAPH_TYPE = GETGRAPHTYPE(G) returns the graph type of graph
            % G (e.g., GRAPH, MULTIGRAPH, ORDERED_MULTIPLEX, MULTIPLEX,
            % ORDERED_MULTILAYER, MULTILAYER)
            %
            % GRAPH_TYPE = GETGRAPHTYPE(GRAPH_CLASS) returns the graph type
            % of the graph whose class is GRAPH_CLASS (e.g., GRAPH,
            % MULTIGRAPH, ORDERED_MULTIPLEX, MULTIPLEX, ORDERED_MULTILAYER, MULTILAYER)
            %
            % See also is_graph, is_multigraph, is_multilayer, is_multiplex, is_ordered_multilayer, is_ordered_multiplex.
            
            graph_type = eval([Graph.getClass(g) '.getGraphType()']);
        end
        function bool = is_graph(g)
            % IS_GRAPH checks if graph is graph (single layer)
            %
            % BOOL = IS_GRAPH(G) returns if the instance of the
            % concrete graph G is graph (single layer).
            %
            % BOOL = IS_GRAPH(GRAPH_CLASS) returns true if graph whose
            % class is GRAPH_CLASS is graph (single layer).
            %
            % See also getGraphType, is_multigraph, is_multilayer, is_multiplex, is_ordered_multilayer, is_ordered_multiplex.
            
            bool = Graph.getGraphType(g) == Graph.GRAPH;
        end
        function bool = is_multigraph(g)
            % IS_MULTIGRAPH checks if graph is multigraph
            %
            % BOOL = IS_MULTIGRAPH(G) returns if the instance of the
            % concrete graph G is multigraph.
            %
            % BOOL = IS_MULTIGRAPH(GRAPH_CLASS) returns true if graph whose
            % class is GRAPH_CLASS is multigraph.
            %
            % See also getGraphType, is_graph, is_multilayer, is_multiplex, is_ordered_multilayer, is_ordered_multiplex.
            
            bool = g.getGraphType() == Graph.MULTIGRAPH;
        end
        function bool = is_ordered_multiplex(g)
            % IS_ORDERED_MULTIPLEX checks if graph is ordered multiplex
            %
            % BOOL = IS_ORDERED_MULTIPLEX(G) returns if the instance of the
            % concrete graph G is ordered multiplex.
            %
            % BOOL = IS_ORDERED_MULTIPLEX(GRAPH_CLASS) returns true if graph
            % whose class is GRAPH_CLASS is ordered multiplex.
            %
            % See also getGraphType, is_graph, is_multigraph, is_multilayer, is_multiplex, is_ordered_multilayer.
            
            bool = Graph.getGraphType(g) == Graph.ORDERED_MULTIPLEX;
        end
        function bool = is_multiplex(g)
            % IS_MULTIPLEX checks if graph is multiplex
            %
            % BOOL = IS_MULTIPLEX(G) returns if the instance of the
            % concrete graph G is multiplex.
            %
            % BOOL = IS_MULTIPLEX(GRAPH_CLASS) returns true if graph whose
            % class is GRAPH_CLASS is multiplex.
            %
            % See also getGraphType, is_graph, is_multigraph, is_multilayer, is_ordered_multilayer, is_ordered_multiplex.
            
            bool = Graph.getGraphType(g) == Graph.MULTIPLEX;
        end
        function bool = is_ordered_multilayer(g)
            % IS_ORDERED_MULTILAYER checks if graph is ordered multilayer
            %
            % BOOL = IS_ORDERED_MULTILAYER(G) returns if the instance of the
            % concrete graph G is ordered multilayer.
            %
            % BOOL = IS_ORDERED_MULTILAYER(GRAPH_CLASS) returns true if graph
            % whose class is GRAPH_CLASS is ordered multilayer.
            %
            % See also getGraphType, is_graph, is_multigraph, is_multilayer, is_multiplex, is_ordered_multiplex.
            
            bool = Graph.getGraphType(g) == Graph.ORDERED_MULTILAYER;
        end
        function bool = is_multilayer(g)
            % IS_MULTILAYER checks if graph is multilayer
            %
            % BOOL = IS_MULTILAYER(G) returns if the instance of the
            % concrete graph G is multilayer.
            %
            % BOOL = IS_MULTILAYER(GRAPH_CLASS) returns true if graph whose
            % class is GRAPH_CLASS is multilayer.
            %
            % See also getGraphType, is_graph, is_multigraph, is_multiplex, is_ordered_multilayer, is_ordered_multiplex.
            
            bool = Graph.getGraphType(g) == Graph.MULTILAYER;
        end
        function connectivity_type = getConnectivityType(g, varargin)
            % GETCONNECTIVITYTYPE returns the connectivity type of the graph
            %
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE(G) returns the
            % connectivity type of the instance of the concrete graph G.
            %
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE(GRAPH_CLASS)
            % returns the connectivity type of the graph whose class is GRAPH_CLASS.
            %
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE(G, LAYERNUMBER)
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE(GRAPH_CLASS, LAYERNUMBER)
            % returns a matrix with the connectivity type of each layer in
            % a multiple layer graph.
            %
            % See also is_binary, is_weighted.
            
            connectivity_type = eval([Graph.getClass(g) '.getConnectivityType(varargin{:})']);
        end
        function bool = is_weighted(g, varargin)
            % IS_WEIGHTED checks if graph is weighted
            %
            % BOOL = IS_WEIGHTED(G) returns if the instance of the
            % concrete graph G is weighted.
            %
            % BOOL = IS_WEIGHTED(GRAPH_CLASS) returns true if graph whose
            % class is GRAPH_CLASS is weighted.
            %
            % See also getConnectivityType, is_binary.
            
            bool = Graph.getConnectivityType(g, varargin{:}) == Graph.WEIGHTED;
        end
        function bool = is_binary(g, varargin)
            % IS_BINARY checks if graph is binary
            %
            % BOOL = IS_BINARY(G) returns if the instance of the
            % concrete graph G is binary.
            %
            % BOOL = IS_BINARY(GRAPH_CLASS) returns true if graph whose
            % class is GRAPH_CLASS is binary.
            %
            % See also getConnectivityType, is_weighted.
            
            bool = Graph.getConnectivityType(g, varargin{:}) == Graph.BINARY;
        end
        function directionality_type = getDirectionalityType(g, varargin)
            % GETDIRECTIONALITYTYPE returns the directionality type of the graph
            %
            % DIRECTIONALITY_TYPE = GETDIRECTIONALITYTYPE(G) returns the
            % directionality type of the instance of the concrete graph G.
            %
            % DIRECTIONALITY_TYPE = GETDIRECTIONALITYTYPE(GRAPH_CLASS)
            % returns the directionality type of the graph whose class is GRAPH_CLASS.
            %
            % DIRECTIONALITY_TYPE = GETDIRECTIONALITYTYPE(G, LAYERNUMBER)
            % DIRECTIONALITY_TYPE = GETDIRECTIONALITYTYPE(GRAPH_CLASS, LAYERNUMBER)
            % returns a matrix with the directionality type of each layer
            % in a multiple layer graph.
            %
            % See also is_directed, is_undirected.
            
            directionality_type = eval([Graph.getClass(g) '.getDirectionalityType(varargin{:})']);
        end
        function bool = is_directed(g, varargin)
            % IS_DIRECTED checks if graph is directed
            %
            % BOOL = IS_DIRECTED(G) returns if the instance of the
            % concrete graph G is directed.
            %
            % BOOL = IS_DIRECTED(GRAPH_CLASS) returns true if graph whose
            % class is GRAPH_CLASS is directed.
            %
            % See also getDirectionalityType, is_undirected.
            
            bool = Graph.getDirectionalityType(g, varargin{:}) == Graph.DIRECTED;
        end
        function bool = is_undirected(g, varargin)
            % IS_UNDIRECTED checks if graph is undirected
            %
            % BOOL = IS_UNDIRECTED(G) returns if the instance of the
            % concrete graph G is undirected.
            %
            % BOOL = IS_UNDIRECTED(GRAPH_CLASS) returns true if graph whose
            % class is GRAPH_CLASS is undirected.
            %
            % See also getDirectionalityType, is_directed.
            
            bool = Graph.getDirectionalityType(g, varargin{:}) == Graph.UNDIRECTED;
        end
        function selfconnectivity_type = getSelfConnectivityType(g, varargin)
            % GETSELFCONNECTIVITYTYPE returns the self-connectivity type of the graph
            %
            % SELFCONNECTIVITY_TYPE = GETSELFCONNECTIVITYTYPE(G) returns the
            % self-connectivity type of the instance of the concrete graph G.
            %
            % SELFCONNECTIVITY_TYPE = GETSELFCONNECTIVITYTYPE(GRAPH_CLASS)
            % returns the self-connectivity type of the graph whose class is GRAPH_CLASS.
            %
            % SELFCONNECTIVITY_TYPE = GETSELFCONNECTIVITYTYPE(G, LAYERNUMBER)
            % SELFCONNECTIVITY_TYPE = GETSELFCONNECTIVITYTYPE(GRAPH_CLASS, LAYERNUMBER)
            % returns a matrix with the self-connectivity  type of each layer
            % in a multiple layer graph.
            %
            % See also is_selfconnected, is_not_selfconnected.
            
            selfconnectivity_type = eval([Graph.getClass(g) '.getSelfConnectivityType(varargin{:})']);
        end
        function bool = is_selfconnected(g, varargin)
            % IS_SELFCONNECTED checks if graph is self-connected
            %
            % BOOL = IS_SELFCONNECTED(G) returns true if the instance of the
            % concrete graph G is self-connected and false otherwise.
            %
            % BOOL = IS_SELFCONNECTED(GRAPH_CLASS) returns true if graph
            % whose class is GRAPH_CLASS is self-connected and false otherwise.
            %
            % See also getSelfConnectivityType, is_not_selfconnected.
            
            bool = Graph.getSelfConnectivityType(g, varargin{:}) == Graph.SELFCONNECTED;
        end
        function bool = is_not_selfconnected(g, varargin)
            % IS_NONSELFCONNECTED checks if graph is not self-connected
            %
            % BOOL = IS_NONSELFCONNECTED(G) returns true if the instance of the
            % concrete graph G is not self-connected and false otherwise.
            %
            % BOOL = IS_NONSELFCONNECTED(GRAPH_CLASS) returns true if graph
            % whose class is GRAPH_CLASS is not self-connected and false otherwise.
            %
            % See also getSelfConnectivityType, is_selfconnected.
            
            bool = Graph.getSelfConnectivityType(g, varargin{:}) == Graph.NONSELFCONNECTED;
        end
        function negativity_type = getNegativityType(g, varargin)
            % GETNEGATIVITYTYPE returns the negativity type of the graph
            %
            % NEGATIVITY_TYPE = GETNEGATIVITYTYPE(G) returns the
            % negativity type of the instance of the concrete graph G.
            %
            % NEGATIVITY_TYPE = GETNEGATIVITYTYPE(GRAPH_CLASS) returns
            % the negativity type of the graph whose class is GRAPH_CLASS.
            %
            % NEGATIVITY_TYPE = GETNEGATIVITYTYPE(G, LAYERNUMBER)
            % NEGATIVITY_TYPE = GETNEGATIVITYTYPE(GRAPH_CLASS, LAYERNUMBER)
            % returns a matrix with the negativity  type of each layer in
            % a multiple layer graph.
            %
            % See also is_negative, is_nonnegative.
            
            negativity_type = eval([Graph.getClass(g) '.getNegativityType(varargin{:})']);
        end
        function bool = is_nonnegative(g, varargin)
            % IS_NONNEGATIVE checks whether graph allows non-negative values
            %
            % BOOL = IS_NONNEGATIVE(G) returns true if the concrete instance
            % of graph G allows non-negative values and false otherwise.
            %
            % BOOL = IS_NONNEGATIVE(GRAPH_CLASS) returns true if the graph
            % whose class is GRAPH_CLASS allows non-negative values and false otherwise.
            %
            % See also getNegativityType, is_negative.
            
            bool = Graph.getNegativityType(g, varargin{:}) == Graph.NONNEGATIVE;
        end
        function bool = is_negative(g, varargin)
            % IS_NEGATIVE checks whether graph allows negative values
            %
            % BOOL = IS_NEGATIVE(G) returns true if the concrete instance
            % of graph G allows negative values and false otherwise.
            %
            % BOOL = IS_NEGATIVE(GRAPH_CLASS) returns true if the graph
            % whose class is GRAPH_CLASS allows negative values and false otherwise.
            %
            % See also getNegativityType, is_nonnegative.
            
            bool = Graph.getNegativityType(g, varargin{:}) == Graph.NEGATIVE;
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
            % See also getList, getCompatibleMeasureNumber.
            
            graph_class = Graph.getClass(g);
            
            measure_code_list = Measure.getList();
            
            list = cell(1, length(measure_code_list));
            for i = 1:1:length(measure_code_list)
                measure_code = measure_code_list{i};
                
                if are_compatible(graph_class, measure_code)
                    list{i} = measure_code;
                end
            end
            list(cellfun('isempty', list)) = [];
        end
        function n = getCompatibleMeasureNumber(g)
            % GETCOMPATIBLEMEASURENUMBER returns the number of compatible
            % measures
            %
            % N = GETCOMPATIBLEMEASURENUMBER(G) returns the number of
            % compatible measures to the concrete graph G.
            %
            % N = GETCOMPATIBLEMEASURENUMBER(GRAHP_CLASS) returns the number
            % of compatible measures to graph whose class is GRAPH_CLASS.
            %
            % See also getList, getCompatibleMeasureList.
            
            list = Graph.getCompatibleMeasureList(g);
            n = numel(list);
        end
    end
    methods (Static)  % Plot Panel method
        function h_plot = plot(A, varargin)
            % PLOT calls the appropiate function to plot
            %
            % H_PLOT = PLOT(G, PLOTRULE, VALUE) using VALUE
            % chooses the corresponding function to return a plot.
            %
            % See also plotb, plotw, hist.
            
            plot_type = get_from_varargin('correlation', 'Graph.PlotType', varargin{:});
            switch plot_type
                case 'binary'
                    h_plot = Graph.plotb(A, varargin{:});
                case 'histogram'
                    h_plot = Graph.hist(A, varargin{:});
                otherwise  % correlation
                    h_plot = Graph.plotw(A, varargin{:});
            end
        end
        function h = plotw(A, varargin)
            % PLOTW plots a weighted matrix
            %
            % H = PLOTW(A) plots the weighted matrix A and returns the handle to
            %   the plot H.
            %
            % H = PLOTW(A,'PropertyName',PropertyValue) sets the property of the
            %   matrix plot PropertyName to PropertyValue.
            %   All standard plot properties of surf can be used.
            %   Additional admissive properties are:
            %       xlabels   -   1:1:number of matrix elements (default)
            %       ylabels   -   1:1:number of matrix elements (default)
            %
            % See also Graph, plotb, surf.
            
            N = length(A);
            
            % x labels
            xlabels = (1:1:N);
            for n = 1:2:length(varargin)
                if strcmpi(varargin{n}, 'xlabels')
                    xlabels = varargin{n + 1};
                end
            end
            if ~iscell(xlabels)
                xlabels = {xlabels};
            end
            
            % y labels
            ylabels = (1:1:N);
            for n = 1:2:length(varargin)
                if strcmpi(varargin{n}, 'ylabels')
                    ylabels = varargin{n + 1};
                end
            end
            if ~iscell(ylabels)
                ylabels = {ylabels};
            end
            
            ht = surf((0:1:N), ...
                (0:1:N), ...
                [A, zeros(size(A, 1), 1); zeros(1, size(A, 1) + 1)]);
            view(2)
            shading flat
            axis equal square tight
            grid off
            box on
            set(gca, ...
                'XAxisLocation', 'top', ...
                'XTick', (1:1:N) - .5, ...
                'XTickLabel', {}, ...
                'YAxisLocation', 'left', ...
                'YDir', 'Reverse', ...
                'YTick', (1:1:N) - .5, ...
                'YTickLabel', ylabels)
            
            if ~verLessThan('matlab', '8.4.0')
                set(gca, ...
                    'XTickLabelRotation', 90, ...
                    'XTickLabel', xlabels)
            else
                t = text((1:1:N) - .5, zeros(1, N), xlabels);
                set(t, ...
                    'HorizontalAlignment', 'left', ...
                    'VerticalAlignment', 'middle', ...
                    'Rotation', 90);
            end
            
            colormap jet
            
            % output if needed
            if nargout > 0
                h = ht;
            end
        end
        function h = plotb(A, varargin)
            % PLOTB plots a binary matrix
            %
            % H = PLOTB(A) plots the binarized version of weighted matrix A and
            %   returns the handle to the plot H.
            %   The matrix A can be binarized by fixing the threshold
            %   (default, threshold = 0.5).
            %
            % H = PLOTB(A, 'PropertyName', PropertyValue) sets the property of the
            %   matrix plot PropertyName to PropertyValue.
            %   All standard plot properties of surf can be used.
            %   Additional admissive properties are:
            %       threshold   -   0.5 (default)
            %       xlabels     -   1:1:number of matrix elements (default)
            %       ylabels     -   1:1:number of matrix elements (default)
            %
            % See also Graph, binarize, plotw, surf.
            
            N = length(A);
            
            % threshold
            threshold = get_from_varargin(0, 'threshold', varargin{:});
            
            % density 
            density = get_from_varargin([], 'density', varargin{:});
            
            % x labels
            xlabels = (1:1:N);
            for n = 1:2:length(varargin)
                if strcmpi(varargin{n}, 'xlabels')
                    xlabels = varargin{n + 1};
                end
            end
            if ~iscell(xlabels)
                xlabels = {xlabels};
            end
            
            % y labels
            ylabels = (1:1:N);
            for n = 1:2:length(varargin)
                if strcmpi(varargin{n}, 'ylabels')
                    ylabels = varargin{n + 1};
                end
            end
            if ~iscell(ylabels)
                ylabels = {ylabels};
            end
            
            B = binarize(A, 'threshold', threshold, 'density', density);
            
            ht = surf((0:1:N), ...
                (0:1:N), ...
                [B, zeros(size(B, 1), 1); zeros(1, size(B, 1) + 1)]);
            view(2)
            shading flat
            axis equal square tight
            grid off
            box on
            set(gca, ...
                'XAxisLocation', 'top',  ...
                'XTick', (1:1:N) - .5, ...
                'XTickLabel', {},  ...
                'YAxisLocation', 'left',  ...
                'YDir', 'Reverse',  ...
                'YTick', (1:1:N) - .5, ...
                'YTickLabel', ylabels)
            
            if ~verLessThan('matlab',  '8.4.0')
                set(gca, ...
                    'XTickLabelRotation',90, ...
                    'XTickLabel', xlabels)
            else
                t = text((1:1:N) - .5, zeros(1,N), xlabels);
                set(t, ...
                    'HorizontalAlignment', 'left',  ...
                    'VerticalAlignment', 'middle',  ...
                    'Rotation',90);
            end
            
            colormap bone
            
            % output if needed
            if nargout > 0
                h = ht;
            end
        end
        function h = hist(A, varargin)
            % HIST plots the histogram and density of a matrix
            %
            % H = HIST(A) plots the histogram of a matrix A and the associated density and
            %   returns the handle to the plot H.
            %
            % H = HIST(A,'PropertyName',PropertyValue) sets the property of the histogram
            %   plot PropertyName to PropertyValue.
            %   All standard plot properties of surf can be used.
            %   Additional admissive properties are:
            %       bins       -   -1:.001:1 (default)
            %       diagonal   -   'exclude' (default) | 'include'
            %
            % See also Graph, histogram.
            
            [count, bins, density] = histogram(A, varargin{:});
            
            bins = [bins(1) bins bins(end)];
            count = [0 count 0];
            density = [100 density 0];
            
            hold on
            ht1 = fill(bins, count, 'k');
            ht2 = plot(bins, density, 'b', 'linewidth', 2);
            hold off
            xlabel('coefficient values / threshold')
            ylabel('coefficient counts / density')
            
            grid off
            box on
            axis square tight
            set(gca, ...
                'XAxisLocation', 'bottom',  ...
                'XTickLabelMode', 'auto',  ...
                'XTickMode', 'auto',  ...
                'YTickLabelMode', 'auto',  ...
                'YAxisLocation', 'left',  ...
                'YDir', 'Normal',  ...
                'YTickMode', 'auto',  ...
                'YTickLabelMode', 'auto')
            
            % output if needed
            if nargout > 0
                h = [ht1 ht2];
            end
        end
    end
    methods  % Basic methods
        function str = tostring(g)
            % TOSTRING string with information about the graph
            %
            % STR = TOSTRING(G) returns string with the graph class and size (layers and nodes).
            %
            % See also disp.
            
            str = [Graph.getClass(g) ': ' int2str(g.layernumber(g)) ' layers with ' int2str(g.nodenumber(g)) ' nodes'];
        end
        function disp(g)
            % DISP displays information about the graph
            %
            % DISP(G) displays information about the graph.
            % It provides information about graph class, graph type, size
            % (layers and nodes size), value, associated measures and
            % settings.
            %
            % See also tostring.
            
            disp(['<a href="matlab:help ' Graph.getClass(g) '">' Graph.getClass(g) '</a>'])
            disp([g.TYPE_DESCRIPTION{Graph.getGraphType(g)} ])
            disp([' size: ' int2str(g.layernumber()) ' layers with ' int2str(g.nodenumber()) ' nodes'])
            %             disp([' measures: ' int2str(length(g.measure_dict))]);
            disp([' settings']); %#ok<NBRAK>
            settings = g.getSettings(); %#ok<PROP>
            for i = 1:2:length(settings) %#ok<PROP>
                disp(['  ' settings{i} ' = ' tostring(settings{i+1})]); %#ok<PROP>
            end
        end
        function res = getSettings(g, setting_code)
            % GETSETTINGS returns the settings
            %
            % SETTINGS = GETSETTINGS(G) returns the settings of the graph
            %
            % SETTINGS = GETSETTINGS(G, SETTING_CODE) returns the settings
            % of the graph SETTING_CODE.
            %
            % See also getA, layernumber, nodenumber.
            
            if nargin<2
                res = g.settings;
            else
                res = get_from_varargin([], setting_code, g.settings{:});
            end
        end
    end
    methods  % Inspection functions
        function n = nodenumber(g)
            % NODENUMBER returns the number of nodes in the graph
            %
            % N = NODENUMBER(G) returns the number of nodes in graph G. For
            % non single layer graphs it returns an array with the number
            % of nodes in each layer.
            %
            % See also getA, getSettings, layernumber.
            
            switch Graph.getGraphType(g)
                case Graph.GRAPH
                    n = length(g.getA());
                otherwise
                    A = g.getA(); %#ok<PROP>
                    n = cellfun(@(a) length(a), A(1:length(A)+1:end)); %#ok<PROP>
            end
        end
        function n = layernumber(g)
            % LAYERNUMBER returns the number of layers in the graph
            %
            % N = LAYERNUMBER(G) returns the number of layers in graph G.
            %
            % See also getA, getSettings, nodenumber.
            
            switch Graph.getGraphType(g)
                case Graph.GRAPH
                    n = 1;
                otherwise
                    n = length(g.getA());
            end
        end
        function A = getA(g, i, j)
            % GETA returns the adjacency matrix or cell array of adjacency matrices
            %
            % A = GETA(G) returns the adjacency matrix A (single layer
            % graphs) or the cell array of adjacency matrices A (multiple
            % graphs) associated to graph G
            %
            % A = GETA(G, I) returns the adjacency matrix at the position
            % (I, I) of the cell array of adjacency matrices A associated
            % to graph G (multiple graph).
            %
            % A = GETA(G, I, J) returns the adjacency matrix at the position
            % (I, J) of the cell array of adjacency matrices A associated
            % to graph G (multiple graph).
            %
            % See also getSettings, layernumber, nodenumber.
            
            if nargin == 1  % return cell array of adjacency matrices
                A = g.A;
            elseif nargin == 2  % return A{i, i}
                A = g.A{i, i};
            else  % return A{i, j}
                A = g.A{i, j};
            end
        end
        function m = getMeasure(g, measure_class)
            % GETMEASURE returns measure
            %
            % M = GETMEASURE(G, MEASURE_CLASS) checks if the measure
            % exists in the property MDICT. If not it creates a new measure
            % M of class MEASURE_CLASS with properties defined by the graph
            % settings. The user must call getValue() for the new measure M
            % to retrieve the value of measure M.
            %
            % See also getMeasureValue, is_measure_calculated.
            
            if isKey(g.measure_dict, measure_class)
                m = g.measure_dict(measure_class);
            else
                m = Measure.getMeasure(measure_class, g, g.settings{:});
                g.measure_dict(measure_class) = m;
            end
        end
        function bool = is_measure_calculated(g, measure_class)
            % IS_MEASURE_CALCULATED checks if a measure is calculated
            %
            % BOOL = IS_MEASURE_CALCULATED(G) returns true if a value of a
            % measure has been already calculated. If a measure M is
            % created by using the function getMeasure(), the user needs to
            % call the function getMeasureValue() to calculate the measure and
            % obtain a value.
            %
            % See also getMeasure, getMeasureValue.
            
            if isKey(g.measure_dict, measure_class)
                bool = g.measure_dict(measure_class).is_value_calculated();
            else
                bool = false;
            end
        end
        function value = getMeasureValue(g, measure_class)
            % GETMEASUREVALUE returns the value of a measure
            %
            % VALUE = GETMEASUREVALUE(G, MEASURE_CLASS) returns the value of
            % a measure of type MEASURE_CLASS.
            %
            % See also getMeasure, is_measure_calculated.
            
            value = g.getMeasure(measure_class).getValue();
        end
    end
    methods (Static)  % Attacks and subgraphs
        function ga = nodeattack(g, nodes, layernumbers)
            % NODEATTACK removes given nodes from a graph
            %
            % GA = NODEATTACK(G, NODES) creates the graph GA resulting by removing
            % the nodes specified by NODES from G. For non single layer
            % graphs, it removes NODES in every layer.
            %
            % GA = NODEATTACK(G, NODES, LAYERNUMBERS) creates the graph GA
            % resulting by removing the nodes specified by NODES from G.
            % For non single layer graphs, it removes NODES in the layers
            % specified by LAYERNUMBERS.
            %
            % NODES are removed by setting all the connections from and to
            % the nodes in the connection matrix to 0.
            %
            % See also edgeattack.
            
            if nargin < 3
                layernumbers = 1:1:g.layernumber();
            end
            
            A = g.getA();
            
            switch Graph.getGraphType(g)
                case Graph.GRAPH
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
            
            ga = Graph.getGraph(Graph.getClass(g), A, g.getSettings());
        end
        function ga = edgeattack(g, nodes1, nodes2, layernumbers1, layernumbers2)
            % EDGEATTACK removes given edges from a graph
            %
            % GA = EDGEATTACK(G, NODES1, NODES2) creates the graph GA resulting
            % by removing the edges going from NODES1 to NODES2 from G. For
            % non single layer graphs, it removes the edges from NODES1 to
            % NODES2 in every layer.
            %
            % GA = EDGEATTACK(G, NODES1, NODES2, LAYERNUMBERS_I) creates the graph GA
            % resulting by removing the edges going from NODES1 to NODES2 from G.
            % For non single layer graphs, it removes the edges from NODES1 to
            % NODES2 in the layers specified by LAYERNUMBERS.
            %
            % GA = EDGEATTACK(G, NODES1, NODES2, LAYERNUMBERS_I, LAYERNUMBERS_J)
            % creates the graph GA resulting by removing the edges going
            % from NODES1 to NODES2 from G. For non single layer graphs, it
            % removes the edges from NODES1 to NODES2 in and between the layers
            % specified by LAYERNUMBERS_I and LAYERNUMBERS_J.
            %
            % EDGES are removed by setting all the connections from NODES1 to
            % NODES2 in the connection matrix to 0.
            %
            % NODES1 and NODES2 must have the same dimensions.
            %
            % See also nodeattack.
            
            if nargin < 4
                layernumbers1 = 1:1:g.layernumber();
            end
            
            if nargin < 5
                layernumbers2 = layernumbers1;
            end
            
            A = g.getA();
            
            switch Graph.getGraphType(g)
                case Graph.GRAPH
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
            
            ga = Graph.getGraph(Graph.getClass(g), A, g.getSettings());
        end
        function sg = subgraph(g, nodes)
            % SUBGRAPH extracts subgraph
            %
            % SG = SUBGRAPH(G, NODES) extracts the graph SG as a subgraph of G
            % containing only the nodes specified by NODES.
            % If NODES is a vector, the specified nodes are removed from
            % all layers. If NODES is a cell array of vectors, the
            % specified nodes are removed from each layer.
            
            A = g.getA();
            L = g.layernumber();
            
            if ~iscell(nodes)
                nodes = repmat({nodes}, 1, L);
            end
            
            switch Graph.getGraphType(g)
                case Graph.GRAPH
                    A = A(nodes{1}, nodes{1});
                    
                otherwise  % multigraph, multiplex and multilayer
                    for li = 1:1:L
                        for lj = 1:1:L
                            Aij = A{li, lj};
                            if ~isempty(Aij)
                                A(li, lj) = {Aij(nodes{li}, nodes{lj})};
                            end
                        end
                    end
            end
            
            sg = Graph.getGraph(Graph.getClass(g), A, g.getSettings());
        end
    end
    methods (Static, Abstract)  % Randomize function
        gr = randomize(g, varargin);
    end
    methods (Access=protected)  % Deep copy
        function g_copy = copyElement(g)
            % COPYELEMENT(G) copies elements of graph
            %
            % G_COPY = COPYELEMENT(G) copies elements of the graph G.
            % Makes a deep copy of the structure of the graph.
            %
            % See also Cohort.
            
            % Make a shallow copy
            g_copy = copyElement@matlab.mixin.Copyable(g);
            
            % Make a deep copy of settings
            g_copy.settings = copy_varargin(g.settings{:});
            
            % Make a deep copy of measure_dict
            g_copy.measure_dict = containers.Map;
            measures = values(g.measure_dict);
            for i = 1:1:length(measures)
                m = measures{i};
                if m.is_value_calculated()
                    g_copy.measure_dict(m.getMeasureCode()) = Measure.getMeasure( ...
                        m.getMeasureCode(), ...
                        g_copy, ...
                        'Value', m.getValue(), ...
                        'Settings', copy_varargin(m.getSettings()) ...
                        );
                else
                    g_copy.measure_dict(m.getMeasureCode()) = Measure.getMeasure( ...
                        m.getMeasureCode(), ...
                        g_copy, ...
                        'Settings', copy_varargin(m.getSettings()) ...
                        );
                end
            end
        end
    end
end