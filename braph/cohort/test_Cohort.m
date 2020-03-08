% test Cohort
br1 = BrainRegion('BR1', 'brain region 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 5, 55, 555);
atlas = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

sub_class_list = Subject.getList();

%% Test 1: Instantiation Empty
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    cohort = Cohort('cohort', sub_class, atlases, {});
end

%% Test 2: Instantiation with Subjects
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));

    sub1 = Subject.getSubject(sub_class, atlases);
    sub2 = Subject.getSubject(sub_class, atlases);
    sub3 = Subject.getSubject(sub_class, atlases);
    
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
end

%% Test 3: Basic functionalities
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));

    sub1 = Subject.getSubject(sub_class, atlases, 'SubjectID', '1');
    sub2 = Subject.getSubject(sub_class, atlases, 'SubjectID', '2');
    sub3 = Subject.getSubject(sub_class, atlases, 'SubjectID', '3');

    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});

    assert(cohort.subjectnumber()==3, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.subjectnumber does not work')
    assert(cohort.contains_subject(1), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.contains_subject does not work')
    assert(~cohort.contains_subject(4), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.contains_subject does not work')
    assert(isequal(cohort.getSubject(2).getID(), '2'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.getSubject does not work')
end

%% Test 3: Add
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));

    sub1 = Subject.getSubject(sub_class, atlases, 'SubjectID', '1');
    sub2 = Subject.getSubject(sub_class, atlases, 'SubjectID', '2');
    sub3 = Subject.getSubject(sub_class, atlases, 'SubjectID', '3');
    sub4 = Subject.getSubject(sub_class, atlases, 'SubjectID', '4');
    sub5 = Subject.getSubject(sub_class, atlases, 'SubjectID', '5');
    sub6 = Subject.getSubject(sub_class, atlases, 'SubjectID', '6');

    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub4, sub5});
   
    cohort.addSubject(sub3, 3)

    assert(cohort.subjectnumber()==5, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.addSubject does not work')
    assert(isequal(cohort.getSubject(3).getID(), '3'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.addSubject does not work')

    cohort.addSubject(sub6)

    assert(cohort.subjectnumber()==6, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.addSubject does not work')
    assert(isequal(cohort.getSubject(6).getID(), '6'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.addSubject does not work')
end

%% Test 4: Remove
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};

    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));

    sub1 = Subject.getSubject(sub_class, atlases, 'SubjectID', '1');
    sub2 = Subject.getSubject(sub_class, atlases, 'SubjectID', '2');
    sub3 = Subject.getSubject(sub_class, atlases, 'SubjectID', '3');
    sub4 = Subject.getSubject(sub_class, atlases, 'SubjectID', '4');
    sub5 = Subject.getSubject(sub_class, atlases, 'SubjectID', '5');
    sub6 = Subject.getSubject(sub_class, atlases, 'SubjectID', '6');
    
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});
    
    cohort.removeSubject(3)

    assert(cohort.subjectnumber()==4, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubject does not work')
    assert(isequal(cohort.getSubject(2).getID(), '2'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubject does not work')
    assert(isequal(cohort.getSubject(3).getID(), '4'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubject does not work')

    cohort.removeSubject(1)

    assert(cohort.subjectnumber()==3, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubject does not work')
    assert(isequal(cohort.getSubject(1).getID(), '2'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubject does not work')
end

%% Test 5: Replace
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};

    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));

    sub1 = Subject.getSubject(sub_class, atlases, 'SubjectID', '1');
    sub2 = Subject.getSubject(sub_class, atlases, 'SubjectID', '2');
    sub3 = Subject.getSubject(sub_class, atlases, 'SubjectID', '3');
    sub4 = Subject.getSubject(sub_class, atlases, 'SubjectID', '4');
    sub5 = Subject.getSubject(sub_class, atlases, 'SubjectID', '5');
    sub6 = Subject.getSubject(sub_class, atlases, 'SubjectID', '6');
    
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});
 
    cohort.replaceSubject(3, sub6)

    assert(cohort.subjectnumber()==5, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.replaceSubject does not work')
    assert(isequal(cohort.getSubject(3).getID(), '6'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.replaceSubject does not work')
end

%% Test 6: Invert
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};

    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));

    sub1 = Subject.getSubject(sub_class, atlases, 'SubjectID', '1');
    sub2 = Subject.getSubject(sub_class, atlases, 'SubjectID', '2');
    sub3 = Subject.getSubject(sub_class, atlases, 'SubjectID', '3');
    sub4 = Subject.getSubject(sub_class, atlases, 'SubjectID', '4');
    sub5 = Subject.getSubject(sub_class, atlases, 'SubjectID', '5');
    sub6 = Subject.getSubject(sub_class, atlases, 'SubjectID', '6');
    
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});
 
    cohort.invertSubjects(2, 4)

    assert(cohort.subjectnumber()==5, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.invertSubjects does not work')
    assert(isequal(cohort.getSubject(2).getID(), '4'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.invertSubjects does not work')
    assert(isequal(cohort.getSubject(4).getID(), '2'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.invertSubjects does not work')
end

%% Test 7: MoveTo
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));

    sub1 = Subject.getSubject(sub_class, atlases, 'SubjectID', '1');
    sub2 = Subject.getSubject(sub_class, atlases, 'SubjectID', '2');
    sub3 = Subject.getSubject(sub_class, atlases, 'SubjectID', '3');
    sub4 = Subject.getSubject(sub_class, atlases, 'SubjectID', '4');
    sub5 = Subject.getSubject(sub_class, atlases, 'SubjectID', '5');

    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});
 
    cohort.movetoSubject(4, 2)

    assert(cohort.subjectnumber()==5, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.movetoSubject does not work')
    assert(isequal(cohort.getSubject(2).getID(), '4'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.movetoSubject does not work')

    cohort.movetoSubject(1, 5)

    assert(cohort.subjectnumber()==5, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.movetoSubject does not work')
    assert(isequal(cohort.getSubject(5).getID(), '1'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.movetoSubject does not work')
end

%% Test 8: Remove All
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));

    sub1 = Subject.getSubject(sub_class, atlases, 'SubjectID', '1');
    sub2 = Subject.getSubject(sub_class, atlases, 'SubjectID', '2');
    sub3 = Subject.getSubject(sub_class, atlases, 'SubjectID', '3');
    sub4 = Subject.getSubject(sub_class, atlases, 'SubjectID', '4');
    sub5 = Subject.getSubject(sub_class, atlases, 'SubjectID', '5');

    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});

    selected = cohort.removeSubjects([2, 4]);

    assert(cohort.subjectnumber()==3, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubjects does not work')
    assert(isequal(cohort.getSubject(3).getID(), '5'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubjects does not work')
    assert(isempty(selected), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubjects does not work')
end

%% Test 9: Add Above
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));

    sub1 = Subject.getSubject(sub_class, atlases, 'SubjectID', '1');
    sub2 = Subject.getSubject(sub_class, atlases, 'SubjectID', '2');
    sub3 = Subject.getSubject(sub_class, atlases, 'SubjectID', '3');
    sub4 = Subject.getSubject(sub_class, atlases, 'SubjectID', '4');
    sub5 = Subject.getSubject(sub_class, atlases, 'SubjectID', '5');

    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});

    [selected, added] = cohort.addaboveSubjects([1 3 5]);

    assert(cohort.subjectnumber()==8, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.addaboveSubjects does not work')
    for i = [1 4 7] %#ok<FXSET>
        assert(isa(cohort.getSubject(i), sub_class), ...
            'BRAPH:Cohort:Bug', ...
            'Cohort.addaboveSubjects does not work')
    end
    assert(isequal(selected, [2 5 8]), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.addaboveSubjects does not work')
    assert(isequal(added, [1 4 7]), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.addaboveSubjects does not work')
end

%% Test 10: Add Below
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));

    sub1 = Subject.getSubject(sub_class, atlases, 'SubjectID', '1');
    sub2 = Subject.getSubject(sub_class, atlases, 'SubjectID', '2');
    sub3 = Subject.getSubject(sub_class, atlases, 'SubjectID', '3');
    sub4 = Subject.getSubject(sub_class, atlases, 'SubjectID', '4');
    sub5 = Subject.getSubject(sub_class, atlases, 'SubjectID', '5');

    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});

    [selected, added] = cohort.addbelowSubjects([1 3 5]);

    assert(cohort.subjectnumber()==8, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.addbelowSubjects does not work')
    for i = [2 5 8] %#ok<FXSET>
        assert(isa(cohort.getSubject(i), sub_class), ...
            'BRAPH:Cohort:Bug', ...
            'Cohort.addbelowSubjects does not work')
    end
    assert(isequal(selected, [1 4 7]), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.addbelowSubjects does not work')
    assert(isequal(added, [2 5 8]), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.addbelowSubjects does not work')
end

%% Test 10: Move Up
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));

    sub1 = Subject.getSubject(sub_class, atlases, 'SubjectID', '1');
    sub2 = Subject.getSubject(sub_class, atlases, 'SubjectID', '2');
    sub3 = Subject.getSubject(sub_class, atlases, 'SubjectID', '3');
    sub4 = Subject.getSubject(sub_class, atlases, 'SubjectID', '4');
    sub5 = Subject.getSubject(sub_class, atlases, 'SubjectID', '5');

    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});

    selected = cohort.moveupSubjects([1 3 5]);

    assert(cohort.subjectnumber()==5, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.moveupSubjects does not work')
    assert(isequal(selected, [1 2 4]), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.moveupSubjects does not work')
end

%% Test 11: Move Down
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));

    sub1 = Subject.getSubject(sub_class, atlases, 'SubjectID', '1');
    sub2 = Subject.getSubject(sub_class, atlases, 'SubjectID', '2');
    sub3 = Subject.getSubject(sub_class, atlases, 'SubjectID', '3');
    sub4 = Subject.getSubject(sub_class, atlases, 'SubjectID', '4');
    sub5 = Subject.getSubject(sub_class, atlases, 'SubjectID', '5');

    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});

    selected = cohort.movedownSubjects([1 3 5]);

    assert(cohort.subjectnumber()==5, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.movedownSubjects does not work')
    assert(isequal(selected, [2 4 5]), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.movedownSubjects does not work')
end

%% Test 12: Move to Top
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));

    sub1 = Subject.getSubject(sub_class, atlases, 'SubjectID', '1');
    sub2 = Subject.getSubject(sub_class, atlases, 'SubjectID', '2');
    sub3 = Subject.getSubject(sub_class, atlases, 'SubjectID', '3');
    sub4 = Subject.getSubject(sub_class, atlases, 'SubjectID', '4');
    sub5 = Subject.getSubject(sub_class, atlases, 'SubjectID', '5');

    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});

    selected = cohort.move2topSubjects([1 3 5]);

    assert(cohort.subjectnumber()==5, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.move2topSubjects does not work')
    assert(isequal(selected, [1 2 3]), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.move2topSubjects does not work')
end

%% Test 12: Move to Bottom
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));

    sub1 = Subject.getSubject(sub_class, atlases, 'SubjectID', '1');
    sub2 = Subject.getSubject(sub_class, atlases, 'SubjectID', '2');
    sub3 = Subject.getSubject(sub_class, atlases, 'SubjectID', '3');
    sub4 = Subject.getSubject(sub_class, atlases, 'SubjectID', '4');
    sub5 = Subject.getSubject(sub_class, atlases, 'SubjectID', '5');

    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});

    selected = cohort.move2bottomSubjects([1 3 5]);

    assert(cohort.subjectnumber()==5, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.move2bottomSubjects does not work')
    assert(isequal(selected, [3 4 5]), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.move2bottomSubjects does not work')
end

%% Test 13: Copy
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));

    sub1 = Subject.getSubject(sub_class, atlases, 'SubjectID', '1');
    sub2 = Subject.getSubject(sub_class, atlases, 'SubjectID', '2');
    sub3 = Subject.getSubject(sub_class, atlases, 'SubjectID', '3');
    sub4 = Subject.getSubject(sub_class, atlases, 'SubjectID', '4');
    sub5 = Subject.getSubject(sub_class, atlases, 'SubjectID', '5');

    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});

    cohort_copy = cohort.copy();
    
    assert(cohort ~= cohort_copy, ... % different objects
        ['BRAPH:Cohort:Copy'], ...
        ['Cohort.copy() does not work']) %#ok<NBRAK>
    
    atlases = cohort.getBrainAtlases();
    atlases_copy = cohort_copy.getBrainAtlases();
    for j = 1:1:length(atlases)
        assert(atlases{j} ~= atlases_copy{j}, ... % different objects
            ['BRAPH:Cohort:Copy'], ...
            ['Cohort.copy() does not work']) %#ok<NBRAK>
    end
    
    for j = 1:1:cohort.subjectnumber()
        sub = cohort.getSubject(j);
        sub_copy = cohort_copy.getSubject(j);
        assert(sub ~= sub_copy, ... % different objects
            ['BRAPH:Cohort:Copy'], ...
            ['Cohort.copy() does not work']) %#ok<NBRAK>
        
        data_codes = sub.getDataCodes();
        for k = 1:1:length(data_codes)
            data_code = data_codes{k};
            assert(sub.getData(data_code) ~= sub_copy.getData(data_code), ... % different objects
                ['BRAPH:Cohort:Copy'], ...
                ['Cohort.copy() does not work']) %#ok<NBRAK>
            assert(sub.getData(data_code).getBrainAtlas() ~= sub_copy.getData(data_code).getBrainAtlas(), ... % different objects
                ['BRAPH:Cohort:Copy'], ...
                ['Cohort.copy() does not work']) %#ok<NBRAK>
        end
    end
