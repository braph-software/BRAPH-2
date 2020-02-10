% test symmetrize
A = [
    1 2 3; 
    2 3 1; 
    3 2 1
    ];

%% Test 1: Symmetrize Default
B = symmetrize(A);
assert(isequal(B,...
    [
    1 2 3;
    2 3 2;
    3 2 1;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize default case not working correctly')

%% Test 2: Symmetrize Sum Add
B = symmetrize(A, 'SymmetrizeRule', 'add');
assert(isequal(B,...
    [
    2 4 6;
    4 6 3;
    6 3 2;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize sum, add case not working correctly')

%% Test 3: Symmetrize Average
B = symmetrize(A, 'SymmetrizeRule', 'av');
assert(isequal(B,...
    [
    1.000000000000000 2.000000000000000 3.000000000000000;
    2.000000000000000 3.000000000000000 1.500000000000000;
    3.000000000000000 1.500000000000000 1.000000000000000;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize av, average case not working correctly')

%% Test 4: Symmetrize Minimum
B = symmetrize(A, 'SymmetrizeRule', 'min');
assert(isequal(B,...
    [
    1 2 3;
    2 3 1;
    3 1 1;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize min, minimum, or, weak case not working correctly')