%% ¡header!
MultiplexParticipationAv < MultiplexParticipation (m, average multiplex participation) is the graph average multiplex participation.

%%% ¡description!
The average multiplex participation of a graph is the average heterogeneity
of its number of neighbours across the layers. 

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexGraphBU
MultiplexWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the average multiplex participation.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class

multiplex_participation_av = calculateValue@MultiplexParticipation(m, prop);	
value = {mean(cell2mat(multiplex_participation_av))};

%% ¡tests!

%%% ¡test!
%%%% ¡name!
MultiplexGraphBU
%%%% ¡code!
B11 = [
    0   1   1
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   1
    0   1   0
    ];
B = {B11  B22};

known_multiplex_participation_av = {mean([8/9 8/9 1])};

g = MultiplexGraphBU('B', B);
multiplex_participation_av = MultiplexParticipationAv('G', g);

assert(isequal(multiplex_participation_av.get('M'), known_multiplex_participation_av), ...
    [BRAPH2.STR ':MultiplexParticipationAv:' BRAPH2.BUG_ERR], ...
    'MultiplexParticipationAv is not being calculated correctly for MultiplexGraphBU.')

%%% ¡test!
%%%% ¡name!
MultiplexWU
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

known_multiplex_participation_av = {mean([8/9 8/9 1])};

g = MultiplexWU('B', B);
multiplex_participation_av = MultiplexParticipationAv('G', g);

assert(isequal(multiplex_participation_av.get('M'), known_multiplex_participation_av), ...
    [BRAPH2.STR ':MultiplexParticipationAv:' BRAPH2.BUG_ERR], ...
    'MultiplexParticipationAv is not being calculated correctly for MultiplexWU.')