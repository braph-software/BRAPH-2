% test OutStrengthAv

%% Test 1: GraphWD
A = [
    0   .2  1
    0   0   .8
    1   0   0
    ];

known_out_strength_av = {mean([1.2 .8 1])};

g = GraphWD(A);
out_strength_av = OutStrengthAv(g);

assert(isequal(out_strength_av.getValue(), known_out_strength_av), ...
    [BRAPH2.STR ':OutStrengthAv:' BRAPH2.BUG_ERR], ...
    'OutStrengthAv is not being calculated correctly for GraphWD')

%% Test 2: MultiplexGraphWD
A11 = [
    0   .2  1
    0   0   .8
    1   0   0
    ];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0  1   .6
    1  0   .4
    0  .4  0
    ];
A = {
    A11     A12  
    A21     A22
    };

known_out_strength_av = {
    mean([1.2 .8  1])
    mean([1.6 1.4 .4])
    };
                                
g = MultiplexGraphWD(A);
out_strength_av = OutStrengthAv(g);

assert(isequal(out_strength_av.getValue(), known_out_strength_av), ...
    [BRAPH2.STR ':OutStrengthAv:' BRAPH2.BUG_ERR], ...
    'OutStrengthAv is not being calculated correctly for MultiplexGraphWD')