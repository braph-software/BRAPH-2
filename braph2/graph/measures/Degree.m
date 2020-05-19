classdef Degree < Measure
    % Degree < Measure: Degree measure
    % Degree provides the degree of a node for binary undirected (BU) and 
    % weighted undirected (WU) graphs. It is calculated as the number of
    % edges connected to the node. Self-connections are excluded (i.e. the
    % diagonal of the connection matrix is removed).
    % 
    % Degree methods:
    %   Degree                      - constructor with Measure properties.
    %
    % Degree methods (Access=protected):
    %   calculate                   - calculates the degree of a node.
    % 
    % Degree methods (Static)
    %   getClass                    - returns the degree class.
    %   getName                     - returns the name of degree measure.
    %   getDescription              - returns the description of degree measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if degree measure is global.
    %   is_nodal                    - boolean, checks if degree measure is nodal.
    %   is_binodal                  - boolean, checks if degree measure if binodal.
    %   getMeasure                  - returns the degree class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
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
            A = g.getA();  % adjency matrix of the graph
            A = binarize(A);  % binarizes the adjacency matrix
            degree = sum(A, 2);  % calculates the degree of a node
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the degree measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'Degree';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the degree measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Degree';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the degree description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % degree measure.
            %
            % See also getList(), getCompatibleGraphList().
            
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
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function measure_type = getMeasureType()
            % GETMEASURETYPE returns the measure type of degree
            %
            % MEASURE_TYPE = GETMEASURETYPE() returns the measure type
            % of degree measure (NODAL).
            %
            % See also getMultiMeasureType().
            
            measure_type = Measure.NODAL;
        end
        function multimeasure_type = getMultiMeasureType()
            % GETMULTIMEASURETYPE returns the multi-measure type of degree
            %
            % MULTIMEASURE_TYPE = GETMULTIMEASURETYPE() returns the
            % multi-measure type of degree measure (UNILAYER).
            %
            % See also getMeasureType().
            
            multimeasure_type = Measure.UNILAYER;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to degree 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to degree. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphBU', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to degree 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to degree.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('Degree');
        end
    end
end