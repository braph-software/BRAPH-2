classdef Radius < Measure
    % Radius Radius measure
    % Radius provides the radius of a graph for 
    % binary undirected (BU) and weighted undirected (WU) graphs. 
    %
    % It is calculated as the minimum eccentricity among the vertice within a layer
    % 
    % Radius methods:
    %   Radius                      - constructor
    %
    % Radius descriptive methods (Static)
    %   getClass                    - returns the radius class.
    %   getName                     - returns the name of radius measure.
    %   getDescription              - returns the description of radius measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure  
    %   getMeasure                  - returns the radius class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Eccentricity, Diameter, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
    
    methods
        function m = Radius(g, varargin)
            % RADIUS(G) creates radius with default measure properties.
            % G is a graph (e.g, an instance of GraphBU, GraphWU,
            % MultiplexGraphBU, MultiplexGraphWU). 
            %
            % RADIUS(G, 'VALUE', VALUE) creates radius, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBU, GraphWU,
            % MultiplexGraphBU, MultiplexGraphWU).
            %   
            % See also Measure, Eccentricity, Diameter, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
              
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function radius = calculate(m)
            % CALCULATE calculates the radius value of a graph
            %
            % RADIUS = CALCULATE(M) returns the value of the radius of a
            % graph.
            %   
            % See also Measure, Eccentricity, Diameter, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            L = g.layernumber();
            
            if g.is_measure_calculated('Eccentricity')
                eccentricity = g.getMeasure('Eccentricity').getValue();
            else
                eccentricity_rule = get_from_varargin('default', 'EccentricityRule', m.getSettings());
                eccentricity = Eccentricity(g, 'EccentricityRule', eccentricity_rule).getValue();
            end
            
            radius = cell(L, 1);
            for li = 1:1:L
                radius(li) = {min(eccentricity{li})};
            end
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
                'among the vertice within a layer'
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to Radius
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to Radius. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {
                'EccentricityRule', BRAPH2.STRING, 'default', {'default', 'subgraphs'};
                };
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of Radius
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of radius measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of Radius
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of radius measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of Radius
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of radius measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with Radius 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to Radius. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphBU', ...
                'GraphWU', ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with Radius 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to Radius.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('Radius');
        end
    end  
end