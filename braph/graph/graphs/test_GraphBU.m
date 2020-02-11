% test GraphBU
A = rand(randi(10));

%% Test 1: GraphBU instantiates well
g = GraphBU(A);

A = dediagonalize(A); 
A = semipositivize(A); 
A = binarize(A);
A = symmetrize(A); 

assert(isequal(g.getA(), A), ...
       'BRAPH:GraphBU:Bug', ...
       'GraphBU is not constructing well')
