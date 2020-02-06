classdef GraphWU < GraphWD
    methods
        function g = GraphWU(A, varargin)
            
            A = symmetrize(A, varargin{:});  % enforces symmetry of adjacency matrix
            
            g = g@GraphWD(A, varargin{:});
        end
    end
    methods (Static)
        function bool = is_directed()
            bool = false;
        end
        function bool = is_undirected()
            bool = true;
        end
    end
end