% test OverlappingOutDegree

%% Test 1: Calculation MultiplexGraphBD
A11 = [
    0   1   0
    1   0   0
    1   0   0
    ];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0   1   0
    1   0   1
    0   0   0
    ];
A = {
    A11     A12
    A21     A22
    };

known_overlapping_out_degree = {[2, 3, 1]'};

g = MultiplexGraphBD(A);
overlapping_out_degree = OverlappingOutDegree(g);
                 
assert(isequal(overlapping_out_degree.getValue(), known_overlapping_out_degree), ...
    [BRAPH2.STR ':OverlappingOutDegree:' BRAPH2.BUG_ERR], ...
    'OverlappingOutDegree is not being calculated correctly for MultiplexGraphBD')

%% Test 2: Calculation MultiplexGraphWD
A11 = [
    0   .4  1
    0   0   0
    1   0   0
    ];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0   1   0
    1   0   0
    0   .3  0
    ];
A = {
    A11     A12
    A21     A22
    };

known_overlapping_out_degree = {[3, 1, 2]'};

g = MultiplexGraphWD(A);           
overlapping_out_degree = OverlappingOutDegree(g);

assert(isequal(overlapping_out_degree.getValue(), known_overlapping_out_degree), ...
    [BRAPH2.STR ':OverlappingOutDegree:' BRAPH2.BUG_ERR], ...
    'OverlappingOutDegree is not being calculated correctly for MultiplexGraphWD')
