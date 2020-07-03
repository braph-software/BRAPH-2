classdef GraphBU < GraphBD
    % GraphBU A binary undirected graph
    % GraphBU represents a binary undirected graph.
    %
    % GraphBD consists of a binary undirected graph.
    %
    % GraphBU methods:
    %   GraphBU                 - constructor
    %
    % GraphBU descriptive methods (static):
    %   getClass                - returns the class name
    %   getName                 - returns the complete name
    %   getDescription          - returns the description
    %   getGraphType            - returns the graph type
    %   getConnectivityType     - returns the connectivity type of the graph
    %   getDirectionalityType   - returns the directionality type of the graph
    %   getSelfConnectivityType - returns the self-connectivity type of the graph
    %   getNegativityType       - returns the negativity type of the graph
    %   getCompatibleMeasureList - returns a list with compatible measures
    %   getCompatibleMeasureNumber - returns the number of compatible measures
    %
    % See also Graph, GraphBD, GraphWD, GraphWU.
    
    methods
        function g = GraphBU(A, varargin)
            % GRAPHBU(A) creates a GRAPHBU class with adjacency matrix A.
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % function: SYMMETRIZE.
            % It calls the superclass constructor GRAPHBD.
            %
            % GRAPHBU(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...) creates
            % a GRAPHBU class with adjacency matrix A and it passes the
            % properties and values to the superclass as VARARGIN.
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % function: SYMMETRIZE.
            % It calls the superclass constructor GRAPHBD.
            %
            % See also Graph, DummyGraph, GraphBD, GraphWD, GraphWU.
            
            A = symmetrize(A, varargin{:});  % enforces symmetry of adjacency matrix
            
            g = g@GraphBD(A, varargin{:});
        end
    end 
    methods (Static)  % Descriptive methods
        function graph_class = getClass()
            % GETCLASS returns the class of the graph.
            %
            % GRAPH_CLASS = GETCLASS() returns the class, 'GraphBU'.
            %
            % See also getName, getDescription.
            
            graph_class = 'GraphBU';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % NAME = GETCLASS() returns the name, 'Binary Undirected Graph'.
            %
            % See also getClass, getDescription.
            
            name = 'Binary Undirected Graph';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of GRAPHBU.
            %
            % See also getClass, getName.
            
            description = [ ...
                'In a binary undirected (BU) graph, ' ...
                'the edges can be either 0 (absence of connection) ' ...
                'or 1 (existence of connection), ' ...
                'and they are undirected.' ...
                'The connectivity matrix is symmetric.' ...
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
            % DIRECTIONALITY_TYPE = GETDIRECTIONALITYTYPE() returns Graph.UNDIRECTED.
            %
            % See also Graph, getConnectivityType, getGraphType, getNegativityType, getSelfConnectivityType.
        
            directionality_type = Graph.UNDIRECTED;
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
            available_settings = { ...
                 'GraphBU.attempts_per_edge', BRAPH2.NUMERIC, 5, {} ...
                 };
        end
    end
%     methods
%         function g = GraphBU(A, varargin)
%             % GRAPHBU(A) creates a GRAPHBU class with adjacency matrix A.
%             % This function is the constructor, it initializes the class by
%             % operating the adjacency matrix A with the following
%             % function: SYMMETRIZE.
%             % It calls the superclass constructor GRAPHBD.
%             %
%             % GRAPHBU(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...) creates
%             % a GRAPHBU class with adjacency matrix A and it passes the
%             % properties and values to the superclass as VARARGIN.
%             % This function is the constructor, it initializes the class by
%             % operating the adjacency matrix A with the following
%             % function: SYMMETRIZE.
%             % It calls the superclass constructor GRAPHBD.
%             %
%             % See also Graph, GraphBD, GraphWD, GraphWU.
%             
%             A = symmetrize(A, varargin{:});  % enforces symmetry of adjacency matrix
%             
%             g = g@GraphBD(A, varargin{:});
%         end
%     end
    methods
        function [randomized_graph, swaps] = randomize_graph(g, varargin)
            % RANDOMIZE_GRAPH returns a randomized graph and the number of swaps.
            %
            % RANDOMIZED_GRAPH, SWAPS = RANDOMIZE_GRAPH() returns the randomized graph
            % RANDOMIZED_GRAPH obtained from a number of edge swaps SWAPS.
            
             % get rules
            attempts_per_edge = g.getSettings('GraphBU.attempts_per_edge');
            
            if nargin<2
                attempts_per_edge = 5;
            end
            
            % get A
            A = g.getA();
            
            % remove self connections
            A(1:length(A)+1:numel(A)) = 0;
            [I_edges, J_edges] = find(triu(A)); % find the edges
            E = length(I_edges); % number of edges
            
            randomized_graph = A;
            swaps = 0; % number of successful edge swaps
            for attempt=1:1:attempts_per_edge*E
                
                % select two edges
                selected_edges = randperm(E,2);
                node_start_1 = I_edges(selected_edges(1));
                node_end_1 = J_edges(selected_edges(1));
                node_start_2 = I_edges(selected_edges(2));
                node_end_2 = J_edges(selected_edges(2));
                
                if rand(1) > 0.5
                    I_edges(selected_edges(2)) = node_end_2;
                    J_edges(selected_edges(2)) = node_start_2;
                    
                    node_start_2 = I_edges(selected_edges(2));
                    node_end_2 = J_edges(selected_edges(2));
                end
                
                % Swap edges if:
                % 1) no edge between node_start_1 and node_end_2
                % 2) no edge between node_start_2 and node_end_1
                % 3) node_start_1 ~= node_start_2
                % 4) node_end_1 ~= node_end_2
                % 5) node_start_1 ~= node_end_2
                % 6) node_start_2 ~= node_end_1
                
                if ~randomized_graph(node_start_1, node_end_2) && ...
                        ~randomized_graph(node_start_2, node_end_1) && ...
                        node_start_1~=node_start_2 && ...
                        node_end_1~=node_end_2 && ...
                        node_start_1~=node_end_2 && ...
                        node_start_2~=node_end_1
                    
                    % erase old edges
                    randomized_graph(node_start_1, node_end_1) = 0;
                    randomized_graph(node_end_1, node_start_1) = 0;
                    
                    randomized_graph(node_start_2, node_end_2) = 0;
                    randomized_graph(node_end_2, node_start_2) = 0;
                    
                    % write new edges
                    randomized_graph(node_start_1, node_end_2) = 1;
                    randomized_graph(node_end_2, node_start_1) = 1;
                    
                    randomized_graph(node_start_2, node_end_1) = 1;
                    randomized_graph(node_end_1, node_start_2) = 1;
                    
                    % update edge list
                    J_edges(selected_edges(1)) = node_end_2;
                    J_edges(selected_edges(2)) = node_end_1;
                    
                    swaps = swaps+1;
                end
            end
        end
    end
%     methods (Static)
%         function list = getCompatibleMeasureList()
%             % GETCOMPATIBLEMEASURELIST returns a list with compatible measures.
%             %
%             % LIST = GETCOMPATIBLEMEASURELIST() returns a list with
%             % compatible measures to the graph.
%             %
%             % See also getCompatibleMeasureNumber().
%             
%             list = Graph.getCompatibleMeasureList('GraphBU');
%         end
%         function n = getCompatibleMeasureNumber()
%             % GETCOMPATIBLEMEASURENUMBER returns a number of the compatible measures.
%             %
%             % N = GETCOMPATIBLEMEASURENUMBER() returns the number of
%             % compatible measures to the graph.
%             %
%             % See also getCompatibleMeasureList().
%             
%             n = Graph.getCompatibleMeasureNumber('GraphBU');
%         end
%     end
end