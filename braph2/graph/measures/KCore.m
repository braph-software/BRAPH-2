classdef KCore < Measure
    % KCore K-Core measure
    % KCore provides the k-core of a network for binary undirected (BU),
    % binary directed (BD), weighted undirected (WU) and weighted directed (WD)  
    % graphs.  
    %
    % It is a parametric measure, it calculates the connection matrix of the 
    % k-core for a given network by recursively peeling off nodes with 
    % degree lower than k within a layer, until no such nodes remain. 
    % The value of k is set by the user (setting 'KCoreThreshold'), the 
    % default value is equal to 1.          
    % 
    % KCore methods:
    %   KCore                       - constructor
    %
    % KCore descriptive methods (Static)
    %   getClass                    - returns the k-core class
    %   getName                     - returns the name of k-core measure
    %   getDescription              - returns the description of k-core measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of k-core measure
    %   getMeasure                  - returns the k-core class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Degree, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
    
    methods
        function m = KCore(g, varargin)
            % KCORE(G) creates k-core with default properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, GraphWU, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD
            % or MultiplexGraphWU). 
            %
            % KCORE(G, 'KCoreThreshold', KCORETHRESHOLD) creates
            % k-core measure and initializes the property KCoreThreshold
            % with KCORETHRESHOLD. Admissible THRESHOLD options are:
            % KCORETHRESHOLD = 1 (default) - KCORE k threshold 
            %                    is set to 1.
            %                    value - KCORE k threshold is set 
            %                    to the specificied value.
            % 
            % KCORE(G, 'VALUE', VALUE) creates k-core, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, GraphWU, MultiplexGraphBD, MultiplexGraphBU, 
            % MultiplexGraphWD or MultiplexGraphWU). 
            %
            % See also Measure, Degree, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function k_core = calculate(m)
            % CALCULATE calculates the k-core value of a graph
            %
            % RICHCLUBDEGREE = CALCULATE(M) returns the value of the 
            % k-core of a graph.
            %
            % See also Measure, Degree, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjacency matrix (for graph) or 2D-cell array (for multiplex)
            L = g.layernumber();
            
            kcore_threshold = get_from_varargin(1, 'KCoreThreshold', m.getSettings());
            assert(mod(kcore_threshold, 1) == 0, ...
                [BRAPH2.STR ':KCore:' BRAPH2.WRONG_INPUT], ...
                ['KCore threshold must be an integer value ' ...
                'while it is ' tostring(kcore_threshold)])
                
            k_core = cell(L, 1);
            directionality_type =  g.getDirectionalityType(L);
            for li = 1:1:L
                
                if g.is_graph(g)
                    Aii = A;
                    directionality_layer = directionality_type;
                else
                    Aii = A{li, li};
                    directionality_layer = directionality_type(li, li);
                end

                % peelorder = [];
                % peellevel = [];
                iter = 0;
                subAii = binarize(Aii);
                while 1
                    % get degrees of matrix
                    %[deg] = degrees_und(CIJ);
                    if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                        deg = sum(subAii, 1)';  % degree undirected graphs
                    else
                        deg = (sum(subAii, 1)' + sum(subAii, 2))/2;  % degree directed
                    end
                    
                    % find nodes with degree < k
                    low_k_nodes = find((deg < kcore_threshold) & (deg > 0));
                    
                    % if none found -> stop
                    if (isempty(low_k_nodes)) break; end; %#ok<SEPEX>
                    
                    % peel away found nodes
                    iter = iter + 1;
                    subAii(low_k_nodes, :) = 0;
                    subAii(:, low_k_nodes) = 0; 
                    %peelorder = [peelorder; low_k_nodes'];
                    %peellevel = [peellevel; iter.*ones(1,length(low_k_nodes))'];
                end
                k_core(li) = {subAii};  % add k-core of layer li          
            end
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the k-core measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'KCore';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the k-core measure.
            %
            % See also getClass, getDescription. 
            
            name = 'K-Core';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the k-core description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % k-core measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The k-core of a graph is the largest subnetwork comprising' ...
                'nodes of degree k or higher. ' ...
                'k is set by the user; the default value is equal to 1. ' ...
                ];  
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to KCore
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to KCore.
            % KCORETHRESHOLD = 1 (default) - KCORE k threshold is set  
            %                    to 1.
            %                    value - KCORE k threshold is set 
            %                    to the specificied value.
            
            available_settings = {
                 'KCoreThreshold', BRAPH2.NUMERIC, 1, {};
                };
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of KCore
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of k-core measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of KCore
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of k-core measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of KCore
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of k-core measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with KCore 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to k-core. 
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
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with KCore
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with k-core.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('KCore');
        end
    end
end