% test StrengthAv

A = rand(randi(10));

%% Test 1: StrengthAv calculates correctly for GraphWU

g = GraphWU(A);
StrengthAv = StrengthAv(g);
A = dediagonalize(A);
A = semipositivize(A);
A = symmetrize(A);
sA = sum(A, 1)';
av_sA = mean(sA);

assert(isequal(StrengthAv.getValue, av_sA), ...
    'BRAPH:StrengthAv:Bug', ...
    'StrengthAv is not beeing calculated correctly for GraphWU')

%% Test 2: StrengthAv get Class correctly

g = GraphWU(A);
StrengthAv = StrengthAv(g);

assert(isequal(StrengthAv.getClass, 'StrengthAv'), ...
    'BRAPH:StrengthAv:Bug', ...
    'StrengthAv is not getting class correctly')

%% Test 3: StrengthAv get Name correctly

g = GraphWU(A);
StrengthAv = StrengthAv(g);

assert(isequal(StrengthAv.getName(), 'Average Strength'), ...
    'BRAPH:StrengthAv:Bug', ...
    'StrengthAv is not getting class correctly')

%% Test 4: StrengthAv get Description works

g = GraphWU(A);
StrengthAv = StrengthAv(g);

assert(ischar(StrengthAv.getDescription()), ...
    'BRAPH:StrengthAv:Bug', ...
    'StrengthAv is not getting class correctly')