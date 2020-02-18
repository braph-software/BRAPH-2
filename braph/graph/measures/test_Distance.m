% test Distance
A = rand(randi(5));
graph_class_list = Graph.getList();

%% Test 1: Calculation AllGraphs
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};    
    g = Graph.getGraph(graph_class, A);
    distance = Distance(g);
    value = distance.getValue();
 
    assert(~isempty(value), ...
        ['BRAPH:' graph_class ':Distance'], ...
        ['Distance is not calculated for ' graph_class])
    
    assert(isequal(size(value), size(g.getA())), ...
        ['BRAPH:Distance: ' graph_class], ...
        ['Distance dim is not correct for ' graph_class])
end

%% Test 2: Calculation vs Known Values
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i}; 
    n = 5;
    L = [0 .1 .2 .25 0; .125 0 0 0 0; .2 .5 0 .25 0; .125 10 0 0 0];
    A = [L;zeros(1,n)];     
    g = Graph.getGraph(graph_class, A);
    dg = Distance(g);
    dg_value = dg.getValue();
    
    known_solution = A;
    
    switch (graph_class)
        case 'GraphWD'
            known_solution = [
                0 5 5 4 Inf;
                8 0 13 12 Inf;
                5 2 0 4 Inf;
                8 1 13 0 Inf;
                Inf Inf Inf Inf 0;
                ];
        case 'GraphWU'
            known_solution = [
                0 5 5 4 Inf;
                5 0 2 1 Inf;
                5 2 0 3 Inf;
                4 1 3 0 Inf;
                Inf Inf Inf Inf 0;
                ];
            
        case 'GraphBD'
            known_solution = [
                0 1 1 1 Inf;
                1 0 2 2 Inf;
                1 1 0 1 Inf;
                1 1 2 0 Inf;
                Inf Inf Inf Inf 0;
                ];
            
        case 'GraphBU'
             known_solution = [
                0 1 1 1 Inf;
                1 0 1 1 Inf;
                1 1 0 1 Inf;
                1 1 1 0 Inf;
                Inf Inf Inf Inf 0;
                ];          
    end

    assert( isequal(dg_value, known_solution), ...
        ['BRAPH:Distance: ' graph_class], ...
        ['Distance is not working for: ' graph_class ])
end

%% Test 3: Calculation vs BCT
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};    
    g = Graph.getGraph(graph_class, A);
    distance = Distance(g);
    value_distance = distance.getValue();
    
     switch(graph_class)
        case 'GraphBD'
            A(1:length(A)+1:end) = 0;
            A(A<0) = 0;
            A(A>0) = 1;
        case 'GraphBU'
            A(1:length(A)+1:end) = 0;
            A(A<0) = 0;
            A(A>0) = 1;
            A = max(A, A');
        case 'GraphWD'
            A(1:length(A)+1:end) = 0;
            A(A<0) = 0;
            A = standardize(A);
        case 'GraphWU'
            A(1:length(A)+1:end) = 0;
            A(A<0) = 0;
            A = max(A, A');
            A = standardize(A);
     end
    
     value_bct = zeros(size(A));
     
     if graph_class == 'GraphWD' | graph_class == 'GraphWU'
         ind = A~=0;
         A(ind) = A(ind).^-1;
         value_bct = distance_wei(A);
     else
         value_bct = distance_bin(A);
     end
 
    assert(isequal(value_distance, value_bct), ...
        ['BRAPH:' graph_class ':Distance'], ...
        ['Distance is not calculated for ' graph_class])    
   
end