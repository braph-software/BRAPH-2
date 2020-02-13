% test Degree
A = rand(randi(10));

%% Test 1: Degree calculates correctly for GraphBU
g = GraphBU(A);
degree = Degree(g);

A = dediagonalize(A);
A = semipositivize(A);
A = binarize(A);
A = symmetrize(A);
degree_test = sum(A, 2);

assert(isequal(degree.getValue(0, degree_test), ...
    'BRAPH:Degree:Bug', ...
    'Degree is not beeing calculated correctly for GraphBU')

%% Test 2: Degree calculates correctly for GraphWU
g = GraphWU(A);
degree = Degree(g);

A = dediagonalize(A);
A = semipositivize(A);
A = symmetrize(A);
A = binarize(A);
degree_test = sum(A, 2);

assert(isequal(degree.getValue(), degree_test), ...
    'BRAPH:Degree:Bug', ...
    'Degree is not beeing calculated correctly for GraphWU')
