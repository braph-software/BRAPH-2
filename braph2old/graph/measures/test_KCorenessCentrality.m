% test KCorenessCentrality

%% Test 1: GraphBU
A = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_k_coreness_centrality = {[2 2 2 1]'};

g = GraphBU(A);
k_coreness_centrality = KCorenessCentrality(g);

assert(isequal(k_coreness_centrality.getValue(), known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentrality:' BRAPH2.BUG_ERR], ...
    'KCorenessCentrality is not being calculated correctly for GraphBU.')

%% Test 2: GraphBD
A = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_k_coreness_centrality = {[4 4 4 3]'};

g = GraphBD(A);
k_coreness_centrality = KCorenessCentrality(g);

assert(isequal(k_coreness_centrality.getValue(), known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentrality:' BRAPH2.BUG_ERR], ...
    'KCorenessCentrality is not being calculated correctly for GraphBD.')

%% Test 3: GraphWU
A = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

known_k_coreness_centrality = {[2 2 2 1]'};

g = GraphWU(A);
k_coreness_centrality = KCorenessCentrality(g);

assert(isequal(k_coreness_centrality.getValue(), known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentrality:' BRAPH2.BUG_ERR], ...
    'KCorenessCentrality is not being calculated correctly for GraphWU.')

%% Test 4: GraphWD
A = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];

known_k_coreness_centrality = {[4 4 4 3]'};

g = GraphWD(A);
k_coreness_centrality = KCorenessCentrality(g);

assert(isequal(k_coreness_centrality.getValue(), known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentrality:' BRAPH2.BUG_ERR], ...
    'KCorenessCentrality is not being calculated correctly for GraphWD.')

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

known_k_coreness_centrality = {
                        [2 2 2 1]'
                        [2 2 2 2]'
                        };

g = MultiplexGraphBU(A);
k_coreness_centrality = KCorenessCentrality(g);

assert(isequal(k_coreness_centrality.getValue(), known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentrality:' BRAPH2.BUG_ERR], ...
    'KCorenessCentrality is not being calculated correctly for MultiplexGraphBU.')

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

known_k_coreness_centrality = {
                        [4 4 4 3]'
                        [4 4 4 4]'
                        };

g = MultiplexGraphBD(A);
k_coreness_centrality = KCorenessCentrality(g);

assert(isequal(k_coreness_centrality.getValue(), known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentrality:' BRAPH2.BUG_ERR], ...
    'KCorenessCentrality is not being calculated correctly for MultiplexGraphBD.')

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
             
known_k_coreness_centrality = {
                        [2 2 2 1]'
                        [2 2 2 2]'
                        };        

g = MultiplexGraphWU(A);
k_coreness_centrality = KCorenessCentrality(g);

assert(isequal(k_coreness_centrality.getValue(), known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentrality:' BRAPH2.BUG_ERR], ...
    'KCorenessCentrality is not being calculated correctly for MultiplexGraphWU.')

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

known_k_coreness_centrality = {
                        [4 4 4 3]'
                        [4 4 4 4]'
                        };           

g = MultiplexGraphWD(A);
k_coreness_centrality = KCorenessCentrality(g);

assert(isequal(k_coreness_centrality.getValue(), known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentrality:' BRAPH2.BUG_ERR], ...
    'KCorenessCentrality is not being calculated correctly for MultiplexGraphWD.')
