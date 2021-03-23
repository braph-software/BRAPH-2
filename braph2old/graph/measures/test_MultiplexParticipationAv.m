% test MultiplexParticipationAv

%% Test 1: MultiplexGraphBU
A11 = [
    0   1   1
    1   0   0
    1   0   0
    ];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0   1   0
    1   0   1
    0   1   0
    ];
A = {
    A11     A12
    A21     A22
    };

known_multiplex_participation_av = {mean([8/9 8/9 1])};

g = MultiplexGraphBU(A);
multiplex_participation_av = MultiplexParticipationAv(g);
                 
assert(isequal(multiplex_participation_av.getValue(), known_multiplex_participation_av), ...
    [BRAPH2.STR ':MultiplexParticipationAv:' BRAPH2.BUG_ERR], ...
    'MultiplexParticipationAv is not being calculated correctly for MultiplexGraphBU.')

%% Test 2: MultiplexGraphWU
A11 = [
    0   .2  1
    .2  0   0
    1   0   0
    ];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0   1   0
    1   0   .3
    0   .3  0
    ];
A = {
    A11     A12
    A21     A22
    };

known_multiplex_participation_av = {mean([8/9 8/9 1])};

g = MultiplexGraphWU(A);           
multiplex_participation_av = MultiplexParticipationAv(g);

assert(isequal(multiplex_participation_av.getValue(), known_multiplex_participation_av), ...
    [BRAPH2.STR ':MultiplexParticipationAv:' BRAPH2.BUG_ERR], ...
    'MultiplexParticipationAv is not being calculated correctly for MultiplexGraphWU.')
