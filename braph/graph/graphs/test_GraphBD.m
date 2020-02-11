% test GraphBD

A = rand(randi(10));

%% Test 1: GraphBD instantiate well

g = GraphBD(A);

A = remove_diagonal(A); 
A = remove_negative_weights(A); 
A = binarize(A); 

assert(isequal(g.getA(), A), ...
       'BRAPH:GraphBD:Bug', ...
       'GraphBD is not constructing well')