classdef OverlappingStrength < Strength
    % OverlappingStrength Overlapping strength measure
    % OverlappingStrength provides the overlapping strength of a node for  
    % weighted undirected (WU) multiplexes. 
    %
    % It is calculated as the sum the sum of the strengths of a node in
    % all layers.    
    % 
    % OverlappingStrength methods:
    %   OverlappingStrength         - constructor
    %
    % OverlappingStrength descriptive methods (Static)
    %   getClass                    - returns the overlapping strength class
    %   getName                     - returns the name of overlapping strength measure
    %   getDescription              - returns the description of overlapping strength measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope    
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Strength, MultiplexGraphWU.
    
    methods
        function m = OverlappingStrength(g, varargin)
            % OVERLAPPINGSTRENGTH(G) creates overlapping strength with default properties.
            % G is a weighted undirected multiplex (e.g, an instance of
            % MultiplexGraphWU).
            % 
            % See also Measure, Strength, MultiplexGraphWU.
            
            m = m@Strength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function overlapping_strength = calculate(m)
            % CALCULATE calculates the overlapping strength value of a multiplex
            %
            % OVERLAPPINGSTRENGTH = CALCULATE(M) returns the value of the overlapping 
            % strength of a multiplex.
            %
            % See also Measure, Strength, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('Strength')
                strength = g.getMeasureValue('Strength');
            else
                strength = calculate@Strength(m);
            end
            
            N = g.nodenumber();
            L = g.layernumber();
            
            overlapping_strength = zeros(N(1), 1);
            for li = 1:1:L
                overlapping_strength = overlapping_strength + strength{li};
            end
            overlapping_strength = {overlapping_strength};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the overlapping strength measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'OverlappingStrength';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the overlapping strength measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Overlapping Strength';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the overlapping strength description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % overlapping strength measure.
            %
            % See also getList, getCompatibleGraphList.
            
            description = [ ...
                'The overlapping strength of a node is the sum of the number' ...
                'of weighted edges connected to the node in all layers. It ' ...
                'is calculated as the sum of the strengths of a node in all layers.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to OverlappingStrength
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OverlappingStrength. Empty array in this case.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OverlappingStrength
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of overlapping strength (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OverlappingStrength
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of overlapping strength measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with OverlappingStrength
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to overlapping strength. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with OverlappingStrength 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to overlapping strength.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('OverlappingStrength');
        end
    end
end