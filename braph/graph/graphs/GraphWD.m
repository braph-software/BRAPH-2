classdef GraphWD < Graph
    % GraphWD < Graph : Creates GraphWD.
    %   GraphWD inherits methods from Graph. GraphWD overrides the static
    %   methods from Graph. 
    %   
    % GraphWD methods:
    %   GraphWD    -    constructor.
    %
    % GraphWD methods (static):
    %   getClass   -    return the class type GraphWD.
    %   getName    -    return the complete name of GraphWD.
    %   getDescription  -   return the description of GraphWD.
    %   is_selfconnected     -  boolean, checks if the graph is self
    %                           connected.
    %   is_nonnegative       -  boolean, checks if the graph is non
    %                           negative.
    %   is_weighted          -  boolean, checks if the graph is weighted.
    %   is_binary            -  boolean, checks if the graph is binary.
    %   is_directed          -  boolean, checks if the graph is directed.
    %   is_undirected        -  boolean, checks if the graph is undirected.
    %   getCompatibleMeasureList   - returns a list with compatible
    %                                measures.
    %   getCompatibleMeasureNumber - returns the number of compatible 
    %                                measures. 
    %
    % See also Graph, GraphBU, GraphBD, GraphWU.

    % Author: Emiliano Gomez & Giovanni Volpe
    % Date: 2020/02/03
    
    methods
        function g = GraphWD(A, varargin)
            % GRAPHWD(A) creates a GRAPHWD class with adjacency matrix A.
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % functions: DEDIAGONALIZE, SEMIPOSITIVE, STANDARDIZE. 
            % It calls the superclass constructor GRAPH.
            %
            % GRAPHWD(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...) creates
            % a GRAPHWD class with adjacency matrix A and it passes the
            % properties and values to the superclass as VARARGIN. 
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % functions: DEDIAGONALIZE, SEMIPOSITIVE, STANDARDIZE. 
            % It calls the superclass constructor GRAPH.
            %
            % See also Graph, GraphBU, GraphBD, GraphWU. 

            A = dediagonalize(A, varargin{:});  % removes self-connections by removing diagonal from adjacency matrix
            A = semipositivize(A, varargin{:});  % removes negative weights
            A = standardize(A, varargin{:});  % ensures all weights are between 0 and 1

            g = g@Graph(A, varargin{:});
        end
    end
    methods (Static)
        function graph_class = getClass()
            % GETCLASS returns the class of the graph.
            %
            % STRING = GETCLASS() returns the class, 'GRAPHWD'.
            %
            % See also getName().
            
            graph_class = 'GraphWD';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % STRING = GETCLASS() returns the name, 'Weighted Directed Graph'.
            %
            % See also getClass().
            
            name = 'Weighted Directed Graph';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % STRINGS = GETDESCRIPTION() returns the description of
            % GRAPHWD.
            %
            % See also getName()
            
            description = [ ...
                'In a weighted directed (WD) graph, ' ...
                'the edges are associated with a real number between 0 and 1' ...
                'indicating the strength of the connection, ' ...
                'and they are directed.' ...
                ];
        end
        function bool = is_selfconnected()
            % IS_SELFCONNECTED checks if the graph is self connected.
            %
            % BOOL = IS_SELFCONNECTED() returns false for GRAPHWD.
            %
            % See also is_nonnegative().
            
            bool = false;
        end        
        function bool = is_nonnegative()
            % IS_NONNEGATIVE checks if the graph is nonnegative.
            %
            % BOOL = IS_NONNEGATIVE() returns true for GRAPHWD.
            %
            % See also is_selfconnected().
            
            bool = true;
        end        
        function bool = is_weighted()
            % IS_WEIGHTED checks if the graph is weighted.
            %
            % BOOL = IS_WEIGHTED() returns true for GRAPHWD.
            %
            % See also is_binary().
            
            bool = true;
        end
        function bool = is_binary()
            % IS_BINARY checks if the graph is binary.
            %
            % BOOL = IS_BINARY() returns false for GRAPHWD.
            %
            % See also is_weigthed().
            
            bool = false;
        end
        function bool = is_directed()
            % IS_DIRECTED checks if the graph is directed.
            %
            % BOOL = IS_DIRECTED() returns true for GRAPHWD.
            %
            % See also is_undirected().
            
            bool = true;
        end
        function bool = is_undirected()
            % IS_UNDIRECTED checks if the graph is undirected.
            %
            % BOOL = IS_UNDIRECTED() returns false for GRAPHWD.
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
            
            list = Graph.getCompatibleMeasureList('GraphWD');
        end
        function n = getCompatibleMeasureNumber()
            % GETCOMPATIBLEMEASURENUMBER returns a number of the compatible
            % measures.
            %
            % N = GETCOMPATIBLEMEASURENUMBER() returns the number of 
            % compatible measures to the graph.
            %
            % See also getCompatibleMeasureList().
            
            n = Graph.getCompatibleMeasureNumber('GraphWD');
        end
    end
end
