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

assert(isequal(out_degree.getValue(), average_out_degree_test), ...
    'BRAPH:OutDegreeAv:Bug', ...
    'OutDegreeAv is not beeing calculated correctly for GraphBD')

%% Test 2: OutDegreeAv calculates correctly for GraphWD
g = GraphWD(A);
out_degree = OutDegreeAv(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
out_degree_test =  sum(A, 2);
average_out_degree_test = mean(out_degree_test);

assert(isequal(out_degree.getValue(), average_out_degree_test), ...
    'BRAPH:OutDegreeAv:Bug', ...
    'OutDegreeAv is not beeing calculated correctly for GraphWD')
