% test InDegree
A = rand(randi(10));

%% Test 1: InDegree calculates correctly for GraphBD
g = GraphBD(A);
in_degree = InDegree(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A(A>0) = 1;
in_degree_test = sum(A, 1)';

assert(isequal(in_degree.getValue(), in_degree_test), ...
    'BRAPH:InDegree:Bug', ...
    'InDegree is not beeing calculated correctly for GraphBD')

%% Test 2: InDegree calculates correctly for GraphWD
g = GraphWD(A);
in_degree = InDegree(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
in_degree_test = sum(A, 1)';

assert(isequal(in_degree.getValue(), in_degree_test), ...
    'BRAPH:InDegree:Bug', ...
    'InDegree is not beeing calculated correctly for GraphWD')
