% test AnalysisMultiplexMRI

br1 = BrainRegion('BR1', 'brain region 1', 'notes 1', 1, 1.1, 1.11);
br2 = BrainRegion('BR2', 'brain region 2', 'notes 2', 2, 2.2, 2.22);
br3 = BrainRegion('BR3', 'brain region 3', 'notes 3', 3, 3.3, 3.33);
br4 = BrainRegion('BR4', 'brain region 4', 'notes 4', 4, 4.4, 4.44);
br5 = BrainRegion('BR5', 'brain region 5', 'notes 5', 5, 5.5, 5.55);
atlas = BrainAtlas('BA', 'brain atlas', 'notes', 'BrainMesh_ICBM152.nv', {br1, br2, br3, br4, br5});

% data obtain from http://braph.org/videos/mri/mri-cohort/  GR1_MRI.txt
% first 10 subjects, 5 brain regions. abs value
sub11 = SubjectMultiplexMRI('ID11', 'label 11', 'notes 11', atlas, 'age', 15, 'MRI1', [0.009254 0.015379 0.042376 0.001630 0.008111]', 'MRI2', [0.751324 0.283473 0.617762 0.248406 0.986245]');
sub12 = SubjectMultiplexMRI('ID12', 'label 12', 'notes 12', atlas, 'age', 15, 'MRI1', [0.015502 0.004323 0.013206 0.006639 0.001157]', 'MRI2', [0.010598 0.171979 0.584338 0.380741 0.589159]');
sub13 = SubjectMultiplexMRI('ID13', 'label 13', 'notes 13', atlas, 'age', 15, 'MRI1', [0.008979 0.115102 0.045353 0.001312 0.004045]', 'MRI2', [0.875963 0.618298 0.669873 0.925564 0.274040]');
sub14 = SubjectMultiplexMRI('ID14', 'label 14', 'notes 14', atlas, 'age', 15, 'MRI1', [0.016894 0.218212 0.028700 0.007709 0.004460]', 'MRI2', [0.617379 0.879746 0.881440 0.168771 0.400157]');

group1 = Group('SubjectMultiplexMRI', 'group 1 id', 'group 1 label', 'group 1 notes', {sub11, sub12, sub13, sub14}, 'GroupName', 'GroupTestMultiplexMRI1');

sub21 = SubjectMultiplexMRI('ID21', 'label 21', 'notes 21', atlas, 'age', 15, 'MRI1', [0.014241 0.000357 0.010545 0.000858 0.005674]', 'MRI2', [0.604707 0.965733 0.332299 0.755957 0.125229]');
sub22 = SubjectMultiplexMRI('ID22', 'label 22', 'notes 22', atlas, 'age', 15, 'MRI1', [0.026439 0.000055 0.020096 0.000803 0.000545]', 'MRI2', [0.015752 0.622754 0.428558 0.641286 0.128858]');
sub23 = SubjectMultiplexMRI('ID23', 'label 23', 'notes 23', atlas, 'age', 15, 'MRI1', [0.011974 0.056372 0.010924 0.015115 0.012533]', 'MRI2', [0.268480 0.900563 0.724331 0.544446 0.368332]');

group2 = Group('SubjectMultiplexMRI', 'group 2 id', 'group 2 label', 'group 2 notes', {sub21, sub22, sub23}, 'GroupName', 'GroupTestMultiplexMRI2');

cohort = Cohort('Cohort Multiplex MRI', 'cohort label', 'cohort notes', 'SubjectMultiplexMRI', atlas, {sub11, sub12, sub13, sub14, sub21, sub22, sub23});
cohort.getGroups().add(group1.getID(), group1)
cohort.getGroups().add(group2.getID(), group2)

graph_type = AnalysisMultiplexMRI.getGraphType();
measures = Graph.getCompatibleMeasureList(graph_type);

%% Test 1: Instantiation
analysis = AnalysisMultiplexMRI('analysis id', 'analysis label', 'analysis notes', cohort, {}, {}, {}); %#ok<NASGU>

%% Test 2: Create correct ID
analysis = AnalysisMultiplexMRI('analysis id', 'analysis label', 'analysis notes', cohort, {}, {}, {});

