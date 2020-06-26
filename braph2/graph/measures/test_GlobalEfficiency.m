% test GlobalEfficiency

%% Test 1: GraphBU
A = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

known_global_efficiency = {[1/4 1/4 1/4 1/4 0]'};

g = GraphBU(A);
global_efficiency = GlobalEfficiency(g);

assert(isequal(global_efficiency.getValue(), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.BUG_ERR], ...
    'GlobalEfficiency is not being calculated correctly for GraphBU.')

%% Test 2: GraphWU
A = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

known_global_efficiency = {[1/20 1/20 1/20 1/20 0]'};

g = GraphWU(A);
global_efficiency = GlobalEfficiency(g);

assert(isequal(global_efficiency.getValue(), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.BUG_ERR], ...
    'GlobalEfficiency is not being calculated correctly for GraphWU.')

%% Test 3: MultiplexGraphBU
A11 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
A12 = eye(5);
A21 = eye(5);
A22 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
A = {
    A11     A12
    A21     A22
    };

known_global_efficiency = {
                        [1/4 1/4 1/4 1/4 0]'
                        [1/4 1/4 1/4 1/4 0]'
                        };


g = MultiplexGraphBU(A);
global_efficiency = GlobalEfficiency(g);

assert(isequal(global_efficiency.getValue(), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.BUG_ERR], ...
    'GlobalEfficiency is not being calculated correctly for MultiplexGraphBU.')

%% Test 4: MultiplexGraphWU
A11 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
A12 = eye(5);
A21 = eye(5);
A22 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
A = {
    A11     A12
    A21     A22
    };

known_global_efficiency = {
                        [1/20 1/20 1/20 1/20 0]'
                        [1/20 1/20 1/20 1/20 0]'
                        };


g = MultiplexGraphWU(A);
global_efficiency = GlobalEfficiency(g);

assert(isequal(global_efficiency.getValue(), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.BUG_ERR], ...
    'GlobalEfficiency is not being calculated correctly for MultiplexGraphWU.')