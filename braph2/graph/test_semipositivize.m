% test semipositivize

A = rand(randi(10));

%% Test 1: Rule Zero
B = semipositivize(A);

assert(isequal(semipositivize(A), semipositivize(A, 'SemipositivizeRule', 'Zero')), ...
    [BRAPH2.STR ':standardize:' BRAPH2.BUG_FUNC], ...
    'Semipositivize with rule ''Zero'' must be the default.')

assert(isequal(B, max(A, 0)), ...
    [BRAPH2.STR ':semipositivize:' BRAPH2.WRONG_OUTPUT], ...
    'Semipositivize with rule ''Zero'' not working correctly.')

%% Test 2: Rule Absolute
B = semipositivize(A, 'SemipositivizeRule', 'Absolute');

assert(isequal(B, abs(A)), ...
    [BRAPH2.STR ':semipositivize:' BRAPH2.WRONG_OUTPUT], ...
    'Semipositivize with rule ''Absolute'' not working correctly.')
