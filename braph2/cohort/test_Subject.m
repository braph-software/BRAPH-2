% test Subject

subject_class_list = Subject.getList();

br1 = BrainRegion('BR1', 'brain region 1', 'notes 1', 1, 1.1, 1.11);
br2 = BrainRegion('BR2', 'brain region 2', 'notes 2', 2, 2.2, 2.22);
br3 = BrainRegion('BR3', 'brain region 3', 'notes 3', 3, 3.3, 3.33);
br4 = BrainRegion('BR4', 'brain region 4', 'notes 4', 4, 4.4, 4.44);
br5 = BrainRegion('BR5', 'brain region 5', 'notes 5', 5, 5.5, 5.55);
atlas = BrainAtlas('BA', 'brain atlas', 'notes', 'BrainMesh_ICBM152.nv', {br1, br2, br3, br4, br5});

%% Test 1: All subjects not abstract
for i = 1:1:length(subject_class_list)
    subject_class = subject_class_list{i};
    if Subject.getBrainAtlasNumber(subject_class) == 1
        sub = Subject.getSubject(subject_class, 'id', 'label', 'notes', {atlas});
        sub = Subject.getSubject(subject_class, 'id', 'label', 'notes', atlas);
    else
        sub = Subject.getSubject(subject_class, 'id', 'label', 'notes', repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)));
    end
end

