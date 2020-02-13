% test StrengthAv
A = rand(randi(10));

%% Test 1: StrengthAv calculates correctly for GraphWU

g = GraphWU(A);
StrengthAv = StrengthAv(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A = max(A, A');
strength_test = sum(A, 1)';
average_strength_test = mean(strength_test);

assert(isequal(StrengthAv.getValue(), average_strength_test), ...
    'BRAPH:StrengthAv:Bug', ...
    'StrengthAv is not beeing calculated correctly for GraphWU')

%% Test 2: StrengthAv get Class correctly

g = GraphWU(A);
StrengthAv = StrengthAv(g);

assert(isequal(StrengthAv.getClass(), 'StrengthAv'), ...
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