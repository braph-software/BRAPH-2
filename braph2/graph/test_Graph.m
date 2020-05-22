% test Graph

graph_class_list = Graph.getList();

clear A
A{Graph.GRAPH} = rand(5);
A{Graph.MULTIGRAPH} = {
    rand(5) [] []
    [] rand(2) []
    [] [] rand(1)
    };
A{Graph.ORDERED_MULTIPLEX} = {
    rand(4) diag(rand(4, 1)) []
    diag(rand(4, 1)) rand(4) diag(rand(4, 1))
    [] diag(rand(4, 1)) rand(4)
    };
A{Graph.MULTIPLEX} = {
    rand(4) diag(rand(4, 1)) diag(rand(4, 1))
    diag(rand(4, 1)) rand(4) diag(rand(4, 1))
    diag(rand(4, 1)) diag(rand(4, 1)) rand(4)
    };
A{Graph.ORDERED_MULTILAYER} = {
    rand(3) rand(3, 2) []
    rand(2, 3) rand(2) rand(2, 4)
    [] rand(4, 2) rand(4)
    };
A{Graph.MULTILAYER} = {
    rand(3) rand(3, 2) rand(3, 4)
    rand(2, 3) rand(2) rand(2, 4)
    rand(4, 3) rand(4, 2) rand(4)
    };

%% Test 1.1: checkA
error_identifier = [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT];

% working case
for graph_type = 1:1:Graph.TYPE_NUMBER
	Graph.checkA(graph_type, A{graph_type})
end

% A formats that should never be accepted
clear A_wrong
A_wrong{1} = rand(5, 3);
A_wrong{2} = {rand(4, 3)};
A_wrong{3} = {rand(3, 4)};
A_wrong{4} = {
    rand(4, 3) rand(4) rand(4)
    rand(4) rand(4) rand(4)
    rand(4) rand(4) rand(4)
    };
A_wrong{5} = {
    rand(3, 4) rand(4) rand(4)
    rand(4) rand(4) rand(4)
    rand(4) rand(4) rand(4)
    };
A_wrong{6} = {rand(4) rand(4)};

