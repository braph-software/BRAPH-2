classdef InEccentricityAv < InEccentricity
    % InEccentricityAv Average in-eccentricity measure
    % InEccentricityAv provides the average in-eccentricity of a graph for binary 
    % directed (BD) and weighted directed (WD) graphs. 
    %
    % It is calculated as the sum of the nodal in-eccentricities divided by 
    % their number within a layer
    %
    % InEccentricityAv methods:
    %   InEccentricityAv            - constructor      
    % 
    % InEccentricityAv descriptive methods (Static)
    %   getClass                    - returns the average in-eccentricity class
    %   getName                     - returns the name of average in-eccentricity measure
    %   getDescription              - returns the description of average in-eccentricity measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure  
    %   getMeasure                  - returns the average in-eccentricity class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, EccentricityAv, InEccentricity, Distance, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = InEccentricityAv(g, varargin)
            % INECCENTRICITYAV(G) creates average in-eccentricity with default
            % InEccentricity properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %   
            % INECCENTRICITYAV(G, 'InEccentricityRule', INECCENTRICITYRULE) creates average in-eccentricity 
            % measure and initializes the property InEccentricityRule with INECCENTRICITYRULE. 
            % Admissible INECCENTRICITYRULE options are:
            % INECCENTRICITYRULE = 'default' (default) - calculates ECCENTRICITY of global graph.
            %                    'subgraphs' - calculates ECCENTRICITY within connected subgraphs.
            %
            % INECCENTRICITYAV(G, 'VALUE', VALUE) creates average eccentricity, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU).
            %   
            % See also Measure, EccentricityAv, InEccentricity, Distance, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.

            m = m@InEccentricity(g, varargin{:});
        end
    end
    methods (Access = protected)
        function in_eccentricity_av = calculate(m)
            % CALCULATE calculates the average in-eccentricity value of a
            % graph
            %
            % ECCENTRICITYAV = CALCULATE(M) returns the value of the average in-eccentricity 
            % of a graph.
            %
            % See also Measure, EccentricityAv, InEccentricity, Distance, GraphBD, GraphWD, MultiplexGraphBD, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('InEccentricity')
                in_eccentricity = g.getMeasureValue('InEccentricity');
            else
                in_eccentricity = calculate@InEccentricity(m);
            end

            in_eccentricity_av = cell(g.layernumber(), 1);
            for li = 1:1:length(in_eccentricity_av)
                in_eccentricity_av(li) = {mean(in_eccentricity{li})};
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average in-eccentricity measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'InEccentricityAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average in-eccentricity measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Average in-eccentricity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average in-eccentricity description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average in-eccentricity measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average in-eccentricity of a graph is the' ...
                'sum of the nodal in-eccentricities divided by their number within a layer.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to
            % InEccentricityAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InEccentricityAv.
            % ECCENTRICITYRULE = 'default' (default) - calculates INECCENTRICITY of global graph.
            %                    'subgraphs' - calculates INECCENTRICITY within connected subgraphs.
            % 
            % See also getCompatibleGraphList()
           
            available_settings = getAvailableSettings@InEccentricity();
        end
       function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of InEccentricity
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of in-eccentricity measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of InEccentricity
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of in-eccentricity measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of InEccentricity
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of in-eccentricity measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with InEccentricityAv 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average in-eccentricity. 
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
            % graphs with InEccentricityAv 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to average in-eccentricity.
            % 
            % See also getCompatibleGraphList().
          
            n = Measure.getCompatibleGraphNumber('InEccentricityAv');
        end
    end
end