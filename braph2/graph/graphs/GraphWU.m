classdef GraphWU < GraphWD
    % GraphWU A weighted undirected graph
    % GraphWU represents a weighted undirected graph.
    %
    % GraphWU consists of a weighted undirected graph.
    %
    % GraphWU methods:
    %   GraphWU                 - constructor
    %
    % GraphWU descriptive methods (static):
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
            % See also Graph, DummyGraph, GraphBD, GraphWD, GraphBU.
            
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
            % See also getName, getDescription.
            
            graph_class = 'GraphWU';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % NAME = GETCLASS() returns the name, 'Weighted Undirected Graph'.
            %
            % See also getClass, getDescription.
            
            name = 'Weighted Undirected Graph';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of GRAPHWU.
            %
            % See also getClass, getName.
            
            description = [ ...
                'In a weighted undirected (WU) graph, ' ...
                'the edges are associated with a real number between 0 and 1 ' ...
                'indicating the strength of the connection, ' ...
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
            % CONNECTIVITY_TYPE = GETCONNECTIVITYTYPE() returns Graph.WEIGHTED.
            %    
            % See also Graph, getDirectionalityType, getGraphType, getNegativityType, getSelfConnectivityType.
          
            connectivity_type = Graph.WEIGHTED;
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
            % GETAVAILABLESETTINGS returns the available rules of graph
            %
            % GETAVAILABLESETTINGS(G) returns an array with the available
            % settings for the graph. 
            %
            % See also getClass, getName, getDescription, getGraphType.
             
            available_settings = { ...
                 'GraphWU.NumberOfWeights', BRAPH2.NUMERIC, 5, {} ...
                 };
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
    methods
        function [randomized_graph, correlation_coefficients] = randomize(g, varargin)  
            % RANDOMIZE returns a randomized graph and the correlation coefficients
            %
            % RANDOMIZED_GRAPH, CORRELATION_COEFFICIENTS = RANDOMIZE(G) 
            % returns the randomized graph RANDOMIZED_GRAPH and the strength
            % correlation coefficients from the graph G and the randomized.
            % Utilizes available graph settings.
            %
            % RANDOMIZED_GRAPH, CORRELATION_COEFFICIENTS = RANDOMIZE(G, 'GraphWU.NumberOfWeights', 'NUMBER')  
            % returns the randomized graph RANDOMIZED_GRAPH and the strength
            % correlation coefficients from the graph G and the randomized.
            % The randomization is performed with the specified number of
            % weights NUMBER.
            
            % get rules
            number_of_weights = g.getSettings('GraphWU.NumberOfWeights');
            
            W = g.getA();
            graph_BU = GraphBU(W);
            [A, ~] = graph_BU.randomize_graph(varargin{:});
             
            % remove self connections
            A(1:length(A)+1:numel(A)) = 0;
            W(1:length(W)+1:numel(W)) = 0;
            W_bin = W > 0;
            N = size(A,1); % number of nodes
            randomized_graph = zeros(N); % intialize null model matrix
            
            S = sum(W,2); % nodal strength
            W_sorted = sort(W(triu(W_bin))); % sorted weights vector
            % find all the edges
            [I_edges, J_edges] = find(triu(A));
            edges = I_edges + (J_edges-1)*N;
            % expected weights matrix
            P = (S*S.');
            
            for m = numel(W_sorted):-number_of_weights:1
                
                % sort the expected weights matrix
                [~, ind] = sort(P(edges));
                
                % random index of sorted expected weight
                selected_indices = randperm(m, min(m,number_of_weights)).';
                selected_edges = ind(selected_indices);
                
                % assign corresponding sorted weight at this index
                randomized_graph(edges(selected_edges)) = W_sorted(selected_indices);
                
                % recalculate expected weight for node I_edges(selected_edge)
                % cumulative weight
                WA = accumarray([I_edges(selected_edges); J_edges(selected_edges)], W_sorted([selected_indices; selected_indices]), [N,1]);
                IJu = any(WA,2);
                F = 1 - WA(IJu)./S(IJu);
                F = F(:,ones(1,N));
                % readjust expected weight probabilities
                P(IJu,:) = P(IJu,:).*F;
                P(:,IJu) = P(:,IJu).*F.';
                % re-adjust strengths
                S(IJu) = S(IJu) - WA(IJu);
                
                % remove the edge/weight from further consideration
                selected_edges = ind(selected_indices);
                edges(selected_edges) = [];
                I_edges(selected_edges) = [];
                J_edges(selected_edges) = [];
                W_sorted(selected_indices) = [];
            end
            
            % calculate the final matrix
            randomized_graph = randomized_graph + transpose(randomized_graph);
            
            % calculate correlation of original vs reassinged strength
            rpos = corrcoef(sum(W), sum(randomized_graph));
            correlation_coefficients = rpos(2);
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