%% Test 2: Implementation static methods
for i = 1:1:length(subject_class_list)
    subject_class = subject_class_list{i};
    
    sub = Subject.getSubject(subject_class, 'id', 'label', 'notes', repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)));
    
    assert(isequal(sub.getClass(), subject_class), ...
        [BRAPH2.STR ':' subject_class ':' BRAPH2.WRONG_OUTPUT], ...
        [subject_class '.getClass() should return ''' subject_class ''''])
    
    assert(ischar(sub.getClass()), ...
        [BRAPH2.STR ':' subject_class ':' BRAPH2.WRONG_OUTPUT], ...
        [subject_class '.getClass() should return a char array'])
    
    assert(ischar(sub.getName()), ...
        [BRAPH2.STR ':' subject_class ':' BRAPH2.WRONG_OUTPUT], ...
        [subject_class '.getName() should return a char array'])
    
    assert(ischar(sub.getDescription()), ...
        [BRAPH2.STR ':' subject_class ':' BRAPH2.WRONG_OUTPUT], ...
        [subject_class '.getDescription() should return a char array'])
    
    assert(isnumeric(sub.getBrainAtlasNumber()) ...
        && sub.getBrainAtlasNumber() > 0, ...
        [BRAPH2.STR ':' subject_class ':' BRAPH2.WRONG_OUTPUT], ...
        [subject_class '.getBrainAtlasNumber() should return positive integer'])
    
    assert(isa(sub.getDataList(), 'containers.Map'), ...
        [BRAPH2.STR ':' subject_class ':' BRAPH2.WRONG_OUTPUT], ...
        [subject_class '.getDataList() should return a containers.Map'])
    
    assert(sub.getDataNumber() == length(sub.getDataList()), ...
        [BRAPH2.STR ':' subject_class ':' BRAPH2.WRONG_OUTPUT], ...
        [subject_class '.getDataNumber() should return an integer equal to the number of data'])
    
    assert(iscell(sub.getDataCodes()) ...
        && length(sub.getDataCodes()) == sub.getDataNumber(), ...
        [BRAPH2.STR ':' subject_class ':' BRAPH2.WRONG_OUTPUT], ...
        [subject_class '.getDataCodes() should return a cell array as long as the number of data'])
    
    assert(iscell(sub.getDataClasses()) ...
        && length(sub.getDataClasses()) == sub.getDataNumber(), ...
        [BRAPH2.STR ':' subject_class ':' BRAPH2.WRONG_OUTPUT], ...
        [subject_class '.getDataClasses() should return a cell array as long as the number of data'])
    
end

%% Test 3: Change BrainAtlas
for i = 1:1:length(subject_class_list)
    subject_class = subject_class_list{i};
    
    sub = Subject.getSubject(subject_class, 'id', 'label', 'notes', repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)));

    atlas_copy = atlas.copy();
    atlasses_copy = repmat({atlas_copy}, 1, sub.getBrainAtlasNumber());
    sub.setBrainAtlases(atlasses_copy)
    
    try
        atlas_wrong = BrainAtlas('wrong brain atlas', {br1, br2, br3});
        atlasses_wrong = repmat({atlas_wrong}, 1, sub.getBrainAtlasNumber());
        sub.setBrainAtlases(atlasses_wrong)
        error = false;
    catch
        error = true;
    end
    assert(error, ...
        [BRAPH2.STR ':' subject_class ':' BRAPH2.BUG_COPY], ...
        [subject_class '.setBrainAtlases() does not work'])
end

%% Test 4: Copy
for i = 1:1:length(subject_class_list)
    subject_class = subject_class_list{i};
    
    sub = Subject.getSubject(subject_class, 'id', 'label', 'notes', repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)));
    
    sub_copy = sub.copy();
    assert(sub ~= sub_copy, ... % different objects, but same values
        [BRAPH2.STR ':' subject_class ':' BRAPH2.BUG_COPY], ...
        [subject_class '.copy() does not work'])
    
    data_codes = sub.getDataCodes();
    for j = 1:1:length(data_codes)
        data_code = data_codes{j};
        d = sub.getData(data_code);
        d_copy = sub_copy.getData(data_code);
        assert(d ~= d_copy, ... % different objects
            [BRAPH2.STR ':' subject_class ':' BRAPH2.BUG_COPY], ...
            [subject_class '.copy() does not work'])
        assert(d.getBrainAtlas() == d_copy.getBrainAtlas(), ... % pointer to same BrainAtlas
            [BRAPH2.STR ':' subject_class ':' BRAPH2.BUG_COPY], ...
            [subject_class '.copy() does not work'])
        
        d_copy.setValue(ones(size(d_copy.getValue())))
    end
    
    sub_copy2 = sub_copy.copy();
    
    for j = 1:1:length(data_codes)
        data_code = data_codes{j};
        d_copy = sub_copy.getData(data_code);
        d_copy2 = sub_copy2.getData(data_code);
        assert(d_copy ~= d_copy2, ... % different objects
            [BRAPH2.STR ':' subject_class ':' BRAPH2.BUG_COPY], ...
            [subject_class '.copy() does not work'])
        assert(d_copy.getBrainAtlas() == d_copy2.getBrainAtlas(), ... % pointer to same BrainAtlas
            [BRAPH2.STR ':' subject_class ':' BRAPH2.BUG_COPY], ...
            [subject_class '.copy() does not work'])
        assert(isequal(d_copy.getValue(), d_copy2.getValue), ...
            [BRAPH2.STR ':' subject_class ':' BRAPH2.BUG_COPY], ...
            [subject_class '.copy() does not work'])
    end
end

%% Test 6: Initialize Subclasses with the datacodes.
for i = 1:1:length(subject_class_list)
    subject_class = subject_class_list{i};
    data_codes = Subject.getDataCodes(subject_class);
    data_list = Subject.getDataList(subject_class);

    varargin = data_codes;
    sub_emptydata = Subject.getSubject(subject_class, 'id', 'label', 'notes', atlas);
    n = atlas.getBrainRegions().length();
    for i = 1:1:numel(data_codes)
        varargin{(2*i)-1} = data_codes{i};
        if isequal(data_list(data_codes{i}), 'DataScalar')
            varargin{(2*i)} = rand();
        elseif isequal(data_list(data_codes{i}), 'DataFunctional') 
            varargin{(2*i)} = rand(n, 10);
        elseif isequal(data_list(data_codes{i}), 'DataConnectivity') 
            varargin{(2*i)} = rand(n, n);
        elseif isequal(data_list(data_codes{i}), 'DataStructural')
            varargin{(2*i)} = rand(n, 1) ;
        else  % we included this case in the event that theres a new data type and the user does not change the unit test.
            varargin{(2*i)} = sub_emptydata.getData(data_codes{i}).getValue();            
        end
    end
    
    sub = Subject.getSubject(subject_class, 'id', 'label', 'notes', atlas, varargin{:});
    
    assert(isequal(sub.getDataCodes(), data_codes), ...
        [BRAPH2.STR ':' subject_class ':' BRAPH2.BUG_FUNC], ...
        ['Constructors for ' subject_class ' not initializing with data codes.'])
    
    for j = 1:1:numel(data_codes)
         assert(isequal(sub.getData(data_codes{j}).getValue(), varargin{2*j}), ...
        [BRAPH2.STR ':' subject_class ':' BRAPH2.BUG_FUNC], ...
        ['Constructors for ' subject_class ' not initializing with correct data codes.'])
    end
end