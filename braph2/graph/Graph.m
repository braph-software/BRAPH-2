classdef Graph < handle & matlab.mixin.Copyable
    % Graph (Abstract): A graph
    % Graph provides the methods necessary for all graphs.
    % Instances of this class cannot be created. Use one of the subclasses.
    % The subclasses must be created inside the folder
    % ./braph/graph/graphs/. 
    % It is a subclass of handle and matlab.mixin.Copyable.
    %
    % Properties(Constant):
    %   
    %   GRAPH    - single layer graph
    %   GRAPH_NAME    - name of GRAPH 
    %   GRAPH_DESCRIPTION   - description of GRAPH
    %   MULTIGRAPH    - multiple unconnected graphs
    %   MULTIGRAPH_NAME    - name of MULTIGRAPH 
    %   MULTIGRAPH_DESCRIPTION   - description of MULTIGRAPH
    %   ORDERED_MULTIPLEX    - ordered multiplex graph
    %   ORDERED_MULTIPLEX_NAME    - name of ORDERED_MULTIPLEX 
    %   ORDERED_MULTIPLEX_DESCRIPTION   - description of ORDERED_MULTIPLEX
    %   MULTIPLEX    - multiplex graph
    %   MULTIPLEX_NAME    - name of MULTIPLEX 
    %   MULTIPLEX_DESCRIPTION   - description of MULTIPLEX   
    %   ORDERED_MULTILAYER    - ordered multilayer graph
    %   ORDERED_MULTILAYER_NAME    - name of ORDERED_MULTILAYER 
    %   ORDERED_MULTILAYER_DESCRIPTION   - description of ORDERED_MULTILAYER
    %   MULTILAYER    - multilayer graph
    %   MULTILAYER_NAME    - name of MULTILAYER 
    %   MULTILAYER_DESCRIPTION   - description of MULTILAYER    
    %   TYPE_NUMBER    - number of graph types
    %   TYPE_NAME    - name of all graph types
    %   TYPE_DESCRIPTION    - description of all graph types
    %   WEIGHTED - weighted graph
    %   WEIGHTED_NAME    - name of WEIGHTED
    %   WEIGHTED_DESCRIPTION    - description of WEIGHTED
    %   BINARY - binary graph
    %   BINARY_NAME    - name of BINARY
    %   BINARY_DESCRIPTION  - description of BINARY
    %   CONNECTIVITY_TYPE_NUMBER    - number of graph connectivity types
    %   CONNECTIVITY_TYPE_NAME    - name of graph connectivity types
    %   CONNECTIVITY_TYPE_DESCRIPTION    - description of graph connectivity types
    %   DIRECTED    - directed graph
    %   DIRECTED_NAME   - name of DIRECTED
    %   DIRECTED_DESCRIPTION    - description of DIRECTED
    %   UNDIRECTED  - undirected graph
    %   UNDIRECTED_NAME     - name of UNDIRECTED
    %   UNDIRECTED_DESCRIPTION  -  description of UNDIRECTED
    %   DIRECTIONALITY_TYPE_NUMBER     - number of graph directionality types
    %   DIRECTIONALITY_TYPE_NAME  - name of graph directionality types
    %   DIRECTIONALITY_TYPE_DESCRIPTION   - description of graph directionality types
    %   NONSELFCONNECTED   - not self-connected graph
    %   NONSELFCONNECTED_NAME  - name of NONSELFCONNECTED
    %   NONSELFCONNECTED_DESCRIPTION   - description of NONSELFCONNECTED
    %   SELFCONNECTED   - self-connected graph
    %   SELFCONNECTED_NAME  - name of SELFCONNECTED
    %   SELFCONNECTED_DESCRIPTION   - description of SELFCONNECTED
    %   SELFCONNECTIVITY_TYPE_NUMBER     - number of graph self-connectivity types
    %   SELFCONNECTIVITY_TYPE_NAME  - name of graph self-connectivity types
    %   SELFCONNECTIVITY_TYPE_DESCRIPTION   - description of graph self-connectivity types
    %   NONNEGATIVE     - non-negative graph
    %   NONNEGATIVE_NAME    - name of NONNEGATIVE
    %   NONNEGATIVE_DESCRIPTION     - description of NONNEGATIVE
    %   NEGATIVE    - negative graph
    %   NEGATIVE_NAME   - name of NEGATIVE
    %   NEGATIVE_DESCRIPTION    - description of NEGATIVE
    %   NEGATIVITY_TYPE_NUMBER   - number of graph negativity types
    %   NEGATIVITY_TYPE_NAME    - name of graph negativity types
    %   NEGATIVITY_TYPE_DESCRIPTION     - description of graph negativity types
    %
    % Graph methods:
    %   checkA      - checks if A is correct for the graph type.
    %   getList     - return a list with subclasses of graph.
    %   getClass    - returns the class type of the graph.
    %   getName     - returns the name of the graph.
    %   getDescription - returns the description of the graph.
    %   getGraphType    - returns the graph type.
    %   is_graph    - checks if the graph is a single layer graph.
    %   is_multigraph    - checks if the graph is a multigraph.
    %   is_ordered_multiplex   - checks if the graph is an ordered multiplex graph.
    %   is_multiplex    - checks if the graph is a multiplex graph.
    %   is_ordered_multilayer   - checks if the graph is an ordered multilayer graph.
    %   is_multilayer   - checks if the graph is a multilayer graph.
    %   getConnectivityType    - returns if the graph is binary or weighted.
    %   is_weighted - checks if the graph is weighted.
    %   is_binary   - checks if the graph is binary.
    %   getEgdeType    - returns if graph is directed or undirected.
    %   is_directed - checks if the graph is directed.
    %   is_undirected - checks if the graph is undirected.
    %   getSelfConnectivityType    - returns if graph is self-connected or not self-connected.
    %   is_selfconnected - checks if the graph is self connected.
    %   is_not_selfconnected - checks if the graph is not self connected.
    %   getNegativityType    - returns if graph is negative or non-negative
    %   is_nonnegative - checks whether graph allows non-negative values
    %   is_negative - checks whether graph allows negative values
    %   tostring    - returns a string representing the graph.
    %   disp        - displays the graph.
    %   nodenumber  - returns the number of nodes in a graph.
    %   layernumber  - returns the number of layers in a graph. 
    %   getA        - returns the adjacency matrix.
    %   getGraph    - returns a graph with the given inputs.
    %   getCompatibleMeasureList - returns a list with the compatible measures.
    %   getCompatibleMeasureNumber - returns a number of the compatible measures.
    %
    % See also Measure, GraphBU, GraphBD, GraphWU, GraphWD.

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
        A  % adjacency matrix or 2D-cell array of adjacency matrices
        settings  % structure with the constructor varagin
