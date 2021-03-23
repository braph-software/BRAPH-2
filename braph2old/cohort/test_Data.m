% test Data

data_class_list = Data.getList();

br1 = BrainRegion('BR1', 'brain region 1', 'notes 1', 1, 1.1, 1.11);
br2 = BrainRegion('BR2', 'brain region 2', 'notes 2', 2, 2.2, 2.22);
br3 = BrainRegion('BR3', 'brain region 3', 'notes 3', 3, 3.3, 3.33);
br4 = BrainRegion('BR4', 'brain region 4', 'notes 4', 4, 4.4, 4.44);
br5 = BrainRegion('BR5', 'brain region 5', 'notes 5', 5, 5.5, 5.55);
atlas = BrainAtlas('BA', 'brain atlas', 'notes', 'BrainMesh_ICBM152.nv', {br1, br2, br3, br4, br5});

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
        [BRAPH2.STR ':' data_class ':' BRAPH2.WRONG_OUTPUT], ...
        [data_class '.getClass() should return ''' data_class ''''])

    assert(ischar(d.getClass()), ...
        [BRAPH2.STR ':' data_class ':' BRAPH2.WRONG_OUTPUT], ...
        [data_class '.getClass() should return a char array'])

    assert(ischar(d.getName()), ...
        [BRAPH2.STR ':' data_class ':' BRAPH2.WRONG_OUTPUT], ...
        [data_class '.getName() should return a char array'])

    assert(ischar(d.getDescription()), ...
        [BRAPH2.STR ':' data_class ':' BRAPH2.WRONG_OUTPUT], ...
        [data_class '.getDescription() should return a char array'])

end

%% Test 3: Change BrainAtlas
for i = 1:1:length(data_class_list)
    data_class = data_class_list{i};
    
    d = Data.getData(data_class, atlas);

    atlas_copy = atlas.copy();
    d.setBrainAtlas(atlas_copy)

    try
        atlas_wrong = BrainAtlas('wrong brain atlas', {br1, br2, br3});
        d.setBrainAtlas(atlas_wrong);
        error = false;
    catch
        error = true;
    end
    assert(error, ...
        [BRAPH2.STR ':' data_class ':' BRAPH2.BUG_FUNC], ...
        [data_class '.setBrainAtlas() does not work'])
end

%% Test 4: Copy
for i = 1:1:length(data_class_list)
    data_class = data_class_list{i};
    
    d = Data.getData(data_class, atlas);

    d_copy = d.copy();
    assert(d ~= d_copy, ... % different objects, but same values
        [BRAPH2.STR ':' data_class ':' BRAPH2.BUG_COPY], ...
        [data_class '.copy() does not work.'])
    assert(d.getBrainAtlas() == d_copy.getBrainAtlas(), ... % pointer to same BrainAtlas
        [BRAPH2.STR ':' data_class ':' BRAPH2.BUG_COPY], ...
        [data_class '.copy() does not work.'])
    
    d_copy.setValue(ones(size(d_copy.getValue())))
    d_copy = d.copy();
    assert(d ~= d_copy, ... % different objects and values
        [BRAPH2.STR ':' data_class ':' BRAPH2.BUG_COPY], ...
        [data_class '.copy() does not work'])
    assert(d.getBrainAtlas() == d_copy.getBrainAtlas(), ... % pointer to same BrainAtlas
        [BRAPH2.STR ':' data_class ':' BRAPH2.BUG_COPY], ...
        [data_class '.copy() does not work.'])    
end