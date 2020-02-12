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
        value = m.getValue();
        if m.is_global()
            assert(isnumeric(value) && numel(value) == 1, ...
                ['BRAPH:' measure_class ':getValueBroken'], ...
                [measure_class '.getValue()  used with ' graph_class ' should return a scalar'])
        end
        if m.is_nodal()
            assert(isnumeric(value) && isequal(size(value), [g.nodenumber() 1]), ...
                ['BRAPH:' measure_class ':getValueBroken'], ...
                [measure_class '.getValue() used with ' graph_class ' should return a column vector with length equal to the numebr of nodes'])
        end
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
            ['BRAPH:' measure_class ':StaticFuncImplementation'], ...
            [measure_class '.getClass() used with ' graph_class ' should return ''' measure_class ''''])
        
        assert(ischar(m.getClass()), ...
            ['BRAPH:' measure_class ':StaticFuncImplementation'], ...
            [measure_class '.getClass() used with ' graph_class ' should return a char array'])
        
        assert(ischar(m.getName()), ...
            ['BRAPH:' measure_class ':StaticFuncImplementation'], ...
            [measure_class '.getName() used with ' graph_class ' should return a char array'])
        
        assert(ischar(m.getDescription()), ...
            ['BRAPH:' measure_class ':StaticFuncImplementation'], ...
            [measure_class '.getDescription() used with ' graph_class ' should return a char array'])
        
        assert(islogical(m.is_global()), ...
            ['BRAPH:' measure_class ':StaticFuncImplementation'], ...
            [measure_class '.is_global() used with ' graph_class ' should return a logical'])
        
        assert(islogical(m.is_nodal()), ...
            ['BRAPH:' measure_class ':StaticFuncImplementation'], ...
            [measure_class '.is_nodal() used with ' graph_class ' should return a logical'])

        assert(iscell(m.getCompatibleGraphList()), ...
            ['BRAPH:' measure_class ':StaticFuncImplementation'], ...
            [measure_class '.getCompatibleGraphList() used with ' graph_class ' should return a cell array'])

        assert(isnumeric(m.getCompatibleGraphNumber()), ...
            ['BRAPH:' measure_class ':StaticFuncImplementation'], ...
            [measure_class '.getCompatibleGraphNumber() used with ' graph_class ' should return a number'])
    end

end

%% Test 3: Either nodal or global
for i = 1:1:length(measure_class_list)
    measure_class = measure_class_list{i};
    assert(Measure.is_global(measure_class) ~= Measure.is_nodal(measure_class), ...
        ['BRAPH:' measure_class ':NodalOrGlobal'], ...
        [measure_class '.is_nodal() == ' measure_class '.is_global()'])
end