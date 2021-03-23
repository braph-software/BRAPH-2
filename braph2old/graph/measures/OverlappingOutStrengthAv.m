classdef OverlappingOutStrengthAv < OverlappingOutStrength
    % OverlappingOutStrengthAv Average overlapping out-strength measure
    % OverlappingOutStrengthAv provides the average overlapping out-strength of a graph
    % for weighted directed (WD) multiplexes. 
    %
    % It is calculated as the average of the sum of the out-strength of a node in all layers.
    % 
    % OverlappingOutStrengthAv methods:
    %   OverlappingOutStrengthAv    - constructor
    %
    % OverlappingOutStrengthAv methods (Static)
    %   getClass                    - returns the average overlapping out-strength class
    %   getName                     - returns the name of average overlapping out-strength measure
    %   getDescription              - returns the description of average overlapping out-strength measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure 
    %   getMeasure                  - returns the average overlapping out-strength class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, OverlappingOutStrength, OutStrength, MultiplexGraphWD.
    
    methods
        function m = OverlappingOutStrengthAv(g, varargin)
            % OVERLAPPINGOUTSTRENGTHAV(G) creates average overlapping out-strength with default properties.
            % G is a directed multiplex (i.e., an instance of MultiplexGraphWD).
            %
            % See also Measure, OverlappingOutStrength, OutStrength, MultiplexGraphWD.
            
            m = m@OverlappingOutStrength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function overlapping_out_strength_av = calculate(m)
            % CALCULATE calculates the average overlapping out-strength value of a multiplex
            %
            % OVERLAPPINGOUTSTRENGTHAV = CALCULATE(M) returns the value of the average overlapping
            % out-strength of a multiplex.
            %
            % See also Measure, OverlappingOutStrength, OutStrength, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('OverlappingOutStrength')
                overlapping_out_strength = g.getMeasureValue('OverlappingOutStrength');
            else
                overlapping_out_strength = calculate@OverlappingOutStrength(m);
            end
            
            overlapping_out_strength_av = {mean(overlapping_out_strength{1})};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average overlapping out-strength measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'OverlappingOutStrengthAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average overlapping out-strength measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Average overlapping out-strength';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average overlapping out-strength description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % overlapping out-strength measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The average overlapping out-strength of a network is the average ' ...
                'of the sum of the outward weighted edges connected to the node in all layers. ' ...
                'It is calculated as the average of the sum of the out-strengths of a node ' ...
                'in all layers.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to OverlappingOutStrengthAv
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OverlappingOutStrengthAv. Empty Array in this case.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OverlappingOutStrengthAv
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of average overlapping out-strength measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OverlappingOutStrengthAv
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of average overlapping out-strength measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of OverlappingOutStrengthAv
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of average overlapping out-strength measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with OverlappingOutStrengthAv 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to average overlapping out-strength. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with OverlappingOutStrengthAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with average overlapping out-strength.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('OverlappingOutStrengthAv');
        end
    end
end