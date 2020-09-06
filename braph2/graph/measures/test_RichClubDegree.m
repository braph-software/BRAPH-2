% test RichClubDegree

%% Test 1: GraphBU
A = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_richclubdegree = {[2 2 2 0]'};

g = GraphBU(A);
richclubdegree = RichClubDegree(g);

assert(isequal(richclubdegree.getValue(), known_richclubdegree), ...
    [BRAPH2.STR ':RichClubDegree:' BRAPH2.BUG_ERR], ...
    'RichClubDegree is not being calculated correctly for GraphBU.')

%% Test 2: GraphBD
A = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

rich(:, 1, 1) = [5/2 3 2 3/2]';
rich(:, 1, 2) = [1 1 0 0]';
known_richclubdegree = {rich};

g = GraphBD(A);
richclubdegree = RichClubDegree(g, 'RichClubThreshold', 2);

assert(isequal(richclubdegree.getValue(), known_richclubdegree), ...
    [BRAPH2.STR ':RichClubDegree:' BRAPH2.BUG_ERR], ...
    'RichClubDegree is not being calculated correctly for GraphBD.')

%% Test 3: GraphWU
A = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

known_richclubdegree = {[2 2 2 0]'};

g = GraphWU(A);
richclubdegree = RichClubDegree(g, 'RichClubThreshold', 1);

assert(isequal(richclubdegree.getValue(), known_richclubdegree), ...
    [BRAPH2.STR ':RichClubDegree:' BRAPH2.BUG_ERR], ...
    'RichClubDegree is not being calculated correctly for GraphWU.')

%% Test 4: GraphWD
A = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];

rich(:, 1, 1) = [5/2 3 2 3/2]';
rich(:, 1, 2) = [1 1 0 0]';
known_richclubdegree = {rich};

g = GraphWD(A);
richclubdegree = RichClubDegree(g, 'RichClubThreshold', 2);

assert(isequal(richclubdegree.getValue(), known_richclubdegree), ...
    [BRAPH2.STR ':RichClubDegree:' BRAPH2.BUG_ERR], ...
    'RichClubDegree is not being calculated correctly for GraphWD.')


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

known_richclubdegree = {
                 [2 2 2 0]'
                 [3 3 2 2]'
                 };      

g = MultiplexGraphBU(A);
richclubdegree = RichClubDegree(g, 'RichClubThreshold', 1);

assert(isequal(richclubdegree.getValue(), known_richclubdegree), ...
    [BRAPH2.STR ':RichClubDegree:' BRAPH2.BUG_ERR], ...
    'RichClubDegree is not being calculated correctly for MultiplexGraphBU.')

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

richness_l1(:, 1, 1) = [5/2 3 2 3/2]';
richness_l1(:, 1, 2) = [1 1 0 0]';

richness_l2(:, 1, 1) = [5/2 3 5/2 2]';
richness_l2(:, 1, 2) = [2 2 2 0]';

known_richclubdegree = {
                 richness_l1
                 richness_l2
                 };      

g = MultiplexGraphBD(A);
richclubdegree = RichClubDegree(g, 'RichClubThreshold', 2);

assert(isequal(richclubdegree.getValue(), known_richclubdegree), ...
    [BRAPH2.STR ':RichClubDegree:' BRAPH2.BUG_ERR], ...
    'RichClubDegree is not being calculated correctly for MultiplexGraphBD.')

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

known_richclubdegree = {
                 [2 2 2 0]'
                 [3 3 2 2]'
                 };      

g = MultiplexGraphWU(A);
richclubdegree = RichClubDegree(g, 'RichClubThreshold', 1);

assert(isequal(richclubdegree.getValue(), known_richclubdegree), ...
    [BRAPH2.STR ':RichClubDegree:' BRAPH2.BUG_ERR], ...
    'RichClubDegree is not being calculated correctly for MultiplexGraphWU.')

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

richness_l1(:, 1, 1) = [5/2 3 2 3/2]';
richness_l1(:, 1, 2) = [1 1 0 0]';

richness_l2(:, 1, 1) = [5/2 3 5/2 2]';
richness_l2(:, 1, 2) = [2 2 2 0]';

known_richclubdegree = {
                 richness_l1
                 richness_l2
                 };  

g = MultiplexGraphWD(A);
richclubdegree = RichClubDegree(g, 'RichClubThreshold', 2);

assert(isequal(richclubdegree.getValue(), known_richclubdegree), ...
    [BRAPH2.STR ':RichClubDegree:' BRAPH2.BUG_ERR], ...
    'RichClubDegree is not being calculated correctly for MultiplexGraphWD.')