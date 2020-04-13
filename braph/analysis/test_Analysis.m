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
    analysis = Analysis.getAnalysis(analysis_class, cohort, {});
end

%% Test 2: Implementation static methods
for i = 1:1:length(analysis_class_list)
    analysis_class = analysis_class_list{i};
    subject_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class));
    cohort = Cohort('cohort', subject_class, atlases, {});
    analysis = Analysis.getAnalysis(analysis_class, cohort, {});
    
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

%% Test 3: Instantiation with Measurement
for i = 1:1:length(analysis_class_list)
    %arrange
    analysis_class = analysis_class_list{i};
    switch(analysis_class)
        case 'AnalysisDTI'
            sub_class = 'SubjectDTI';
        case 'AnalysisfMRI'
            sub_class = 'SubjectfMRI';
        otherwise
            sub_class = 'SubjectMRI';
    end
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    measurement = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    %act
    analysis = Analysis.getAnalysis(analysis_class, cohort, measurement);
    %assert
    assert(isa(analysis, analysis_class), ...
        ['BRAPH:' analysis_class ':Instantiation'], ...
        [analysis_class 'Instantiation error with measurements.'])
end

%% Test 4: Basic Functions
for i = 1:1:length(analysis_class_list)
    %arrange
    analysis_class = analysis_class_list{i};
    switch(analysis_class)
        case 'AnalysisDTI'
            sub_class = 'SubjectDTI';
        case 'AnalysisfMRI'
            sub_class = 'SubjectfMRI';
        otherwise
            sub_class = 'SubjectMRI';
    end
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    measurement1 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement2 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement = {measurement1, measurement2};
    %act
    analysis = Analysis.getAnalysis(analysis_class, cohort, measurement);
    %assert
    if isequal(analysis_class, 'AnalysisMRI')
        assert(analysis.getMeasurements().length()==2, ...
            'BRAPH:Analysis:Bug', ...
            'Analysis.getMeasurements().length() does not work')
        assert(analysis.getMeasurements().contains(1), ...
            'BRAPH:Cohort:Bug', ...
            'Cohort.contains_subject does not work')
        assert(~analysis.getMeasurements().contains(3), ...
            'BRAPH:Cohort:Bug', ...
            'Cohort.contains_subject does not work')
    end
end

%% Test 5: Add
for i = 1:1:length(analysis_class_list)
    %arrange
    analysis_class = analysis_class_list{i};
    switch(analysis_class)
        case 'AnalysisDTI'
            sub_class = 'SubjectDTI';
        case 'AnalysisfMRI'
            sub_class = 'SubjectfMRI';
        otherwise
            sub_class = 'SubjectMRI';
    end
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    measurement1 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement2 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement_cell1 = {measurement1, measurement2};
    measurement3 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement4 = Measurement.getMeasurement('RandomComparisonMRI', atlas, group);
    measurement5 = Measurement.getMeasurement('RandomComparisonMRI', atlas, group);
    measurement6 =Measurement.getMeasurement('ComparisonMRI', atlas, repmat({group}, Measurement.getGroupNumber('ComparisonMRI')));
    %act
    analysis = Analysis.getAnalysis(analysis_class, cohort, measurement_cell1);
    
    if isequal(analysis_class, 'AnalysisMRI')
        analysis.getMeasurements().add(measurement3.getName(), measurement3);
        analysis.getRandomComparisons().add(measurement4.getName(), measurement4);
        analysis.getRandomComparisons().add(measurement5.getName(), measurement5);
        analysis.getComparisons().add(measurement6.getName(), measurement6);
        %assert
        assert(analysis.getMeasurements().length()==3, ...
            'BRAPH:Analysis:Bug', ...
            'getMeasurements().add() does not work')
        assert(analysis.getRandomComparisons().length()==2, ...
            'BRAPH:Analysis:Bug', ...
            'getComparisons().add() does not work')
        assert(analysis.getComparisons().length()==1, ...
            'BRAPH:Analysis:Bug', ...
            'getRandomComparisons().add() does not work')
    end
end

%% Test 6: Remove
for i = 1:1:length(analysis_class_list)
    %arrange
    analysis_class = analysis_class_list{i};
    switch(analysis_class)
        case 'AnalysisDTI'
            sub_class = 'SubjectDTI';
        case 'AnalysisfMRI'
            sub_class = 'SubjectfMRI';
        otherwise
            sub_class = 'SubjectMRI';
    end
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    if isequal(analysis_class, 'AnalysisMRI')
        measurement1 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
        measurement2 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
        measurement = {measurement1, measurement2};
        %act
        analysis = Analysis.getAnalysis(analysis_class, cohort, measurement);
        analysis.getMeasurements().remove(2);
        %assert
        assert(analysis.getMeasurements().length()==1, ...
            'BRAPH:Analysis:Bug', ...
            'Analysis.removeMeasurement() does not work')
    end
