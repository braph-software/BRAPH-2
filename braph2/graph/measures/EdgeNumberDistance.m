classdef EdgeNumberDistance < Distance
    % EdgeNumberDistance Edge number distance measure
    % EdgeNumberDistance provides the edge number distance of a graph for 
    % weighted undirected (WU) and weighted directed (WD) graphs.
    %
    % It is calculated as the number of edges in the shortest weighted path
    % between two nodes within the same layer.
    %
    % EdgeNumberDistance methods:
    %   EdgeNumberDistance          - constructor
    % 
    % EdgeNumberDistance descriptive methods (Static)
    %   getClass                    - returns the edge number distance class
    %   getName                     - returns the name of edge number distance measure
    %   getDescription              - returns the description of edge number distance measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure 
    %   getMeasure                  - returns the edge number distance class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Distance, GraphWU, GraphWD, MultiplexGraphWU, MultiplexGraphWD.
   
    methods
        function m = EdgeNumberDistance(g, varargin)
            % EDGENUMBERDISTANCE(G) creates edge number distance with default properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, GraphWU, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD
            % or MultiplexGraphWU). 
            %
            % See also Measure, Distance, GraphWU, GraphWD, MultiplexGraphWU, MultiplexGraphWD.
          
            m = m@Distance(g, varargin{:});
        end
    end
    methods (Access=protected)   
        function edge_number_distance = calculate(m)
            % CALCULATE calculates the edge number distance value of a graph
            %
            % EDGENUMBERDISTANCE = CALCULATE(M) returns the value of the 
            % edge number distance distance of a graph or multiplex.
            %
            % See also Measure, Distance, GraphWU, GraphWD, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            distance = Distance(g);
            distance.getValue();
            edge_number_distance = distance.getB();
        end
    end
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the edge number distance measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'EdgeNumberDistance';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the edge number distance measure.
            %
            % See also getClass, getDescription. 
          
            name = 'Distance in number of edges';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the edge number distance description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % edge number distance measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The edge distance number of a graph is ' ...
                'the number of edges in the shortest weighted path between two nodes. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to EdgeNumberDistance
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to EdgeNumberDistance. Empty Array in this case.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of EdgeNumberDistance
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of edge number distance measure (BINODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.BINODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of EdgeNumberDistance
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of edge number distance measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of EdgeNumberDistance
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of edge number distance measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with EdgeNumberDistance 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to edge number distance. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'GraphWD', ...
                'GraphWU' ...
                'MultiplexGraphWD' ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with EdgeNumberDistance 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to edge number distance.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('EdgeNumberDistance');
        end
    end
end
