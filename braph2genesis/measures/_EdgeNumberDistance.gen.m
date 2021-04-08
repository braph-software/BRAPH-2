%% ¡header!
EdgeNumberDistance < Distance (m, edge number distance) is the graph edge number distance.

%%% ¡description!
The edge distance number of a graph is the number of edges in the shortest
weighted path between two nodes within a layer.

%%% ¡shape!
shape = Measure.BINODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWD
GraphWU
MultiplexWD
MultiplexWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the edge number distance.
%%%% ¡calculate!
g = m.get('G');
distance = Distance('G', g);
distance.get('M');
edge_number_distance = distance.get('EDGESNUMBER');

value = edge_number_distance;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡code!
A = [
    0 .1 .2 .25 0;
    .125 0 0 0  0;
    .2 .5 0 .25 0;
    .125 10 0 0 0;
    0  0  0  0  0
    ];

known_value = {[
                0 2 1 1 0;
                2 0 1 1 0;
                1 1 0 2 0;
                1 1 2 0 0;
                0 0 0 0 0;
                ]};

g = GraphWU('B', A);
edge_number_distance = EdgeNumberDistance('G', g).get('M');

assert(isequal(edge_number_distance, known_value), ...
    [BRAPH2.STR ':EdgeNumberDistance:' BRAPH2.BUG_ERR], ...
    'EdgeNumberDistance is not being calculated correctly for GraphWU.')

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡code!
A11 = [
        0 .1 .2 .25 0;
        .125 0 0 0  0;
        .2 .5 0 .25 0;
        .125 10 0 0 0;
        0  0  0  0  0
       ];
A22 = [
        0 .1 .2 .25 0;
        .125 0 0 0  0;
        .2 .5 0 .25 0;
        .125 10 0 0 0;
        0  0  0  0  0
       ];
A = {A11 A22};

known_value = {[
                0 2 1 1 0;
                1 0 2 2 0;
                1 1 0 1 0;
                1 1 2 0 0;
                0 0 0 0 0;
               ]
               [
                0 2 1 1 0;
                1 0 2 2 0;
                1 1 0 1 0;
                1 1 2 0 0;
                0 0 0 0 0;
               ]};

g = MultiplexWD('B', A);
edge_number_distance = EdgeNumberDistance('G', g).get('M');

assert(isequal(edge_number_distance, known_value'), ...
    [BRAPH2.STR ':EdgeNumberDistance:' BRAPH2.BUG_ERR], ...
    'EdgeNumberDistance is not being calculated correctly for MultiplexGraphWD.')
