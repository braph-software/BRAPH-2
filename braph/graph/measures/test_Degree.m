% test Degree

A = rand(randi(10));

%% Test 1: Degree calculates correctly for GraphBU

g = GraphBU(A);
degree = Degree(g);
A = dediagonalize(A);
A = semipositivize(A);
A = binarize(A);
A = symmetrize(A);
dA = sum(A, 2);

assert(isequal(degree.getValue, dA), ...
    'BRAPH:Degree:Bug', ...
    'Degree is not beeing calculated correctly for GraphBU')

%% Test 2: Degree calculates correctly for GraphWU

g = GraphWU(A);
degree = Degree(g);
A = dediagonalize(A);
A = semipositivize(A);
A = symmetrize(A);
A = binarize(A);
dA = sum(A, 2);

assert(isequal(degree.getValue, dA), ...
    'BRAPH:Degree:Bug', ...
    'Degree is not beeing calculated correctly for GraphWU')

%% Test 3: Degree get Class correctly

g = GraphWU(A);
degree = Degree(g);

assert(isequal(degree.getClass, 'Degree'), ...
    'BRAPH:Degree:Bug', ...
    'Degree is not getting class correctly')

%% Test 4: Degree get Name correctly

g = GraphWU(A);
degree = Degree(g);

assert(isequal(degree.getName(), 'Degree'), ...
    'BRAPH:Degree:Bug', ...
    'Degree is not getting class correctly')

%% Test 5: Degree get Description works

g = GraphWU(A);
degree = Degree(g);

assert(ischar(degree.getDescription()), ...
    'BRAPH:Degree:Bug', ...
    'Degree is not getting class correctly')