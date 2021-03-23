classdef SCore < Measure
    % SCore S-Core measure
    % SCore provides the s-core of a network for weighted undirected (WU)
    % and weighted directed (WD) graphs.  
    %
    % It is a parametric measure, it calculates the connection matrix of the 
    % s-core for a given network by recursively peeling off nodes with 
    % strength lower than s within a layer, until no such nodes remain. 
    % The value of s is set by the user (setting 'SCoreThreshold'), the 
    % default value is equal to 1.          
    % 
    % SCore methods:
    %   SCore                       - constructor
    %
    % SCore descriptive methods (Static)
    %   getClass                    - returns the s-core class
    %   getName                     - returns the name of s-core measure
    %   getDescription              - returns the description of s-core measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of s-core measure
    %   getMeasure                  - returns the s-core class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, GraphWU, GraphWD, MultiplexGraphWU, MultiplexGraphWD.
    
    methods
        function m = SCore(g, varargin)
            % SCORE(G) creates s-core with default properties.
            % G is a graph (e.g, an instance of GraphWD, GraphWU,  
            % MultiplexGraphWD or MultiplexGraphWU). 
            %
            % SCORE(G, 'SCoreThreshold', SCORETHRESHOLD) creates
            % s-core measure and initializes the property SCoreThreshold
            % with SCORETHRESHOLD. Admissible THRESHOLD options are:
            % SCORETHRESHOLD = 1 (default) - SCORE s threshold 
            %                    is set to 1.
            %                    value - SCORE s threshold is set 
            %                    to the specificied value.
            % 
            % SCORE(G, 'VALUE', VALUE) creates s-core, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphWD, GraphWU, 
            % MultiplexGraphWD or MultiplexGraphWU). 
            %
            % See also Measure, GraphWU, GraphWD, MultiplexGraphWU, MultiplexGraphWD.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function s_core = calculate(m)
            % CALCULATE calculates the s-core value of a graph
            %
            % SCORE = CALCULATE(M) returns the value of the 
            % s-core of a graph.
            %
            % See also Measure, GraphWU, GraphWD, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjacency matrix (for graph) or 2D-cell array (for multiplex)
            L = g.layernumber();
            
            score_threshold = get_from_varargin(1, 'SCoreThreshold', m.getSettings());
            assert(isnumeric(score_threshold) == 1, ...
                [BRAPH2.STR ':SCore:' BRAPH2.WRONG_INPUT], ...
                ['SCore threshold must be a positive number ' ...
                'while it is ' tostring(score_threshold)])
            
            s_core = cell(L, 1);
            directionality_type =  g.getDirectionalityType(L);
            for li = 1:1:L
                
                if g.is_graph(g)
                    Aii = A;
                    directionality_layer = directionality_type;
                else
                    Aii = A{li, li};
                    directionality_layer = directionality_type(li, li);
                end

                iter = 0;
                subAii = Aii;
                while 1
                    % get strengths of matrix
                    if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                        st = sum(subAii, 1)';  % degree undirected graphs
                    else
                        st = (sum(subAii, 1)' + sum(subAii, 2));  % strength directed
                    end
                    
                    % find nodes with degree < k
                    low_s_nodes = find((st < score_threshold) & (st > 0));
                    
                    % if none found -> stop
                    if (isempty(low_s_nodes)) break; end; %#ok<SEPEX>
                    
                    % peel away found nodes
                    iter = iter + 1;
                    subAii(low_s_nodes, :) = 0;
                    subAii(:, low_s_nodes) = 0; 
                end
                s_core(li) = {subAii};  % add s-core of layer li
            end
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the s-core measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'SCore';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the s-core measure.
            %
            % See also getClass, getDescription. 
            
            name = 'S-Core';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the s-core description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % s-core measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The s-core of a graph is the largest subnetwork comprising' ...
                'nodes of strength s or higher. ' ...
                's is set by the user; the default value is equal to 1. ' ...
                ];  
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to SCore
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to SCore.
            % SCORETHRESHOLD = 1 (default) - SCORE s threshold is set  
            %                    to 1.
            %                    value - SCORE s threshold is set 
            %                    to the specificied value.
            
            available_settings = {
                 'SCoreThreshold', BRAPH2.NUMERIC, 1, {};
                };
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of SCore
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of s-core measure (BINODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.BINODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of SCore
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of s-core measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of SCore
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of s-core measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with SCore 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to s-core. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'GraphWD', ...
                'GraphWU', ...
                'MultiplexGraphWD', ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with SCore
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with s-core.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('SCore');
        end
    end
end