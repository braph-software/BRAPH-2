classdef OverlappingDegree < Degree
    % OverlappingDegree Overlapping degree measure
    % OverlappingDegree provides the overlapping degree of a node for binary 
    % undirected (BU) and weighted undirected (WU) multiplexes. 
    %
    % It is calculated as the sum of the number of edges connected to the
    % node in all layers, i.e., it is the sum of the degrees of a node in
    % all layers.
    % 
    % OverlappingDegree methods:
    %   OverlappingDegree           - constructor
    %
    % OverlappingDegree methods (Static)
    %   getClass                    - returns the overlapping degree class
    %   getName                     - returns the name of overlapping degree measure
    %   getDescription              - returns the description of overlapping degree measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope    
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Degree, MultiplexGraphBU, MultiplexGraphWU.
    
    methods
        function m = OverlappingDegree(g, varargin)
            % OVERLAPPINGDEGREE(G) creates overlapping degree with default properties.
            % G is an undirected multiplex (i.e., an instance of
            % MultiplexGraphBU or MultiplexGraphWU).
            %
            % See also Measure, Degree, MultiplexGraphBU, MultiplexGraphWU.
            
            m = m@Degree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function overlapping_degree = calculate(m)
            % CALCULATE calculates the overlapping degree value of a multiplex
            %
            % OVERLAPPINGDEGREE = CALCULATE(M) returns the value of the overlapping
            % degree of a multiplex.
            %
            % See also Measure, Degree, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('Degree')
                degree = g.getMeasureValue('Degree');
            else
                degree = calculate@Degree(m);
            end
            
            N = g.nodenumber();
            L = g.layernumber();
            
            overlapping_degree = zeros(N(1), 1);
            for li = 1:1:L
                overlapping_degree = overlapping_degree + degree{li};
            end
            overlapping_degree = {overlapping_degree};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the overlapping degree measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'OverlappingDegree';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the overlapping degree measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Overlapping degree';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the overlapping degree description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % overlapping degree measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The overlapping degree of a node is the sum of ' ...
                'the edges connected to the node in all layers. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to OverlappingDegree
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OverlappingDegree. Empty Array in this case.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of OverlappingDegree
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of overlapping degree measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of OverlappingDegree
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of overlapping degree measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with OverlappingDegree 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to overlapping degree. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with OverlappingDegree
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with overlapping degree.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('OverlappingDegree');
        end
    end
end