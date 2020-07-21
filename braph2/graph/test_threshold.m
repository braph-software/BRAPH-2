% test threshold

%% Test 1 Threshold

A = [1 2 3 4 5; 5 4 3 2 1; 2 3 4 5 1; 3 4 5 1 2; 4 5 1 2 3;];
T = 3;
T_A = threshold(A, T);

assert(isequal(T_A, ...
    [
    0 0 0 1 1; 
    1 1 0 0 0; 
    0 0 1 1 0;
    0 1 1 0 0;
    1 1 0 0 0;
    ]), ...
    [BRAPH2.STR ':threshold:' BRAPH2.WRONG_OUTPUT], ...
    'threshold does not work correctly.')

%% Test 2 Density
A = [1 2 3 4 5; 5 4 3 2 1; 2 3 4 5 1; 3 4 5 1 2; 4 5 1 2 3;];
D = 2;
D_A = threshold(A, 'density', D);

assert(isequal(D_A, ...
    [
    0, 1, 1, 1, 1;
    1, 1, 1, 1, 0;
    1, 1, 1, 1, 0;
    1, 1, 1, 0, 1;
    1, 1, 0, 1, 1;
    ]), ...
    [BRAPH2.STR ':threshold:' BRAPH2.WRONG_OUTPUT], ...
    'density does not work correctly.')
