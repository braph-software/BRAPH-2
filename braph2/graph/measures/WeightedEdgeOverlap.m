classdef WeightedEdgeOverlap < Measure
    % WeightedEdgeOverlap Weighted Edge Overlap measure
    % WeightedEdgeOverlap provides the weighted edge overlap of a graph for 
    % weighted undirected (WU) and weighted directed (WD) graphs.  
    % It is calculated as the fraction of layers in which each pair
    % of node exists. 
    % 
    % WeightedEdgeOverlap methods:
    %   WeightedEdgeOverlap         - constructor
    %
    % WeightedEdgeOverlap methods (Access=protected):
    %   calculate                   - calculates the weighted edge overlap of a graph
    % 
    % WeightedEdgeOverlap methods (Static)
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
    % See also Measure, Graph, Strength, EdgeOverlap, OverlappingStrength.
    
    methods
        function m = WeightedEdgeOverlap(g, varargin)
            % WEIGHTEDEDGEOVERLAP(G) creates weighted edge overlap with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %
            % WEIGHTEDEDGEOVERLAP(G, 'VALUE', VALUE) creates weighted edge overlap, 
            % and sets the value to VALUE. G is a graph (e.g, an instance of 
            % GraphBD, GraphBU, GraphWD, Graph WU).
            %   
            % See also Measure, Graph, Strength, EdgeOverlap, OverlappingStrength. 
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function weighted_edge_overlap = calculate(m)
            % CALCULATE calculates the weighted edge overlap value of a graph
            %
            % WEIGHTEDEDGEOVERLAP = CALCULATE(M) returns the value of the 
            % weighted edge overlap of a graph.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix or 2D-cell array 
            
            N = g.nodenumber();
            L = g.layernumber();
            overlap = zeros(N(1));
            
            for li = 1:1:L
                if g.is_graph(g)
                    Aii = A;
                else
                    Aii = A{li, li};
                end
                overlap = overlap + Aii;
            end
            weighted_edge_overlap = {overlap/L};
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
            
            name = 'Weighted-Edge-Overlap';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the weighted edge overlap description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % weighted edge overlap measure.
            %
            % See also getList, getCompatibleGraphList.
            
            description = [ ...
                'The weighted edge overlap of a graph is ' ...
                'the fraction of layers in which each pair of nodes exists. ' ...
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
            % GETMEASUREFORMAT returns the measure format of weighted edge overlap
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of weighted edge overlap measure (BINODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.BINODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of weighted edge overlap
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of weighted edge overlap measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs to weighted edge overlap 
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
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs to weighted edge overlap 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to weighted edge overlap.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('WeightedEdgeOverlap');
        end
    end
end