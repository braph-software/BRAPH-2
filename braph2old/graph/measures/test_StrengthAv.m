% test StrengthAv

%% Test 1: GraphWU
A = [
    0  .2 1
    .2 0  0
    1  0  0
    ];

known_strength_av = {mean([1.2 0.2 1])};

g = GraphWU(A);
strength_av = StrengthAv(g);

assert(isequal(strength_av.getValue(), known_strength_av), ...
    [BRAPH2.STR ':StrengthAv:' BRAPH2.BUG_ERR], ...
    'StrengthAv is not being calculated correctly for GraphWU.')

%% Test 2: MultiplexGraphWU
A11 = [
    0  .2 1
    .2 0  0
    1  0  0
    ];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0 1  0
    1 0  .4
    0 .4 0
    ];
A = {
    A11     A12  
    A21     A22
    };

known_strength_av = {
                 mean([1.2 .2  1])
                 mean([1   1.4 .4])
                 };
                                
g = MultiplexGraphWU(A);
strength_av = StrengthAv(g);

assert(isequal(strength_av.getValue(), known_strength_av), ...
    [BRAPH2.STR ':StrengthAv:' BRAPH2.BUG_ERR], ...
    'StrengthAv is not being calculated correctly for MultiplexGraphWU.')