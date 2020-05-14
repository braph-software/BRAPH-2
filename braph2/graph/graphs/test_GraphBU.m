% test GraphBU
A = rand(randi(10));

%% Test 1: Constructor
g = GraphBU(A);

A = dediagonalize(A); 
A = semipositivize(A); 
A = binarize(A);
A = symmetrize(A); 

assert(isequal(g.getA(g), A), ...
       'BRAPH:GraphBU:Bug', ...
       'GraphBU is not constructing well')
