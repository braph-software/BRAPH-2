classdef GraphBU < GraphBD
    methods
        function g = GraphBU(A, varargin)

            A = symmetrize(A, varargin{:});  % enforces symmetry of adjacency matrix

            g = g@GraphBD(A, varargin{:});
        end
    end
    methods (Static)
        function name = getName()
            name = 'Binary Undirected Graph';
        end
        function description = getDescription()
            description = [ ...
                'In a binary undirected (BU) graph, ' ...
                'the edges can be either 0 (absence of connection) ' ...
                'or 1 (existence of connection), ' ...
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
    end
end