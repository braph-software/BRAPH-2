classdef GraphBU < GraphBD
    % GraphBD < GraphBD : Creates GraphBU.
    %   GraphBU inherits methods from GraphBD. GraphBU overrides the static
    %   methods from GraphBD. 
    %   
    % GraphBU methods:
    %   GraphBU    -    constructor.
    %
    % GraphBU methods (static):
    %   getClass   -    return the class type GraphBU.
    %   getName    -    return the complete name of GraphBU.
    %   getDescription  -   return the description of GraphBU.
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
    % See also Graph, GraphBD, GraphWD, GraphWU.

    % Author: Emiliano Gomez & Giovanni Volpe
    % Date: 2020/02/03
    
    methods
        function g = GraphBU(A, varargin)
            % GRAPHBU(A) creates a GRAPHBU class with adjacency matrix A.
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % functions:  SYMMETRIZE. 
            % It calls the superclass constructor GRAPHBD.
            %
            % GRAPHBU(A, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ...) creates
            % a GRAPHBU class with adjacency matrix A and it passes the
            % properties and values to the superclass as VARARGIN. 
            % This function is the constructor, it initializes the class by
            % operating the adjacency matrix A with the following
            % functions: DEDIAGONALIZE, SEMIPOSITIVE, BINARIZE. 
            % It calls the superclass constructor GRAPHBD.
            %
            % See also Graph, GraphBD, GraphWD, GraphWU.

            A = symmetrize(A, varargin{:});  % enforces symmetry of adjacency matrix

            g = g@GraphBD(A, varargin{:});
        end
    end
    methods (Static)
        function graph_class = getClass()
            % GETCLASS returns the class of the graph.
            %
            % STRING = GETCLASS() returns the class, 'GRAPHBU'.
            %
            % See also getName().
            
            graph_class = 'GraphBU';
        end
        function name = getName()
            % GETNAME returns the name of the graph.
            %
            % STRING = GETCLASS() returns the name, 'Binary Undirected Graph'.
            %
            % See also getClass().
            
            name = 'Binary Undirected Graph';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the graph.
            %
            % STRINGS = GETDESCRIPTION() returns the description of
            % GRAPHBU.
            %
            % See also getName().
            
            description = [ ...
                'In a binary undirected (BU) graph, ' ...
                'the edges can be either 0 (absence of connection) ' ...
                'or 1 (existence of connection), ' ...
                'and they are undirected.' ...
                'The connectivity matrix is symmetric.' ...
                ];
        end
        function bool = is_directed()
            % IS_DIRECTED checks if the graph is directed.
            %
            % BOOL = IS_DIRECTED() returns false for GRAPHBU.
            %
            % See also is_undirected().
            
            bool = false;
        end
        function bool = is_undirected()
            % IS_UNDIRECTED checks if the graph is directed.
            %
            % BOOL = IS_UNDIRECTED() returns true for GRAPHBU.
            %
            % See also is_directed().
            
            bool = true;
        end        
        function list = getCompatibleMeasureList()
            % GETCOMPATIBLEMEASURELIST returns a list with compatible
            % measures.
            %
            % LIST = GETCOMPATIBLEMEASURELIST() returns a list with
            % compatible measures to the graph.
            %
            % See also getCompatibleMeasureNumber().
            
            list = Graph.getCompatibleMeasureList('GraphBU');
        end
        function n = getCompatibleMeasureNumber()
            % GETCOMPATIBLEMEASURENUMBER returns a number of the compatible
            % measures.
            %
            % N = GETCOMPATIBLEMEASURENUMBER() returns the number of 
            % compatible measures to the graph.
            %
            % See also getCompatibleMeasureList().
            
            n = Graph.getCompatibleMeasureNumber('GraphBU');
        end
    end
end