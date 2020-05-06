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
    sub_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    cohort = Cohort('cohort', sub_class, atlases, {});
    analysis = Analysis.getAnalysis(analysis_class, cohort, {}, {}, {});
end

%% Test 2: Implementation static methods
for i = 1:1:length(analysis_class_list)
    analysis_class = analysis_class_list{i};
    sub_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    cohort = Cohort('cohort', sub_class, atlases, {});
    analysis = Analysis.getAnalysis(analysis_class, cohort, {}, {}, {});
    
    assert(iscell(analysis.getList()), ...
        ['BRAPH:' analysis_class ':StaticFuncImplementation'], ...
        [analysis_class '.getList() should return a cell'])
    
    assert(isequal(analysis.getClass(), analysis_class), ...
        ['BRAPH:' analysis_class ':StaticFuncImplementation'], ...
        [analysis_class '.getClass() should return ' analysis_class ])
    
    assert(ischar(analysis.getClass()), ...
        ['BRAPH:' analysis_class ':StaticFuncImplementation'], ...
        [analysis_class '.getClass() should return a char array'])
    
    assert(ischar(analysis.getName()), ...
        ['BRAPH:' analysis_class ':StaticFuncImplementation'], ...
        [analysis_class '.getName() should return a char array'])
    
    assert(ischar(analysis.getSubjectClass()), ...
        ['BRAPH:' analysis_class ':StaticFuncImplementation'], ...
        [analysis_class '.getSubjectClass() should return a char array'])
    
    assert(ischar(analysis.getDescription()), ...
        ['BRAPH:' analysis_class ':StaticFuncImplementation'], ...
        [analysis_class '.getDescription() should return a char array'])
    
    assert(ischar(analysis.getMeasurementClass()), ...
        ['BRAPH:' analysis_class ':StaticFuncImplementation'], ...
        [analysis_class '.getMeasurementClass() should return a string'])
    
    assert(ischar(analysis.getRandomComparisonClass()), ...
        ['BRAPH:' analysis_class ':StaticFuncImplementation'], ...
        [analysis_class '.getRandomComparisonClass() should return a string'])
    
    assert(ischar(analysis.getComparisonClass()), ...
        ['BRAPH:' analysis_class ':StaticFuncImplementation'], ...
        [analysis_class '.getComparisonClass() should return a string'])
    
    assert(iscell(analysis.getAvailableSettings()), ...
        ['BRAPH:' analysis_class ':StaticFuncImplementation'], ...
        [analysis_class '.getMeasurementClass() should return a cell array'])
    
end

%% Test 3: Instantiation with Measurement
for i = 1:1:length(analysis_class_list)
    % setup
    analysis_class = analysis_class_list{i};
    sub_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    measurement_class = Analysis.getMeasurementClass(analysis_class);
    comparison_class = Analysis.getComparisonClass(analysis_class);
    random_comparison_class = Analysis.getRandomComparisonClass(analysis_class);
    
    % act
    measurement = Measurement.getMeasurement(measurement_class, 'm1', atlas, group, [measurement_class '.measure_code'], 'Degree');
    comparison = Comparison.getComparison(comparison_class, 'c1', atlas, {group group}, [comparison_class '.measure_code'], 'Degree');
    randomcomparison = RandomComparison.getRandomComparison(random_comparison_class, 'rc1', atlas, group, [random_comparison_class '.measure_code'], 'Degree');
    analysis = Analysis.getAnalysis(analysis_class, cohort, {measurement}, {randomcomparison}, {comparison});
    
    % assert
    assert(isa(analysis, analysis_class), ...
        ['BRAPH:' analysis_class ':Instantiation'], ...
        [analysis_class 'Instantiation error with measurements.'])
end

