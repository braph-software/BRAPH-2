% test GraphWU
A = rand(randi(10));

%% Test 1: Constructor
g = GraphWU(A);

A = dediagonalize(A);
A = semipositivize(A);
A = symmetrize(A);    
A = standardize(A);
            
assert(isequal(g.getA(g), A), ...
       'BRAPH:GraphWU:Bug', ...
       'GraphWU is not constructing well')
