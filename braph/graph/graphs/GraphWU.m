classdef GraphWU < GraphWD
    % GraphWU < GraphWD: A weighted undirected graph
    % GraphWU represents a weighted undirected graph.
    %   
    % GraphWU methods:
    %   GraphWU     - constructor.
    %
    % GraphWU methods (static):
    %   getClass    - return the class type GraphWU.
    %   getName     - return the complete name of GraphWU.
    %   getDescription - return the description of GraphWU.
    %   is_selfconnected - boolean, checks if the graph is self-connected.
    %   is_nonnegative - boolean, checks if the graph is non-negative.
    %   is_weighted - boolean, checks if the graph is weighted.
    %   is_binary   - boolean, checks if the graph is binary.
    %   is_directed - boolean, checks if the graph is directed.
    %   is_undirected - boolean, checks if the graph is undirected.
    %   getCompatibleMeasureList - returns a list with compatible measures.
    %   getCompatibleMeasureNumber - returns the number of compatible measures. 
    %
    % See also Graph, GraphBD, GraphWU, GraphWD.

    methods
        function g = GraphWU(A, varargin)
            % GRAPHWU(A) creates a GRAPHWU class with adjacency matrix A.
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % function: SYMMETRIZE. 
            % It calls the superclass constructor GRAPHWD.
            %
            % GRAPHWU(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...) creates
            % a GRAPHWU class with adjacency matrix A and it passes the
            % properties and values to the superclass as VARARGIN. 
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % function: SYMMETRIZE. 
            % It calls the superclass constructor GRAPHWD.
            %
            % See also Graph, GraphBD, GraphWD, GraphBU.
            
            A = symmetrize(A, varargin{:});  % enforces symmetry of adjacency matrix
            
            g = g@GraphWD(A, varargin{:});
        end
    end
    methods (Static)
        function graph_class = getClass()
            % GETCLASS returns the class of the graph.
            %
            % GRAPH_CLASS = GETCLASS() returns the class, 'GraphWU'.
            %
            % See also getName().
            
            graph_class = 'GraphWU';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % NAME = GETCLASS() returns the name, 'Weighted Undirected Graph'.
            %
            % See also getClass()
            
            name = 'Weighted Undirected Graph';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of GRAPHWU.
            %
            % See also getName().
            
            description = [ ...
                'In a weighted undirected (WU) graph, ' ...
                'the edges are associated with a real number between 0 and 1 ' ...
                'indicating the strength of the connection, ' ...
                'and they are undirected.' ...
                'The connectivity matrix is symmetric.' ...
                ];
        end
        function bool = is_directed()
            % IS_DIRECTED checks if the graph is directed.
            %
            % BOOL = IS_DIRECTED() returns false for GRAPHWU.
            %
            % See also is_undirected().
            
            bool = false;
        end
        function bool = is_undirected()
            % IS_UNDIRECTED checks if the graph is directed.
            %
            % BOOL = IS_UNDIRECTED() returns true for GRAPHWU.
            %
            % See also is_directed().
            
            bool = true;
        end
        function list = getCompatibleMeasureList()
            % GETCOMPATIBLEMEASURELIST returns a list with compatible measures.
            %
            % LIST = GETCOMPATIBLEMEASURELIST() returns a list with
            % compatible measures to the graph.
            %
            % See also getCompatibleMeasureNumber().
            
            list = Graph.getCompatibleMeasureList('GraphWU');
        end
        function n = getCompatibleMeasureNumber()
            % GETCOMPATIBLEMEASURENUMBER returns a number of the compatible measures.
            %
            % N = GETCOMPATIBLEMEASURENUMBER() returns the number of 
            % compatible measures to the graph.
            %
            % See also getCompatibleMeasureList().
            
            n = Graph.getCompatibleMeasureNumber('GraphWU');
        end
    end
end