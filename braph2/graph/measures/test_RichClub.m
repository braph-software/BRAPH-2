% test Richclub

%% Test 1: GraphBU
A = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

r(1, 1, 1) = .5;
r(1, 1, 2) = 0;
r(1, 1, 3) = 0;

known_richclub = {r};  
             
g = GraphBU(A);
richclub = RichClub(g, 'RichClub.Parameter', 3);

assert(isequal(richclub.getValue(), known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.BUG_ERR], ...
    'RichClub is not being calculated correctly for GraphBU.')

%% Test 2: GraphBD
A = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

r(1, 1, 1) = 3/4;
r(1, 1, 2) = 1/6;
r(1, 1, 3) = 0;

known_richclub = {r};  

g = GraphBD(A);
richclub = RichClub(g, 'RichClub.Parameter', 3);

assert(isequal(richclub.getValue(), known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.BUG_ERR], ...
    'RichClub is not being calculated correctly for GraphBD.')

%% Test 3: GraphWU
A = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

r(1, 1, 1) = .5;
r(1, 1, 2) = 0;
r(1, 1, 3) = 0;

known_richclub = {r};  

g = GraphWU(A);
richclub = RichClub(g, 'RichClub.Parameter', 3);

assert(isequal(richclub.getValue(), known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.BUG_ERR], ...
    'RichClub is not being calculated correctly for GraphWU.')

%% Test 4: GraphWD
A = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];

r(1, 1, 1) = 3/4;
r(1, 1, 2) = 1/6;
r(1, 1, 3) = 0;

known_richclub = {r}; 

g = GraphWD(A);
richclub = RichClub(g, 'RichClub.Parameter', 3);

assert(isequal(richclub.getValue(), known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.BUG_ERR], ...
    'RichClub is not being calculated correctly for GraphWD.')

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

known_richclub = {
                 1/2
                 5/6
                 };      
             
g = MultiplexGraphBU(A);
richclub = RichClub(g, 'RichClub.Parameter', 1);

assert(isequal(richclub.getValue(), known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.BUG_ERR], ...
    'RichClub is not being calculated correctly for MultiplexGraphBU.')

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

richclub_l1(1, 1, 1) = 3/4;
richclub_l1(1, 1, 2) = 1/6;

richclub_l2(1, 1, 1) = 5/6;
richclub_l2(1, 1, 2) = 1/2;

known_richclub = {
                 richclub_l1
                 richclub_l2
                 };      

g = MultiplexGraphBD(A);
richclub = RichClub(g, 'RichClub.Parameter', 2);

assert(isequal(richclub.getValue(), known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.BUG_ERR], ...
    'RichClub is not being calculated correctly for MultiplexGraphBD.')

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

known_richclub = {
                 1/2
                 5/6
                 };     

g = MultiplexGraphWU(A);
richclub = RichClub(g, 'RichClub.Parameter', 1);

assert(isequal(richclub.getValue(), known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.BUG_ERR], ...
    'RichClub is not being calculated correctly for MultiplexGraphWU.')

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

richclub_l1(1, 1, 1) = 3/4;
richclub_l1(1, 1, 2) = 1/6;

richclub_l2(1, 1, 1) = 5/6;
richclub_l2(1, 1, 2) = 1/2;

known_richclub = {
                 richclub_l1
                 richclub_l2
                 };  

g = MultiplexGraphWD(A);
richclub = RichClub(g, 'RichClub.Parameter', 2);

assert(isequal(richclub.getValue(), known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.BUG_ERR], ...
    'RichClub is not being calculated correctly for MultiplexGraphWD.')
