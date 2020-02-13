% test OutStrength

A = rand(randi(10));

%% Test 1: OutStrength calculates correctly for GraphWD

g = GraphWD(A);
OutStrength = OutStrength(g);
A = dediagonalize(A);
A = semipositivize(A);
out_sA = sum(A, 2);

assert(isequal(OutStrength.getValue, out_sA), ...
    'BRAPH:OutStrength:Bug', ...
    'OutStrength is not beeing calculated correctly for GraphWD')

%% Test 2: OutStrength get Class correctly

g = GraphWD(A);
OutStrength = OutStrength(g);

assert(isequal(OutStrength.getClass, 'OutStrength'), ...
    'BRAPH:OutStrength:Bug', ...
    'OutStrength is not getting class correctly')

%% Test 3: OutStrength get Name correctly

g = GraphWD(A);
OutStrength = OutStrength(g);

assert(isequal(OutStrength.getName(), 'Out-Strength'), ...
    'BRAPH:OutStrength:Bug', ...
    'OutStrength is not getting class correctly')

%% Test 4: OutStrength get Description works

g = GraphWD(A);
OutStrength = OutStrength(g);

assert(ischar(OutStrength.getDescription()), ...
    'BRAPH:OutStrength:Bug', ...
    'OutStrength is not getting class correctly')