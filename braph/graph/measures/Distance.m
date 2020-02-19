classdef Distance < Measure
    properties
        B  % number of edges matrix 
    end
    methods
        function m = Distance(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function D = calculate(m)
            g = m.getGraph();
            graph_class = g.getClass();
            A = g.getA();
            
            if isequal(graph_class, 'GraphWD') || isequal(graph_class, 'GraphWU')
                ind = A~=0;
                A(ind) = A(ind).^-1;
                n = length(A);
                D = inf(n);
                D(1:n+1:end) = 0;  % distance matrix
                B = zeros(n);  % number of edges matrix
                
                for u = 1:n
                    S = true(1, n);  % distance permanence (true is temporary)
                    L1 = A;
                    V = u;
                    
                    while 1
                        S(V) = 0;  % distance u->V is now permanent
                        L1(:, V) = 0;  % no in-edges as already shortest
                        
                        for v = V
                            T = find(L1(v, :));  % neighbours of shortest nodes
                            [d, wi] = min([D(u, T);D(u, v)+L1(v, T)]);
                            D(u, T) = d;  % smallest of old/new path lengths
                            ind = T(wi==2);  % indices of lengthened paths
                            B(u, ind) = B(u, v) + 1;  % increment no. of edges in lengthened paths
                        end
                        
                        minD = min(D(u, S));
                        if isempty(minD) || isinf(minD)  % isempty: all nodes reached;
                            break  % isinf: some nodes cannot be reached
                        end
                        
                        V = find(D(u,:)==minD);
                    end
                end
                m.B = B;
            else
                l = 1;  % path length
                D = A;  % distance matrix
                
                Lpath = A;
                Idx = true;
                while any(Idx(:))
                    l = l+1;
                    Lpath = Lpath * A;
                    Idx = (Lpath ~= 0) & (D == 0);
                    D(Idx) = l;
                end
                
                D(~D) = inf;  % assign inf to disconnected nodes
                D = dediagonalize(D);  % assign 0 to the diagonal
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'Distance';
        end
        function name = getName()
            name = 'Distance';
        end
        function description = getDescription()
            description = [ ...
                'The distance of a graph is ' ...
                'the shortest path between all pairs of nodes in the graph. ' ...
                ];
        end
        function bool = is_global()
            bool = false;
        end
        function bool = is_nodal()
            bool = false;
        end
        function bool = is_binodal()
            bool = true;
        end
        function list = getCompatibleGraphList()
            list = { ...
                'GraphBD', ...
                'GraphBU', ...
                'GraphWD', ...
                'GraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('Distance');
        end
    end
end
