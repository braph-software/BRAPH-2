% test InDegreeAv
A = rand(randi(10));

%% Test 1: InDegreeAv calculates correctly for GraphBD
g = GraphBD(A);
average_in_degree = InDegreeAv(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A(A>0) = 1;
in_degree_test =  sum(A, 1)';
average_in_degree_test = mean(in_degree_test);

assert(isequal(average_in_degree.getValue(), average_in_degree_test), ...
    'BRAPH:InDegreeAv:Bug', ...
    'InDegreeAv is not beeing calculated correctly for GraphBD')

%% Test 2: InDegreeAv calculates correctly for GraphWD
g = GraphWD(A);
average_in_degree = InDegreeAv(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
in_degree_test =  sum(A, 1)';
average_in_degree_test = mean(in_degree_test);

assert(isequal(average_in_degree.getValue(), average_in_degree_test), ...
    'BRAPH:InDegreeAv:Bug', ...
    'InDegreeAv is not beeing calculated correctly for GraphWD')
