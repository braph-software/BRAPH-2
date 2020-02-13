% test InStrengthAv
A = rand(randi(10));

%% Test 1: InStrengthAv calculates correctly for GraphWD
g = GraphWD(A);
InStrengthAv = InStrengthAv(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
in_strength = sum(A, 1)';
average_in_strength = mean(in_strength);

assert(isequal(InStrengthAv.getValue(), average_in_strength), ...
    'BRAPH:InStrengthAv:Bug', ...
    'InStrengthAv is not beeing calculated correctly for GraphWD')
