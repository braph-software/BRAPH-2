classdef WeightedEdgeOverlap < Measure
    % WeightedEdgeOverlap Weighted edge overlap measure
    % WeightedEdgeOverlap provides the weighted edge overlap of a weighted multiplex. 
    % 
    % It is calculated as the weighted fraction of layers in which edge
    % between a pair of nodes exists. 
    % 
    % WeightedEdgeOverlap methods:
    %   WeightedEdgeOverlap         - constructor
    %
    % WeightedEdgeOverlap descriptive methods (Static)
    %   getClass                    - returns the weighted edge overlap class
    %   getName                     - returns the name of weighted edge overlap measure
    %   getDescription              - returns the description of weighted edge overlap measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope    
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, MultiplexGraphWD, MultiplexGraphWU.
    
    methods
        function m = WeightedEdgeOverlap(g, varargin)
            % WEIGHTEDEDGEOVERLAP(G) creates weighted edge overlap with default properties.
            % G is a multiplex (i.e., an instance of MultiplexGraphWD, MultiplexGraphWU). 
            %
            % See also Measure, MultiplexGraphWD, MultiplexGraphWU.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function weighted_edge_overlap = calculate(m)
            % CALCULATE calculates the weighted edge overlap value of a multiplex
            %
            % WEIGHTEDEDGEOVERLAP = CALCULATE(M) returns the value of the 
            % weighted edge overlap of a multiplex.
            %
            % See also Measure, MultiplexGraphWD, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % 2D-cell array 
            
            N = g.nodenumber();
            L = g.layernumber();
            
            weighted_edge_overlap = zeros(N(1));
            for li = 1:1:L
                Aii = A{li, li};
                weighted_edge_overlap = weighted_edge_overlap + Aii;
            end
            weighted_edge_overlap = {weighted_edge_overlap/L};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the weighted edge overlap measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'WeightedEdgeOverlap';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the weighted edge overlap measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Weighted Edge Overlap';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the weighted edge overlap description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % weighted edge overlap measure.
            %
            % See also getList, getCompatibleGraphList.
            
            description = [ ...
                'For each edge, the weighted edge overlap of a multiplex graph ' ...
                'is the weighted fraction of layers where that edge exists. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to WeightedEdgeOverlap
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to WeightedEdgeOverlap. Empty Array in this case.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of WeightedEdgeOverlap
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of weighted edge overlap measure (BINODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.BINODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of WeightedEdgeOverlap
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of weighted edge overlap measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs to WeightedEdgeOverlap
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to weighted edge overlap. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphWD' ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs to WeightedEdgeOverlap 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to weighted edge overlap.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('WeightedEdgeOverlap');
        end
    end
end