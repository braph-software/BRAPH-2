% test DummyMultilayer
A_WD = [
    1  0.2   1    0;
    0  1     0.3  0;
    0  0.3   1    1;
    0  0.1   0    1;
    ];

A_BD = [
    1 1 1;
    0 1 1;
    1 0 1;
    ];

A_13 = randn(3, 4);
A_23 = round(rand(3, 4));
A_31 = randn(4, 3);
A_32 = round(rand(4, 3));

A = {
    A_BD                diag(ones(3, 1))    A_13
    diag(ones(3, 1))    A_BD                A_23 
    A_31                A_32                A_WD
    };

%% Test 1: Constructor
g = DummyMultilayer([]);  %#ok<NASGU>

%% Test 2: Node attack
nodes = 2;

A_WD_attack = [
    1  0  1  0;
    0  0  0  0;
    0  0  1  1;
    0  0  0  1;
    ];

A_BD_attack = [
    1 0 1;
    0 0 0;
    1 0 1;
    ];

g = DummyMultilayer(A); 

% Attack all layers

A_attack = {
    A_BD_attack         diag(ones(3, 1))    A_13
    diag(ones(3, 1))    A_BD_attack         A_23 
    A_31                A_32                A_WD_attack
    };

ng = g.nodeattack(g, nodes);

assert(isequal(ng.getA(), A_attack), ...
    [BRAPH2.STR ':DummyMultilayer:' BRAPH2.BUG_ERR], ...
    'Graph.nodeattack() is not working for non single layer graphs')

% Attack specified layers
g = DummyMultilayer(A);
layernumbers = [1, 3];

A_attack = {
    A_BD_attack         diag(ones(3, 1))    A_13
    diag(ones(3, 1))    A_BD                A_23 
    A_31                A_32                A_WD_attack
    };

ng = g.nodeattack(g, nodes, layernumbers);

assert(isequal(ng.getA(), A_attack), ...
    [BRAPH2.STR ':DummyMultilayer:' BRAPH2.BUG_ERR], ...
    'Graph.nodeattack() is not working for non single layer graphs')

%% Test 3: Edge attack
nodes1 = [1, 1];
nodes2 = [2, 1];

A_WD_attack = [
    0  0     1    0;
    0  1     0.3  0;
    0  0.3   1    1;
    0  0.1   0    1;
    ];

A_BD_attack = [
    0 0 1;
    0 1 1;
    1 0 1;
    ]; 

% Attack all layers
g = DummyMultilayer(A);

A_attack = {
    A_BD_attack         diag(ones(3, 1))    A_13
    diag(ones(3, 1))    A_BD_attack         A_23 
    A_31                A_32                A_WD_attack
    };

eg = g.edgeattack(g, nodes1, nodes2);

assert(isequal(eg.getA(), A_attack), ...
    [BRAPH2.STR ':DummyMultilayer:' BRAPH2.BUG_ERR], ...
    'Graph.edgeattack() is not working for non single layer graphs')

% Attack specified layers: layernumbers1
layernumbers1 = [1, 3];

A_attack = {
    A_BD_attack         diag(ones(3, 1))    A_13
    diag(ones(3, 1))    A_BD                A_23 
    A_31                A_32                A_WD_attack
    };

eg = g.edgeattack(g, nodes1, nodes2, layernumbers1);

assert(isequal(eg.getA(), A_attack), ...
    [BRAPH2.STR ':DummyMultilayer:' BRAPH2.BUG_ERR], ...
    'Graph.edgeattack() is not working for non single layer graphs')

% Attack specified layers and between specified layers: layernumbers1, layernumbers2
layernumbers1 = [2, 2];
layernumbers2 = [2, 1];

A_21_attack = [
    0 0 0;
    0 1 0;
    0 0 1;
    ]; 

A_attack = {
    A_BD           diag(ones(3, 1))     A_13
    A_21_attack    A_BD_attack          A_23 
    A_31           A_32                 A_WD
    };

eg = g.edgeattack(g, nodes1, nodes2, layernumbers1, layernumbers2);

assert(isequal(eg.getA(), A_attack), ...
    [BRAPH2.STR ':DummyMultilayer:' BRAPH2.BUG_ERR], ...
    'Graph.edgeattack() is not working for non single layer graphs')