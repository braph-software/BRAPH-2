%% ¡header!
WeightedMultiplexParticipationAv < WeightedMultiplexParticipation (m, average weighted multiplex participation) is the graph average weighted multiplex participation.

%%% ¡description!
The weighted multiplex participation of a graph is the average heterogeneity
of its number of neighbours across the layers. 

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexGraphWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the average weighted multiplex participation.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class

weighted_multiplex_participation = calculateValue@WeightedMultiplexParticipation(m, prop);	
value = {mean(cell2mat(weighted_multiplex_participation))};

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

known_weighted_multiplex_participation_Av = {mean([24/25 3/4 8/9])};

g = MultiplexGraphWU('B', B);
weighted_multiplex_participation_av = WeightedMultiplexParticipationAv('G', g);

assert(isequal(weighted_multiplex_participation_av.get('M'), known_weighted_multiplex_participation_Av), ...
    [BRAPH2.STR ':WeightedMultiplexParticipationAv:' BRAPH2.BUG_ERR], ...
    'WeightedMultiplexParticipationAv is not being calculated correctly for MultiplexGraphWU.')