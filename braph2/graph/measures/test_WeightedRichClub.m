% test WeightedRichClub

%% Test 1: GraphWU
A = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

r(1, 1, 1) = 3/4;
r(1, 1, 2) = 1;
r(1, 1, 3) = 0;
known_weighted_rich_club = {r};  

g = GraphWU(A);
weighted_rich_club = WeightedRichClub(g, 'WeightedRichClub.Parameter', [1, 1.5, 2]);
weighted_rich_club = weighted_rich_club.getValue();

assert(isequal(round(weighted_rich_club{1}, 10), round(known_weighted_rich_club{1}, 10)), ...
    [BRAPH2.STR ':WeightedRichClub:' BRAPH2.BUG_ERR], ...
    'WeightedRichClub is not being calculated correctly for GraphWU.')

%% Test 2: GraphWD
A = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];

wr(1, 1, 1) = 13/15;
wr(1, 1, 2) = 1;
known_weighted_rich_club = {wr};  

g = GraphWD(A);
weighted_rich_club = WeightedRichClub(g, 'WeightedRichClub.Parameter', [1.5, 2]); 

assert(isequal(weighted_rich_club.getValue(), known_weighted_rich_club), ...
    [BRAPH2.STR ':WeightedRichClub:' BRAPH2.BUG_ERR], ...
    'WeightedRichClub is not being calculated correctly for GraphWD.')

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

known_weighted_rich_club = {
                           3/4
                           1
                           };      

g = MultiplexGraphWU(A);
weighted_rich_club = WeightedRichClub(g);
weighted_rich_club = weighted_rich_club.getValue();

assert(isequal(round(weighted_rich_club{1}, 10), round(known_weighted_rich_club{1}, 10)), ...
    [BRAPH2.STR ':WeightedRichClub:' BRAPH2.BUG_ERR], ...
    'WeightedRichClub is not being calculated correctly for MultiplexGraphWU.')

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

wrichclub_l1(1, 1, 1) = 13/15;
wrichclub_l1(1, 1, 2) = 1;

wrichclub_l2(1, 1, 1) = 13/15;
wrichclub_l2(1, 1, 2) = 1;

known_weighted_rich_club = {
                 wrichclub_l1
                 wrichclub_l2
                 };             

g = MultiplexGraphWD(A);
weighted_rich_club = WeightedRichClub(g, 'WeightedRichClub.Parameter', [1.5, 2]);

assert(isequal(weighted_rich_club.getValue(), known_weighted_rich_club), ...
    [BRAPH2.STR ':WeightedRichClub:' BRAPH2.BUG_ERR], ...
    'WeightedRichClub is not being calculated correctly for MultiplexGraphWD.')