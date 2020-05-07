classdef Radius < Measure
    % Radius < Measure: Radius measure
    % Radius provides the radius of a graph for binary undirected (BU) and 
    % weighted undirected (WU) graphs. It is calculated as the minimum   
    % eccentricity among the vertice.
    % 
    % Radius methods:
    %   Radius                      - constructor with Measure properties.
    %
    % Radius methods (Access=protected):
    %   calculate                   - calculates the radius of a graph.
    % 
    % Radius methods (Static)
    %   getClass                    - returns the radius class.
    %   getName                     - returns the name of radius measure.
    %   getDescription              - returns the description of radius measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if radius measure is global.
    %   is_nodal                    - boolean, checks if radius measure is nodal.
    %   is_binodal                  - boolean, checks if radius measure if binodal.
    %   getMeasure                  - returns the radius class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Eccentricity, Diameter.
    
    methods
        function m = Radius(g, varargin)
            % RADIUS(G) creates radius with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %
            % RADIUS(G, 'VALUE', VALUE) creates radius, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU).
            %   
            % See also Measure, Graph, Eccentricity, Diameter. 
              
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function radius = calculate(m)
            % CALCULATE calculates the radius value of a graph
            %
            % RADIUS = CALCULATE(M) returns the value of the radius of a
            % graph.
            
            g = m.getGraph(); % graph from measure class
            
            if g.is_measure_calculated('Eccentricity')
                eccentricity = g.getMeasure('Eccentricity').getValue();
            else
                eccentricity_rule = get_from_varargin('default', 'EccentricityRule', m.getSettings());
                eccentricity = Eccentricity(g, 'EccentricityRule', eccentricity_rule).getValue();
            end
            
            radius = min(eccentricity);
        end
    end  
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the radius measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'Radius';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the radius measure.
            %
            % See also getClass(), getDescription(). 
          
            name = 'Radius';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the radius description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % radius measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The radius is the minimum eccentricity ' ...
                'among the vertice.'
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to Radius
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to Radius. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function bool = is_global()
            % IS_GLOBAL checks if radius measure is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
            
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if radius measure is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal. 
            
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if radius measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to Radius 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to Radius. 
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
            % graphs to Radius 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to Radius.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('Radius');
        end
    end  
end