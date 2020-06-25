% test MultiplexInParticipation

%% Test 1: MultiplexGraphBD
A11 = [
    0   1   0
    1   0   0
    1   0   0
    ];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0   1   0
    1   0   1
    0   0   0
    ];
A = {
    A11     A12
    A21     A22
    };

known_multiplex_in_participation = {[8/9 1 0]'};

g = MultiplexGraphBD(A);
multiplex_in_participation = MultiplexInParticipation(g);
                 
assert(isequal(multiplex_in_participation.getValue(), known_multiplex_in_participation), ...
    [BRAPH2.STR ':MultiplexInParticipation:' BRAPH2.BUG_ERR], ...
    'MultiplexInParticipation is not being calculated correctly for MultiplexGraphBD.')

%% Test 2: MultiplexGraphWD
A11 = [
    0   .4  1
    0   0   0
    1   0   0
    ];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0   1   0
    1   0   0
    0   .3  0
    ];
A = {
    A11     A12
    A21     A22
    };

known_multiplex_in_participation = {[1 8/9 0]'};

g = MultiplexGraphWD(A);           
multiplex_in_participation = MultiplexInParticipation(g);

assert(isequal(multiplex_in_participation.getValue(), known_multiplex_in_participation), ...
    [BRAPH2.STR ':MultiplexInParticipation:' BRAPH2.BUG_ERR], ...
    'MultiplexInParticipation is not being calculated correctly for MultiplexGraphWD.')
