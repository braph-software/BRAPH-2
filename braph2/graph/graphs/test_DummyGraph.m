% test DummyGraph
A_BU = [
    0 1 0;
    1 0 1;
    0 1 0;
    ];

%% Test 1: Constructor
g = DummyGraph([]); %#ok<NASGU>

%% Test 2: Node attack
nodes = 1;

A_BU_attack = [
    0 0 0;
    0 0 1;
    0 1 0;
    ]; 

g = DummyGraph(A_BU);

% Attack 
ng = g.nodeattack(g, nodes);

assert(isequal(ng.getA(), A_BU_attack), ...
    [BRAPH2.STR ':DummyGraph:' BRAPH2.BUG_ERR], ...
    'Graph.nodeattack() is not working for single layer graphs')

%% Test 3: Edge attack
nodes1 = [1, 1];
nodes2 = [2, 1];

A_BU_attack = [
    0 0 0;
    0 0 1;
    0 1 0;
    ]; 

% Attack all layers
g = DummyGraph(A_BU);

eg = g.edgeattack(g, nodes1, nodes2);

assert(isequal(eg.getA(), A_BU_attack), ...
    [BRAPH2.STR ':DummyGraph:' BRAPH2.BUG_ERR], ...
    'Graph.edgeattack() is not working for single layer graphs')

%% Test 4: Subgraph
nodes = [2, 3];

A_BU_subgraph = [
                0 1;
                1 0;
                ]; 

g = DummyGraph(A_BU);
sg = g.subgraph(g, nodes);

assert(isequal(sg.getA(), A_BU_subgraph), ...
    [BRAPH2.STR ':DummyGraph:' BRAPH2.BUG_ERR], ...
    'Graph.subgraph() is not working for single layer graphs')