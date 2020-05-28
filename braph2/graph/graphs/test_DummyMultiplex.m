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
    [BRAPH2.STR ':DummyMultiplex:' BRAPH2.BUG_ERR], ...
    'Graph.nodeattack() is not working for non single layer graphs')

% Attack specified layers
g = DummyMultiplex([]);
A = g.getA();
layernumbers = [1, 3];
for i = layernumbers
    M = A{i, i};
    M(nodes(:), :) = 0;
    M(:, nodes(:)) = 0;
    A(i, i) = {M};
end

ng = g.nodeattack(g, nodes, layernumbers);

assert(isequal(ng.getA(), A), ...
    [BRAPH2.STR ':DummyMultiplex:' BRAPH2.BUG_ERR], ...
    'Graph.nodeattack() is not working for non single layer graphs')

%% Test 3: Edge attack
n = randi(4);
nodes1 = [randi(n), randi(n)];
nodes2 = [randi(n), randi(n)];

% Attack all layers
g = DummyMultiplex([]);
A = g.getA();
L = length(A);
for layer = 1:1:L
    M = A{layer, layer};
    M(sub2ind(size(M), nodes1, nodes2)) = 0;
    if layer < L/2 + 1
        M(sub2ind(size(M), nodes2, nodes1)) = 0;
    end
    A(layer, layer) = {M};
end    

eg = g.edgeattack(g, nodes1, nodes2);

assert(isequal(eg.getA(), A), ...
    [BRAPH2.STR ':DummyMultiplex:' BRAPH2.BUG_ERR], ...
    'Graph.edgeattack() is not working for non single layer graphs')