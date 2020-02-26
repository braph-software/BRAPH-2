% test PathLengthAv
graph_class_list = {'GraphBU', 'GraphWU'};

%% Test 1: Calculation AllGraphs
for i = 1:1:length(graph_class_list)
    A = rand(randi(5));
    graph_class = graph_class_list{i};
    g = Graph.getGraph(graph_class, A);
    pathL = g.getMeasure('PathLengthAv');
    value = pathL.getValue();
    
    assert(~isempty(value), ...
        ['BRAPH:' graph_class ':PathLengthAv'], ...
        ['PathLengthAv is not calculated for ' graph_class])
    
end

%% Test 2: Calculation vs know value
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
    p = PathLengthAv(g);
    p_value = p.getValue();
    p_value = round(p_value,4);
    
    known_solution = A;
    
    switch (graph_class)
        case 'GraphWU'
            known_solution = Inf;
            
        case 'GraphBU'
            known_solution = Inf;
    end
    
    assert( isequal(p_value, known_solution), ...
        ['BRAPH:PathLength: ' graph_class], ...
        ['PathLength is not working for: ' graph_class ])
    
end

%% Test 3: Calculation vs know value subgraphs
for i = 1:1:length(graph_class_list)
 graph_class = graph_class_list{i};
    n = 5;
    L = [
        0 .1 .2 .25 2;
        .125 0 0 0 0;
        .2 .5 0 .25 0;
        .125 10 0 0 5;
        1 2 3 4 5;
        ];
    g = Graph.getGraph(graph_class, L);
    p = PathLengthAv(g, 'PathLengthAvRule', 'subgraphs');
    p_value = p.getValue();
    p_value = round(p_value,4);  

    
    switch (graph_class)
        case 'GraphWU'
            known_solution = 1.5;
            
        case 'GraphBU'
            known_solution = 1;
    end
    
    assert( isequal(p_value, known_solution), ...
        ['BRAPH:PathLength: ' graph_class], ...
        ['PathLength is not working for: ' graph_class ])
    
end