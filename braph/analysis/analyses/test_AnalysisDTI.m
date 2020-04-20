% test AnalysisDTI
br1 = BrainRegion('BR1', 'brain region 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 5, 55, 555);
atlas = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

sub1 = SubjectDTI(atlas, 'SubjectID', '1', 'DTIAge', 20, 'DTIValue', rand(atlas.getBrainRegions().length()));
sub2 = SubjectDTI(atlas, 'SubjectID', '2', 'DTIAge', 20, 'DTIValue', rand(atlas.getBrainRegions().length()));
sub3 = SubjectDTI(atlas, 'SubjectID', '3', 'DTIAge', 20, 'DTIValue', rand(atlas.getBrainRegions().length()));
sub4 = SubjectDTI(atlas, 'SubjectID', '4', 'DTIAge', 20, 'DTIValue', rand(atlas.getBrainRegions().length()));
sub5 = SubjectDTI(atlas, 'SubjectID', '5', 'DTIAge', 20, 'DTIValue', rand(atlas.getBrainRegions().length()));
group1 = Group('SubjectDTI', {sub1, sub2, sub3, sub4, sub5}, 'GroupName', 'GroupTestDTI1');
group2 = Group('SubjectDTI', {sub1, sub2, sub3, sub4, sub5}, 'GroupName', 'GroupTestDTI2');

cohort = Cohort('Cohort DTI', 'SubjectDTI', atlas, {sub1, sub2, sub3, sub4, sub5});
cohort.getGroups().add(group1.getName(), group1)
cohort.getGroups().add(group2.getName(), group2)

%% Test 1: Instantiation
analysis = AnalysisDTI(cohort, {}, {}, {}); %#ok<NASGU>

%% Test 2: Create correct ID
analysis = AnalysisDTI(cohort, {}, {}, {});
measurement_id = analysis.getMeasurementID('Degree', group1);
comparison_id = analysis.getComparisonID('Distance', {group1, group2});
randomcomparison_id = analysis.getRandomComparisonID('PathLength', group1);

assert(ischar(measurement_id), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['.getMeasurementID() not creating an ID']) %#ok<*NBRAK>
assert(ischar(randomcomparison_id), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['.getMeasurementID() not creating an ID']) %#ok<*NBRAK>
assert(ischar(comparison_id), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['.getMeasurementID() not creating an ID']) %#ok<*NBRAK>

%% Test 3: Calculate Measurement
analysis = AnalysisDTI(cohort, {}, {}, {});
calculated_measurement = analysis.calculateMeasurement('Degree', group1, 'GraphType', 'GraphWU');

expected_answer = [4 4 4 4 4; 4 4 4 4 4; 4 4 4 4 4; 4 4 4 4 4; 4 4 4 4 4;];

assert(~isempty(calculated_measurement), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['.calculateMeasurement() not working']) %#ok<*NBRAK>
assert(isequal(calculated_measurement.getMeasureCode(), 'Degree'), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['.calculateMeasurement() not working']) %#ok<*NBRAK>
assert(isequal(calculated_measurement.getMeasure(), expected_answer), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['.calculateMeasurement() not working']) %#ok<*NBRAK>
assert(isequal(calculated_measurement.getGroupAverageValue(), 4), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['.calculateMeasurement() not working']) %#ok<*NBRAK>

