classdef MultiplexGraphBD < Graph
    % MultiplexGraphBD A Multiplex binary directed graph
    % MultiplexGraphBD represents a multiplex binary directed graph.
    %    
    % MultiplexGraphBD consists of a multiplex with binary directed graphs.   
    %       
    % MultiplexGraphBD methods:
    %   MultiplexGraphBD        - constructor
    %
    % MultiplexGraphBD descriptive methods (static):
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
    % See also Graph, MultiplexGraphBU, MultiplexGraphWD, MultiplexGraphWU.
    
    methods
        function g = MultiplexGraphBD(A, varargin)
            % MULTIPLEXGRAPHBD(A) creates a MULTIPLEXGRAPHBD class with adjacency matrix A.
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % functions: DEDIAGONALIZE, SEMIPOSITIVE, BINARIZE.
            % It calls the superclass constructor GRAPH.
            %
            % MULTIPLEXGRAPHBD(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...) creates
            % a MULTIPLEXGRAPHBD class with adjacency matrix A and it passes the
            % properties and values to the superclass as VARARGIN.
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % functions: DEDIAGONALIZE, SEMIPOSITIVE, BINARIZE.
            % It calls the superclass constructor GRAPH.
            %
            % See also Graph, MultiplexGraphBU, MultiplexGraphWD, MultiplexGraphWU.
            
            if isempty(A)
                A = {
                    round(rand(4))            round(diag(rand(4, 1)))   round(diag(rand(4, 1)))	
                    round(diag(rand(4, 1)))   round(rand(4))            round(diag(rand(4, 1)))	
                    round(diag(rand(4, 1)))   round(diag(rand(4, 1)))   round(rand(4))      
                    };
            end 
            
            L = length(A);  % number of layers
            for layer = 1:1:L
                M = A{layer, layer};
                M = dediagonalize(M, varargin{:});  % removes self-connections by removing diagonal from adjacency matrix
                M = semipositivize(M, varargin{:});  % removes negative weights
                M = binarize(M, varargin{:});  % enforces binary adjacency matrix
                A(layer, layer) = {M};
            end
            % enforce zero off-diagonal values and binary diagonal values
            for i = 1:1:size(A, 1)
                for j = i+1:1:size(A, 2)
                    A(i, j) = {diagonalize(A{i, j}, varargin{:})};
                    A(j, i) = {diagonalize(A{j, i}, varargin{:})};
                    A(i, j) = {semipositivize(A{i, j}, varargin{:})};
                    A(j, i) = {semipositivize(A{j, i}, varargin{:})};
                    A(i, j) = {binarize(A{i, j}, varargin{:})};
                    A(j, i) = {binarize(A{j, i}, varargin{:})};
                end
            end
            
            g = g@Graph(A, varargin{:});
        end
    end
    methods (Static)  % Descriptive methods
        function graph_class = getClass()
            % GETCLASS returns the class of the graph.
            %
            % GRAPH_CLASS = GETCLASS() returns the class, 'MultiplexGraphBD'.
            %
            % See also getName, getDescription.
            
            graph_class = 'MultiplexGraphBD';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % NAME = GETCLASS() returns the name, 'Multiplex Binary Directed Graph'.
            %
            % See also getClass, getDescription.
            
            name = 'Multiplex Binary Directed Graph';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of MULTIPLEXGRAPHBD.
            %
            % See also getClass, getName.
            
            description = [ ...
                'In a multiplex binary directed graph, ' ...
                'all the layers and connections between layers consist' ...
                'of binary directed (BD) graphs.' ...
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
            % a matrix with Graph.DIRECTED for all the elements.
            % For example, for a 3x3 matrix it returns:
            % DIRECTIONALITY_TYPE = DIRECTED  DIRECTED  DIRECTED
            %                       DIRECTED  DIRECTED  DIRECTED  
            %                       DIRECTED  DIRECTED  DIRECTED  
            % where DIRECTED = Graph.DIRECTED.
            %
            % See also Graph, getConnectivityType, getGraphType, getNegativityType, getSelfConnectivityType.
         
            if isempty(varargin)
                directionality_type = Graph.DIRECTED;
            else
                layernumber = varargin{1};             
                directionality_type = Graph.DIRECTED * ones(layernumber);
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
        function available_settings = getAvailableSettings(g)  %#ok<INUSD>
            % GETAVAILABLESETTINGS returns the available rules of graph
            %
            % GETAVAILABLESETTINGS(G) returns an array with the available
            % settings for the graph. 
            %
            % See also getClass, getName, getDescription, getGraphType.
            
            available_settings = { ...
                'MultiplexGraphBD.AttemptsPerEdge', BRAPH2.NUMERIC, 5, {} ...
                };
        end
    end
    methods
        function [randomized_graph, swaps] = randomize(g, varargin)
            % RANDOMIZE returns a randomized graph and the number of swaps.
            %
            % RANDOMIZED_GRAPH, SWAPS = RANDOMIZE() returns the randomized 
            % graph RANDOMIZED_GRAPH obtained from a number of edge swaps SWAPS.
            % The randomization it is done layer by layer and then
            % integrated in the 2-D supra-adjacency matrix cell array.
            %
            % RANDOMIZED_GRAPH, SWAPS = RANDOMIZE(G, 'PROPERTYRULE1', 'VALUE1', ...) 
            % returns the randomized graph RANDOMIZED_GRAPH obtained from a
            % number of edge swaps SWAPS. The randomization it is done layer 
            % by layer and then integrated in the 2-D supra-adjacency matrix cell array.
            
            % get rules
            attempts_per_edge = get_from_varargin(10, 'AttemptsPerEdge', varargin{:});
            
            if nargin<2
                attempts_per_edge = 5;
            end
            
            % get A
            A = g.getA();
            L = g.layernumber();
            swaps = zeros(1, L); % number of successful edge swaps
            randomized_graph = A;
            
            for li = 1:1:L
                Aii = A{li, li};   
                % remove self connections
                Aii(1:length(Aii)+1:numel(Aii)) = 0;
                [I_edges, J_edges] = find(Aii); % find all the edges
                E = length(I_edges); % number of edges
 
                randomized_graph_layer = Aii;
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
                    if ~randomized_graph_layer(node_start_1, node_end_2) && ...
                            ~randomized_graph_layer(node_start_2, node_end_1) && ...
                            node_start_1~=node_start_2 && ...
                            node_end_1~=node_end_2 && ...
                            node_start_1~=node_end_2 && ...
                            node_start_2~=node_end_1

                        % erase old edges
                        randomized_graph_layer(node_start_1, node_end_1) = 0;
                        randomized_graph_layer(node_start_2, node_end_2) = 0;

                        % write new edges
                        randomized_graph_layer(node_start_1, node_end_2) = 1;
                        randomized_graph_layer(node_start_2, node_end_1) = 1;

                        % update edge list
                        J_edges(selected_edges(1)) = node_end_2;
                        J_edges(selected_edges(2)) = node_end_1;

                        swaps(L) = swaps(L)+1;
                    end
                end
                randomized_graph(li, li) = {randomized_graph_layer};
            end
        end
    end

%     methods
%         function g = GraphBD(A, varargin)
%             % GRAPHBD(A) creates a GRAPHBD class with adjacency matrix A.
%             % This function is the constructor, it initializes the class by
%             % operating the adjacency matrix A with the following
%             % functions: DEDIAGONALIZE, SEMIPOSITIVE, BINARIZE.
%             % It calls the super class constructor GRAPH.
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
