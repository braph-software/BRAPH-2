classdef GraphBD < Graph
    % GraphBD A binary directed graph
    % GraphBD represents a binary directed graph.
    %
    % GraphBD consists of a binary directed graph.
    %
    % GraphBD methods:
    %   GraphBD                 - constructor
    %
    % GraphBD descriptive methods (static):
    %   getClass                - returns the class name
    %   getName                 - returns the complete name
    %   getDescription          - returns the description
    %   getGraphType            - returns the graph type
    %   getConnectivityType     - returns the connectivity type of the graph
    %   getDirectionalityType   - returns the directionality type of the graph
    %   getSelfConnectivityType - returns the self-connectivity type of the graph
    %   getNegativityType       - returns the negativity type of the graph
    %
    % GraphBD randomize graph method
    %   randomize               - returns a randomized graph
    %
    % GraphBD randomize A method (Static)
    %   randomize_A             - returns a randomized correlation matrix
    %
    % See also Graph, GraphBU, GraphWD, GraphWU.
    
    methods
        function g = GraphBD(A, varargin)
            % GRAPHBD(A) creates a GRAPHBD class with adjacency matrix A.
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % functions: DEDIAGONALIZE, SEMIPOSITIVE, BINARIZE.
            % It calls the superclass constructor GRAPH.
            %
            % GRAPHBD(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...) creates
            % a GRAPHBD class with adjacency matrix A and it passes the
            % properties and values to the superclass as VARARGIN.
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % functions: DEDIAGONALIZE, SEMIPOSITIVE, BINARIZE.
            % It calls the superclass constructor GRAPH.
            %
            % See also Graph, DummyGraph, GraphBU, GraphWD, GraphWU.
            
            A = dediagonalize(A, varargin{:});  % removes self-connections by removing diagonal from adjacency matrix
            A = semipositivize(A, varargin{:});  % removes negative weights
            A = binarize(A, varargin{:});  % enforces binary adjacency matrix
            
            g = g@Graph(A, varargin{:});
        end
    end
    methods (Static)  % Descriptive methods
        function graph_class = getClass()
            % GETCLASS returns the class of the graph.
            %
            % GRAPH_CLASS = GETCLASS() returns the class, 'GraphBD'.
            %
            % See also getName, getDescription.
            
            graph_class = 'GraphBD';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % NAME = GETCLASS() returns the name, 'Binary Directed Graph'.
            %
            % See also getClass, getDescription.
            
            name = 'Binary Directed Graph';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of GRAPHBD.
            %
            % See also getClass, getName.
            
            description = [ ...
                'In a binary directed (BD) graph, ' ...
                'the edges can be either 0 (absence of connection) ' ...
                'or 1 (existence of connection), ' ...
                'and they are directed.' ...
                ];
        end
        function graph_type = getGraphType()
            % GETGRAPHTYPE returns the graph type
            %
            % GRAPH_TYPE = GETGRAPHTYPE() returns Graph.GRAPH.
            %
            % See also getConnectivityType, getDirectionalityType, getNegativityType, getSelfConnectivityType.
          
            graph_type = Graph.GRAPH;
        end
        function connectivity_type = getConnectivityType(varargin)
            % GETCONNECTIVITYTYPE returns the connectivity type of the graph
            %
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE() returns Graph.BINARY.
            %    
            % See also Graph, getDirectionalityType, getGraphType, getNegativityType, getSelfConnectivityType.
           
            connectivity_type = Graph.BINARY;
        end
        function directionality_type = getDirectionalityType(varargin)
            % GETDIRECTIONALITYTYPE returns the directionality type of the graph
            %   
            % DIRECTIONALITY_TYPE = GETDIRECTIONALITYTYPE() returns Graph.DIRECTED.
            %
            % See also Graph, getConnectivityType, getGraphType, getNegativityType, getSelfConnectivityType.
        
            directionality_type = Graph.DIRECTED;
        end
        function selfconnectivity_type = getSelfConnectivityType(varargin)
            % GETSELFCONNECTIVITYTYPE returns the self-connectivity type of the graph
            %    
            % SELFCONNECTIVITY_TYPE = GETSELFCONNECTIVITYTYPE() returns Graph.NONSELFCONNECTED.
            %
            % See also Graph, getConnectivityType, getDirectionalityType, getGraphType, getNegativityType.
           
            selfconnectivity_type = Graph.NONSELFCONNECTED; 
        end
        function negativity_type = getNegativityType(varargin)
            % GETNEGATIVITYTYPE returns the negativity type of the graph
            %
            % NEGATIVITY_TYPE = GETNEGATIVITYTYPE() returns Graph.NONNEGATIVE.
            %
            % See also Graph, getConnectivityType, getDirectionalityType, getGraphType, getSelfConnectivityType.
            
            negativity_type = Graph.NONNEGATIVE;
        end
        function available_settings = getAvailableSettings(g) %#ok<INUSD>
            % GETAVAILABLESETTINGS returns the available rules of graph
            %
            % GETAVAILABLESETTINGS(G) returns an array with the available
            % settings for the graph. 
            %
            % See also getClass, getName, getDescription, getGraphType.
            
            available_settings = {};
        end
    end
    methods
        function random_g = randomize(g, varargin)
            % RANDOMIZE returns a randomized graph
            %
            % RANDOM_G = RANDOMIZE(G) returns the randomized graph
            % RANDOM_G obtained with a randomized correlation
            % matrix via the static function randomize_A while preserving 
            % degree and strength distributions.
            %
            % RANDOM_G = RANDOMIZE(G, 'AttemptPerEdge', VALUE) returns the 
            % randomized graph RANDOM_G obtained with a randomized correlation
            % matrix via the static function randomize_A while preserving
            % degree and strength distributions, it passes the
            % attempts per edge specified by the user.
            %
            % See also randomize_A
            
            attempts_per_edge = get_from_varargin(5, 'AttemptsPerEdge', varargin{:});
            
            A = g.getA();
            random_A = GraphBD.randomize_A(A, attempts_per_edge);
                        
            random_g = Graph.getGraph(Graph.getClass(g), ...
                random_A, ...
                varargin{:});            
        end
    end
    methods (Static)
        function [random_A, swaps] = randomize_A(A, attempts_per_edge)
            % RANDOMIZE_A returns a randomized correlation matrix
            %
            % RANDOM_A = RANDOMIZE(G) returns the randomized matrix
            % RANDOM_A. Tries to swap 5 times an edge. 
            %
            % [RANDOM_A, SWAPS] = RANDOMIZE(G) attempts to rewire each edge 
            % 5 times. Returns the randomized matrix RANDOM_A. Returns the
            % number of succesful edge swaps.  This algorithm was proposed
            % by Maslov and Sneppen (Science 296, 910, 2002)
            %
            % [RANDOM_A, SWAPS] = RANDOMIZE(G, ATTEMPTS_PER_EDGE) attempts
            % to rewire each edge ATTEMPTS_PER_EDGE times then it returns the 
            % randomized matrix RANDOM_A. Returns the number of succesful edge swaps.
            %
            % Modification History: 
            % May 2019: Original (Adam Liberda, Theo Berglin, Mite Mijalkov & Giovanni Volpe)
            %
            % See also randomize
            
            if nargin < 2
                attempts_per_edge = 5;
            end

            % remove self connections
            A(1:length(A)+1:numel(A)) = 0;
            [I_edges, J_edges] = find(A); % find all the edges
            E = length(I_edges); % number of edges
            
            random_A = A;
            swaps = 0; % number of successful edge swaps
            for attempt = 1:1:attempts_per_edge*E
                
                % select two edges
                selected_edges = randperm(E,2);
                node_start_1 = I_edges(selected_edges(1));
                node_end_1 = J_edges(selected_edges(1));
                node_start_2 = I_edges(selected_edges(2));
                node_end_2 = J_edges(selected_edges(2));
                
                % Swap edges if:
                % 1) no edge between node_start_2 and node_end_1
                % 2) no edge between node_start_1 and node_end_2
                % 3) node_start_1 ~= node_start_2
                % 4) node_end_1 ~= node_end_2
                % 5) node_start_1 ~= node_end_2
                % 6) node_start_2 ~= node_end_1
                if ~random_A(node_start_1, node_end_2) && ...
                        ~random_A(node_start_2, node_end_1) && ...
                        node_start_1~=node_start_2 && ...
                        node_end_1~=node_end_2 && ...
                        node_start_1~=node_end_2 && ...
                        node_start_2~=node_end_1
                    
                    % erase old edges
                    random_A(node_start_1, node_end_1) = 0;
                    random_A(node_start_2, node_end_2) = 0;
                    
                    % write new edges
                    random_A(node_start_1, node_end_2) = 1;
                    random_A(node_start_2, node_end_1) = 1;
                    
                    % update edge list
                    J_edges(selected_edges(1)) = node_end_2;
                    J_edges(selected_edges(2)) = node_end_1;
                    
                    swaps = swaps+1;
                end
            end
        end
    end
end
