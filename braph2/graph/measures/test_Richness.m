% test Richness

%% Test 1: GraphBU
A = [
    0  1  1; 
    1  0  0; 
    1  1  0
    ];

known_richness = {[1 1 0]'};

g = GraphBU(A);
richness = Richness(g, 'RichnessThreshold', 1);

assert(isequal(richness.getValue(), known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.BUG_ERR], ...
    'Richness is not being calculated correctly for GraphBU')

%% Test 2: GraphBD

%% Test 3: GraphWU

%% Test 4: GraphWD

%% Test 5: MultiplexGraphBU
A11 = [
      0     .1  .2  .25  0; 
      .125  0   0   0    0; 
      .2    .5  0   .25  0; 
      .125  10   0   0    0;
      0     0   0   0    0
      ];
A12 = eye(5);
A21 = eye(5);
A22 = [
      0     .1  .2  .25  0; 
      .125  0   0   0    0; 
      .2    .5  0   .25  0; 
      .125  10   0   0    0;
      0     0   0   0    0
      ];
A = {
    A11     A12
    A21     A22
    };

known_richness = {
                 known_distance_layer
                 known_distance_layer
                 };

g = MultiplexGraphBU(A);
richness = Richness(g);

assert(isequal(richness.getValue(), known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.BUG_ERR], ...
    'Richness is not being calculated correctly for MultiplexGraphBU')

%% Test 6: MultiplexGraphBD


%% Test 7: MultiplexGraphWU


%% Test 8: MultiplexGraphWD

