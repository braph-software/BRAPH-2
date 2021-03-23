% test WeightedMultiplexParticipationAv

%% Test 1: MultiplexGraphWU
A11 = [
    0   .5  1
    .5  0   0
    1   0   0
    ];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0   1   0
    1   0   .5
    0   .5  0
    ];
A = {
    A11     A12
    A21     A22
    };

known_weighted_multiplex_participation_av = {mean([24/25 3/4 8/9])};

g = MultiplexGraphWU(A);           
weighted_multiplex_participation_av = WeightedMultiplexParticipationAv(g);

assert(isequal(weighted_multiplex_participation_av.getValue(), known_weighted_multiplex_participation_av), ...
    [BRAPH2.STR ':WeightedMultiplexParticipationAv:' BRAPH2.BUG_ERR], ...
    'WeightedMultiplexParticipationAv is not being calculated correctly for MultiplexGraphWU.')
