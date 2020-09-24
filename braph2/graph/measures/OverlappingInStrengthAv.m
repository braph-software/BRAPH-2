classdef OverlappingInStrengthAv < OverlappingInStrength
    % OverlappingInStrengthAv Average overlapping in-strength measure
    % OverlappingInStrengthAv provides the average overlapping in-strength of a graph
    % for weighted directed (WD) multiplexes. 
    %
    % It is calculated as the average of the sum of the in-strengths of a node in all layers.
    % 
    % OverlappingInStrengthAv methods:
    %   OverlappingInStrengthAv     - constructor
    %
    % OverlappingInStrengthAv methods (Static)
    %   getClass                    - returns the average overlapping in-strength class
    %   getName                     - returns the name of average overlapping in-strength measure
    %   getDescription              - returns the description of average overlapping in-strength measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure 
    %   getMeasure                  - returns the average overlapping in-strength class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, OverlappingInStrength, InStrength, MultiplexGraphWD.
    
    methods
        function m = OverlappingInStrengthAv(g, varargin)
            % OVERLAPPINGINSTRENGTHAV(G) creates average overlapping in-strength with default properties.
            % G is a weighted directed multiplex (i.e., an instance of MultiplexGraphWD).
            %
            % See also Measure, OverlappingInStrength, InStrength, MultiplexGraphWD.
            
            m = m@OverlappingInStrength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function overlapping_in_strength_av = calculate(m)
            % CALCULATE calculates the average overlapping in-strength value of a multiplex
            %
            % OVERLAPPINGINSTRENGTHAV = CALCULATE(M) returns the value of the average overlapping
            % in-strength of a multiplex.
            %
            % See also Measure, OverlappingInStrength, InStrength, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('OverlappingInStrength')
                overlapping_in_strength = g.getMeasureValue('OverlappingInStrength');
            else
                overlapping_in_strength = calculate@OverlappingInStrength(m);
            end
            
            overlapping_in_strength_av = {mean(overlapping_in_strength{1})};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average overlapping in-strength measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'OverlappingInStrengthAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average overlapping in-strength measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Average overlapping in-strength';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average overlapping in-strength description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % overlapping in-strength measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The average overlapping in-strength of a network is the average ' ...
                'of the sum of the inward weighted edges connected to the node in all layers. ' ...
                'It is calculated as the average of the sum of the in-strengths of a node ' ...
                'in all layers.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to OverlappingInStrengthAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OverlappingInStrengthAv. Empty Array in this case.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OverlappingInStrengthAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average overlapping in-strength measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OverlappingInStrengthAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average overlapping in-strength measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of OverlappingInStrengthAv
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of average overlapping in-strength measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with OverlappingInStrengthAv 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average overlapping in-strength. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with OverlappingInStrengthAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with average overlapping in-strength.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('OverlappingInStrengthAv');
        end
    end
end