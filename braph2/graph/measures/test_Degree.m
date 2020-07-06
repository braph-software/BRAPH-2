% test Degree

%% Test 1: GraphBU
A = [
    0   1   1
    1   0   0
    1   0   0
    ];

known_degree = {[2 1 1]'};

g = GraphBU(A);
degree = Degree(g);

assert(isequal(degree.getValue(), known_degree), ...
    [BRAPH2.STR ':Degree:' BRAPH2.BUG_ERR], ...
    'Degree is not being calculated correctly for GraphBU.')

%% Test 2: GraphWU
A = [
    0   .6  1
    .6  0   0
    1   0   0
    ];

known_degree = {[2 1 1]'};

g = GraphWU(A);
degree = Degree(g);

assert(isequal(degree.getValue(), known_degree), ...
    [BRAPH2.STR ':Degree:' BRAPH2.BUG_ERR], ...
    'Degree is not being calculated correctly for GraphWU')

%% Test 3: MultiplexGraphBU
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

known_degree = {
    [2 1 1]'
    [1 2 1]'
    };

g = MultiplexGraphBU(A);
degree = Degree(g);

assert(isequal(degree.getValue(), known_degree), ...
    [BRAPH2.STR ':Degree:' BRAPH2.BUG_ERR], ...
    'Degree is not being calculated correctly for MultiplexGraphBU.')

%% Test 4: MultiplexGraphWU
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

known_degree = {
    [2 1 1]'
    [1 2 1]'
    };

g = MultiplexGraphWU(A);
degree = Degree(g);

assert(isequal(degree.getValue(), known_degree), ...
    [BRAPH2.STR ':Degree:' BRAPH2.BUG_ERR], ...
    'Degree is not being calculated correctly for MultiplexGraphWU.')
