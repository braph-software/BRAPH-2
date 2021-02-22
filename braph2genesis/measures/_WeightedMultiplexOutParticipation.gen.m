%% ¡header!
WeightedMultiplexOutParticipation < Measure (m, weighted multiplex out-participation) is the graph weighted multiplex out-participation.

%%% ¡description!
The weighted multiplex out-participation of a graph is the nodal heterogeneity
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
M (result, cell) is the weighted multiplex out-participation.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
L = g.layernumber();

if L == 0
    value = {};
else
    N = g.nodenumber();
    out_strength = OutStrength('G', g).get('M');
    overlapping_out_strength = OverlappingOutStrength('G', g).get('M');

    weighted_multiplex_out_participation =  zeros(N(1), 1);
    for li = 1:1:L
        weighted_multiplex_out_participation = weighted_multiplex_out_participation + (out_strength{li}./overlapping_out_strength{1}).^2;
    end
    weighted_multiplex_out_participation = L / (L - 1) * (1 - weighted_multiplex_out_participation);
    weighted_multiplex_out_participation(isnan(weighted_multiplex_out_participation)) = 0;  % Should return zeros, since NaN happens when strength = 0 and overlapping strength = 0 for all regions
    value = {weighted_multiplex_out_participation};
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

known_weighted_multiplex_out_participation = {[24/25 3/4 8/9]'};

g = MultiplexGraphWD('B', B);
weighted_multiplex_out_participation = WeightedMultiplexOutParticipation('G', g);

assert(isequal(weighted_multiplex_out_participation.get('M'), known_weighted_multiplex_out_participation), ...
    [BRAPH2.STR ':WeightedMultiplexOutParticipation:' BRAPH2.BUG_ERR], ...
    'WeightedMultiplexOutParticipation is not being calculated correctly for MultiplexGraphWD.')