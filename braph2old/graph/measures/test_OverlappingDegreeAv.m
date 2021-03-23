% test OverlappingDegreeAv

%% Test 1: MultiplexGraphBU
A11 = [
    0   1   1
    1   0   0
    1   0   0
    ];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0   1   0
    1   0   1
    0   1   0
    ];
A = {
    A11     A12
    A21     A22
    };

known_overlapping_degree_av = {mean([3, 3, 2])};

g = MultiplexGraphBU(A);
overlapping_degree_av = OverlappingDegreeAv(g);
                 
assert(isequal(overlapping_degree_av.getValue(), known_overlapping_degree_av), ...
    [BRAPH2.STR ':OverlappingDegreeAv:' BRAPH2.BUG_ERR], ...
    'OverlappingDegreeAv is not being calculated correctly for MultiplexGraphBU')

%% Test 2: MultiplexGraphWU
A11 = [
    0   .2  1
    .2  0   0
    1   0   0
    ];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0   1   0
    1   0   .3
    0   .3  0
    ];
A = {
    A11     A12
    A21     A22
    };

known_overlapping_degree_av = {mean([3, 3, 2])};

g = MultiplexGraphWU(A);           
overlapping_degree_av = OverlappingDegreeAv(g);

assert(isequal(overlapping_degree_av.getValue(), known_overlapping_degree_av), ...
    [BRAPH2.STR ':OverlappingDegreeAv:' BRAPH2.BUG_ERR], ...
    'OverlappingDegreeAv is not being calculated correctly for MultiplexGraphWU')
