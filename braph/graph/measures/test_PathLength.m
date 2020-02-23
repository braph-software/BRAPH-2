% test PathLength
A = rand(randi(5));
graph_class_list = Graph.getList();

%% Test 1: Calculation AllGraphs
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
    g = Graph.getGraph(graph_class, A);
    pathL = g.getMeasure('PathLength');
    value = pathL.getValue();
    
    assert(~isempty(value), ...
        ['BRAPH:' graph_class ':PathLength'], ...
        ['PathLength is not calculated for ' graph_class])    
    
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
    p = PathLength(g);
    p_value = p.getValue();
    
    known_solution = A;
    
    switch (graph_class)
        case 'GraphWD'
            known_solution = [
                4.3750 5.125 5.25 5.25 Inf;
                ];
        case 'GraphWU'
            known_solution = [
                3.5 2 2.5 2 Inf;
                ];
            
        case 'GraphBD'
            known_solution = [
               0.75 1 1 1 Inf;
                ];
            
        case 'GraphBU'
            known_solution = [
               0.75 0.75 0.75 0.75 Inf
                ];
    end
    
    assert( isequal(p_value, known_solution), ...
        ['BRAPH:PathLength: ' graph_class], ...
        ['PathLength is not working for: ' graph_class ])
end