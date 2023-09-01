%% ¡header!
OverlappingDgrIn < DegreeIn (m, overlapping in-degree) is the graph overlapping in-degree.

%%% ¡description!
The overlapping in-degree of a graph is the sum of the in-degrees of a node 
in all layers. 

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
OverlappingDgrIn.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
OverlappingDgrIn.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
OverlappingDgrIn.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
OverlappingDgrIn.M
%%%% ¡title!
OverlappingDgrIn

%%% ¡prop!
%%%% ¡id!
OverlappingDgrIn.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
OverlappingDgrIn.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
OverlappingDgrIn.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the overlapping in-degree.
%%%% ¡default!
'OverlappingDgrIn'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the overlapping in-degree.
%%%% ¡default!
'The overlapping in-degree of a graph is the sum of the in-degrees of a node in all layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the overlapping in-degree.
%%%% ¡settings!
'OverlappingDgrIn'

%%% ¡prop!
ID (data, string) is a few-letter code of the overlapping in-degree.
%%%% ¡default!
'OverlappingDgrIn ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the overlapping in-degree.
%%%% ¡default!
'OverlappingDgrIn label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the overlapping in-degree.
%%%% ¡default!
'OverlappingDgrIn notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
%%%% ¡default!
Measure.NODAL

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
{'MultiplexWD' 'MultiplexBD'};

%%% ¡prop!
M (result, cell) is the overlapping in-degree.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');
ls = g.get('PARTITIONS');

if l == 0
    value = {};
else
    N = g.get('NODENUMBER');
    in_degree = calculateValue@DegreeIn(m, prop);
    overlapping_in_degree = zeros(N(1), 1);

    for li = 1:l
        overlapping_in_degree = overlapping_in_degree + in_degree{li};
    end
    value = {overlapping_in_degree};
end

%% ¡tests!

%%% ¡excluded_props!
[OverlappingDgrIn.PFM]

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

known_overlapping_in_degree = {[3, 2, 1]'};

g = MultiplexBD('B', B);
m_outside_g = OverlappingDgrIn('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_in_degree), ...
    [BRAPH2.STR ':OverlappingDgrIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDgrIn');
assert(isequal(m_inside_g.get('M'), known_overlapping_in_degree), ...
    [BRAPH2.STR ':OverlappingDgrIn:' BRAPH2.FAIL_TEST], ...
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

known_overlapping_in_degree = {[2, 3, 1]'};

g = MultiplexWD('B', B);
m_outside_g = OverlappingDgrIn('G', g);
assert(isequal(m_outside_g.get('M'), known_overlapping_in_degree), ...
    [BRAPH2.STR ':OverlappingDgrIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'OverlappingDgrIn');
assert(isequal(m_inside_g.get('M'), known_overlapping_in_degree), ...
    [BRAPH2.STR ':OverlappingDgrIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])