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
    %   is_global                   - boolean, checks if degree measure is global.
    %   is_nodal                    - boolean, checks if degree measure is nodal.
    %   is_binodal                  - boolean, checks if degree measure if binodal.
    %   getMeasure                  - returns the degree class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, Strength, Distance, Efficency.
    
    methods
        function m = Degree(g, varargin)
            % DEGREE(G) creates degree with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, Graph WU). 
            %   
            % DEGREE(G, 'Settings', SETTINGS) ceates degree measure and
            % initializes the property settings with SETTINGS. 
            %   
            % See also Measure, Graph, Strength, Distance, Efficency. 
            settings = clean_varargin({}, varargin{:});

            m = m@Measure(g, settings{:});
        end
    end
    methods (Access=protected)
        function degree = calculate(m)
            % CALCULATE calculates the degree value of a node
            %
            % DEGREE = CALCULATE(M) returns the value of the degree of a
            % node.
            
            g = m.getGraph(); % graph from measure class
            A = g.getA(); % adjency matrix of the graph
            A = binarize(A); % binarizes the adjacency matrix
            degree = sum(A, 2); % calculates the degree of a node
        end
    end        
    methods (Static)
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
        function bool = is_global()
            % IS_GLOBAL checks if degree measure is global
            %
            % BOOL = IS_GLOBAL() returns true if the degree measure is
            % global and false otherwise.
            %
            % See also is_nodal, is_binodal.
                                   
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if degree measure is nodal
            %
            % BOOL = IS_NODAL() returns true if the degree measure is
            % nodal and false otherwise.
            %
            % See also is_global, is_binodal. 
            
            bool = true;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if degree measure is binodal
            %
            % BOOL = IS_BINODAL() returns true if the degree measure is
            % binodal and false otherwise.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to degree measure
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to degree measure. 
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
            % graphs to degree measure
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to degree measure.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('Degree');
        end
    end
end