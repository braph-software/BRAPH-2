classdef EdgeOverlap < Measure
    % EdgeOverlap Edge Overlap measure
    % EdgeOverlap provides the edge overlap of a graph for binary undirected (BU) and 
    % weighted undirected (WU) graphs. It is calculated as the number of
    % edges connected to the node. Self-connections are excluded (i.e. the
    % diagonal of the connection matrix is removed).
    % 
    % EdgeOverlap methods:
    %   EdgeOverlap                      - constructor
    %
    % EdgeOverlap methods (Access=protected):
    %   calculate                   - calculates the edge overlap of a graph
    % 
    % EdgeOverlap methods (Static)
    %   getClass                    - returns the degree class
    %   getName                     - returns the name of edge overlap measure
    %   getDescription              - returns the description of degree measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns de measure format
    %   getMeasureScope             - returns de measure scope    
    %   getMeasure                  - returns the degree class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, Graph, Strength, Distance, Efficiency.
    
    methods
        function m = EdgeOverlap(g, varargin)
            % DEGREE(G) creates degree with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %
            % DEGREE(G, 'VALUE', VALUE) creates degree, and sets the value
            % to VALUE. G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU).
            %   
            % See also Measure, Graph, Strength, Distance, Efficency. 
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function edge_overlap = calculate(m)
            % CALCULATE calculates the degree value of a node
            %
            % DEGREE = CALCULATE(M) returns the value of the degree of a
            % node.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix or 2D-cell array 
            
            N = g.nodenumber();
            L = g.layernumber();
            overlap = zeros(N);
            
            for li = 1:1:L
                if g.is_graph(g)
                    Aii = A;
                else
                    Aii = A{li, li};
                end
                Aii = binarize(Aii);  % binarizes the adjacency matrix
                overlap = overlap + Aii;
            end
            edge_overlap = {overlap/L};
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the edge overlap measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'EdgeOverlap';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the edge overlap measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Edge-Overlap';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the edge overlap description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % edge overlap measure.
            %
            % See also getList, getCompatibleGraphList.
            
            description = [ ...
                'The edge overlap of a graph is ' ...
                'the fraction of layers in which each pair of nodes exists. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to EdgeOverlap
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to EdgeOverlap. Empty Array in this case.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of edge overlap
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of edge overlap measure (BINODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.BINODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of edge overlap
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of edge overlap measure (SUPERGLOBAL).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.SUPERGLOBAL;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs to edge overlap 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to edge overlap. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'GraphBU', ...
                'MultiplexGraphBU', ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs to edge overlap 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to edge overlap.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('EdgeOverlap');
        end
    end
end