end

%% Test 7: Replace
for i = 1:1:length(analysis_class_list)
    %arrange
    analysis_class = analysis_class_list{i};
    switch(analysis_class)
        case 'AnalysisDTI'
            sub_class = 'SubjectDTI';
        case 'AnalysisfMRI'
            sub_class = 'SubjectfMRI';
        otherwise
            sub_class = 'SubjectMRI';
    end
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    measurement1 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement2 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement = {measurement1, measurement2};
    %act
    if isequal(analysis_class, 'AnalysisMRI')
        analysis = Analysis.getAnalysis(analysis_class, cohort, measurement);
        measurement3 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
        analysis.getMeasurements().replace(measurement3.getName(), measurement3, 2);
        %assert
        assert(analysis.getMeasurements().length()==2, ...
            'BRAPH:Analysis:Bug', ...
            'Analysis.replaceMeasurement() does not work')
        assert( isequal(analysis.getMeasurements().getValue(2).getClass(), 'MeasurementMRI'), ...
            'BRAPH:Analysis:Bug', ...
            'Analysis.replaceMeasurement() does not work')
    end
end

%% Test 8: Invert
for i = 1:1:length(analysis_class_list)
    %arrange
    analysis_class = analysis_class_list{i};
    switch(analysis_class)
        case 'AnalysisDTI'
            sub_class = 'SubjectDTI';
        case 'AnalysisfMRI'
            sub_class = 'SubjectfMRI';
        otherwise
            sub_class = 'SubjectMRI';
    end
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    measurement1 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement2 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement = {measurement1, measurement2};
    %act
    analysis = Analysis.getAnalysis(analysis_class, cohort, measurement); 
    if isequal(analysis_class, 'AnalysisMRI')
        analysis.getMeasurements().invert(2, 1);
        %assert
        assert( isequal(analysis.getMeasurements().getValue(2).getClass(), 'MeasurementMRI'), ...
            'BRAPH:Analysis:Bug', ...
            'Analysis.invertMeasurements() does not work')
    end
end

%% Test 9: MoveTo
for i = 1:1:length(analysis_class_list)
    %arrange
    analysis_class = analysis_class_list{i};
    switch(analysis_class)
        case 'AnalysisDTI'
            sub_class = 'SubjectDTI';
        case 'AnalysisfMRI'
            sub_class = 'SubjectfMRI';
        otherwise
            sub_class = 'SubjectMRI';
    end
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    measurement1 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement2 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement3 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement = {measurement1, measurement2, measurement3};
    %act
    analysis = Analysis.getAnalysis(analysis_class, cohort, measurement);
    if isequal(analysis_class, 'AnalysisMRI')
        
        analysis.getMeasurements().move_to(3, 1);
        %assert
        assert( isequal(analysis.getMeasurements().getValue(1).getClass(), 'MeasurementMRI'), ...
            'BRAPH:Analysis:Bug', ...
            'Analysis.movetoMeasurement() does not work')
    end
end

%% Test 10: RemoveAll
for i = 1:1:length(analysis_class_list)
    %arrange
    analysis_class = analysis_class_list{i};
    switch(analysis_class)
        case 'AnalysisDTI'
            sub_class = 'SubjectDTI';
        case 'AnalysisfMRI'
            sub_class = 'SubjectfMRI';
        otherwise
            sub_class = 'SubjectMRI';
    end
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    measurement1 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement2 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement3 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement = {measurement1, measurement2, measurement3};
    %act
    analysis = Analysis.getAnalysis(analysis_class, cohort, measurement);
    if isequal(analysis_class, 'AnalysisMRI')
        selected = analysis.getMeasurements().remove_all([1, 3]);
        %assert
        assert(analysis.getMeasurements().length()==1, ...
            'BRAPH:Analysis:Bug', ...
            'Analysis.removeMeasurements() does not work')
        assert( isequal(analysis.getMeasurements().getValue(1).getClass(), 'MeasurementMRI'), ...
            'BRAPH:Analysis:Bug', ...
            'Analysis.removeMeasurements() does not work')
        assert(isempty(selected), ...
            'BRAPH:Analysis:Bug', ...
            'Analysis.removeMeasurements() does not work')
    end
end

