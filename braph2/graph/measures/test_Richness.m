% test Richness

%% Test 1: GraphBU
A = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_richness = {[2 2 2 0]'};

g = GraphBU(A);
richness = Richness(g, 'RichnessThreshold', 1);

assert(isequal(richness.getValue(), known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.BUG_ERR], ...
    'Richness is not being calculated correctly for GraphBU.')

%% Test 2: GraphBD
A = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_richness = {[2 2 0 0]'};

g = GraphBD(A);
richness = Richness(g, 'RichnessThreshold', 4);

assert(isequal(richness.getValue(), known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.BUG_ERR], ...
    'Richness is not being calculated correctly for GraphBD.')

%% Test 3: GraphWU
A = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

known_richness = {[2 2 2 0]'};

g = GraphWU(A);
richness = Richness(g, 'RichnessThreshold', 1);

assert(isequal(richness.getValue(), known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.BUG_ERR], ...
    'Richness is not being calculated correctly for GraphWU.')

%% Test 4: GraphWD
A = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];

known_richness = {[2 2 0 0]'};

g = GraphWD(A);
richness = Richness(g, 'RichnessThreshold', 4);

assert(isequal(richness.getValue(), known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.BUG_ERR], ...
    'Richness is not being calculated correctly for GraphWD.')


%% Test 5: MultiplexGraphBU

%% Test 6: MultiplexGraphBD


%% Test 7: MultiplexGraphWU


%% Test 8: MultiplexGraphWD

