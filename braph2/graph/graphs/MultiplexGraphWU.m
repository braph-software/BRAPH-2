classdef MultiplexGraphWU < MultiplexGraphWD
    % MultiplexGraphWU A multiplex weighted undirected graph
    % MultiplexGraphWU represents a multiplex weighted undirected graph.
    %
    % MultiplexGraphWU consists of a multiplex where the layers are weighted 
    % undirected graphs and the connections are weighted directed graphs.
    %
    % MultiplexGraphWU methods:
    %   MultiplexGraphWU     - constructor
    %
    % MultiplexGraphWU descriptive methods (static):
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
    % See also Graph, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD.
    
    methods
        function g = MultiplexGraphWU(A, varargin)
            % MULTIPLEXGRAPHWU(A) creates a MULTIPLEXGRAPHWU class with adjacency matrix A.
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % function: SYMMETRIZE.
            % It calls the superclass constructor MULTIPLEXGRAPHWD.
            %
            % MULTIPLEXGRAPHWU(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...) creates
            % a MULTIPLEXGRAPHWU class with adjacency matrix A and it passes the
            % properties and values to the superclass as VARARGIN.
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % function: SYMMETRIZE.
            % It calls the superclass constructor MULTIPLEXGRAPHWD.
            %
            % See also Graph, MultiplexGraphBD, MultiplexGraphWD, MultiplexGraphBU.
            
            if isempty(A)
                A = {
                    symmetrize(rand(4))  diag(rand(4, 1))     diag(rand(4, 1))
                    diag(rand(4, 1))     symmetrize(rand(4))  diag(rand(4, 1))
                    diag(rand(4, 1))     diag(rand(4, 1))     symmetrize(rand(4))
                    };
            end
            
            L = length(A);  % number of layers
            for layer = 1:1:L
                M = A{layer, layer};
                M = symmetrize(M, varargin{:});  % enforces symmetry of adjacency matrix
                A(layer, layer) = {M};
            end
            
            g = g@MultiplexGraphWD(A, varargin{:});
        end
    end
    methods (Static)  % Descriptive methods
        function graph_class = getClass()
            % GETCLASS returns the class of the graph.
            %
            % GRAPH_CLASS = GETCLASS() returns the class, 'MultiplexGraphWU'.
            %
            % See also getName, getDescription.
            
            graph_class = 'MultiplexGraphWU';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % NAME = GETCLASS() returns the name, 'Multiplex Weighted Undirected Graph'.
            %
            % See also getClass, getDescription.
            
            name = 'Multiplex Weighted Undirected Graph';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of MULTIPLEXGRAPHWU.
            %
            % See also getClass, getName.
            
            description = [ ...
                'In a multiplex weighted undirected graph, ' ...
                'all the layers consist of weighted undirected (WU)' ...
                'graphs and the connections between layers consist ' ...
                'of weighted directed (WD).' ...
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
            % Graph.WEIGHTED.
            %
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE(LAYERNUMBER) returns 
            % a matrix with Graph.WEIGHTED for all the elements.
            % For example, for a 3x3 matrix it returns:
            % CONNECTIVITY_TYPE = WEIGHTED  WEIGHTED  WEIGHTED
            %                     WEIGHTED  WEIGHTED  WEIGHTED  
            %                     WEIGHTED  WEIGHTED  WEIGHTED  
            % where WEIGHTED = Graph.WEIGHTED.
            %
            % See also Graph, getDirectionalityType, getGraphType, getNegativityType, getSelfConnectivityType.
         
            if isempty(varargin)
                connectivity_type = Graph.WEIGHTED;
            else
                layernumber = varargin{1};             
                connectivity_type = Graph.WEIGHTED * ones(layernumber);
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
%         function g = GraphWU(A, varargin)
%             % GRAPHWU(A) creates a GRAPHWU class with adjacency matrix A.
%             % This function is the constructor, it initializes the class by
%             % operating the adjacency matrix A with the following
%             % function: SYMMETRIZE.
%             % It calls the superclass constructor GRAPHWD.
%             %
%             % GRAPHWU(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...) creates
%             % a GRAPHWU class with adjacency matrix A and it passes the
%             % properties and values to the superclass as VARARGIN.
%             % This function is the constructor, it initializes the class by
%             % operating the adjacency matrix A with the following
%             % function: SYMMETRIZE.
%             % It calls the superclass constructor GRAPHWD.
%             %
%             % See also Graph, GraphBD, GraphWD, GraphBU.
%             
%             A = symmetrize(A, varargin{:});  % enforces symmetry of adjacency matrix
%             
%             g = g@GraphWD(A, varargin{:});
%         end
%     end
%     methods
%         function [randomized_graph, correlation_coefficients] = randomize_graph(g, varargin)           
%             % get rules
%             number_of_weights = get_from_varargin(10, 'NumberOfWeights', varargin{:});
%             
%             W = g.getA();
%             graph_BU = GraphBU(W);
%             [A, ~] = graph_BU.randomize_graph(varargin{:});
%              
%             % remove self connections
%             A(1:length(A)+1:numel(A)) = 0;
%             W(1:length(W)+1:numel(W)) = 0;
%             W_bin = W > 0;
%             N = size(A,1); % number of nodes
%             randomized_graph = zeros(N); % intialize null model matrix
%             
%             S = sum(W,2); % nodal strength
%             W_sorted = sort(W(triu(W_bin))); % sorted weights vector
%             % find all the edges
%             [I_edges, J_edges] = find(triu(A));
%             edges = I_edges + (J_edges-1)*N;
%             % expected weights matrix
%             P = (S*S.');
%             
%             for m = numel(W_sorted):-number_of_weights:1
%                 
%                 % sort the expected weights matrix
%                 [~, ind] = sort(P(edges));
%                 
%                 % random index of sorted expected weight
%                 selected_indices = randperm(m, min(m,number_of_weights)).';
%                 selected_edges = ind(selected_indices);
%                 
%                 % assign corresponding sorted weight at this index
%                 randomized_graph(edges(selected_edges)) = W_sorted(selected_indices);
%                 
%                 % recalculate expected weight for node I_edges(selected_edge)
%                 % cumulative weight
%                 WA = accumarray([I_edges(selected_edges); J_edges(selected_edges)], W_sorted([selected_indices; selected_indices]), [N,1]);
%                 IJu = any(WA,2);
%                 F = 1 - WA(IJu)./S(IJu);
%                 F = F(:,ones(1,N));
%                 % readjust expected weight probabilities
%                 P(IJu,:) = P(IJu,:).*F;
%                 P(:,IJu) = P(:,IJu).*F.';
%                 % re-adjust strengths
%                 S(IJu) = S(IJu) - WA(IJu);
%                 
%                 % remove the edge/weight from further consideration
%                 selected_edges = ind(selected_indices);
%                 edges(selected_edges) = [];
%                 I_edges(selected_edges) = [];
%                 J_edges(selected_edges) = [];
%                 W_sorted(selected_indices) = [];
%             end
%             
%             % calculate the final matrix
%             randomized_graph = randomized_graph + transpose(randomized_graph);
%             
%             % calculate correlation of original vs reassinged strength
%             rpos = corrcoef(sum(W), sum(randomized_graph));
%             correlation_coefficients = rpos(2);
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
%             list = Graph.getCompatibleMeasureList('GraphWU');
%         end
%         function n = getCompatibleMeasureNumber()
%             % GETCOMPATIBLEMEASURENUMBER returns a number of the compatible measures.
%             %
%             % N = GETCOMPATIBLEMEASURENUMBER() returns the number of
%             % compatible measures to the graph.
%             %
%             % See also getCompatibleMeasureList().
%             
%             n = Graph.getCompatibleMeasureNumber('GraphWU');
%         end
%     end
end