% test Overlapping Strength
L1= [
    0   0.2 1
    0.2 0   0
    1   0   0];

L2 = [
    0 1   0
    1 0   0.3
    0 0.3 0];

A = {
    L1      eye(3)
    eye(3)  L2
    };

%% Test 1: Calculation MultiplexGraphWU
g = MultiplexGraphWU(A);
overlapping_strength = OverlappingStrength(g);

known_overlapping_strength = [
                     2.2
                     1.5
                     1.3];
                 
overlapping_strength_test = {known_overlapping_strength};  

assert(isequal(overlapping_strength.getValue(), overlapping_strength_test), ...
    [BRAPH2.STR ':OverlappingStrength:' BRAPH2.BUG_ERR], ...
    'OverlappingStrength is not being calculated correctly for MultiplexGraphWU')

%% Test 2: Calculation GraphWU
g = GraphWU(L1);
overlapping_strength = OverlappingStrength(g);

known_overlapping_strength = [
                     1.2
                     0.2
                     1];
                 
overlapping_strength_test = {known_overlapping_strength};  

assert(isequal(overlapping_strength.getValue(), overlapping_strength_test), ...
    [BRAPH2.STR ':OverlappingStrength:' BRAPH2.BUG_ERR], ...
    'OverlappingStrength is not being calculated correctly for GraphWU')