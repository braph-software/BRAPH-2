% test OutDegree
A = rand(randi(10));

%% Test 1: OutDegree calculates correctly for GraphBD
g = GraphBD(A);
out_degree = OutDegree(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A(A>0) = 1;
out_degree_test = sum(A, 2);

assert(isequal(out_degree.getValue, out_degree_test), ...
    'BRAPH:OutDegree:Bug', ...
    'OutDegree is not beeing calculated correctly for GraphBD')

%% Test 2: OutDegree calculates correctly for GraphWD
g = GraphWD(A);
out_degree = OutDegree(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
out_degree_test = sum(A, 2);

assert(isequal(out_degree.getValue, out_degree_test), ...
    'BRAPH:OutDegree:Bug', ...
    'OutDegree is not beeing calculated correctly for GraphWD')
