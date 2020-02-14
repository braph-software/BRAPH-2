% test InStrength
A = rand(randi(10));

%% Test 1: Calculation GraphWD
g = GraphWD(A);
in_strength = InStrength(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
in_strength_test = sum(A, 1)';

assert(isequal(in_strength.getValue(), in_strength_test), ...
    'BRAPH:InStrength:Bug', ...
    'InStrength is not beeing calculated correctly for GraphWD')
