% test Eigenvector Centrality

%% Test 1: GraphBU
A = [
    0 1 1 0 
    1 0 0 1 
    1 0 0 1
    0 1 1 0
    ];

known_eigenvector_centrality = {[1/2 1/2 1/2 1/2]'};

g = GraphBU(A);
eigenvector_centrality = EigenvectorCentrality(g);

assert(isequal(round(cell2mat(eigenvector_centrality.getValue()), 6), round(cell2mat(known_eigenvector_centrality), 6)), ...
    [BRAPH2.STR ':EigenvectorCentrality:' BRAPH2.BUG_ERR], ...
    'EigenvectorCentrality is not being calculated correctly for GraphBU.')

%% Test 2: GraphWU
A = [
    0   .5  .5  0
    .5  0   0   .5 
    .5  0   0   .5
    0   .5  .5  0
    ];

known_eigenvector_centrality = {[1/2 1/2 1/2 1/2]'};

g = GraphWU(A);
eigenvector_centrality = EigenvectorCentrality(g);

assert(isequal(round(cell2mat(eigenvector_centrality.getValue()), 6), round(cell2mat(known_eigenvector_centrality), 6)), ...
    [BRAPH2.STR ':EigenvectorCentrality:' BRAPH2.BUG_ERR], ...
    'EigenvectorCentrality is not being calculated correctly for GraphWU.')

%% Test 3: MultiplexGraphBU
A11 = [
    0 1 1 0
    1 0 0 1
    1 0 0 1
    0 1 1 0
    ];
A12 = eye(4);
A21 = eye(4);
A22 = [
    0 1 1 0
    1 0 0 1
    1 0 0 1
    0 1 1 0
    ];
A = {
    A11     A12
    A21     A22
    };

known_eigenvector_centrality = {
    [1/2 1/2 1/2 1/2]'
    [1/2 1/2 1/2 1/2]'
    };

g = MultiplexGraphBU(A);
eigenvector_centrality = EigenvectorCentrality(g);

assert(isequal(round(cell2mat(eigenvector_centrality.getValue()), 6), round(cell2mat(known_eigenvector_centrality), 6)), ...
    [BRAPH2.STR ':EigenvectorCentrality:' BRAPH2.BUG_ERR], ...
    'EigenvectorCentrality is not being calculated correctly for MultiplexGraphBU.')

%% Test 4: MultiplexGraphWU
A11 = [
    0   .5  .5  0
    .5  0   0   .5 
    .5  0   0   .5
    0   .5  .5  0
    ];
A12 = eye(4);
A21 = eye(4);
A22 = [
    0   .5  .5  0
    .5  0   0   .5 
    .5  0   0   .5
    0   .5  .5  0
    ];
A = {
    A11     A12
    A21     A22
    };

known_eigenvector_centrality = {
    [1/2 1/2 1/2 1/2]'
    [1/2 1/2 1/2 1/2]'
    };

g = MultiplexGraphWU(A);
eigenvector_centrality = EigenvectorCentrality(g);

assert(isequal(round(cell2mat(eigenvector_centrality.getValue()), 6), round(cell2mat(known_eigenvector_centrality), 6)), ...
    [BRAPH2.STR ':EigenvectorCentrality:' BRAPH2.BUG_ERR], ...
    'EigenvectorCentrality is not being calculated correctly for MultiplexGraphWU.')
