% test GraphWD

A = rand(randi(10));

%% Test 1: GraphWD instantiate well

g = GraphWD(A);

A = remove_diagonal(A);
A = remove_negative_weights(A);  

assert(isequal(g.getA(), A), ...
       'BRAPH:GraphWD:Bug', ...
       'GraphWD is not constructing well')