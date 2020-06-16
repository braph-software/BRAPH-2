% test MultiplexOutParticipation

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

known_multiplex_out_participation = {[1, 8/9, 0]'};

g = MultiplexGraphBD(A);
multiplex_out_participation = MultiplexOutParticipation(g);
                 
assert(isequal(multiplex_out_participation.getValue(), known_multiplex_out_participation), ...
    [BRAPH2.STR ':MultiplexOutParticipation:' BRAPH2.BUG_ERR], ...
    'MultiplexOutParticipation is not being calculated correctly for MultiplexGraphBD')

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

known_multiplex_out_participation = {[8/9, 0, 1]'};

g = MultiplexGraphWD(A);           
multiplex_out_participation = MultiplexOutParticipation(g);

assert(isequal(multiplex_out_participation.getValue(), known_multiplex_out_participation), ...
    [BRAPH2.STR ':MultiplexOutParticipation:' BRAPH2.BUG_ERR], ...
    'MultiplexOutParticipation is not being calculated correctly for MultiplexGraphWD')
