% test MeasurementDTI

br1 = BrainRegion('BR1', 'brain region 1', 'notes 1', 1, 1.1, 1.11);
br2 = BrainRegion('BR2', 'brain region 2', 'notes 2', 2, 2.2, 2.22);
br3 = BrainRegion('BR3', 'brain region 3', 'notes 3', 3, 3.3, 3.33);
br4 = BrainRegion('BR4', 'brain region 4', 'notes 4', 4, 4.4, 4.44);
br5 = BrainRegion('BR5', 'brain region 5', 'notes 5', 5, 5.5, 5.55);
atlas = BrainAtlas('BA', 'brain atlas', 'notes', 'BrainMesh_ICBM152.nv', {br1, br2, br3, br4, br5});

subject_class = Measurement.getSubjectClass('MeasurementDTI');

sub1 = Subject.getSubject(subject_class, 'id1', 'label 1', 'notes 1', atlas);
sub2 = Subject.getSubject(subject_class, 'id2', 'label 2', 'notes 2', atlas);
sub3 = Subject.getSubject(subject_class, 'id3', 'label 3', 'notes 3', atlas);

group = Group(subject_class, 'id', 'label', 'notes', {sub1, sub2, sub3});

% TODO: get graph type from Analysis
graph_type = 'GraphWU';
measures = Graph.getCompatibleMeasureList(graph_type);

%% Test 1: Instantiation
for i = 1:1:numel(measures)
    measurement = MeasurementDTI('m1', 'label', 'notes', atlas, group, 'MeasurementDTI.MeasureCode', measures{i});
end

%% Test 2: Correct size defaults
for i = 1:1:numel(measures)
    measurement = MeasurementDTI('m1', 'label', 'notes', atlas, group, 'MeasurementDTI.MeasureCode', measures{i});
    
    values = measurement.getMeasureValues();
    average_value = measurement.getGroupAverageValue();
    
    if Measure.is_global(measures{i})
        assert(iscell(values) & ...
            isequal(numel(values), group.subjectnumber) & ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), values)), ...
            [BRAPH2.STR ':MeasurementDTI:' BRAPH2.BUG_FUNC], ...
            'MeasurementDTI does not initialize correctly with global measures')
        assert(isequal(numel(average_value), 1), ...
            [BRAPH2.STR ':MeasurementDTI:' BRAPH2.BUG_FUNC], ...
            'MeasurementDTI does not initialize correctly with global measures')
    elseif Measure.is_nodal(measures{i})
        assert(iscell(values) & ...
            isequal(numel(values), group.subjectnumber) & ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), values)), ...
            [BRAPH2.STR ':MeasurementDTI:' BRAPH2.BUG_FUNC], ...
            'MeasurementDTI does not initialize correctly with nodal measures')
        assert(isequal(size(average_value), [atlas.getBrainRegions().length(), 1]), ...
            [BRAPH2.STR ':MeasurementDTI:' BRAPH2.BUG_FUNC], ...
            'MeasurementDTI does not initialize correctly with nodal measures') 
    elseif Measure.is_binodal(measures{i})
        assert(iscell(values) & ...
            isequal(numel(values), group.subjectnumber) & ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), values)), ...
            [BRAPH2.STR ':MeasurementDTI:' BRAPH2.BUG_FUNC], ...
            'MeasurementDTI does not initialize correctly with binodal measures')
        assert(isequal(size(average_value), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), ...
            [BRAPH2.STR ':MeasurementDTI:' BRAPH2.BUG_FUNC], ...
            'MeasurementDTI does not initialize correctly with binodal measures')
    end
end

%% Test 3: Initialize with values
for i = 1:1:numel(measures)
    % setup
    for j = 1:1:group.subjectnumber()
        A = rand(atlas.getBrainRegions().length());
        g = Graph.getGraph('GraphWU', A);
        m  = Measure.getMeasure(measures{i}, g);
        values{j} =  cell2mat(m.getValue());
    end
    average_value = mean(reshape(cell2mat(values), [size(values{1}, 1), size(values{1}, 2), group.subjectnumber()]), 3);
    
    % act
    measurement = MeasurementDTI('m1', 'label', 'notes', atlas, group, 'MeasurementDTI.MeasureCode', measures{i}, ...
        'MeasurementDTI.values', values, ...
        'MeasurementDTI.average_value', average_value ...
        );
    
    % assert
    if Measure.is_global(measures{i})
        assert(iscell(measurement.getMeasureValues()) & ...
            isequal(numel(measurement.getMeasureValues()), group.subjectnumber) & ...
            all(cellfun(@(x) isequal(size(x), [1, 1]), measurement.getMeasureValues()) ...
            & isequal(size(measurement.getMeasureValues()), size(values))), ...
            [BRAPH2.STR ':MeasurementDTI:' BRAPH2.BUG_FUNC], ...
            'MeasurementDTI does not initialize correctly with global measures')
        assert(isequal(size(measurement.getGroupAverageValue()), [1 1]), ...
            [BRAPH2.STR ':MeasurementDTI:' BRAPH2.BUG_FUNC], ...
            'MeasurementDTI does not initialize correctly with global measures') 
    elseif Measure.is_nodal(measures{i})
        assert(iscell(measurement.getMeasureValues()) & ...
            isequal(numel(measurement.getMeasureValues()), group.subjectnumber) & ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), measurement.getMeasureValues()) ...
            & isequal(size(measurement.getMeasureValues()), size(values))), ...
            [BRAPH2.STR ':MeasurementDTI:' BRAPH2.BUG_FUNC], ...
            'MeasurementDTI does not initialize correctly with nodal measures') 
        assert(isequal(size(measurement.getGroupAverageValue()), [atlas.getBrainRegions().length(), 1]), ...
            [BRAPH2.STR ':MeasurementDTI:' BRAPH2.BUG_FUNC], ...
            'MeasurementDTI does not initialize correctly with nodal measures') 
    elseif Measure.is_binodal(measures{i})
        assert(iscell(measurement.getMeasureValues()) & ...
            isequal(numel(measurement.getMeasureValues()), group.subjectnumber) & ...
            all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), measurement.getMeasureValues()) ...
            & isequal(size(measurement.getMeasureValues()), size(values))), ...
            [BRAPH2.STR ':MeasurementDTI:' BRAPH2.BUG_FUNC], ...
            'MeasurementDTI does not initialize correctly with binodal measures')
        assert(isequal(size(measurement.getGroupAverageValue()), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), ...
            [BRAPH2.STR ':MeasurementDTI:' BRAPH2.BUG_FUNC], ...
            'MeasurementDTI does not initialize correctly with binodal measures')
    end
end