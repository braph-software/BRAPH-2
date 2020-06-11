% test OverlappingStrength

A = {
    [0, 0.2, 1; 0.2, 0, 0; 1, 0, 0]     eye(3)
    eye(3)                              [0, 1, 0; 1, 0, 0.3; 0, 0.3, 0]
    };

%% Test 1: Calculation MultiplexGraphWU
known_overlapping_strength = {[2.2, 1.5, 1.3]'};
                 
g = MultiplexGraphWU(A);
overlapping_strength = OverlappingStrength(g);

assert(isequal(overlapping_strength.getValue(), known_overlapping_strength), ...
    [BRAPH2.STR ':OverlappingStrength:' BRAPH2.BUG_ERR], ...
    'OverlappingStrength is not being calculated correctly for MultiplexGraphWU')
