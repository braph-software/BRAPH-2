classdef GraphWD < Graph
    methods
        function g = GraphWD(A, varargin)

            A = remove_diagonal(A);  % removes self-connections by removing diagonal from adjacency matrix
            A = remove_negative_weights(A, varargin{:});  % removes negative weights

            g = g@Graph(A, varargin{:});
        end
    end
    methods (Static)
        function graph_class = getClass()
            graph_class = 'GraphWD';
        end
        function name = getName()
            name = 'Weighted Directed Graph';
        end
        function description = getDescription()
            description = [ ...
                'In a weighted directed (WD) graph, ' ...
                'the edges are associated with a non-negative real number ' ...
                'indicating the strength of the connection, ' ...
                'and they are directed.' ...
                ];
        end
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
            bool = true;
        end
        function bool = is_undirected()
            bool = false;
        end        
    end
end