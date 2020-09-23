% test OutStrength
A = rand(randi(10));

%% Test 1: Calculation GraphWD
g = GraphWD(A);
out_strength = OutStrength(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
out_strength_test = sum(A, 2);

assert(isequal(out_strength.getValue(), out_strength_test), ...
    'BRAPH:OutStrength:Bug', ...
    'OutStrength is not beeing calculated correctly for GraphWD')
