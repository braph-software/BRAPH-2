% test Measure
graph_class_list = Graph.getList();

%% Test 1: Check all graphs are not abstract
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
	A = rand(randi(10));
    g = Graph.getGraph(graph_class, A);
end

%% Test 2: Check implementation of static functions
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
	A = rand(randi(10));
    g = Graph.getGraph(graph_class, A);

    assert(isequal(g.getClass(), graph_class), ...
    ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
    [graph_class '.getClass() should return ''' graph_class ''''])
    
    assert(ischar(g.getClass()), ...
        ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
        [graph_class '.getClass() should return a char array'])

    assert(ischar(g.getName()), ...
        ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
        [graph_class '.getName() should return a char array'])

    assert(ischar(g.getDescription()), ...
        ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
        [graph_class '.getDescription() should return a char array'])

    assert(islogical(g.is_weighted()), ...
        ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
        [graph_class '.is_weighted() should return a logical'])

    assert(islogical(g.is_binary()), ...
        ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
        [graph_class '.is_binary() should return a logical'])

    assert(islogical(g.is_directed()), ...
        ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
        [graph_class '.is_directed() should return a logical'])

    assert(islogical(g.is_undirected()), ...
        ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
        [graph_class '.is_undirected() should return a logical'])

    assert(islogical(g.is_selfconnected()), ...
        ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
        [graph_class '.is_selfconnected() should return a logical'])

    assert(islogical(g.is_nonnegative()), ...
        ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
        [graph_class '.is_nonnegative() should return a logical'])

    assert(iscell(g.getCompatibleMeasureList()), ...
        ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
        [graph_class '.getCompatibleMeasureList() should return a cell array'])

    assert(isnumeric(g.getCompatibleMeasureNumber()), ...
        ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
        [graph_class '.getCompatibleMeasureNumber() should return a number'])
end

%% Test 3: Either weighted or binary
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
    assert(Graph.is_weighted(graph_class) ~= Graph.is_binary(graph_class), ...
        ['BRAPH:' graph_class ':WeightedOrBinary'], ...
        [graph_class '.is_weighted() == ' graph_class '.is_binary()'])
end

%% Test 4: Either directed or undirected
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
    assert(Graph.is_directed(graph_class) ~= Graph.is_undirected(graph_class), ...
        ['BRAPH:Gra' graph_class 'ph:DirectedOrUndirected'], ...
        [graph_class '.is_directed() == ' graph_class '.is_undirected()'])
end

%% Test 5: Test subgraph
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
    n = randi([1 10],1,1);
    A =  rand(n);
    g = Graph.getGraph(graph_class, A);
    nodes = [randi([1 n],1,1), randi([1 n],1,1)];
    sub_graph = g.subgraph(nodes);
    removing_nodes_A = A(nodes, nodes);
    removed_nodes_g = Graph.getGraph(graph_class, removing_nodes_A);
    
    assert( isequal(g.getA(), removed_nodes_g.getA()), ...
        ['BRAPH:Gra' graph_class 'ph:DirectedOrUndirected'], ...
        [graph_class '.is_directed() == ' graph_class '.is_undirected()'])
end