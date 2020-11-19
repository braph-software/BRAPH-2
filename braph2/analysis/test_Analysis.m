% test Analysis

analysis_class_list = Analysis.getList();

br1 = BrainRegion('BR1', 'brain region 1', 'notes 1', 1, 1.1, 1.11);
br2 = BrainRegion('BR2', 'brain region 2', 'notes 2', 2, 2.2, 2.22);
br3 = BrainRegion('BR3', 'brain region 3', 'notes 3', 3, 3.3, 3.33);
br4 = BrainRegion('BR4', 'brain region 4', 'notes 4', 4, 4.4, 4.44);
br5 = BrainRegion('BR5', 'brain region 5', 'notes 5', 5, 5.5, 5.55);
atlas = BrainAtlas('BA', 'brain atlas', 'notes', 'BrainMesh_ICBM152.nv', {br1, br2, br3, br4, br5});

%% Test 1: All analyses not abstract
for i = 1:1:length(analysis_class_list)
    analysis_class = analysis_class_list{i};
    subject_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class));
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', subject_class, atlases, {});
    analysis = Analysis.getAnalysis(analysis_class, 'analysis id', 'analysis label', 'analysis notes', cohort, {}, {}, {});
end

%% Test 2: Implementation static methods
for i = 1:1:length(analysis_class_list)
    analysis_class = analysis_class_list{i};
    subject_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class));
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', subject_class, atlases, {});
    analysis = Analysis.getAnalysis(analysis_class, 'analysis id', 'analysis label', 'analysis notes', cohort, {}, {}, {});
    
    assert(iscell(analysis.getList()), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        [analysis_class '.getList() should return a cell'])
    
    assert(isequal(analysis.getClass(), analysis_class), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        [analysis_class '.getClass() should return ' analysis_class ])
    
    assert(ischar(analysis.getClass()), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        [analysis_class '.getClass() should return a char array'])
    
    assert(ischar(analysis.getName()), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        [analysis_class '.getName() should return a char array'])
    
    assert(ischar(analysis.getSubjectClass()), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        [analysis_class '.getSubjectClass() should return a char array'])
    
    assert(ischar(analysis.getDescription()), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        [analysis_class '.getDescription() should return a char array'])
    
    assert(ischar(analysis.getMeasurementClass()), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        [analysis_class '.getMeasurementClass() should return a string'])
    
    assert(ischar(analysis.getRandomComparisonClass()), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        [analysis_class '.getRandomComparisonClass() should return a string'])
    
    assert(ischar(analysis.getComparisonClass()), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        [analysis_class '.getComparisonClass() should return a string'])
    
    assert(iscell(analysis.getAvailableSettings()), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        [analysis_class '.getMeasurementClass() should return a cell array'])
    
end

