% test DummyMultigraph
A_WD = [
    1 2 1;
    0 1 3;
    1 0 1;
    ];

A = {
    A_WD	{}      {}
    {}      A_WD    {}
    {}      {}      A_WD
    };

%% Test 1: Constructor
g = DummyMultigraph([]);

%% Test 2: Node attack
nodes = 2;

A_WD_attack = [
    1 0 1;
    0 0 0;
    1 0 1;
    ]; 

% Attack all layers
g = DummyMultigraph(A);

A_attack = {
    A_WD_attack     {}              {}
    {}              A_WD_attack     {}
    {}              {}              A_WU_attack
    };

ng = g.nodeattack(g, nodes);

assert( isequal(ng.getA(), A_attack), ...
    [BRAPH2.STR ':DummyMultigraph:' BRAPH2.BUG_ERR], ...
    'Graph.nodeattack() is not working for non single layer graphs')

% Attack specified layers
g = DummyMultigraph(A);
layernumbers = [1, 3];

A_attack = {
    A_WD_attack     {}              {}
    {}              A_WD            {}
    {}              {}              A_WD_attack
    };

ng = g.nodeattack(g, nodes, layernumbers);

assert(isequal(ng.getA(), A_attack), ...
    [BRAPH2.STR ':DummyMultigraph:' BRAPH2.BUG_ERR], ...
    'Graph.nodeattack() is not working for non single layer graphs')

%% Test 3: Edge attack
nodes = 2;
nodes1 = [1, 1];
nodes2 = [2, 1];

A_WD_attack = [
    0 0 1;
    0 1 3;
    1 0 1;
    ]; 

% Attack all layers
g = DummyMultigraph(A);

A_attack = {
    A_WD_attack     {}              {}
    {}              A_WD_attack     {}
    {}              {}              A_WD_attack
    };

eg = g.edgeattack(g, nodes1, nodes2);

assert(isequal(eg.getA(), A_attack), ...
    [BRAPH2.STR ':DummyMultigraph:' BRAPH2.BUG_ERR], ...
    'Graph.edgeattack() is not working for non single layer graphs')

% Attack specified layers: layernumbers1
layernumbers1 = [1, 3];
g = DummyMultigraph(A);

A_attack = {
    A_WD_attack     {}              {}
    {}              A_WD            {}
    {}              {}              A_WD_attack
    };

eg = g.edgeattack(g, nodes1, nodes2, layernumbers1);

assert(isequal(eg.getA(), A_attack), ...
    [BRAPH2.STR ':DummyMultigraph:' BRAPH2.BUG_ERR], ...
    'Graph.edgeattack() is not working for non single layer graphs')
