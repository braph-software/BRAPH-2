% test InStrengthAv
A = rand(randi(10));

%% Test 1: InStrengthAv calculates correctly for GraphWD
g = GraphWD(A);
in_strength_av = InStrengthAv(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
in_strength_test = sum(A, 1)';
in_strength_av_test = mean(in_strength_test);

assert(isequal(in_strength_av.getValue(), in_strength_av_test), ...
    'BRAPH:InStrengthAv:Bug', ...
    'InStrengthAv is not beeing calculated correctly for GraphWD')
