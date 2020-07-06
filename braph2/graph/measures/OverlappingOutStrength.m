classdef OverlappingOutStrength < OutStrength
    % OverlappingOutStrength Overlapping out-strength measure
    % OverlappingOutStrength provides the overlapping out-strength of a node for  
    % weighted directed (WD) multiplexes. 
    %
    % It is calculated as the sum of the out-strengths of a node in all layers.    
    % 
    % OverlappingOutStrength methods:
    %   OverlappingOutStrength      - constructor
    %
    % OverlappingOutStrength descriptive methods (Static)
    %   getClass                    - returns the overlapping out-strength class
    %   getName                     - returns the name of overlapping out-strength measure
    %   getDescription              - returns the description of overlapping out-strength measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope    
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, OutStrength, MultiplexGraphWD.
    
    methods
        function m = OverlappingOutStrength(g, varargin)
            % OVERLAPPINGOUTSTRENGTH(G) creates overlapping out-strength with default properties.
            % G is a weighted directed multiplex (e.g, an instance of
            % MultiplexGraphWD).
            % 
            % See also Measure, OutStrength, MultiplexGraphWD.
            
            m = m@OutStrength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function overlapping_out_strength = calculate(m)
            % CALCULATE calculates the overlapping out-strength value of a multiplex
            %
            % OVERLAPPINGOUTSTRENGTH = CALCULATE(M) returns the value of the overlapping 
            % out-strength of a multiplex.
            %
            % See also Measure, OutStrength, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('OutStrength')
                out_strength = g.getMeasureValue('OutStrength');
            else
                out_strength = calculate@OutStrength(m);
            end
            
            N = g.nodenumber();
            L = g.layernumber();
            
            overlapping_out_strength = zeros(N(1), 1);
            for li = 1:1:L
                overlapping_out_strength = overlapping_out_strength + out_strength{li};
            end
            overlapping_out_strength = {overlapping_out_strength};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the overlapping out-strength measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'OverlappingOutStrength';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the overlapping out-strength measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Overlapping out-strength';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the overlapping out-strength description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % overlapping out-strength measure.
            %
            % See also getList, getCompatibleGraphList.
            
            description = [ ...
                'The overlapping out-strength of a node is the sum of the outward ' ...
                'weighted edges connected to the node in all layers. It ' ...
                'is calculated as the sum of the out-strengths of a node in all layers.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to OverlappingOutStrength
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OverlappingOutStrength. Empty array in this case.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OverlappingOutStrength
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of overlapping out-strength (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OverlappingOutStrength
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of overlapping out-strength measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with OverlappingOutStrength
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to overlapping out-strength. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with OverlappingOutStrength 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to overlapping out-strength.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('OverlappingOutStrength');
        end
    end
end
