% test MultiplexGraphBD
B = rand(randi(10));
A = {B, B; B, B};

%% Test 1: Constructor
g = MultiplexGraphBD(A);
B = semipositivize(B);
B = binarize(B); 
C = dediagonalize(B);
A = {C, diagonalize(B); diagonalize(B), C};

assert(isequal(g.getA(), A), ...
       [BRAPH2.STR ':MultiplexGraphBD:' BRAPH2.BUG_ERR], ...
       'MultiplexGraphBD is not constructing well')
