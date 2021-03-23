classdef OutEccentricityAv < OutEccentricity
    % OutEccentricityAv Average out-eccentricity measure
    % OutEccentricityAv provides the average out-eccentricity of a graph for binary 
    % directed (BD) and weighted directed (WD) graphs. 
    %
    % It is calculated as the sum of the nodal out-eccentricities divided by 
    % their number within a layer
    % 
    % OutEccentricityAv methods:
    %   OutEccentricityAv           - constructor 
    % 
    % OutEccentricityAv descriptive methods (Static)
    %   getClass                    - returns the average out-eccentricity class
    %   getName                     - returns the name of average out-eccentricity measure
    %   getDescription              - returns the description of average out-eccentricity measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getMeasure                  - returns the average out-eccentricity class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, EccentricityAv, OutEccentricity, Distance, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = OutEccentricityAv(g, varargin)
            % OUTECCENTRICITYAV(G) creates average out-eccentricity with default
            % OutEccentricity properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %   
            % OUTECCENTRICITYAV(G, 'EccentricityRule', ECCENTRICITYRULE) creates average out-eccentricity 
            % measure and initializes the property EccentricityRule with ECCENTRICITYRULE. 
            % Admissible RULE options are:
            % ECCENTRICITYRULE = 'default' (default) - calculates OUTECCENTRICITY of global graph.
            %                    'subgraphs' - calculates OUTECCENTRICITY within connected subgraphs.
            %
            % OUTECCENTRICITYAV(G, 'VALUE', VALUE) creates average out-eccentricity, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %   
            % See also Measure, EccentricityAv, OutEccentricity, Distance, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            m = m@OutEccentricity(g, varargin{:});
        end
    end
    methods (Access = protected)
        function out_eccentricity_av = calculate(m)
            % CALCULATE calculates the average out-eccentricity value of a
            % graph
            %
            % OUTECCENTRICITYAV = CALCULATE(M) returns the value of the average out-eccentricity 
            % of a graph.
            %
            % See also Measure, EccentricityAv, OutEccentricity, Distance, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('OutEccentricity')
                out_eccentricity = g.getMeasureValue('OutEccentricity');
            else
                out_eccentricity = calculate@OutEccentricity(m);
            end

            out_eccentricity_av = cell(g.layernumber(), 1);
            for li = 1:1:length(out_eccentricity_av)
                out_eccentricity_av(li) = {mean(out_eccentricity{li})};
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average out-eccentricity measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'OutEccentricityAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average out-eccentricity measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Average out-eccentricity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average out-eccentricity description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average out-eccentricity measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average out-eccentricity of a graph is the' ...
                'sum of the nodal out Eccentricities divided by their number within a layer.' ...
                ];
        end
        function available_settings = getAvailableSettings()   
            % GETAVAILABLESETTINGS returns the setting available to OutEccentricityAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OutEccentricityAv.
            % ECCENTRICITYRULE = 'default' (default) - calculates OUTECCENTRICITY of global graph.
            %                    'subgraphs' - calculates OUTECCENTRICITY within connected subgraphs.
            % 
            % See also getCompatibleGraphList()
           
            available_settings = getAvailableSettings@OutEccentricity();
        end
       function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OutEccentricityAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average out-eccentricity measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OutEccentricityAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average out-eccentricity measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of OutEccentricityAv
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of average out-eccentricity measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with OutEccentricityAv 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average out-eccentricity.
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphBD', ...
                'GraphWD', ...
                'MultiplexGraphBD', ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with OutEccentricityAv 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to average out-eccentricity.
            % 
            % See also getCompatibleGraphList().
          
            n = Measure.getCompatibleGraphNumber('OutEccentricityAv');
        end
    end
end