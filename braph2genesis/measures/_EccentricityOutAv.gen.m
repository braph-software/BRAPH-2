%% ¡header!
EccentricityOutAv < EccentricityOut (m, average eccentricity) is the graph average out-eccentricity.

%%% ¡description!
The average out-eccentricity of a node is the sum of the nodal 
out-eccentricities divided by their number within a layer.

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'EccentricityOutAv'

%%% ¡prop!
NAME (constant, string) is the name of the average out-eccentricity.
%%%% ¡default!
'EccentricityOutAv'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the average out-eccentricity.
%%%% ¡default!
'The average out-eccentricity of a node is the sum of the nodal out-eccentricities divided by their number within a layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the average out-eccentricity.
%%%% ¡settings!
'EccentricityOutAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the average out-eccentricity.
%%%% ¡default!
'EccentricityOutAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the average out-eccentricity.
%%%% ¡default!
'EccentricityOutAv label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the average out-eccentricity.
%%%% ¡default!
'EccentricityOutAv notes'

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
%%%% ¡default!
{'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD'};

%%% ¡prop!
M (result, cell) is the average out-eccentricity.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');

eccentricity = calculateValue@EccentricityOut(m, prop); 

eccentricity_av = cell(L, 1);

ls = g.get('PARTITIONS');

if L == 0
    value = {};
    return ;
end

parfor li = 1:L
    eccentricity_av(li) = {mean(eccentricity{li})};
end


value = eccentricity_av;

%% ¡tests!

%%% ¡excluded_props!
[EccentricityOutAv.PFM]

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];

known_eccentricity = {mean([5 10 10 5 0]')};

g = GraphWD('B', B);

m_outside_g = EccentricityOutAv('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityOutAv');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];

known_eccentricity = {mean([1 1 1 1 0]')};

g = GraphBD('B', B);

m_outside_g = EccentricityOutAv('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityOutAv');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
      ];
B22 = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
      ];
B = {
    B11 B22
    };

known_eccentricity = {
    mean([10 5 5 10 0]')
    mean([10 5 5 10 0]')
    };

g = MultiplexWD('B', B);

m_outside_g = EccentricityOutAv('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityOutAv');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])


%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
      ];
B22 = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
      ];
B = {
    B11 B22
    };

known_eccentricity = {
    mean([1 1 1 1 0]')
    mean([1 1 1 1 0]')
    };

g = MultiplexBD('B', B);

m_outside_g = EccentricityOutAv('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityOutAv');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity), ...
    [BRAPH2.STR ':EccentricityOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxWD
%%%% ¡probability!
.01
%%%% ¡code!
B11  =[
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];

B22  =[
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];

B = {B11 B22};
known_eccentricity_Av = {
    mean([10 5 5 10 0]')
    mean([10 5 5 10 0]')
    };

g = OrdMxWD('B', B);

m_outside_g = EccentricityOutAv('G', g);
m_outside_g.set('RULE', 'subgraphs');

assert(isequal(m_outside_g.get('M'), known_eccentricity_Av), ...
    [BRAPH2.STR ':EccentricityOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'EccentricityOutAv');
m_inside_g.set('RULE', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity_Av), ...
    [BRAPH2.STR ':EccentricityOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])