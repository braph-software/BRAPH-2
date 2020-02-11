% test Measure
measure_class_list = Measure.getList();

%% Test 1: Check all graphs are not abstract
for i = 1:1:length(measure_class_list)
    measure_class = measure_class_list{i};

%     graph_list = eval([measure_code '.compatible_graph_list()']);
%     
%     for j = 1:1:length(graph_list)
%         graph_code = graph_list{j};
%         A = rand(randi(10));
%         g = Graph.getGraph(graph_code, A);
%         m = Measure.getMeasure(measure_code, g);
%     end
end


% %% Test 3: Either nodal or global
% for i = 1:1:length(measure_code_list)
%     measure_code = measure_code_list{i};
%     assert(eval([measure_code '.is_nodal() ~= ' measure_code '.is_global()']), ...
%         'BRAPH:Measure:NodalOrGlobal', ...
%         [measure_code '.is_nodal() == ' measure_code '.is_global()'])
% end
