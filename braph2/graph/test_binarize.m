% test binarize

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