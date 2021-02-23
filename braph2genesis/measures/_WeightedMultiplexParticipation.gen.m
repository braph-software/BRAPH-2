%% ¡header!
WeightedMultiplexParticipation < Measure (m, weighted multiplex participation) is the graph weighted multiplex participation.

%%% ¡description!
The weighted multiplex participation of a graph is the nodal heterogeneity
of its number of neighbours across the layers. 

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexGraphWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the weighted multiplex participation.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
B = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.layernumber();
N = 1;
if L > 0
    N = length(B{1});
end

strength = Strength('G', g).get('M');
overlapping_strength = OverlappingStrength('G', g).get('M');

weighted_multiplex_participation =  zeros(N, 1);
for li = 1:1:L
    weighted_multiplex_participation = weighted_multiplex_participation + (strength{li}./overlapping_strength{1}).^2;
end
weighted_multiplex_participation = L / (L - 1) * (1 - weighted_multiplex_participation);
weighted_multiplex_participation(isnan(weighted_multiplex_participation)) = 0;  % Should return zeros, since NaN happens when strength = 0 and overlapping strength = 0 for all regions
value = {weighted_multiplex_participation};

%% ¡tests!

%%% ¡test!
%%%% ¡name!
MultiplexGraphWU
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

known_weighted_multiplex_participation = {[24/25 3/4 8/9]'};

g = MultiplexGraphWU('B', B);
weighted_multiplex_participation = WeightedMultiplexParticipation('G', g);

assert(isequal(weighted_multiplex_participation.get('M'), known_weighted_multiplex_participation), ...
    [BRAPH2.STR ':WeightedMultiplexParticipation:' BRAPH2.BUG_ERR], ...
    'WeightedMultiplexParticipation is not being calculated correctly for MultiplexGraphWU.')