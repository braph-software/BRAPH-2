% test WeightedMultiplexParticipation

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

known_weighted_multiplex_participation = {[24/25 3/4 8/9]'};

g = MultiplexGraphWU(A);           
weighted_multiplex_participation = WeightedMultiplexParticipation(g);

assert(isequal(weighted_multiplex_participation.getValue(), known_weighted_multiplex_participation), ...
    [BRAPH2.STR ':WeightedMultiplexParticipation:' BRAPH2.BUG_ERR], ...
    'WeightedMultiplexParticipation is not being calculated correctly for MultiplexGraphWU.')
