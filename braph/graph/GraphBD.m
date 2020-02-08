classdef GraphBD < Graph
    methods
        function g = GraphBD(A, varargin)

            A = remove_diagonal(A);  % removes self-connections by removing diagonal from adjacency matrix
            A = remove_negative_weights(A, varargin{:});  % removes negative weights
            A = binarize(A);  % enforces binary adjacency matrix

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
            bool = false;
        end
        function bool = is_binary()
            bool = true;
        end
        function bool = is_directed()
            bool = true;
        end
        function bool = is_undirected()
            bool = false;
        end        
    end
end