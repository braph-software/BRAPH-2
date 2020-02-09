% test remove_diagonal
A = [1 1 1; 1 1 1; 1 1 1];

%% Test 1: Remove diagonal
B = remove_diagonal(A);
assert(isequal(B, [0 1 1; 1 0 1; 1 1 0]), ...
    'BRAPH:remove_diagonal:Bug', ...
    'Diagonal not correctly set to 0')

%% Test 2: Remove diagonal and set value
value = randn();
B = remove_diagonal(A, value);
assert(isequal(B, [value 1 1; 1 value 1; 1 1 value]), ...
    'BRAPH:remove_diagonal:Bug', ...
    'Diagonal not correctly set to value')