classdef EccentricityAv < Eccentricity
    % EccentricityAv Average eccentricity measure
    % EccentricityAv provides the average eccentricity of a graph for binary 
    % undirected (BU) and weighted undirected (WU) graphs. 
    % 
    % It is calculated as the sum of the nodal eccentricities divided by 
    % their number within a layer.
    % 
    % EccentricityAv methods:
    %   EccentricityAv              - constructor
    % 
    % EccentricityAv methods (Static)
    %   getClass                    - returns the average eccentricity class
    %   getName                     - returns the name of average eccentricity measure
    %   getDescription              - returns the description of average eccentricity measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure  
    %   getMeasure                  - returns the average eccentricity class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Eccentricity, Distance, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
    
    methods
        function m = EccentricityAv(g, varargin)
            % ECCENTRICITYAV(G) creates average eccentricity with default
            % Eccentricity properties.
            % G is a graph (e.g, an instance of GraphBU, GraphWU,
            % MultiplexGraphBU, MultiplexGraphWU). 
            %   
            % ECCENTRICITYAV(G, 'EccentricityRule', ECCENTRICITYRULE) creates average eccentricity 
            % measure and initializes the property EccentricityRule with ECCENTRICITYRULE. 
            % Admissible ECCENTRICITYRULE options are:
            % ECCENTRICITYRULE = 'default' (default) - calculates ECCENTRICITY of global graph.
            %                    'subgraphs' - calculates ECCENTRICITY within connected subgraphs.
            %
            % ECCENTRICITYAV(G, 'VALUE', VALUE) creates average eccentricity, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBU, GraphWU,
            % MultiplexGraphBU, MultiplexGraphWU). 
            %
            % See also Measure, Eccentricity, Distance, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.

            m = m@Eccentricity(g, varargin{:});
        end
    end
    methods (Access = protected)
        function eccentricity_av = calculate(m)
            % CALCULATE calculates the average eccentricity value of a
            % graph
            %
            % ECCENTRICITYAV = CALCULATE(M) returns the value of the average eccentricity 
            % of a graph.
            %
            % See also Measure, Eccentricity, Distance, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('Eccentricity')
                eccentricity = g.getMeasureValue('Eccentricity');
            else
                eccentricity = calculate@Eccentricity(m);
            end
                        
            eccentricity_av = cell(g.layernumber(), 1);
            for li = 1:1:length(eccentricity_av)
                eccentricity_av(li) = {mean(eccentricity{li})};
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average eccentricity measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'EccentricityAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average eccentricity measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Average eccentricity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average eccentricity description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average eccentricity measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average eccentricity of a graph is the ' ...
                'sum of the nodal eccentricities divided by their number within a layer.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to
            % EccentricityAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to EccentricityAv.
            % ECCENTRICITYRULE = 'default' (default) - calculates ECCENTRICITY of global graph.
            %                    'subgraphs' - calculates ECCENTRICITY within connected subgraphs.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = getAvailableSettings@Eccentricity();
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of EccentricityAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average eccentricity measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of EccentricityAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average eccentricity measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of EccentricityAv
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of average eccentricity measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with EccentricityAv 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average eccentricity. 
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
            % graphs with EccentricityAv 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to average eccentricity.
            % 
            % See also getCompatibleGraphList().
          
            n = Measure.getCompatibleGraphNumber('EccentricityAv');
        end
    end
end