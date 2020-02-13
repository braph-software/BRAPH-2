% test OutDegreeAv

A = rand(randi(10));

%% Test 1: InDegreeAv calculates correctly for GraphBD

g = GraphBD(A);
out_degree_av = InDegreeAv(g);
A = dediagonalize(A);
A = semipositivize(A);
A = binarize(A);

out_dA =  sum(A, 2);
out_dA_av = mean(out_dA);

assert(isequal(out_degree_av.getValue, out_dA_av), ...
    'BRAPH:OutDegreeAv:Bug', ...
    'OutDegreeAv is not beeing calculated correctly for GraphBD')

%% Test 2: OutDegreeAv calculates correctly for GraphWD

g = GraphWD(A);
out_degree_av = OutDegreeAv(g);
A = dediagonalize(A);
A = semipositivize(A);
out_dA =  sum(A, 2);
out_dA_av = mean(out_dA);

assert(isequal(out_degree_av.getValue, out_dA_av), ...
    'BRAPH:OutDegreeAv:Bug', ...
    'OutDegreeAv is not beeing calculated correctly for GraphWD')

%% Test 3: OutDegreeAv get Class correctly

g = GraphWD(A);
out_degree_av = OutDegreeAv(g);

assert(isequal(out_degree_av.getClass, 'OutDegreeAv'), ...
    'BRAPH:OutDegreeAv:Bug', ...
    'OutDegreeAv is not getting class correctly')

%% Test 4: OutDegreeAv get Name correctly

g = GraphWD(A);
out_degree_av = OutDegreeAv(g);

assert(isequal(out_degree_av.getName(), 'Average Out Degree'), ...
    'BRAPH:OutDegreeAv:Bug', ...
    'OutDegreeAv is not getting class correctly')

%% Test 5: OutDegreeAv get Description works

g = GraphWD(A);
out_degree_av = OutDegreeAv(g);

assert(ischar(out_degree_av.getDescription()), ...
    'BRAPH:OutDegreeAv:Bug', ...
    'OutDegreeAv is not getting class correctly')