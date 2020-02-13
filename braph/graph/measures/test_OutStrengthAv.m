% test OutStrengthAv
A = rand(randi(10));

%% Test 1: OutStrengthAv calculates correctly for GraphWD
g = GraphWD(A);
OutStrengthAv = OutStrengthAv(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
out_strength_test = sum(A, 2);
average_out_strength_test = mean(out_strength_test);

assert(isequal(OutStrengthAv.getValue(), average_out_strength_test), ...
    'BRAPH:OutStrengthAv:Bug', ...
    'OutStrengthAv is not beeing calculated correctly for GraphWD')
