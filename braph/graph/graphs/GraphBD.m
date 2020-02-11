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
        function graph_class = getClass()
            graph_class = 'GraphBD';
        end
        function name = getName()
            name = 'Binary Directed Graph';
        end
        function description = getDescription()
            description = [ ...
                'In a binary directed (BD) graph, ' ...
                'the edges can be either 0 (absence of connection) ' ...
                'or 1 (existence of connection), ' ...
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
        function list = getCompatibleMeasureList()
            list = Graph.getCompatibleMeasureList('GraphBD');
        end
        function n = getCompatibleMeasureNumber()
            n = Graph.getCompatibleMeasureNumber('GraphBD');
        end
    end
end