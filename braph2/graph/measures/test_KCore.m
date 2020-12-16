% test KCore

%% Test 1: GraphBU
A = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_kcore = {[
                0  1  1  0;
                1  0  1  0;
                1  1  0  0;
                0  0  0  0
                ]};

g = GraphBU(A);
kcore = KCore(g, 'KCoreThreshold', 2);

assert(isequal(kcore.getValue(), known_kcore), ...
    [BRAPH2.STR ':KCore:' BRAPH2.BUG_ERR], ...
    'KCore is not being calculated correctly for GraphBU.')

%% Test 2: GraphBD
A = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_kcore = {[
                0  1  1  0;
                1  0  1  0;
                1  1  0  0;
                0  0  0  0
                ]};

g = GraphBD(A);
kcore = KCore(g, 'KCoreThreshold', 2);

assert(isequal(kcore.getValue(), known_kcore), ...
    [BRAPH2.STR ':KCore:' BRAPH2.BUG_ERR], ...
    'KCore is not being calculated correctly for GraphBD.')

%% Test 3: GraphWU
A = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

known_kcore = {[
                0  1  1  0;
                1  0  1  0;
                1  1  0  0;
                0  0  0  0
                ]};

g = GraphWU(A);
kcore = KCore(g, 'KCoreThreshold', 2);

assert(isequal(kcore.getValue(), known_kcore), ...
    [BRAPH2.STR ':KCore:' BRAPH2.BUG_ERR], ...
    'KCore is not being calculated correctly for GraphWU.')

%% Test 4: GraphWD
A = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];

known_kcore = {[
                0  1  1  0;
                1  0  1  0;
                1  1  0  0;
                0  0  0  0
                ]};

g = GraphWD(A);
kcore = KCore(g, 'KCoreThreshold', 2);

assert(isequal(kcore.getValue(), known_kcore), ...
    [BRAPH2.STR ':KCore:' BRAPH2.BUG_ERR], ...
    'KCore is not being calculated correctly for GraphWD.')

%% Test 5: MultiplexGraphBU
A11 = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];
A12 = eye(4);
A21 = eye(4);
A22 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    1  1  0  0
    ];
A = {
    A11     A12
    A21     A22
    };
             
known_kcore(1) = {[
                0  1  1  0;
                1  0  1  0;
                1  1  0  0;
                0  0  0  0
                ]};
known_kcore(2, 1) = {[
                0  1  1  1;
                1  0  1  1;
                1  1  0  0;
                1  1  0  0
                ]};            

g = MultiplexGraphBU(A);
kcore = KCore(g, 'KCoreThreshold', 2);

assert(isequal(kcore.getValue(), known_kcore), ...
    [BRAPH2.STR ':KCore:' BRAPH2.BUG_ERR], ...
    'KCore is not being calculated correctly for MultiplexGraphBU.')

%% Test 6: MultiplexGraphBD
A11 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];
A12 = eye(4);
A21 = eye(4);
A22 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  1  0
    ];
A = {
    A11     A12
    A21     A22
    };

known_kcore(1) = {[
                0  1  1  0;
                1  0  1  0;
                1  1  0  0;
                0  0  0  0
                ]};
known_kcore(2, 1) = {[
                0  1  1  1;
                1  0  1  1;
                1  1  0  0;
                0  1  1  0
                ]};            

g = MultiplexGraphBD(A);
kcore = KCore(g, 'KCoreThreshold', 2);

assert(isequal(kcore.getValue(), known_kcore), ...
    [BRAPH2.STR ':KCore:' BRAPH2.BUG_ERR], ...
    'KCore is not being calculated correctly for MultiplexGraphBD.')

%% Test 7: MultiplexGraphWU
A11 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];
A12 = eye(4);
A21 = eye(4);
A22 = [
    0   .1  1  1; 
    .1  0   1  .8; 
    1   1   0  0;
    1   .8  0  0
    ];
A = {
    A11     A12
    A21     A22
    };
             
known_kcore(1) = {[
                0  1  1  0;
                1  0  1  0;
                1  1  0  0;
                0  0  0  0
                ]};
known_kcore(2, 1) = {[
                0  1  1  1;
                1  0  1  1;
                1  1  0  0;
                1  1  0  0
                ]};            

g = MultiplexGraphWU(A);
kcore = KCore(g, 'KCoreThreshold', 2);

assert(isequal(kcore.getValue(), known_kcore), ...
    [BRAPH2.STR ':KCore:' BRAPH2.BUG_ERR], ...
    'KCore is not being calculated correctly for MultiplexGraphWU.')

%% Test 8: MultiplexGraphWD
A11 = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];
A12 = eye(4);
A21 = eye(4);
A22 = [
    0   1   1   .1; 
    .2  0   1   1; 
    1   1   0   0;
    0   .3  .7  0
    ];
A = {
    A11     A12
    A21     A22
    };

known_kcore(1) = {[
                0  1  1  0;
                1  0  1  0;
                1  1  0  0;
                0  0  0  0
                ]};
known_kcore(2, 1) = {[
                0  1  1  1;
                1  0  1  1;
                1  1  0  0;
                0  1  1  0
                ]};            

g = MultiplexGraphWD(A);
kcore = KCore(g, 'KCoreThreshold', 2);

assert(isequal(kcore.getValue(), known_kcore), ...
    [BRAPH2.STR ':KCore:' BRAPH2.BUG_ERR], ...
    'KCore is not being calculated correctly for MultiplexGraphWD.')
