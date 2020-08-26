classdef StrengthAv < Strength
    % StrengthAv Average strength measure
    % StrengthAv provides the average strength of a node for weighted 
    % undirected (WU) graphs.
    %
    % It is calculated as the average of the sum of all weights of the edges 
    % connected to a node within a layer, i.e., it is the mean of the strength 
    % within each layer.
    %
    % StrengthAv methods:
    %   StrengthAv                  - constructor
    %
    % StrengthAv descriptive methods (Static)
    %   getClass                    - returns the average strength class
    %   getName                     - returns the name of average strength measure
    %   getDescription              - returns the description of average strength measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope 
    %   getMeasure                  - returns the strength class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Strength, GraphWU, MultiplexGraphWU.
    
    methods
        function m = StrengthAv(g, varargin)
            % STRENGTHAV(G) creates average strength with default properties.
            % G is a weighted undirected (WU) graph (e.g, an instance of 
            % GraphWU or MultiplexGraphWU).
            %
            % See also Measure, Strength, GraphWU, MultiplexGraphWU.

            m = m@Strength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function strength_av = calculate(m)
            % CALCULATE calculates the average strength value of a graph
            %
            % STRENGTHAV = CALCULATE(M) returns the value of the average strength
            % of a weighted undirected (WU) graph or multiplex.
            %
            % See also Measure, Strength, GraphWU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class

            if g.is_measure_calculated('Strength')
                strength = g.getMeasureValue('Strength');
            else
                strength = calculate@Strength(m);
            end
            
            strength_av = cell(g.layernumber(), 1);
            for li = 1:1:length(strength_av)
                strength_av(li) = {mean(strength{li})}; 
            end
        end
    end
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average 
            % strength measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'StrengthAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average strength measure.
            %
            % See also getClass(), getDescription().
            
            name = 'Average strength';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average strength description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average strength measure.
            %
            % See also getClass(), getName().
            
            description = [ ...
                'The average strength of a node is ' ...
                'the average of the sum of the weights of ' ...
                'all the edges connected to a node within a layer ' ...
                'for weighted undirected (WU) graphs. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to StrengthAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to StrengthAv. Empty array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of StrengthAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average strength measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of StrengthAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average strength measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of StrengthAv
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of average strength measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with StrengthAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average strength. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber().
            
            list = { ...
                'GraphWU' ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with StrengthAv 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to average strength.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('StrengthAv');
        end
    end
end