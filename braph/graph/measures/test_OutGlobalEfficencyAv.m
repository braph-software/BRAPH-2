% test OutGlobalEfficencyAv
A = rand(randi(10));
graph_class_list = {'GraphBD', 'GraphWD'};

%% Test 1: Calculation allgraphs
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
    g = Graph.getGraph(graph_class, A);
    ge = InGlobalEfficencyAv(g).getValue();
    
    assert(~isempty(ge), ...
        ['BRAPH:OutGlobalEfficencyAv: ' graph_class], ...
        ['OutGlobalEfficencyAv  is not calculating for ' graph_class])
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
    ge = InGlobalEfficencyAv(g).getValue(); 
    ge = round(ge, 4);

    switch (graph_class)       
        case 'GraphWD'
            known_solution = 0.1544;          
        case 'GraphBD'
            known_solution = 0.525;
    end
    
    assert( isequal(ge, known_solution), ...
        ['BRAPH:OutGlobalEfficencyAv: ' graph_class], ...
        ['OutGlobalEfficencyAv is not working for: ' graph_class ])
end
