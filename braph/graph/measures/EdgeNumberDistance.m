classdef EdgeNumberDistance < Distance
    % EdgeNumberDistance < Measure: Edge Number Distance measure
    % EdgeNumberDistance provides the edge number distance of a graph for 
    % weighted undirected (WU) and weighted directed (WD) graphs.
    % It is calculated as the number of edges in the shortest weighted path
    % between two nodes.
    % 
    % EdgeNumberDistance methods:
    %   EdgeNumberDistance          - constructor with Distance properties.
    %
    % EdgeNumberDistance methods (Access=protected):
    %   calculate                   - calculates the edge number distance of a graph.
    % 
    % EdgeNumberDistance methods (Static)
    %   getClass                    - returns the edge number distanceclass.
    %   getName                     - returns the name of edge number distance measure.
    %   getDescription              - returns the description of edge number distance measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if edge number distance measure is global.
    %   is_nodal                    - boolean, checks if edge number distance measure is nodal.
    %   is_binodal                  - boolean, checks if edge number distance measure if binodal.
    %   getMeasure                  - returns the edge number distance class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Degree, Strength, Distance.
    
    methods
        function m = EdgeNumberDistance(g, varargin)
            % EDGENUMBERDISTANCE(G) creates edge number distance with default Distance properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %
            % EDGENUMBERDISTANCE(G, 'VALUE', VALUE) creates edge number distance, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU).
            %   
            % See also Measure, Graph, Degree, Strength, BetweennessCentrality. 
            
            m = m@Distance(g, varargin{:});
        end
    end
    methods (Access=protected)
        function edge_number_distance = calculate(m)            
            % CALCULATE calculates the edge number distance value of a
            % graph.
            %
            % EDGENUMBERDISTANCE = CALCULATE(M) returns the value of 
            % the edge number distance of a graph.
            
            if isempty(m.B)
                d =  calculate@Distance(m);
            end
            
            edge_number_distance = m.B;
        end        
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the edge number distance measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'EdgeNumberDistance';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the edge number distance measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Distance in number of edges';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the edge number distance description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % edge number distance measure.
            %
            % See also getList(), getCompatibleGraphList().
            
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
            % See also getCompatibleGraphList()
           
            available_settings = {};
        end
 function bool = is_global()
            % IS_GLOBAL checks if edge number distance measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
            
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if edge number distance measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal. 
            
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if edge number distance measure is binodal (true)
            %
            % BOOL = IS_BINODAL() returns true.
            %
            % See also is_global, is_nodal.
            
            bool = true;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to EdgeNumberDistance 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to EdgeNumberDistance. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...              
                'GraphWD', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to EdgeNumberDistance 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to EdgeNumberDistance.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('EdgeNumberDistance');
        end
    end
end
