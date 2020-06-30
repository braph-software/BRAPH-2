% test Group

subject_class_list = Subject.getList();

br1 = BrainRegion('BR1', 'brain region 1', 'notes 1', 1, 1.1, 1.11);
br2 = BrainRegion('BR2', 'brain region 2', 'notes 2', 2, 2.2, 2.22);
br3 = BrainRegion('BR3', 'brain region 3', 'notes 3', 3, 3.3, 3.33);
br4 = BrainRegion('BR4', 'brain region 4', 'notes 4', 4, 4.4, 4.44);
br5 = BrainRegion('BR5', 'brain region 5', 'notes 5', 5, 5.5, 5.55);
atlas = BrainAtlas('BA', 'brain atlas', 'notes', 'BrainMesh_ICBM152.nv', {br1, br2, br3, br4, br5});

%% Test 1: Instantiation
for i = 1:1:length(subject_class_list)
    subject_class = subject_class_list{i};

    sub1 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', '1');
    sub2 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', '2');
    sub3 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', '3');
    sub4 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', '4');
    sub5 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', '5');
    
    group = Group(subject_class, {sub1, sub2, sub3 sub4, sub5});
end

%% Test 2: Basic functions
for i = 1:1:length(subject_class_list)
    subject_class = subject_class_list{i};

    sub1 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', '1');
    sub2 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', '2');
    sub3 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', '3');
    sub4 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', '4');
    sub5 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', '5');
    
    group = Group(subject_class, {sub1, sub2, sub3});
    assert(group.subjectnumber() == 3, ...
            ['BRAPH:Group:BasicError'], ...
            ['One of the basic functions of Group does not work']) %#ok<NBRAK>
    assert(isequal(group.getSubjects(), {sub1, sub2, sub3}), ...
            ['BRAPH:Group:BasicError'], ...
            ['One of the basic functions of Group does not work']) %#ok<NBRAK>
        
    group.addSubjects({sub3, sub4, sub5})
    assert(group.subjectnumber() == 5, ...
            ['BRAPH:Group:BasicError'], ...
            ['One of the basic functions of Group does not work']) %#ok<NBRAK>
    assert(isequal(group.getSubjects(), {sub1, sub2, sub3, sub4, sub5}), ...
            ['BRAPH:Group:BasicError'], ...
            ['One of the basic functions of Group does not work']) %#ok<NBRAK>
	
    group.removeSubjects({sub1, sub3})
    assert(group.subjectnumber() == 3, ...
            ['BRAPH:Group:BasicError'], ...
            ['One of the basic functions of Group does not work']) %#ok<NBRAK>
    assert(isequal(group.getSubjects(), {sub2, sub4, sub5}), ...
            ['BRAPH:Group:BasicError'], ...
            ['One of the basic functions of Group does not work']) %#ok<NBRAK>
	
end