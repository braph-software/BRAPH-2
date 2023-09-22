%% ¡header!
OverlappingSAv < OverlappingS (m, averge overlapping strength) is the graph averge overlapping strength.

%%% ¡description!
The average overlapping strength of a graph is the average of the sum of the 
strengths of a node in all layers.

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
OverlappingSAv.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
OverlappingSAv.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
OverlappingSAv.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
OverlappingSAv.M
%%%% ¡title!
OverlappingSAv

%%% ¡prop!
%%%% ¡id!
OverlappingSAv.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
OverlappingSAv.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
OverlappingSAv.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the averge overlapping strength.
%%%% ¡default!
'OverlappingSAv'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the averge overlapping strength.
%%%% ¡default!
'The average overlapping strength of a graph is the average of the sum of the strengths of a node in all layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the averge overlapping strength.
%%%% ¡settings!
'OverlappingSAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the averge overlapping strength.
%%%% ¡default!
'OverlappingSAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the averge overlapping strength.
%%%% ¡default!
'OverlappingSAv label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the averge overlapping strength.
%%%% ¡default!
'OverlappingSAv notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
%%%% ¡default!
Measure.GLOBAL

%%% ¡prop!
SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.
%%%% ¡default!
Measure.SUPERGLOBAL

%%% ¡prop!
PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.
%%%% ¡default!
Measure.NONPARAMETRIC

%%% ¡prop!
COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
%%%% ¡default!
{'MultiplexWU' 'OrdMxWU' 'MultilayerWU' 'OrdMlWU'};

%%% ¡prop!
M (result, cell) is the averge overlapping strength.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
overlapping_strength = calculateValue@OverlappingS(m, prop);
l = g.get('LAYERNUMBER');

if l == 0
    value = {};
else

    value = {mean(cell2mat(overlapping_strength))};
end


%% ¡tests!

%%% ¡excluded_props!
[OverlappingSAv.PFM]

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
B = {B11 B22};

known_overlapping_str = {mean([2.2 1.5 1.3])};

g = MultiplexWU('B', B);
m_outside_g = OverlappingSAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_str), ...
    [BRAPH2.STR ':OverlappingSAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingSAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_str), ...
    [BRAPH2.STR ':OverlappingSAv:' BRAPH2.FAIL_TEST], ...
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
B = {B11 B22};

known_overlapping_str = {mean([2.2 1.5 1.3])};

g = OrdMxWU('B', B);
m_outside_g = OverlappingSAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_str), ...
    [BRAPH2.STR ':OverlappingSAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingSAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_str), ...
    [BRAPH2.STR ':OverlappingSAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerWU
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
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B = {B11 B12;
     B21 B22};

known_overlapping_strength_AV = {mean([2.2 1.5 1.3]')};

g = MultilayerWU('B', B);
m_outside_g = OverlappingSAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_strength_AV), ...
    [BRAPH2.STR ':OverlappingSAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingSAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_strength_AV), ...
    [BRAPH2.STR ':OverlappingSAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlWU
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
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B = {B11 B12;
     B21 B22};

known_overlapping_strength_AV = {mean([2.2 1.5 1.3]')};

g = OrdMlWU('B', B);
m_outside_g = OverlappingSAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_strength_AV), ...
    [BRAPH2.STR ':OverlappingSAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingSAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_strength_AV), ...
    [BRAPH2.STR ':OverlappingSAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])