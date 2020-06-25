% test WeightedMultiplexCorePeriphery

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
known_weighted_multirichness = [5.4/4 5.2/4 2 1.8/4]';   
known_over = [5.4/4 7.6/4 2 4.2/4]';  
known_weighted_multiplex_core_periphery = {[0 0 1 0]'};    

g = MultiplexGraphWU(A);
weighted_multiplex_core_periphery = WeightedMultiplexCorePeriphery(g, 'WeightedRichnessThreshold', -1, 'WeightedMultirichnessCoefficients', [3/4, 1/4]);

assert(isequal(weighted_multiplex_core_periphery.getValue(), known_weighted_multiplex_core_periphery), ...
    [BRAPH2.STR ':WeightedMultiplexCorePeriphery:' BRAPH2.BUG_ERR], ...
    'WeightedMultiplexCorePeriphery is not being calculated correctly for MultiplexGraphWU.')

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

known_weighted_multirichness = [0 1 1 0]';   
known_over = [13.2/8 9/4 16.7/8 6.3/8]';  
known_weighted_multiplex_core_periphery = {[0 1 0 0]'};

g = MultiplexGraphWD(A);
weighted_multiplex_core_periphery = WeightedMultiplexCorePeriphery(g, 'WeightedRichnessThreshold', 1.8);

assert(isequal(weighted_multiplex_core_periphery.getValue(), known_weighted_multiplex_core_periphery), ...
    [BRAPH2.STR ':WeightedMultiplexCorePeriphery:' BRAPH2.BUG_ERR], ...
    'WeightedMultiplexCorePeriphery is not being calculated correctly for MultiplexGraphWD.')