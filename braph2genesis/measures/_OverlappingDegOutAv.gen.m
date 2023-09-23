%% ¡header!
OverlappingDegOutAv < OverlappingDegOut (m, average overlapping out-degree) is the graph average overlapping out-degree.

%%% ¡description!
The average overlapping out-degree of a graph is the average of the sum of the 
out-degrees of a node in all layers. 

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
OverlappingDegOutAv.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
OverlappingDegOutAv.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
OverlappingDegOutAv.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
OverlappingDegOutAv.M
%%%% ¡title!
OverlappingDegOutAv

%%% ¡prop!
%%%% ¡id!
OverlappingDegOutAv.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
OverlappingDegOutAv.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
OverlappingDegOutAv.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'OverlappingDegOutAv'

%%% ¡prop!
NAME (constant, string) is the name of the average overlapping out-degree.
%%%% ¡default!
'OverlappingDegOutAv'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the average overlapping out-degree.
%%%% ¡default!
'The average overlapping out-degree of a graph is the average of the sum of the out-degrees of a node in all layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the average overlapping out-degree.
%%%% ¡settings!
'OverlappingDegOutAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the average overlapping out-degree.
%%%% ¡default!
'OverlappingDegOutAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the average overlapping out-degree.
%%%% ¡default!
'OverlappingDegOutAv label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the average overlapping out-degree.
%%%% ¡default!
'OverlappingDegOutAv notes'

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
{'MultiplexWD' 'MultiplexBD' 'MultilayerWD' 'MultilayerBD' 'OrdMxBD' 'OrdMxWD' 'OrdMlBD' 'OrdMlWD'};

%%% ¡prop!
M (result, cell) is the average overlapping out-degree.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
overlapping_out_degree_av = calculateValue@OverlappingDegOut(m, prop);
l = g.get('LAYERNUMBER');

if l == 0
    value = {};
    return;
end

value = {mean(cell2mat(overlapping_out_degree_av))};

%% ¡tests!

%%% ¡excluded_props!
[OverlappingDegOutAv.PFM]

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   1   0
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   1
    0   0   0
    ];
B = {B11 B22};

known_overlapping_out_degree_av = {mean([2, 3, 1])};

g = MultiplexBD('B', B);
m_outside_g = OverlappingDegOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_out_degree_av), ...
    [BRAPH2.STR ':OverlappingDegOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDegOutAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_out_degree_av), ...
    [BRAPH2.STR ':OverlappingDegOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .4  1
    0   0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   0
    0   .3  0
    ];
B = {B11 B22};

known_overlapping_out_degree_av = {mean([3, 1, 2])};

g = MultiplexWD('B', B);
m_outside_g = OverlappingDegOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_out_degree_av), ...
    [BRAPH2.STR ':OverlappingDegOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDegOutAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_out_degree_av), ...
    [BRAPH2.STR ':OverlappingDegOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerBD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   1   0
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   1
    0   0   0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B = {B11 B12;
     B21 B22};

known_overlapping_out_degree_av = {mean([2, 3, 1]')};

g = MultilayerBD('B', B);
m_outside_g = OverlappingDegOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_out_degree_av), ...
    [BRAPH2.STR ':OverlappingDegOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDegOutAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_out_degree_av), ...
    [BRAPH2.STR ':OverlappingDegOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlBD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   1   0
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   1
    0   0   0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B = {B11 B12;
     B21 B22};

known_overlapping_out_degree_av = {mean([2, 3, 1]')};

g = OrdMlBD('B', B);
m_outside_g = OverlappingDegOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_out_degree_av), ...
    [BRAPH2.STR ':OverlappingDegOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDegOutAv');
assert(isequal(m_inside_g.get('M'), known_overlapping_out_degree_av), ...
    [BRAPH2.STR ':OverlappingDegOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])