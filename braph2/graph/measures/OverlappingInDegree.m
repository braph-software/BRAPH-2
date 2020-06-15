classdef OverlappingInDegree < InDegree
    % OverlappingInDegree Overlapping in-degree measure
    % OverlappingInDegree provides the overlapping in-degree of a node for  
    % binary directed (BD) and weighted directed (WD) multiplexes. 
    %
    % It is calculated as the sum of the number of inward edges connected to the
    % node in all layers, i.e., it is the sum of the in-degrees of a node in
    % all layers.
    % 
    % OverlappingInDegree methods:
    %   OverlappingInDegree         - constructor
    %
    % OverlappingInDegree methods (Static)
    %   getClass                    - returns the overlapping in-degree class
    %   getName                     - returns the name of overlapping in-degree measure
    %   getDescription              - returns the description of overlapping in-degree measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope    
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, InDegree, MultiplexGraphBD, MultiplexGraphWD.
    
    methods
        function m = OverlappingInDegree(g, varargin)
            % OVERLAPPINGINDEGREE(G) creates overlapping in-degree with default properties.
            % G is an directed multiplex (i.e., an instance of
            % MultiplexGraphBD or MultiplexGraphWD).
            %
            % See also Measure, InDegree, MultiplexGraphBD, MultiplexGraphWD.
            
            m = m@InDegree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function overlapping_in_degree = calculate(m)
            % CALCULATE calculates the overlapping in-degree value of a multiplex
            %
            % OVERLAPPINGINDEGREE = CALCULATE(M) returns the value of the overlapping
            % in-degree of a multiplex.
            %
            % See also Measure, InDegree, MultiplexGraphBD, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('InDegree')
                in_degree = g.getMeasureValue('InDegree');
            else
                in_degree = calculate@InDegree(m);
            end
            
            N = g.nodenumber();
            L = g.layernumber();
            
            overlapping_in_degree = zeros(N(1), 1);
            for li = 1:1:L
                overlapping_in_degree = overlapping_in_degree + in_degree{li};
            end
            overlapping_in_degree = {overlapping_in_degree};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the overlapping in-degree measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'OverlappingInDegree';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the overlapping in-degree measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Overlapping in-degree';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the overlapping in-degree description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % overlapping in-degree measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The overlapping in-degree of a node is the sum of ' ...
                'the inward edges connected to the node in all layers. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to OverlappingInDegree
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OverlappingInDegree. Empty Array in this case.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OverlappingInDegree
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of overlapping in-degree measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OverlappingInDegree
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of overlapping in-degree measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with OverlappingInDegree 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to overlapping in-degree. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphBD', ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with OverlappingInDegree
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with overlapping in-degree.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('OverlappingInDegree');
        end
    end
end