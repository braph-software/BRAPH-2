%% ¡header!
MultiplexInParticipation < Measure (m, multiplex in-participation) is the graph multiplex in-participation.

%%% ¡description!
The multiplex in-participation is the homogeneity of the number of inward 
<<<<<<< Updated upstream
neighbours of a node across the layers.
    
%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexBD
MultiplexWD
=======
 neighbours of a node across the layers.
>>>>>>> Stashed changes

%% ¡props_update!

%%% ¡prop!
<<<<<<< Updated upstream
M (result, cell) is the multiplex in-participation.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
L = g.layernumber();
=======
NAME (constant, string) is the name of the multiplex in-participation.
%%%% ¡default!
'MultiplexInParticipation'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the multiplex in-participation.
%%%% ¡default!
'The multiplex in-participation is the homogeneity of the number of inward neighbours of a node across the layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the multiplex in-participation.
%%%% ¡settings!
'MultiplexInParticipation'

%%% ¡prop!
ID (data, string) is a few-letter code of the multiplex in-participation.
%%%% ¡default!
'MultiplexInParticipation ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the multiplex in-participation.
%%%% ¡default!
'MultiplexInParticipation label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the multiplex in-participation.
%%%% ¡default!
'MultiplexInParticipation notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
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
{'MultiplexBD' 'MultiplexWD'} ;%TBE % % % add any missing tests

%%% ¡prop!
M (result, cell) is the multiplex in-participation.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
L = g.get('LAYERNUMBER');
>>>>>>> Stashed changes

if L == 0
    value = {};
else
<<<<<<< Updated upstream
    
    N = g.nodenumber();
    in_degree = InDegree('G', g).get('M');
    overlapping_in_degree = OverlappingInDegree('G', g).get('M');  
=======
    N = g.get('NODENUMBER');
    in_degree = DegreeIn('G', g).get('M');
    overlapping_in_degree = OverlappingDgrIn('G', g).get('M');  
>>>>>>> Stashed changes
    multiplex_in_participation =  zeros(N(1), 1);

    for li = 1:1:L
        multiplex_in_participation = multiplex_in_participation + (in_degree{li}./overlapping_in_degree{1}).^2;
    end
    multiplex_in_participation = L / (L - 1) * (1 - multiplex_in_participation);
    multiplex_in_participation(isnan(multiplex_in_participation)) = 0;  % Should return zeros, since NaN happens when strength = 0 and overlapping strength = 0 for all regions
    value = {multiplex_in_participation};
end

%% ¡tests!

<<<<<<< Updated upstream
=======
%%% ¡excluded_props!
[MultiplexInParticipation.PFM]


>>>>>>> Stashed changes
%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡code!
B11 = [
    0   1   0
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0
<<<<<<< Updated upstream
    1   0   1
    0   1   0
=======
    1   0   0
    0   0   0
>>>>>>> Stashed changes
    ];
B33 = [
    0   1   0
    1   0   0
    0   1   0
    ];
B = {B11 B22 B33};

<<<<<<< Updated upstream
known_multiplex_in_participation = {[15/16 24/25 0]'};

g = MultiplexBD('B', B);
multiplex_in_participation = MultiplexInParticipation('G', g);

assert(isequal(cellfun(@(x)round(x,4),multiplex_in_participation.get('M'),'UniformOutput',false), known_multiplex_in_participation), ...
    [BRAPH2.STR ':MultiplexInParticipation:' BRAPH2.BUG_ERR], ...
    'MultiplexInParticipation is not being calculated correctly for MultiplexBD.')
=======
known_multiplex_in_participation = {[15/16 15/16 0]'};

g = MultiplexBD('B', B);

m_outside_g = MultiplexInParticipation('G', g);
assert(isequal(m_outside_g.get('M'), known_multiplex_in_participation), ...
    [BRAPH2.STR ':MultiplexInParticipation:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexInParticipation');
assert(isequal(m_inside_g.get('M'), known_multiplex_in_participation), ...
    [BRAPH2.STR ':MultiplexInParticipation:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
>>>>>>> Stashed changes

%%% ¡test!
%%%% ¡name!
MultiplexWD
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
B = {B11  B22};

known_multiplex_in_participation = {[8/9 8/9 1]'};

g = MultiplexWD('B', B);
<<<<<<< Updated upstream
multiplex_in_participation = MultiplexInParticipation('G', g);

assert(isequal(multiplex_in_participation.get('M'), known_multiplex_in_participation), ...
    [BRAPH2.STR ':MultiplexInParticipation:' BRAPH2.BUG_ERR], ...
    'MultiplexInParticipation is not being calculated correctly for MultiplexWD.')
=======

m_outside_g = MultiplexInParticipation('G', g);
assert(isequal(m_outside_g.get('M'), known_multiplex_in_participation), ...
    [BRAPH2.STR ':MultiplexInParticipation:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'MultiplexInParticipation');
assert(isequal(m_inside_g.get('M'), known_multiplex_in_participation), ...
    [BRAPH2.STR ':MultiplexInParticipation:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

>>>>>>> Stashed changes
