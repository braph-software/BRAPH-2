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
A = dediagonalize(A);
A = semipositivize(A);
out_degree_test = sum(A, 2);

assert(isequal(out_degree.getValue, out_degree_test), ...
    'BRAPH:OutDegree:Bug', ...
    'OutDegree is not beeing calculated correctly for GraphWD')

%% Test 3: OutDegree get Class correctly

g = GraphWD(A);
out_degree = OutDegree(g);

assert(isequal(out_degree.getClass, 'OutDegree'), ...
    'BRAPH:OutDegree:Bug', ...
    'OutDegree is not getting class correctly')

%% Test 4: OutDegree get Name correctly

g = GraphWD(A);
out_degree = OutDegree(g);

assert(isequal(out_degree.getName(), 'Out-Degree'), ...
    'BRAPH:OutDegree:Bug', ...
    'OutDegree is not getting class correctly')

%% Test 5: OutDegree get Description works

g = GraphWD(A);
out_degree = OutDegree(g);

assert(ischar(out_degree.getDescription()), ...
    'BRAPH:OutDegree:Bug', ...
    'OutDegree is not getting class correctly')