classdef GraphWD < Graph
    properties
        L  % edge length matrix
        B  % number of edges in shortest weighted path matrix
    end
    methods
        function g = GraphWD(A, varargin)

            A = dediagonalize(A, varargin{:});  % removes self-connections by removing diagonal from adjacency matrix
            A = semipositivize(A, varargin{:});  % removes negative weights
            A = standardize(A, varargin{:});  % ensures all weights are between 0 and 1

            g = g@Graph(A, varargin{:});
        end
    end
    methods (Access=protected)
        function [D, L, B] = distance(g)
            % The algorithm used is Dijkstra's algorithm.
            L = g.getA();
            ind = L~=0;
            L(ind) = L(ind).^-1;
            
            n = length(L);
            D = inf(n);
            D(1:n+1:end) = 0;  % distance matrix
            B = zeros(n);  % number of edges matrix
            
            for u = 1:n
                S = true(1,n);  % distance permanence (true is temporary)
                L1 = L;
                V = u;
                
                while 1
                    S(V) = 0;  % distance u->V is now permanent
                    L1(:,V) = 0;  % no in-edges as already shortest
                    
                    for v = V
                        T = find(L1(v,:));  % neighbours of shortest nodes
                        [d wi] = min([D(u,T);D(u,v)+L1(v,T)]);
                        D(u,T) = d;  % smallest of old/new path lengths
                        ind = T(wi==2);  % indices of lengthened paths
                        B(u,ind) = B(u,v)+1;  % increment no. of edges in lengthened paths
                    end
                    
                    minD = min(D(u,S));
                    if isempty(minD) || isinf(minD),  % isempty: all nodes reached;
                        break,  % isinf: some nodes cannot be reached
                    end;
                    
                    V = find(D(u,:)==minD);
                end
            end
            
            g.D = D;
            g.L = L;
            g.B = B;
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
                'the edges are associated with a real number between 0 and 1' ...
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
        function list = getCompatibleMeasureList()
            list = Graph.getCompatibleMeasureList('GraphWD');
        end
        function n = getCompatibleMeasureNumber()
            n = Graph.getCompatibleMeasureNumber('GraphWD');
        end
    end
end