%         measure_dict  % dictionary with calculated measures
    end
    methods (Access=protected)  % Contructor
        function g = Graph(A, varargin)
            % Graph(A) creates a graph with the default properties.
            % A is the adjacency matrix or the cell array of adjacency
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
            % See also Measure, GraphBD, GraphBU, GraphWD, GraphWU.
           
            if length(varargin) == 1
                varargin = varargin{:};
            end
            
            settings = get_from_varargin(varargin, 'Settings', varargin{:});
            
            Graph.checkA(Graph.getGraphType(g), A);  % performs all necessary checks on A
            Graph.checkConnectivity(Graph.getConnectivityType(g), A);
            Graph.checkDirectionality(Graph.getDirectionalityType(g), A);
            Graph.checkSelfConnectivity(Graph.getSelfConnectivityType(g), A);
            Graph.checkNegativity(Graph.getNegativityType(g), A);
            
            g.A = A;
            g.settings = settings;  % initialize the property settings
        end
    end
    methods (Static)  % Checks
        function checkA(graph_type, A)
            % CHECKA checks if adjacency matrix A or cell array of adjacency matrices A is correct for the type of graph
            %
            % CHECKA(GRAPH_TYPE, A) checks if adjacency matrix A or cell array of
            % adjacency matrices A is correct for the GRAPH_TYPE.
            
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

            % This check assumes that checkA has already been passed
            
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

            % This check assumes that checkA has already been passed
            
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

            % This check assumes that checkA has already been passed
            
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
            
            % This check assumes that checkA has already been passed
            
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
    methods (Static)  % Descriptive methods
        function graph_class_list = getList()
            % GETLIST returns the list of available graphs
            %
            % GRAPH_CLASS_LIST = GETLIST() returns the list of graphs
            % (cell array) that are subclasses of Graph.
            %
            % See also getClass(), getCompatibleMeasureList()
            
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
            % See also getList(), getCompatibleMeasureList().
            
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
            % See also getList(), getCompatibleMeasureList().
            
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
            % See also getList(), getCompatibleMeasureList().
            
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
            % See also is_graph(), is_multigraph(), is_multilayer(), is_multiplex(), is_ordered_multilayer(), is_ordered_multiplex().     
                  
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
            % See also getGraphType(), is_multigraph(), is_multilayer(), is_multiplex(), is_ordered_multilayer(), is_ordered_multiplex().     
                  
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
            % See also getGraphType(), is_graph(), is_multilayer(), is_multiplex(), is_ordered_multilayer(), is_ordered_multiplex().     
                    
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
            % See also getGraphType(), is_graph(), is_multigraph(), is_multilayer(), is_multiplex(), is_ordered_multilayer().     
                   
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
            % See also getGraphType(), is_graph(), is_multigraph(), is_multilayer(), is_ordered_multilayer(), is_ordered_multiplex().     
              
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
            % See also getGraphType(), is_graph(), is_multigraph(), is_multilayer(), is_multiplex(), is_ordered_multiplex().     
                
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
            % See also getGraphType(), is_graph(), is_multigraph(), is_multiplex(), is_ordered_multilayer(), is_ordered_multiplex().     
                   
            bool = Graph.getGraphType(g) == Graph.MULTILAYER;
        end
        function connectivity_type = getConnectivityType(g, varargin)
            % GETCONNECTIVITYTYPE returns if graph is binary or weighted
            %
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE(G) returns if
            % the instance of the concrete graph G is binary or weighted.
            %
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE(GRAPH_CLASS) returns 
            % if graph whose class is GRAPH_CLASS is binary or weighted.
            %
            % See also is_binary(), is_weighted().     
            
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
            % See also getConnectivityType(), is_binary().     
            
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
            % See also getConnectivityType(), is_weighted().     
            
            bool = Graph.getConnectivityType(g, varargin{:}) == Graph.BINARY;
        end
        function directionality_type = getDirectionalityType(g, varargin)
            % GETDIRECTIONALITYTYPE returns if graph is directed or undirected
            %
            % DIRECTIONALITY_TYPE = GETDIRECTIONALITYTYPE(G) returns if
            % the instance of the concrete graph G is directed or not
            % undirected.
            %
            % DIRECTIONALITY_TYPE = GETDIRECTIONALITYTYPE(GRAPH_CLASS)
            % returns if graph whose class is GRAPH_CLASS is directed or
            % undirected.
            %
            % See also is_directed(), is_undirected().     
                         
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
            % See also getEgdeType(), is_undirected().     
                     
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
            % See also getEgdeType(), is_directed().     
                    
            bool = Graph.getDirectionalityType(g, varargin{:}) == Graph.UNDIRECTED;
        end
        function selfconnectivity_type = getSelfConnectivityType(g, varargin)
            % GETSELFCONNECTIVITYTYPE returns if graph is self-connected or not self-connected
            %
            % SELFCONNECTIVITY_TYPE = GETSELFCONNECTIVITYTYPE(G) returns if
            % the instance of the concrete graph G is self-connected or not
            % self-connected.
            %
            % SELFCONNECTIVITY_TYPE = GETSELFCONNECTIVITYTYPE(GRAPH_CLASS)
            % returns if graph whose class is GRAPH_CLASS is self-connected
            % or not self-connected.
            %
            % See also is_selfconnected(), is_not_selfconnected().     
                        
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
            % See also getSelfConnectivityType(), is_not_selfconnected().     
             
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
            % See also getSelfConnectivityType(), is_selfconnected().     
                  
            bool = Graph.getSelfConnectivityType(g, varargin{:}) == Graph.NONSELFCONNECTED;
        end
        function negativity_type = getNegativityType(g, varargin)
            % GETNEGATIVITYTYPE returns if graph is negative or non-negative
            %
            % NEGATIVITY_TYPE = GETNEGATIVITYTYPE(G) returns if the instance of the
            % concrete graph G is negative or non-negative.
            %
            % NEGATIVITY_TYPE = GETNEGATIVITYTYPE(GRAPH_CLASS) returns if graph
            % whose class is GRAPH_CLASS is negative or non-negative.
            %
            % See also is_negative(), is_nonnegative().     
            
            negativity_type = eval([Graph.getClass(g, varargin{:}) '.getNegativityType()']);
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
            % See also getNegativityType(), is_negative().
            
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
            % See also getNegativityType(), is_nonnegative().
            
            bool = Graph.getNegativityType(g, varargin{:}) == Graph.NEGATIVE;
        end
    end
    methods  % Basic functions
        function str = tostring(g)
            % TOSTRING string with information about the graph
            %
            % STR = TOSTRING(G) returns string with the graph class and size (layers and nodes).
            %
            % See also disp().
            
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
            % See also tostring().
            
            disp(['<a href="matlab:help ' Graph.getClass(g) '">' Graph.getClass(g) '</a>'])
            disp([g.TYPE_DESCRIPTION{Graph.getGraphType(g)} ])
            disp([' size: ' int2str(g.layernumber(g)) ' layers with ' int2str(g.nodenumber(g)) ' nodes'])
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
            % See also getA(), nodenumber().
            
            if nargin<2
                res = g.settings;
            else
                res = get_from_varargin([], setting_code, g.settings{:});
            end
        end
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
            % initializes he property settings with the properties and values.
            %
            % G = GETGRAPH(G, A, 'Settings', SETTINGS)
            % G = GETGRAPH(GRAPH_CLASS, A, 'Settings', SETTINGS)
            % initializes the property settings with SETTINGS.
            %
            % See also getList(), getCompatibleMeasureList().
            
            g_new = eval([Graph.getClass(g) '(A, varargin{:})']);
        end
    end
    methods (Static)  % Inspection functions
        function n = nodenumber(g)
            % NODENUMBER returns the number of nodes in the graph
            %
            % N = NODENUMBER(G) returns the number of nodes in graph G.
            %
            % See also getA(), getSettings(), layernumber().

            switch Graph.getGraphType(g)
                case Graph.GRAPH
                    n = length(g.getA(g));
                otherwise
                    A = g.getA(g); % #ok<PROP>
                    n = cellfun(@(a) length(a), A(1:length(A)+1:end)); % #ok<PROP>
            end
        end
        function n = layernumber(g)
            % LAYERNUMBER returns the number of layers in the graph
            %
            % N = LAYERNUMBER(G) returns the number of layers in graph G.
            %
            % See also getA(), getSettings(), nodenumber().
            
            switch Graph.getGraphType(g)
                case Graph.GRAPH
                    n = 1;
                otherwise
                    n = length(g.getA(g));
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
            % See also getSettings(), layernumber(), nodenumber().
            
            if nargin == 1  % return cell array of adjacency matrices
                A = g.A;
            elseif nargin == 2  % return A{i, i}
                A = g.A{i, i};
            else  % return A{i, j}
                A = g.A{i, j};
            end
        end
    end
    methods (Static)  
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
            % See also edgeattack().
                        
            if nargin < 3
                layernumbers = 1:1:g.layernumber(g);
            end   
            
            A = g.getA(g);
            
            switch Graph.getGraphType(g)
                case Graph.GRAPH
                    A(nodes(:), :) = 0;
                    A(:, nodes(:)) = 0;
                    
                otherwise              
                    for i = layernumbers
                        B = A{i, i};
                        B(nodes(:), :) = 0; 
                        B(:, nodes(:)) = 0; 
                        A(i, i) = {B};
                    end
            end
            ga = Graph.getGraph(Graph.getClass(g), A, g.getSettings());  % #ok<PROPLC>
        end
        function ga = edgeattack(g, nodes1, nodes2, layernumbers_i, layernumbers_j)
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
            % See also nodeattack().
                
            if nargin < 4
                layernumbers_i = 1:1:g.layernumber(g);
            end
            
            if nargin < 5 
                layernumbers_j = layernumbers_i;
            end 
            
            A = g.getA(g);  % #ok<PROPLC>
            
            switch Graph.getGraphType(g)
                case Graph.GRAPH
                    A(sub2ind(size(A), nodes1, nodes2)) = 0;  % #ok<PROPLC>
                    if g.is_undirected(g)
                        A(sub2ind(size(A), nodes2, nodes1)) = 0;  % #ok<PROPLC>
                    end

                otherwise
                    for i = 1:1:length(layernumbers_i)
                        B = A{layernumbers_i(i), layernumbers_j(i)};
                        B(sub2ind(size(B), nodes1, nodes2)) = 0;  % #ok<PROPLC>
                        if g.is_undirected(g) & (layernumbers_i(i) == layernumbers_j(i))
                            B(sub2ind(size(B), nodes2, nodes1)) = 0;  % #ok<PROPLC>
                        elseif g.is_undirected(g) & (layernumbers_i(i) ~= layernumbers_j(i))
                            C = A{layernumbers_j(i), layernumbers_i(i)};
                            if size(C, 1) == size(C, 2)
                                C(sub2ind(size(C), nodes1, nodes2)) = 0;  % #ok<PROPLC>
                            else
                                C = C';
                                C(sub2ind(size(C), nodes1, nodes2)) = 0;  % #ok<PROPLC>
                                C = C';
                            end    
                            A(layernumbers_j(i), layernumbers_i(i)) = {C};
                        end
                        A(layernumbers_i(i), layernumbers_j(i)) = {B};
                    end
            end 
            ga = Graph.getGraph(Graph.getClass(g), A, g.getSettings());  % #ok<PROPLC>
        end
    end
