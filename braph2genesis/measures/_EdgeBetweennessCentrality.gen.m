%% ¡header!
EdgeBetweennessCentrality < Measure (m, edge betweenness centrality) is the graph edge betweenness centrality.

%%% ¡description!
The edge betweenness centrality of a graph is the fraction of all shortest paths in the 
graph that pass through a given edge within a layer. Edges with high values 
of betweenness centrality participate in a large number of shortest paths.

%%% ¡shape!
shape = Measure.BINODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphBD
GraphBU
GraphWD
GraphWU
MultiplexBD
MultiplexBU
MultiplexWD
MultiplexWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the edge betweenness centrality.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
N = g.nodenumber();
L = g.layernumber();

edge_betweenness_centrality = cell(L, 1);
connectivity_type =  g.getConnectivityType(L);
for li = 1:1:g.layernumber()    
    Aii = A{li, li};
    connectivity_layer = connectivity_type(li, li);   
    
    if connectivity_layer == Graph.WEIGHTED  % weighted graphs
        edge_betweenness_centrality_layer = m.getWeightedCalculation(Aii);
    else  % binary graphs
        edge_betweenness_centrality_layer = m.getBinaryCalculation(Aii);
    end
    edge_betweenness_centrality(li) = {edge_betweenness_centrality_layer};
end

value = edge_betweenness_centrality;

%% ¡methods!
function binary_edge_betweenness_centrality = getBinaryCalculation(m, A)
% GETBINARYCALCULATION calculates the edge betweenness centrality value of a binary adjacency matrix
%
% BINARY_EDGE_BETWEENNESS_CENTRALITY = GETBINARYCALCULATION(m, A) returns the value
% of the edge betweenness centrality of a binary adjacency matrix A.

n = length(A);
BC = zeros(n,1);  % vertex betweenness
EBC = zeros(n);  % edge betweenness
for u=1:n
    D = false(1, n); D(u) = 1;  % distance from u
    NP = zeros(1, n); NP(u) = 1;  % number of paths from u
    P = false(n);  % predecessors
    Q = zeros(1, n); q = n;  % order of non-increasing distance
    Gu = A;
    V = u;
    while V
        Gu(:, V) = 0;  % remove remaining in-edges
        for v = V
            Q(q) = v; q = q-1;
            W = find(Gu(v, :));  % neighbours of v
            for w = W
                if D(w)
                    NP(w) = NP(w) + NP(v);  % NP(u->w) sum of old and new
                    P(w, v) = 1;  % v is a predecessor
                else
                    D(w) = 1;
                    NP(w) = NP(v);  % NP(u->w) = NP of new path
                    P(w, v) = 1;  % v is a predecessor
                end
            end
        end
        V = find(any(Gu(V, :), 1));
    end
    if ~all(D)  % if some vertices unreachable,
        Q(1:q) = find(~D);  % ...these are first-in-line
    end
    DP = zeros(n, 1);  % dependency
    for w=Q(1:n-1)
        BC(w) = BC(w) + DP(w);
        for v = find(P(w, :))
            DPvw = (1+DP(w)).*NP(v)./NP(w);
            DP(v) = DP(v) + DPvw;
            EBC(v, w) = EBC(v, w) + DPvw;
        end
    end
end
binary_edge_betweenness_centrality = EBC;
binary_edge_betweenness_centrality(isnan(binary_edge_betweenness_centrality)) = 0;  % Should return zeros, not NaN
end
function weighted_edge_betweenness_centrality = getWeightedCalculation(m, A)
% GETWEIGHTEDCALCULATION calculates the edge betweenness centrality value of a weighted adjacency matrix
%
% WEIGHTED_EDGE_BETWEENNESS_CENTRALITY  = GETWEIGHTEDCALCULATION(m, A)
% returns the value of the edge betweenness centrality of a weighted
% adjacency matrix A.

