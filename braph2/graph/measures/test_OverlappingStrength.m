% test OverlappingStrength

A11 = [
    0   .2  1
    .2  0   0
    1   0   0];
A12= eye(3);
A21 = eye(3);
A22 = [
    0   1   0
    1   0   .3
    0   .3  0];
A = {
    A11     A12  
    A21     A22
    };

%% Test 1: Calculation MultiplexGraphWU
known_overlapping_strength = {[2.2, 1.5, 1.3]'};
                 
g = MultiplexGraphWU(A);
overlapping_strength = OverlappingStrength(g);

assert(isequal(overlapping_strength.getValue(), known_overlapping_strength), ...
    [BRAPH2.STR ':OverlappingStrength:' BRAPH2.BUG_ERR], ...
    'OverlappingStrength is not being calculated correctly for MultiplexGraphWU')
