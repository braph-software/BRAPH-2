classdef Diameter < Measure
    % Diameter < Measure: Diameter measure
    % Diameter provides the diameter of a graph for 
    % binary undirected (BU) and weighted undirected (WU) graphs. 
    % It is calculated as the maximum eccentricity among the vertice.
    % 
    % Diameter methods:
    %   Diameter                    - constructor with Measure properties.
    %
    % Diameter methods (Access=protected):
    %   calculate                   - calculates the diameter of a graph.
    % 
    % Diameter methods (Static)
    %   getClass                    - returns the diameter class.
    %   getName                     - returns the name of diameter measure.
    %   getDescription              - returns the description of diameter measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if diameter measure is global.
    %   is_nodal                    - boolean, checks if diameter measure is nodal.
    %   is_binodal                  - boolean, checks if diameter measure if binodal.
    %   getMeasure                  - returns the diameter class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Eccentricity, Radius.
    
    methods
        function m = Diameter(g, varargin)
            % DIAMETER(G) creates diameter with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %
            % DIAMETER(G, 'VALUE', VALUE) creates diameter, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU).
            %   
            % See also Measure, Graph, Eccentricity, Radius. 
              
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function diameter = calculate(m)
            % CALCULATE calculates the diameter value of a graph
            %
            % DIAMETER = CALCULATE(M) returns the value of the diameter of a
            % graph.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('Eccentricity')
                eccentricity = g.getMeasure('Eccentricity').getValue();
            else
                eccentricity_rule = get_from_varargin('default', 'EccentricityRule', m.getSettings());
                eccentricity = Eccentricity(g, 'EccentricityRule', eccentricity_rule).getValue();
            end
            
            diameter = max(eccentricity);
        end
    end  
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the diameter measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'Diameter';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the diameter measure.
            %
            % See also getClass(), getDescription(). 
          
            name = 'Diameter';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the diameter description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % diameter measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The diameter is the maximum eccentricity ' ...
                'among the vertice.'
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to Diameter
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to Diameter. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function bool = is_global()
            % IS_GLOBAL checks if diameter measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
            
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if diameter measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal. 
            
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if diameter measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to Diameter 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to Diameter. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphBU', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to Diameter 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to Diameter.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('Diameter');
        end
    end  
end