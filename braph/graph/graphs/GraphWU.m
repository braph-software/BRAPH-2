classdef GraphWU < GraphWD
    methods
        function g = GraphWU(A, varargin)
            
            A = symmetrize(A, varargin{:});  % enforces symmetry of adjacency matrix
            
            g = g@GraphWD(A, varargin{:});
        end
    end
    methods (Static)
        function graph_class = getClass()
            graph_class = 'GraphWU';
        end
        function name = getName()
            name = 'Weighted Undirected Graph';
        end
        function description = getDescription()
            description = [ ...
                'In a weighted undirected (WU) graph, ' ...
                'the edges are associated with a non-negative real number ' ...
                'indicating the strength of the connection, ' ...
                'and they are undirected.' ...
                'The connectivity matrix is symmetric.' ...
                ];
        end
        function bool = is_directed()
            bool = false;
        end
        function bool = is_undirected()
            bool = true;
        end
        function list = getCompatibleMeasureList()
            list = Graph.getCompatibleMeasureList('GraphWU');
        end
        function n = getCompatibleMeasureNumber()
            n = Graph.getCompatibleMeasureNumber('GraphWU');
        end
    end
end