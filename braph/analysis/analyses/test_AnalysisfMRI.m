% test AnalysisfMRI
br1 = BrainRegion('BR1', 'brain region 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 5, 55, 555);
atlas = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

sub11 = SubjectfMRI(atlas, 'SubjectID', '11', 'fMRIAge', 20, 'fMRIValue', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub12 = SubjectfMRI(atlas, 'SubjectID', '12', 'fMRIAge', 20, 'fMRIValue', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub13 = SubjectfMRI(atlas, 'SubjectID', '13', 'fMRIAge', 20, 'fMRIValue', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub14 = SubjectfMRI(atlas, 'SubjectID', '14', 'fMRIAge', 20, 'fMRIValue', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub15 = SubjectfMRI(atlas, 'SubjectID', '15', 'fMRIAge', 20, 'fMRIValue', .5 + .5 * rand(atlas.getBrainRegions().length()));
group1 = Group('SubjectfMRI', {sub11, sub12, sub13, sub14, sub15}, 'GroupName', 'GroupTestfMRI1');

sub21 = SubjectfMRI(atlas, 'SubjectID', '21', 'fMRIAge', 20, 'fMRIValue', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub22 = SubjectfMRI(atlas, 'SubjectID', '22', 'fMRIAge', 20, 'fMRIValue', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub23 = SubjectfMRI(atlas, 'SubjectID', '23', 'fMRIAge', 20, 'fMRIValue', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub24 = SubjectfMRI(atlas, 'SubjectID', '24', 'fMRIAge', 20, 'fMRIValue', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub25 = SubjectfMRI(atlas, 'SubjectID', '25', 'fMRIAge', 20, 'fMRIValue', .5 + .5 * rand(atlas.getBrainRegions().length()));
group2 = Group('SubjectfMRI', {sub21, sub22, sub23, sub24, sub25}, 'GroupName', 'GroupTestfMRI2');

cohort = Cohort('Cohort fMRI', 'SubjectfMRI', atlas, {sub11, sub12, sub13, sub14, sub15, sub21, sub22, sub23, sub24, sub25});
cohort.getGroups().add(group1.getName(), group1)
cohort.getGroups().add(group2.getName(), group2)

%% Test 1: Instantiation
analysis = AnalysisfMRI(cohort, {}, {}, {}); %#ok<*NASGU>

%% Test 2: Create correct ID
analysis = AnalysisfMRI(cohort, {}, {}, {});
measurement_id = analysis.getMeasurementID('Degree', group1);
comparison_id = analysis.getComparisonID('Distance', {group1, group2});
randomcomparison_id = analysis.getRandomComparisonID('PathLength', group1);

assert(ischar(measurement_id), ...
    ['BRAPH:AnalysisfMRI:getMeasurementID'], ...
    ['.getMeasurementID() not creating an ID']) %#ok<*NBRAK>
assert(ischar(randomcomparison_id), ...
    ['BRAPH:AnalysisfMRI:getMeasurementID'], ...
    ['.getMeasurementID() not creating an ID']) %#ok<*NBRAK>
assert(ischar(comparison_id), ...
    ['BRAPH:AnalysisfMRI:getMeasurementID'], ...
    ['.getMeasurementID() not creating an ID']) %#ok<*NBRAK>

%% Test 3: Calculate Measurement
analysis = AnalysisfMRI(cohort, {}, {}, {});
calculated_measurement = analysis.calculateMeasurement('Degree', group1);

expected_answer = {[4; 4; 4; 4; 4;] [4; 4; 4; 4; 4;] [4; 4; 4; 4; 4;] [4; 4; 4; 4; 4;] [4; 4; 4; 4; 4;]};

assert(~isempty(calculated_measurement), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['AnalysisDTI.calculateMeasurement() not working']) %#ok<*NBRAK>
assert(isequal(calculated_measurement.getMeasureCode(), 'Degree'), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['AnalysisDTI.calculateMeasurement() not working']) %#ok<*NBRAK>
assert(isequal(calculated_measurement.getMeasureValues(), expected_answer), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['AnalysisDTI.calculateMeasurement() not working']) %#ok<*NBRAK>
assert(isequal(calculated_measurement.getGroupAverageValue(), 4), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['AnalysisDTI.calculateMeasurement() not working']) %#ok<*NBRAK>
