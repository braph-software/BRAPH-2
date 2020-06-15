classdef OverlappingInStrength < InStrength
    % OverlappingInStrength Overlapping in-strength measure
    % OverlappingInStrength provides the overlapping in-strength of a node for  
    % weighted directed (WD) multiplexes. 
    %
    % It is calculated as the sum of the in-strengths of a node in all layers.    
    % 
    % OverlappingInStrength methods:
    %   OverlappingInStrength       - constructor
    %
    % OverlappingInStrength descriptive methods (Static)
    %   getClass                    - returns the overlapping in-strength class
    %   getName                     - returns the name of overlapping in-strength measure
    %   getDescription              - returns the description of overlapping in-strength measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope    
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, InStrength, MultiplexGraphWD.
    
    methods
        function m = OverlappingInStrength(g, varargin)
            % OVERLAPPINGINSTRENGTH(G) creates overlapping in-strength with default properties.
            % G is a weighted directed multiplex (e.g, an instance of
            % MultiplexGraphWD).
            % 
            % See also Measure, InStrength, MultiplexGraphWD.
            
            m = m@InStrength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function overlapping_in_strength = calculate(m)
            % CALCULATE calculates the overlapping in-strength value of a multiplex
            %
            % OVERLAPPINGINSTRENGTH = CALCULATE(M) returns the value of the overlapping 
            % in-strength of a multiplex.
            %
            % See also Measure, InStrength, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('InStrength')
                in_strength = g.getMeasureValue('InStrength');
            else
                in_strength = calculate@Strength(m);
            end
            
            N = g.nodenumber();
            L = g.layernumber();
            
            overlapping_in_strength = zeros(N(1), 1);
            for li = 1:1:L
                overlapping_in_strength = overlapping_in_strength + in_strength{li};
            end
            overlapping_in_strength = {overlapping_in_strength};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the overlapping in-strength measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'OverlappingInStrength';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the overlapping in-strength measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Overlapping in-strength';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the overlapping in-strength description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % overlapping in-strength measure.
            %
            % See also getList, getCompatibleGraphList.
            
            description = [ ...
                'The overlapping in-strength of a node is the sum of the inward ' ...
                'weighted edges connected to the node in all layers. It ' ...
                'is calculated as the sum of the in-strengths of a node in all layers.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to OverlappingInStrength
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OverlappingInStrength. Empty array in this case.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OverlappingInStrength
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of overlapping in-strength (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OverlappingInStrength
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of overlapping in-strength measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with OverlappingInStrength
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to overlapping in-strength. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with OverlappingInStrength 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to overlapping in-strength.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('OverlappingInStrength');
        end
    end
end
