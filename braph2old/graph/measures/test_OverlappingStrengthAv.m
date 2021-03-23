% test OverlappingStrengthAv

%% Test 1: MultiplexGraphWU
A11 = [
    0   .2  1
    .2  0   0
    1   0   0
    ];
A12= eye(3);
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

known_overlapping_strength_av = {mean([2.2 1.5 1.3])};
                 
g = MultiplexGraphWU(A);
overlapping_strength_av = OverlappingStrengthAv(g);

assert(isequal(overlapping_strength_av.getValue(), known_overlapping_strength_av), ...
    [BRAPH2.STR ':OverlappingStrengthAv:' BRAPH2.BUG_ERR], ...
    'OverlappingStrengthAv is not being calculated correctly for MultiplexGraphWU.')
