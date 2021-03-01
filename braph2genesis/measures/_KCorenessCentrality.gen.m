%% ¡header!
KCorenessCentrality < Measure (m, k-coreness centrality) is the graph k-coreness centrality.

%%% ¡description!
The k-coreness centrality of a node is k if the node belongs to the k-core
but not to the (k+1)-core.

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWU
GraphWD
GraphBU
GraphBD
MultiplexWU
MultiplexWD
MultiplexBU
MultiplexBD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the k-coreness centrality.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.layernumber();
N = g.nodenumber();

k_coreness_centrality = cell(L, 1);
directionality_type =  g.getDirectionalityType(L);
for li = 1:1:L   
   
    Aii = A{li, li};
    directionality_layer = directionality_type(li, li);

    coreness = zeros(1, N(1));
    for k = 1:N(1)
        k_core = m.calculate_kcore(Aii, k, directionality_layer);
        ss = sum(k_core) > 0;
        coreness(ss) = k;
    end
    k_coreness_centrality(li) = {coreness'};
end
value = k_coreness_centrality;

%% ¡methods!
function k_core = calculate_kcore(m, A, k, directionality_layer)
% CALCULATEKCORE calculates the k-core value of an adjacency matrix
%
% KCORE = CALCULATEKCORE(M, A, k, directionality_layer) returns
% the value of the k-core of an adjacency matrix

iter = 0;
subAii = binarize(A);
while 1
    % get degrees of matrix
    if directionality_layer == Graph.UNDIRECTED  % undirected graphs
        deg = sum(subAii, 1)';  % degree undirected graphs
    else
        deg = (sum(subAii, 1)' + sum(subAii, 2));  % degree directed
    end
    
    % find nodes with degree < k
    low_k_nodes = find((deg < k) & (deg > 0));
    
    % if none found -> stop
    if (isempty(low_k_nodes)) break; end; %#ok<SEPEX>
    
    % peel away found nodes
    iter = iter + 1;
    subAii(low_k_nodes, :) = 0;
    subAii(:, low_k_nodes) = 0;
end
k_core = subAii;  % add k-core of layer li
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
A = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_k_coreness_centrality = {[2 2 2 1]'};

g = GraphBU('B', A);
k_coreness_centrality = KCorenessCentrality('G', g).get('M');

assert(isequal(k_coreness_centrality, known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentrality:' BRAPH2.BUG_ERR], ...
    'KCorenessCentrality is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!
A = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];

known_k_coreness_centrality = {[4 4 4 3]'};

g = GraphWD('B', A);
k_coreness_centrality = KCorenessCentrality('G', g).get('M');

assert(isequal(k_coreness_centrality, known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentrality:' BRAPH2.BUG_ERR], ...
    'KCorenessCentrality is not being calculated correctly for GraphWD.')

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡code!
A11 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

A22 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  1  0
    ];
A = {A11 A22};

known_k_coreness_centrality = {
                        [4 4 4 3]'
                        [4 4 4 4]'
                        };

g = MultiplexBD('B', A);
k_coreness_centrality = KCorenessCentrality('G', g).get('M');

assert(isequal(k_coreness_centrality, known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentrality:' BRAPH2.BUG_ERR], ...
    'KCorenessCentrality is not being calculated correctly for MultiplexGraphBD.')

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡code!
A11 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

A22 = [
    0   .1  1  1; 
    .1  0   1  .8; 
    1   1   0  0;
    1   .8  0  0
    ];
A = {A11 A22};
             
known_k_coreness_centrality = {
                        [2 2 2 1]'
                        [2 2 2 2]'
                        };        

g = MultiplexWU('B', A);
k_coreness_centrality = KCorenessCentrality('G', g).get('M');

assert(isequal(k_coreness_centrality, known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentrality:' BRAPH2.BUG_ERR], ...
    'KCorenessCentrality is not being calculated correctly for MultiplexGraphWU.')