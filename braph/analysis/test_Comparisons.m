% test Comparisons
br1 = BrainRegion('BR1', 'brain region 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 5, 55, 555);
atlas = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

comparisons_class_list =  {'ComparisonMRI'}; % Comparison.getList();
subject_class_list = Subject.getList();
%% Test 1 Instantiation
for i = 1:1:length(comparisons_class_list)
    for j = 1:1:length(subject_class_list)
        %arrange
        comparisons_class = comparisons_class_list{i};
        subject_class = subject_class_list{j};
        sub1 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 1);
        sub2 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 2);
        sub3 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 3);
        sub4 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 4);
        sub5 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 5);
        
        group = Group(subject_class, {sub1, sub2, sub3 sub4, sub5});
        %act        
        comparison = Comparison.getComparison(comparisons_class, 'c1', repmat({atlas}, Comparison.getBrainAtlasNumber(comparisons_class), Subject.getBrainAtlasNumber(subject_class)), repmat({group}, Comparison.getGroupNumber(comparisons_class)));
        %assert
        assert(~isempty(comparison), ...
            ['BRAPH:Comparison:Instantiation'], ...
            ['Comparison instantiation fail.']) %#ok<NBRAK>
    end
end

%% Test 2: Static Functions
for i = 1:1:length(comparisons_class_list)
    for j = 1:1:length(subject_class_list)
        %arrange
        comparisons_class = comparisons_class_list{i};
        subject_class = subject_class_list{j};
        sub1 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 1);
        sub2 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 2);
        sub3 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 3);
        sub4 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 4);
        sub5 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 5);
        
        group = Group(subject_class, {sub1, sub2, sub3});
        %act
        comparison = Comparison.getComparison(comparisons_class, 'c1', repmat({atlas}, Comparison.getBrainAtlasNumber(comparisons_class), Subject.getBrainAtlasNumber(subject_class)), repmat({group}, Comparison.getGroupNumber(comparisons_class)));
        %assert
        assert(isequal(comparison.getClass(), comparisons_class), ...
            ['BRAPH:Comparison:StaticFunctions'], ...
            ['Comparison getClass() fail.']) %#ok<NBRAK>
        assert(ischar(comparison.getName()), ...
            ['BRAPH:Comparison:StaticFunctions'], ...
            ['Comparison getName() fail.']) %#ok<NBRAK>
        assert(ischar(comparison.getDescription()), ...
            ['BRAPH:Comparison:StaticFunctions'], ...
            ['Comparison getDescription() fail.']) %#ok<NBRAK>
        assert(~isempty(comparison.getBrainAtlasNumber()), ...
            ['BRAPH:Comparison:StaticFunctions'], ...
            ['Comparison getAtlasesNumber() fail.']) %#ok<NBRAK>
        assert(~isempty(comparison.getGroupNumber()), ...
            ['BRAPH:Comparison:StaticFunctions'], ...
            ['Comparison getGroupsNumber() fail.']) %#ok<NBRAK>
        assert(~isempty(comparison.getDataCodes()), ...
            ['BRAPH:Comparison:StaticFunctions'], ...
            ['Comparison getGroupsNumber() fail.']) %#ok<NBRAK>
        assert(~isempty(comparison.getDataClasses()), ...
            ['BRAPH:Comparison:StaticFunctions'], ...
            ['Comparison getGroupsNumber() fail.']) %#ok<NBRAK>
    end
end

