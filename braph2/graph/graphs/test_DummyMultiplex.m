% test DummyMultiplex
A = {
    symmetrize(rand(3)) round(diag(rand(3, 1))) round(diag(rand(3, 1))) round(diag(rand(3, 1)))
    round(diag(rand(3, 1))) symmetrize(rand(3)) round(diag(rand(3, 1))) round(diag(rand(3, 1)))
    round(diag(rand(3, 1))) round(diag(rand(3, 1))) round(rand(3)) round(diag(rand(3, 1)))
    round(diag(rand(3, 1))) round(diag(rand(3, 1))) round(diag(rand(3, 1))) round(rand(3))
    };

%% Test 1: Constructor
g = DummyMultiplex(A, 'Settings', 4);

assert(isequal(g.getA(), A), ...
       'BRAPH:DummyMultiplex:Bug', ...
       'DummyMultiplex is not constructing well')