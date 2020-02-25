% test GlobalEfficency
A = rand(randi(5));
graph_class_list = {'GraphBU', 'GraphWU'};

%% Test 1: Calculation AllGraphs
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
    g = Graph.getGraph(graph_class, A);
    ge = GlobalEfficency(g);
    value = ge.getValue();
    
    assert(~isempty(value), ...
        ['BRAPH:GlobalEfficency: ' graph_class ], ...
        ['GlobalEfficency is not calculated for ' graph_class])
    
end

%% Test 2: Calculation vs Know Values
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
    ge = GlobalEfficency(g).getValue();
    ge = round(ge, 4);
    
    switch(graph_class)
        case 'GraphBU'
            kv = [
                0.75;
                0.75;
                0.75;
                0.75;
                0;
                ];
        case 'GraphWU'
            kv = [
                0.1625;
                0.425;
                0.2583;
                0.3958;
                0;
                ];
    end
    
    assert(isequal(ge, kv), ...
        ['BRAPH:GlobalEfficency: ' graph_class ], ...
        ['GlobalEfficency is not calculated for ' graph_class])
    
end