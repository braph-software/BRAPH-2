% test Multirichness

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

known_multirichness = {[5/2 5/2 2 1]'};      

g = MultiplexGraphBU(A);
multirichness = Multirichness(g, 'RichnessThreshold', 1);

assert(isequal(multirichness.getValue(), known_multirichness), ...
    [BRAPH2.STR ':Multirichness:' BRAPH2.BUG_ERR], ...
    'Multirichness is not being calculated correctly for MultiplexGraphBU.')

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
     
known_multirichness = {[3/2 3/2 1 0]'};      

g = MultiplexGraphBD(A);
multirichness = Multirichness(g, 'RichnessThreshold', 2, 'MultirichnessCoefficients', [1/2, 1/2]);

assert(isequal(multirichness.getValue(), known_multirichness), ...
    [BRAPH2.STR ':Multirichness:' BRAPH2.BUG_ERR], ...
    'Multirichness is not being calculated correctly for MultiplexGraphBD.')

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

known_multirichness = {[9/4 9/4 2 1/2]'};      

g = MultiplexGraphWU(A);
multirichness = Multirichness(g, 'RichnessThreshold', 1, 'MultirichnessCoefficients', [3/4, 1/4]);

assert(isequal(multirichness.getValue(), known_multirichness), ...
    [BRAPH2.STR ':Multirichness:' BRAPH2.BUG_ERR], ...
    'Multirichness is not being calculated correctly for MultiplexGraphWU.')

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

known_multirichness = {[5/4 5/4 1/2 0]'};      

g = MultiplexGraphWD(A);
multirichness = Multirichness(g, 'RichnessThreshold', 2, 'MultirichnessCoefficients', [3/4, 1/4]);

assert(isequal(multirichness.getValue(), known_multirichness), ...
    [BRAPH2.STR ':Multirichness:' BRAPH2.BUG_ERR], ...
    'Multirichness is not being calculated correctly for MultiplexGraphWD.')