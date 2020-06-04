% test GraphWU

%% Test 1: Constructor
A = rand(randi(10));
g = GraphWU(A);

A = dediagonalize(A);
A = semipositivize(A);
A = symmetrize(A);    
A = standardize(A);
            
assert(isequal(g.getA(), A), ...
       [BRAPH2.STR ':GraphWU:' BRAPH2.BUG_ERR], ...
       'GraphWU is not constructing well')
