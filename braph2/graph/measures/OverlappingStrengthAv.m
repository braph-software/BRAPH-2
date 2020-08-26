classdef OverlappingStrengthAv < OverlappingStrength
    % OverlappingStrengthAv Average overlapping strength measure
    % OverlappingStrengthAv provides the average overlapping strength of a 
    % node for weighted undirected (WU) multiplexes. 
    %
    % It is calculated as the average of the sum of the strengths of a 
    % node in all layers, i.e., it is the mean of the overlapping strength 
    % within each layer.
    % 
    % OverlappingStrengthAv methods:
    %   OverlappingStrengthAv       - constructor
    %
    % OverlappingStrengthAv descriptive methods (Static)
    %   getClass                    - returns the average overlapping strength class
    %   getName                     - returns the name of average overlapping strength measure
    %   getDescription              - returns the description of average overlapping strength measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure   
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, OverlappingStrength, Strength, MultiplexGraphWU.
    
    methods
        function m = OverlappingStrengthAv(g, varargin)
            % OVERLAPPINGSTRENGTHAV(G) creates average overlapping strength with default properties.
            % G is a weighted undirected multiplex (e.g, an instance of
            % MultiplexGraphWU).
            % 
            % See also Measure, OverlappingStrength, Strength, MultiplexGraphWU.
            
            m = m@OverlappingStrength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function overlapping_strength_av = calculate(m)
            % CALCULATE calculates the average overlapping strength value of a multiplex
            %
            % OVERLAPPINGSTRENGTHAV = CALCULATE(M) returns the value of the average 
            % overlapping strength of a multiplex.
            %
            % See also Measure, OverlappingStrength, Strength, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('OverlappingStrength')
                overlapping_strength = g.getMeasureValue('OverlappingStrength');
            else
                overlapping_strength = calculate@OverlappingStrength(m);
            end
            
            overlapping_strength_av = {mean(overlapping_strength{1})}; 
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average overlapping strength measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'OverlappingStrengthAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average overlapping strength measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Average overlapping Strength';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average overlapping strength description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average overlapping strength measure.
            %
            % See also getList, getCompatibleGraphList.
            
            description = [ ...
                'The average overlapping strength of a node is the average ' ...
                'of the sum of the number of weighted edges connected to ' ...
                'the node in all layers. It is calculated as the sum of ' ...
                'the strengths of a node in all layers.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to OverlappingStrengthAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OverlappingStrengthAv. Empty array in this case.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OverlappingStrengthAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average overlapping strength (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OverlappingStrengthAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average overlapping strength measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of OverlappingStrengthAv
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of average overlapping strength measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with OverlappingStrengthAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average overlapping strength. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with OverlappingStrengthAv 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to average overlapping strength.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('OverlappingStrengthAv');
        end
    end
end
