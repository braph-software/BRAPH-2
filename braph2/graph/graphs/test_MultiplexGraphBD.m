% test MultiplexGraphBD
B = rand(randi(10));
A = {B, B; B, B};

%% Test 1: Constructor
g = MultiplexGraphBD(A);

C = dediagonalize(B);
C = semipositivize(C);
C = binarize(C); 
A = {C, diagonalize(B); diagonalize(B), C};

assert(isequal(g.getA(), A), ...
       'BRAPH:MultiplexGraphBD:Bug', ...
       'MultiplexGraphBD is not constructing well')
