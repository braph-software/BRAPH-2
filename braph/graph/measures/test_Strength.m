% test Strength

A = rand(randi(10));

%% Test 1: Strength calculates correctly for GraphWU

g = GraphWU(A);
Strength = Strength(g);
A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A = max(A, A');
strength_test = sum(A, 1)';

assert(isequal(Strength.getValue, strength_test), ...
    'BRAPH:Strength:Bug', ...
    'Strength is not beeing calculated correctly for GraphWU')

%% Test 2: Strength get Class correctly

g = GraphWU(A);
Strength = Strength(g);

assert(isequal(Strength.getClass, 'Strength'), ...
    'BRAPH:Strength:Bug', ...
    'Strength is not getting class correctly')

%% Test 3: Strength get Name correctly

g = GraphWU(A);
Strength = Strength(g);

assert(isequal(Strength.getName(), 'Strength'), ...
    'BRAPH:Strength:Bug', ...
    'Strength is not getting class correctly')

%% Test 4: Strength get Description works

g = GraphWU(A);
Strength = Strength(g);

assert(ischar(Strength.getDescription()), ...
    'BRAPH:Strength:Bug', ...
    'Strength is not getting class correctly')