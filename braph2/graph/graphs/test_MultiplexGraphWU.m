% test MultiplexGraphWU
B = rand(randi(10));
A = {B, B; B, B};

%% Test 1: Constructor
g = MultiplexGraphWU(A);

C = dediagonalize(B);
C = semipositivize(C);
C = symmetrize(C);    
A = {C, diagonalize(B); diagonalize(B), C};

assert(isequal(g.getA(g), A), ...
       'BRAPH:MultiplexGraphWU:Bug', ...
       'MultiplexGraphWU is not constructing well')
