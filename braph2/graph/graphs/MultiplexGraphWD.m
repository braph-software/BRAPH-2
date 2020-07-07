classdef MultiplexGraphWD < Graph
    % MultiplexGraphWD A multiplex weighted directed graph
    % MultiplexGraphWD represents a multiplex weighted directed graph.
    %
    % MultiplexGraphWD consists of a multiplex with weighted directed graphs.  
    %
    % MultiplexGraphWD methods:
    %   MultiplexGraphWD        - constructor
    %
    % MultiplexGraphWD descriptive methods (static):
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

            if isempty(A)
                A = {
                    rand(4)            diag(rand(4, 1))   diag(rand(4, 1))
                    diag(rand(4, 1))   rand(4)            diag(rand(4, 1))
                    diag(rand(4, 1))   diag(rand(4, 1))   rand(4)
                    };
            end
            
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
            % GRAPH_CLASS = GETCLASS() returns the class, 'MultiplexGraphWD'.
            %
            % See also getName, getDescription.
            
            graph_class = 'MultiplexGraphWD';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % NAME = GETCLASS() returns the name, 'Multiplex Weighted Directed Graph'.
            %
            % See also getClass, getDescription.
            
            name = 'Multiplex Weighted Directed Graph';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of MULTIPLEXGRAPHWD.
            %
            % See also getClass, getName.
            
            description = [ ...
                'In a multiplex weighted directed graph, ' ...
                'all the layers and connections between layers consist' ...
                'of weighted directed (WD) graphs.' ...
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
                'MultiplexGraphWD.NumberOfWeights', BRAPH2.NUMERIC, 5, {} ...
                };
        end
    end
    methods
        function [randomized_graph, correlation_coefficients] = randomize(g, varargin)
            % RANDOMIZE returns a randomized graph and the correlation coefficients
            %
            % RANDOMIZED_GRAPH, CORRELATION_COEFFICIENTS = RANDOMIZE(G) 
            % returns the randomized graph RANDOMIZED_GRAPH and the strength
            % correlation coefficients from the graph G and the randomized.
            % The randomization it is done layer by layer and then
            % integrated in the 2-D supra-adjacency matrix cell array.
            %
            % RANDOMIZED_GRAPH, CORRELATION_COEFFICIENTS = RANDOMIZE(G, 'MultiplexGraphWD.NumberOfWeights', 'NUMBER') 
            % returns the randomized graph RANDOMIZED_GRAPH and the strength
            % correlation coefficients from the graph G and the randomized.
            % The randomization is performed with the specified number of
            % weights NUMBER. The multiplex is randomized layer by layer 
            % where randomized adjacency matrix of each layer are then  
            % integrated in the 2-D supra-adjacency matrix cell array.
            
            % get rules
            number_of_weights = get_from_varargin(10, 'NumberOfWeights', varargin{:});
            
            W = g.getA();            
            multiplex_graph_BD = MultiplexGraphBD(W);
            [A, ~] = multiplex_graph_BD.randomize_graph(varargin{:});
            L = g.layernumber();
            correlation_coefficients = cell(L, 1);
            randomized_graph = A;
            
            for li = 1:1:L
                Aii = A{li, li};
                Wii = W{li, li};       
                % remove self connections
                Aii(1:length(Aii)+1:numel(Aii)) = 0;
                Wii(1:length(Wii)+1:numel(Wii)) = 0;
                W_bin = Wii > 0;
                N = size(Aii, 1);  % number of nodes
                randomized_graph_layer = zeros(N);  % initialize null model matrix
                S_in = sum(Wii, 1).';  % nodal in-strength
                S_out = sum(Wii, 2);  % nodal out-strength
                W_sorted = sort(Wii(W_bin));  % sorted weights vector
                % find all the edges
                [I_edges, J_edges] = find(Aii);
                edges = I_edges + (J_edges - 1)*N;
                % expected weights matrix
                P = (S_out*S_in.');

                for m = numel(W_sorted):-number_of_weights:1

                    % sort the expected weights matrix
                    [~, ind] = sort(P(edges));

                    % random index of sorted expected weight
                    selected_indices = randperm(m, min(m,number_of_weights)).';
                    selected_edges = ind(selected_indices);

                    % assign corresponding sorted weight at this index
                    randomized_graph_layer(edges(selected_edges)) = W_sorted(selected_indices);

                    % recalculate expected weight for node I_edges(selected_edge)
                    WAi = accumarray(I_edges(selected_edges), W_sorted(selected_indices), [N, 1]);
                    Iu = any(WAi, 2);
                    % readjust expected weight probabilities
                    F = 1 - WAi(Iu)./S_out(Iu);
                    P(Iu, :) = P(Iu, :).*F(:, ones(1, N));
                    % readjust in-strength
                    S_out(Iu) = S_out(Iu) - WAi(Iu);

                    % recalculate expected weight for node J_edges(selected_edge)
                    WAj = accumarray(J_edges(selected_edges), W_sorted(selected_indices), [N, 1]);
                    Ju = any(WAj, 2);
                    % readjust expected weight probabilities
                    F = 1 - WAj(Ju)./S_in(Ju);
                    P(:, Ju) = P(:, Ju).*F(:, ones(1, N)).';
                    % readjust out-strength
                    S_in(Ju) = S_in(Ju) - WAj(Ju);

                    % remove the edge/weight from further consideration
                    selected_edges = ind(selected_indices);
                    edges(selected_edges) = [];
                    I_edges(selected_edges) = [];
                    J_edges(selected_edges) = [];
                    W_sorted(selected_indices) = [];
                end

                % calculate correlation of original vs reassinged in/out strength
                rpos_in = corrcoef(sum(Wii, 1), sum(randomized_graph_layer, 1));
                rpos_out = corrcoef(sum(Wii, 2), sum(randomized_graph_layer, 2));
                correlation_coefficients(li) = {[rpos_in(2) rpos_out(2)]};
                randomized_graph(li, li) = {randomized_graph_layer};
            end
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
