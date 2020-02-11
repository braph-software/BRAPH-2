% test symmetrize
A = [
    1 2 3; 
    2 3 1; 
    3 2 1
    ];

%% Test 1: Symmetrize Max Default
B = symmetrize(A);
assert(isequal(B,...
    [
    1 2 3;
    2 3 2;
    3 2 1;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize max (default) case not working correctly')

%% Test 2: Symmetrize Add
B = symmetrize(A, 'SymmetrizeRule', 'add');
assert(isequal(B,...
    [
    2 4 6;
    4 6 3;
    6 3 2;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize add case not working correctly')

%% Test 3: Symmetrize Sum
B = symmetrize(A, 'SymmetrizeRule', 'sum');
assert(isequal(B,...
    [
    2 4 6;
    4 6 3;
    6 3 2;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize sum case not working correctly')

%% Test 4: Symmetrize Average
B = symmetrize(A, 'SymmetrizeRule', 'average');
assert(isequal(B,...
    [
    1 2 3;
    2 3 1.5;
    3 1.5 1;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize average case not working correctly')

%% Test 5: Symmetrize Av
B = symmetrize(A, 'SymmetrizeRule', 'av');
assert(isequal(B,...
    [
    1 2 3;
    2 3 1.5;
    3 1.5 1;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize av case not working correctly')

%% Test 6: Symmetrize Minimum
B = symmetrize(A, 'SymmetrizeRule', 'minimum');
assert(isequal(B,...
    [
    1 2 3;
    2 3 1;
    3 1 1;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize minimum case not working correctly')

%% Test 7: Symmetrize Min
B = symmetrize(A, 'SymmetrizeRule', 'min');
assert(isequal(B,...
    [
    1 2 3;
    2 3 1;
    3 1 1;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize min case not working correctly')

%% Test 8: Symmetrize Or
B = symmetrize(A, 'SymmetrizeRule', 'or');
assert(isequal(B,...
    [
    1 2 3;
    2 3 1;
    3 1 1;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize or case not working correctly')

%% Test 9: Symmetrize Weak
B = symmetrize(A, 'SymmetrizeRule', 'weak');
assert(isequal(B,...
    [
    1 2 3;
    2 3 1;
    3 1 1;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize weak case not working correctly')