% test AnalysisMRI
br1 = BrainRegion('BR1', 'brain region 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 5, 55, 555);
atlas = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

% data obtain from http://braph.org/videos/mri/mri-cohort/  GR1_MRI.txt
% first 10 subjects, 5 brain regions. abs value
sub11 = SubjectMRI(atlas, 'SubjectID', '11', 'age', 15, 'MRI', [0.009254 0.015379 0.042376 0.001630 0.008111]');
sub12 = SubjectMRI(atlas, 'SubjectID', '12', 'age', 15, 'MRI', [0.015502 0.004323 0.013206 0.006639 0.001157]');
sub13 = SubjectMRI(atlas, 'SubjectID', '13', 'age', 15, 'MRI', [0.008979 0.115102 0.045353 0.001312 0.004045]');
sub14 = SubjectMRI(atlas, 'SubjectID', '14', 'age', 15, 'MRI', [0.016894 0.218212 0.028700 0.007709 0.004460]');
sub15 = SubjectMRI(atlas, 'SubjectID', '15', 'age', 15, 'MRI', [0.044055 0.033781 0.017567 0.002396	0.002815]');
group1 = Group('SubjectMRI', {sub11, sub12, sub13, sub14, sub15}, 'GroupName', 'GroupTestMRI1');

sub21 = SubjectMRI(atlas, 'SubjectID', '21', 'age', 15, 'MRI', [0.014241 0.000357 0.010545 0.000858	0.005674]');
sub22 = SubjectMRI(atlas, 'SubjectID', '22', 'age', 15, 'MRI', [0.026439 0.000055 0.020096 0.000803	0.000545]');
sub23 = SubjectMRI(atlas, 'SubjectID', '23', 'age', 15, 'MRI', [0.011974 0.056372 0.010924 0.015115 0.012533]');
sub24 = SubjectMRI(atlas, 'SubjectID', '24', 'age', 15, 'MRI', [0.035397 0.013930 0.044592 0.001359 0.004776]');
sub25 = SubjectMRI(atlas, 'SubjectID', '25', 'age', 15, 'MRI', [0.019584 0.013150 0.027739 0.013222 0.011735]');
group2 = Group('SubjectMRI', {sub21, sub22, sub23, sub24, sub25}, 'GroupName', 'GroupTestMRI2');

cohort = Cohort('Cohort MRI', 'SubjectMRI', atlas, {sub11, sub12, sub13, sub14, sub15, sub21, sub22, sub23, sub24, sub25});
cohort.getGroups().add(group1.getName(), group1)
cohort.getGroups().add(group2.getName(), group2)

measures = {'Assortativity', 'Degree', 'Distance'};

%% Test 1: Instantiation
analysis = AnalysisMRI(cohort, {}, {}, {}); %#ok<*NASGU>

%% Test 2: Create correct ID
analysis = AnalysisMRI(cohort, {}, {}, {});

measurement_id = analysis.getMeasurementID('Degree', group1);
expected_value = [ ...
    tostring(analysis.getMeasurementClass()) ' ' ...
    tostring('Degree') ' ' ...
    tostring(analysis.getCohort().getGroups().getIndex(group1)) ...
    ];
assert(ischar(measurement_id), ...
    ['BRAPH:AnalysisMRI:getMeasurementID'], ...
    ['AnalysisMRI.getMeasurementID() not creating an ID']) %#ok<*NBRAK>
assert(isequal(measurement_id, expected_value), ...
    ['BRAPH:AnalysisMRI:getMeasurementID'], ...
    ['AnalysisMRI.getMeasurementID() not creating correct ID']) %#ok<*NBRAK>

comparison_id = analysis.getComparisonID('Distance', {group1, group2});
expected_value = [ ...
    tostring(analysis.getComparisonClass()) ' ' ...
    tostring('Distance') ' ' ...
    tostring(analysis.getCohort().getGroups().getIndex(group1)) ' ' ...
    tostring(analysis.getCohort().getGroups().getIndex(group2)) ...
    ];
assert(ischar(comparison_id), ...
    ['BRAPH:AnalysisMRI:getComparisonID'], ...
    ['AnalysisMRI.getComparisonID() not creating an ID']) %#ok<*NBRAK>
assert(isequal(comparison_id, expected_value), ...
    ['BRAPH:AnalysisMRI:getComparisonID'], ...
    ['AnalysisMRI.getComparisonID() not creating correct ID']) %#ok<*NBRAK>

randomcomparison_id = analysis.getRandomComparisonID('PathLength', group1);
expected_value = [ ...
    tostring(analysis.getRandomComparisonClass()) ' ' ...
    tostring('PathLength') ' ' ...
    tostring(analysis.getCohort().getGroups().getIndex(group1)) ...
    ];
assert(ischar(randomcomparison_id), ...
    ['BRAPH:AnalysisMRI:getRandomComparisonID'], ...
    ['AnalysisMRI.getRandomComparisonID() not creating an ID']) %#ok<*NBRAK>
assert(isequal(randomcomparison_id, expected_value), ...
    ['BRAPH:AnalysisMRI:getRandomComparisonID'], ...
    ['AnalysisMRI.getRandomComparisonID() not creating correct ID']) %#ok<*NBRAK>


%% Test 3: Calculate Measurement
for i = 1:1:length(measures)
    measure = measures{i};
    analysis = AnalysisMRI(cohort, {}, {}, {});
    calculated_measurement = analysis.calculateMeasurement(measure, group1);
    
    assert(~isempty(calculated_measurement), ...
        ['BRAPH:AnalysisDTI:calculateMeasurement'], ...
        ['AnalysisDTI.calculateMeasurement() not working']) %#ok<*NBRAK>
    
    calculated_measurement = analysis.getMeasurements().getValue(1);
    calculated_value = calculated_measurement.getMeasureValue();
    
    if Measure.is_global(measure)
        
        assert(isequal(calculated_measurement.getMeasureCode(), measure), ...
            ['BRAPH:AnalysisDTI:calculateMeasurement'], ...
            ['AnalysisDTI.calculateMeasurement() not working for global']) %#ok<*NBRAK>
        assert(iscell(calculated_value) & ...
            isequal(numel(calculated_value), 1) & ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), calculated_value)), ...
            ['BRAPH:MeasurementMRI:Instantiation'], ...
            ['MeasurementMRI does not initialize correctly with global measures.']) %#ok<*NBRAK>
        
    elseif Measure.is_nodal(measure)
        
        assert(isequal(calculated_measurement.getMeasureCode(), measure), ...
            ['BRAPH:AnalysisDTI:calculateMeasurement'], ...
            ['AnalysisDTI.calculateMeasurement() not working for nodal']) %#ok<*NBRAK>
        assert(iscell(calculated_value) & ...
            isequal(numel(calculated_value), 1) & ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), calculated_value)), ...
            ['BRAPH:MeasurementMRI:Instantiation'], ...
            ['MeasurementMRI does not initialize correctly with nodal measures.']) %#ok<*NBRAK>
    else
        
        assert(isequal(calculated_measurement.getMeasureCode(), measure), ...
            ['BRAPH:AnalysisDTI:calculateMeasurement'], ...
            ['AnalysisDTI.calculateMeasurement() not working for binodal']) %#ok<*NBRAK>
        assert(iscell(calculated_value) & ...
            isequal(numel(calculated_value), 1) & ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), calculated_value)), ...
            ['BRAPH:MeasurementMRI:Instantiation'], ...
            ['MeasurementMRI does not initialize correctly with binodal measures.']) %#ok<*NBRAK>
    end
end

