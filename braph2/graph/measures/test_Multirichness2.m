% test Multirichness2

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

known_multirichness2 = {[1/2 0 3/2 3/2]'};      

g = MultiplexGraphBU(A);
multirichness2 = Multirichness2(g, 'RichnessThreshold', 1);

assert(isequal(multirichness2.getValue(), known_multirichness2), ...
    [BRAPH2.STR ':Multirichness2:' BRAPH2.BUG_ERR], ...
    'Multirichness2 is not being calculated correctly for MultiplexGraphBU.')

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

known_multirichness2 = {[1 0 5/3 5/3]'};

g = MultiplexGraphBD(A);
multirichness2 = Multirichness2(g, 'RichnessThreshold', 2, 'MultirichnessCoefficients', [2/3, 1/3]);
multirichness2 = multirichness2.getValue();

assert(isequal(round(multirichness2{1}, 10), round(known_multirichness2{1}, 10)), ...
    [BRAPH2.STR ':Multirichness2:' BRAPH2.BUG_ERR], ...
    'Multirichness2 is not being calculated correctly for MultiplexGraphBD.')

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

known_multirichness2 = {[3/40 0 5/4 21/20]'};      

g = MultiplexGraphWU(A);
multirichness2 = Multirichness2(g, 'MultirichnessCoefficients', [3/4, 1/4]);
multirichness2 = multirichness2.getValue();

assert(isequal(round(multirichness2{1}, 10), round(known_multirichness2{1}, 10)), ...
    [BRAPH2.STR ':Multirichness2:' BRAPH2.BUG_ERR], ...
    'Multirichness2 is not being calculated correctly for MultiplexGraphWU.')

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

known_multirichness2 = {[3/5 0 3/2 7/8]'};

g = MultiplexGraphWD(A);
multirichness2 = Multirichness2(g, 'RichnessThreshold', 2, 'MultirichnessCoefficients', [2/4, 2/4]);

assert(isequal(multirichness2.getValue(), known_multirichness2), ...
    [BRAPH2.STR ':Multirichness2:' BRAPH2.BUG_ERR], ...
    'Multirichness2 is not being calculated correctly for MultiplexGraphWD.')