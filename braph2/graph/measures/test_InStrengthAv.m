% test InStrengthAv

%% Test 1: GraphWD
A = [
    0   .2  1
    0   0   .8
    1   0   0
    ];

known_in_strength_av = {mean([1 .2 1.8])};

g = GraphWD(A);
in_strength_av = InStrengthAv(g);

assert(isequal(in_strength_av.getValue(), known_in_strength_av), ...
    [BRAPH2.STR ':InStrengthAv:' BRAPH2.BUG_ERR], ...
    'InStrengthAv is not being calculated correctly for GraphWD')

%% Test 2: MultiplexGraphWD
A11 = [
    0   .2  1
    0   0   .8
    1   0   0];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0  1   .6
    1  0   .4
    0  .4  0];
A = {
    A11     A12  
    A21     A22
    };

known_in_strength_av = {
    mean([1 .2  1.8])
    mean([1 1.4 1])
    };
                                
g = MultiplexGraphWD(A);
in_strength_av = InStrengthAv(g);

assert(isequal(in_strength_av.getValue(), known_in_strength_av), ...
    [BRAPH2.STR ':InStrengthAv:' BRAPH2.BUG_ERR], ...
    'InStrengthAv is not being calculated correctly for MultiplexGraphWD')