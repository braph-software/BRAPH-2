% test Measurement
br1 = BrainRegion('BR1', 'brain region 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 5, 55, 555);
atlas = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

measurement_class_list =  Measurement.getList();
subject_class_list = Subject.getList();
%% Test 1 Instantiation
for i = 1:1:length(measurement_class_list)
    for j = 1:1:length(subject_class_list)
        %arrange
        measurement_class = measurement_class_list{i};
        subject_class = subject_class_list{j};
        sub1 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 1);
        sub2 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 2);
        sub3 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 3);
        sub4 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 4);
        sub5 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 5);
        rule = [measurement_class '.measure_code'];
        
        group = Group(subject_class, {sub1, sub2, sub3 sub4, sub5});
        %act        
        measurement = Measurement.getMeasurement(measurement_class, 'm1', repmat({atlas}, Measurement.getBrainAtlasNumber(measurement_class), Subject.getBrainAtlasNumber(subject_class)), group, rule, 'Degree');
        %assert
        assert(~isempty(measurement), ...
            ['BRAPH:Measurement:Instantiation'], ...
            ['Measurement instantiation fail.']) %#ok<NBRAK>
    end
end

%% Test 2: Static Functions
for i = 1:1:length(measurement_class_list)
    for j = 1:1:length(subject_class_list)
        %arrange
        measurement_class = measurement_class_list{i};
        subject_class = subject_class_list{j};
        sub1 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 1);
        sub2 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 2);
        sub3 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 3);
        sub4 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 4);
        sub5 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 5);
        rule = [measurement_class '.measure_code'];
        
        group = Group(subject_class, {sub1, sub2, sub3});
        %act
        measurement = Measurement.getMeasurement(measurement_class, 'm1', repmat({atlas}, Measurement.getBrainAtlasNumber(measurement_class), Subject.getBrainAtlasNumber(subject_class)), group, rule, 'Degree');
        %assert
        assert(isequal(measurement.getClass(), measurement_class), ...
            ['BRAPH:Measurement:StaticFunctions'], ...
            ['Measurement getClass() fail.']) %#ok<NBRAK>
        assert(ischar(measurement.getName()), ...
            ['BRAPH:Measurement:StaticFunctions'], ...
            ['Measurement getName() fail.']) %#ok<NBRAK>
        assert(ischar(measurement.getDescription()), ...
            ['BRAPH:Measurement:StaticFunctions'], ...
            ['Measurement getDescription() fail.']) %#ok<NBRAK>
        assert(~isempty(measurement.getBrainAtlasNumber()), ...
            ['BRAPH:Measurement:StaticFunctions'], ...
            ['Measurement getAtlasesNumber() fail.']) %#ok<NBRAK>
        assert(~isempty(measurement.getGroupNumber()), ...
            ['BRAPH:Measurement:StaticFunctions'], ...
            ['Measurement getGroupsNumber() fail.']) %#ok<NBRAK>
    end
end

