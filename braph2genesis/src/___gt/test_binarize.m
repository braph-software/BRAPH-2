%TEST_BINARIZE

A = [
    -1 1 0; 
    -1 5 -1; 
    2 3 11
    ];

%% Test 1: Basic
B = binarize(A);

assert(isequal(B, ...
    [
    1 1 0; 
    1 1 1; 
    1 1 1
    ]), ...
    [BRAPH2.STR ':binarize:' BRAPH2.WRONG_OUTPUT], ...
    'Binarize does not work correctly.')

%% Test 2 Threshold

A = [
    1 2 3 4 5;
    5 4 3 2 1;
    2 3 4 5 1;
    3 4 5 1 2;
    4 5 1 2 3;
    ];
T = 3;
T_A = binarize(A, 'threshold', T);

assert(isequal(T_A, ...
    [
    0 0 0 1 1; 
    1 1 0 0 0; 
    0 0 1 1 0;
    0 1 1 0 0;
    1 1 0 0 0;
    ]), ...
    [BRAPH2.STR ':binarize:' BRAPH2.WRONG_OUTPUT], ...
    'threshold does not work correctly.')

%% Test 3 Density
A = [
    0.001 0.002 0.003 0.004 0.005; 
    0.005 0.004 0.003 0.002 0.001;
    0.002 0.003 0.004 0.005 0.001;
    0.003 0.004 0.005 0.001 0.002;
    0.004 0.005 0.001 0.002 0.003;
    ];
D = 2;  % 2 percent
D_A = binarize(A, 'density', D);

assert(isequal(D_A, ...
    [
    0, 0, 0, 0, 0;
    0, 0, 0, 0, 0;
    0, 0, 0, 0, 0;
    0, 0, 0, 0, 0;
    0, 0, 0, 0, 0;
    ]), ...
    [BRAPH2.STR ':binarize:' BRAPH2.WRONG_OUTPUT], ...
    'density does not work correctly.')

D = 60;  % 60 percent
D_A = binarize(A, 'density', D);

assert(isequal(D_A, ...
    [
    0, 0, 1, 1, 1;
    1, 1, 1, 0, 0;
    0, 1, 1, 1, 0;
    1, 1, 1, 0, 0;
    1, 1, 0, 0, 1;
    ]), ...
    [BRAPH2.STR ':binarize:' BRAPH2.WRONG_OUTPUT], ...
    'density does not work correctly.')