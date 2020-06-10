classdef OverlappingDegree < Degree
    % OverlappingDegree Degree measure
    % OverlappingDegree provides the overlapping degree of a node for binary 
    % undirected (BU) and weighted undirected (WU) graphs. It is calculated 
    % as the number of edges connected to the node. 
    % 
    % OverlappingDegree methods:
    %   OverlappingDegree           - constructor
    %
    % OverlappingDegree methods (Access=protected):
    %   calculate                   - calculates the overlapping degree of a node
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
    % See also Measure, Graph, Strength, Distance, Efficiency.
    
    methods
        function m = OverlappingDegree(g, varargin)
            % OVERLAPPINGDEGREE(G) creates overlapping degree with default Degree properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %
            % OVERLAPPINGDEGREE(G, 'VALUE', VALUE) creates overlapping degree, 
            % and sets the value to VALUE. G is a graph (e.g, an instance of 
            % GraphBD, GraphBU, GraphWD, Graph WU).
            %   
            % See also Measure, Graph, Strength, Distance, Efficency. 
            
            m = m@Degree(g, varargin{:});
        end
    end
    methods (Access=protected)
        function overlapping_degree = calculate(m)
            % CALCULATE calculates the degree value of a node
            %
            % OVERLAPPINGDEGREE = CALCULATE(M) returns the value of the degree of a
            % node.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('Degree')
                degree = g.getMeasureValue('Degree');
            else
                degree = calculate@Degree(m);
            end
            
            N = g.nodenumber();
            L = g.layernumber();
            overlapping = zeros(N(1), 1);
            
            for li = 1:1:L
                overlapping = overlapping + degree{li};
            end
            overlapping_degree = {overlapping};
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
            
            name = 'Overlapping-Degree';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the overlapping degree description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % overlapping degree measure.
            %
            % See also getList, getCompatibleGraphList.
            
            description = [ ...
                'The overlapping degree of a node is ' ...
                'the total number of edges connected to the node within all layers. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to OverlappingDegree
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OverlappingDegree. Empty Array in this case.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of overlapping degree
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of overlapping degree measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of overlapping degree
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of overlapping degree measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to overlapping degree 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to overlapping degree. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'GraphBU', ...
                'GraphWU' ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to overlapping degree 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to overlapping degree.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('OverlappingDegree');
        end
    end
end