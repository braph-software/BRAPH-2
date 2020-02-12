% test standardize
A = randn(10);


%% Test 1: Standardize Range Default
B = standardize(A);
assert(isequal(B, A/max(max(A))),...
    'BRAPH:standardize:Bug',...
    'Standardize default case (''range between 0 and 1'') not working correctly')

%% Test 2: Standardize One
C = standardize(A, 'StandardizeRule','one');
D = A;
D(D<0)=0;
D(D>1)=1;
assert(isequal(C, D),...
    'BRAPH:standardize:Bug',...
    'Standardize default case (''range between 0 and 1'') not working correctly')
