% test OverlappingDegree

A = {
    [0, 1, 1; 1, 0, 0; 1, 0, 0]         eye(3)
    eye(3)                              [0, 1, 0; 1, 0, 1; 0, 1, 0]
};

A_weighted = {
    [0, 0.2, 1; 0.2, 0, 0; 1, 0, 0]     eye(3)
    eye(3)                              [0, 1, 0; 1, 0, 0.3; 0, 0.3, 0]
    };

%% Test 1: Calculation MultiplexGraphBU
known_overlapping_degree = {[3, 3, 2]'};

g = MultiplexGraphBU(A);
overlapping_degree = OverlappingDegree(g);
                 
assert(isequal(overlapping_degree.getValue(), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDegree:' BRAPH2.BUG_ERR], ...
    'OverlappingDegree is not being calculated correctly for MultiplexGraphBU')

%% Test 2: Calculation MultiplexGraphWU
known_overlapping_degree = {[3, 3, 2]'};

g = MultiplexGraphWU(A_weighted);           
overlapping_degree = OverlappingDegree(g);

assert(isequal(overlapping_degree.getValue(), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDegree:' BRAPH2.BUG_ERR], ...
    'OverlappingDegree is not being calculated correctly for MultiplexGraphWU')
