% test SmallWorldness

%% Test 1: GraphBU
A = rand(20);

known_smallworldness = {1};

g = GraphBU(A);
smallworldness = SmallWorldness(g);

assert(isequal(smallworldness.getValue(), known_smallworldness), ...
    [BRAPH2.STR ':SmallWorldness:' BRAPH2.BUG_ERR], ...
    'SmallWorldness is not being calculated correctly for GraphBU.')


%% Test 2: GraphWU
A = rand(20);

known_smallworldness = 1;

g = GraphWU(A);
smallworldness = SmallWorldness(g);
smallworldness = smallworldness.getValue();

assert(isequal(round(smallworldness{1}, 1), known_smallworldness), ...
    [BRAPH2.STR ':SmallWorldness:' BRAPH2.BUG_ERR], ...
    'SmallWorldness is not being calculated correctly for GraphWU.')

%% Test 3: MultiplexGraphBU
A11 = rand(20);
A12 = eye(20);
A21 = eye(20);
A22 = rand(20);
A = {
    A11     A12
    A21     A22
    };

known_smallworldness = {
                       1
                       1
                       };

g = MultiplexGraphBU(A);
smallworldness = SmallWorldness(g);

assert(isequal(smallworldness.getValue(), known_smallworldness), ...
    [BRAPH2.STR ':SmallWorldness:' BRAPH2.BUG_ERR], ...
    'SmallWorldness is not being calculated correctly for MultiplexGraphBU.')

%% Test 4: MultiplexGraphWU
A11 = rand(20);
A12 = eye(20);
A21 = eye(20);
A22 = rand(20);
A = {
    A11     A12
    A21     A22
    };

known_smallworldness = {
                       1
                       1
                       };

g = MultiplexGraphWU(A);
smallworldness = SmallWorldness(g);
smallworldness = smallworldness.getValue();
smallworldness = cellfun(@(s) round(s, 1), smallworldness, 'UniformOutput', false);

assert(isequal(smallworldness, known_smallworldness), ...
    [BRAPH2.STR ':SmallWorldness:' BRAPH2.BUG_ERR], ...
    'SmallWorldness is not being calculated correctly for MultiplexGraphWU.')