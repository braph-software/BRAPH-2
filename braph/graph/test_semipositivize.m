% test semipositivize

A = rand(randi(10));

%% Test 1: Semipositivize Zero Default

B = semipositivize(A);
A = max(A, 0);

assert(isequal(B,A),...
    'BRAPH:semipositivize:Bug',...
    'Symmetrize max (default) case not working correctly')

%% Test 2: Semipositivize Absolute

B = semipositivize(A);
A = abs(A);

assert(isequal(B,A),...
    'BRAPH:semipositivize:Bug',...
    'Symmetrize Absoltue case not working correctly')
