% test Subject
subject_class_list = Subject.getList();

br1 = BrainRegion('BR1', 'brain region 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 5, 55, 555);
atlas = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

%% Test 1: All subjects not abstract
for i = 1:1:length(subject_class_list)
    subject_class = subject_class_list{i};
    if Subject.getBrainAtlasNumber(subject_class) == 1
        sub = Subject.getSubject(subject_class, {atlas});
        sub = Subject.getSubject(subject_class, atlas);
    else
        sub = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)));
    end
end

%% Test 2: Implementation static methods
for i = 1:1:length(subject_class_list)
    subject_class = subject_class_list{i};
    
    sub = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)));
    
    assert(isequal(sub.getClass(), subject_class), ...
        ['BRAPH:' subject_class ':StaticFuncImplementation'], ...
        [subject_class '.getClass() should return ''' subject_class ''''])
    
    assert(ischar(sub.getClass()), ...
        ['BRAPH:' subject_class ':StaticFuncImplementation'], ...
        [subject_class '.getClass() should return a char array'])
    
    assert(ischar(sub.getName()), ...
        ['BRAPH:' subject_class ':StaticFuncImplementation'], ...
        [subject_class '.getName() should return a char array'])
    
    assert(ischar(sub.getDescription()), ...
        ['BRAPH:' subject_class ':StaticFuncImplementation'], ...
        [subject_class '.getDescription() should return a char array'])
    
    assert(isnumeric(sub.getBrainAtlasNumber()) ...
        && sub.getBrainAtlasNumber() > 0, ...
        ['BRAPH:' subject_class ':StaticFuncImplementation'], ...
        [subject_class '.getBrainAtlasNumber() should return positive integer'])
    
    assert(isa(sub.getDataList(), 'containers.Map'), ...
        ['BRAPH:' subject_class ':StaticFuncImplementation'], ...
        [subject_class '.getDataList() should return a containers.Map'])
    
    assert(sub.getDataNumber() == length(sub.getDataList()), ...
        ['BRAPH:' subject_class ':StaticFuncImplementation'], ...
        [subject_class '.getDataNumber() should return an integer equal to the number of data'])
    
    assert(iscell(sub.getDataCodes()) ...
        && length(sub.getDataCodes()) == sub.getDataNumber(), ...
        ['BRAPH:' subject_class ':StaticFuncImplementation'], ...
        [subject_class '.getDataCodes() should return a cell array as long as the number of data'])
    
    assert(iscell(sub.getDataClasses()) ...
        && length(sub.getDataClasses()) == sub.getDataNumber(), ...
        ['BRAPH:' subject_class ':StaticFuncImplementation'], ...
        [subject_class '.getDataClasses() should return a cell array as long as the number of data'])
    
end

%% Test 3: Groups
for i = 1:1:length(subject_class_list)
    subject_class = subject_class_list{i};
    
    sub = Subject.getSubject(subject_class, ...
        repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), ...
        'SubjectGroups', {1 3 5});
    
    groups = sub.getGroups();
    assert(isequal(groups, {1 3 5}), ...
        ['BRAPH:' subject_class ':Groups'], ...
        ['Group managemenr for ' subject_class ' not working'])
    
    sub.setGroups({ 2 4});
    groups = sub.getGroups();
    assert(isequal(groups, {2 4}), ...
        ['BRAPH:' subject_class ':Groups'], ...
        ['Group managemenr for ' subject_class ' not working'])
end

%% Test 4: Change BrainAtlas
for i = 1:1:length(subject_class_list)
    subject_class = subject_class_list{i};
    
    sub = Subject.getSubject(subject_class, ...
        repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), ...
        'SubjectGroups', {1 3 5});
    
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
        ['BRAPH:' subject_class ':Copy'], ...
        [subject_class '.setBrainAtlases() does not work'])
end

%% Test 5: Copy
for i = 1:1:length(subject_class_list)
    subject_class = subject_class_list{i};
    
    sub = eval(['Subject.getSubject(subject_class' ...
        repmat(', atlas', 1, Subject.getBrainAtlasNumber(subject_class)) ...
        ', ''SubjectGroups'', {1 3 5})']);
    
    sub_copy = sub.copy();
    assert(sub ~= sub_copy, ... % different objects, but same values
        ['BRAPH:' subject_class ':Copy'], ...
        [subject_class '.copy() does not work'])
    
    data_codes = sub.getDataCodes();
    for j = 1:1:length(data_codes)
        data_code = data_codes{j};
        d = sub.getData(data_code);
        d_copy = sub_copy.getData(data_code);
        assert(d ~= d_copy, ... % different objects
            ['BRAPH:' subject_class ':Copy'], ...
            [subject_class '.copy() does not work'])
        assert(d.getBrainAtlas() == d_copy.getBrainAtlas(), ... % pointer to same BrainAtlas
            ['BRAPH:' subject_class ':Copy'], ...
            [subject_class '.copy() does not work'])
        
        d_copy.setValue(ones(size(d_copy.getValue())))
    end
    
    sub_copy2 = sub_copy.copy();
    
    for j = 1:1:length(data_codes)
        data_code = data_codes{j};
        d_copy = sub_copy.getData(data_code);
        d_copy2 = sub_copy2.getData(data_code);
        assert(d_copy ~= d_copy2, ... % different objects
            ['BRAPH:' subject_class ':Copy'], ...
            [subject_class '.copy() does not work'])
        assert(d_copy.getBrainAtlas() == d_copy2.getBrainAtlas(), ... % pointer to same BrainAtlas
            ['BRAPH:' subject_class ':Copy'], ...
            [subject_class '.copy() does not work'])
        assert(isequal(d_copy.getValue(), d_copy2.getValue), ...
            ['BRAPH:' subject_class ':Copy'], ...
            [subject_class '.copy() does not work'])
    end
end

%% Test 6: Initialize Subclasses with the datacodes.
for i = 1:1:length(subject_class_list)
    subject_class = subject_class_list{i};
    codes = Subject.getDataCodes(subject_class);
    datalist = Subject.getDataList(subject_class);
    n = atlas.brainregionnumber();
    varargin = codes;
    for i= 1:1:numel(codes)
        varargin{(2*i)-1} = codes{i};
        if isequal(datalist(codes{i}), 'DataScalar')
            varargin{(2*i)} = 33;
        elseif isequal(datalist(codes{i}), 'DataFunctional') | isequal(datalist(codes{i}), 'DataConnectivity') 
            varargin{(2*i)} = rand(n);
        else
            varargin{(2*i)} = rand(n,1) ;
        end
    end
    
    sub = Subject.getSubject(subject_class, atlas, varargin{:});
    
    assert(isequal(sub.getDataCodes(), codes), ...
        ['BRAPH:' subject_class ':Constructor'], ...
        ['Constructors for ' subject_class ' not initializing with data codes.'])
    
    for j = 1:1:numel(codes)
         assert(isequal(sub.getData(codes{j}).getValue(), varargin{2*j}), ...
        ['BRAPH:' subject_class ':Constructor'], ...
        ['Constructors for ' subject_class ' not initializing with correct data codes.'])
    end
end