measurement_id = analysis.getMeasurementID('Degree', group1);
expected_value = [ ...
    tostring(analysis.getMeasurementClass()) ' ' ...
    tostring('Degree') ' ' ...
    tostring(analysis.getCohort().getGroups().getIndex(group1)) ...
    ];
assert(ischar(measurement_id), ...
    [BRAPH2.STR ':AnalysisMultiplexMRI:' BRAPH2.WRONG_OUTPUT], ...
    'AnalysisMultiplexMRI.getMeasurementID() not creating an ID')
assert(isequal(measurement_id, expected_value), ...
    [BRAPH2.STR ':AnalysisMultiplexMRI:' BRAPH2.WRONG_OUTPUT], ...
    'AnalysisMultiplexMRI.getMeasurementID() not creating correct ID')

%  todo: randomcomparison
%  todo: comparison

%% Test 3: Calculate Measurement
for i = 1:1:length(measures)
    measure = measures{i};
    analysis = AnalysisMultiplexMRI('analysis id', 'analysis label', 'analysis notes', cohort, {}, {}, {});
    calculated_measurement = analysis.getMeasurement(measure, group1);
    
    assert(~isempty(calculated_measurement), ...
        [BRAPH2.STR ':AnalysisMultiplexMRI:' BRAPH2.BUG_FUNC], ...
        'AnalysisMultiplexMRI.getMeasurement() not working')
    
    measurement_keys = analysis.getMeasurements().getKeys();
    
    for j = 1:1:numel(measurement_keys)
        calculated_measurement = analysis.getMeasurements().getValue(measurement_keys{j});
        calculated_value = calculated_measurement.getMeasureValue();
        
        if Measure.is_superglobal(measures{i})
            num_elements = 1;
        elseif Measure.is_unilayer(measures{i})
            num_elements = 2;
        elseif Measure.is_bilayer(measures{i})
            num_elements = 4;
        end
        
        if Measure.is_global(measure)
            
            assert(isequal(calculated_measurement.getMeasureCode(), measure), ...
                [BRAPH2.STR ':AnalysisMultiplexMRI:calculateMeasurement'], ...
                ['AnalysisMultiplexMRI.calculateMeasurement() not working for global']) %#ok<*NBRAK>
            assert(iscell(calculated_value) & ...
                isequal(numel(calculated_value), num_elements) & ...
                all(cellfun(@(x) isequal(size(x), [1, 1]), calculated_value)), ...
                [BRAPH2.STR ':AnalysisMultiplexMRI:Instantiation'], ...
                ['AnalysisMultiplexMRI does not initialize correctly with global measures.']) %#ok<*NBRAK>
            
        elseif Measure.is_nodal(measure)
            
            assert(isequal(calculated_measurement.getMeasureCode(), measure), ...
                [BRAPH2.STR ':AnalysisMultiplexMRI:calculateMeasurement'], ...
                ['AnalysisMultiplexMRI.calculateMeasurement() not working for nodal']) %#ok<*NBRAK>
            assert(iscell(calculated_value) & ...
                isequal(numel(calculated_value), num_elements) & ...
                all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), calculated_value)), ...
                [BRAPH2.STR ':AnalysisMultiplexMRI:Instantiation'], ...
                ['AnalysisMultiplexMRI does not initialize correctly with nodal measures.']) %#ok<*NBRAK>
        
        elseif Measure.is_binodal(measure)
            
            assert(isequal(calculated_measurement.getMeasureCode(), measure), ...
                [BRAPH2.STR ':AnalysisMultiplexMRI:calculateMeasurement'], ...
                ['AnalysisMultiplexMRI.calculateMeasurement() not working for binodal']) %#ok<*NBRAK>
            assert(iscell(calculated_value) & ...
                isequal(numel(calculated_value), num_elements) & ...
                all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), calculated_value)), ...
                [BRAPH2.STR ':AnalysisMultiplexMRI:Instantiation'], ...
                ['AnalysisMultiplexMRI does not initialize correctly with binodal measures.']) %#ok<*NBRAK>
        end
    end
end 

%% Test 4: Random Compare
% todo

%% Test 5: Compare
% todo