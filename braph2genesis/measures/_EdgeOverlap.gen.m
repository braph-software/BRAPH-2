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
MultiplexGraphBD
MultiplexGraphBU
MultiplexGraphWD
MultiplexWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the edge overlap.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
L = g.layernumber();

if L == 0
    value = {};
else
    A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
    N = g.nodenumber();
    edge_overlap = zeros(N(1));

    for li = 1:1:L
        Aii = A{li, li};
        Aii = binarize(Aii);  % binarizes the adjacency matrix
        edge_overlap = edge_overlap + Aii;
    end
    value = {edge_overlap / L};
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
MultiplexGraphBU
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

g = MultiplexGraphBU('B', B);
edge_overlap = EdgeOverlap('G', g);
 
assert(isequal(edge_overlap.get('M'), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for MultiplexGraphBU.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphBD
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

g = MultiplexGraphBD('B', B);
edge_overlap = EdgeOverlap('G', g);

assert(isequal(edge_overlap.get('M'), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for MultiplexGraphBD')

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
MultiplexGraphWD
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

g = MultiplexGraphWD('B', B);
edge_overlap = EdgeOverlap('G', g);

assert(isequal(edge_overlap.get('M'), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for MultiplexGraphWD')