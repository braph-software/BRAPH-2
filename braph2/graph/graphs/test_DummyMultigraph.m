% test DummyMultigraph
A_WD_1 = [
    1 0.2 1;
    0 1   0.3;
    1 0   1;
    ];

A_WD_2 = [
    1 0.2 1   0;
    0 1   0.3 0;
    1 0   1   1;
    0 0.1 1   1;
    ];

A = {
    A_WD_1	{}      {}
    {}      A_WD_1  {}
    {}      {}      A_WD_2
    };

%% Test 1: Constructor
g = DummyMultigraph([]); %#ok<NASGU>

%% Test 2: Node attack
nodes = 2;

A_WD_1_attack = [
    1 0 1;
    0 0 0;
    1 0 1;
    ]; 

A_WD_2_attack = [
    1 0 1 0;
    0 0 0 0;
    1 0 1 1;
    0 0 1 1;
    ];

% Attack all layers
g = DummyMultigraph(A);

A_attack = {
    A_WD_1_attack     {}              {}
    {}              A_WD_1_attack     {}
    {}              {}              A_WD_2_attack
    };

ng = g.nodeattack(g, nodes);

assert( isequal(ng.getA(), A_attack), ...
    [BRAPH2.STR ':DummyMultigraph:' BRAPH2.BUG_ERR], ...
    'Graph.nodeattack() is not working for non single layer graphs')

% Attack specified layers
g = DummyMultigraph(A);
layernumbers = [1, 3];

A_attack = {
    A_WD_1_attack     {}              {}
    {}              A_WD_1            {}
    {}              {}              A_WD_2_attack
    };

ng = g.nodeattack(g, nodes, layernumbers);

assert(isequal(ng.getA(), A_attack), ...
    [BRAPH2.STR ':DummyMultigraph:' BRAPH2.BUG_ERR], ...
    'Graph.nodeattack() is not working for non single layer graphs')

%% Test 3: Edge attack
nodes1 = [1, 1];
nodes2 = [2, 1];

A_WD_1_attack = [
    0 0 1;
    0 1 0.3;
    1 0 1;
    ]; 

A_WD_2_attack = [
    0 0   1   0;
    0 1   0.3 0;
    1 0   1   1;
    0 0.1 1   1;
    ];

% Attack all layers
g = DummyMultigraph(A);

A_attack = {
    A_WD_1_attack     {}              {}
    {}              A_WD_1_attack     {}
    {}              {}              A_WD_2_attack
    };

eg = g.edgeattack(g, nodes1, nodes2);

assert(isequal(eg.getA(), A_attack), ...
    [BRAPH2.STR ':DummyMultigraph:' BRAPH2.BUG_ERR], ...
    'Graph.edgeattack() is not working for non single layer graphs')

% Attack specified layers: layernumbers1
nodes1 = [1, 4, 2];
nodes2 = [2, 2, 3];
layernumbers1 = 3;
g = DummyMultigraph(A);

A_WD_2_attack = [
    1 0 1 0;
    0 1 0 0;
    1 0 1 1;
    0 0 1 1;
    ];

A_attack = {
    A_WD_1          {}              {}
    {}              A_WD_1          {}
    {}              {}              A_WD_2_attack
    };

eg = g.edgeattack(g, nodes1, nodes2, layernumbers1);

assert(isequal(eg.getA(), A_attack), ...
    [BRAPH2.STR ':DummyMultigraph:' BRAPH2.BUG_ERR], ...
    'Graph.edgeattack() is not working for non single layer graphs')

%% Test 4: Subgraph
nodes = [2, 3];

A_WD_1_subgraph = [
                  1   0.3
                  0   1
                  ];

A_WD_2_subgraph = [
                  1   0.3
                  0   1  
                  ];
            
A_subgraph = {
            A_WD_1_subgraph  {}               {}
            {}               A_WD_1_subgraph  {}
            {}               {}               A_WD_2_subgraph          
            };

g = DummyMultigraph(A);
sg = g.subgraph(g, nodes);

assert(isequal(sg.getA(), A_subgraph), ...
    [BRAPH2.STR ':DummyMultigraph:' BRAPH2.BUG_ERR], ...
    'Graph.subgraph() is not working for non single layer graphs')

% Subgraph with different nodes per layer
nodes = {[2, 3]
         [2, 3]
         [2, 3, 4]
         };

A_WD_1_subgraph = [
                  1   0.3
                  0   1
                  ];

A_WD_2_subgraph = [
                  1   .3  0
                  0   1   1
                  .1  1   1
                  ];
            
A_subgraph = {
            A_WD_1_subgraph  {}               {}
            {}               A_WD_1_subgraph  {}
            {}               {}               A_WD_2_subgraph          
            }; 

g = DummyMultigraph(A);
sg = g.subgraph(g, nodes);

assert(isequal(sg.getA(), A_subgraph), ...
    [BRAPH2.STR ':DummyMultigraph:' BRAPH2.BUG_ERR], ...
    'Graph.subgraph() is not working for non single layer graphs')