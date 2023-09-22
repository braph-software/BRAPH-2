%% ¡header!
WeightedMxPOut < Measure (m, weighted out-participation) is the graph weighted multiplex out-participation.

%%% ¡description!
The weighted multiplex out-participation of a graph is the nodal homogeneity 
 of its number of outward neighbours across the layers. 

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
WeightedMxPOut.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
WeightedMxPOut.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
WeightedMxPOut.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
WeightedMxPOut.M
%%%% ¡title!
WeightedMxPOut 

%%% ¡prop!
%%%% ¡id!
WeightedMxPOut.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
WeightedMxPOut.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
WeightedMxPOut.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the weighted multiplex out-particiption.
%%%% ¡default!
'WeightedMxPOut '

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the weighted multiplex out-particiption.
%%%% ¡default!
'The weighted multiplex out-participation of a graph is the nodal homogeneity of its number of outward neighbours across the layers.'
 
%%% ¡prop!
TEMPLATE (parameter, item) is the template of the weighted multiplex out-particiption.
%%%% ¡settings!
'WeightedMxPOut'

%%% ¡prop!
ID (data, string) is a few-letter code of the weighted multiplex out-particiption.
%%%% ¡default!
'WeightedMxPOut ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the weighted multiplex out-particiption.
%%%% ¡default!
'WeightedMxPOut label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the weighted multiplex out-particiption.
%%%% ¡default!
'WeightedMxPOut notes'

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
M (result, cell) is the weighted multiplex out-particiption.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
l = g.get('LAYERNUMBER');

if l == 0
    value = {};
else
    N = g.get('NODENUMBER');
    out_strength = StrengthOut('G', g).get('M');
    overlapping_out_strength = OverlappingSOut('G', g).get('M');

    weighted_multiplex_out_participation =  zeros(N(1), 1);
    for li = 1:l
        weighted_multiplex_out_participation = weighted_multiplex_out_participation + (out_strength{li}./overlapping_out_strength{1}).^2;
    end
    weighted_multiplex_out_participation = l / (l - 1) * (1 - weighted_multiplex_out_participation);
    weighted_multiplex_out_participation(isnan(weighted_multiplex_out_participation)) = 0;  % Should return zeros, since NaN happens when strength = 0 and overlapping strength = 0 for all regions
    value = {weighted_multiplex_out_participation};
end

%% ¡tests!

%%% ¡excluded_props!
[WeightedMxPOut.PFM]

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

known_weighted_multiplex_in_participation = {[24/25 8/9 8/9]'};

g = MultiplexWD('B', B);
m_outside_g = WeightedMxPOut ('G', g);

assert(isequal(m_outside_g.get('M'), known_weighted_multiplex_in_participation), ...
    [BRAPH2.STR ':WeightedMxPOut :' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'WeightedMxPOut ');
assert(isequal(m_inside_g.get('M'), known_weighted_multiplex_in_participation), ...
    [BRAPH2.STR ':WeightedMxPOut :' BRAPH2.FAIL_TEST], ...
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

known_weighted_multiplex_in_participation = {[24/25 8/9 8/9]'};

g = OrdMxWD('B', B);
m_outside_g = WeightedMxPOut ('G', g);

assert(isequal(m_outside_g.get('M'), known_weighted_multiplex_in_participation), ...
    [BRAPH2.STR ':WeightedMxPOut :' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'WeightedMxPOut ');
assert(isequal(m_inside_g.get('M'), known_weighted_multiplex_in_participation), ...
    [BRAPH2.STR ':WeightedMxPOut :' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])