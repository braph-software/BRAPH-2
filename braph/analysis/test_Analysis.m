% test Analysis
br1 = BrainRegion('BR1', 'brain region 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 5, 55, 555);
atlas = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

analysis_class_list = Analysis.getList();

%% Test 1: All analyses not abstract
for i = 1:1:length(analysis_class_list)
    analysis_class = analysis_class_list{i};
    subject_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class));
    cohort = Cohort('cohort', subject_class, atlases, {});
    analysis = Analysis.getAnalysis(analysis_class, cohort);
end

%% Test 2: Implementation static methods
for i = 1:1:length(analysis_class_list)
    analysis_class = analysis_class_list{i};
    subject_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class));
    cohort = Cohort('cohort', subject_class, atlases, {});
    analysis = Analysis.getAnalysis(analysis_class, cohort);
    
    assert(isequal(analysis.getClass(), analysis_class), ...
        ['BRAPH:' analysis_class ':StaticFuncImplementation'], ...
        [analysis_class '.getClass() should return ''' analysis_class ''''])
    
    assert(ischar(analysis.getClass()), ...
        ['BRAPH:' analysis_class ':StaticFuncImplementation'], ...
        [analysis_class '.getClass() should return a char array'])
    
    assert(ischar(analysis.getName()), ...
        ['BRAPH:' analysis_class ':StaticFuncImplementation'], ...
        [analysis_class '.getName() should return a char array'])
    
    assert(ischar(analysis.getDescription()), ...
        ['BRAPH:' analysis_class ':StaticFuncImplementation'], ...
        [analysis_class '.getDescription() should return a char array'])
end