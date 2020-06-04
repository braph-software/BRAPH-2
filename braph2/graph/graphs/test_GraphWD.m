% test GraphWD
A = rand(randi(10));

%% Test 1: Constructor
g = GraphWD(A);

A = dediagonalize(A);
A = semipositivize(A);
A = standardize(A);

assert(isequal(g.getA(), A), ...
       [BRAPH2.STR ':GraphWD:' BRAPH2.BUG_ERR], ...
       'GraphWD is not constructing well')
