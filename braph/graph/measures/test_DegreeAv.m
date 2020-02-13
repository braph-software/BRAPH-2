% test DegreeAv

A = rand(randi(10));

%% Test 1: DegreeAv calculates correctly for GraphBU

g = GraphBU(A);
degree_av = DegreeAv(g);
A = dediagonalize(A);
A = semipositivize(A);
A = binarize(A);
A = symmetrize(A);
dA = sum(A, 2);
dav_A = mean(dA);

assert(isequal(degree_av.getValue, dav_A), ...
    'BRAPH:DegreeAv:Bug', ...
    'DegreeAv is not beeing calculated correctly for GraphBU')

%% Test 2: DegreeAv calculates correctly for GraphWU

g = GraphWU(A);
degree_av = DegreeAv(g);
A = dediagonalize(A);
A = semipositivize(A);
A = symmetrize(A);
A = binarize(A);
dA = sum(A, 2);
dav_A = mean(dA);

assert(isequal(degree_av.getValue, dav_A), ...
    'BRAPH:DegreeAv:Bug', ...
    'DegreeAv is not beeing calculated correctly for GraphWU')

%% Test 3: Degree get Class correctly

g = GraphWU(A);
degree_av = DegreeAv(g);

assert(isequal(degree_av.getClass, 'DegreeAv'), ...
    'BRAPH:DegreeAv:Bug', ...
    'DegreeAv is not getting class correctly')

%% Test 4: DegreeAv get Name correctly

g = GraphWU(A);
degree_av = DegreeAv(g);

assert(isequal(degree_av.getName(), 'Average Degree'), ...
    'BRAPH:DegreeAv:Bug', ...
    'DegreeAv is not getting class correctly')

%% Test 5: DegreeAv get Description works

g = GraphWU(A);
degree_av = DegreeAv(g);

assert(ischar(degree_av.getDescription()), ...
    'BRAPH:DegreeAv:Bug', ...
    'DegreeAv is not getting class correctly')