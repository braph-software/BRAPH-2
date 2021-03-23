% test OverlappingOutStrengthAv

%% Test 1: MultiplexGraphWD
A11 = [
    0   .2  1
    .3  0   .1
    1   0   0
    ];
A12= eye(3);
A21 = eye(3);
A22 = [
    0   1   0
    1   0   0
    .7  .3  0
    ];
A = {
    A11     A12  
    A21     A22
    };

known_overlapping_out_strength_av = {mean([2.2 1.4 2])};
                 
g = MultiplexGraphWD(A);
overlapping_out_strength_av = OverlappingOutStrengthAv(g);

assert(isequal(overlapping_out_strength_av.getValue(), known_overlapping_out_strength_av), ...
    [BRAPH2.STR ':OverlappingOutStrengthAv:' BRAPH2.BUG_ERR], ...
    'OverlappingOutStrengthAv is not being calculated correctly for MultiplexGraphWD.')