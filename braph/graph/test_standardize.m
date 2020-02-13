% test standardize
A = randn(randi(10));

%% Test 1: Standardize Range Default
B = standardize(A);

assert(isequal(B, A-min(A)/(max(A)-min(A))),...
    'BRAPH:standardize:Bug',...
    'Standardize default case (''range between 0 and 1'') not working correctly')

%% Test 2: Standardize One
B = standardize(A, 'StandardizeRule', 'one');

C = A;
C(C<0)=0;
C(C>1)=1;

assert(isequal(B, C),...
    'BRAPH:standardize:Bug',...
    'Standardize default case (''range between 0 and 1'') not working correctly')
