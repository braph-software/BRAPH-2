%% ¡header!
Radius < Measure (m, radius) is the graph radius.

%%% ¡description!
The radius is the minimum eccentricity among the vertice within a layer.

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWU
GraphBU
MultiplexGraphBU
MultiplexGraphWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the radius.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)

eccentricity = Eccentricity('G', g).get('M');
radius = cell(g.layernumber(), 1);


for li = 1:1:g.layernumber()
    Aii = A{li, li};
    Aii = binarize(Aii);  % binarizes the adjacency matrix
    radius(li) = {sum(Aii, 2)};  % calculates the radius of a node for layer li
end

value = radius;

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

known_degree = {[2 1 1]'};

g = GraphBU('B', B);

m_outside_g = Degree('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':Degree:' BRAPH2.BUG_ERR], ...
    'Degree is not being calculated correctly for GraphBU.')

m_inside_g = g.getMeasure('Degree');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':Degree:' BRAPH2.BUG_ERR], ...
    'Degree is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡code!
B = [
    0   .6  1
    .6  0   0
    1   0   0
    ];

known_degree = {[2 1 1]'};

g = GraphWU('B', B);

m_outside_g = Degree('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':Degree:' BRAPH2.BUG_ERR], ...
    'Degree is not being calculated correctly for GraphWU.')

m_inside_g = g.getMeasure('Degree');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':Degree:' BRAPH2.BUG_ERR], ...
    'Degree is not being calculated correctly for GraphWU.')

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

known_degree = { ...
    [2 1 1]'
    [1 0 1]'
    [0 0 0]'
    };

g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = Degree('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':Degree:' BRAPH2.BUG_ERR], ...
    'Degree is not being calculated correctly for MultigraphBUT.')

m_inside_g = g.getMeasure('Degree');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':Degree:' BRAPH2.BUG_ERR], ...
    'Degree is not being calculated correctly for MultigraphBUT.')

%%% ¡test!
%%%% ¡name!
MultigraphBUD
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

densities = [0 33 67 100];

known_degree = { ...
    [0 0 0]'
    [1 0 1]'
    [2 1 1]'
    [2 2 2]'
    };

g = MultigraphBUD('B', B, 'DENSITIES', densities);

m_outside_g = Degree('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':Degree:' BRAPH2.BUG_ERR], ...
    'Degree is not being calculated correctly for MultigraphBUD.')

m_inside_g = g.getMeasure('Degree');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':Degree:' BRAPH2.BUG_ERR], ...
    'Degree is not being calculated correctly for MultigraphBUD.')