for i = 1:1:length(A_wrong)
    for graph_type = 1:1:Graph.TYPE_NUMBER
        try 
            clear e
            Graph.checkA(graph_type, A_wrong{i})
        catch e
            assert(isequal(e.identifier, error_identifier), ...
                [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
                ['Expected error: ' error_identifier '. Instead, thrown error ' e.identifier])    
        end
        assert(exist('e', 'var') == 1, ...
            [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
            ['Error not thrown. Expected error: ' error_identifier])
    end
end

% Specific cases for ORDERED_MULTIPLEX and MULTIPLEX
clear A_wrong
A_wrong{1} = {
    rand(4) diag(rand(4, 1)) []
    diag(rand(4, 1)) rand(4) diag(rand(4, 1))
    [] diag(rand(4, 1)) rand(3)
    };
A_wrong{2} = {
    rand(4) diag(rand(4, 1)) diag(rand(4, 1))
    diag(rand(4, 1)) rand(4) diag(rand(3, 1))
    diag(rand(4, 1)) diag(rand(4, 1)) rand(4)
    };
A_wrong{3} = {
    rand(4) diag(rand(4, 1)) diag(rand(4, 1))
    diag(rand(4, 1)) rand(4) diag(rand(4, 1))
    diag(rand(4, 1)) diag(rand(3, 1)) rand(4)
    };

for i = 1:1:length(A_wrong)
    for graph_type = [Graph.ORDERED_MULTIPLEX, Graph.MULTIPLEX] 
        try 
            clear e
            Graph.checkA(graph_type, A_wrong{i})
        catch e
            assert(isequal(e.identifier, error_identifier), ...
                [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
                ['Expected error: ' error_identifier '. Instead, thrown error ' e.identifier])    
        end
        assert(exist('e', 'var') == 1, ...
            [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
            ['Error not thrown. Expected error: ' error_identifier])
    end
end

% Specific cases for MULTIPLEX
clear A_wrong
A_wrong{1} = {
    rand(4) diag(rand(4, 1)) diag(rand(3, 1))
    diag(rand(4, 1)) rand(4) diag(rand(4, 1))
    diag(rand(4, 1)) diag(rand(4, 1)) rand(4)
    };
A_wrong{2} = {
    rand(4) diag(rand(4, 1)) diag(rand(4, 1))
    diag(rand(4, 1)) rand(4) diag(rand(4, 1))
    rand(3, 1) diag(rand(4, 1)) rand(4)
    };

for i = 1:1:length(A_wrong)
    for graph_type = [Graph.MULTIPLEX]
        try 
            clear e
            Graph.checkA(graph_type, A_wrong{i})
        catch e
            assert(isequal(e.identifier, error_identifier), ...
                [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
                ['Expected error: ' error_identifier '. Instead, thrown error ' e.identifier])    
        end
        assert(exist('e', 'var') == 1, ...
            [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
            ['Error not thrown. Expected error: ' error_identifier])
    end
end

% Specific cases for ORDERED_MULTILAYER and MULTILAYER
clear A_wrong
A_wrong{1} = {
    rand(3) rand(3, 3) rand(3, 4)
    rand(2, 3) rand(2) rand(2, 4)
    rand(4, 3) rand(4, 2) rand(4)
    };
A_wrong{2} = {
    rand(3) rand(3, 2) rand(3, 4)
    rand(2, 3) rand(2) rand(2, 2)
    rand(4, 3) rand(4, 2) rand(4)
    };
A_wrong{3} = {
    rand(3) rand(3, 2) rand(3, 4)
    rand(3, 3) rand(2) rand(2, 4)
    rand(4, 3) rand(4, 2) rand(4)
    };
A_wrong{4} = {
    rand(3) rand(3, 2) rand(3, 4)
    rand(2, 3) rand(2) rand(2, 4)
    rand(4, 3) rand(4, 4) rand(4)
    };

for i = 1:1:length(A_wrong)
    for graph_type = [Graph.ORDERED_MULTILAYER, Graph.MULTILAYER] 
        try 
            clear e
            Graph.checkA(graph_type, A_wrong{i})
        catch e
            assert(isequal(e.identifier, error_identifier), ...
                [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
                ['Expected error: ' error_identifier '. Instead, thrown error ' e.identifier])    
        end
        assert(exist('e', 'var') == 1, ...
            [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
            ['Error not thrown. Expected error: ' error_identifier])
    end
end

% Specific cases for MULTILAYER
clear A_wrong
A_wrong{1} = {
    rand(3) rand(3, 2) rand(4, 4)
    rand(2, 3) rand(2) rand(2, 4)
    rand(4, 3) rand(4, 2) rand(4)
    };
A_wrong{2} = {
    rand(3) rand(3, 2) rand(3, 3)
    rand(2, 3) rand(2) rand(2, 4)
    rand(4, 3) rand(4, 2) rand(4)
    };
A_wrong{3} = {
    rand(3) rand(3, 2) rand(3, 4)
    rand(2, 3) rand(2) rand(2, 4)
    rand(3, 3) rand(4, 2) rand(4)
    };
A_wrong{4} = {
    rand(3) rand(3, 2) rand(3, 4)
    rand(2, 3) rand(2) rand(2, 4)
    rand(4, 4) rand(4, 2) rand(4)
    };

for i = 1:1:length(A_wrong)
    for graph_type = [Graph.MULTILAYER]
        try 
            clear e
            Graph.checkA(graph_type, A_wrong{i})
        catch e
            assert(isequal(e.identifier, error_identifier), ...
                [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
                ['Expected error: ' error_identifier '. Instead, thrown error ' e.identifier])    
        end
        assert(exist('e', 'var') == 1, ...
            [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
            ['Error not thrown. Expected error: ' error_identifier])
    end
end

%% Test 1.2: checkConnectivity
error_identifier = [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT];

connectivity_type{1} = Graph.BINARY;
B{1} = 0;
works{1} = true; 

connectivity_type{2} = Graph.BINARY;
B{2} = 1;
works{2} = true; 

connectivity_type{3} = Graph.BINARY;
B{3} = zeros(3);
works{3} = true; 

connectivity_type{4} = Graph.BINARY;
B{4} = ones(3);
works{4} = true; 

connectivity_type{5} = Graph.BINARY;
B{5} = round(rand(5));
works{5} = true; 

connectivity_type{6} = Graph.WEIGHTED;
B{6} = .5;
works{6} = true; 

connectivity_type{7} = Graph.WEIGHTED;
B{7} = -1;
works{7} = true; 

connectivity_type{8} = Graph.WEIGHTED;
B{8} = rand(5);
works{8} = true; 

connectivity_type{9} = Graph.BINARY;
B{9} = .5;
works{9} = false; 

connectivity_type{10} = Graph.BINARY;
B{10} = -1;
works{10} = false; 

connectivity_type{11} = Graph.BINARY;
B{11} = rand(5);
works{11} = false; 

connectivity_type{11} = Graph.BINARY;
B{11} = {
    ones(2) zeros(2, 3)
    zeros(3, 2) ones(3)
    };
works{11} = true; 

connectivity_type{12} = [
    Graph.BINARY Graph.BINARY
    Graph.BINARY Graph.BINARY
    ];
B{12} = {
    ones(2) zeros(2, 3)
    zeros(3, 2) ones(3)
    };
works{12} = true;

connectivity_type{13} = [
    Graph.BINARY Graph.BINARY
    Graph.BINARY Graph.BINARY
    ];
B{13} = {
    ones(2) rand(2, 3)
    rand(3, 2) ones(3)
    };
works{13} = false; 

connectivity_type{14} = [
    Graph.BINARY Graph.WEIGHTED
    Graph.WEIGHTED Graph.BINARY
    ];
B{14} = {
    ones(2) rand(2, 3)
    rand(3, 2) ones(3)
    };
works{14} = true; 

connectivity_type{15} = Graph.WEIGHTED;
B{15} = {
    ones(2) rand(2, 3)
    rand(3, 2) ones(3)
    };
works{15} = true; 

for i = 1:1:length(connectivity_type)
    if works{i}
        Graph.checkConnectivity(connectivity_type{i}, B{i})
    else
        try 
            clear e
            Graph.checkConnectivity(connectivity_type{i}, B{i})
        catch e
            assert(isequal(e.identifier, error_identifier), ...
                [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
                ['Expected error: ' error_identifier '. Instead, thrown error ' e.identifier])    
        end
        assert(exist('e', 'var') == 1, ...
            [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
            ['Error not thrown. Expected error: ' error_identifier])
    end
end

%% Test 1.3: checkEdge
error_identifier = [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT];

edge_type{1} = Graph.UNDIRECTED;
B{1} = 0.8;
works{1} = true; 

edge_type{2} = Graph.UNDIRECTED;
B{2} = ones(3);
works{2} = true; 

edge_type{3} = Graph.DIRECTED;
B{3} = round(rand(5));
works{3} = true; 

edge_type{4} = Graph.DIRECTED;
B{4} = rand(5);
works{4} = true; 

edge_type{5} = Graph.UNDIRECTED;
B{5} = [
    1, 2;
    1, 4];
works{5} = false; 

edge_type{6} = Graph.UNDIRECTED;
B{6} = {
    ones(2) zeros(2)
    zeros(2) ones(2)
    };
works{6} = true; 

edge_type{7} = [
    Graph.UNDIRECTED Graph.UNDIRECTED
    Graph.UNDIRECTED Graph.UNDIRECTED
    ];
B{7} = {
    ones(2) zeros(2)
    zeros(2) ones(2)
    };
works{7} = true;

edge_type{8} = [
    Graph.UNDIRECTED Graph.UNDIRECTED
    Graph.UNDIRECTED Graph.UNDIRECTED
    ];
B{8} = {
    ones(2) rand(2)
    rand(2) ones(2)
    };
works{8} = false; 

edge_type{9} = [
    Graph.UNDIRECTED Graph.DIRECTED
    Graph.DIRECTED Graph.UNDIRECTED
    ];
B{9} = {
    ones(2) rand(2)
    rand(2) ones(2)
    };
works{9} = true; 

edge_type{10} = Graph.DIRECTED;
B{10} = {
    ones(3) rand(3)
    rand(3) ones(3)
    };
works{10} = true; 

for i = 1:1:length(edge_type)
    if works{i}
        Graph.checkEdge(edge_type{i}, B{i})
    else
        try 
            clear e
            Graph.checkEdge(edge_type{i}, B{i})
        catch e
            assert(isequal(e.identifier, error_identifier), ...
                [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
                ['Expected error: ' error_identifier '. Instead, thrown error ' e.identifier])    
        end
        assert(exist('e', 'var') == 1, ...
            [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
            ['Error not thrown. Expected error: ' error_identifier])
    end
end

%% Test 1.4: checkSelfConnectivity
error_identifier = [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT];

selfconnectivity_type{1} = Graph.NONSELFCONNECTED;
B{1} = 0;
works{1} = true; 

selfconnectivity_type{2} = Graph.SELFCONNECTED;
B{2} = 1;
works{2} = true; 

selfconnectivity_type{3} = Graph.NONSELFCONNECTED;
B{3} = zeros(3);
works{3} = true; 

selfconnectivity_type{4} = Graph.SELFCONNECTED;
B{4} = ones(3);
works{4} = true; 

selfconnectivity_type{5} = Graph.NONSELFCONNECTED;
B{5} = ones(3);
works{5} = false; 

selfconnectivity_type{6} = Graph.NONSELFCONNECTED;
B{6} = {
    zeros(2) zeros(2)
    zeros(2) zeros(2)
    };
works{6} = true; 

selfconnectivity_type{7} = Graph.SELFCONNECTED;
B{7} = {
    ones(2) ones(2)
    ones(2) ones(2)
    };
works{7} = true; 

selfconnectivity_type{8} = Graph.NONSELFCONNECTED;
B{8} = {
    ones(2) ones(2)
    ones(2) ones(2)
    };
works{8} = false; 

selfconnectivity_type{9} = [
    Graph.NONSELFCONNECTED Graph.SELFCONNECTED
    Graph.SELFCONNECTED Graph.NONSELFCONNECTED
    ];
B{9} = {
    zeros(2) ones(2)
    ones(2) zeros(2)
    };
works{9} = true;

selfconnectivity_type{10} = [
    Graph.NONSELFCONNECTED Graph.SELFCONNECTED
    Graph.SELFCONNECTED Graph.NONSELFCONNECTED
    ];
B{10} = {
    ones(2) zeros(2)
    zeros(2) ones(2)
    };
works{10} = false;

for i = 1:1:length(selfconnectivity_type)
    if works{i}
        Graph.checkSelfConnectivity(selfconnectivity_type{i}, B{i})
    else
        try 
            clear e
            Graph.checkSelfConnectivity(selfconnectivity_type{i}, B{i})
        catch e
            assert(isequal(e.identifier, error_identifier), ...
                [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
                ['Expected error: ' error_identifier '. Instead, thrown error ' e.identifier])    
        end
        assert(exist('e', 'var') == 1, ...
            [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
            ['Error not thrown. Expected error: ' error_identifier])
    end
end

%% Test 1.: checkNegativity
error_identifier = [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT];

negativity_type{1} = Graph.NONNEGATIVE;
B{1} = 0.8;
works{1} = true; 

negativity_type{2} = Graph.NEGATIVE;
B{2} = -0.8;
works{2} = true; 

negativity_type{3} = Graph.NONNEGATIVE;
B{3} = ones(5);
works{3} = true; 

negativity_type{4} = Graph.NEGATIVE;
B{4} = randn(5);
works{4} = true; 

negativity_type{5} = Graph.NONNEGATIVE;
B{5} = randn(5);
works{5} = false; 

negativity_type{6} = Graph.NONNEGATIVE;
B{6} = {
    ones(2) zeros(2)
    zeros(2) ones(2)
    };
works{6} = true; 

negativity_type{7} = Graph.NONNEGATIVE;
B{7} = {
    ones(2) zeros(2)
    randn(2) [-1, -1; 3, -1]
    };
works{7} = false; 

negativity_type{8} = [
    Graph.NONNEGATIVE Graph.NONNEGATIVE
    Graph.NONNEGATIVE Graph.NONNEGATIVE
    ];
B{8} = {
    ones(2) zeros(2)
    zeros(2) ones(2)
    };
works{8} = true;

negativity_type{9} = [
    Graph.NONNEGATIVE Graph.NEGATIVE
    Graph.NEGATIVE Graph.NONNEGATIVE
    ];
B{9} = {
    ones(2) randn(2)
    randn(2) ones(2)
    };
works{9} = true; 

negativity_type{10} = [
    Graph.NONNEGATIVE Graph.NEGATIVE
    Graph.NEGATIVE Graph.NONNEGATIVE
    ];
B{10} = {
    [-1, -1; 3, -1] randn(2)
    randn(2) ones(2)
    };
works{10} = false; 

for i = 1:1:length(negativity_type)
    if works{i}
        Graph.checkNegativity(negativity_type{i}, B{i})
    else
        try 
            clear e
            Graph.checkNegativity(negativity_type{i}, B{i})
        catch e
            assert(isequal(e.identifier, error_identifier), ...
                [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
                ['Expected error: ' error_identifier '. Instead, thrown error ' e.identifier])    
        end
        assert(exist('e', 'var') == 1, ...
            [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
            ['Error not thrown. Expected error: ' error_identifier])
    end
end

%% Test 2: Implementation static methods
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
    g = Graph.getGraph(graph_class, A{Graph.getGraphType(graph_class)});
    
    assert(ischar(g.getClass()) && isequal(g.getClass(), graph_class), ...
        [BRAPH2.STR ':' graph_class ':' BRAPH2.WRONG_OUTPUT], ...
        ['Graph.getClass() should return ''' graph_class ''''])
   
    assert(ischar(g.getName()), ...
        [BRAPH2.STR ':' graph_class ':' BRAPH2.WRONG_OUTPUT], ...
        'Graph.getName() should return a char array')
    
    assert(ischar(g.getDescription()), ...
        [BRAPH2.STR ':' graph_class ':' BRAPH2.WRONG_OUTPUT], ...
        'Graph.getDescription() should return a char array')
    
    assert(islogical(Graph.is_weighted(g)), ...
        [BRAPH2.STR ':' graph_class ':' BRAPH2.WRONG_OUTPUT], ...
        'Graph.is_weighted() should return a logical')
    
    assert(islogical(Graph.is_binary(g)), ...
        [BRAPH2.STR ':' graph_class ':' BRAPH2.WRONG_OUTPUT], ...
        'Graph.is_binary() should return a logical')
    
    assert(isnumeric(Graph.getConnectivityType(g)), ...
        [BRAPH2.STR ':' graph_class ':' BRAPH2.WRONG_OUTPUT], ...
        'Graph.getConnectivityType() should return a number')
    
    assert(islogical(Graph.is_directed(g)), ...
        [BRAPH2.STR ':' graph_class ':' BRAPH2.WRONG_OUTPUT], ...
        'Graph.is_directed() should return a logical')
    
    assert(islogical(Graph.is_undirected(g)), ...
        [BRAPH2.STR ':' graph_class ':' BRAPH2.WRONG_OUTPUT], ...
        'Graph.is_undirected() should return a logical')
        
    assert(isnumeric(Graph.getEdgeType(g)), ...
        [BRAPH2.STR ':' graph_class ':' BRAPH2.WRONG_OUTPUT], ...
        'Graph.getEgdeType() should return a number')
    
    assert(islogical(Graph.is_selfconnected(g)), ...
        [BRAPH2.STR ':' graph_class ':' BRAPH2.WRONG_OUTPUT], ...
        'Graph.is_selfconnected() should return a logical')
         
    assert(islogical(Graph.is_not_selfconnected(g)), ...
        [BRAPH2.STR ':' graph_class ':' BRAPH2.WRONG_OUTPUT], ...
        'Graph.is_not_selfconnected() should return a logical')
    
    assert(isnumeric(Graph.getSelfConnectivityType(g)), ...
        [BRAPH2.STR ':' graph_class ':' BRAPH2.WRONG_OUTPUT], ...
        'Graph.getSelfConnectivityType() should return a number')
       
    assert(islogical(Graph.is_negative(g)), ...
        [BRAPH2.STR ':' graph_class ':' BRAPH2.WRONG_OUTPUT], ...
        'Graph.is_negative() should return a logical')
    
    assert(islogical(Graph.is_nonnegative(g)), ...
        [BRAPH2.STR ':' graph_class ':' BRAPH2.WRONG_OUTPUT], ...
        'Graph.is_nonnegative() should return a logical')
     
    assert(isnumeric(Graph.getNegativityType(g)), ...
        [BRAPH2.STR ':' graph_class ':' BRAPH2.WRONG_OUTPUT], ...
        'Graph.getNegativityType() should return a number')
            
%     assert(iscell(g.getCompatibleMeasureList()), ...
%         ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
%         [graph_class '.getCompatibleMeasureList() should return a cell array'])
%     
%     assert(isnumeric(g.getCompatibleMeasureNumber()), ...
%         ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
%         [graph_class '.getCompatibleMeasureNumber() should return a number'])
end

%% Test 3: All graphs not abstract
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
    g = Graph.getGraph(graph_class, A{Graph.getGraphType(graph_class)});
end

% %% Test 4: Either weighted or binary
% for i = 1:1:length(graph_class_list)
%     graph_class = graph_class_list{i};
%     assert(Graph.is_weighted(graph_class) ~= Graph.is_binary(graph_class), ...
%         [BRAPH2.STR ':' graph_class ':' BRAPH2.WRONG_OUTPUT], ...
%         [graph_class '.is_weighted() == ' graph_class '.is_binary()'])
% end
%  
% %% Test 5: Either directed or undirected
% for i = 1:1:length(graph_class_list)
%     graph_class = graph_class_list{i};
%     assert(Graph.is_directed(graph_class) ~= Graph.is_undirected(graph_class), ...
%         [BRAPH2.STR ':' graph_class ':' BRAPH2.WRONG_OUTPUT], ...
%         [graph_class '.is_directed() == ' graph_class '.is_undirected()'])
% end
% 
% %% Test 6: Either Self-connected or Non self-connected
% for i = 1:1:length(graph_class_list)
%     graph_class = graph_class_list{i};
%     assert(Graph.is_selfconnected(graph_class) ~= Graph.is_not_selfconnected(graph_class), ...
%         [BRAPH2.STR ':' graph_class ':' BRAPH2.WRONG_OUTPUT], ...
%         [graph_class '.is_selfconnected() == ' graph_class '.is_not_selfconnected()'])
% end
% 
% %% Test 7: Either Negative or Non negative
% for i = 1:1:length(graph_class_list)
%     graph_class = graph_class_list{i};
%     assert(Graph.is_negative(graph_class) ~= Graph.is_nonnegative(graph_class), ...
%         [BRAPH2.STR ':' graph_class ':' BRAPH2.WRONG_OUTPUT], ...
%         [graph_class '.is_negative() == ' graph_class '.is_nonnegative()'])
% end

% %% Test 8: NodeAttack
% n = randi(4);
% nodes = [randi(n), randi(n)];
% 
% % Specific case for single layer GRAPH
% B = A{Graph.GRAPH};
% g = Graph.getGraph('GraphBU', B);
% B = dediagonalize(B);
% B = semipositivize(B);
% B = binarize(B);
% B = symmetrize(B);
% B(nodes(:), :) = 0;
% B(:, nodes(:)) = 0;
% 
% ng = g.nodeattack(g, nodes);
% 
% assert( isequal(ng.getA(ng), B), ...
%     [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
%     'Graph.nodeattack() is not working for single layer graphs')
% 
% % Specific cases for all multilayer types
% B = A{Graph.MULTIPLEX};
% g = Graph.getGraph('MultiplexGraphWU', B);
% L = length(B);
% for layer = 1:1:L
%     M = B{layer, layer};
%     M = dediagonalize(M);
%     M = semipositivize(M);
%     M = standardize(M);
%     M = symmetrize(M);
%     B(layer, layer) = {M};
% end
% for x = 1:1:size(B, 1)
%     for j = x+1:1:size(B, 2)
%         B(x, j) = {semipositivize(B{x, j})};
%         B(j, x) = {semipositivize(B{j, x})};
%         B(x, j) = {standardize(B{x, j})};
%         B(j, x) = {standardize(B{j, x})};
%     end
% end
% C = B;
% 
% % Attack all layers
% for layer = 1:1:L
%     M = B{layer, layer};
%     M(nodes(:), :) = 0;
%     M(:, nodes(:)) = 0;
%     B(layer, layer) = {M};
% end    
% 
% ng = g.nodeattack(g, nodes);
% 
% assert( isequal(ng.getA(ng), B), ...
%     [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
%     'Graph.nodeattack() is not working for non single layer graphs')
% 
% % Attack specified layers
% layernumbers = [1, 2];
% for i = layernumbers
%     M = C{i, i};
%     M(nodes(:), :) = 0;
%     M(:, nodes(:)) = 0;
%     C(i, i) = {M};
% end
% 
% ng = g.nodeattack(g, nodes, layernumbers);
% 
% assert(isequal(ng.getA(ng), C), ...
%     [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
%     'Graph.nodeattack() is not working for non single layer graphs')

% %% Test 9: EdgeAttack
% n = randi(4);
% nodes1 = [randi(n), randi(n)];
% nodes2 = [randi(n), randi(n)];
% 
% % Specific Case for single layer
% B = A{Graph.GRAPH};
% g = Graph.getGraph('GraphBU', B);
% B = dediagonalize(B);
% B = semipositivize(B);
% B = binarize(B);
% B = symmetrize(B);
% B(sub2ind(size(B), nodes1, nodes2)) = 0;
% B(sub2ind(size(B), nodes2, nodes1)) = 0;
% 
% eg = g.edgeattack(g, nodes1, nodes2);
% 
% assert(isequal(eg.getA(eg), B), ...
%     [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
%     'Graph.edgeattack() is not working for single layer graphs')
% 
% % Specific cases for all multilayer types
% B = A{Graph.MULTIPLEX};
% g = Graph.getGraph('MultiplexGraphWU', B);
% L = length(B);
% for layer = 1:1:L
%     M = B{layer, layer};
%     M = dediagonalize(M);
%     M = semipositivize(M);
%     M = standardize(M);
%     M = symmetrize(M);
%     B(layer, layer) = {M};
% end
% for x = 1:1:size(B, 1)
%     for j = x+1:1:size(B, 2)
%         B(x, j) = {semipositivize(B{x, j})};
%         B(j, x) = {semipositivize(B{j, x})};
%         B(x, j) = {standardize(B{x, j})};
%         B(j, x) = {standardize(B{j, x})};
%     end
% end
% C = B;
% D = B;
% 
% % Attack all layers
% for layer = 1:1:L
%     M = B{layer, layer};
%     M(sub2ind(size(M), nodes1, nodes2)) = 0;
%     M(sub2ind(size(M), nodes2, nodes1)) = 0;
%     B(layer, layer) = {M};
% end    
% 
% eg = g.edgeattack(g, nodes1, nodes2);
% 
% assert(isequal(eg.getA(eg), B), ...
%     'BRAPH: GRAPH: EdgeAttack', ...
%     'Graph.edgeattack() is not working for non single layer graphs')
% 
% % Attack specified layers: i
% layernumbers_i = [1, 2];
% for i = layernumbers_i
%     M = C{i, i};
%     M(sub2ind(size(M), nodes1, nodes2)) = 0;
%     M(sub2ind(size(M), nodes2, nodes1)) = 0;
%     C(i, i) = {M};
% end
% 
% eg = g.edgeattack(g, nodes1, nodes2, layernumbers_i);
% 
% assert(isequal(eg.getA(eg), C), ...
%     [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
%     'Graph.edgeattack() is not working for non single layer graphs')
% 
% % Attack specified layers and between specified layers: i, j 
% layernumbers_i = [1, 2];
% layernumbers_j = [2, 2];
% for i = 1:1:length(layernumbers_i)
%     M = D{layernumbers_i(i), layernumbers_j(i)};
%     M(sub2ind(size(M), nodes1, nodes2)) = 0;
%     if layernumbers_i(i) ~= layernumbers_j(i)
%         M2 = D{layernumbers_j(i), layernumbers_i(i)};
%         M2(sub2ind(size(M2), nodes1, nodes2)) = 0;
%         D(layernumbers_j(i), layernumbers_i(i)) = {M2};
%     else    
%         M(sub2ind(size(M), nodes2, nodes1)) = 0;
%     end
%     D(layernumbers_i(i), layernumbers_j(i)) = {M};
% end
% 
% eg = g.edgeattack(g, nodes1, nodes2, layernumbers_i, layernumbers_j);
% 
% assert(isequal(eg.getA(eg), D), ...
%     [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
%     'Graph.edgeattack() is not working for non single layer graphs')

% %% Test 10: Copy
% for i = 1:1:length(graph_class_list)
%     A = rand(randi(10));
%     graph_class = graph_class_list{i};
%     g = Graph.getGraph(graph_class, A);
%     
%     g_copy = copy(g);
%     
%     measure_class_list = g.getCompatibleMeasureList();
%     for j = 1:1:length(measure_class_list)
%         measure_class = measure_class_list{j};
%         g.getMeasure(measure_class).getValue();
%     end
%     for j = 1:1:length(measure_class_list)
%         assert(g.is_measure_calculated(measure_class) ~= g_copy.is_measure_calculated(measure_class), ...
%             ['BRAPH:' graph_class ':Copy'], ...
%             [graph_class '.copy() not working properly'])
%         assert(isequal(g.getMeasure(measure_class).getGraph(), g), ...
%             ['BRAPH:' graph_class ':Copy'], ...
%             [graph_class '.copy() not working properly'])
%         assert(isequal(g_copy.getMeasure(measure_class).getGraph(), g_copy), ...
%             ['BRAPH:' graph_class ':Copy'], ...
%             [graph_class '.copy() not working properly'])
%         assert(~isequal(g.getMeasure(measure_class).getGraph(), g_copy), ...
%             ['BR~APH:' graph_class ':Copy'], ...
%             [graph_class '.copy() not working properly'])
%         assert(~isequal(g_copy.getMeasure(measure_class).getGraph(), g), ...
%             ['BRAPH:' graph_class ':Copy'], ...
%             [graph_class '.copy() not working properly'])
%     end
% end
% 
% %% Test 11: Subgraph
% for i = 1:1:length(graph_class_list)
%     graph_class = graph_class_list{i};
%     n = randi(10);
%     A =  randn(n);
%     g = Graph.getGraph(graph_class, A);
%     
%     nodes = [randi(n), randi(n)];
%     
%     sg = g.subgraph(nodes);
%     
%     A_test = g.getA();
%     sg_test = Graph.getGraph(graph_class, A_test(nodes, nodes));
%     
%     assert( isequal(sg.getA(), sg_test.getA()), ...
%         ['BRAPH:' graph_class ':Subgraph'], ...
%         [graph_class '.subgraph() is not working' ])
%     
% end
