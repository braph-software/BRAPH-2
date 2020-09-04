% test Richness2

%% Test 1: GraphBU
A = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_richness2 = {[1 0 1 1]'};

g = GraphBU(A);
richness2 = Richness2(g);

assert(isequal(richness2.getValue(), known_richness2), ...
    [BRAPH2.STR ':Richness2:' BRAPH2.BUG_ERR], ...
    'Richness2 is not being calculated correctly for GraphBU.')

%% Test 2: GraphBD
A = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_richness2 = {[1 0 2 3/2]'};

g = GraphBD(A);
richness2 = Richness2(g);

assert(isequal(richness2.getValue(), known_richness2), ...
    [BRAPH2.STR ':Richness2:' BRAPH2.BUG_ERR], ...
    'Richness2 is not being calculated correctly for GraphBD.')

%% Test 3: GraphWU
A = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

known_richness2 = {[.1 0 1 .8]'};

g = GraphWU(A);
richness2 = Richness2(g);

assert(isequal(richness2.getValue(), known_richness2), ...
    [BRAPH2.STR ':Richness2:' BRAPH2.BUG_ERR], ...
    'Richness2 is not being calculated correctly for GraphWU.')

%% Test 4: GraphWD
A = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];

known_richness2 = {[.6 0 2 .7]'};

g = GraphWD(A);
richness2 = Richness2(g);
r = richness2.getValue();
assert(isequal(round(r{1}, 10), round(known_richness2{1}, 10)), ...
    [BRAPH2.STR ':Richness2:' BRAPH2.BUG_ERR], ...
    'Richness2 is not being calculated correctly for GraphWD.')
