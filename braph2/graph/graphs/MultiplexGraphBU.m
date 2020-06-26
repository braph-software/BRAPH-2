classdef MultiplexGraphBU < MultiplexGraphBD
    % MultiplexGraphBU A multiplex binary undirected graph
    % MultiplexGraphBU represents a multiplex binary undirected graph.
    %  
    % MultiplexGraphBU consists of a multiplex where the layers are binary 
    % undirected graphs and the connections are binary directed graphs.
    % 
    % MultiplexGraphBU methods:
    %   MultiplexGraphBU        - constructor
    %
    % MultiplexGraphBU descriptive methods (static):
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
    % See also Graph, MultiplexGraphBD, MultiplexGraphWD, MultiplexGraphWU.
    
    methods
        function g = MultiplexGraphBU(A, varargin)
            % MULTIPLEXGRAPHBU(A) creates a MULTIPLEXGRAPHBU class with adjacency matrix A.
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % function: SYMMETRIZE.
            % It calls the superclass constructor MULTIPLEXGRAPHBD.
            %
            % MULTIPLEXGRAPHBU(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...) creates
            % a MULTIPLEXGRAPHBU class with adjacency matrix A and it passes the
            % properties and values to the superclass as VARARGIN.
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % function: SYMMETRIZE.
            % It calls the superclass constructor MULTIPLEXGRAPHBD.
            %
            % See also Graph, MultiplexGraphBD, MultiplexGraphWD, MultiplexGraphWU.
            
            if isempty(A)
                A = {
                    symmetrize(round(rand(4)))  round(diag(rand(4, 1)))     round(diag(rand(4, 1)))	
                    round(diag(rand(4, 1)))     symmetrize(round(rand(4))) 	round(diag(rand(4, 1)))	
                    round(diag(rand(4, 1)))     round(diag(rand(4, 1)))     symmetrize(round(rand(4)))   
                    };
            end    
            
            L = length(A);  % number of layers
            for layer = 1:1:L
                M = A{layer, layer};
                M = symmetrize(M, varargin{:});  % enforces symmetry of adjacency matrix
                A(layer, layer) = {M};
            end
            
            g = g@MultiplexGraphBD(A, varargin{:});
        end
    end 
    methods (Static)  % Descriptive methods
        function graph_class = getClass()
            % GETCLASS returns the class of the graph.
            %
            % GRAPH_CLASS = GETCLASS() returns the class, 'MultiplexGraphBU'.
            %
            % See also getName, getDescription.
            
            graph_class = 'MultiplexGraphBU';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % NAME = GETCLASS() returns the name, 'Multiplex Binary Undirected Graph'.
            %
            % See also getClass, getDescription.
            
            name = 'Multiplex Binary Undirected Graph';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of MULTIPLEXGRAPHBU.
            %
            % See also getClass, getName.
            
            description = [ ...
                'In a multiplex binary undirected graph, ' ...
                'all the layers consist of binary undirected (BU)' ...
                'graphs and the connections between layers consist ' ...
                'of binary directed (BD).' ...
                ];
        end
        function graph_type = getGraphType()
            % GETGRAPHTYPE returns the graph type
            %
            % GRAPH_TYPE = GETGRAPHTYPE() returns Graph.MULTIPLEX.
            %
            % See also getConnectivityType, getDirectionalityType, getNegativityType, getSelfConnectivityType.

            graph_type = Graph.MULTIPLEX;
        end
        function connectivity_type = getConnectivityType(varargin)
            % GETCONNECTIVITYTYPE returns the connectivity type of the graph
            %
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE() returns
            % Graph.BINARY.
            %
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE(LAYERNUMBER) returns 
            % a matrix with Graph.BINARY for all the elements.
            % For example, for a 3x3 matrix it returns:
            % CONNECTIVITY_TYPE = BINARY  BINARY  BINARY
            %                     BINARY  BINARY  BINARY  
            %                     BINARY  BINARY  BINARY  
            % where BINARY = Graph.BINARY.
            %
            % See also Graph, getDirectionalityType, getGraphType, getNegativityType, getSelfConnectivityType.
         
            if isempty(varargin)
                connectivity_type = Graph.BINARY;
            else
                layernumber = varargin{1};             
                connectivity_type = Graph.BINARY * ones(layernumber);
            end
        end
        function directionality_type = getDirectionalityType(varargin)
            % GETDIRECTIONALITYTYPE returns the directionality type of the graph
            %
            % DIRECTIONALITY_TYPE = GETDIRECTIONALITYTYPE() returns
            % Graph.DIRECTED.
            %
            % DIRECTIONALITY_TYPE = GETDIRECTIONALITYTYPE(LAYERNUMBER) returns 
            % a matrix with Graph.UNDIRECTED for all the elements.
            % For example, for a 3x3 matrix it returns:
            % DIRECTIONALITY_TYPE = UNDIRECTED  DIRECTED    DIRECTED
            %                       DIRECTED    UNDIRECTED  DIRECTED  
            %                       DIRECTED    DIRECTED    UNDIRECTED  
            % where UNDIRECTED = Graph.UNDIRECTED and DIRECTED = Graph.DIRECTED.
            %
            % See also Graph, getConnectivityType, getGraphType, getNegativityType, getSelfConnectivityType.
         
            if isempty(varargin)
                directionality_type = Graph.DIRECTED;
            else
                layernumber = varargin{1};             
                directionality_type = Graph.DIRECTED * ones(layernumber);
                directionality_type(1:layernumber+1:end) = Graph.UNDIRECTED;
            end            
        end
        function selfconnectivity_type = getSelfConnectivityType(varargin)
            % GETSELFCONNECTIVITYTYPE returns the self-connectivity type of the graph
            %
            % SELFCONNECTIVITY_TYPE = GETSELFCONNECTIVITYTYPE() returns
            % Graph.SELFCONNECTED.
            %
            % SELFCONNECTIVITY_TYPE = GETSELFCONNECTIVITYTYPE(LAYERNUMBER) returns 
            % a matrix with Graph.NONSELFCONNECTED for the diagonal elements and
            % Graph.SELFCONNECTED for the off-diagonal elements.
            % For example, for a 3x3 matrix it returns:
            % SELFCONNECTIVITY_TYPE = NONSELFCONNECTED  SELFCONNECTED     SELFCONNECTED
            %                         SELFCONNECTED     NONSELFCONNECTED  SELFCONNECTED  
            %                         SELFCONNECTED     SELFCONNECTED     NONSELFCONNECTED  
            % where SELFCONNECTED = Graph.SELFCONNECTED and NONSELFCONNECTED = Graph.NONSELFCONNECTED.
            %
            % See also Graph, getConnectivityType, getDirectionalityType, getGraphType, getNegativityType.
         
            if isempty(varargin)
                selfconnectivity_type = Graph.SELFCONNECTED;
            else
                layernumber = varargin{1};             
                selfconnectivity_type = Graph.SELFCONNECTED * ones(layernumber);
                selfconnectivity_type(1:layernumber+1:end) = Graph.NONSELFCONNECTED;                
            end
        end
        function negativity_type = getNegativityType(varargin)
            % GETNEGATIVITYTYPE returns the negativity type of the graph
            %
            % NEGATIVITY_TYPE  = GETNEGATIVITYTYPE() returns Graph.NONNEGATIVE.
            %
            % NEGATIVITY_TYPE = GETNEGATIVITYTYPE(LAYERNUMBER) returns 
            % a matrix with Graph.NONNEGATIVE for all the elements.
            % For example, for a 3x3 matrix it returns:
            % NEGATIVITY_TYPE = NONNEGATIVE  NONNEGATIVE  NONNEGATIVE
            %                   NONNEGATIVE  NONNEGATIVE  NONNEGATIVE
            %                   NONNEGATIVE  NONNEGATIVE  NONNEGATIVE  
            % where NONNEGATIVE = Graph.NONNEGATIVE.
            %
            % See also Graph, getConnectivityType, getDirectionalityType, getGraphType, getSelfConnectivityType.
            
            if isempty(varargin)
                negativity_type = Graph.NONNEGATIVE;
            else
                layernumber = varargin{1};
                negativity_type =  Graph.NONNEGATIVE * ones(layernumber);
            end
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
%     methods
%         function [randomized_graph, swaps] = randomize_graph(g, varargin)
%              % get rules
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
%             [I_edges, J_edges] = find(triu(A)); % find the edges
%             E = length(I_edges); % number of edges
%             
%             randomized_graph = A;
%             swaps = 0; % number of successful edge swaps
%             for attempt=1:1:attempts_per_edge*E
%                 
%                 % select two edges
%                 selected_edges = randperm(E,2);
%                 node_start_1 = I_edges(selected_edges(1));
%                 node_end_1 = J_edges(selected_edges(1));
%                 node_start_2 = I_edges(selected_edges(2));
%                 node_end_2 = J_edges(selected_edges(2));
%                 
%                 if rand(1) > 0.5
%                     I_edges(selected_edges(2)) = node_end_2;
%                     J_edges(selected_edges(2)) = node_start_2;
%                     
%                     node_start_2 = I_edges(selected_edges(2));
%                     node_end_2 = J_edges(selected_edges(2));
%                 end
%                 
%                 % Swap edges if:
%                 % 1) no edge between node_start_1 and node_end_2
%                 % 2) no edge between node_start_2 and node_end_1
%                 % 3) node_start_1 ~= node_start_2
%                 % 4) node_end_1 ~= node_end_2
%                 % 5) node_start_1 ~= node_end_2
%                 % 6) node_start_2 ~= node_end_1
%                 
%                 if ~randomized_graph(node_start_1, node_end_2) && ...
%                         ~randomized_graph(node_start_2, node_end_1) && ...
%                         node_start_1~=node_start_2 && ...
%                         node_end_1~=node_end_2 && ...
%                         node_start_1~=node_end_2 && ...
%                         node_start_2~=node_end_1
%                     
%                     % erase old edges
%                     randomized_graph(node_start_1, node_end_1) = 0;
%                     randomized_graph(node_end_1, node_start_1) = 0;
%                     
%                     randomized_graph(node_start_2, node_end_2) = 0;
%                     randomized_graph(node_end_2, node_start_2) = 0;
%                     
%                     % write new edges
%                     randomized_graph(node_start_1, node_end_2) = 1;
%                     randomized_graph(node_end_2, node_start_1) = 1;
%                     
%                     randomized_graph(node_start_2, node_end_1) = 1;
%                     randomized_graph(node_end_1, node_start_2) = 1;
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