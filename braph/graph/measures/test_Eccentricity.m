% test Eccentricity
A = rand(randi(5));
graph_class_list = {'GraphBU', 'GraphWU'};

%% Test 1: Calculation AllGraphs
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
    g = Graph.getGraph(graph_class, A);
    ecc = Eccentricity(g).getValue();
    
    assert(~isempty(ecc), ...
        ['BRAPH:' graph_class ':Eccentricity'], ...
        ['Eccentricity is not calculated for ' graph_class])   
end

%% Test 2: Calculation AllGraphs vs Known Solution
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
    ecc = Eccentricity(g).getValue();
    
    switch (graph_class)
        case 'GraphWU'
            known_solution = [
                5;
                5;
                5;
                4;
                0;
                ];
            
        case 'GraphBU'
            known_solution = [
                1;
                1;
                1;
                1;
                0;
                ];
    end  
    
    assert(isequal(ecc, known_solution), ...
        ['BRAPH:' graph_class ':Eccentricity'], ...
        ['Eccentricity is not calculated for ' graph_class])   
end