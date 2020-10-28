% test EdgeNumberDistance
graph_class_list = {'GraphWD', 'GraphWU'};

%% Test 1: Calculation AllGraphs
A = rand(randi(5));
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
    
    g = Graph.getGraph(graph_class, A);
    edn = EdgeNumberDistance(g);
    value = edn.getValue();

    assert(~isempty(value), ...
        ['BRAPH:' graph_class ':EdgeNumberDistance'], ...
        ['EdgeNumberDistance is not calculated for ' graph_class])
end

%% Test 2: Calculation vs Known Values
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
    
    n = 5;
    L = [
        0 .1 .2 .25 0;
        .125 0 0 0 0;
        .2 .5 0 .25 0;
        .125 10 0 0 0
        ];
    A = [L;zeros(1,n)];
    g = Graph.getGraph(graph_class, A);
    edn = EdgeNumberDistance(g);
    value = edn.getValue();

    known_solution = A;
    switch (graph_class)
        case 'GraphWD'
            known_solution = [
                0 2 1 1 0;
                1 0 2 2 0;
                1 1 0 1 0;
                1 1 2 0 0;
                0 0 0 0 0;
                ];
        case 'GraphWU'
            known_solution = [
                0 2 1 1 0;
                2 0 1 1 0;
                1 1 0 2 0;
                1 1 2 0 0;
                0 0 0 0 0;
                ];              

    end

    assert(isequal(value, known_solution), ...
        ['BRAPH:' graph_class ':EdgeNumberDistance'], ...
        ['EdgeNumberDistance is not calculated for ' graph_class])
end