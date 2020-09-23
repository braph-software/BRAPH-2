% test GraphBD
A = rand(randi(10));

%% Test 1: Constructor
g = GraphBD(A);

A = dediagonalize(A); 
A = semipositivize(A); 
A = binarize(A); 

assert(isequal(g.getA(), A), ...
       'BRAPH:GraphBD:Bug', ...
       'GraphBD is not constructing well')
