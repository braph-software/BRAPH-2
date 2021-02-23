%% ¡header!
WeightedMultiplexInParticipation < Measure (m, weighted multiplex in-participation) is the graph weighted multiplex in-participation.

%%% ¡description!
The weighted multiplex in-participation of a graph is the nodal heterogeneity
of its number of neighbours across the layers. 

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexGraphWD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the weighted multiplex in-participation.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
L = g.layernumber();

if L == 0
    value = {};
else
    N = g.nodenumber();
    in_strength = InStrength('G', g).get('M');
    overlapping_in_strength = OverlappingInStrength('G', g).get('M');

    weighted_multiplex_in_participation =  zeros(N(1), 1);
    for li = 1:1:L
        weighted_multiplex_in_participation = weighted_multiplex_in_participation + (in_strength{li}./overlapping_in_strength{1}).^2;
    end
    weighted_multiplex_in_participation = L / (L - 1) * (1 - weighted_multiplex_in_participation);
    weighted_multiplex_in_participation(isnan(weighted_multiplex_in_participation)) = 0;  % Should return zeros, since NaN happens when strength = 0 and overlapping strength = 0 for all regions
    value = {weighted_multiplex_in_participation};
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
MultiplexGraphWD
%%%% ¡code!
B11 = [
    0   .5  1
    .5  0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   .5
    0   .5  0
    ];
B = {B11  B22};

known_weighted_multiplex_in_participation = {[24/25 3/4 8/9]'};

g = MultiplexGraphWD('B', B);
weighted_multiplex_in_participation = WeightedMultiplexInParticipation('G', g);

assert(isequal(weighted_multiplex_in_participation.get('M'), known_weighted_multiplex_in_participation), ...
    [BRAPH2.STR ':WeightedMultiplexInParticipation:' BRAPH2.BUG_ERR], ...
    'WeightedMultiplexInParticipation is not being calculated correctly for MultiplexGraphWD.')