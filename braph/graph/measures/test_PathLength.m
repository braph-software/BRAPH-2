% test PathLength
graph_class_list = {'GraphBU', 'GraphWU'};

%% Test 1: Calculation AllGraphs
for i = 1:1:length(graph_class_list)
    A = rand(randi(5));
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
    p_value = round(p_value,4);
    
    known_solution = A;
    
    switch (graph_class)
        case 'GraphWU'
            known_solution = [
                Inf;
                Inf;
                Inf;
                Inf;
                Inf;
                ];
            
        case 'GraphBU'
            known_solution = [
                Inf;
                Inf;
                Inf;
                Inf;
                Inf;
                ];
    end
    
    assert( isequal(p_value, known_solution), ...
        ['BRAPH:PathLength: ' graph_class], ...
        ['PathLength is not working for: ' graph_class ])
end

%% Test 3: Calculation Harmonic WU vs know Value

n = 5;
L = [
    0 .1 .2 .25 0;
    .125 0 0 0 0;
    .2 .5 0 .25 0;
    .125 10 0 0 0
    ];
A = [L;zeros(1,n)];
g = GraphWU(A);
p = PathLength(g, 'PathLengthAvRule', 'harmonic');
p_value = p.getValue();
p_value = round(p_value,4);

known_solution = [
    6.1538;
    2.3529;
    3.871;
    2.5263;
    Inf;
    ];

assert( isequal(p_value, known_solution), ...
    ['BRAPH:PathLength:Harmonic '], ...
    ['PathLength is not working for: Harmonic mean'])

%% Test 4: Calculation subgraphs WU vs know Value
n = 5;
L = [
    0 .1 .2 .25 0;
    .125 0 0 0 0;
    .2 .5 0 .25 0;
    .125 10 0 0 0
    ];
A = [L;zeros(1,n)];
g = GraphWU(A);
p = PathLength(g, 'PathLengthAvRule', 'subgraphs');
p_value = p.getValue();
p_value = round(p_value,4);

known_solution = [
    4.6667;
    2.6667;
    3.3333;
    2.6667;
    Inf;
    ];

assert( isequal(p_value, known_solution), ...
    ['BRAPH:PathLength:Subgraphs '], ...
    ['PathLength is not working for: Subgraphs mean'])