% test OutDegreeAv

A = rand(randi(10));

%% Test 1: InDegreeAv calculates correctly for GraphBD

g = GraphBD(A);
out_degree = InDegreeAv(g);
A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A(A>0) = 1;
out_degree_test =  sum(A, 2);
average_out_degree_test = mean(out_degree_test);

assert(isequal(out_degree.getValue, average_out_degree_test), ...
    'BRAPH:OutDegreeAv:Bug', ...
    'OutDegreeAv is not beeing calculated correctly for GraphBD')

%% Test 2: OutDegreeAv calculates correctly for GraphWD

g = GraphWD(A);
out_degree = OutDegreeAv(g);
A = dediagonalize(A);
A = semipositivize(A);
out_degree_test =  sum(A, 2);
average_out_degree_test = mean(out_degree_test);

assert(isequal(out_degree.getValue, average_out_degree_test), ...
    'BRAPH:OutDegreeAv:Bug', ...
    'OutDegreeAv is not beeing calculated correctly for GraphWD')

%% Test 3: OutDegreeAv get Class correctly

g = GraphWD(A);
out_degree = OutDegreeAv(g);

assert(isequal(out_degree.getClass, 'OutDegreeAv'), ...
    'BRAPH:OutDegreeAv:Bug', ...
    'OutDegreeAv is not getting class correctly')

%% Test 4: OutDegreeAv get Name correctly

g = GraphWD(A);
out_degree = OutDegreeAv(g);

assert(isequal(out_degree.getName(), 'Average Out Degree'), ...
    'BRAPH:OutDegreeAv:Bug', ...
    'OutDegreeAv is not getting class correctly')

%% Test 5: OutDegreeAv get Description works

g = GraphWD(A);
out_degree = OutDegreeAv(g);

assert(ischar(out_degree.getDescription()), ...
    'BRAPH:OutDegreeAv:Bug', ...
    'OutDegreeAv is not getting class correctly')