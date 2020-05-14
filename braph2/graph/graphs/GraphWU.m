classdef GraphWU < GraphWD
    % GraphWU < GraphWD: A weighted undirected graph
    % GraphWU represents a weighted undirected graph.
    %
    % GraphWU methods:
    %   GraphWU     - constructor.
    %
    % GraphWU methods (static):
    %   getClass    - return the class type GraphWU.
    %   getName     - return the complete name of GraphWU.
    %   getDescription - return the description of GraphWU.
    %   is_selfconnected - boolean, checks if the graph is self-connected.
    %   is_nonnegative - boolean, checks if the graph is non-negative.
    %   is_weighted - boolean, checks if the graph is weighted.
    %   is_binary   - boolean, checks if the graph is binary.
    %   is_directed - boolean, checks if the graph is directed.
    %   is_undirected - boolean, checks if the graph is undirected.
    %   getCompatibleMeasureList - returns a list with compatible measures.
    %   getCompatibleMeasureNumber - returns the number of compatible measures.
    %
    % See also Graph, GraphBD, GraphWU, GraphWD.
    
    methods
        function g = GraphWU(A, varargin)
            % GRAPHWU(A) creates a GRAPHWU class with adjacency matrix A.
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % function: SYMMETRIZE.
            % It calls the superclass constructor GRAPHWD.
            %
            % GRAPHWU(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...) creates
            % a GRAPHWU class with adjacency matrix A and it passes the
            % properties and values to the superclass as VARARGIN.
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % function: SYMMETRIZE.
            % It calls the superclass constructor GRAPHWD.
            %
            % See also Graph, GraphBD, GraphWD, GraphBU.
            
            A = symmetrize(A, varargin{:});  % enforces symmetry of adjacency matrix
            
            g = g@GraphWD(A, varargin{:});
        end
    end
    methods (Static)  % Descriptive methods
        function graph_class = getClass()
            % GETCLASS returns the class of the graph.
            %
            % GRAPH_CLASS = GETCLASS() returns the class, 'GraphWU'.
            %
            % See also getName().
            
            graph_class = 'GraphWU';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % NAME = GETCLASS() returns the name, 'Weighted Undirected Graph'.
            %
            % See also getClass()
            
            name = 'Weighted Undirected Graph';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of GRAPHWU.
            %
            % See also getName().
            
            description = [ ...
                'In a weighted undirected (WU) graph, ' ...
                'the edges are associated with a real number between 0 and 1 ' ...
                'indicating the strength of the connection, ' ...
                'and they are undirected.' ...
                'The connectivity matrix is symmetric.' ...
                ];
        end
        function graph_type = getGraphType()
            graph_type = Graph.GRAPH;
        end
        function graph_type = getConnectionType()
            graph_type = Graph.WEIGHTED;
        end
        function graph_type = getEdgeType()
            graph_type = Graph.UNDIRECTED;
        end
        function selfconnectivity_type = getSelfConnectivityType()
            selfconnectivity_type = Graph.NOT_SELFCONNECTED;
        end
        function negativity_type = getNegativityType()
            % GETNEGATIVITYTYPE checks if the graph is non-negative or negative
            %
            % BOOL = GETNEGATIVITYTYPE() returns NONNEGATIVE for GRAPHBD.
            %
            % See also getConnectionType(), getEdgeType(), getGraphType() and getSelfConnectivityType().
            
            negativity_type = Graph.NONNEGATIVE;
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