% test InEccentricity
A = rand(randi(5));
graph_class_list = {'GraphBD', 'GraphWD'};

%% Test 1: Calculation AllGraphs
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
    g = Graph.getGraph(graph_class, A);
    ecc = InEccentricity(g).getValue();
    
    assert(~isempty(ecc), ...
        ['BRAPH:' graph_class ':InEccentricity'], ...
        ['InEccentricity is not calculated for ' graph_class])   
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
    ecc = InEccentricity(g).getValue();
    
    switch (graph_class)
        case 'GraphWD'
            known_solution = [
                8;
                5;
                13;
                12;
                0;
                ];
            
        case 'GraphBD'
            known_solution = [
                1;
                1;
                2;
                2;
                0;
                ];
    end  
    
    assert(isequal(ecc, known_solution), ...
        ['BRAPH:' graph_class ':InEccentricity'], ...
        ['InEccentricity is not calculated for ' graph_class])   
end