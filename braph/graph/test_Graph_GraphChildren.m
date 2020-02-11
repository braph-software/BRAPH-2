% test graph_and_graph_children

A = [
    8 9 2; 
    9 6 5; 
    1 7 4;
    ];

G_WD = GraphWD(A);
G_WU = GraphWU(A);
G_BD = GraphBD(A);
G_BU = GraphBU(A);

graph_code_list = subclasses('Graph');

%% Test 1: All children either weighted or binary

for i = 1:1:length(graph_code_list)
    graph_code = graph_code_list{i};
    assert(eval([graph_code '.is_weighted() ~= ' graph_code '.is_binary()']), ...
        'BRAPH:Graph:WeightedOrBinary', ...
        [graph_code '.is_weighted() == ' graph_code '.is_binary()'])
end

%% Test 2: All children either directed or undirected

for i = 1:1:length(graph_code_list)
    graph_code = graph_code_list{i};
    assert(eval([graph_code '.is_directed() ~= ' graph_code '.is_undirected()']), ...
        'BRAPH:Graph:DirectedOrUndirected', ...
        [graph_code '.is_directed() == ' graph_code '.is_undirected()'])
end

%% Test 3: All children are not self connected

for i = 1:1:length(graph_code_list)
    graph_code = graph_code_list{i};
    assert(eval([graph_code '.is_selfconnected() == false']), ...
        'BRAPH:Graph:NotSelfConnected', ...
        [graph_code '.is_directed() == true'])
end

%% Test 4: All children are not negative 

for i = 1:1:length(graph_code_list)
    graph_code = graph_code_list{i};
    assert(eval([graph_code '.is_nonnegative() == true']), ...
        'BRAPH:Graph:NonNegative', ...
        [graph_code '.is_nonnegative() == false'])
end

%% Test 5: All children have name

for i = 1:1:length(graph_code_list)
    graph_code = graph_code_list{i};
    assert(eval([graph_code '.getName() ~= "" ']), ...
        'BRAPH:Graph:WithNoName', ...
        [graph_code '.getName() == ""'])
end

%% Test 6: All children have description

for i = 1:1:length(graph_code_list)
    graph_code = graph_code_list{i};
    assert(eval([graph_code '.getDescription() ~= "" ']), ...
        'BRAPH:Graph:WithNoDescription', ...
        [graph_code '.getDescription() == ""'])
end

%% Test 7: Graph Weighted Directed Constructs Well

assert( isequal(G_WD.getA(), ...
    [
    0 9 2;
    9 0 5;
    1 7 0;
    ]),...
    'BRAPH:GraphWD:Bug',...
    'GraphWD not constructing well')

%% Test 8: Graph Weighted Undirected Constructs Well

assert( isequal(G_WU.getA(), ...
    [
    0 9 2;
    9 0 7;
    2 7 0;
    ]),...
    'BRAPH:GraphWU:Bug',...
    'GraphWU not constructing well')

%% Test 9: Graph Binary Directed Constructs Well

assert( isequal(G_BD.getA(), ...
    [
    0 1 1;
    1 0 1;
    1 1 0;
    ]),...
    'BRAPH:GraphBD:Bug',...
    'GraphBD not constructing well')

%% Test 10: Graph Binary Undirected Constructs Well

assert( isequal(G_BU.getA(), ...
    [
    0 1 1;
    1 0 1;
    1 1 0;
    ]),...
    'BRAPH:GraphBU:Bug',...
    'GraphBU not constructing well')