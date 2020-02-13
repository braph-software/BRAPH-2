% test DegreeAv
A = rand(randi(10));

%% Test 1: DegreeAv calculates correctly for GraphBU
g = GraphBU(A);
average_degree = DegreeAv(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A(A>0) = 1;
A = max(A, A');
degree_test = sum(A, 2);
average_degree_test = mean(degree_test);

assert(isequal(average_degree.getValue(), average_degree_test), ...
    'BRAPH:DegreeAv:Bug', ...
    'DegreeAv is not beeing calculated correctly for GraphBU')

%% Test 2: DegreeAv calculates correctly for GraphWU
g = GraphWU(A);
average_degree = DegreeAv(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A(A>0) = 1;
A = max(A, A');
degree_test = sum(A, 2);
average_degree_test = mean(degree_test);

assert(isequal(average_degree.getValue(), average_degree_test), ...
    'BRAPH:DegreeAv:Bug', ...
    'DegreeAv is not beeing calculated correctly for GraphWU')
