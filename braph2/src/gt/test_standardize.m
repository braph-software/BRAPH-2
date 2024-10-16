%TEST_STANDARDIZE

A = randn(randi([2 10]));

%% Test 1: Rule Threshold
B = standardize(A);

C = A;
C(C<0)=0;
C(C>1)=1;

assert(isequal(standardize(A), standardize(A, 'StandardizeRule', 'Threshold')), ...
    [BRAPH2.STR ':standardize:' BRAPH2.FAIL_TEST], ...
    'Standardize with rule ''Threshold'' must be the default.')

assert(isequal(B, C), ...
    [BRAPH2.STR ':standardize:' BRAPH2.FAIL_TEST], ...
    'Standardize with rule ''Threshold'' not working correctly.')
assert(~any(B(:) < 0), ...
    [BRAPH2.STR ':standardize:' BRAPH2.FAIL_TEST], ...
    'Standardize with rule ''Threshold'' giving values < 0.')
assert(~any(B(:) > 1), ...
    [BRAPH2.STR ':standardize:' BRAPH2.FAIL_TEST], ...
    'Standardize with rule ''Threshold'' giving values > 1.')

%% Test 2: Rule Range
B = standardize(A, 'StandardizeRule', 'Range');

assert(isequal(B, (A - min(A(:))) / (max(A(:)) - min(A(:)))), ...
    [BRAPH2.STR ':standardize:' BRAPH2.FAIL_TEST], ...
    'Standardize with rule ''Range'' not working correctly.')
assert(~any(B(:) < 0), ...
    [BRAPH2.STR ':standardize:' BRAPH2.FAIL_TEST], ...
    'Standardize with rule ''Range'' giving values < 0.')
assert(~any(B(:) > 1), ...
    [BRAPH2.STR ':standardize:' BRAPH2.FAIL_TEST], ...
    'Standardize with rule ''Range'' giving values > 1.')