% test Measure
measure_class_list = Measure.getList();

%% Test 1: Check all measures are not abstract
for i = 1:1:length(measure_class_list)
    measure_class = measure_class_list{i};

    graph_class_list = Measure.getCompatibleGraphList(measure_class);
    for j = 1:1:length(graph_class_list)
        graph_class = graph_class_list{j};
        A = rand(randi(10));
        g = Graph.getGraph(graph_class, A);
        m = Measure.getMeasure(measure_class, g);
    end
end

%% Test 2: Check implementation of static functions
for i = 1:1:length(measure_class_list)
    measure_class = measure_class_list{i};
    
    graph_class_list = Measure.getCompatibleGraphList(measure_class);
    for j = 1:1:length(graph_class_list)
        graph_class = graph_class_list{j};
        A = rand(randi(10));
        g = Graph.getGraph(graph_class, A);
        m = Measure.getMeasure(measure_class, g);
        
        assert(isequal(m.getClass(), measure_class), ...
            'BRAPH:Measure:StaticFuncImplementation', ...
            [measure_class '.getClass() should return ''' measure_class ''''])
        
        assert(ischar(m.getClass()), ...
            'BRAPH:Measure:StaticFuncImplementation', ...
            [measure_class '.getClass() should return a char array'])
        
        assert(ischar(m.getName()), ...
            'BRAPH:Measure:StaticFuncImplementation', ...
            [measure_class '.getName() should return a char array'])
        
        assert(ischar(m.getDescription()), ...
            'BRAPH:Measure:StaticFuncImplementation', ...
            [measure_class '.getDescription() should return a char array'])
        
        assert(islogical(m.is_global()), ...
            'BRAPH:Measure:StaticFuncImplementation', ...
            [measure_class '.is_global() should return a logical'])
        
        assert(islogical(m.is_nodal()), ...
            'BRAPH:Graph:StaticFuncImplementation', ...
            [measure_class '.is_nodal() should return a logical'])
    end

end

%% Test 3: Either nodal or global
for i = 1:1:length(measure_class_list)
    measure_class = measure_class_list{i};
    assert(Measure.is_global(measure_class) ~= Measure.is_nodal(measure_class), ...
        'BRAPH:Measure:NodalOrGlobal', ...
        [measure_class '.is_nodal() == ' measure_class '.is_global()'])
end
