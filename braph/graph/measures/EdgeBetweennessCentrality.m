classdef EdgeBetweennessCentrality < Measure
    methods
        function m = EdgeBetweennessCentrality(g, varargin)
            
            settings = clean_varargin({}, varargin{:});
            
            m = m@Measure(g, settings{:});
        end
    end
    methods (Access=protected)
        function edge_betweenness_centrality = calculate(m)
            g = m.getGraph();
            A = g.getA();
            n=length(A);
            BC=zeros(n,1);                  %vertex betweenness
            EBC = zeros(n);                   %edge betweenness
            
            %BCT code  Mika Rubinov, UNSW/U Cambridge, 2007-2012
            
            if isa(g, 'GraphBD') || isa(g, 'GraphBU')         
                for u=1:n
                    D = false(1, n); D(u) = 1;      	%distance from u
                    NP = zeros(1, n); NP(u) = 1;     %number of paths from u
                    P = false(n);                 %predecessors
                    Q = zeros(1, n); q = n;          %order of non-increasing distance
                    Gu = A;
                    V = u;
                    while V
                        Gu(:, V) = 0;              %remove remaining in-edges
                        for v = V
                            Q(q) = v; q = q-1;
                            W = find(Gu(v, :));                %neighbours of v
                            for w = W
                                if D(w)
                                    NP(w) = NP(w) + NP(v);      %NP(u->w) sum of old and new
                                    P(w, v) = 1;               %v is a predecessor
                                else
                                    D(w) = 1;
                                    NP(w) = NP(v);            %NP(u->w) = NP of new path
                                    P(w, v) = 1;               %v is a predecessor
                                end
                            end
                        end
                        V = find(any(Gu(V, :), 1));
                    end
                    if ~all(D)                              %if some vertices unreachable,
                        Q(1:q) = find(~D);                    %...these are first-in-line
                    end
                    
                    DP = zeros(n, 1);                          %dependency
                    for w=Q(1:n-1)
                        BC(w) = BC(w) + DP(w);
                        for v = find(P(w, :))
                            DPvw = (1+DP(w)).*NP(v)./NP(w);
                            DP(v) = DP(v) + DPvw;
                            EBC(v, w) = EBC(v, w) + DPvw;
                        end
                    end
                end
                edge_betweenness_centrality = EBC';                
                % Weighted graphs WU and WD
            elseif isa(g, 'GraphWU') || isa(g, 'GraphWD')
                for u=1:n
                    D = inf(1, n); D(u) = 0;         %distance from u
                    NP = zeros(1, n); NP(u) = 1;     %number of paths from u
                    S = true(1, n);                %distance permanence (true is temporary)
                    P = false(n);                 %predecessors
                    Q = zeros(1, n); q = n;          %order of non-increasing distance
                    
                    G1 = A;
                    V = u;
                    while 1
                        S(V) = 0;                 %distance u->V is now permanent
                        G1(:, V) = 0;              %no in-edges as already shortest
                        for v = V
                            Q(q) = v; q = q-1;
                            W = find(G1(v, :));                %neighbours of v
                            for w = W
                                Duw = D(v) + G1(v, w);           %path length to be tested
                                if Duw < D(w)                 %if new u->w shorter than old
                                    D(w) = Duw;
                                    NP(w) = NP(v);            %NP(u->w) = NP of new path
                                    P(w,: ) = 0;
                                    P(w, v) = 1;               %v is the only predecessor
                                elseif Duw == D(w)            %if new u->w equal to old
                                    NP(w) = NP(w) + NP(v);      %NP(u->w) sum of old and new
                                    P(w, v) = 1;               %v is also a predecessor
                                end
                            end
                        end
                        
                        minD = min(D(S));
                        if isempty(minD), break             %all nodes reached, or
                        elseif isinf(minD)                  %...some cannot be reached:
                            Q(1:q) = find(isinf(D)); break	%...these are first-in-line
                        end
                        V = find(D == minD);
                    end
                    
                    DP=zeros(n, 1);                          %dependency
                    for w = Q(1:n-1)
                        BC(w) = BC(w) + DP(w);
                        for v = find(P(w,:))
                            DPvw = (1+DP(w)).*NP(v)./NP(w);
                            DP(v) = DP(v) + DPvw;
                            EBC(v, w) = EBC(v, w) + DPvw;
                        end
                    end
                end
                edge_betweenness_centrality = EBC';
            end
            edge_betweenness_centrality(isnan(edge_betweenness_centrality)) = 0; % Should return zeros, not NaN
        end
    end
    methods (Static)
        function measure_class = getClass()
            measure_class = 'EdgeBetweennessCentrality';
        end
        function name = getName()
            name = 'Edge Betweenness-Centrality';
        end
        function description = getDescription()
            description = [ ...
                'The edge betweenness centrality of a graph is ' ...
                'the fraction of all shortest paths in the ' ...
                'graph that pass through a given edge. ' ...
                'Edges with high values of betweenness centrality ' ...
                'participate in a large number of shortest paths. ' ...
                ];
        end
        function bool = is_global()
            bool = false;
        end
        function bool = is_nodal()
            bool = true;
        end
        function bool = is_binodal()
            bool = false;
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
            n = Measure.getCompatibleGraphNumber('EdgeBetweennessCentrality');
        end
    end
end
