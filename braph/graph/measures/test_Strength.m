% test Strength
A = rand(randi(10));

%% Test 1: Calculation GraphWU
g = GraphWU(A);
strength = Strength(g);

A(1:length(A)+1:end) = 0;
A(A<0) = 0;
A = max(A, A');
strength_test = sum(A, 1)';

assert(isequal(strength.getValue(), strength_test), ...
    'BRAPH:Strength:Bug', ...
    'Strength is not beeing calculated correctly for GraphWU')
