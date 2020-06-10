% test Overlapping Degree
L1 = [
    0 1 1
    1 0 0
    1 0 0];

L2 = [
    0 1 0
    1 0 1
    0 1 0];

A = {
    L1      eye(3)
    eye(3)  L2
    };

L1_weighted = [
    0   0.2 1
    0.2 0   0
    1   0   0];

L2_weighted = [
    0 1   0
    1 0   0.3
    0 0.3 0];

A_weighted = {
    L1_weighted    eye(3)
    eye(3)          L2_weighted
    };

%% Test 1: Calculation MultiplexGraphBU
g = MultiplexGraphBU(A);
overlapping_degree = OverlappingDegree(g);

known_overlapping_degree = [
                     3
                     3
                     2];
                 
overlapping_degree_test = {known_overlapping_degree};  

assert(isequal(overlapping_degree.getValue(), overlapping_degree_test), ...
    [BRAPH2.STR ':OverlappingDegree:' BRAPH2.BUG_ERR], ...
    'OverlappingDegree is not being calculated correctly for MultiplexGraphBU')

%% Test 2: Calculation MultiplexGraphWU
g = MultiplexGraphWU(A_weighted);
overlapping_degree = OverlappingDegree(g);

known_overlapping_degree = [
                     3
                     3
                     2];
                 
overlapping_degree_test = {known_overlapping_degree};  

assert(isequal(overlapping_degree.getValue(), overlapping_degree_test), ...
    [BRAPH2.STR ':OverlappingDegree:' BRAPH2.BUG_ERR], ...
    'OverlappingDegree is not being calculated correctly for MultiplexGraphWU')
