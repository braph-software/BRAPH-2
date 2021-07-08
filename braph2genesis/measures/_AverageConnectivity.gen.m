%% ¡header!
AverageConnectivity < Measure (m, average connectivity) is the average connectivity of a group.

%%% ¡description!
The average connectivity of a group is the average of the weighted or binary adjacency 
matrices of a group of subjects.

%%% ¡shape!
shape = Measure.BINODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWU
GraphWD
GraphBU
GraphBD
MultigraphBUD
MultigraphBUT
MultiplexWU
MultiplexWD
MultiplexBU
MultiplexBUD
MultiplexBUT
MultiplexBD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the average connectivity.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class

A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
value = A;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
B = [
    0   1   1
    1   0   0
    1   0   0
    ];

known_connectivity = B;

g = GraphBU('B', B);

av_connectivity = AverageConnectivity('G', g);
assert(isequal(av_connectivity.get('M'), known_connectivity), ...
    [BRAPH2.STR ':AverageConnectivity:' BRAPH2.BUG_ERR], ...
    'AverageConnectivity is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   0
    .7   0   0
    ];

thresholds = [0 .5 1];

known_connectivity = cell(3);

known_connectivity(1) = {[
    0   1   1
    1   0   0
    1   0   0]'};

known_connectivity(2, 2) = {[
    0   0   1
    0   0   0
    1   0   0]'};

known_connectivity(3, 3) = {zeros(3)};

g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);

av_connectivity = AverageConnectivity('G', g);
assert(isequal(av_connectivity.get('M'), known_connectivity), ...
    [BRAPH2.STR ':AverageConnectivity:' BRAPH2.BUG_ERR], ...
    'AverageConnectivity is not being calculated correctly for MultigraphBUT.')

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
B= {B11 B22};

known_connectivity = cell(2);
known_connectivity(1) = {B11};
known_connectivity(2) = {eye(3)};
known_connectivity(3) = {eye(3)};
known_connectivity(4) = {B22};

g = MultiplexWU('B', B);
av_connectivity = AverageConnectivity('G', g);

assert(isequal(av_connectivity.get('M'), known_connectivity), ...
    [BRAPH2.STR ':AverageConnectivity:' BRAPH2.BUG_ERR], ...
    'AverageConnectivity is not being calculated correctly for MultiplexWU.')
