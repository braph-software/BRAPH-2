% test OutStrengthAv
A = rand(randi(10));

%% Test 1: OutStrengthAv calculates correctly for GraphWD
g = GraphWD(A);
out_strength_av = OutStrengthAv(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
out_strength_test = sum(A, 2);
out_strength_av_test = mean(out_strength_test);

assert(isequal(out_strength_av.getValue(), out_strength_av_test), ...
    'BRAPH:OutStrengthAv:Bug', ...
    'OutStrengthAv is not beeing calculated correctly for GraphWD')
