% test dediagonalize
A = [
    1 1 1; 
    1 1 1; 
    1 1 1
    ];

%% Test 1: Diagonal to 0
B = dediagonalize(A);
assert(isequal(B, ...
    [
    0 1 1; 
    1 0 1; 
    1 1 0
    ]), ...
    'BRAPH:dediagonalize:Bug', ...
    'Diagonal not correctly set to 0')

%% Test 2: Diagonal to value
value = randn();
B = dediagonalize(A, 'DediagonalizeRule', value);
assert(isequal(B, ...
    [
    value 1 1; 
    1 value 1; 
    1 1 value
    ]), ...
    'BRAPH:dediagonalize:Bug', ...
    'Diagonal not correctly set to value')