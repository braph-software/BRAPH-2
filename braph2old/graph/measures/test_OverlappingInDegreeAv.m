% test OverlappingInDegreeAv

%% Test 1: MultiplexGraphBD
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

known_overlapping_in_degree_av = {mean([3, 2, 1])};

g = MultiplexGraphBD(A);
overlapping_in_degree_av = OverlappingInDegreeAv(g);
                 
assert(isequal(overlapping_in_degree_av.getValue(), known_overlapping_in_degree_av), ...
    [BRAPH2.STR ':OverlappingInDegreeAv:' BRAPH2.BUG_ERR], ...
    'OverlappingInDegreeAv is not being calculated correctly for MultiplexGraphBD.')

%% Test 2: MultiplexGraphWD
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

known_overlapping_in_degree_av = {mean([2, 3, 1])};

g = MultiplexGraphWD(A);           
overlapping_in_degree_av = OverlappingInDegreeAv(g);

assert(isequal(overlapping_in_degree_av.getValue(), known_overlapping_in_degree_av), ...
    [BRAPH2.STR ':OverlappingInDegreeAv:' BRAPH2.BUG_ERR], ...
    'OverlappingInDegreeAv is not being calculated correctly for MultiplexGraphWD.')