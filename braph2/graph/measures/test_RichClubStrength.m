% test RichClubStrength

%% Test 1: GraphWU
A = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

known_rich_club_strength = {[1.1 1.1 2 0]'};

g = GraphWU(A);
rich_club_strength = RichClubStrength(g, 'RichClubStrength.Parameter', 1);

assert(isequal(rich_club_strength.getValue(), known_rich_club_strength), ...
    [BRAPH2.STR ':RichClubStrength:' BRAPH2.BUG_ERR], ...
    'RichClubStrength is not being calculated correctly for GraphWU.')

%% Test 2: GraphWD
A = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];

wrich(:, 1, 1) = [1.6 1.6 2 0]';
wrich(:, 1, 2) = [0 0 0 0]';
known_rich_club_strength = {wrich};

g = GraphWD(A);
rich_club_strength = RichClubStrength(g, 'RichClubStrength.Parameter', [1.5, 2]); 

assert(isequal(rich_club_strength.getValue(), known_rich_club_strength), ...
    [BRAPH2.STR ':RichClubStrength:' BRAPH2.BUG_ERR], ...
    'RichClubStrength is not being calculated correctly for GraphWD.')

%% Test 3: MultiplexGraphWU
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

known_rich_club_strength = {
                 [1.1 1.1 2 0]'
                 [2.1 1.9 2 1.8]'
                 };      

g = MultiplexGraphWU(A);
rich_club_strength = RichClubStrength(g);

assert(isequal(rich_club_strength.getValue(), known_rich_club_strength), ...
    [BRAPH2.STR ':RichClubStrength:' BRAPH2.BUG_ERR], ...
    'RichClubStrength is not being calculated correctly for MultiplexGraphWU.')

%% Test 4: MultiplexGraphWD
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

w_richness_l1(:, 1, 1) = [1.6 1.6 2 0]';
w_richness_l1(:, 1, 2) = [0 0 0 0]';

w_richness_l2(:, 1, 1) = [1.6 1.6 2 0]';
w_richness_l2(:, 1, 2) = [0 1 1 0]';

known_rich_club_strength = {
                 w_richness_l1
                 w_richness_l2
                 };            

g = MultiplexGraphWD(A);
rich_club_strength = RichClubStrength(g, 'RichClubStrength.Parameter', [1.5, 2]);

assert(isequal(rich_club_strength.getValue(), known_rich_club_strength), ...
    [BRAPH2.STR ':RichClubStrength:' BRAPH2.BUG_ERR], ...
    'RichClubStrength is not being calculated correctly for MultiplexGraphWD.')