% test DummyMultiplex

%% Test 1: Constructor
g = DummyMultiplex([]);

%% Test 2: Node attack
n = randi(4);
nodes = [randi(n), randi(n)];
g = DummyMultiplex([]);
A = g.getA();

% Attack all layers
L = length(A);
for layer = 1:1:L
    M = A{layer, layer};
    M(nodes(:), :) = 0;
    M(:, nodes(:)) = 0;
    A(layer, layer) = {M};
end    

ng = g.nodeattack(g, nodes);

assert( isequal(ng.getA(), A), ...
    [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
    'Graph.nodeattack() is not working for non single layer graphs')

%% Test 3: Edge attack