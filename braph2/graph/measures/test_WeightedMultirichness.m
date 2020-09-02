% test WeightedMultirichness

%% Test 1: MultiplexGraphWU
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

known_weighted_multirichness = {[5.4/4 5.2/4 2 1.8/4]'};      

g = MultiplexGraphWU(A);
weighted_multirichness = WeightedMultirichness(g, 'WeightedRichnessThreshold', 1, 'WeightedMultirichnessCoefficients', [3/4, 1/4]);

assert(isequal(weighted_multirichness.getValue(), known_weighted_multirichness), ...
    [BRAPH2.STR ':WeightedMultirichness:' BRAPH2.BUG_ERR], ...
    'WeightedMultirichness is not being calculated correctly for MultiplexGraphWU.')

%% Test 2: MultiplexGraphWD
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

wmultirich(:, 1, 1) = [1.6 1.6 2 0]';
wmultirich(:, 1, 2) = [0 .5 .5 0]';
known_weighted_multirichness = {wmultirich};

g = MultiplexGraphWD(A);
weighted_multirichness = WeightedMultirichness(g, 'WeightedRichnessThreshold', [1.5, 2]);

assert(isequal(weighted_multirichness.getValue(), known_weighted_multirichness), ...
    [BRAPH2.STR ':WeightedMultirichness:' BRAPH2.BUG_ERR], ...
    'WeightedMultirichness is not being calculated correctly for MultiplexGraphWD.')