% test symmetrize
A = [
    1 2 3; 
    2 3 1; 
    3 2 1
    ];

%% Test 1: Rule Max
B = symmetrize(A);
assert(isequal(B,...
    [
    1 2 3;
    2 3 2;
    3 2 1;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize max (default) case not working correctly')

%% Test 2: Rule Add
B = symmetrize(A, 'SymmetrizeRule', 'add');
assert(isequal(B,...
    [
    2 4 6;
    4 6 3;
    6 3 2;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize add case not working correctly')

%% Test 3: Rule Sum
B = symmetrize(A, 'SymmetrizeRule', 'sum');
assert(isequal(B,...
    [
    2 4 6;
    4 6 3;
    6 3 2;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize sum case not working correctly')

%% Test 4: Rule Average
B = symmetrize(A, 'SymmetrizeRule', 'average');
assert(isequal(B,...
    [
    1 2 3;
    2 3 1.5;
    3 1.5 1;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize average case not working correctly')

%% Test 5: Rule Av
B = symmetrize(A, 'SymmetrizeRule', 'av');
assert(isequal(B,...
    [
    1 2 3;
    2 3 1.5;
    3 1.5 1;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize av case not working correctly')

%% Test 6: Rule Minimum
B = symmetrize(A, 'SymmetrizeRule', 'minimum');
assert(isequal(B,...
    [
    1 2 3;
    2 3 1;
    3 1 1;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize minimum case not working correctly')

%% Test 7: Rule Min
B = symmetrize(A, 'SymmetrizeRule', 'min');
assert(isequal(B,...
    [
    1 2 3;
    2 3 1;
    3 1 1;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize min case not working correctly')

%% Test 8: Rule Or
B = symmetrize(A, 'SymmetrizeRule', 'or');
assert(isequal(B,...
    [
    1 2 3;
    2 3 1;
    3 1 1;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize or case not working correctly')

%% Test 9: Rule Weak
B = symmetrize(A, 'SymmetrizeRule', 'weak');
assert(isequal(B,...
    [
    1 2 3;
    2 3 1;
    3 1 1;
    ]),...
    'BRAPH:symmetrize:Bug',...
    'Symmetrize weak case not working correctly')