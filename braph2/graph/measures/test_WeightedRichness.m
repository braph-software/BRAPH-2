% test WeightedRichness

%% Test 1: GraphWU
A = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

known_weighted_richness = {[1.1 1.1 2 0]'};

g = GraphWU(A);
weighted_richness = WeightedRichness(g, 'WeightedRichnessThreshold', 1);

assert(isequal(weighted_richness.getValue(), known_weighted_richness), ...
    [BRAPH2.STR ':WeightedRichness:' BRAPH2.BUG_ERR], ...
    'WeightedRichness is not being calculated correctly for GraphWU.')

%% Test 2: GraphWD
A = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];

known_weighted_richness = {[0 1 1 0]'};

g = GraphWD(A);
weighted_richness = WeightedRichness(g, 'WeightedRichnessThreshold', 1.8);

assert(isequal(weighted_richness.getValue(), known_weighted_richness), ...
    [BRAPH2.STR ':WeightedRichness:' BRAPH2.BUG_ERR], ...
    'WeightedRichness is not being calculated correctly for GraphWD.')

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

known_weighted_richness = {
                 [1.1 1.1 2 0]'
                 [2.1 1.9 2 1.8]'
                 };      

g = MultiplexGraphWU(A);
weighted_richness = WeightedRichness(g, 'WeightedRichnessThreshold', 1);

assert(isequal(weighted_richness.getValue(), known_weighted_richness), ...
    [BRAPH2.STR ':WeightedRichness:' BRAPH2.BUG_ERR], ...
    'WeightedRichness is not being calculated correctly for MultiplexGraphWU.')

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

known_weighted_richness = {
                 [0 1 1 0]'
                 [0 1 1 0]'
                 };      

g = MultiplexGraphWD(A);
weighted_richness = WeightedRichness(g, 'WeightedRichnessThreshold', 1.8);

assert(isequal(weighted_richness.getValue(), known_weighted_richness), ...
    [BRAPH2.STR ':WeightedRichness:' BRAPH2.BUG_ERR], ...
    'WeightedRichness is not being calculated correctly for MultiplexGraphWD.')