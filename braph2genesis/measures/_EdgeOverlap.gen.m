%% ¡header!
EdgeOverlap < Measure (m, edge overlap) is the graph edge overlap.

%%% ¡description!
The edge overlap of a graph is the fraction of layers in which an edge between
a pair of nodes exists. Connection weights are ignored in calculations.
    
%%% ¡shape!
shape = Measure.BINODAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexBD
MultiplexBU
MultiplexBUD
MultiplexBUT
MultiplexWD
MultiplexWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the edge overlap.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
[l, ls] = g.layernumber();

if l == 0
    value = {};
else
    A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
    N = g.nodenumber();
    edge_overlap = cell(length(ls), 1);   
    count = 1;
    for i = 1:1:length(ls)
        edge_overlap_partition = zeros(N(1));
        for li = count:1:ls(i) + count - 1
            Aii = A{li, li};
            Aii = binarize(Aii);  % binarizes the adjacency matrix
            edge_overlap_partition = edge_overlap_partition + Aii;
        end
        count = count + ls(i);
        edge_overlap(i) = {edge_overlap_partition / ls(i)};
    end
    value = edge_overlap;
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡code!
B11 = [
    0   1   1
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   1
    0   1   0
    ];
B = {B11 B22};

known_edge_overlap = {[
    0   1   .5
    1   0   .5
    .5  .5  0
    ]};

g = MultiplexBU('B', B);
edge_overlap = EdgeOverlap('G', g);
 
assert(isequal(edge_overlap.get('M'), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for MultiplexBU.')

%%% ¡test!
%%%% ¡name!
MultiplexBUT
%%%% ¡code!
B11 = [
    0   1   1
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   1
    0   1   0
    ];
B = {B11 B22};

known_edge_overlap_1 = [
    0   1   .5
    1   0   .5
    .5  .5  0
    ];
known_edge_overlap = {
                      known_edge_overlap_1
                      zeros(3)
                      };

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);
edge_overlap = EdgeOverlap('G', g);
 
assert(isequal(edge_overlap.get('M'), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for MultiplexBUT.')


%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡code!
B11 = [
    0   1   0
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   1
    0   1   0
    ];
B = {B11 B22};

known_edge_overlap = {[
    0   1   0
    1   0   .5
    .5  .5  0
    ]};

g = MultiplexBD('B', B);
edge_overlap = EdgeOverlap('G', g);

assert(isequal(edge_overlap.get('M'), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for MultiplexBD')

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡code!
B11 = [
    0   .2  1
    .2  0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   .3
    0   .3  0
    ];
B = {B11 B22};

known_edge_overlap = {[
    0   1   .5
    1   0   .5
    .5  .5  0
    ]};

g = MultiplexWU('B', B);
edge_overlap = EdgeOverlap('G', g);

assert(isequal(edge_overlap.get('M'), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for MultiplexWU')

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡code!
B11 = [
    0   .2  0
    .2  0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   .3
    0   .3  0
    ];
B = {B11 B22};

known_edge_overlap = {[
    0   1   0
    1   0   .5
    .5  .5  0
    ]};

g = MultiplexWD('B', B);
edge_overlap = EdgeOverlap('G', g);

assert(isequal(edge_overlap.get('M'), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for MultiplexWD')