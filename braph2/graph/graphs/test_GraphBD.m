% test GraphBD
A = rand(randi(10));

%% Test 1: Constructor
g = GraphBD(A);

A = dediagonalize(A);
A = semipositivize(A);
A = binarize(A);

assert(isequal(g.getA(), A), ...
    [BRAPH2.STR ':GraphBD:' BRAPH2.BUG_ERR], ...
    'GraphBD is not constructing well')
