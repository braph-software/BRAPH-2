% test AnalysisDTI
br1 = BrainRegion('BR1', 'brain region 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 5, 55, 555);
atlas = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

sub11 = SubjectDTI(atlas, 'SubjectID', '11', 'DTIAge', 20, 'DTIValue', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub12 = SubjectDTI(atlas, 'SubjectID', '12', 'DTIAge', 20, 'DTIValue', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub13 = SubjectDTI(atlas, 'SubjectID', '13', 'DTIAge', 20, 'DTIValue', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub14 = SubjectDTI(atlas, 'SubjectID', '14', 'DTIAge', 20, 'DTIValue', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub15 = SubjectDTI(atlas, 'SubjectID', '15', 'DTIAge', 20, 'DTIValue', .5 + .5 * rand(atlas.getBrainRegions().length()));
group1 = Group('SubjectDTI 1', {sub11, sub12, sub13, sub14, sub15}, 'GroupName', 'GroupTestDTI1');

sub21 = SubjectDTI(atlas, 'SubjectID', '21', 'DTIAge', 20, 'DTIValue', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub22 = SubjectDTI(atlas, 'SubjectID', '22', 'DTIAge', 20, 'DTIValue', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub23 = SubjectDTI(atlas, 'SubjectID', '23', 'DTIAge', 20, 'DTIValue', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub24 = SubjectDTI(atlas, 'SubjectID', '24', 'DTIAge', 20, 'DTIValue', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub25 = SubjectDTI(atlas, 'SubjectID', '25', 'DTIAge', 20, 'DTIValue', .5 + .5 * rand(atlas.getBrainRegions().length()));
group2 = Group('SubjectDTI 2', {sub21, sub22, sub23, sub24, sub25}, 'GroupName', 'GroupTestDTI2');

cohort = Cohort('Cohort DTI', 'SubjectDTI', atlas, {sub11, sub12, sub13, sub14, sub15, sub21, sub22, sub23, sub24, sub25});
cohort.getGroups().add(group1.getName(), group1)
cohort.getGroups().add(group2.getName(), group2)

%% Test 1: Instantiation
analysis = AnalysisDTI(cohort, {}, {}, {}); %#ok<NASGU>

%% Test 2: Create correct ID
analysis = AnalysisDTI(cohort, {}, {}, {});

measurement_id = analysis.getMeasurementID('Degree', group1);
assert(ischar(measurement_id), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['AnalysisDTI.getMeasurementID() not creating an ID']) %#ok<*NBRAK>

comparison_id = analysis.getComparisonID('Distance', {group1, group2});
assert(ischar(comparison_id), ...
    ['BRAPH:AnalysisDTI:getComparisonID'], ...
    ['AnalysisDTI.getComparisonID() not creating an ID']) %#ok<*NBRAK>

randomcomparison_id = analysis.getRandomComparisonID('PathLength', group1);
assert(ischar(randomcomparison_id), ...
    ['BRAPH:AnalysisDTI:getRandomComparisonID'], ...
    ['AnalysisDTI.getRandomComparisonID() not creating an ID']) %#ok<*NBRAK>

%% Test 3: Calculate Measurement
analysis = AnalysisDTI(cohort, {}, {}, {});
calculated_measurement = analysis.calculateMeasurement('Degree', group1);

expected_answer = [4 4 4 4 4; 4 4 4 4 4; 4 4 4 4 4; 4 4 4 4 4; 4 4 4 4 4;];

assert(~isempty(calculated_measurement), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['AnalysisDTI.calculateMeasurement() not working']) %#ok<*NBRAK>
assert(isequal(calculated_measurement.getMeasureCode(), 'Degree'), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['AnalysisDTI.calculateMeasurement() not working']) %#ok<*NBRAK>
assert(isequal(calculated_measurement.getMeasure(), expected_answer), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['AnalysisDTI.calculateMeasurement() not working']) %#ok<*NBRAK>
assert(isequal(calculated_measurement.getGroupAverageValue(), 4), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['AnalysisDTI.calculateMeasurement() not working']) %#ok<*NBRAK>
