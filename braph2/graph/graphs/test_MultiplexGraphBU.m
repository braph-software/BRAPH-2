% test MultiplexGraphBU
B = rand(randi(10));
A = {B, B; B, B};

%% Test 1: Constructor
g = MultiplexGraphBU(A);

C = dediagonalize(B);
C = semipositivize(C);
C = binarize(C);
C = symmetrize(C);    
A = {C, diagonalize(B); diagonalize(B), C};

assert(isequal(g.getA(), A), ...
       'BRAPH:MultiplexGraphBU:Bug', ...
       'MultiplexGraphBU is not constructing well')
