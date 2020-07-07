classdef GraphWD < Graph
    % GraphWD A weighted directed graph
    % GraphWD represents a weighted directed graph.
    %
    % GraphWD consists of a weighted directed graph.
    %
    % GraphWD methods:
    %   GraphWD                 - constructor
    %
    % GraphWD descriptive methods (static):
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
    % See also Graph, GraphBU, GraphBD, GraphWU.
    
    methods
        function g = GraphWD(A, varargin)
            % GRAPHWD(A) creates a GRAPHWD class with adjacency matrix A.
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % functions: DEDIAGONALIZE, SEMIPOSITIVE, STANDARDIZE.
            % It calls the superclass constructor GRAPH.
            %
            % GRAPHWD(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...) creates
            % a GRAPHWD class with adjacency matrix A and it passes the
            % properties and values to the superclass as VARARGIN.
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % functions: DEDIAGONALIZE, SEMIPOSITIVE, STANDARDIZE.
            % It calls the superclass constructor GRAPH.
            %
            % See also Graph, DummyGraph, GraphBU, GraphBD, GraphWU.
            
            A = dediagonalize(A, varargin{:});  % removes self-connections by removing diagonal from adjacency matrix
            A = semipositivize(A, varargin{:});  % removes negative weights
            A = standardize(A, varargin{:});  % ensures all weights are between 0 and 1
            
            g = g@Graph(A, varargin{:});
        end
    end
    methods (Static)  % Descriptive methods
        function graph_class = getClass()
            % GETCLASS returns the class of the graph.
            %
            % GRAPH_CLASS = GETCLASS() returns the class, 'GraphWD'.
            %
            % See also getName, getDescription.
            
            graph_class = 'GraphWD';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % NAME = GETCLASS() returns the name, 'Weighted Directed Graph'.
            %
            % See also getClass, getDescription.
            
            name = 'Weighted Directed Graph';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of GRAPHWD.
            %
            % See also getClass, getName.
            
            description = [ ...
                'In a weighted directed (WD) graph, ' ...
                'the edges are associated with a real number between 0 and 1' ...
                'indicating the strength of the connection, ' ...
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
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE() returns Graph.WEIGHTED.
            %    
            % See also Graph, getDirectionalityType, getGraphType, getNegativityType, getSelfConnectivityType.
           
            connectivity_type = Graph.WEIGHTED;
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
            
            available_settings = { ...
                 'GraphWD.NumberOfWeights', BRAPH2.NUMERIC, 5, {} ...
                 };
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
    methods
        function [randomized_graph, correlation_coefficients] = randomize(g, varargin)
            % RANDOMIZE returns a randomized graph and the correlation coefficients
            %
            % RANDOMIZED_GRAPH, CORRELATION_COEFFICIENTS = RANDOMIZE(G) 
            % returns the randomized graph RANDOMIZED_GRAPH and the strength
            % correlation coefficients from the graph G and the randomized.
            % Utilizes available graph settings.
            %
            % RANDOMIZED_GRAPH, CORRELATION_COEFFICIENTS = RANDOMIZE(G, 'GraphWD.NumberOfWeights', 'NUMBER') 
            % returns the randomized graph RANDOMIZED_GRAPH and the strength
            % correlation coefficients from the graph G and the randomized.
            % The randomization is performed with the specified number of
            % weights NUMBER.
            
            % get rules
             number_of_weights = g.getSettings('GraphWU.NumberOfWeights');
            
            W = g.getA();
            graph_BD = GraphBD(W);
            [A, ~] = graph_BD.randomize_graph(varargin{:});
            % remove self connections
            A(1:length(A)+1:numel(A)) = 0;
            W(1:length(W)+1:numel(W)) = 0;
            W_bin = W > 0;
            N = size(A,1); % number of nodes
            randomized_graph = zeros(N); % initialize null model matrix
            
            S_in = sum(W,1).'; % nodal in-strength
            S_out = sum(W,2);  % nodal out-strength
            W_sorted = sort(W(W_bin)); % sorted weights vector
            % find all the edges
            [I_edges, J_edges] = find(A);
            edges = I_edges + (J_edges-1)*N;
            % expected weights matrix
            P = (S_out*S_in.');
            
            for m = numel(W_sorted):-number_of_weights:1
                
                % sort the expected weights matrix
                [~, ind] = sort(P(edges));
                
                % random index of sorted expected weight
                selected_indices = randperm(m, min(m,number_of_weights)).';
                selected_edges = ind(selected_indices);
                
                % assign corresponding sorted weight at this index
                randomized_graph(edges(selected_edges)) = W_sorted(selected_indices);
                
                % recalculate expected weight for node I_edges(selected_edge)
                WAi = accumarray(I_edges(selected_edges), W_sorted(selected_indices), [N,1]);
                Iu = any(WAi,2);
                % readjust expected weight probabilities
                F = 1 - WAi(Iu)./S_out(Iu);
                P(Iu,:) = P(Iu,:).*F(:,ones(1,N));
                % readjust in-strength
                S_out(Iu) = S_out(Iu) - WAi(Iu);
                
                % recalculate expected weight for node J_edges(selected_edge)
                WAj = accumarray(J_edges(selected_edges), W_sorted(selected_indices), [N,1]);
                Ju = any(WAj,2);
                % readjust expected weight probabilities
                F = 1 - WAj(Ju)./S_in(Ju);
                P(:,Ju) = P(:,Ju).*F(:,ones(1,N)).';
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
            rpos_in = corrcoef(sum(W,1), sum(randomized_graph,1));
            rpos_out = corrcoef(sum(W,2), sum(randomized_graph,2));
            correlation_coefficients = [rpos_in(2) rpos_out(2)];
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
