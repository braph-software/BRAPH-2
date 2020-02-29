% test Data
data_class_list = Data.getList();

br1 = BrainRegion('BR1', 'brain region 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 5, 55, 555);
atlas = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

%% Test 1: All data not abstract
for i = 1:1:length(data_class_list)
    data_class = data_class_list{i};

    d = Data.getData(data_class, atlas);
    
    d.setValue(d.getValue());
end

%% Test 2: Implementation static methods
for i = 1:1:length(data_class_list)
    data_class = data_class_list{i};
    
    d = Data.getData(data_class, atlas);

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

%% Test 3: Change BrainAtlas
for i = 1:1:length(data_class_list)
    data_class = data_class_list{i};
    
    d = Data.getData(data_class, atlas);

    atlas_copy = atlas.copy();
    d.setBrainAtlas(atlas_copy)

    try
        ba_wrong = BrainAtlas('wrong brain atlas', {br1, br2, br3});
        d.setBrainAtlas(ba_wrong);
        error = false;
    catch
        error = true;
    end
    assert(error, ...
        ['BRAPH:' data_class ':Copy'], ...
        [data_class '.setBrainAtlas() does not work'])
end

%% Test 4: Copy
for i = 1:1:length(data_class_list)
    data_class = data_class_list{i};
    
    d = Data.getData(data_class, atlas);

    d_copy = d.copy();
    assert(d ~= d_copy, ... % different objects, but same values
        ['BRAPH:' data_class ':Copy'], ...
        [data_class '.copy() does not work'])
    assert(d.getBrainAtlas() == d_copy.getBrainAtlas(), ... % pointer to same BrainAtlas
        ['BRAPH:' data_class ':Copy'], ...
        [data_class '.copy() does not work'])
    
    d_copy.setValue(ones(size(d_copy.getValue())))
    d_copy = d.copy();
    assert(d ~= d_copy, ... % different objects and values
        ['BRAPH:' data_class ':Copy'], ...
        [data_class '.copy() does not work'])
    assert(d.getBrainAtlas() == d_copy.getBrainAtlas(), ... % pointer to same BrainAtlas
        ['BRAPH:' data_class ':Copy'], ...
        [data_class '.copy() does not work'])    
end