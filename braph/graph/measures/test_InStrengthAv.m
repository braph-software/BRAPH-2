% test InStrengthAv

A = rand(randi(10));

%% Test 1: InStrengthAv calculates correctly for GraphWD

g = GraphWD(A);
InStrengthAv = InStrengthAv(g);
A(1:length(A)+1:end) = 0;
A(A<0) = 0;
in_strength = sum(A, 1)';
average_in_strength = mean(in_strength);


assert(isequal(InStrengthAv.getValue, average_in_strength), ...
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