% test InDegreeAv

A = rand(randi(10));

%% Test 1: InDegreeAv calculates correctly for GraphBD

g = GraphBD(A);
in_degree_av = InDegreeAv(g);
A = dediagonalize(A);
A = semipositivize(A);
A = binarize(A);

in_dA =  sum(A, 1)';
in_dA_av = mean(in_dA);

assert(isequal(in_degree_av.getValue, in_dA_av), ...
    'BRAPH:InDegreeAv:Bug', ...
    'InDegreeAv is not beeing calculated correctly for GraphBD')

%% Test 2: InDegreeAv calculates correctly for GraphWD

g = GraphWD(A);
in_degree_av = InDegreeAv(g);
A = dediagonalize(A);
A = semipositivize(A);
in_dA =  sum(A, 1)';
in_dA_av = mean(in_dA);

assert(isequal(in_degree_av.getValue, in_dA_av), ...
    'BRAPH:InDegreeAv:Bug', ...
    'InDegreeAv is not beeing calculated correctly for GraphWD')

%% Test 3: InDegreeAv get Class correctly

g = GraphWD(A);
in_degree_av = InDegreeAv(g);

assert(isequal(in_degree_av.getClass, 'InDegreeAv'), ...
    'BRAPH:InDegreeAv:Bug', ...
    'InDegreeAv is not getting class correctly')

%% Test 4: InDegreeAv get Name correctly

g = GraphWD(A);
in_degree_av = InDegreeAv(g);

assert(isequal(in_degree_av.getName(), 'Average In Degree'), ...
    'BRAPH:InDegreeAv:Bug', ...
    'InDegreeAv is not getting class correctly')

%% Test 5: InDegreeAv get Description works

g = GraphWD(A);
in_degree_av = InDegreeAv(g);

assert(ischar(in_degree_av.getDescription()), ...
    'BRAPH:InDegreeAv:Bug', ...
    'InDegreeAv is not getting class correctly')