%     methods (Access=protected)
%         function g = Graph(A, varargin)
%             % Graph(A) creates a graph with the default properties.
%             % A is the adjacency matrix. This method is only accessible
%             % by the subclasses of Graph.
%             %
%             % Graph(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...)
%             % creates a graph with properties and values. It initializes
%             % the property settings with the properties and values.
%             %
%             % GRAPH(A, 'Settings', SETTINGS) ceates a graph and
%             % initializes the property settings with SETTINGS.
%             %
%             % See also Measure, GraphBD, GraphBU, GraphWD, GraphWU.
%             
%             if length(varargin) == 1
%                 varargin = varargin{:};
%             end
% 
%             settings = get_from_varargin(varargin, 'Settings', varargin{:});
%             measure_dict = get_from_varargin(containers.Map, 'MeasureDictionary', varargin{:});
%             
%             g.A = A;  % initialize the property A
%             g.settings = settings;  % initialize the property settings
%             g.measure_dict = measure_dict;  % initialize the property measure_dict
%         end
%         function g_copy = copyElement(g)
%             % COPYELEMENT(G) copies elements of graph
%             %
%             % G_COPY = COPYELEMENT(G) copies elements of the graph G.
%             % Makes a deep copy of the structure of the graph.
%             %
%             % See also Cohort.
%             
%             % Make a shallow copy
%             g_copy = copyElement@matlab.mixin.Copyable(g);
%             
%             % Make a deep copy of settings
%             g_copy.settings = copy_varargin(g.settings{:});
%             
%             % Make a deep copy of measure_dict
%             g_copy.measure_dict = containers.Map;
%             measures = values(g.measure_dict);
%             for i = 1:1:length(measures)
%                 m = measures{i};
%                 if m.is_value_calculated()
%                     g_copy.measure_dict(m.getMeasureCode()) = Measure.getMeasure( ...
%                         m.getMeasureCode(), ...
%                         g_copy, ...
%                         'Value', m.getValue(), ...
%                         'Settings', copy_varargin(m.getSettings()) ...
%                         );
%                 else
%                     g_copy.measure_dict(m.getMeasureCode()) = Measure.getMeasure( ...
%                         m.getMeasureCode(), ...
%                         g_copy, ...
%                         'Settings', copy_varargin(m.getSettings()) ...
%                         );
%                 end
%             end
%         end
%     end
%     methods
%         function m = getMeasure(g, measure_class)
%             % GETMEASURE returns measure
%             %
%             % M = GETMEASURE(G, MEASURE_CLASS) checks if the measure
%             % exists in the property MDICT. If not it creates a new measure
%             % M of class MEASURE_CLASS with properties defined by the graph
%             % settings. The user must call getValue() for the new measure M
%             % to retrieve the value of measure M.
%             %
%             % See also getMeasureValue(), is_measure_calculated().
%             
%             if isKey(g.measure_dict, measure_class)
%                 m = g.measure_dict(measure_class);
%             else
%                 m = Measure.getMeasure(measure_class, g, g.settings{:});
%                 g.measure_dict(measure_class) = m;
%             end
%         end
%         function bool = is_measure_calculated(g, measure_class)
%             % IS_MEASURE_CALCULATED checks if a measure is calculated
%             %
%             % BOOL = IS_MEASURE_CALCULATED(G) returns true if a value of a
%             % measure has been already calculated. If a measure M is
%             % created by using the function getMeasure(), the user needs to
%             % call the function getMeasureValue() to calculate the measure and
%             % obtain a value.
%             %
%             % See also getMeasure(), getMeasureValue().
%             
%             if isKey(g.measure_dict, measure_class)
%                 bool = g.measure_dict(measure_class).is_value_calculated();
%             else
%                 bool = false;
%             end
%         end
%         function value = getMeasureValue(g, measure_class)
%             % GETMEASUREVALUE returns the value of a measure
%             %
%             % VALUE = GETMEASUREVALUE(G, MEASURE_CLASS) returns the value of
%             % a measure of type MEASURE_CLASS.
%             %
%             % See also getMeasure(), is_measure_calculated().
%             
%             value = g.getMeasure(measure_class).getValue();
%         end
%         function sg = subgraph(g, nodes)
%             % SUBGRAPH creates subgraph from given nodes
%             %
%             % SG = SUBGRAPH(G, NODES) creates the graph SG as a subgraph of G
%             % containing only the nodes specified by NODES.
%             
%             A = g.getA(); %#ok<PROPLC>
%             sg = Graph.getGraph(Graph.getClass(g), A(nodes, nodes), g.getSettings()); %#ok<PROPLC>
%         end
%     methods (Abstract)
%         randomize_graph(n);
%     end
%     methods (Static)
%         function list = getCompatibleMeasureList(g)
%             % GETCOMPATIBLEMEASURELIST returns the list of measures
%             %
%             % CELL ARRAY = GETCOMPATIBLEMEASURELIST(G) returns a cell array of
%             % compatible measures to the concrete graph G.
%             %
%             % CELL ARRAY = GETCOMPATIBLEMEASURELIST(GRAPH_CLASS) returns a 
%             % cell array of compatible measures to a graph whose class is
%             % GRAPH_CLASS.
%             %
%             % See also getList(), getCompatibleMeasureNumber().
%             
%             graph_class = Graph.getClass(g);
%             
%             measure_code_list = Measure.getList();
%             
%             list = cell(1, length(measure_code_list));
%             for i = 1:1:length(measure_code_list)
%                 measure_code = measure_code_list{i};
%                 
%                 if are_compatible(graph_class, measure_code)
%                     list{i} = measure_code;
%                 end
%             end
%             list(cellfun('isempty', list)) = [];
%         end
%         function n = getCompatibleMeasureNumber(g)
%             % GETCOMPATIBLEMEASURENUMBER returns the number of compatible
%             % measures
%             %
%             % N = GETCOMPATIBLEMEASURENUMBER(G) returns the number of
%             % compatible measures to the concrete graph G.
%             %
%             % N = GETCOMPATIBLEMEASURENUMBER(GRAHP_CLASS) returns the number
%             % of compatible measures to graph whose class is GRAPH_CLASS.
%             %
%             % See also getList(), getCompatibleMeasureList().
%             
%             list = Graph.getCompatibleMeasureList(g);
%             n = numel(list);
%         end
%     end
end