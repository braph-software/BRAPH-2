% test GraphWD
A = rand(randi(10));

%% Test 1: GraphWD instantiates well
g = GraphWD(A);

A = dediagonalize(A);
A = semipositivize(A);

assert(isequal(g.getA(), A), ...
       'BRAPH:GraphWD:Bug', ...
       'GraphWD is not constructing well')