n = length(A);
BC = zeros(n,1);  % vertex betweenness
EBC = zeros(n);  % edge betweenness
for u=1:n
    D = inf(1, n); D(u) = 0;  % distance from u
    NP = zeros(1, n); NP(u) = 1;  % number of paths from u
    S = true(1, n);  % distance permanence (true is temporary)
    P = false(n);  % predecessors
    Q = zeros(1, n); q = n;  % order of non-increasing distance
    G1 = A;
    V = u;
    while 1
        S(V) = 0;  % distance u->V is now permanent
        G1(:, V) = 0;  % no in-edges as already shortest
        for v = V
            Q(q) = v; q = q-1;
            W = find(G1(v, :));  % neighbours of v
            for w = W
                Duw = D(v) + G1(v, w);  % path length to be tested
                if Duw < D(w)  % if new u->w shorter than old
                    D(w) = Duw;
                    NP(w) = NP(v);  % NP(u->w) = NP of new path
                    P(w,: ) = 0;
                    P(w, v) = 1;  % v is the only predecessor
                elseif Duw == D(w)  % if new u->w equal to old
                    NP(w) = NP(w) + NP(v);  % NP(u->w) sum of old and new
                    P(w, v) = 1;  % v is also a predecessor
                end
            end
        end
        minD = min(D(S));
        if isempty(minD), break  % all nodes reached, or
        elseif isinf(minD)  % ...some cannot be reached:
            Q(1:q) = find(isinf(D)); break	 % ...these are first-in-line
        end
        V = find(D == minD);
    end
    DP=zeros(n, 1);  % dependency
    for w = Q(1:n-1)
        BC(w) = BC(w) + DP(w);
        for v = find(P(w,:))
            DPvw = (1+DP(w)).*NP(v)./NP(w);
            DP(v) = DP(v) + DPvw;
            EBC(v, w) = EBC(v, w) + DPvw;
        end
    end
end
weighted_edge_betweenness_centrality = EBC;
weighted_edge_betweenness_centrality(isnan(weighted_edge_betweenness_centrality)) = 0;  % Should return zeros, not NaN
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
A = [
    0 1 1; 
    1 0 0; 
    1 0 0
    ];

known_edge_betweenness_centrality = {[
                                0 2 2;
                                2 0 0;
                                2 0 0
                                ]};
g = GraphBU('B', A);
edge_betweenness_centrality = EdgeBetweennessCentrality('G', g).get('M');

assert(isequal(edge_betweenness_centrality, known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentrality is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
A = [
    0 1 0; 
    1 0 0; 
    1 0 0
    ];

known_edge_betweenness_centrality = {[
                                0 2 0;
                                1 0 0;
                                2 0 0
                                ]};
g = GraphBD('B', A);
edge_betweenness_centrality = EdgeBetweennessCentrality('G', g).get('M');

assert(isequal(edge_betweenness_centrality, known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentrality is not being calculated correctly for GraphBD.')

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡code!
A11 = [
    0   1   1
    1   0   0
    1   0   0
    ];
A22 = [
    0   1   0
    1   0   1
    0   1   0
    ];
A = {A11 A22};

known_edge_betweenness_centrality = {[
                                      0 2 2;
                                      2 0 0;
                                      2 0 0
                                     ]
                                     [
                                      0 2 0;
                                      2 0 2;
                                      0 2 0
                                     ]};
g = MultiplexBU('B', A);
edge_betweenness_centrality = EdgeBetweennessCentrality('G', g).get('M');

assert(isequal(edge_betweenness_centrality, known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentrality is not being calculated correctly for MultiplexGraphBU.')

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡code!
A11 = [
    0   1   0
    1   0   0
    4   0   0
    ];

A22 = [
    0   1   0
    1   0   0
    0   4   0
    ];
A = {A11 A22};
known_edge_betweenness_centrality = {[
                                      0 2 0;
                                      1 0 0;
                                      2 0 0
                                     ]
                                     [
                                      0 1 0;
                                      2 0 0;
                                      0 2 0
                                     ]};
g = MultiplexWD('B', A);
edge_betweenness_centrality = EdgeBetweennessCentrality('G', g).get('M');
assert(isequal(edge_betweenness_centrality, known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentrality is not being calculated correctly for MultiplexGraphWD.')