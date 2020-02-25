% test GlobalEfficencyAv
A = rand(randi(10));
graph_class_list = {'GraphBU', 'GraphWU'};

%% Test 1: Calculation allgraphs
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
    g = Graph.getGraph(graph_class, A);
    ge = GlobalEfficencyAv(g).getValue();
    
    assert(~isempty(ge), ...
        ['BRAPH:GlobalEfficencyAv: ' graph_class], ...
        ['GlobalEfficencyAv  is not calculating for ' graph_class])
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
    ge = GlobalEfficencyAv(g).getValue(); 
    ge = round(ge, 4);

    switch (graph_class)       
        case 'GraphWU'
            known_solution = 0.2483;          
        case 'GraphBU'
            known_solution = 0.6;
    end
    
    assert( isequal(ge, known_solution), ...
        ['BRAPH:GlobalEfficencyAv: ' graph_class], ...
        ['GlobalEfficencyAv is not working for: ' graph_class ])
end
