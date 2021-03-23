% test SCore

%% Test 1: GraphWU
A = [
    0   .5  1  0; 
    .5  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

known_score = {[
                0   .5  1  0;
                .5  0   1  0;
                1   1   0  0;
                0   0   0  0
                ]};

g = GraphWU(A);
score = SCore(g, 'SCoreThreshold', 1.5);

assert(isequal(score.getValue(), known_score), ...
    [BRAPH2.STR ':SCore:' BRAPH2.BUG_ERR], ...
    'SCore is not being calculated correctly for GraphWU.')

%% Test 2: GraphWD
A = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];

known_score = {[
                0   1  1  0; 
                .2  0  1  0; 
                1   1  0  0;
                0   0  0  0
                ]};

g = GraphWD(A);
score = SCore(g, 'SCoreThreshold', 3);

assert(isequal(score.getValue(), known_score), ...
    [BRAPH2.STR ':SCore:' BRAPH2.BUG_ERR], ...
    'SCore is not being calculated correctly for GraphWD.')

%% Test 3: MultiplexGraphWU
A11 = [
    0   .5  1  0; 
    .5  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];
A12 = eye(4);
A21 = eye(4);
A22 = [
    0   .5  1  0; 
    .5  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];
A = {
    A11     A12
    A21     A22
    };
             
known_score(1) = {[
                0   .5  1  0;
                .5  0   1  0;
                1   1   0  0;
                0   0   0  0
                ]};
known_score(2, 1) = {[
                0   .5  1  0;
                .5  0   1  0;
                1   1   0  0;
                0   0   0  0
                ]};            

g = MultiplexGraphWU(A);
score = SCore(g, 'SCoreThreshold', 1.5);

assert(isequal(score.getValue(), known_score), ...
    [BRAPH2.STR ':SCore:' BRAPH2.BUG_ERR], ...
    'SCore is not being calculated correctly for MultiplexGraphWU.')

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

known_score(1) = {[
                0   1  1  0; 
                .2  0  1  0; 
                1   1  0  0;
                0   0  0  0
                ]};
known_score(2, 1) = {[
                0   1  1  0; 
                .2  0  1  0; 
                1   1  0  0;
                0   0  0  0
                ]};            

g = MultiplexGraphWD(A);
score = SCore(g, 'SCoreThreshold', 3);

assert(isequal(score.getValue(), known_score), ...
    [BRAPH2.STR ':SCore:' BRAPH2.BUG_ERR], ...
    'SCore is not being calculated correctly for MultiplexGraphWD.')
