classdef DegreeOverlap < EdgeOverlap
    % DegreeOverlap Overlapping Degree measure
    % DegreeOverlap provides the overlapping degree of a node for binary 
    % undirected (BU) and weighted undirected (WU) graphs. It is calculated 
    % as the number of edges connected to the node. 
    % 
    % DegreeOverlap methods:
    %   DegreeOverlap           - constructor
    %
    % DegreeOverlap methods (Access=protected):
    %   calculate                   - calculates the overlapping degree of a node
    % 
    % DegreeOverlap methods (Static)
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
        function m = DegreeOverlap(g, varargin)
            % OVERLAPPINGDEGREE(G) creates overlapping degree with default Degree properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %
            % OVERLAPPINGDEGREE(G, 'VALUE', VALUE) creates overlapping degree, 
            % and sets the value to VALUE. G is a graph (e.g, an instance of 
            % GraphBD, GraphBU, GraphWD, Graph WU).
            %   
            % See also Measure, Graph, Strength, Distance, Efficency. 
            
            m = m@EdgeOverlap(g, varargin{:});
        end
    end
    methods (Access=protected)
        function degree_overlap = calculate(m)
            % CALCULATE calculates the overlapping degree value of a node
            %
            % OVERLAPPINGDEGREE = CALCULATE(M) returns the value of the overlapping
            % degree of a node.
            
            g = m.getGraph();  % graph from measure class
            
            if g.is_measure_calculated('EdgeOverlap')
                edge_overlap = g.getMeasureValue('EdgeOverlap');
            else
                edge_overlap = calculate@EdgeOverlap(m);
            end
            
            degree_overlap = {sum(edge_overlap{1} == 1, 2)};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the overlapping degree measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'DegreeOverlap';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the overlapping degree measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Degree overlap';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the overlapping degree description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % overlapping degree measure.
            %
            % See also getList, getCompatibleGraphList.
            
            description = [ ...
                'The degree overlap of a node is ' ...
                'the total number of edges connected to the node within all layers. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to DegreeOverlap
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to DegreeOverlap. Empty Array in this case.
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
            
            n = Measure.getCompatibleGraphNumber('DegreeOverlap');
        end
    end
end