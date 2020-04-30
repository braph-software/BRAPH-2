% test MeasurementfMRI
br1 = BrainRegion('BR1', 'brain region 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 5, 55, 555);
atlas = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

subject_class = 'SubjectfMRI'; 

sub1 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 1);
sub2 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 2);
sub3 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 3);
sub4 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 4);
sub5 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 5);
group = Group(subject_class, {sub1, sub2, sub3 sub4, sub5});

measures = {'Assortativity', 'Degree', 'Distance'};
type_of_measure = {'global', 'nodal', 'binodal'};

%% Test 1: Instantiation
measurement = MeasurementfMRI('m1', atlas, group, 'MeasurementfMRI.measure_code', 'Degree');

%% Test 2: Correct size defaults
for i=1:1:numel(measures)
    measurement = MeasurementfMRI('m1', atlas, group, 'MeasurementfMRI.measure_code', measures{i});
    
    assert(~isempty(measurement), ...
        ['BRAPH:MeasurementfMRI'], ...
        ['MeasurementfMRI does not initialize correctly with: ' type_of_measure{i} ' measures.']) %#ok<*NBRAK>
    
    value = measurement.getMeasureValues();
    mean_value = measurement.getGroupAverageValue();
    
    if Measure.is_global(measures{i})
        assert(isequal([1 1], size(value{1})), ...
            ['BRAPH:MeasurementfMRI'], ...
            ['MeasurementfMRI does not initialize correctly with: ' type_of_measure{i} ' measures.']) %#ok<*NBRAK>
        assert(isequal([1 1], size(mean_value{1}))  && isequal(1, numel(mean_value)), ...
            ['BRAPH:MeasurementfMRI'], ...
            ['MeasurementfMRI does not initialize correctly with: ' type_of_measure{i} ' measures.']) %#ok<*NBRAK>
    elseif Measure.is_nodal(measures{i})
        assert(isequal([5 1], size(value{1})), ...
            ['BRAPH:MeasurementfMRI'], ...
            ['MeasurementfMRI does not initialize correctly with: ' type_of_measure{i} ' measures.']) %#ok<*NBRAK>
         assert(isequal([5 1], size(mean_value{1})) && isequal(1, numel(mean_value)), ...
            ['BRAPH:MeasurementfMRI'], ...
            ['MeasurementfMRI does not initialize correctly with: ' type_of_measure{i} ' measures.']) %#ok<*NBRAK>
    else
        assert(isequal([5 5], size(value{1})), ...
            ['BRAPH:MeasurementfMRI'], ...
            ['MeasurementfMRI does not initialize correctly with: ' type_of_measure{i} ' measures.']) %#ok<*NBRAK>
        assert(isequal([5 5], size(mean_value{1})) && isequal(1, numel(mean_value)), ...
            ['BRAPH:MeasurementfMRI'], ...
            ['MeasurementfMRI does not initialize correctly with: ' type_of_measure{i} ' measures.']) %#ok<*NBRAK>
    end
end