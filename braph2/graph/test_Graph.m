% test Graph

%% Test 1: checkA
error_identifier = [BRAPH2.STR ':Graph:' BRAPH2.WRONG_INPUT];

% working case
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
    rand(4) rand(4) []
    rand(4) rand(4) rand(4)
    [] rand(4) rand(4)
    };
A{Graph.MULTILAYER} = {
    rand(4) rand(4) rand(4)
    rand(4) rand(4) rand(4)
    rand(4) rand(4) rand(4)
    };

for graph_type = 1:1:Graph.TYPE_NUMBER
	Graph.checkA(graph_type, A{graph_type})
end

% non-square matrix -> error
A_wrong = rand(5, 3);

for graph_type = 1:1:Graph.TYPE_NUMBER
    try 
        clear e
        Graph.checkA(Graph.GRAPH, A_wrong)
    catch e
        assert(isequal(e.identifier, error_identifier), ...
            [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
            ['Expected error: ' error_identifier '. Instead, thrown error ' e.identifier])    
    end
    assert(exist('e', 'var') == 1, ...
        [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
        ['Error not thrown. Expected error: ' error_identifier])
end

% TODO: specific cases

%     if % cell -> error
%         A = {
%             rand(5, 5) rand(5, 2); 
%             rand(2, 5) rand(2, 2); 
%             };
%         try 
%             clear e
%             Graph.checkA(Graph.GRAPH, A)
%         catch e
%             assert(isequal(e.identifier, error_identifier), ...
%                 [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
%                 ['Expected error: ' error_identifier '. Instead, thrown error ' e.identifier])    
%         end
%         assert(exist('e', 'var') == 1, ...
%             [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
%             ['Error not thrown. Expected error: ' error_identifier])


% % cell -> error
% A = {rand(5, 5)};
% try 
%     clear e
%     Graph.checkA(Graph.GRAPH, A)
% catch e
%     assert(isequal(e.identifier, error_identifier), ...
%         [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
%         ['Expected error: ' error_identifier '. Instead, thrown error ' e.identifier])    
% end
% assert(exist('e', 'var') == 1, ...
%     [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
%     ['Error not thrown. Expected error: ' error_identifier])
% 
% % cell -> error
% A = {
%     rand(5, 5) rand(5, 2); 
%     rand(2, 5) rand(2, 2); 
%     };
% try 
%     clear e
%     Graph.checkA(Graph.GRAPH, A)
% catch e
%     assert(isequal(e.identifier, error_identifier), ...
%         [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
%         ['Expected error: ' error_identifier '. Instead, thrown error ' e.identifier])    
% end
% assert(exist('e', 'var') == 1, ...
%     [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
%     ['Error not thrown. Expected error: ' error_identifier])


% A = [
%     2, 2, 2;
%     2, 3, 1
%     ];
% 
% detected = false;
% 
% try
%     g = GraphBU(A);  % GraphType Graph
% catch 
%     detected = true;
% end
% 
% assert(detected, ...
%     [BRAPH2.STR ': Graph :' BRAPH2.WRONG_INPUT], ...
%     'A was not a square adjacency matrix and it was not detected.')

% %% Test 2: GraphType Graph Assert
% A = rand(randi(10));
% g = GraphBU(A);  % GraphType Graph
% 
% assert(isequal(g.getClass(), 'GraphBU'), ...
%     'BRAPH: GraphBU :StaticFuncImplementation', ...
%     ['GraphBU.getClass() should return ''' 'GraphBU' ''''])

% %% Test 1: All graphs not abstract
% for i = 1:1:length(graph_class_list)
%     graph_class = graph_class_list{i};
%     A = rand(randi(10));
%     g = Graph.getGraph(graph_class, A);
% end

%% Test 2: Implementation static methods
graph_class_list = Graph.getList();

for i = 1:1:length(graph_class_list)
%     graph_class = graph_class_list{i};
%     A = rand(randi(10));
%     g = Graph.getGraph(graph_class, A);
%     
%     assert(isequal(g.getClass(), graph_class), ...
%         ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
%         [graph_class '.getClass() should return ''' graph_class ''''])
%     
%     assert(ischar(g.getClass()), ...
%         ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
%         [graph_class '.getClass() should return a char array'])
%     
%     assert(ischar(g.getName()), ...
%         ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
%         [graph_class '.getName() should return a char array'])
%     
%     assert(ischar(g.getDescription()), ...
%         ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
%         [graph_class '.getDescription() should return a char array'])
%     
%     assert(islogical(g.is_weighted()), ...
%         ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
%         [graph_class '.is_weighted() should return a logical'])
%     
%     assert(islogical(g.is_binary()), ...
%         ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
%         [graph_class '.is_binary() should return a logical'])
%     
%     assert(islogical(g.is_directed()), ...
%         ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
%         [graph_class '.is_directed() should return a logical'])
%     
%     assert(islogical(g.is_undirected()), ...
%         ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
%         [graph_class '.is_undirected() should return a logical'])
%     
%     assert(islogical(g.is_selfconnected()), ...
%         ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
%         [graph_class '.is_selfconnected() should return a logical'])
%     
%     assert(islogical(g.is_nonnegative()), ...
%         ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
%         [graph_class '.is_nonnegative() should return a logical'])
%     
%     assert(iscell(g.getCompatibleMeasureList()), ...
%         ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
%         [graph_class '.getCompatibleMeasureList() should return a cell array'])
%     
%     assert(isnumeric(g.getCompatibleMeasureNumber()), ...
%         ['BRAPH:' graph_class ':StaticFuncImplementation'], ...
%         [graph_class '.getCompatibleMeasureNumber() should return a number'])
end
 
% %% Test 3: Either weighted or binary
% for i = 1:1:length(graph_class_list)
%     graph_class = graph_class_list{i};
%     assert(Graph.is_weighted(graph_class) ~= Graph.is_binary(graph_class), ...
%         ['BRAPH:' graph_class ':WeightedOrBinary'], ...
%         [graph_class '.is_weighted() == ' graph_class '.is_binary()'])
% end
% 
% %% Test 4: Either directed or undirected
% for i = 1:1:length(graph_class_list)
%     graph_class = graph_class_list{i};
%     assert(Graph.is_directed(graph_class) ~= Graph.is_undirected(graph_class), ...
%         ['BRAPH:Gra' graph_class 'ph:DirectedOrUndirected'], ...
%         [graph_class '.is_directed() == ' graph_class '.is_undirected()'])
% end
% 
% %% Test 5: Copy
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
% %% Test 6: Subgraph
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
% 
% %% Test 7: NodeAttack
% for i = 1:1:length(graph_class_list)
%     graph_class = graph_class_list{i};
%     n = randi(10);
%     A =  randn(n);
%     nodes = [randi(n), randi(n)];
%     
%     g = Graph.getGraph(graph_class, A);
%     ng = g.nodeattack(nodes);
%     
%     switch(graph_class)
%         case 'GraphBD'
%             A(1:length(A)+1:end) = 0;
%             A(A<0) = 0;
%             A(A>0) = 1;
%         case 'GraphBU'
%             A(1:length(A)+1:end) = 0;
%             A(A<0) = 0;
%             A(A>0) = 1;
%             A = max(A, A');
%         case 'GraphWD'
%             A(1:length(A)+1:end) = 0;
%             A(A<0) = 0;
%             A = standardize(A);
%         case 'GraphWU'
%             A(1:length(A)+1:end) = 0;
%             A(A<0) = 0;
%             A = max(A, A');
%             A = standardize(A);
%     end
%     
%     for j = 1:1:numel(nodes)
%         A(nodes(j), :) = 0; %#ok<PROPLC>
%         A(:, nodes(j)) = 0; %#ok<PROPLC>
%     end
%     
%     assert( isequal(ng.getA(), A), ...
%         ['BRAPH:' graph_class ':NodeAttack'], ...
%         [graph_class '.nodeattack() is not working' ])
% end
% 
% %% Test 7: EdgeAttack
% for i = 1:1:length(graph_class_list)
%     graph_class = graph_class_list{i};
%     n = randi(10);
%     A =  randn(n);
%     nodes = [randi(n), randi(n)];
%     g = Graph.getGraph(graph_class, A);
%     
%     eg = g.edgeattack(nodes, nodes);
%     
%     switch(graph_class)
%         case 'GraphBD'
%             A(1:length(A)+1:end) = 0;
%             A(A<0) = 0;
%             A(A>0) = 1;
%         case 'GraphBU'
%             A(1:length(A)+1:end) = 0;
%             A(A<0) = 0;
%             A(A>0) = 1;
%             A = max(A, A');
%         case 'GraphWD'
%             A(1:length(A)+1:end) = 0;
%             A(A<0) = 0;
%             A = standardize(A);
%         case 'GraphWU'
%             A(1:length(A)+1:end) = 0;
%             A(A<0) = 0;
%             A = max(A, A');
%             A = standardize(A);
%     end
%     
%     A(sub2ind(size(A), nodes, nodes)) = 0; %#ok<PROPLC>
%     
%     assert( isequal(eg.getA(), A), ...
%         ['BRAPH:' graph_class ':EdgeAttack'], ...
%         [graph_class '.edgeattack() is not working' ])
% end
