% test OverlappingInStrength

%% Test 1: MultiplexGraphWD
A11 = [
    0   .2  1
    .3  0   .1
    1   0   0
    ];
A12= eye(3);
A21 = eye(3);
A22 = [
    0   1   .4
    1   0   0
    .7  .3  0
    ];
A = {
    A11     A12  
    A21     A22
    };

known_overlapping_in_strength = {[3 1.5 1.5]'};
                 
g = MultiplexGraphWD(A);
overlapping_strength = OverlappingInStrength(g);

assert(isequal(overlapping_strength.getValue(), known_overlapping_in_strength), ...
    [BRAPH2.STR ':OverlappingInStrength:' BRAPH2.BUG_ERR], ...
    'OverlappingInStrength is not being calculated correctly for MultiplexGraphWD.')
