%% ¡header!
DegreeAv < Degree (m, average degree) is the graph average degree.

%%% ¡description!
The average degree of a graph is the average of all number of edges 
connected to a node within a layer. 
Connection weights are ignored in calculations.

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWU
GraphBU
MultigraphBUD
MultigraphBUT
MultiplexGraphWU
MultiplexGraphBU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the average degree.
%%%% ¡calculate!
degree = calculateValue@Degree(m, prop);

g = m.get('G');  % graph from measure class

degree_av = cell(g.layernumber(), 1);
for li = 1:1:g.layernumber()
    degree_av(li) = {mean(degree{li})};
end

value = degree_av;

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

known_degree_av = {mean([2 1 1])};

g = GraphBU('B', B);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree_av), ...
    [BRAPH2.STR ':Degree:' BRAPH2.BUG_ERR], ...
    'DegreeAv is not being calculated correctly for GraphBU.')

m_inside_g = g.getMeasure('DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree_av), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.BUG_ERR], ...
    'DegreeAv is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡code!
B = [
    0   .6  1
    .6  0   0
    1   0   0
    ];

known_degree_av = {mean([2 1 1])};

g = GraphWU('B', B);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree_av), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.BUG_ERR], ...
    'DegreeAv is not being calculated correctly for GraphWU.')

m_inside_g = g.getMeasure('DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree_av), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.BUG_ERR], ...
    'DegreeAv is not being calculated correctly for GraphWU.')

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
    mean([2 1 1])
    mean([1 0 1])
    mean([0 0 0])
    };

g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.BUG_ERR], ...
    'DegreeAv is not being calculated correctly for MultigraphBUT.')

m_inside_g = g.getMeasure('DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.BUG_ERR], ...
    'DegreeAv is not being calculated correctly for MultigraphBUT.')

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
    mean([0 0 0])
    mean([1 0 1])
    mean([2 1 1])
    mean([2 2 2])
    };

g = MultigraphBUD('B', B, 'DENSITIES', densities);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.BUG_ERR], ...
    'DegreeAv is not being calculated correctly for MultigraphBUD.')

m_inside_g = g.getMeasure('DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.BUG_ERR], ...
    'DegreeAv is not being calculated correctly for MultigraphBUD.')

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

known_degree = {
    mean([2 1 1])
    mean([1 2 1])
    };

g = MultiplexGraphBU('B', B);
degree_av = DegreeAv('G', g);

assert(isequal(degree_av.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.BUG_ERR], ...
    'DegreeAv is not being calculated correctly for MultiplexGraphBU.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphWU
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

known_degree = {
    mean([2 1 1])
    mean([1 2 1])
    };

g = MultiplexGraphWU('B', B);
degree_av = DegreeAv('G', g);

assert(isequal(degree_av.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.BUG_ERR], ...
    'DegreeAv is not being calculated correctly for MultiplexGraphWU.')