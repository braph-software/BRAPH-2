% test diagonalize

A = [
    1 1 1; 
    2 2 2; 
    3 3 3
    ];

%% Test 1: Basic
B = diagonalize(A);

assert(isequal(B, ...
    [
    1 0 0; 
    0 2 0; 
    0 0 3
    ]), ...
    [BRAPH2.STR ':diagonalize:' BRAPH2.WRONG_OUTPUT], ...
    'Diagonalize does not work correctly.')