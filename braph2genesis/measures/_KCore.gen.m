%% ¡header!
KCore < Measure (m, k-core) is the graph k-core.

%%% ¡description!
The k-core of a graph is the largest subnetwork comprising nodes of degree k or higher. 
k is set by the user; the default value is equal to 1.

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
MultiplexhWD
MultiplexWU

%% ¡props!
%%% ¡prop! 
KCoreThreshold (parameter, SCALAR) is the k-core threshold
%%%% ¡default!
1

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the k-core.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.layernumber();

kcore_threshold = m.get('KCoreThreshold');
assert(mod(kcore_threshold, 1) == 0, ...
    [BRAPH2.STR ':KCore:' BRAPH2.WRONG_INPUT], ...
    ['KCore threshold must be an integer value ' ...
    'while it is ' tostring(kcore_threshold)])

k_core = cell(L, 1);
directionality_type =  g.getDirectionalityType(L);
for li = 1:1:L    
    Aii = A{li, li};
    directionality_layer = directionality_type(li, li);   
    
    iter = 0;
    subAii = binarize(Aii);
    while 1
        % get degrees of matrix
        if directionality_layer == Graph.UNDIRECTED  % undirected graphs
            deg = sum(subAii, 1)';  % degree undirected graphs
        else
            deg = (sum(subAii, 1)' + sum(subAii, 2));  % degree directed
        end
        
        % find nodes with degree < k
        low_k_nodes = find((deg < kcore_threshold) & (deg > 0));
        
        % if none found -> stop
        if (isempty(low_k_nodes)) break; end; %#ok<SEPEX>
        
        % peel away found nodes
        iter = iter + 1;
        subAii(low_k_nodes, :) = 0;
        subAii(:, low_k_nodes) = 0;
    end
    k_core(li) = {subAii};  % add k-core of layer li
end

value = k_core;

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

known_kcore = {[
                0  1  1  0;
                1  0  1  0;
                1  1  0  0;
                0  0  0  0
                ]};

g = GraphBU('B', A);
kcore = KCore('G', g, 'KCoreThreshold', 2).get('M');

assert(isequal(kcore, known_kcore), ...
    [BRAPH2.STR ':KCore:' BRAPH2.BUG_ERR], ...
    'KCore is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
A = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_kcore = {[
                0  1  1  0;
                1  0  1  0;
                1  1  0  0;
                0  0  0  0
                ]};

g = GraphBD('B', A);
kcore = KCore('G', g, 'KCoreThreshold', 4).get('M');

assert(isequal(kcore, known_kcore), ...
    [BRAPH2.STR ':KCore:' BRAPH2.BUG_ERR], ...
    'KCore is not being calculated correctly for GraphBD.')

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
             
known_kcore(1) = {[
                0  1  1  0;
                1  0  1  0;
                1  1  0  0;
                0  0  0  0
                ]};
known_kcore(2, 1) = {[
                0  1  1  1;
                1  0  1  1;
                1  1  0  0;
                1  1  0  0
                ]};            

g = MultiplexWU('B', A);
kcore = KCore('G', g, 'KCoreThreshold', 2).get('M');

assert(isequal(kcore, known_kcore), ...
    [BRAPH2.STR ':KCore:' BRAPH2.BUG_ERR], ...
    'KCore is not being calculated correctly for MultiplexGraphWU.')

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡code!
A11 = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];

A22 = [
    0   1   1   .1; 
    .2  0   1   1; 
    1   1   0   0;
    0   .3  .7  0
    ];
A = {A11 A22};

known_kcore(1) = {[
                0  1  1  0;
                1  0  1  0;
                1  1  0  0;
                0  0  0  0
                ]};
known_kcore(2, 1) = {[
                0  1  1  1;
                1  0  1  1;
                1  1  0  0;
                0  1  1  0
                ]};            

g = MultiplexWD('B', A);
kcore = KCore('G', g, 'KCoreThreshold', 4).get('M');

assert(isequal(kcore, known_kcore), ...
    [BRAPH2.STR ':KCore:' BRAPH2.BUG_ERR], ...
    'KCore is not being calculated correctly for MultiplexGraphWD.')
