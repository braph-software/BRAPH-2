% test GraphWD
A = rand(randi(10));

%% Test 1: Constructor
g = GraphWD(A);

A = dediagonalize(A);
A = semipositivize(A);
A = standardize(A);

assert(isequal(g.getA(g), A), ...
       'BRAPH:GraphWD:Bug', ...
       'GraphWD is not constructing well')
