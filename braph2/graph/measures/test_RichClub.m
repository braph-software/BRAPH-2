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
richclub = RichClub(g, 'RichClubThreshold', 3);

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
r(1, 1, 2) = 0;
r(1, 1, 3) = 0;

known_richclub = {r};  

g = GraphBD(A);
richclub = RichClub(g, 'RichClubThreshold', 3);

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

known_richclub = {[2 2 2 0]'};

g = GraphWU(A);
richclub = Richclub(g, 'RichClubThreshold', 3);

assert(isequal(richclub.getValue(), known_richclub), ...
    [BRAPH2.STR ':RichClub:' BRAPH2.BUG_ERR], ...
    'RichClub is not being calculated correctly for GraphWU.')