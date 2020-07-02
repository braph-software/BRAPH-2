% test Cohort

br1 = BrainRegion('BR1', 'brain region 1', 'notes 1', 1, 1.1, 1.11);
br2 = BrainRegion('BR2', 'brain region 2', 'notes 2', 2, 2.2, 2.22);
br3 = BrainRegion('BR3', 'brain region 3', 'notes 3', 3, 3.3, 3.33);
br4 = BrainRegion('BR4', 'brain region 4', 'notes 4', 4, 4.4, 4.44);
br5 = BrainRegion('BR5', 'brain region 5', 'notes 5', 5, 5.5, 5.55);
atlas = BrainAtlas('BA', 'brain atlas', 'notes', 'BrainMesh_ICBM152.nv', {br1, br2, br3, br4, br5});

sub_class_list = Subject.getList();

%% Test 1: Instantiation Empty
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', sub_class, atlases, {});
end

%% Test 2: Instantiation with Subjects
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    
    sub1 = Subject.getSubject(sub_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(sub_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(sub_class, 'id3', 'label 3', 'notes 3', atlases);
    
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', sub_class, atlases, {sub1, sub2, sub3});
end

%% Test 3: Basic functionalities
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    
    sub1 = Subject.getSubject(sub_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(sub_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(sub_class, 'id3', 'label 3', 'notes 3', atlases);
    
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', sub_class, atlases, {sub1, sub2, sub3});
    
    assert(cohort.getSubjects().length() == 3, ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.subjectnumber does not work')
    assert(cohort.getSubjects().contains(1), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.contains_subject does not work')
    assert(~cohort.getSubjects().contains(4), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.contains_subject does not work')
    assert(isequal(cohort.getSubjects().getValue(2).getID(), 'id2'), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.getSubject does not work')
end

%% Test 3: Add
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    
    sub1 = Subject.getSubject(sub_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(sub_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(sub_class, 'id3', 'label 3', 'notes 3', atlases);
    sub4 = Subject.getSubject(sub_class, 'id4', 'label 4', 'notes 4', atlases);
    sub5 = Subject.getSubject(sub_class, 'id5', 'label 5', 'notes 5', atlases);
    sub6 = Subject.getSubject(sub_class, 'id6', 'label 6', 'notes 6', atlases);
    
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', sub_class, atlases, {sub1, sub2, sub4, sub5});
    
    cohort.getSubjects().add(num2str(sub3.getID()),sub3, 3);
    
    assert(cohort.getSubjects().length() == 5, ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.addSubject does not work')
    assert(isequal(cohort.getSubjects().getValue(3).getID(), 'id3'), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.addSubject does not work')
    
    cohort.getSubjects().add(num2str(sub6.getID()), sub6);
    
    assert(cohort.getSubjects().length() == 6, ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.addSubject does not work')
    assert(isequal(cohort.getSubjects().getValue(6).getID(), 'id6'), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.addSubject does not work')
end

%% Test 4: Remove
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    
    sub1 = Subject.getSubject(sub_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(sub_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(sub_class, 'id3', 'label 3', 'notes 3', atlases);
    sub4 = Subject.getSubject(sub_class, 'id4', 'label 4', 'notes 4', atlases);
    sub5 = Subject.getSubject(sub_class, 'id5', 'label 5', 'notes 5', atlases);
    sub6 = Subject.getSubject(sub_class, 'id6', 'label 6', 'notes 6', atlases);
    
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});
    
    cohort.getSubjects().remove(3);
    
    assert(cohort.getSubjects().length() == 4, ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.removeSubject does not work')
    assert(isequal(cohort.getSubjects().getValue(2).getID(), 'id2'), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.removeSubject does not work')
    assert(isequal(cohort.getSubjects().getValue(3).getID(), 'id4'), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.removeSubject does not work')
    
    cohort.getSubjects().remove(1);
    
    assert(cohort.getSubjects().length() == 3, ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.removeSubject does not work')
    assert(isequal(cohort.getSubjects().getValue(1).getID(), 'id2'), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.removeSubject does not work')
end

%% Test 5: Replace
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    
    sub1 = Subject.getSubject(sub_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(sub_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(sub_class, 'id3', 'label 3', 'notes 3', atlases);
    sub4 = Subject.getSubject(sub_class, 'id4', 'label 4', 'notes 4', atlases);
    sub5 = Subject.getSubject(sub_class, 'id5', 'label 5', 'notes 5', atlases);
    sub6 = Subject.getSubject(sub_class, 'id6', 'label 6', 'notes 6', atlases);
    
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});
    
    cohort.getSubjects().replace(sub6.getID(), sub6, 3);
    
    assert(cohort.getSubjects().length() == 5, ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.replaceSubject does not work')
    assert(isequal(cohort.getSubjects().getValue(3).getID(), 'id6'), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.replaceSubject does not work')
end

%% Test 6: Invert
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    
    sub1 = Subject.getSubject(sub_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(sub_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(sub_class, 'id3', 'label 3', 'notes 3', atlases);
    sub4 = Subject.getSubject(sub_class, 'id4', 'label 4', 'notes 4', atlases);
    sub5 = Subject.getSubject(sub_class, 'id5', 'label 5', 'notes 5', atlases);
    sub6 = Subject.getSubject(sub_class, 'id6', 'label 6', 'notes 6', atlases);
    
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});
    
    cohort.getSubjects().invert(2, 4);
    
    assert(cohort.getSubjects().length() == 5, ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.invertSubjects does not work')
    assert(isequal(cohort.getSubjects().getValue(2).getID(), 'id4'), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.invertSubjects does not work')
    assert(isequal(cohort.getSubjects().getValue(4).getID(), 'id2'), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.invertSubjects does not work')
end

%% Test 7: MoveTo
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    
    sub1 = Subject.getSubject(sub_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(sub_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(sub_class, 'id3', 'label 3', 'notes 3', atlases);
    sub4 = Subject.getSubject(sub_class, 'id4', 'label 4', 'notes 4', atlases);
    sub5 = Subject.getSubject(sub_class, 'id5', 'label 5', 'notes 5', atlases);
    
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});
    
    cohort.getSubjects().move_to(4, 2);
    
    assert(cohort.getSubjects().length() == 5, ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.movetoSubject does not work')
    assert(isequal(cohort.getSubjects().getValue(2).getID(), 'id4'), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.movetoSubject does not work')
    
    cohort.getSubjects().move_to(1, 5);
    
    assert(cohort.getSubjects().length() == 5, ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.movetoSubject does not work')
    assert(isequal(cohort.getSubjects().getValue(5).getID(), 'id1'), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.movetoSubject does not work')
end

%% Test 8: Remove All
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    
    sub1 = Subject.getSubject(sub_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(sub_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(sub_class, 'id3', 'label 3', 'notes 3', atlases);
    sub4 = Subject.getSubject(sub_class, 'id4', 'label 4', 'notes 4', atlases);
    sub5 = Subject.getSubject(sub_class, 'id5', 'label 5', 'notes 5', atlases);
    
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});
    
    selected = cohort.getSubjects().remove_all([2, 4]);
    
    assert(cohort.getSubjects().length() == 3, ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.removeSubjects does not work')
    assert(isequal(cohort.getSubjects().getValue(3).getID(), 'id5'), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.removeSubjects does not work')
    assert(isempty(selected), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.removeSubjects does not work')
end

%% Test 9: Move Up
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    
    sub1 = Subject.getSubject(sub_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(sub_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(sub_class, 'id3', 'label 3', 'notes 3', atlases);
    sub4 = Subject.getSubject(sub_class, 'id4', 'label 4', 'notes 4', atlases);
    sub5 = Subject.getSubject(sub_class, 'id5', 'label 5', 'notes 5', atlases);
    
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});
    
    selected = cohort.getSubjects().move_up([1 3 5]);
    
    assert(cohort.getSubjects().length() == 5, ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.moveupSubjects does not work')
    assert(isequal(selected, [1 2 4]), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.moveupSubjects does not work')
end

%% Test 10: Move Down
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    
    sub1 = Subject.getSubject(sub_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(sub_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(sub_class, 'id3', 'label 3', 'notes 3', atlases);
    sub4 = Subject.getSubject(sub_class, 'id4', 'label 4', 'notes 4', atlases);
    sub5 = Subject.getSubject(sub_class, 'id5', 'label 5', 'notes 5', atlases);
    
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});
    
    selected = cohort.getSubjects().move_down([1 3 5]);
    
    assert(cohort.getSubjects().length() == 5, ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.movedownSubjects does not work')
    assert(isequal(selected, [2 4 5]), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.movedownSubjects does not work')
end

%% Test 11: Move to Top
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    
    sub1 = Subject.getSubject(sub_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(sub_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(sub_class, 'id3', 'label 3', 'notes 3', atlases);
    sub4 = Subject.getSubject(sub_class, 'id4', 'label 4', 'notes 4', atlases);
    sub5 = Subject.getSubject(sub_class, 'id5', 'label 5', 'notes 5', atlases);
    
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});
    
    selected = cohort.getSubjects().move_to_top([1 3 5]);
    
    assert(cohort.getSubjects().length() == 5, ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.move2topSubjects does not work')
    assert(isequal(selected, [1 2 3]), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.move2topSubjects does not work')
end

%% Test 12: Move to Bottom
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    
    sub1 = Subject.getSubject(sub_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(sub_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(sub_class, 'id3', 'label 3', 'notes 3', atlases);
    sub4 = Subject.getSubject(sub_class, 'id4', 'label 4', 'notes 4', atlases);
    sub5 = Subject.getSubject(sub_class, 'id5', 'label 5', 'notes 5', atlases);
    
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});
    
    selected = cohort.getSubjects().move_to_bottom([1 3 5]);
    
    assert(cohort.getSubjects().length() == 5, ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.move2bottomSubjects does not work')
    assert(isequal(selected, [3 4 5]), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.move2bottomSubjects does not work')
end

%% Test 13: Copy
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    
    sub1 = Subject.getSubject(sub_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(sub_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(sub_class, 'id3', 'label 3', 'notes 3', atlases);
    sub4 = Subject.getSubject(sub_class, 'id4', 'label 4', 'notes 4', atlases);
    sub5 = Subject.getSubject(sub_class, 'id5', 'label 5', 'notes 5', atlases);
    group1 = Group(sub_class, 'G1', 'Group 1', 'Group description 1', {});
    group2 = Group(sub_class, 'G2', 'Group 2', 'Group description 2', {});
    group1.addSubject(sub1);
    group2.addSubject(sub4);
    
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});
    cohort.getGroups().add(group1.getID(), group1);
    cohort.getGroups().add(group2.getID(), group2);
    
    cohort_copy = cohort.copy();
    
    assert(cohort ~= cohort_copy, ... % different objects
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_COPY], ...
        'Cohort.copy() does not work')
    
    atlases = cohort.getBrainAtlases();
    atlases_copy = cohort_copy.getBrainAtlases();
    for j = 1:1:length(atlases)
        assert(atlases{j} ~= atlases_copy{j}, ... % different objects
            [BRAPH2.STR ':Cohort:' BRAPH2.BUG_COPY], ...
            'Cohort.copy() does not work')
    end
    
    for j = 1:1:cohort.getSubjects().length()
        sub = cohort.getSubjects().getValue(j);
        sub_copy = cohort_copy.getSubjects().getValue(j);
        assert(sub ~= sub_copy, ... % different objects
            [BRAPH2.STR ':Cohort:' BRAPH2.BUG_COPY], ...
            'Cohort.copy() does not work')
        
        data_codes = sub.getDataCodes();
        for k = 1:1:length(data_codes)
            data_code = data_codes{k};
            assert(sub.getData(data_code) ~= sub_copy.getData(data_code), ... % different objects
                [BRAPH2.STR ':Cohort:' BRAPH2.BUG_COPY], ...
                'Cohort.copy() does not work')
            assert(sub.getData(data_code).getBrainAtlas() ~= sub_copy.getData(data_code).getBrainAtlas(), ... % different objects
                [BRAPH2.STR ':Cohort:' BRAPH2.BUG_COPY], ...
                'Cohort.copy() does not work')
        end
    end
    
    
    for k = 1:1:cohort.getGroups().length()
        group = cohort.getGroups().getValue(k);
        group_copy = cohort_copy.getGroups().getValue(k);
        assert(group ~= group_copy, ... % different objects
            [BRAPH2.STR ':Cohort:' BRAPH2.BUG_COPY], ...
            'Cohort.copy() does not work')
        
        subs = group.getSubjects();
        subs_copy = group_copy.getSubjects();
        assert(subs{1} ~= subs_copy{1}, ... % different objects
            [BRAPH2.STR ':Cohort:' BRAPH2.BUG_COPY], ...
            'Cohort.copy() does not work')
    end
end

%% Test 14: Groups
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    
    sub1 = Subject.getSubject(sub_class, 'id1', 'label 1', 'notes 1', atlases);
    sub2 = Subject.getSubject(sub_class, 'id2', 'label 2', 'notes 2', atlases);
    sub3 = Subject.getSubject(sub_class, 'id3', 'label 3', 'notes 3', atlases);
    sub4 = Subject.getSubject(sub_class, 'id4', 'label 4', 'notes 4', atlases);
    sub5 = Subject.getSubject(sub_class, 'id5', 'label 5', 'notes 5', atlases);
    
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});
    
    assert(cohort.getGroups().length() == 0, ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'The management of groups does not work')
    
    group1 = Group(sub_class, 'G1', 'Group 1', 'Group description 1', {});
    cohort.getGroups().add(group1.getID(), group1);
    assert(cohort.getGroups().length() == 1, ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'The management of groups does not work')
    
    group2 = Group(sub_class, 'G2', 'Group 2', 'Group description 2', {});
    assert(~cohort.getGroups().contains(group2), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'The management of groups does not work')
    assert(~cohort.getGroups().contains(2), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'The management of groups does not work')
    
    cohort.getGroups().add(group2.getID(), group2)
    assert(cohort.getGroups().contains(group2), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'The management of groups does not work')
    assert(cohort.getGroups().contains(2), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'The management of groups does not work')
    assert(cohort.getGroups().length() == 2, ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'The management of groups does not work')
    assert(cohort.getGroups().getValue(2) == group2, ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'The management of groups does not work')
    
    cohort.getGroups().remove(1)
    assert(cohort.getGroups().length() == 1, ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'The management of groups does not work')
    
    group1 = Group(sub_class, 'G1', 'Group 1', 'Group description 1', {});
    cohort.getGroups().add(group1.getID(), group1, 1)
    assert(cohort.getGroups().length() == 2, ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'The management of groups does not work')
    assert(cohort.getGroups().contains(group1), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'The management of groups does not work')
    assert(cohort.getGroups().contains(1), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'The management of groups does not work')
    assert(isequal(cohort.getGroups().getValue(1).getID(), 'G1'), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'The management of groups does not work')
    
    cohort.addSubjectToGroup(1, 1)
    cohort.addSubjectToGroup(2, 2)
    cohort.addSubjectToGroup(3, 2)
    assert(isequal(cohort.getGroups().getValue(1).getSubjects(), {sub1}), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'The management of groups does not work')
    assert(isequal(cohort.getGroups().getValue(2).getSubjects(), {sub2 sub3}), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'The management of groups does not work')
    
    cohort.addSubjectsToGroup([2 3 4 5], 1)
    cohort.addSubjectsToGroup([1 4 5], 2)
    assert(isequal(cohort.getGroupSubjects(1), [1 2 3 4 5]), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'The management of groups does not work')
    assert(isequal(cohort.getGroupSubjects(2), [2 3 1 4 5]), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'The management of groups does not work')
    
    cohort.removeSubjectsFromGroup(1, 1)
    cohort.removeSubjectsFromGroup([2 3], 2)
    assert(isequal(cohort.getGroupSubjects(1), [2 3 4 5]), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'The management of groups does not work')
    assert(isequal(cohort.getGroupSubjects(2), [1 4 5]), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'The management of groups does not work')
    
    copy_cohort = cohort.copy();
    copy_cohort.addSubjectsToGroup(1, 1)
    copied_subjects = copy_cohort.getGroups().getValue(2).getSubjects();
    copy_cohort.removeSubjectsFromGroup(copied_subjects{1}, 2)
    assert(isequal(cohort.getGroupSubjects(1), [2 3 4 5]), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_COPY], ...
        'The management of groups does not work')
    assert(isequal(cohort.getGroupSubjects(2), [1 4 5]), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_COPY], ...
        'The management of groups does not work')
    assert(isequal(copy_cohort.getGroupSubjects(1), [2 3 4 5 1]), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_COPY], ...
        'The management of groups does not work')
    assert(isequal(copy_cohort.getGroupSubjects(2), [4 5]), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_COPY], ...
        'The management of groups does not work')
end

%% Test 15: Cohort getNewSubject
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', sub_class, atlases, {});
    
    new_subject = cohort.getNewSubject('sub id', 'sub label', 'sub notes', {});
    assert(isa(new_subject, sub_class), ...
        [BRAPH2.STR ':Cohort:' BRAPH2.BUG_FUNC], ...
        'Cohort.getNewSubject() does not work')
end
