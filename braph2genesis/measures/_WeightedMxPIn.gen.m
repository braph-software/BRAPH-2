%% ¡header!
WeightedMxPIn < Measure (m, weighted in-participation) is the graph weighted multiplex in-participation.

%%% ¡description!
The weighted multiplex in-participation of a graph is the nodal homogeneity 
  of its number of inward neighbours across the layers. 

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
WeightedMxPIn.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
WeightedMxPIn.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
WeightedMxPIn.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
WeightedMxPIn.M
%%%% ¡title!
WeightedMxPIn

%%% ¡prop!
%%%% ¡id!
WeightedMxPIn.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
WeightedMxPIn.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
WeightedMxPIn.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'WeightedMxPIn'

%%% ¡prop!
NAME (constant, string) is the name of the weighted multiplex in-particiption.
%%%% ¡default!
'WeightedMxPIn'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the weighted multiplex in-particiption.
%%%% ¡default!
'The weighted multiplex in-participation of a graph is the nodal homogeneity of its number of inward neighbours across the layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the weighted multiplex in-particiption.
%%%% ¡settings!
'WeightedMxPIn'

%%% ¡prop!
ID (data, string) is a few-letter code of the weighted multiplex in-particiption.
%%%% ¡default!
'WeightedMxPIn ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the weighted multiplex in-particiption.
%%%% ¡default!
'WeightedMxPIn label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the weighted multiplex in-particiption.
%%%% ¡default!
'WeightedMxPIn notes'

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
{'MultiplexWD' 'OrdMxWD' 'MultilayerWD' 'OrdMlWD'}

%%% ¡prop!
M (result, cell) is the weighted multiplex in-particiption.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');

if l == 0
    value = {};
else
    N = g.get('NODENUMBER');
    in_strength = StrengthIn('G', g).get('M');
    overlapping_in_strength = OverlappingSIn('G', g).get('M');

    weighted_multiplex_in_participation =  zeros(N(1), 1);
    for li = 1:l
        weighted_multiplex_in_participation = weighted_multiplex_in_participation + (in_strength{li}'./overlapping_in_strength{1}).^2;
    end
    weighted_multiplex_in_participation = l / (l - 1) * (1 - weighted_multiplex_in_participation);
    weighted_multiplex_in_participation(isnan(weighted_multiplex_in_participation)) = 0;  % Should return zeros, since NaN happens when strength = 0 and overlapping strength = 0 for all regions
    value = {weighted_multiplex_in_participation};
end

%% ¡tests!

%%% ¡excluded_props!
[WeightedMxPIn.PFM]

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .5  1
    .5  0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   0
    0   .5  0
    ];
B = {B11  B22};

known_weighted_multiplex_in_participation = {[24/25 3/4 0]'};

g = MultiplexWD('B', B);
m_outside_g = WeightedMxPIn('G', g);

assert(isequal(m_outside_g.get('M'), known_weighted_multiplex_in_participation), ...
    [BRAPH2.STR ':WeightedMxPIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'WeightedMxPIn');
assert(isequal(m_inside_g.get('M'), known_weighted_multiplex_in_participation), ...
    [BRAPH2.STR ':WeightedMxPIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .5  1
    .5  0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   0
    0   .5  0
    ];
B = {B11  B22};

known_weighted_multiplex_in_participation = {[24/25 3/4 0]'};

g = OrdMxWD('B', B);
m_outside_g = WeightedMxPIn('G', g);

assert(isequal(m_outside_g.get('M'), known_weighted_multiplex_in_participation), ...
    [BRAPH2.STR ':WeightedMxPIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'WeightedMxPIn');
assert(isequal(m_inside_g.get('M'), known_weighted_multiplex_in_participation), ...
    [BRAPH2.STR ':WeightedMxPIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])