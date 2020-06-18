% test Richness

%% Test 1: GraphBU
A = [
    0  1  1; 
    1  0  0; 
    1  1  0
    ];

% known_richness = {[1 1 0]'};
known_richness = {[0 0 0]'};

g = GraphBU(A);
% richness = Richness(g, 'RichnessThreshold', 1);
richness = Richness(g, 'RichnessThreshold', 'default');

assert(isequal(richness.getValue(), known_richness), ...
    [BRAPH2.STR ':Richness:' BRAPH2.BUG_ERR], ...
    'Richness is not being calculated correctly for GraphBU')

%% Test 2: GraphBD

%% Test 3: GraphWU

%% Test 4: GraphWD

%% Test 5: MultiplexGraphBU

%% Test 6: MultiplexGraphBD


%% Test 7: MultiplexGraphWU


%% Test 8: MultiplexGraphWD

