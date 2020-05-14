classdef MultiplexGraphWD < Graph
    % MultiplexGraphWD < Graph: A multiplex weighted directed graph
    % MultiplexGraphWD represents a multiplex weighted directed graph.
    %
    % MultiplexGraphWD methods:
    %   MultiplexGraphWD     - constructor.
    %
    % MultiplexGraphWD methods (static):
    %   getClass    - return the class type MultiplexGraphWD.
    %   getName     - return the complete name of MultiplexGraphWD.
    %   getDescription - return the description of MultiplexGraphWD.
    %   is_selfconnected - boolean, checks if the graph is self-connected.
    %   is_nonnegative - boolean, checks if the graph is non-negative.
    %   is_weighted - boolean, checks if the graph is weighted.
    %   is_binary   - boolean, checks if the graph is binary.
    %   is_directed - boolean, checks if the graph is directed.
    %   is_undirected - boolean, checks if the graph is undirected.
    %   getCompatibleMeasureList - returns a list with compatible measures.
    %   getCompatibleMeasureNumber - returns the number of compatible measures.
    %
    % See also Graph, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU.
    
    methods
        function g = MultiplexGraphWD(A, varargin)
            % MULTIPLEXGRAPHWD(A) creates a MULTIPLEXGRAPHWD class with adjacency matrix A.
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % functions: DEDIAGONALIZE, SEMIPOSITIVE, STANDARDIZE.
            % It calls the superclass constructor GRAPH.
            %
            % MULTIPLEXGRAPHWD(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...) creates
            % a MULTIPLEXGRAPHWD class with adjacency matrix A and it passes the
            % properties and values to the superclass as VARARGIN.
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % functions: DEDIAGONALIZE, SEMIPOSITIVE, STANDARDIZE.
            % It calls the superclass constructor GRAPH.
            %
            % See also Graph, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU.

            L = length(A);  % number of layers
            for layer = 1:1:L
                M = A{layer, layer};
                M = dediagonalize(M, varargin{:});  % removes self-connections by removing diagonal from adjacency matrix
                M = semipositivize(M, varargin{:});  % removes negative weights
                M = standardize(M, varargin{:});  % ensures all weights are between 0 and 1
                A(layer, layer) = {M};
            end
            % enforce zero off-diagonal values and binary diagonal values
            for i = 1:1:size(A, 1)
                for j = i+1:1:size(A, 2)
                    A(i, j) = {diagonalize(A{i, j}, varargin{:})};
                    A(j, i) = {diagonalize(A{j, i}, varargin{:})};
                    A(i, j) = {semipositivize(A{i, j}, varargin{:})};
                    A(j, i) = {semipositivize(A{j, i}, varargin{:})};
                    A(i, j) = {standardize(A{i, j}, varargin{:})};
                    A(j, i) = {standardize(A{j, i}, varargin{:})};
                end
            end
            
            g = g@Graph(A, varargin{:});
        end
    end
    methods (Static)  % Descriptive methods
        function graph_class = getClass()
            % GETCLASS returns the class of the graph.
            %
            % GRAPH_CLASS = GETCLASS() returns the class, 'GraphWD'.
            %
            % See also getName().
            
            graph_class = 'MultiplexGraphWD';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % NAME = GETCLASS() returns the name, 'Weighted Directed Graph'.
            %
            % See also getClass().
            
            name = 'Multiplex Weighted Directed Graph';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of GRAPHWD.
            %
            % See also getName()
            
            description = [ ...
                'In a weighted directed (WD) graph, ' ...
                'the edges are associated with a real number between 0 and 1' ...
                'indicating the strength of the connection, ' ...
                'and they are directed.' ...
                ];
        end
        function graph_type = getGraphType()
            graph_type = Graph.MULTIPLEX;
        end
        function graph_type = getConnectionType()
            graph_type = Graph.WEIGHTED;
        end
        function graph_type = getEdgeType()
            graph_type = Graph.DIRECTED;
        end
        function selfconnectivity_type = getSelfConnectivityType()
            selfconnectivity_type = Graph.NOT_SELFCONNECTED;  % True in cell diagonal matrices  
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
%         function g = GraphWD(A, varargin)
%             % GRAPHWD(A) creates a GRAPHWD class with adjacency matrix A.
%             % This function is the constructor, it initializes the class by
%             % operating the adjacency matrix A with the following
%             % functions: DEDIAGONALIZE, SEMIPOSITIVE, STANDARDIZE.
%             % It calls the superclass constructor GRAPH.
%             %
%             % GRAPHWD(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...) creates
%             % a GRAPHWD class with adjacency matrix A and it passes the
%             % properties and values to the superclass as VARARGIN.
%             % This function is the constructor, it initializes the class by
%             % operating the adjacency matrix A with the following
%             % functions: DEDIAGONALIZE, SEMIPOSITIVE, STANDARDIZE.
%             % It calls the superclass constructor GRAPH.
%             %
%             % See also Graph, GraphBU, GraphBD, GraphWU.
%             
%             A = dediagonalize(A, varargin{:});  % removes self-connections by removing diagonal from adjacency matrix
%             A = semipositivize(A, varargin{:});  % removes negative weights
%             A = standardize(A, varargin{:});  % ensures all weights are between 0 and 1
%             
%             g = g@Graph(A, varargin{:});
%         end
%     end
%     methods
%         function [randomized_graph, correlation_coefficents] = randomize_graph(g, varargin)
%             % get rules
%             number_of_weights = get_from_varargin(10, 'NumberOfWeights', varargin{:});
%             
%             W = g.getA();
%             graph_BD = GraphBD(W);
%             [A, ~] = graph_BD.randomize_graph(varargin{:});
%             % remove self connections
%             A(1:length(A)+1:numel(A)) = 0;
%             W(1:length(W)+1:numel(W)) = 0;
%             W_bin = W > 0;
%             N = size(A,1); % number of nodes
%             randomized_graph = zeros(N); % initialize null model matrix
%             
%             S_in = sum(W,1).'; % nodal in-strength
%             S_out = sum(W,2);  % nodal out-strength
%             W_sorted = sort(W(W_bin)); % sorted weights vector
%             % find all the edges
%             [I_edges, J_edges] = find(A);
%             edges = I_edges + (J_edges-1)*N;
%             % expected weights matrix
%             P = (S_out*S_in.');
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
%                 WAi = accumarray(I_edges(selected_edges), W_sorted(selected_indices), [N,1]);
%                 Iu = any(WAi,2);
%                 % readjust expected weight probabilities
%                 F = 1 - WAi(Iu)./S_out(Iu);
%                 P(Iu,:) = P(Iu,:).*F(:,ones(1,N));
%                 % readjust in-strength
%                 S_out(Iu) = S_out(Iu) - WAi(Iu);
%                 
%                 % recalculate expected weight for node J_edges(selected_edge)
%                 WAj = accumarray(J_edges(selected_edges), W_sorted(selected_indices), [N,1]);
%                 Ju = any(WAj,2);
%                 % readjust expected weight probabilities
%                 F = 1 - WAj(Ju)./S_in(Ju);
%                 P(:,Ju) = P(:,Ju).*F(:,ones(1,N)).';
%                 % readjust out-strength
%                 S_in(Ju) = S_in(Ju) - WAj(Ju);
%                 
%                 % remove the edge/weight from further consideration
%                 selected_edges = ind(selected_indices);
%                 edges(selected_edges) = [];
%                 I_edges(selected_edges) = [];
%                 J_edges(selected_edges) = [];
%                 W_sorted(selected_indices) = [];
%             end
%             
%             % calculate correlation of original vs reassinged in/out strength
%             rpos_in = corrcoef(sum(W,1), sum(randomized_graph,1));
%             rpos_out = corrcoef(sum(W,2), sum(randomized_graph,2));
%             correlation_coefficents = [rpos_in(2) rpos_out(2)];
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
%             list = Graph.getCompatibleMeasureList('GraphWD');
%         end
%         function n = getCompatibleMeasureNumber()
%             % GETCOMPATIBLEMEASURENUMBER returns a number of the compatible measures.
%             %
%             % N = GETCOMPATIBLEMEASURENUMBER() returns the number of
%             % compatible measures to the graph.
%             %
%             % See also getCompatibleMeasureList().
%             
%             n = Graph.getCompatibleMeasureNumber('GraphWD');
%         end
%     end
end
