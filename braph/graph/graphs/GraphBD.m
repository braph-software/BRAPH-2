classdef GraphBD < Graph
    % GraphBD < Graph : Creates GraphBD.
    %   GraphBD represents a binary directed graph.
    %   
    % GraphBD methods:
    %   GraphBD    -    constructor.
    %
    % GraphBD methods (static):
    %   getClass        -    return the class type GraphBD.
    %   getName         -    return the complete name of GraphBD.
    %   getDescription  -   return the description of GraphBD.
    %   is_selfconnected -  boolean, checks if the graph is self-connected.
    %   is_nonnegative  -  boolean, checks if the graph is non-negative.
    %   is_weighted     -  boolean, checks if the graph is weighted.
    %   is_binary       -  boolean, checks if the graph is binary.
    %   is_directed     -  boolean, checks if the graph is directed.
    %   is_undirected   -  boolean, checks if the graph is undirected.
    %   getCompatibleMeasureList - returns a list with compatible measures.
    %   getCompatibleMeasureNumber - returns the number of compatible measures. 
    %
    % See also Graph, GraphBU, GraphWD, GraphWU.
    
    % Author: Emiliano Gomez & Giovanni Volpe
    % Date: 2020/02/03
    
    
    methods
        function g = GraphBD(A, varargin)
            % GRAPHBD(A) creates a GRAPHBD class with adjacency matrix A.
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % functions: DEDIAGONALIZE, SEMIPOSITIVE, BINARIZE. 
            % It calls the superclass constructor GRAPH.
            %
            % GRAPHBD(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...) creates
            % a GRAPHBD class with adjacency matrix A and it passes the
            % properties and values to the superclass as VARARGIN. 
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % functions: DEDIAGONALIZE, SEMIPOSITIVE, BINARIZE. 
            % It calls the superclass constructor GRAPH.
            %
            % See also Graph, GraphBU, GraphWD, GraphWU. 

            A = dediagonalize(A, varargin{:});  % removes self-connections by removing diagonal from adjacency matrix
            A = semipositivize(A, varargin{:});  % removes negative weights
            A = binarize(A, varargin{:});  % enforces binary adjacency matrix

            g = g@Graph(A, varargin{:});
        end
    end
    methods (Static)
        function graph_class = getClass()
            % GETCLASS returns the class of the graph.
            %
            % STRING = GETCLASS() returns the class, 'GraphBD'.
            %
            % See also getName().
            
            graph_class = 'GraphBD';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % STRING = GETCLASS() returns the name, 'Binary Directed Graph'.
            %
            % See also getClass().
            
            name = 'Binary Directed Graph';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % STRINGS = GETDESCRIPTION() returns the description of
            % GRAPHBD.
            %
            % See also getName().
            
            description = [ ...
                'In a binary directed (BD) graph, ' ...
                'the edges can be either 0 (absence of connection) ' ...
                'or 1 (existence of connection), ' ...
                'and they are directed.' ...
                ];
        end
        function bool = is_selfconnected()
            % IS_SELFCONNECTED checks if the graph is self connected.
            %
            % BOOL = IS_SELFCONNECTED() returns false for GRAPHBD.
            %
            % See also is_nonnegative().
            
            bool = false;
        end        
        function bool = is_nonnegative()
            % IS_NONNEGATIVE checks if the graph is nonnegative.
            %
            % BOOL = IS_NONNEGATIVE() returns true for GRAPHBD.
            %
            % See also is_selfconnected().
            
            bool = true;
        end        
        function bool = is_weighted()
            % IS_WEIGHTED checks if the graph is weighted.
            %
            % BOOL = IS_WEIGHTED() returns false for GRAPHBD.
            %
            % See also is_binary().
            
            bool = false;
        end
        function bool = is_binary()
            % IS_BINARY checks if the graph is binary.
            %
            % BOOL = IS_BINARY() returns true for GRAPHBD.
            %
            % See also is_weigthed().
            
            bool = true;
        end
        function bool = is_directed()
            % IS_DIRECTED checks if the graph is directed.
            %
            % BOOL = IS_DIRECTED() returns true for GRAPHBD.
            %
            % See also is_undirected().
            
            bool = true;
        end
        function bool = is_undirected()
            % IS_UNDIRECTED checks if the graph is undirected.
            %
            % BOOL = IS_UNDIRECTED() returns false for GRAPHBD.
            %
            % See also is_directed().
            
            bool = false;
        end        
        function list = getCompatibleMeasureList()
            % GETCOMPATIBLEMEASURELIST returns a list with compatible
            % measures.
            %
            % LIST = GETCOMPATIBLEMEASURELIST() returns a list with
            % compatible measures to the graph.
            %
            % See also getCompatibleMeasureNumber().
            
            list = Graph.getCompatibleMeasureList('GraphBD');
        end
        function n = getCompatibleMeasureNumber()
            % GETCOMPATIBLEMEASURENUMBER returns a number of the compatible
            % measures.
            %
            % N = GETCOMPATIBLEMEASURENUMBER() returns the number of 
            % compatible measures to the graph.
            %
            % See also getCompatibleMeasureList().
            
            n = Graph.getCompatibleMeasureNumber('GraphBD');
        end
    end
end
