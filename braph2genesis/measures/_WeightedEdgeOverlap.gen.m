%% ¡header!
WeightedEdgeOverlap < Measure (m, weighted edge overlap) is the graph weighted edge overlap.

%%% ¡description!
The weighted edge overlap of a graph is the average weight of an edge 
across all layers.
    
%%% ¡shape!
shape = Measure.BINODAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexWD
MultiplexWU
OrderedMultiplexWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the weighted edge overlap.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
L = g.layernumber();

if L == 0
    value = {};
else
    A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
    N = g.nodenumber();
    weighted_edge_overlap = zeros(N(1));

    for li = 1:1:L
        Aii = A{li, li};
        weighted_edge_overlap = weighted_edge_overlap + Aii;
    end
    value = {weighted_edge_overlap / L};
end

%% ¡tests!

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
    1   0   .4
    0   .4  0
    ];
B = {B11 B22};

known_weighted_edge_overlap = {[
    0   .6  0.5
    .6   0  .2
    .5  .2  0
    ]};

g = MultiplexWU('B', B);
weighted_edge_overlap = WeightedEdgeOverlap('G', g);

assert(isequal(weighted_edge_overlap.get('M'), known_weighted_edge_overlap), ...
    [BRAPH2.STR ':WeightedEdgeOverlap:' BRAPH2.BUG_ERR], ...
    'WeightedEdgeOverlap is not being calculated correctly for MultiplexWU')

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
    1   0   .4
    0   .4  0
    ];
B = {B11 B22};

known_weighted_edge_overlap = {[
    0   .6  0
    .6  0   .2
    .5  .2  0
    ]};

g = MultiplexWD('B', B);
weighted_edge_overlap = WeightedEdgeOverlap('G', g);

assert(isequal(weighted_edge_overlap.get('M'), known_weighted_edge_overlap), ...
    [BRAPH2.STR ':WeightedEdgeOverlap:' BRAPH2.BUG_ERR], ...
    'WeightedEdgeOverlap is not being calculated correctly for MultiplexWD')