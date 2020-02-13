% test InStrengthAv

A = rand(randi(10));

%% Test 1: InStrengthAv calculates correctly for GraphWD

g = GraphWD(A);
InStrengthAv = InStrengthAv(g);
A = dediagonalize(A);
A = semipositivize(A);
in_sA = sum(A, 1)';
in_sA_av = mean(in_sA);


assert(isequal(InStrengthAv.getValue, in_sA_av), ...
    'BRAPH:InStrengthAv:Bug', ...
    'InStrengthAv is not beeing calculated correctly for GraphWD')

%% Test 2: InStrengthAv get Class correctly

g = GraphWD(A);
InStrengthAv = InStrengthAv(g);

assert(isequal(InStrengthAv.getClass, 'InStrengthAv'), ...
    'BRAPH:InStrengthAv:Bug', ...
    'InStrengthAv is not getting class correctly')

%% Test 3: InStrengthAv get Name correctly

g = GraphWD(A);
InStrengthAv = InStrengthAv(g);

assert(isequal(InStrengthAv.getName(), 'Average In-Strength'), ...
    'BRAPH:InStrengthAv:Bug', ...
    'InStrengthAv is not getting class correctly')

%% Test 4: InStrengthAv get Description works

g = GraphWD(A);
InStrengthAv = InStrengthAv(g);

assert(ischar(InStrengthAv.getDescription()), ...
    'BRAPH:InStrengthAv:Bug', ...
    'InStrengthAv is not getting class correctly')