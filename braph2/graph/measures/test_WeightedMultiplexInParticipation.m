% test WeightedMultiplexInParticipation

%% Test 1: MultiplexGraphWD
A11 = [
    0   .5  0
    .5  0   0
    1   0   0
    ];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0   1   0
    1   0   .5
    0   0   0
    ];
A = {
    A11     A12
    A21     A22
    };

known_weighted_multiplex_in_participation = {[24/25 8/9 0]'};

g = MultiplexGraphWD(A);           
weighted_multiplex_in_participation = WeightedMultiplexInParticipation(g);

assert(isequal(weighted_multiplex_in_participation.getValue(), known_weighted_multiplex_in_participation), ...
    [BRAPH2.STR ':WeightedMultiplexInParticipation:' BRAPH2.BUG_ERR], ...
    'WeightedMultiplexInParticipation is not being calculated correctly for MultiplexGraphWD.')
