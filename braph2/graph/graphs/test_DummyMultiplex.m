% test DummyMultiplex
A_WU = [
    1    0.2  1;
    0.2  1    0.3;
    1    0.3  1;
    ];

A_BD = [
    1 1 1;
    0 1 1;
    1 0 1;
    ];

A = {
    A_WU                diag(ones(3, 1))    diag(ones(3, 1))    diag(ones(3, 1)) 
    diag(ones(3, 1))    A_WU                diag(ones(3, 1))    diag(ones(3, 1))
    diag(ones(3, 1))    diag(ones(3, 1))    A_BD                diag(ones(3, 1))
    diag(ones(3, 1))    diag(ones(3, 1))    diag(ones(3, 1))    A_BD
    };

%% Test 1: Constructor
g = DummyMultiplex([]); %#ok<NASGU>

%% Test 2: Node attack
nodes = 2;

A_WU_BD_attack = [
    1 0 1;
    0 0 0;
    1 0 1;
    ]; 

A_D_attack = [
    1 0 0;
    0 0 0;
    0 0 1;
    ]; 

g = DummyMultiplex(A);

% Attack all layers
A_attack = {
    A_WU_BD_attack  A_D_attack      A_D_attack      A_D_attack 
    A_D_attack      A_WU_BD_attack  A_D_attack      A_D_attack
    A_D_attack      A_D_attack      A_WU_BD_attack  A_D_attack
    A_D_attack      A_D_attack      A_D_attack      A_WU_BD_attack
    };

ng = g.nodeattack(g, nodes);

assert(isequal(ng.getA(), A_attack), ...
    [BRAPH2.STR ':DummyMultiplex:' BRAPH2.BUG_ERR], ...
    'Graph.nodeattack() is not working for non single layer graphs')

% Attack specified layers
g = DummyMultiplex(A);
layernumbers = [1, 3];

A_attack = {
    A_WU_BD_attack  A_D_attack          A_D_attack      A_D_attack
    A_D_attack      A_WU                A_D_attack      diag(ones(3, 1))
    A_D_attack      A_D_attack          A_WU_BD_attack  A_D_attack
    A_D_attack      diag(ones(3, 1))    A_D_attack      A_BD
    };

ng = g.nodeattack(g, nodes, layernumbers);

assert(isequal(ng.getA(), A_attack), ...
    [BRAPH2.STR ':DummyMultiplex:' BRAPH2.BUG_ERR], ...
    'Graph.nodeattack() is not working for non single layer graphs')

%% Test 3: Edge attack
nodes1 = [1, 1];
nodes2 = [2, 1];

A_BD_attack = [
    0 0 1;
    0 1 1;
    1 0 1;
    ]; 

A_WU_attack = [
    0 0   1;
    0 1   0.3;
    1 0.3 1;
    ];

% Attack all layers
g = DummyMultiplex(A);

A_attack = {
    A_WU_attack         diag(ones(3, 1))    diag(ones(3, 1))    diag(ones(3, 1)) 
    diag(ones(3, 1))    A_WU_attack         diag(ones(3, 1))    diag(ones(3, 1))
    diag(ones(3, 1))    diag(ones(3, 1))    A_BD_attack         diag(ones(3, 1))
    diag(ones(3, 1))    diag(ones(3, 1))    diag(ones(3, 1))    A_BD_attack 
    };

eg = g.edgeattack(g, nodes1, nodes2);

assert(isequal(eg.getA(), A_attack), ...
    [BRAPH2.STR ':DummyMultiplex:' BRAPH2.BUG_ERR], ...
    'Graph.edgeattack() is not working for non single layer graphs')

% Attack specified layers: layernumbers1
layernumbers1 = [1, 3];

A_attack = {
    A_WU_attack         diag(ones(3, 1))    diag(ones(3, 1))    diag(ones(3, 1)) 
    diag(ones(3, 1))    A_WU                diag(ones(3, 1))    diag(ones(3, 1))
    diag(ones(3, 1))    diag(ones(3, 1))    A_BD_attack         diag(ones(3, 1))
    diag(ones(3, 1))    diag(ones(3, 1))    diag(ones(3, 1))    A_BD
    };

eg = g.edgeattack(g, nodes1, nodes2, layernumbers1);

assert(isequal(eg.getA(), A_attack), ...
    [BRAPH2.STR ':DummyMultiplex:' BRAPH2.BUG_ERR], ...
    'Graph.edgeattack() is not working for non single layer graphs')

% Attack specified layers and between specified layers: layernumbers1, layernumbers2
layernumbers1 = [2, 3];
layernumbers2 = [2, 4];

A_34_attack = [
    0 0 0;
    0 1 0;
    0 0 1;
    ]; 

A_attack = {
    A_WU                diag(ones(3, 1))    diag(ones(3, 1))    diag(ones(3, 1)) 
    diag(ones(3, 1))    A_WU_attack         diag(ones(3, 1))    diag(ones(3, 1))
    diag(ones(3, 1))    diag(ones(3, 1))    A_BD                A_34_attack
    diag(ones(3, 1))    diag(ones(3, 1))    diag(ones(3, 1))    A_BD
    };

eg = g.edgeattack(g, nodes1, nodes2, layernumbers1, layernumbers2);

assert(isequal(eg.getA(), A_attack), ...
    [BRAPH2.STR ':DummyMultiplex:' BRAPH2.BUG_ERR], ...
    'Graph.edgeattack() is not working for non single layer graphs')