%% Test 3: Instantiation with Measurement
for i = 1:1:length(analysis_class_list)
    % setup
    analysis_class = analysis_class_list{i};
    subject_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class));
    sub1 = Subject.getSubject(subject_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(subject_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(subject_class, 'id3', 'label 3', 'notes 3', atlases);
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', subject_class, atlases, {sub1, sub2, sub3});
    group = Group(subject_class, 'id', 'label', 'notes', {sub1, sub2, sub3});
    measurement_class = Analysis.getMeasurementClass(analysis_class);
    random_comparison_class = Analysis.getRandomComparisonClass(analysis_class);
    comparison_class = Analysis.getComparisonClass(analysis_class);
    
    % act
    measurements = Measurement.getMeasurement(measurement_class, 'm1 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    randomcomparison = RandomComparison.getRandomComparison(random_comparison_class, 'rc1', 'rc1 label', 'rc1 notes', atlas, 'Degree', group);
    comparison = Comparison.getComparison(comparison_class, 'c1 id', 'c1 label', 'c1 notes', atlas, 'Degree', group, group);
    analysis = Analysis.getAnalysis(analysis_class, 'analysis id', 'analysis label', 'analysis notes', cohort, {measurements}, {randomcomparison}, {comparison});
    
    % assert
    assert(isa(analysis, analysis_class), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        [analysis_class 'Instantiation error with measurements.'])
end

%% Test 4: Basic Functions
for i = 1:1:length(analysis_class_list)
    % setup
    analysis_class = analysis_class_list{i};
    subject_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class));
    sub1 = Subject.getSubject(subject_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(subject_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(subject_class, 'id3', 'label 3', 'notes 3', atlases);
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', subject_class, atlases, {sub1, sub2, sub3});
    group = Group(subject_class, 'id', 'label', 'notes', {sub1, sub2, sub3});
    measurement_class = Analysis.getMeasurementClass(analysis_class);
    random_comparison_class = Analysis.getRandomComparisonClass(analysis_class);
    comparison_class = Analysis.getComparisonClass(analysis_class);
    
    % act
    measurement1 = Measurement.getMeasurement(measurement_class, 'm1 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2 id', 'm2 label', 'm2 notes', atlas, 'Degree', group);
    measurements = {measurement1, measurement2};
    randomcomparison = RandomComparison.getRandomComparison(random_comparison_class, 'rc1', 'rc1 label', 'rc1 notes', atlas, 'Degree', group);
    comparison = Comparison.getComparison(comparison_class, 'c1 id', 'c1 label', 'c1 notes', atlas, 'Degree', group, group);
    analysis = Analysis.getAnalysis(analysis_class, 'analysis id', 'analysis label', 'analysis notes', cohort, measurements, {randomcomparison}, {comparison});
    
    % assert
    assert(analysis.getMeasurements().length() == 2, ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        [analysis_class '.getMeasurements().length() does not work'])
    assert(analysis.getMeasurements().contains(1), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        [analysis_class '.getMeasurements().contains() does not work'])
    assert(~analysis.getMeasurements().contains(3), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        [analysis_class '.getMeasurements().contains() does not work'])
    assert(analysis.getRandomComparisons().length() == 1, ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        [analysis_class '.getRandomComparisons().length() does not work']);
    assert(analysis.getComparisons().length() == 1, ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        [analysis_class '.getComparisons().length() does not work']);
    
end

%% Test 5: Add
for i = 1:1:length(analysis_class_list)
    
    analysis_class = analysis_class_list{i};
    subject_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class));
    sub1 = Subject.getSubject(subject_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(subject_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(subject_class, 'id3', 'label 3', 'notes 3', atlases);
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', subject_class, atlases, {sub1, sub2, sub3});
    group = Group(subject_class, 'id', 'label', 'notes', {sub1, sub2, sub3});
    measurement_class = Analysis.getMeasurementClass(analysis_class);
    random_comparison_class = Analysis.getRandomComparisonClass(analysis_class);
    comparison_class = Analysis.getComparisonClass(analysis_class);
    measurement1 = Measurement.getMeasurement(measurement_class, 'm1 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    measurements = {measurement1, measurement2};
    measurement3 = Measurement.getMeasurement(measurement_class, 'm3 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    randomcomparison = RandomComparison.getRandomComparison(random_comparison_class, 'rc1', 'rc1 label', 'rc1 notes', atlas, 'Degree', group);  % will not pass rule to get default
    comparison = Comparison.getComparison(comparison_class, 'c1', 'c1 label', 'c1 notes', atlas, 'Degree', group, group);
    
    analysis = Analysis.getAnalysis(analysis_class, 'analysis id', 'analysis label', 'analysis notes', cohort, measurements, {}, {});
    analysis.getMeasurements().add(measurement3.getID(), measurement3);
    analysis.getRandomComparisons().add(randomcomparison.getID(), randomcomparison);
    analysis.getComparisons().add(comparison.getID(), comparison);
    
    assert(analysis.getMeasurements().length() == 3, ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        [analysis_class '.getMeasurements().add() does not work'])
    assert(analysis.getRandomComparisons().length() == 1, ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        [analysis_class '.getComparisons().add() does not work'])
    assert(analysis.getComparisons().length() == 1, ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        [analysis_class '.getRandomComparisons().add() does not work'])
end

%% Test 6: Remove
for i = 1:1:length(analysis_class_list)
    
    % setup
    analysis_class = analysis_class_list{i};
    subject_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class));
    sub1 = Subject.getSubject(subject_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(subject_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(subject_class, 'id3', 'label 3', 'notes 3', atlases);
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', subject_class, atlases, {sub1, sub2, sub3});
    group = Group(subject_class, 'id', 'label', 'notes', {sub1, sub2, sub3});
    measurement_class = Analysis.getMeasurementClass(analysis_class);
    
    measurement1 = Measurement.getMeasurement(measurement_class, 'm1 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    measurements = {measurement1, measurement2};
    
    % act
    analysis = Analysis.getAnalysis(analysis_class, 'analysis id', 'analysis label', 'analysis notes', cohort, measurements, {}, {});
    analysis.getMeasurements().remove(2);
    
    % assert
    assert(analysis.getMeasurements().length() == 1, ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        'Analysis.removeMeasurement() does not work')
end

%% Test 7: Replace
for i = 1:1:length(analysis_class_list)
    
    % setup
    analysis_class = analysis_class_list{i};
    subject_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class));
    sub1 = Subject.getSubject(subject_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(subject_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(subject_class, 'id3', 'label 3', 'notes 3', atlases);
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', subject_class, atlases, {sub1, sub2, sub3});
    group = Group(subject_class, 'id', 'label', 'notes', {sub1, sub2, sub3});
    measurement_class = Analysis.getMeasurementClass(analysis_class);

    measurement1 = Measurement.getMeasurement(measurement_class, 'm1 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    measurements = {measurement1, measurement2};
    
    % act
    analysis = Analysis.getAnalysis(analysis_class, 'analysis id', 'analysis label', 'analysis notes', cohort, measurements, {}, {});
    measurement3 = Measurement.getMeasurement(measurement_class, 'm3 id', 'm3 label', 'm3 notes', atlas, 'Degree', group);
    analysis.getMeasurements().replace(measurement3.getName(), measurement3, 2);
    
    % assert
    assert(analysis.getMeasurements().length()==2, ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        'Analysis.replaceMeasurement() does not work')
    assert( isequal(analysis.getMeasurements().getValue(2).getClass(), measurement_class), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        'Analysis.replaceMeasurement() does not work')
end

%% Test 8: Invert
for i = 1:1:length(analysis_class_list)
    
    % setup
    analysis_class = analysis_class_list{i};
    subject_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class));
    sub1 = Subject.getSubject(subject_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(subject_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(subject_class, 'id3', 'label 3', 'notes 3', atlases);
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', subject_class, atlases, {sub1, sub2, sub3});
    group = Group(subject_class, 'id', 'label', 'notes', {sub1, sub2, sub3});
    measurement_class = Analysis.getMeasurementClass(analysis_class);

    measurement1 = Measurement.getMeasurement(measurement_class, 'm1 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    measurements = {measurement1, measurement2};
        
    % act
    analysis = Analysis.getAnalysis(analysis_class, 'analysis id', 'analysis label', 'analysis notes', cohort, measurements, {}, {});
    analysis.getMeasurements().invert(2, 1);
    
    % assert
    assert( isequal(analysis.getMeasurements().getValue(2).getClass(), measurement_class), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        'Analysis.invertMeasurements() does not work')
end

%% Test 9: MoveTo
for i = 1:1:length(analysis_class_list)
    % setup
    analysis_class = analysis_class_list{i};
    subject_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class));
    sub1 = Subject.getSubject(subject_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(subject_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(subject_class, 'id3', 'label 3', 'notes 3', atlases);
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', subject_class, atlases, {sub1, sub2, sub3});
    group = Group(subject_class, 'id', 'label', 'notes', {sub1, sub2, sub3});
    measurement_class = Analysis.getMeasurementClass(analysis_class);

    measurement1 = Measurement.getMeasurement(measurement_class, 'm1 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    measurement3 = Measurement.getMeasurement(measurement_class, 'm3 id', 'm3 label', 'm3 notes', atlas, 'Degree', group);
    measurements = {measurement1, measurement2, measurement3};
    
    % act
    analysis = Analysis.getAnalysis(analysis_class, 'analysis id', 'analysis label', 'analysis notes', cohort, measurements, {}, {});
    analysis.getMeasurements().move_to(3, 1);
    
    % assert
    assert( isequal(analysis.getMeasurements().getValue(1).getClass(), measurement_class), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        'Analysis.movetoMeasurement() does not work')
end

%% Test 10: RemoveAll
for i = 1:1:length(analysis_class_list)
    % setup
    analysis_class = analysis_class_list{i};
    subject_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class));
    sub1 = Subject.getSubject(subject_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(subject_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(subject_class, 'id3', 'label 3', 'notes 3', atlases);
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', subject_class, atlases, {sub1, sub2, sub3});
    group = Group(subject_class, 'id', 'label', 'notes', {sub1, sub2, sub3});
    measurement_class = Analysis.getMeasurementClass(analysis_class);

    measurement1 = Measurement.getMeasurement(measurement_class, 'm1 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    measurement3 = Measurement.getMeasurement(measurement_class, 'm3 id', 'm3 label', 'm3 notes', atlas, 'Degree', group);
    measurements = {measurement1, measurement2, measurement3};
    
    % act
    analysis = Analysis.getAnalysis(analysis_class, 'analysis id', 'analysis label', 'analysis notes', cohort, measurements, {}, {});
    selected = analysis.getMeasurements().remove_all([1, 3]);
    
    % assert
    assert(analysis.getMeasurements().length()==1, ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        'Analysis.removeMeasurements() does not work')
    assert( isequal(analysis.getMeasurements().getValue(1).getClass(), measurement_class), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        'Analysis.removeMeasurements() does not work')
    assert(isempty(selected), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        'Analysis.removeMeasurements() does not work')
end

%% Test 11: MoveUp
for i = 1:1:length(analysis_class_list)
    % setup
    analysis_class = analysis_class_list{i};
    subject_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class));
    sub1 = Subject.getSubject(subject_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(subject_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(subject_class, 'id3', 'label 3', 'notes 3', atlases);
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', subject_class, atlases, {sub1, sub2, sub3});
    group = Group(subject_class, 'id', 'label', 'notes', {sub1, sub2, sub3});
    cohort.getGroups().add(group.getID(), group);
    measurement_class = Analysis.getMeasurementClass(analysis_class);

    measurement1 = Measurement.getMeasurement(measurement_class, 'm1 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    measurement3 = Measurement.getMeasurement(measurement_class, 'm3 id', 'm3 label', 'm3 notes', atlas, 'Degree', group);
    measurements = {measurement1, measurement2, measurement3};
    
    % act
    analysis = Analysis.getAnalysis(analysis_class, 'analysis id', 'analysis label', 'analysis notes', cohort, measurements, {}, {});
    selected = analysis.getMeasurements().move_up([2 3]);
    
    % assert
    assert(analysis.getMeasurements().length()==3, ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        'Analysis.moveupMeasurements() does not work')
    assert( isequal(analysis.getMeasurements().getValue(1).getClass(), measurement_class), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        'Analysis.moveupMeasurements() does not work')
end

%% Test 12: MoveDown
for i = 1:1:length(analysis_class_list)
    % setup
    analysis_class = analysis_class_list{i};
    subject_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class));
    sub1 = Subject.getSubject(subject_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(subject_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(subject_class, 'id3', 'label 3', 'notes 3', atlases);
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', subject_class, atlases, {sub1, sub2, sub3});
    group = Group(subject_class, 'id', 'label', 'notes', {sub1, sub2, sub3});
    cohort.getGroups().add(group.getID(), group);
    measurement_class = Analysis.getMeasurementClass(analysis_class);

    measurement1 = Measurement.getMeasurement(measurement_class, 'm1 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    measurement3 = Measurement.getMeasurement(measurement_class, 'm3 id', 'm3 label', 'm3 notes', atlas, 'Degree', group);
    measurements = {measurement1, measurement2, measurement3};
    
    % act
    analysis = Analysis.getAnalysis(analysis_class, 'analysis id', 'analysis label', 'analysis notes', cohort, measurements, {}, {});
    selected = analysis.getMeasurements().move_down([1 2]);
    % assert
    assert(analysis.getMeasurements().length()==3, ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        'Analysis.movedownMeasurements() does not work')
    assert( isequal(analysis.getMeasurements().getValue(3).getClass(), measurement_class), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        'Analysis.movedownMeasurements() does not work')
end

%% Test 13: MoveToTop
for i = 1:1:length(analysis_class_list)
    % setup
    analysis_class = analysis_class_list{i};
    subject_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class));
    sub1 = Subject.getSubject(subject_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(subject_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(subject_class, 'id3', 'label 3', 'notes 3', atlases);
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', subject_class, atlases, {sub1, sub2, sub3});
    group = Group(subject_class, 'id', 'label', 'notes', {sub1, sub2, sub3});
    cohort.getGroups().add(group.getID(), group);
    measurement_class = Analysis.getMeasurementClass(analysis_class);

    measurement1 = Measurement.getMeasurement(measurement_class, 'm1 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    measurement3 = Measurement.getMeasurement(measurement_class, 'm3 id', 'm3 label', 'm3 notes', atlas, 'Degree', group);
    measurements = {measurement1, measurement2, measurement3};
    
    % act
    analysis = Analysis.getAnalysis(analysis_class, 'analysis id', 'analysis label', 'analysis notes', cohort, measurements, {}, {});
    selected = analysis.getMeasurements().move_to_top([3]);  %#ok<NBRAK>
    
    % assert
    assert(analysis.getMeasurements().length()==3, ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        'Analysis.move2topMeasurements() does not work')
    assert( isequal(analysis.getMeasurements().getValue(1).getClass(), measurement_class), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        'Analysis.move2topMeasurements() does not work')
end

%% Test 14: MoveToBottom
for i = 1:1:length(analysis_class_list)
    % setup
    analysis_class = analysis_class_list{i};
    subject_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class));
    sub1 = Subject.getSubject(subject_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(subject_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(subject_class, 'id3', 'label 3', 'notes 3', atlases);
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', subject_class, atlases, {sub1, sub2, sub3});
    group = Group(subject_class, 'id', 'label', 'notes', {sub1, sub2, sub3});
    cohort.getGroups().add(group.getID(), group);
    measurement_class = Analysis.getMeasurementClass(analysis_class);

    measurement1 = Measurement.getMeasurement(measurement_class, 'm1 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2 id', 'm1 label', 'm1 notes', atlas, 'Degree', group);
    measurement3 = Measurement.getMeasurement(measurement_class, 'm3 id', 'm3 label', 'm3 notes', atlas, 'Degree', group);
    measurements = {measurement1, measurement2, measurement3};
    
    % act
    analysis = Analysis.getAnalysis(analysis_class, 'analysis id', 'analysis label', 'analysis notes', cohort, measurements, {}, {});
    selected = analysis.getMeasurements().move_to_bottom([1]);  %#ok<NBRAK>
    
    % assert
    assert(analysis.getMeasurements().length()==3, ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        'Analysis.move2topMeasurements() does not work')
    assert( isequal(analysis.getMeasurements().getValue(3).getClass(), measurement_class), ...
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_FUNC], ...
        'Analysis.move2topMeasurements() does not work')
end

%% Test 15: Copy
for i =1:1:length(analysis_class_list)
    % setup
    analysis_class = analysis_class_list{i};
    subject_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class));
    sub1 = Subject.getSubject(subject_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(subject_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(subject_class, 'id3', 'label 3', 'notes 3', atlases);
    sub4 = Subject.getSubject(subject_class, 'id4', 'label 4', 'notes 4', atlases);
    sub5 = Subject.getSubject(subject_class, 'id5', 'label 5', 'notes 5', atlases);
    sub6 = Subject.getSubject(subject_class, 'id6', 'label 6', 'notes 6', atlases);
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', subject_class, atlases, {sub1, sub2, sub3, sub4, sub5, sub6});
    group1 = Group(subject_class, 'gr id 1', 'gr label 1', 'gr notes 1', {sub1, sub2, sub3});
    group2 = Group(subject_class, 'gr id 2', 'gr label 2', 'gr notes 2', {sub4, sub5, sub6});
    cohort.getGroups().add(group1.getID(), group1);
    cohort.getGroups().add(group2.getID(), group2);
    measurement_class = Analysis.getMeasurementClass(analysis_class);
    random_comparison_class = Analysis.getRandomComparisonClass(analysis_class);
    comparison_class = Analysis.getComparisonClass(analysis_class);
    measurement = Measurement.getMeasurement(measurement_class, 'm1 id', 'm1 label', 'm1 notes', atlas, 'Degree', group1);
    randomcomparison = RandomComparison.getRandomComparison(random_comparison_class, 'rc1 id', 'rc1 label', 'rc1 notes', atlas, 'Degree', group1);
    comparison = Comparison.getComparison(comparison_class, 'c1 id', 'cq label', 'c1 notes', atlas, 'Degree', group1, group2);
    analysis = Analysis.getAnalysis(analysis_class, 'analysis id', 'analysis label', 'analysis notes', cohort, {measurement}, {randomcomparison}, {comparison});
    
    % act
    analysis_copy = analysis.copy();
    
    assert(analysis ~= analysis_copy, ... % different objects
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
        [analysis_class '.copy() does not work'])
    
    cohort_analysis = analysis.getCohort();
    measurement_analysis_idict = analysis.getMeasurements();
    randomcomparison_analysis_idict = analysis.getRandomComparisons();
    comparison_analysis_idict = analysis.getComparisons();
    
    cohort_copy = analysis_copy.getCohort();
    measurement_copy_idict = analysis_copy.getMeasurements();
    randomcomparison_copy_idict = analysis_copy.getRandomComparisons();
    comparison_copy_idict = analysis_copy.getComparisons();
    
    % cohort part
    atlases = cohort_analysis.getBrainAtlases();
    atlases_copy = cohort_copy.getBrainAtlases();
    
    assert(cohort_analysis ~= cohort_copy, ... % different objects
        [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
        [analysis_class '.copy() does not work'])
    for j = 1:1:length(atlases)
        assert(atlases{j} ~= atlases_copy{j}, ... % different objects
            [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
            [analysis_class '.copy() does not work'])
    end
    
    for j = 1:1:cohort.getSubjects().length()
        sub = cohort_analysis.getSubjects().getValue(j);
        sub_copy = cohort_copy.getSubjects().getValue(j);
        assert(sub ~= sub_copy, ... % different objects
            [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
            [analysis_class '.copy() does not work'])
        
        data_codes = sub.getDataCodes();
        for k = 1:1:length(data_codes)
            data_code = data_codes{k};
            assert(sub.getData(data_code) ~= sub_copy.getData(data_code), ... % different objects
                [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
                [analysis_class '.copy() does not work'])
            assert(isequal(sub.getData(data_code).getBrainAtlas() , sub_copy.getData(data_code).getBrainAtlas()), ... % different objects
                [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
                [analysis_class '.copy() does not work'])
        end
    end
  
    for k = 1:1:cohort_analysis.getGroups().length()
        group = cohort_analysis.getGroups().getValue(k);
        group_copy = cohort_copy.getGroups().getValue(k);
        assert(group ~= group_copy, ... % different objects
            [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
            [analysis_class '.copy() does not work'])
        
        subs = group.getSubjects();
        subs_copy = group_copy.getSubjects();
        assert(subs{1} ~= subs_copy{1}, ... % different objects
            [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
            [analysis_class '.copy() does not work'])
    end
    
    % measurement part
    for m = 1:1:measurement_analysis_idict.length()
        measurement_analysis = measurement_analysis_idict.getValue(m);
        measurement_copy = measurement_copy_idict.getValue(m);
        atlases = measurement_analysis.getBrainAtlases();
        atlases_copy = measurement_copy.getBrainAtlases();
        
        assert(measurement_analysis ~= measurement_copy, ... % different objects
            [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
            [analysis_class '.copy() does not work'])
        
        for j = 1:1:length(atlases)
            assert(atlases{j} ~= atlases_copy{j}, ... % different objects
                [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
                [analysis_class '.copy() does not work'])
        end
        
        for k = 1:1:numel(measurement_analysis.getGroup())
            group = measurement_analysis.getGroup();
            group_copy = measurement_copy.getGroup();
            assert(group ~= group_copy, ... % different objects
                [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
                [analysis_class '.copy() does not work'])
            
            subs = group.getSubjects();
            subs_copy = group_copy.getSubjects();
            assert(subs{1} ~= subs_copy{1}, ... % different objects
                [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
                [analysis_class '.copy() does not work'])
        end
    end
    
    % randomcomparison part
    for rc = 1:1:randomcomparison_analysis_idict.length()
        randomcomparison_analysis = randomcomparison_analysis_idict.getValue(rc);
        randomcomparison_copy = randomcomparison_copy_idict.getValue(rc);
        atlases = randomcomparison_analysis.getBrainAtlases();
        atlases_copy = randomcomparison_copy.getBrainAtlases();
        
        assert(randomcomparison_analysis ~= randomcomparison_copy, ... % different objects
            [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
            [analysis_class '.copy() does not work'])
        
        for j = 1:1:length(atlases)
            assert(atlases{j} ~= atlases_copy{j}, ... % different objects
                [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
                [analysis_class '.copy() does not work'])
        end
        
        for k = 1:1:numel(randomcomparison_analysis.getGroup())
            group = randomcomparison_analysis.getGroup();
            group_copy = randomcomparison_copy.getGroup();
            assert(group ~= group_copy, ... % different objects
                [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
                [analysis_class '.copy() does not work'])
            
            subs = group.getSubjects();
            subs_copy = group_copy.getSubjects();
            assert(subs{1} ~= subs_copy{1}, ... % different objects
                [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
                [analysis_class '.copy() does not work'])
        end
    end
    
    % comparison part
    for c = 1:1:comparison_analysis_idict.length()
        comparison_analysis = comparison_analysis_idict.getValue(c);
        comparison_copy = comparison_copy_idict.getValue(c);
        atlases = comparison_analysis.getBrainAtlases();
        atlases_copy = comparison_copy.getBrainAtlases();
        
        assert(comparison_analysis ~= comparison_copy, ... % different objects
            [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
            [analysis_class '.copy() does not work'])
        
        for j = 1:1:length(atlases)
            assert(atlases{j} ~= atlases_copy{j}, ... % different objects
                [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
                [analysis_class '.copy() does not work'])
        end
        
        for k = 1:1:numel(comparison_analysis.getGroups())
            [group1, group2] = comparison.getGroups();
            [group1_copy, group2_copy] = comparison_copy.getGroups();

            assert(group1 ~= group1_copy, ... % different objects
                [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
                [analysis_class '.copy() does not work'])
                
            subs1 = group1.getSubjects();
            subs1_copy = group1_copy.getSubjects();
            assert(subs1{1} ~= subs1_copy{1}, ... % different objects
                [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
                [analysis_class '.copy() does not work'])
            assert(group1 ~= group1_copy, ... % different objects
                [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
                [analysis_class '.copy() does not work'])
                
            subs1 = group1.getSubjects();
            subs1_copy = group1_copy.getSubjects();
            assert(subs1{1} ~= subs1_copy{1}, ... % different objects
                [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
                [analysis_class '.copy() does not work'])

            assert(group2 ~= group2_copy, ... % different objects
                [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
                [analysis_class '.copy() does not work'])
                
            subs2 = group2.getSubjects();
            subs2_copy = group2_copy.getSubjects();
            assert(subs2{1} ~= subs2_copy{1}, ... % different objects
                [BRAPH2.STR ':' analysis_class ':' BRAPH2.BUG_COPY], ...
                [analysis_class '.copy() does not work'])
        end
    end
end