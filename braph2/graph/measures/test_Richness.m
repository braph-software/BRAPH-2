% test Richness

%% Test 1: GraphBU
A = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_richness = {[1 0 1 1]'};

g = GraphBU(A);
richness = Richness(g);

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

known_richness = {[1 0 2 3/2]'};

g = GraphBD(A);
richness = Richness(g);

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

known_richness = {[.1 0 1 .8]'};

g = GraphWU(A);
richness = Richness(g);

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

known_richness = {[.6 0 2 .7]'};

g = GraphWD(A);
richness = Richness(g);
r = richness.getValue();
assert(isequal(round(r{1}, 10), round(known_richness{1}, 10)), ...
    [BRAPH2.STR ':Richness:' BRAPH2.BUG_ERR], ...
    'Richness is not being calculated correctly for GraphWD.')
