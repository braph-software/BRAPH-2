% test Strength
L1 = [
    0   0.2 1
    0.2 0   0
    1   0   0];

L2 = [
    0 1   0
    1 0   0.4
    0 0.4 0];

A = {
    L1      eye(3)
    eye(3)  L2
    };

%% Test 1: Calculation GraphWU
g = GraphWU(L1);
strength = Strength(g);

known_overlapping_strength = [
                     1.2
                     0.2
                     1];
                 
strength_test = {known_overlapping_strength};  

assert(isequal(strength.getValue(), strength_test), ...
    [BRAPH2.STR ':Strength:' BRAPH2.BUG_ERR], ...
    'Strength is not being calculated correctly for GraphWU')

%% Test 2: Calculation MultiplexGraphWU
g = MultiplexGraphWU(A);
strength = Strength(g);

known_overlapping_strength1 = [
                     1.2
                     0.2
                     1];
                 
 known_overlapping_strength2 = [
                     1
                     1.4
                     0.4];
                 
strength_test = {known_overlapping_strength1; known_overlapping_strength2};  

assert(isequal(strength.getValue(), strength_test), ...
    [BRAPH2.STR ':Strength:' BRAPH2.BUG_ERR], ...
    'Strength is not being calculated correctly for MultiplexGraphWU')