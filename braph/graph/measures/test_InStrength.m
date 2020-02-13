% test InStrength
A = rand(randi(10));

%% Test 1: InStrength calculates correctly for GraphWD
g = GraphWD(A);
InStrength = InStrength(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
in_strength = sum(A, 1)';

assert(isequal(InStrength.getValue(), in_strength), ...
    'BRAPH:InStrength:Bug', ...
    'InStrength is not beeing calculated correctly for GraphWD')
