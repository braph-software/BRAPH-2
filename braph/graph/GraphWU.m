classdef GraphWU < Graph
    methods
        function g = GraphWU(A, varargin)
            
            A = removediagonal(A); % removes self-connections by removing diagonal from adjacency matrix
            A = remove_negative_weights(A, varargin{:});  % removes negative weights
            A = symmetrize(A, varargin{:});  % enforces symmetry of adjacency matrix
            
            g = g@Graph(A, varargin{:});
        end
    end
    methods (Static)
        function bool = is_selfconnected()
            bool = false;
        end        
        function bool = is_nonnegative()
            bool = true;
        end        
        function bool = is_weighted()
            bool = true;
        end
        function bool = is_binary()
            bool = false;
        end
        function bool = is_directed()
            bool = false;
        end
        function bool = is_undirected()
            bool = true;
        end
    end
end