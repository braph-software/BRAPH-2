% test GraphBU

A = rand(randi(10));

%% Test 1: GraphBU instantiate well

g = GraphBU(A);

A = remove_diagonal(A); 
A = remove_negative_weights(A); 
A = binarize(A);
A = symmetrize(A); 

assert(isequal(g.getA(), A), ...
       'BRAPH:GraphBU:Bug', ...
       'GraphBU is not constructing well')