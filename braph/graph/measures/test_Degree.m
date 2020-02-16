% test Degree
A = rand(randi(10));

%% Test 1: Calculation GraphBU
g = GraphBU(A);
degree = Degree(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A = max(A, A');
A(A>0) = 1;
degree_test = sum(A, 2);

assert(isequal(degree.getValue(), degree_test), ...
    'BRAPH:Degree:Bug', ...
    'Degree is not beeing calculated correctly for GraphBU')

%% Test 2: Calculation GraphWU
g = GraphWU(A);
degree = Degree(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A = max(A, A');
A(A>0) = 1;
degree_test = sum(A, 2);

assert(isequal(degree.getValue(), degree_test), ...
    'BRAPH:Degree:Bug', ...
    'Degree is not beeing calculated correctly for GraphWU')
