% test MultiRichClubDegree

%% Test 1: MultiplexGraphBU
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

known_multi_rich_club_degree = {[5/2 5/2 2 1]'};      

g = MultiplexGraphBU(A);
multi_rich_club_degree = MultiRichClubDegree(g);

assert(isequal(multi_rich_club_degree.getValue(), known_multi_rich_club_degree), ...
    [BRAPH2.STR ':MultiRichClubDegree:' BRAPH2.BUG_ERR], ...
    'MultiRichClubDegree is not being calculated correctly for MultiplexGraphBU.')

%% Test 2: MultiplexGraphBD
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

mrich(:, 1, 1) = [5/2 3 13/6 5/3]';
mrich(:, 1, 2) = [4/3 4/3 2/3 0]';
known_multi_rich_club_degree = {mrich};

g = MultiplexGraphBD(A);
multi_rich_club_degree = MultiRichClubDegree(g, 'RichClubThreshold', 2, 'MultiRichClubCoefficients', [2/3, 1/3]);
multi_rich_club_degree = multi_rich_club_degree.getValue();

assert(isequal(round(multi_rich_club_degree{1}, 10), round(known_multi_rich_club_degree{1}, 10)), ...
    [BRAPH2.STR ':MultiRichClubDegree:' BRAPH2.BUG_ERR], ...
    'MultiRichClubDegree is not being calculated correctly for MultiplexGraphBD.')

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

known_multi_rich_club_degree = {[9/4 9/4 2 1/2]'};      

g = MultiplexGraphWU(A);
multi_rich_club_degree = MultiRichClubDegree(g, 'MultiRichClubCoefficients', [3/4, 1/4]);

assert(isequal(multi_rich_club_degree.getValue(), known_multi_rich_club_degree), ...
    [BRAPH2.STR ':MultiRichClubDegree:' BRAPH2.BUG_ERR], ...
    'MultiRichClubDegree is not being calculated correctly for MultiplexGraphWU.')

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

mrich(:, 1, 1) = [5/2 3 17/8 13/8]';
mrich(:, 1, 2) = [5/4 5/4 1/2 0]';
known_multi_rich_club_degree = {mrich};

g = MultiplexGraphWD(A);
multi_rich_club_degree = MultiRichClubDegree(g, 'RichClubThreshold', 2, 'MultiRichClubCoefficients', [3/4, 1/4]);

assert(isequal(multi_rich_club_degree.getValue(), known_multi_rich_club_degree), ...
    [BRAPH2.STR ':MultiRichClubDegree:' BRAPH2.BUG_ERR], ...
    'MultiRichClubDegree is not being calculated correctly for MultiplexGraphWD.')