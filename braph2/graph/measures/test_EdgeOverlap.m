% test EdgeOverlap
 
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

known_edge_overlap = {[
    0   1   .5
    1   0   .5
    .5  .5  0
    ]};

g = MultiplexGraphBU(A);
edge_overlap = EdgeOverlap(g);
 
assert(isequal(edge_overlap.getValue(), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for MultiplexGraphBU.')

%% Test 2: MultiplexGraphBD
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
    0   1   0
    ];
A = {
    A11     A12
    A21     A22
    };

known_edge_overlap = {[
    0   1   0
    1   0   .5
    .5  .5  0
    ]};

g = MultiplexGraphBD(A);
edge_overlap = EdgeOverlap(g);

assert(isequal(edge_overlap.getValue(), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for MultiplexGraphBD')

%% Test 3: MultiplexGraphWU
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

known_edge_overlap = {[
    0   1   .5
    1   0   .5
    .5  .5  0
    ]};

g = MultiplexGraphWU(A);
edge_overlap = EdgeOverlap(g);

assert(isequal(edge_overlap.getValue(), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for MultiplexGraphWU')

%% Test 4: Calculation MultiplexGraphWD
A11 = [
    0   .2  0
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

known_edge_overlap = {[
    0   1   0
    1   0   .5
    .5  .5  0
    ]};

g = MultiplexGraphWD(A);
edge_overlap = EdgeOverlap(g);

assert(isequal(edge_overlap.getValue(), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for MultiplexGraphWD')
