% test InPathLength
graph_class_list = {'GraphBD', 'GraphWD'};

%% Test 1: Calculation AllGraphs
for i = 1:1:length(graph_class_list)
    A = rand(randi(5));
    graph_class = graph_class_list{i};
    g = Graph.getGraph(graph_class, A);
    pathL = g.getMeasure('InPathLength');
    value = pathL.getValue();
    
    assert(~isempty(value), ...
        ['BRAPH:' graph_class ':InPathLength'], ...
        ['InPathLength is not calculated for ' graph_class])
    
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
    p = InPathLength(g);
    p_value = p.getValue();
    p_value = round(p_value, 4);
    
    known_solution = A;
    
    switch (graph_class)
        case 'GraphWD'
            known_solution = [
                7;
                2.6667;
                10.3333;
                6.6667;
                Inf;
                ];
            
        case 'GraphBD'
            known_solution = [
                1;
                1;
                1.6667;
                1.3333;
                Inf;
                ];
    end
    
    assert( isequal(p_value, known_solution), ...
        ['BRAPH:InPathLength: ' graph_class], ...
        ['InPathLength is not working for: ' graph_class ])
end

%% Test 3: Calculation Harmonic WD vs know Value

n = 5;
L = [
    0 .1 .2 .25 0;
    .125 0 0 0 0;
    .2 .5 0 .25 0;
    .125 10 0 0 0
    ];
A = [L;zeros(1,n)];
g = GraphWD(A);
p = InPathLength(g, 'InPathLengthAvRule', 'harmonic');
p_value = p.getValue();
p_value = round(p_value, 4);

known_solution = [
    6.6667;
    1.7647;
    8.4783;
    5.1429;
    Inf;
    ];

assert( isequal(p_value, known_solution), ...
    ['BRAPH:InPathLength:Harmonic '], ...
    ['PathLength is not working for: Harmonic mean'])

%% Test 4: Calculation subgraphs WD vs know Value
n = 5;
L = [
    0 .1 .2 .25 0;
    .125 0 0 0 0;
    .2 .5 0 .25 0;
    .125 10 0 0 0
    ];
A = [L;zeros(1,n)];
g = GraphWD(A);
p = InPathLength(g, 'PathLengthAvRule', 'subgraphs');
p_value = p.getValue();
p_value = round(p_value, 4);

known_solution = [
    7;
    2.6667;
    10.3333;
    6.6667;
    Inf;
    ];

assert( isequal(p_value, known_solution), ...
    ['BRAPH:InPathLength:Subgraphs '], ...
    ['InPathLength is not working for: Subgraphs mean'])