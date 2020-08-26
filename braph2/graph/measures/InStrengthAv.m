classdef InStrengthAv < InStrength
    % InStrengthAv Average in-strength measure
    % InStrengthAv provides the average in-strength of a node for weighted 
    % directed (WD) graphs.
    %
    % It is calculated as the average of the sum of all weights of the inward edges 
    % connected to a node within a layer, i.e., it is the mean of the in-strength 
    % within each layer.
    %
    % InStrengthAv methods:
    %   InStrengthAv                - constructor
    %
    % InStrengthAv descriptive methods (Static)
    %   getClass                    - returns the average in-strength class
    %   getName                     - returns the name of average in-strength measure
    %   getDescription              - returns the description of average in-strength measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope 
    %   getMeasure                  - returns the strength class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, InStrength, GraphWD, MultiplexGraphWD.
    
    methods
        function m = InStrengthAv(g, varargin)
            % INSTRENGTHAV(G) creates average in-strength with default properties.
            % G is a weighted directed (WD) graph (e.g, an instance of 
            % GraphWD or MultiplexGraphWD).
            %
            % See also Measure, InStrength, GraphWD, MultiplexGraphWD.

            m = m@InStrength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function in_strength_av = calculate(m)
            % CALCULATE calculates the average in-strength value of a graph
            %
            % INSTRENGTHAV = CALCULATE(M) returns the value of the average in-strength
            % of a weighted directed (WD) graph or multiplex.
            %
            % See also Measure, InStrength, GraphWD, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class

            if g.is_measure_calculated('InStrength')
                in_strength = g.getMeasureValue('InStrength');
            else
                in_strength = calculate@InStrength(m);
            end
            
            in_strength_av = cell(g.layernumber(), 1);
            for li = 1:1:length(in_strength_av)
                in_strength_av(li) = {mean(in_strength{li})}; 
            end
        end
    end
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average 
            % in-strength measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'InStrengthAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average in-strength measure.
            %
            % See also getClass(), getDescription().
            
            name = 'Average in-strength';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average in-strength description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average in-strength measure.
            %
            % See also getClass(), getName().
            
            description = [ ...
                'The average in-strength of a node is ' ...
                'the average of the sum of the weights of ' ...
                'all the inward edges connected to a node within a layer ' ...
                'for weighted directed (WD) graphs. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to InStrengthAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to InStrengthAv. Empty array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of InStrengthAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average in-strength measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of InStrengthAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average in-strength measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of InStrengthAv
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of average in-strength measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with InStrengthAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average in-strength. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber().
            
            list = { ...
                'GraphWD' ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with InStrengthAv 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to average in-strength.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('InStrengthAv');
        end
    end
end