% test DummyOrderedMultiplex

A_BD = [
    1 1 1;
    0 1 1;
    1 0 1;
    ];

A_WD = [
    1  0.2  1;
    0  1    0.3;
    1  0    1;
    ];

A = {
    A_BD                diag(ones(3, 1))    {}  
    diag(ones(3, 1))    A_BD                diag(ones(3, 1))   
    {}                  diag(ones(3, 1))    A_WD                
    };

%% Test 1: Constructor
g = DummyOrderedMultiplex([]);  %#ok<NASGU>

%% Test 2: Node attack
nodes = 2;

A_WD_BD_attack = [
    1 0 1;
    0 0 0;
    1 0 1;
    ]; 

g = DummyOrderedMultiplex(A);

% Attack all layers
A_attack = {
    A_WD_BD_attack      diag(ones(3, 1))    {}  
    diag(ones(3, 1))    A_WD_BD_attack      diag(ones(3, 1))   
    {}                  diag(ones(3, 1))    A_WD_BD_attack                
    };

ng = g.nodeattack(g, nodes);

assert(isequal(ng.getA(), A_attack), ...
    [BRAPH2.STR ':DummyOrderedMultiplex:' BRAPH2.BUG_ERR], ...
    'Graph.nodeattack() is not working for non single layer graphs')

% Attack specified layers
layernumbers = [1, 3];

A_attack = {
    A_WD_BD_attack      diag(ones(3, 1))    {}  
    diag(ones(3, 1))    A_BD                diag(ones(3, 1))   
    {}                  diag(ones(3, 1))    A_WD_BD_attack                
    };

ng = g.nodeattack(g, nodes, layernumbers);

assert(isequal(ng.getA(), A_attack), ...
    [BRAPH2.STR ':DummyOrderedMultiplex:' BRAPH2.BUG_ERR], ...
    'Graph.nodeattack() is not working for non single layer graphs')

%% Test 3: Edge attack
nodes1 = [1, 1];
nodes2 = [2, 1];

A_BD_attack = [
    0 0 1;
    0 1 1;
    1 0 1;
    ]; 

A_WD_attack = [
    0  0  1;
    0  1  0.3;
    1  0  1;
    ];

g = DummyOrderedMultiplex(A);

% Attack all layers
A_attack = {
    A_BD_attack         diag(ones(3, 1))    {}  
    diag(ones(3, 1))    A_BD_attack         diag(ones(3, 1))   
    {}                  diag(ones(3, 1))    A_WD_attack                
    };

eg = g.edgeattack(g, nodes1, nodes2);

assert(isequal(eg.getA(), A_attack), ...
    [BRAPH2.STR ':DummyOrderedMultiplex:' BRAPH2.BUG_ERR], ...
    'Graph.edgeattack() is not working for non single layer graphs')

% Attack specified layers: layernumbers1
layernumbers1 = [1, 3];

A_attack = {
    A_BD_attack         diag(ones(3, 1))    {}  
    diag(ones(3, 1))    A_BD                diag(ones(3, 1))   
    {}                  diag(ones(3, 1))    A_WD_attack                
    };

eg = g.edgeattack(g, nodes1, nodes2, layernumbers1);

assert(isequal(eg.getA(), A_attack), ...
    [BRAPH2.STR ':DummyOrderedMultiplex:' BRAPH2.BUG_ERR], ...
    'Graph.edgeattack() is not working for non single layer graphs')

% Attack specified layers and between specified layers: layernumbers1, layernumbers2
layernumbers1 = [2, 3];
layernumbers2 = [2, 2];

A_32_attack = [
    0 0 0;
    0 1 0;
    0 0 1;
    ]; 

A_attack = {
    A_BD                diag(ones(3, 1))    {}  
    diag(ones(3, 1))    A_BD_attack         diag(ones(3, 1))   
    {}                  A_32_attack         A_WD               
    };

eg = g.edgeattack(g, nodes1, nodes2, layernumbers1, layernumbers2);

assert(isequal(eg.getA(), A_attack), ...
    [BRAPH2.STR ':DummyOrderedMultiplex:' BRAPH2.BUG_ERR], ...
    'Graph.edgeattack() is not working for non single layer graphs')
