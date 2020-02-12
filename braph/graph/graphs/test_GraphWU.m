% test GraphWU
A = rand(randi(10));

%% Test 1: GraphWU instantiates well
g = GraphWU(A);

A = dediagonalize(A);
A = semipositivize(A);
A = symmetrize(A);    

assert(isequal(g.getA(), A), ...
       'BRAPH:GraphWU:Bug', ...
       'GraphWU is not constructing well')