%% Test 4: Basic Functions
for i = 1:1:length(analysis_class_list)
    % setup
    analysis_class = analysis_class_list{i};
    sub_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    measurement_class = Analysis.getMeasurementClass(analysis_class);
    comparison_class = Analysis.getComparisonClass(analysis_class);
    random_comparison_class = Analysis.getRandomComparisonClass(analysis_class);
    
    % act
    measurement1 = Measurement.getMeasurement(measurement_class, 'm1', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement = {measurement1, measurement2};
    comparison = Comparison.getComparison(comparison_class, 'c1', atlas, {group group}, [comparison_class '.measure_code'], 'Degree');
    randomcomparison = RandomComparison.getRandomComparison(random_comparison_class, 'rc1', atlas, group);
    analysis = Analysis.getAnalysis(analysis_class, cohort, measurement, {randomcomparison}, {comparison});
    
    % assert
    assert(analysis.getMeasurements().length()==2, ...
        'BRAPH:Analysis:Bug', ...
        'Analysis.getMeasurements().length() does not work')
    assert(analysis.getMeasurements().contains(1), ...
        'BRAPH:Cohort:Bug', ...
        'Analysis.contains_subject does not work')
    assert(~analysis.getMeasurements().contains(3), ...
        'BRAPH:Cohort:Bug', ...
        'Analysis.contains_subject does not work')
    assert(analysis.getRandomComparisons().length() == 1, ...
        'BRAPH:Analysis:Bug', ...
        'Analysis.getRandomComparisons().length() does not work');
    assert(analysis.getRandomComparisons().length() == 1, ...
        'BRAPH:Analysis:Bug', ...
        'Analysis.getRandomComparisons().length() does not work');
    
end

%% Test 5: Add
for i = 1:1:length(analysis_class_list)
    
    analysis_class = analysis_class_list{i};
    sub_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    measurement_class = Analysis.getMeasurementClass(analysis_class);
    comparison_class = Analysis.getComparisonClass(analysis_class);
    random_comparison_class = Analysis.getRandomComparisonClass(analysis_class);
    measurement1 = Measurement.getMeasurement(measurement_class, 'm1', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement_cell1 = {measurement1, measurement2};
    measurement3 = Measurement.getMeasurement(measurement_class, 'm3', atlas, group, [measurement_class '.measure_code'], 'Degree');
    comparison = Comparison.getComparison(comparison_class, 'c1', atlas, {group group}, [comparison_class '.measure_code'], 'Degree');
    randomcomparison = RandomComparison.getRandomComparison(random_comparison_class, 'rc1', atlas, group);  % will not pass rule to get default
    
    analysis = Analysis.getAnalysis(analysis_class, cohort, measurement_cell1, {randomcomparison}, {comparison});
    analysis.getMeasurements().add(measurement3.getID(), measurement3);
    analysis.getRandomComparisons().add(randomcomparison.getID(), randomcomparison);
    analysis.getComparisons().add(comparison.getID(), comparison);
    
    assert(analysis.getMeasurements().length()==3, ...
        'BRAPH:Analysis:Bug', ...
        'getMeasurements().add() does not work')
    assert(analysis.getRandomComparisons().length()==2, ...
        'BRAPH:Analysis:Bug', ...
        'getComparisons().add() does not work')
    assert(analysis.getComparisons().length()==2, ...
        'BRAPH:Analysis:Bug', ...
        'getRandomComparisons().add() does not work')
end

%% Test 6: Remove
for i = 1:1:length(analysis_class_list)
    
    % setup
    analysis_class = analysis_class_list{i};
    sub_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    measurement_class = Analysis.getMeasurementClass(analysis_class);
    comparison_class = Analysis.getComparisonClass(analysis_class);
    random_comparison_class = Analysis.getRandomComparisonClass(analysis_class);
    
    measurement1 = Measurement.getMeasurement(measurement_class, 'm1', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement = {measurement1, measurement2};
    
    % act
    analysis = Analysis.getAnalysis(analysis_class, cohort, measurement, {}, {});
    analysis.getMeasurements().remove(2);
    
    % assert
    assert(analysis.getMeasurements().length()==1, ...
        'BRAPH:Analysis:Bug', ...
        'Analysis.removeMeasurement() does not work')
end

%% Test 7: Replace
for i = 1:1:length(analysis_class_list)
    
    % setup
    analysis_class = analysis_class_list{i};
    sub_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    measurement_class = Analysis.getMeasurementClass(analysis_class);
    comparison_class = Analysis.getComparisonClass(analysis_class);
    random_comparison_class = Analysis.getRandomComparisonClass(analysis_class);
    measurement1 = Measurement.getMeasurement(measurement_class, 'm1', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement = {measurement1, measurement2};
    
    % act
    analysis = Analysis.getAnalysis(analysis_class, cohort, measurement, {}, {});
    measurement3 = Measurement.getMeasurement(measurement_class, 'm3', atlas, group, [measurement_class '.measure_code'], 'Degree');
    analysis.getMeasurements().replace(measurement3.getName(), measurement3, 2);
    
    % assert
    assert(analysis.getMeasurements().length()==2, ...
        'BRAPH:Analysis:Bug', ...
        'Analysis.replaceMeasurement() does not work')
    assert( isequal(analysis.getMeasurements().getValue(2).getClass(), measurement_class), ...
        'BRAPH:Analysis:Bug', ...
        'Analysis.replaceMeasurement() does not work')
end

%% Test 8: Invert
for i = 1:1:length(analysis_class_list)
    
    % setup
    analysis_class = analysis_class_list{i};
    sub_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    measurement_class = Analysis.getMeasurementClass(analysis_class);
    comparison_class = Analysis.getComparisonClass(analysis_class);
    random_comparison_class = Analysis.getRandomComparisonClass(analysis_class);
    measurement1 = Measurement.getMeasurement(measurement_class, 'm1', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement = {measurement1, measurement2};
    
    % act
    analysis = Analysis.getAnalysis(analysis_class, cohort, measurement, {}, {});
    analysis.getMeasurements().invert(2, 1);
    
    % assert
    assert( isequal(analysis.getMeasurements().getValue(2).getClass(), measurement_class), ...
        'BRAPH:Analysis:Bug', ...
        'Analysis.invertMeasurements() does not work')
end

%% Test 9: MoveTo
for i = 1:1:length(analysis_class_list)
    % setup
    analysis_class = analysis_class_list{i};
    sub_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    measurement_class = Analysis.getMeasurementClass(analysis_class);
    comparison_class = Analysis.getComparisonClass(analysis_class);
    random_comparison_class = Analysis.getRandomComparisonClass(analysis_class);
    measurement1 = Measurement.getMeasurement(measurement_class, 'm1', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement3 = Measurement.getMeasurement(measurement_class, 'm3', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement = {measurement1, measurement2, measurement3};
    
    % act
    analysis = Analysis.getAnalysis(analysis_class, cohort, measurement, {}, {});
    analysis.getMeasurements().move_to(3, 1);
    
    % assert
    assert( isequal(analysis.getMeasurements().getValue(1).getClass(), measurement_class), ...
        'BRAPH:Analysis:Bug', ...
        'Analysis.movetoMeasurement() does not work')
end

%% Test 10: RemoveAll
for i = 1:1:length(analysis_class_list)
    % setup
    analysis_class = analysis_class_list{i};
    sub_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    measurement_class = Analysis.getMeasurementClass(analysis_class);
    comparison_class = Analysis.getComparisonClass(analysis_class);
    random_comparison_class = Analysis.getRandomComparisonClass(analysis_class);
    measurement1 = Measurement.getMeasurement(measurement_class, 'm1', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement3 = Measurement.getMeasurement(measurement_class, 'm3', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement = {measurement1, measurement2, measurement3};
    
    % act
    analysis = Analysis.getAnalysis(analysis_class, cohort, measurement, {}, {});
    selected = analysis.getMeasurements().remove_all([1, 3]);
    
    % assert
    assert(analysis.getMeasurements().length()==1, ...
        'BRAPH:Analysis:Bug', ...
        'Analysis.removeMeasurements() does not work')
    assert( isequal(analysis.getMeasurements().getValue(1).getClass(), measurement_class), ...
        'BRAPH:Analysis:Bug', ...
        'Analysis.removeMeasurements() does not work')
    assert(isempty(selected), ...
        'BRAPH:Analysis:Bug', ...
        'Analysis.removeMeasurements() does not work')
end

%% Test 11: MoveUp
for i = 1:1:length(analysis_class_list)
    % setup
    analysis_class = analysis_class_list{i};
    sub_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    cohort.getGroups().add(group.getName(), group);
    measurement_class = Analysis.getMeasurementClass(analysis_class);
    comparison_class = Analysis.getComparisonClass(analysis_class);
    random_comparison_class = Analysis.getRandomComparisonClass(analysis_class);
    measurement1 = Measurement.getMeasurement(measurement_class, 'm1', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement3 = Measurement.getMeasurement(measurement_class, 'm3', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement = {measurement1, measurement2, measurement3};
    
    % act
    analysis = Analysis.getAnalysis(analysis_class, cohort, measurement, {}, {});
    selected = analysis.getMeasurements().move_up([2 3]);
    
    % assert
    assert(analysis.getMeasurements().length()==3, ...
        'BRAPH:Analysis:Bug', ...
        'Analysis.moveupMeasurements() does not work')
    assert( isequal(analysis.getMeasurements().getValue(1).getClass(), measurement_class), ...
        'BRAPH:Analysis:Bug', ...
        'Analysis.moveupMeasurements() does not work')
end

%% Test 12: MoveDown
for i = 1:1:length(analysis_class_list)
    % setup
    analysis_class = analysis_class_list{i};
    sub_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    cohort.getGroups().add(group.getName(), group);
    measurement_class = Analysis.getMeasurementClass(analysis_class);
    comparison_class = Analysis.getComparisonClass(analysis_class);
    random_comparison_class = Analysis.getRandomComparisonClass(analysis_class);
    measurement1 = Measurement.getMeasurement(measurement_class, 'm1', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement3 = Measurement.getMeasurement(measurement_class, 'm3', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement = {measurement1, measurement2, measurement3};
    
    % act
    analysis = Analysis.getAnalysis(analysis_class, cohort, measurement, {}, {});
    selected = analysis.getMeasurements().move_down([1 2]);
    % assert
    assert(analysis.getMeasurements().length()==3, ...
        'BRAPH:Analysis:Bug', ...
        'Analysis.movedownMeasurements() does not work')
    assert( isequal(analysis.getMeasurements().getValue(3).getClass(), measurement_class), ...
        'BRAPH:Analysis:Bug', ...
        'Analysis.movedownMeasurements() does not work')
end

%% Test 13: MoveToTop
for i = 1:1:length(analysis_class_list)
    % setup
    analysis_class = analysis_class_list{i};
    sub_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    cohort.getGroups().add(group.getName(), group);
    measurement_class = Analysis.getMeasurementClass(analysis_class);
    comparison_class = Analysis.getComparisonClass(analysis_class);
    random_comparison_class = Analysis.getRandomComparisonClass(analysis_class);
    measurement1 = Measurement.getMeasurement(measurement_class, 'm1', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement3 = Measurement.getMeasurement(measurement_class, 'm3', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement = {measurement1, measurement2, measurement3};
    
    % act
    analysis = Analysis.getAnalysis(analysis_class, cohort, measurement, {}, {});
    selected = analysis.getMeasurements().move_to_top([3]);  %#ok<NBRAK>
    
    % assert
    assert(analysis.getMeasurements().length()==3, ...
        'BRAPH:Analysis:Bug', ...
        'Analysis.move2topMeasurements() does not work')
    assert( isequal(analysis.getMeasurements().getValue(1).getClass(), measurement_class), ...
        'BRAPH:Analysis:Bug', ...
        'Analysis.move2topMeasurements() does not work')
end

%% Test 14: MoveToBottom
for i = 1:1:length(analysis_class_list)
    % setup
    analysis_class = analysis_class_list{i};
    sub_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    cohort.getGroups().add(group.getName(), group);
    measurement_class = Analysis.getMeasurementClass(analysis_class);
    comparison_class = Analysis.getComparisonClass(analysis_class);
    random_comparison_class = Analysis.getRandomComparisonClass(analysis_class);
    measurement1 = Measurement.getMeasurement(measurement_class, 'm1', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement2 = Measurement.getMeasurement(measurement_class, 'm2', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement3 = Measurement.getMeasurement(measurement_class, 'm3', atlas, group, [measurement_class '.measure_code'], 'Degree');
    measurement = {measurement1, measurement2, measurement3};
    
    % act
    analysis = Analysis.getAnalysis(analysis_class, cohort, measurement, {}, {});
    selected = analysis.getMeasurements().move_to_bottom([1]);  %#ok<NBRAK>
    
    % assert
    assert(analysis.getMeasurements().length()==3, ...
        'BRAPH:Analysis:Bug', ...
        'Analysis.move2topMeasurements() does not work')
    assert( isequal(analysis.getMeasurements().getValue(3).getClass(), measurement_class), ...
        'BRAPH:Analysis:Bug', ...
        'Analysis.move2topMeasurements() does not work')
end

%% Test 15: Copy
for i =1:1:length(analysis_class_list)
    % setup
    analysis_class = analysis_class_list{i};
    sub_class = Analysis.getSubjectClass(analysis_class);
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
    group = Group(sub_class, {sub1, sub2, sub3});
    measurement_class = Analysis.getMeasurementClass(analysis_class);
    comparison_class = Analysis.getComparisonClass(analysis_class);
    random_comparison_class = Analysis.getRandomComparisonClass(analysis_class);
    measurement = Measurement.getMeasurement(measurement_class, 'm1', atlas, group, [measurement_class '.measure_code'], 'Degree');
    comparison = Comparison.getComparison(comparison_class, 'c1', atlas, {group group}, [comparison_class '.measure_code'], 'Degree');
    randomcomparison = RandomComparison.getRandomComparison(random_comparison_class, 'rc1', atlas, group);
    analysis = Analysis.getAnalysis(analysis_class, cohort, {measurement}, {randomcomparison}, {comparison});
    
    % act
    analysis_copy = analysis.copy();
    
    assert(analysis ~= analysis_copy, ... % different objects
        ['BRAPH:Analysis:Copy'], ...
        ['Analysis.copy() does not work']) %#ok<NBRAK>
    
    cohort_analysis = analysis.getCohort();
    measurement_analysis = analysis.getMeasurements();
    comparison_analysis = analysis.getComparisons();
    randomcomparison_analysis = analysis.getRandomComparisons();
    
    cohort_copy = analysis_copy.getCohort();
    measurement_copy = analysis_copy.getMeasurements();
    comparison_copy = analysis_copy.getComparisons();
    randomcomparison_copy = analysis_copy.getRandomComparisons();
    
    assert(cohort_analysis ~= cohort_copy, ... % different objects
        ['BRAPH:Analysis:Copy'], ...
        ['Analysis.copy() does not work']) %#ok<NBRAK>
    assert(measurement_analysis ~= measurement_copy, ... % different objects
        ['BRAPH:Analysis:Copy'], ...
        ['Analysis.copy() does not work']) %#ok<NBRAK>
    assert(comparison_analysis ~= comparison_copy, ... % different objects
        ['BRAPH:Analysis:Copy'], ...
        ['Analysis.copy() does not work']) %#ok<NBRAK>
    assert(randomcomparison_analysis ~= randomcomparison_copy, ... % different objects
        ['BRAPH:Analysis:Copy'], ...
        ['Analysis.copy() does not work']) %#ok<NBRAK>
    
end