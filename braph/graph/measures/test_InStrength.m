% test InStrength

A = rand(randi(10));

%% Test 1: InStrength calculates correctly for GraphWD

g = GraphWD(A);
InStrength = InStrength(g);
A = dediagonalize(A);
A = semipositivize(A);
in_sA = sum(A, 1)';

assert(isequal(InStrength.getValue, in_sA), ...
    'BRAPH:InStrength:Bug', ...
    'InStrength is not beeing calculated correctly for GraphWD')

%% Test 2: InStrength get Class correctly

g = GraphWD(A);
InStrength = InStrength(g);

assert(isequal(InStrength.getClass, 'InStrength'), ...
    'BRAPH:InStrength:Bug', ...
    'InStrength is not getting class correctly')

%% Test 3: InStrength get Name correctly

g = GraphWD(A);
InStrength = InStrength(g);

assert(isequal(InStrength.getName(), 'In-Strength'), ...
    'BRAPH:InStrength:Bug', ...
    'InStrength is not getting class correctly')

%% Test 4: InStrength get Description works

g = GraphWD(A);
InStrength = InStrength(g);

assert(ischar(InStrength.getDescription()), ...
    'BRAPH:InStrength:Bug', ...
    'InStrength is not getting class correctly')