% test Measurement
br1 = BrainRegion('BR1', 'brain region 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 5, 55, 555);
atlas = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

measurement_class_list =  Measurement.getList();

%% Test 1 Instantiation
for i = 1:1:length(measurement_class_list)
    % setup
    measurement_class = measurement_class_list{i};
    subject_class = Measurement.getSubjectClass(measurement_class);
    
    sub1 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 1);
    sub2 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 2);
    sub3 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 3);

    group = Group(subject_class, {sub1, sub2, sub3});

    % act
    measurement = Measurement.getMeasurement(measurement_class, ...
        'm1', ...
        repmat({atlas}, 1, Measurement.getBrainAtlasNumber(measurement_class)), ...
        group, ...
        'setting name', 'setting value');

    % assert
    assert(~isempty(measurement), ...
        ['BRAPH' measurement_class 'Instantiation'], ...
        [measurement_class ' instantiation fail.'])
end

%% Test 2: Static Functions
for i = 1:1:length(measurement_class_list)
    % setup
    measurement_class = measurement_class_list{i};
    subject_class = Measurement.getSubjectClass(measurement_class);

    sub1 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 1);
    sub2 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 2);
    sub3 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 3);

    group = Group(subject_class, {sub1, sub2, sub3});

    % act
    measurement = Measurement.getMeasurement(measurement_class, 'm1', ...
        repmat({atlas}, 1, Measurement.getBrainAtlasNumber(measurement_class)), ...
        group, ...
        'setting name', 'setting value');

    % assert
    assert(isequal(measurement.getClass(), measurement_class), ...
        ['BRAPH' measurement_class 'StaticFunctions'], ...
        [measurement_class '.getClass() fail.'])
    assert(ischar(measurement.getName()), ...
        ['BRAPH' measurement_class 'StaticFunctions'], ...
        [measurement_class '.getName() fail.'])
    assert(ischar(measurement.getDescription()), ...
        ['BRAPH' measurement_class 'StaticFunctions'], ...
        [measurement_class '.getDescription() fail.'])
    assert(isequal(measurement.getBrainAtlasNumber(), Subject.getBrainAtlasNumber(subject_class)), ...
        ['BRAPH' measurement_class 'StaticFunctions'], ...
        [measurement_class '.getAtlasNumber() fail.'])
    assert(ischar(measurement.getAnalysisClass()), ...
        ['BRAPH' measurement_class 'StaticFunctions'], ...
        [measurement_class '.getAnalysisClass() fail.'])
    assert(ischar(measurement.getSubjectClass()), ...
        ['BRAPH' measurement_class 'StaticFunctions'], ...
        [measurement_class '.getSubjectClass() fail.'])
end