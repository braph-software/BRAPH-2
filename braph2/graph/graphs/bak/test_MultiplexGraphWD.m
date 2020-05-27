% test MultiplexGraphWD
B = rand(randi(10));
A = {B, B; B, B};

%% Test 1: Constructor
g = MultiplexGraphWD(A);

C = dediagonalize(B);
C = semipositivize(C);  
A = {C, diagonalize(B); diagonalize(B), C};

assert(isequal(g.getA(g), A), ...
       'BRAPH:MultiplexGraphWD:Bug', ...
       'MultiplexGraphWU is not constructing well')
