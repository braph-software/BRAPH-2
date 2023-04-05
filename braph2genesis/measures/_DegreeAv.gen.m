%% ¡header!
DegreeAv < Degree (m, average degree) is the graph average degree.

%%% ¡description!
The average degree of a graph is the average of all number of edges 
connected to a node within a layer. 
Connection weights are ignored in calculations.

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the average degree.
%%%% ¡default!
'DegreeAv'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the average degree.
%%%% ¡default!
'The average degree of a graph is the average of all number of edges connected to a node within a layer. Connection weights are ignored in calculations.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the average degree.

%%% ¡prop!
ID (data, string) is a few-letter code for the average degree.
%%%% ¡default!
'DegreeAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the average degree.
%%%% ¡default!
'DegreeAv label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the average degree.
%%%% ¡default!
'DegreeAv notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.
%%%% ¡default!
Measure.GLOBAL

%%% ¡prop!
SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.
%%%% ¡default!
Measure.UNILAYER

%%% ¡prop!
PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.
%%%% ¡default!
Measure.NONPARAMETRIC

%%% ¡prop!
COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
%%% ¡default!
{'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU' 'OrdMxBU' 'OrdMxBUD'}

%%% ¡prop!
M (result, cell) is the average degree.
%%%% ¡calculate!
degree = calculateValue@Degree(m, prop);

g = m.get('G');  % graph from measure class

degree_av = cell(g.get('LAYERNUMBER'), 1);
parfor li = 1:1:g.get('LAYERNUMBER')
    degree_av(li) = {mean(degree{li})};
end

value = degree_av;

%% ¡tests!

%%% ¡excluded_props!
[DegreeAv.TEMPLATE DegreeAv.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
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
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree_av), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡probability!
.01
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
    [BRAPH2.STR ':Degree:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree_av), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUD
%%%% ¡probability!
.01
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
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

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
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
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

g = MultiplexWU('B', B);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
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

g = MultiplexBU('B', B);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

densities = [0 33 67 100];

known_degree = { ...
    mean([0 0 0])
    mean([0 0 0])
    mean([0 0 0])
    mean([1 0 1])
    mean([1 0 1])
    mean([1 0 1])
    mean([2 1 1])
    mean([2 1 1])
    mean([2 1 1])
    mean([2 2 2])
    mean([2 2 2])
    mean([2 2 2])
    };

g = MultiplexBUD('B', {B B B}, 'DENSITIES', densities);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUT
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   0
    .7   0   0
    ];

thresholds = [0 .5 1];

known_degree = { ...
    mean([2 1 1])
    mean([2 1 1])
    mean([2 1 1])
    mean([1 0 1])
    mean([1 0 1])
    mean([1 0 1])
    mean([0 0 0])
    mean([0 0 0])
    mean([0 0 0])
    };

g = MultiplexBUT('B', {B B B}, 'THRESHOLDS', thresholds);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxWU
%%%% ¡probability!
.01
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

g = OrdMxWU('B', B);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxBU
%%%% ¡probability!
.01
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

g = OrdMxBU('B', B);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxBUD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

densities = [0 33 67 100];

known_degree = { ...
    mean([0 0 0])
    mean([0 0 0])
    mean([0 0 0])
    mean([1 0 1])
    mean([1 0 1])
    mean([1 0 1])
    mean([2 1 1])
    mean([2 1 1])
    mean([2 1 1])
    mean([2 2 2])
    mean([2 2 2])
    mean([2 2 2])
    };

g = OrdMxBUD('B', {B B B}, 'DENSITIES', densities);

m_outside_g = DegreeAv('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeAv');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':DegreeAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
