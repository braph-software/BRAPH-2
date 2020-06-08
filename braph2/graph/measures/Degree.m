classdef Degree < Measure
    % Degree Degree measure
    % Degree provides the degree of a node for binary undirected (BU) and 
    % weighted undirected (WU) graphs. It is calculated as the number of
    % edges connected to the node. Self-connections are excluded (i.e. the
    % diagonal of the connection matrix is removed).
    % 
    % Degree methods:
    %   Degree                      - constructor
    %
    % Degree methods (Access=protected):
    %   calculate                   - calculates the degree of a node
    % 
    % Degree methods (Static)
    %   getClass                    - returns the degree class
    %   getName                     - returns the name of degree measure
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
        function m = Degree(g, varargin)
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
        function degree = calculate(m)
            % CALCULATE calculates the degree value of a node
            %
            % DEGREE = CALCULATE(M) returns the value of the degree of a
            % node.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix or 2D-cell array 
            
            degree = cell(g.layernumber(), 1);
            
            for li = 1:1:g.layernumber()
                if g.is_graph(g)
                    Aii = A;
                else
                    Aii = A{li, li};
                end
                Aii = binarize(Aii);  % binarizes the adjacency matrix
                degree(li) = {sum(Aii, 2)};  % calculates the degree of a node for layer li
            end
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the degree measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'Degree';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the degree measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Degree';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the degree description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % degree measure.
            %
            % See also getList, getCompatibleGraphList.
            
            description = [ ...
                'The degree of a node is ' ...
                'the number of edges connected to the node. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to Degree
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to Degree. Empty Array in this case.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of degree
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of degree measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of degree
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of degree measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to degree 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to degree. 
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
            % graphs to degree 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to degree.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('Degree');
        end
    end
end