%% Test 11: MoveUp
for i = 1:1:length(analysis_class_list)
    %arrange
    analysis_class = analysis_class_list{i};
    switch(analysis_class)
        case 'AnalysisDTI'
            sub_class = 'SubjectDTI';
        case 'AnalysisfMRI'
            sub_class = 'SubjectfMRI';
        otherwise
            sub_class = 'SubjectMRI';
    end
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    cohort.getGroups().add(group.getName(), group);
    measurement1 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement2 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement3 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement = {measurement1, measurement2, measurement3};
    %act
    analysis = Analysis.getAnalysis(analysis_class, cohort, measurement);
    if isequal(analysis_class, 'AnalysisMRI')
        selected = analysis.getMeasurements().move_up([2 3]);
        %assert
        assert(analysis.getMeasurements().length()==3, ...
            'BRAPH:Analysis:Bug', ...
            'Analysis.moveupMeasurements() does not work')
        assert( isequal(analysis.getMeasurements().getValue(1).getClass(), 'MeasurementMRI'), ...
            'BRAPH:Analysis:Bug', ...
            'Analysis.moveupMeasurements() does not work')
    end
end

%% Test 12: MoveDown
for i = 1:1:length(analysis_class_list)
    %arrange
    analysis_class = analysis_class_list{i};
    switch(analysis_class)
        case 'AnalysisDTI'
            sub_class = 'SubjectDTI';
        case 'AnalysisfMRI'
            sub_class = 'SubjectfMRI';
        otherwise
            sub_class = 'SubjectMRI';
    end
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    cohort.getGroups().add(group.getName(), group);
    measurement1 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement2 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement3 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement = {measurement1, measurement2, measurement3};
    %act
    analysis = Analysis.getAnalysis(analysis_class, cohort, measurement);
    if isequal(analysis_class, 'AnalysisMRI')
        selected = analysis.getMeasurements().move_down([1 2]);
        %assert
        assert(analysis.getMeasurements().length()==3, ...
            'BRAPH:Analysis:Bug', ...
            'Analysis.movedownMeasurements() does not work')
        assert( isequal(analysis.getMeasurements().getValue(3).getClass(), 'MeasurementMRI'), ...
            'BRAPH:Analysis:Bug', ...
            'Analysis.movedownMeasurements() does not work')
    end
end

%% Test 13: MoveToTop
for i = 1:1:length(analysis_class_list)
    %arrange
    analysis_class = analysis_class_list{i};
    switch(analysis_class)
        case 'AnalysisDTI'
            sub_class = 'SubjectDTI';
        case 'AnalysisfMRI'
            sub_class = 'SubjectfMRI';
        otherwise
            sub_class = 'SubjectMRI';
    end
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    cohort.getGroups().add(group.getName(), group);
    measurement1 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement2 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement3 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement = {measurement1, measurement2, measurement3};
    %act
    analysis = Analysis.getAnalysis(analysis_class, cohort, measurement);
    if isequal(analysis_class, 'AnalysisMRI')
        selected = analysis.getMeasurements().move_to_top([3]);  %#ok<NBRAK>
        %assert
        assert(analysis.getMeasurements().length()==3, ...
            'BRAPH:Analysis:Bug', ...
            'Analysis.move2topMeasurements() does not work')
        assert( isequal(analysis.getMeasurements().getValue(1).getClass(), 'MeasurementMRI'), ...
            'BRAPH:Analysis:Bug', ...
            'Analysis.move2topMeasurements() does not work')
    end
end

%% Test 14: MoveToBottom
for i = 1:1:length(analysis_class_list)
    %arrange
    analysis_class = analysis_class_list{i};
    switch(analysis_class)
        case 'AnalysisDTI'
            sub_class = 'SubjectDTI';
        case 'AnalysisfMRI'
            sub_class = 'SubjectfMRI';
        otherwise
            sub_class = 'SubjectMRI';
    end
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    cohort.getGroups().add(group.getName(), group);
    measurement1 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement2 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement3 = Measurement.getMeasurement('MeasurementMRI', atlas, group);
    measurement = {measurement1, measurement2, measurement3};
    %act
    analysis = Analysis.getAnalysis(analysis_class, cohort, measurement);
    if isequal(analysis_class, 'AnalysisMRI')
        selected = analysis.getMeasurements().move_to_bottom([1]);  %#ok<NBRAK>
        %assert
        assert(analysis.getMeasurements().length()==3, ...
            'BRAPH:Analysis:Bug', ...
            'Analysis.move2topMeasurements() does not work')
        assert( isequal(analysis.getMeasurements().getValue(3).getClass(), 'MeasurementMRI'), ...
            'BRAPH:Analysis:Bug', ...
            'Analysis.move2topMeasurements() does not work')
    end
end