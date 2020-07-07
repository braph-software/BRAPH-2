% test Comparison

comparison_class_list =  Comparison.getList();

br1 = BrainRegion('BR1', 'brain region 1', 'notes 1', 1, 1.1, 1.11);
br2 = BrainRegion('BR2', 'brain region 2', 'notes 2', 2, 2.2, 2.22);
br3 = BrainRegion('BR3', 'brain region 3', 'notes 3', 3, 3.3, 3.33);
br4 = BrainRegion('BR4', 'brain region 4', 'notes 4', 4, 4.4, 4.44);
br5 = BrainRegion('BR5', 'brain region 5', 'notes 5', 5, 5.5, 5.55);
atlas = BrainAtlas('BA', 'brain atlas', 'notes', 'BrainMesh_ICBM152.nv', {br1, br2, br3, br4, br5});

%% Test 1 Instantiation
for i = 1:1:length(comparison_class_list)
    % setup
    comparison_class = comparison_class_list{i};
    subject_class = Comparison.getSubjectClass(comparison_class);
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class));

    sub1 = Subject.getSubject(subject_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(subject_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(subject_class, 'id3', 'label 3', 'notes 3', atlases);

    group = Group(subject_class, 'id', 'label', 'notes', {sub1, sub2, sub3});
    
    %act
    comparison = Comparison.getComparison(comparison_class, ...
        'c1', ...
        'comparison label', ...
        'comparison notes', ...
        atlas, ...
        'Degree', ...
        group, ...
        group, ...
        'setting name', 'setting value');
    
    %assert
    assert(~isempty(comparison), ...
        [BRAPH2.STR ':' comparison_class ':' BRAPH2.BUG_FUNC], ...
        [comparison_class ' instantiation fail'])
end

% %% Test 2: Static Functions
% for i = 1:1:length(comparison_class_list)
%     % setup
%     comparison_class = comparison_class_list{i};
%     subject_class = Comparison.getSubjectClass(comparison_class);
%     
%     sub1 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 1);
%     sub2 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 2);
%     sub3 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 3);
%     
%     group = Group(subject_class, {sub1, sub2, sub3});
%     
%     % act
%     comparison = Comparison.getComparison(comparison_class, 'c1', atlas, {group group});
%     
%     % assert
%     assert(isequal(comparison.getClass(), comparison_class), ...
%         ['BRAPH:' comparison_class ':StaticFunctions'], ...
%         [comparison_class '.getClass() fail.'])
%     assert(ischar(comparison.getName()), ...
%         ['BRAPH:' comparison_class ':StaticFunctions'], ...
%         [comparison_class '.getName() fail.'])
%     assert(ischar(comparison.getDescription()), ...
%         ['BRAPH:' comparison_class ':StaticFunctions'], ...
%         [comparison_class '.getDescription() fail.'])
%     assert(isequal(comparison.getBrainAtlasNumber(), Subject.getBrainAtlasNumber(subject_class)), ...
%         ['BRAPH:' comparison_class ':StaticFunctions'], ...
%         [comparison_class '.getAtlasNumber() fail.']) 
%     assert(ischar(comparison.getAnalysisClass()), ...
%         ['BRAPH:' comparison_class ':StaticFunctions'], ...
%         [comparison_class '.getAtlasesNumber() fail.'])
%     assert(ischar(comparison.getSubjectClass()), ...
%         ['BRAPH:' comparison_class ':StaticFunctions'], ...
%         [comparison_class '.getAtlasesNumber() fail.'])
% end