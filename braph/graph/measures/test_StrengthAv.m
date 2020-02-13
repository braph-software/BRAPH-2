% test StrengthAv
A = rand(randi(10));

%% Test 1: StrengthAv calculates correctly for GraphWU
g = GraphWU(A);
strength_av = StrengthAv(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A = max(A, A');
strength_test = sum(A, 1)';
strength_av_test = mean(strength_test);

assert(isequal(strength_av.getValue(), strength_av_test), ...
    'BRAPH:StrengthAv:Bug', ...
    'StrengthAv is not beeing calculated correctly for GraphWU')
