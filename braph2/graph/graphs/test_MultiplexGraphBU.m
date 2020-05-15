% test MultiplexGraphBU
B = rand(randi(10));
A = {B, B; B, B};

%% Test 1: Constructor
g = MultiplexGraphBU(A);
B = semipositivize(B);
B = binarize(B); 
C = dediagonalize(B);
C = symmetrize(C);    
A = {C, diagonalize(B); diagonalize(B), C};

assert(isequal(g.getA(g), A), ...
       'BRAPH:MultiplexGraphBU:Bug', ...
       'MultiplexGraphBU is not constructing well')
