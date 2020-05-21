classdef GraphBD < Graph
    % GraphBD < Graph: A binary directed graph
    % GraphBD represents a binary directed graph.
    %
    % GraphBD methods:
    %   GraphBD     - constructor.
    %
    % GraphBD methods (static):
    %   getClass	- return the class type GraphBD.
    %   getName     - return the complete name of GraphBD.
    %   getDescription - return the description of GraphBD.
    %   is_selfconnected - boolean, checks if the graph is self-connected.
    %   is_nonnegative - boolean, checks if the graph is non-negative.
    %   is_weighted - boolean, checks if the graph is weighted.
    %   is_binary   - boolean, checks if the graph is binary.
    %   is_directed - boolean, checks if the graph is directed.
    %   is_undirected - boolean, checks if the graph is undirected.
    %   getCompatibleMeasureList - returns a list with compatible measures.
    %   getCompatibleMeasureNumber - returns the number of compatible measures.
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
            % See also Graph, GraphBU, GraphWD, GraphWU.
            
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
            % See also getName().
            
            graph_class = 'GraphBD';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % NAME = GETCLASS() returns the name, 'Binary Directed Graph'.
            %
            % See also getClass().
            
            name = 'Binary Directed Graph';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of GRAPHBD.
            %
            % See also getName().
            
            description = [ ...
                'In a binary directed (BD) graph, ' ...
                'the edges can be either 0 (absence of connection) ' ...
                'or 1 (existence of connection), ' ...
                'and they are directed.' ...
                ];
        end
        function graph_type = getGraphType()
            graph_type = Graph.GRAPH;
        end
        function connection_type = getConnectionType()
            connection_type = Graph.BINARY;
        end
        function edge_type = getEdgeType()
            edge_type = Graph.DIRECTED;
        end
        function selfconnectivity_type = getSelfConnectivityType()
            selfconnectivity_type = Graph.NOT_SELFCONNECTED; 
        end
        function negativity_type = getNegativityType()
            % GETNEGATIVITYTYPE checks if the graph is non-negative or negative
            %
            % BOOL = GETNEGATIVITYTYPE() returns NONNEGATIVE for GRAPHBD.
            %
            % See also getConnectivityType(), getEdgeType(), getGraphType() and getSelfConnectivityType().
            
            negativity_type = Graph.NONNEGATIVE;
        end
    end
%     methods
%         function g = GraphBD(A, varargin)
%             % GRAPHBD(A) creates a GRAPHBD class with adjacency matrix A.
%             % This function is the constructor, it initializes the class by
%             % operating the adjacency matrix A with the following
%             % functions: DEDIAGONALIZE, SEMIPOSITIVE, BINARIZE.
%             % It calls the superclass constructor GRAPH.
%             %
%             % GRAPHBD(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...) creates
%             % a GRAPHBD class with adjacency matrix A and it passes the
%             % properties and values to the superclass as VARARGIN.
%             % This function is the constructor, it initializes the class by
%             % operating the adjacency matrix A with the following
%             % functions: DEDIAGONALIZE, SEMIPOSITIVE, BINARIZE.
%             % It calls the superclass constructor GRAPH.
%             %
%             % See also Graph, GraphBU, GraphWD, GraphWU.
%             
%             A = dediagonalize(A, varargin{:});  % removes self-connections by removing diagonal from adjacency matrix
%             A = semipositivize(A, varargin{:});  % removes negative weights
%             A = binarize(A, varargin{:});  % enforces binary adjacency matrix
%             
%             g = g@Graph(A, varargin{:});
%         end
%     end
%     methods
%         function [randomized_graph, swaps] = randomize_graph(g, varargin)
%             % get rules
%             attempts_per_edge = get_from_varargin(10, 'AttemptsPerEdge', varargin{:});
%             
%             if nargin<2
%                 attempts_per_edge = 5;
%             end
%             
%             % get A
%             A = g.getA();
%             
%             % remove self connections
%             A(1:length(A)+1:numel(A)) = 0;
%             [I_edges, J_edges] = find(A); % find all the edges
%             E = length(I_edges); % number of edges
%             
%             randomized_graph = A;
%             swaps = 0; % number of successful edge swaps
%             for attempt = 1:1:attempts_per_edge*E
%                 
%                 % select two edges
%                 selected_edges = randperm(E,2);
%                 node_start_1 = I_edges(selected_edges(1));
%                 node_end_1 = J_edges(selected_edges(1));
%                 node_start_2 = I_edges(selected_edges(2));
%                 node_end_2 = J_edges(selected_edges(2));
%                 
%                 % Swap edges if:
%                 % 1) no edge between node_start_2 and node_end_1
%                 % 2) no edge between node_start_1 and node_end_2
%                 % 3) node_start_1 ~= node_start_2
%                 % 4) node_end_1 ~= node_end_2
%                 % 5) node_start_1 ~= node_end_2
%                 % 6) node_start_2 ~= node_end_1
%                 if ~randomized_graph(node_start_1, node_end_2) && ...
%                         ~randomized_graph(node_start_2, node_end_1) && ...
%                         node_start_1~=node_start_2 && ...
%                         node_end_1~=node_end_2 && ...
%                         node_start_1~=node_end_2 && ...
%                         node_start_2~=node_end_1
%                     
%                     % erase old edges
%                     randomized_graph(node_start_1, node_end_1) = 0;
%                     randomized_graph(node_start_2, node_end_2) = 0;
%                     
%                     % write new edges
%                     randomized_graph(node_start_1, node_end_2) = 1;
%                     randomized_graph(node_start_2, node_end_1) = 1;
%                     
%                     % update edge list
%                     J_edges(selected_edges(1)) = node_end_2;
%                     J_edges(selected_edges(2)) = node_end_1;
%                     
%                     swaps = swaps+1;
%                 end
%             end
%         end
%     end
%     methods (Static)
%         function list = getCompatibleMeasureList()
%             % GETCOMPATIBLEMEASURELIST returns a list with compatible measures.
%             %
%             % LIST = GETCOMPATIBLEMEASURELIST() returns a list with
%             % compatible measures to the graph.
%             %
%             % See also getCompatibleMeasureNumber().
%             
%             list = Graph.getCompatibleMeasureList('GraphBD');
%         end
%         function n = getCompatibleMeasureNumber()
%             % GETCOMPATIBLEMEASURENUMBER returns a number of the compatible measures.
%             %
%             % N = GETCOMPATIBLEMEASURENUMBER() returns the number of
%             % compatible measures to the graph.
%             %
%             % See also getCompatibleMeasureList().
%             
%             n = Graph.getCompatibleMeasureNumber('GraphBD');
%         end
%     end
end
