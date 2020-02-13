% test OutStrengthAv

A = rand(randi(10));

%% Test 1: OutStrengthAv calculates correctly for GraphWD

g = GraphWD(A);
OutStrengthAv = OutStrengthAv(g);
A = dediagonalize(A);
A = semipositivize(A);
out_sA = sum(A, 2);
out_sA_av = mean(out_sA);

assert(isequal(OutStrengthAv.getValue, out_sA_av), ...
    'BRAPH:OutStrengthAv:Bug', ...
    'OutStrengthAv is not beeing calculated correctly for GraphWD')

%% Test 2: OutStrengthAv get Class correctly

g = GraphWD(A);
OutStrengthAv = OutStrengthAv(g);

assert(isequal(OutStrengthAv.getClass, 'OutStrengthAv'), ...
    'BRAPH:OutStrengthAv:Bug', ...
    'OutStrengthAv is not getting class correctly')

%% Test 3: OutStrengthAv get Name correctly

g = GraphWD(A);
OutStrengthAv = OutStrengthAv(g);

assert(isequal(OutStrengthAv.getName(), 'Average Out-Strength'), ...
    'BRAPH:OutStrengthAv:Bug', ...
    'OutStrengthAv is not getting class correctly')

%% Test 4: OutStrengthAv get Description works

g = GraphWD(A);
OutStrengthAv = OutStrengthAv(g);

assert(ischar(OutStrengthAv.getDescription()), ...
    'BRAPH:OutStrengthAv:Bug', ...
    'OutStrengthAv is not getting class correctly')