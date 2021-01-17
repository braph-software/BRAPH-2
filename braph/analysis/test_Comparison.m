% test Comparisons
br1 = BrainRegion('BR1', 'brain region 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 5, 55, 555);
atlas = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

comparison_class_list =  Comparison.getList();

%% Test 1 Instantiation
for i = 1:1:length(comparison_class_list)
    % setup
    comparison_class = comparison_class_list{i};
    subject_class = Comparison.getSubjectClass(comparison_class);
    
    sub1 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 1);
    sub2 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 2);
    sub3 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 3);
    
    group = Group(subject_class, {sub1, sub2, sub3});
    
    %act
    comparison = Comparison.getComparison(comparison_class, ...
        'c1', ...
        atlas, ...
        {group group}, ...
        'setting name', 'setting value');
    
    %assert
    assert(~isempty(comparison), ...
        ['BRAPH:' comparison_class ':Instantiation'], ...
        [comparison_class ' instantiation fail.'])
end

%% Test 2: Static Functions
for i = 1:1:length(comparison_class_list)
    % setup
    comparison_class = comparison_class_list{i};
    subject_class = Comparison.getSubjectClass(comparison_class);
    
    sub1 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 1);
    sub2 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 2);
    sub3 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 3);
    
    group = Group(subject_class, {sub1, sub2, sub3});
    
    % act
    comparison = Comparison.getComparison(comparison_class, 'c1', atlas, {group group});
    
    % assert
    assert(isequal(comparison.getClass(), comparison_class), ...
        ['BRAPH:' comparison_class ':StaticFunctions'], ...
        [comparison_class '.getClass() fail.'])
    assert(ischar(comparison.getName()), ...
        ['BRAPH:' comparison_class ':StaticFunctions'], ...
        [comparison_class '.getName() fail.'])
    assert(ischar(comparison.getDescription()), ...
        ['BRAPH:' comparison_class ':StaticFunctions'], ...
        [comparison_class '.getDescription() fail.'])
    assert(isequal(comparison.getBrainAtlasNumber(), Subject.getBrainAtlasNumber(subject_class)), ...
        ['BRAPH:' comparison_class ':StaticFunctions'], ...
        [comparison_class '.getAtlasNumber() fail.']) 
    assert(ischar(comparison.getAnalysisClass()), ...
        ['BRAPH:' comparison_class ':StaticFunctions'], ...
        [comparison_class '.getAtlasesNumber() fail.'])
    assert(ischar(comparison.getSubjectClass()), ...
        ['BRAPH:' comparison_class ':StaticFunctions'], ...
        [comparison_class '.getAtlasesNumber() fail.'])
end