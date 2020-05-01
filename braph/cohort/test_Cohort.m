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

    assert(cohort.getSubjects().length()==3, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.subjectnumber does not work')
    assert(cohort.getSubjects().contains(1), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.contains_subject does not work')
    assert(~cohort.getSubjects().contains(4), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.contains_subject does not work')
    assert(isequal(cohort.getSubjects().getValue(2).getID(), '2'), ...
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
   
    cohort.getSubjects().add(num2str(sub3.getID()),sub3, 3);

    assert(cohort.getSubjects().length()==5, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.addSubject does not work')
    assert(isequal(cohort.getSubjects().getValue(3).getID(), '3'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.addSubject does not work')

    cohort.getSubjects().add(num2str(sub6.getID()), sub6);

    assert(cohort.getSubjects().length()==6, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.addSubject does not work')
    assert(isequal(cohort.getSubjects().getValue(6).getID(), '6'), ...
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
    
    cohort.getSubjects().remove(3);

    assert(cohort.getSubjects().length()==4, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubject does not work')
    assert(isequal(cohort.getSubjects().getValue(2).getID(), '2'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubject does not work')
    assert(isequal(cohort.getSubjects().getValue(3).getID(), '4'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubject does not work')

    cohort.getSubjects().remove(1);

    assert(cohort.getSubjects().length()==3, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubject does not work')
    assert(isequal(cohort.getSubjects().getValue(1).getID(), '2'), ...
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
 
    cohort.getSubjects().replace(sub6.getID(), sub6, 3);

    assert(cohort.getSubjects().length()==5, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.replaceSubject does not work')
    assert(isequal(cohort.getSubjects().getValue(3).getID(), '6'), ...
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
 
    cohort.getSubjects().invert(2, 4);

    assert(cohort.getSubjects().length()==5, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.invertSubjects does not work')
    assert(isequal(cohort.getSubjects().getValue(2).getID(), '4'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.invertSubjects does not work')
    assert(isequal(cohort.getSubjects().getValue(4).getID(), '2'), ...
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
 
    cohort.getSubjects().move_to(4, 2);

    assert(cohort.getSubjects().length()==5, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.movetoSubject does not work')
    assert(isequal(cohort.getSubjects().getValue(2).getID(), '4'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.movetoSubject does not work')

    cohort.getSubjects().move_to(1, 5);

    assert(cohort.getSubjects().length()==5, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.movetoSubject does not work')
    assert(isequal(cohort.getSubjects().getValue(5).getID(), '1'), ...
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

    selected = cohort.getSubjects().remove_all([2, 4]);

    assert(cohort.getSubjects().length()==3, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubjects does not work')
    assert(isequal(cohort.getSubjects().getValue(3).getID(), '5'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubjects does not work')
    assert(isempty(selected), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubjects does not work')
end

%% Test 9: Move Up
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));

    sub1 = Subject.getSubject(sub_class, atlases, 'SubjectID', '1');
    sub2 = Subject.getSubject(sub_class, atlases, 'SubjectID', '2');
    sub3 = Subject.getSubject(sub_class, atlases, 'SubjectID', '3');
    sub4 = Subject.getSubject(sub_class, atlases, 'SubjectID', '4');
    sub5 = Subject.getSubject(sub_class, atlases, 'SubjectID', '5');

    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});

    selected = cohort.getSubjects().move_up([1 3 5]);

    assert(cohort.getSubjects().length()==5, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.moveupSubjects does not work')
    assert(isequal(selected, [1 2 4]), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.moveupSubjects does not work')
end

%% Test 10: Move Down
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));

    sub1 = Subject.getSubject(sub_class, atlases, 'SubjectID', '1');
    sub2 = Subject.getSubject(sub_class, atlases, 'SubjectID', '2');
    sub3 = Subject.getSubject(sub_class, atlases, 'SubjectID', '3');
    sub4 = Subject.getSubject(sub_class, atlases, 'SubjectID', '4');
    sub5 = Subject.getSubject(sub_class, atlases, 'SubjectID', '5');

    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});

    selected = cohort.getSubjects().move_down([1 3 5]);

    assert(cohort.getSubjects().length()==5, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.movedownSubjects does not work')
    assert(isequal(selected, [2 4 5]), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.movedownSubjects does not work')
end

%% Test 11: Move to Top
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));

    sub1 = Subject.getSubject(sub_class, atlases, 'SubjectID', '1');
    sub2 = Subject.getSubject(sub_class, atlases, 'SubjectID', '2');
    sub3 = Subject.getSubject(sub_class, atlases, 'SubjectID', '3');
    sub4 = Subject.getSubject(sub_class, atlases, 'SubjectID', '4');
    sub5 = Subject.getSubject(sub_class, atlases, 'SubjectID', '5');

    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});

    selected = cohort.getSubjects().move_to_top([1 3 5]);

    assert(cohort.getSubjects().length()==5, ...
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

    selected = cohort.getSubjects().move_to_bottom([1 3 5]);

    assert(cohort.getSubjects().length()==5, ...
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
    group1 = Group(sub_class, {}, 'GroupName', 'Group 1', 'GroupDescription', 'Group 1 Description');
    group2 = Group(sub_class, {}, 'GroupName', 'Group 2', 'GroupDescription', 'Group 2 Description');    
    group1.addSubject(sub1);
    group2.addSubject(sub4);

    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});
    cohort.getGroups().add(group1.getName(), group1);
    cohort.getGroups().add(group2.getName(), group2);

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
    
    for j = 1:1:cohort.getSubjects().length()
        sub = cohort.getSubjects().getValue(j);
        sub_copy = cohort_copy.getSubjects().getValue(j);
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
    

    for k = 1:1:cohort.getGroups().length()
        group = cohort.getGroups().getValue(k);
        group_copy = cohort_copy.getGroups().getValue(k);
        assert(group ~= group_copy, ... % different objects
            ['BRAPH:Cohort:Copy'], ...
            ['Cohort.copy() does not work']) %#ok<NBRAK>
        
        subs = group.getSubjects();
        subs_copy = group_copy.getSubjects();
        assert(subs{1} ~= subs_copy{1}, ... % different objects
            ['BRAPH:Cohort:Copy'], ...
            ['Cohort.copy() does not work']) %#ok<NBRAK>        
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

    assert(cohort.getGroups().length() == 0, ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>
    
    group1 = Group(cohort.getSubjectClass(), {}, 'GroupName', 'Group 1', 'GroupDescription', 'Group 1 Description');
    cohort.getGroups().add(group1.getName(), group1);
    assert(cohort.getGroups().length() == 1, ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>
    
    group2 = Group(cohort.getSubjectClass(), {}, 'GroupName', 'Group 2', 'GroupDescription', 'Group 2 Description');
    assert(~cohort.getGroups().contains(group2), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    
    assert(~cohort.getGroups().contains(2), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    

    cohort.getGroups().add(group2.getName(), group2)
    assert(cohort.getGroups().contains(group2), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    
    assert(cohort.getGroups().contains(2), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    
    assert(cohort.getGroups().length() == 2, ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>
    assert(cohort.getGroups().getValue(2) == group2, ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>
    
    cohort.getGroups().remove(1)
    assert(cohort.getGroups().length() == 1, ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>
    
    group1 = Group(cohort.getSubjectClass(), {}, 'GroupName', 'Group 1', 'GroupDescription', 'Group 1 Description');
    cohort.getGroups().add(group1.getName(), group1, 1)
    assert(cohort.getGroups().length() == 2, ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>
    assert(cohort.getGroups().contains(group1), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    
    assert(cohort.getGroups().contains(1), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    
    assert(isequal(cohort.getGroups().getValue(1).getName(), 'Group 1'), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>
    
    cohort.addSubjectToGroup(1, 1)
    cohort.addSubjectToGroup(2, 2)
    cohort.addSubjectToGroup(3, 2)
    assert(isequal(cohort.getGroups().getValue(1).getSubjects(), {sub1}), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    
    assert(isequal(cohort.getGroups().getValue(2).getSubjects(), {sub2 sub3}), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    

    cohort.addSubjectsToGroup([2 3 4 5], 1)
    cohort.addSubjectsToGroup([1 4 5], 2)
    assert(isequal(cohort.getGroupSubjects(1), [1 2 3 4 5]), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    
    assert(isequal(cohort.getGroupSubjects(2), [2 3 1 4 5]), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    

    cohort.removeSubjectsFromGroup(1, 1)
    cohort.removeSubjectsFromGroup([2 3], 2)
    assert(isequal(cohort.getGroupSubjects(1), [2 3 4 5]), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    
    assert(isequal(cohort.getGroupSubjects(2), [1 4 5]), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>
    
    copy_cohort = cohort.copy();
    copy_cohort.addSubjectsToGroup(1, 1)
    copied_subjects = copy_cohort.getGroups().getValue(2).getSubjects();
    copy_cohort.removeSubjectsFromGroup(copied_subjects{1}, 2)
    assert(isequal(cohort.getGroupSubjects(1), [2 3 4 5]), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    
    assert(isequal(cohort.getGroupSubjects(2), [1 4 5]), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>
    assert(isequal(copy_cohort.getGroupSubjects(1), [2 3 4 5 1]), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    
    assert(isequal(copy_cohort.getGroupSubjects(2), [4 5]), ...
        ['BRAPH:Cohort:Groups'], ...
        ['The management of groups does not work']) %#ok<NBRAK>    
end

%% Test 15: Cohort getNewSubject
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));

    cohort = Cohort('cohort', sub_class, atlases, {});
    
    new_subject = cohort.getNewSubject({}); 
    assert(isa(new_subject, sub_class), ... 
        ['BRAPH:Cohort:getNewSubject'], ...
        ['Cohort.getNewSubject() does not work'])  %#ok<NBRAK>
end