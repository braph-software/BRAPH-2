classdef OutStrengthAv < OutStrength
    % OutStrengthAv Average out-strength measure
    % OutStrengthAv provides the average out-strength of a node for weighted 
    % directed (WD) graphs.
    %
    % It is calculated as the average of the sum of all weights of the outward edges 
    % connected to a node within a layer, i.e., it is the mean of the out-strength 
    % within each layer.
    %
    % OutStrengthAv methods:
    %   OutStrengthAv               - constructor
    %
    % OutStrengthAv descriptive methods (Static)
    %   getClass                    - returns the average out-strength class
    %   getName                     - returns the name of average out-strength measure
    %   getDescription              - returns the description of average out-strength measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope 
    %   getMeasure                  - returns the strength class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, OutStrength, GraphWD, MultiplexGraphWD.
    
    methods
        function m = OutStrengthAv(g, varargin)
            % OUTSTRENGTHAV(G) creates average out-strength with default properties.
            % G is a weighted directed (WD) graph (e.g, an instance of 
            % GraphWD or MultiplexGraphWD).
            %
            % See also Measure, OutStrength, GraphWD, MultiplexGraphWD.

            m = m@OutStrength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function out_strength_av = calculate(m)
            % CALCULATE calculates the average out-strength value of a graph
            %
            % OUTSTRENGTHAV = CALCULATE(M) returns the value of the average out-strength
            % of a weighted directed (WD) graph or multiplex.
            %
            % See also Measure, OutStrength, GraphWD, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class

            if g.is_measure_calculated('OutStrength')
                out_strength = g.getMeasureValue('OutStrength');
            else
                out_strength = calculate@OutStrength(m);
            end
            
            out_strength_av = cell(g.layernumber(), 1);
            for li = 1:1:length(out_strength_av)
                out_strength_av(li) = {mean(out_strength{li})}; 
            end
        end
    end
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average 
            % out-strength measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'OutStrengthAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average out-strength measure.
            %
            % See also getClass(), getDescription().
            
            name = 'Average out-strength';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average out-strength description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average out-strength measure.
            %
            % See also getClass(), getName().
            
            description = [ ...
                'The average out-strength of a node is ' ...
                'the average of the sum of the weights of ' ...
                'all the outward edges connected to a node within a layer ' ...
                'for weighted directed (WD) graphs. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to OutStrengthAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OutStrengthAv. Empty array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OutStrengthAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average out-strength measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OutStrengthAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average out-strength measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of OutStrengthAv
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of average out-strength measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with OutStrengthAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average out-strength. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber().
            
            list = { ...
                'GraphWD' ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with OutStrengthAv 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to average out-strength.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('OutStrengthAv');
        end
    end
end