end

%% Test 14: Groups
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));

    sub1 = Subject.getSubject(sub_class, atlases, 'SubjectID', '1');
    sub2 = Subject.getSubject(sub_class, atlases, 'SubjectID', '2');
    sub3 = Subject.getSubject(sub_class, atlases, 'SubjectID', '3');
    sub4 = Subject.getSubject(sub_class, atlases, 'SubjectID', '4');
    sub5 = Subject.getSubject(sub_class, atlases, 'SubjectID', '5');

    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});

    assert(cohort.groupnumber() == 0, ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>
    
    cohort.addGroup()
    assert(cohort.groupnumber() == 1, ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>
    
    group2 = Group(cohort.getSubjectClass(), {}, 'GroupName', 'Group 2', 'GroupDescription', 'Group 2 Description');
    assert(~cohort.contains_group(group2), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    
    assert(~cohort.contains_group(2), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    

    cohort.addGroup(group2)
    assert(cohort.contains_group(group2), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    
    assert(cohort.contains_group(2), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    
    assert(cohort.groupnumber() == 2, ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>
    assert(cohort.getGroup(2) == group2, ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>
    
    cohort.removeGroup(1)
    assert(cohort.groupnumber() == 1, ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>
    
    group1 = Group(cohort.getSubjectClass(), {}, 'GroupName', 'Group 1', 'GroupDescription', 'Group 1 Description');
    cohort.addGroup(group1, 1)
    assert(cohort.groupnumber() == 2, ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>
    assert(cohort.contains_group(group1), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    
    assert(cohort.contains_group(1), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    
    assert(isequal(cohort.getGroup(1).getName(), 'Group 1'), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>
    
    cohort.addSubjectToGroup(1, 1)
    cohort.addSubjectToGroup(2, 2)
    cohort.addSubjectToGroup(3, 2)
    assert(isequal(cohort.getGroupSubjects(1), [1]), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    
    assert(isequal(cohort.getGroupSubjects(2), [2 3]), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    
end