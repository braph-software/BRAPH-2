classdef KCorenessCentrality < Measure
    % KCorenessCentrality K-Coreness Centrality measure
    % KCorenessCentrality provides the k-coreness centrality of a node for 
    % binary undirected (BU), binary directed (BD), weighted undirected (WU) 
    % and weighted directed (WD) graphs.  
    %
    % It calculates the coreness of a node, which is k if the node belongs 
    % to the k-core but not to the (k+1)-core.
    % 
    % KCorenessCentrality methods:
    %   KCorenessCentrality         - constructor
    %
    % KCorenessCentrality descriptive methods (Static)
    %   getClass                    - returns the k-coreness centrality class
    %   getName                     - returns the name of k-coreness centrality measure
    %   getDescription              - returns the description of k-coreness centrality measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of k-coreness centrality measure
    %   getMeasure                  - returns the k-coreness centrality class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
    
    methods
        function m = KCorenessCentrality(g, varargin)
            % KCORENESSCENTRALITY(G) creates k-coreness centrality with default properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, GraphWU, MultiplexGraphBD, MultiplexGraphBU, 
            % MultiplexGraphWD or MultiplexGraphWU). 
            %
            % See also Measure, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function k_coreness_centrality = calculate(m)
            % CALCULATE calculates the k-coreness centrality value of a graph
            %
            % KCORENESSCENTRALITY = CALCULATE(M) returns the value of the 
            % k-coreness centrality of a graph.
            %
            % See also Measure, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjacency matrix (for graph) or 2D-cell array (for multiplex)
            L = g.layernumber();
            N = g.nodenumber();
 
            k_coreness_centrality = cell(L, 1);
            directionality_type =  g.getDirectionalityType(L);
            for li = 1:1:L
                if g.is_graph(g)
                    Aii = A;
                    directionality_layer = directionality_type;
                else
                    Aii = A{li, li};
                    directionality_layer = directionality_type(li, li);
                end
                
                coreness = zeros(1, N(1));
                for k = 1:N(1)
                    k_core = m.calculate_kcore(Aii, k, directionality_layer);
                    ss = sum(k_core) > 0;
                    coreness(ss) = k;
                end
                k_coreness_centrality(li) = {coreness'};
            end
        end
        function k_core = calculate_kcore(m, A, k, directionality_layer)
            % CALCULATEKCORE calculates the k-core value of an adjacency matrix
            %
            % KCORE = CALCULATEKCORE(M, A, k, directionality_layer) returns 
            % the value of the k-core of an adjacency matrix

            iter = 0;
            subAii = binarize(A);
            while 1
                % get degrees of matrix
                if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                    deg = sum(subAii, 1)';  % degree undirected graphs
                else
                    deg = (sum(subAii, 1)' + sum(subAii, 2));  % degree directed
                end
                
                % find nodes with degree < k
                low_k_nodes = find((deg < k) & (deg > 0));
                
                % if none found -> stop
                if (isempty(low_k_nodes)) break; end; %#ok<SEPEX>
                
                % peel away found nodes
                iter = iter + 1;
                subAii(low_k_nodes, :) = 0;
                subAii(:, low_k_nodes) = 0;
            end
            k_core = subAii;  % add k-core of layer li
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the k-coreness centrality measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'KCorenessCentrality';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the k-coreness centrality measure.
            %
            % See also getClass, getDescription. 
            
            name = 'K-Coreness Centrality';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the k-coreness centrality description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % k-coreness centrality measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The k-coreness centrality of a node is k if the node belongs ' ...
                'to the k-core but not to the (k+1)-core. ' ...
                ];  
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to KCorenessCentrality
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to KCorenessCentrality. Empty Array in this case.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of KCorenessCentrality
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of k-coreness centrality measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of KCorenessCentrality
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of k-coreness centrality measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of KCorenessCentrality
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of k-coreness centrality measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with KCorenessCentrality 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to k-coreness centrality. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'GraphBD', ...
                'GraphBU', ...
                'GraphWD', ...
                'GraphWU' ...
                'MultiplexGraphBD', ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWD' ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with KCorenessCentrality
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with k-coreness centrality.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('KCorenessCentrality');
        end
    end
end