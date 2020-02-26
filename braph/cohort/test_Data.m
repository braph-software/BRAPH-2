% test Data
data_class_list = Data.getList();

%% Test 1: All data not abstract
for i = 1:1:length(data_class_list)
    data_class = data_class_list{i};

    d = Data.getData(data_class);
end

%% Test 2: Implementation static methods
for i = 1:1:length(data_class_list)
    data_class = data_class_list{i};
    
    d = Data.getData(data_class);

    assert(isequal(d.getClass(), data_class), ...
        ['BRAPH:' data_class ':StaticFuncImplementation'], ...
        [data_class '.getClass() should return ''' data_class ''''])

    assert(ischar(d.getClass()), ...
        ['BRAPH:' data_class ':StaticFuncImplementation'], ...
        [data_class '.getClass() should return a char array'])

    assert(ischar(d.getName()), ...
        ['BRAPH:' data_class ':StaticFuncImplementation'], ...
        [data_class '.getName() should return a char array'])

    assert(ischar(d.getDescription()), ...
        ['BRAPH:' data_class ':StaticFuncImplementation'], ...
        [data_class '.getDescription() should return a char array'])

end