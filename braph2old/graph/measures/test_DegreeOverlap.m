% test DegreeOverlap

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

known_degree_overlap = {[1 1 0]'};

g = MultiplexGraphBU(A);
degree_overlap = DegreeOverlap(g);
                 
assert(isequal(degree_overlap.getValue(), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlap:' BRAPH2.BUG_ERR], ...
    'DegreeOverlap is not being calculated correctly for MultiplexGraphBU')

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

known_degree_overlap = {[1 1 0]'};

g = MultiplexGraphWU(A);
degree_overlap = DegreeOverlap(g);

assert(isequal(degree_overlap.getValue(), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlap:' BRAPH2.BUG_ERR], ...
    'DegreeOverlap is not being calculated correctly for MultiplexGraphWU')
