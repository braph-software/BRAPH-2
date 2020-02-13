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

%% Test 3: InDegreeAv get Class correctly
g = GraphWD(A);
average_in_degree = InDegreeAv(g);

assert(isequal(average_in_degree.getClass(), 'InDegreeAv'), ...
    'BRAPH:InDegreeAv:Bug', ...
    'InDegreeAv is not getting class correctly')

%% Test 4: InDegreeAv get Name correctly
g = GraphWD(A);
average_in_degree = InDegreeAv(g);

assert(isequal(average_in_degree.getName(), 'Average In Degree'), ...
    'BRAPH:InDegreeAv:Bug', ...
    'InDegreeAv is not getting class correctly')

%% Test 5: InDegreeAv get Description works
g = GraphWD(A);
average_in_degree = InDegreeAv(g);

assert(ischar(average_in_degree.getDescription()), ...
    'BRAPH:InDegreeAv:Bug', ...
    'InDegreeAv is not getting class correctly')