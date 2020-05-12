% test semipositivize
A = rand(randi(10));

%% Test 1: Rule Zero
B = semipositivize(A);
assert(isequal(B, max(A, 0)),...
    'BRAPH:semipositivize:Bug',...
    'Symmetrize default case (''Max'') not working correctly')

%% Test 2: Rule Absolute
B = semipositivize(A, 'SemipositivizeRule', 'Absolute');
assert(isequal(B, abs(A)),...
    'BRAPH:semipositivize:Bug',...
    'Symmetrize ''Absoltue'' case not working correctly')
