classdef Diameter < Measure
    % Diameter Diameter measure
    % Diameter provides the diameter of a graph for 
    % binary undirected (BU) and weighted undirected (WU) graphs. 
    %
    % It is calculated as the maximum eccentricity among the vertice within
    % a layer.
    % 
    % Diameter methods:
    %   Diameter                    - constructor
    %
    % Diameter descriptive methods (Static)
    %   getClass                    - returns the diameter class
    %   getName                     - returns the name of diameter measure
    %   getDescription              - returns the description of diameter measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure  
    %   getMeasure                  - returns the diameter class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Eccentricity, Radius, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
    
    methods
        function m = Diameter(g, varargin)
            % DIAMETER(G) creates diameter with default measure properties.
            % G is a graph (e.g, an instance of GraphBU, GraphWU,
            % MultiplexGraphBU, MultiplexGraphWU). 
            %
            % DIAMETER(G, 'VALUE', VALUE) creates diameter, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBU, GraphWU,
            % MultiplexGraphBU, MultiplexGraphWU).
            %   
            % See also Measure, Eccentricity, Radius, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
              
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function diameter = calculate(m)
            % CALCULATE calculates the diameter value of a graph
            %
            % DIAMETER = CALCULATE(M) returns the value of the diameter of a
            % graph.
            %   
            % See also Measure, Eccentricity, Radius, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            L = g.layernumber();
            
            if g.is_measure_calculated('Eccentricity')
                eccentricity = g.getMeasureValue('Eccentricity');
            else
                eccentricity_rule = get_from_varargin('default', 'EccentricityRule', m.getSettings());
                eccentricity = Eccentricity(g, 'EccentricityRule', eccentricity_rule).getValue();
            end
            
            diameter = cell(L, 1);
            for li = 1:1:L
                diameter(li) = {max(eccentricity{li})};
            end
        end
    end  
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the diameter measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'Diameter';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the diameter measure.
            %
            % See also getClass, getDescription. 
          
            name = 'Diameter';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the diameter description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % diameter measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The diameter is the maximum eccentricity ' ...
                'among the vertice within a layer' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to Diameter
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to Diameter. 
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {
                'EccentricityRule', BRAPH2.STRING, 'default', {'default', 'subgraphs'};
                };
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of Diameter
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of diameter measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of Diameter
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of diameter measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of Diameter
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of diameter measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with Diameter 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to diameter. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'GraphBU', ...
                'GraphWU', ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with Diameter 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to diameter.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('Diameter');
        end
    end  
end