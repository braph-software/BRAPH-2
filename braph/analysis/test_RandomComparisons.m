% test RandomComparison
br1 = BrainRegion('BR1', 'brain region 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 5, 55, 555);
atlas = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

randomComparison_class_list =  RandomComparison.getList();
subject_class_list = Subject.getList();
%% Test 1 Instantiation
for i = 1:1:length(randomComparison_class_list)
    for j = 1:1:length(subject_class_list)
        %arrange
        randomComparison_class = randomComparison_class_list{i};
        subject_class = subject_class_list{j};
        sub1 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 1);
        sub2 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 2);
        sub3 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 3);
        sub4 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 4);
        sub5 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 5);
        
        group = Group(subject_class, {sub1, sub2, sub3 sub4, sub5});
        %act        
        randomcomparison = RandomComparison.getRandomComparison(randomComparison_class, 'rc1', repmat({atlas}, RandomComparison.getBrainAtlasNumber(randomComparison_class), Subject.getBrainAtlasNumber(subject_class)), group);
        %assert
        assert(~isempty(randomcomparison), ...
            ['BRAPH:RandomComparison:Instantiation'], ...
            ['RandomComparison instantiation fail.']) %#ok<NBRAK>
    end
end

%% Test 2: Static Functions
for i = 1:1:length(randomComparison_class_list)
    for j = 1:1:length(subject_class_list)
        %arrange
        randomComparison_class = randomComparison_class_list{i};
        subject_class = subject_class_list{j};
        sub1 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 1);
        sub2 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 2);
        sub3 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 3);
        sub4 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 4);
        sub5 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 5);
        
        group = Group(subject_class, {sub1, sub2, sub3});
        %act
        randomcomparison = RandomComparison.getRandomComparison(randomComparison_class, 'rc1', repmat({atlas}, RandomComparison.getBrainAtlasNumber(randomComparison_class), Subject.getBrainAtlasNumber(subject_class)), group);
        %assert
        assert(isequal(randomcomparison.getClass(), randomComparison_class), ...
            ['BRAPH:RandomComparison:StaticFunctions'], ...
            ['RandomComparison getClass() fail.']) %#ok<NBRAK>
        assert(ischar(randomcomparison.getName()), ...
            ['BRAPH:RandomComparison:StaticFunctions'], ...
            ['RandomComparison getName() fail.']) %#ok<NBRAK>
        assert(ischar(randomcomparison.getDescription()), ...
            ['BRAPH:RandomComparison:StaticFunctions'], ...
            ['RandomComparison getDescription() fail.']) %#ok<NBRAK>
        assert(~isempty(randomcomparison.getBrainAtlasNumber()), ...
            ['BRAPH:RandomComparison:StaticFunctions'], ...
            ['RandomComparison getAtlasesNumber() fail.']) %#ok<NBRAK>
        assert(~isempty(randomcomparison.getGroupNumber()), ...
            ['BRAPH:RandomComparison:StaticFunctions'], ...
            ['RandomComparison getGroupsNumber() fail.']) %#ok<NBRAK>
        assert(~isempty(randomcomparison.getDataCodes()), ...
            ['BRAPH:RandomComparison:StaticFunctions'], ...
            ['RandomComparison getGroupsNumber() fail.']) %#ok<NBRAK>
        assert(~isempty(randomcomparison.getDataClasses()), ...
            ['BRAPH:RandomComparison:StaticFunctions'], ...
            ['RandomComparison getGroupsNumber() fail.']) %#ok<NBRAK>
    end
end

