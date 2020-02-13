% test OutStrength
A = rand(randi(10));

%% Test 1: OutStrength calculates correctly for GraphWD
g = GraphWD(A);
OutStrength = OutStrength(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
out_strength = sum(A, 2);

assert(isequal(OutStrength.getValue(), out_strength), ...
    'BRAPH:OutStrength:Bug', ...
    'OutStrength is not beeing calculated correctly for GraphWD')
