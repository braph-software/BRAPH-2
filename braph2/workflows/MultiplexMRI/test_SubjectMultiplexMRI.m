% test SubjectMultiplexMRI

br1 = BrainRegion('BR1', 'brain region 1', 'notes 1', 1, 1.1, 1.11);
br2 = BrainRegion('BR2', 'brain region 2', 'notes 2', 2, 2.2, 2.22);
br3 = BrainRegion('BR3', 'brain region 3', 'notes 3', 3, 3.3, 3.33);
br4 = BrainRegion('BR4', 'brain region 4', 'notes 4', 4, 4.4, 4.44);
br5 = BrainRegion('BR5', 'brain region 5', 'notes 5', 5, 5.5, 5.55);
atlas = BrainAtlas('BA', 'brain atlas', 'notes', 'BrainMesh_ICBM152.nv', {br1, br2, br3, br4, br5});

%% Test 1: Instantiation
sub = SubjectMultiplexMRI('id', 'label', 'notes', atlas);

%% Test 2: Save and Load Cohort XLS
% setup
sub_class = 'SubjectMultiplexMRI';
input_rule1 = 'MRI1';
input_rule2 = 'MRI2';
input_data1 = rand(atlas.getBrainRegions().length(), 1);
input_data2 = rand(atlas.getBrainRegions().length(), 1);
save_dir_rule1 = 'File1';
save_dir_rule2 = 'File2';
save_dir_path1 = [fileparts(which('test_braph2')) filesep 'trial_cohort_to_be_erased.xlsx'];
save_dir_path2 = [fileparts(which('test_braph2')) filesep 'trial_cohort_to_be_erased2.xlsx'];
cohort_info_path = [fileparts(which('test_braph2')) filesep 'trial_cohort_to_be_erased.txt'];
sub1 = Subject.getSubject(sub_class, 'SubjectID1', 'label1', 'notes1', atlas, input_rule1, input_data1, input_rule2, input_data2);
sub2 = Subject.getSubject(sub_class, 'SubjectID2', 'label2', 'notes2', atlas, input_rule1, input_data1, input_rule2, input_data2);
sub3 = Subject.getSubject(sub_class, 'SubjectID3', 'label3', 'notes3', atlas, input_rule1, input_data1, input_rule2, input_data2);
group = Group(sub_class, 'GroupName1', 'TestGroup1', 'notes1', {sub1, sub2, sub3});

cohort = Cohort('cohorttest', 'label1', 'notes1', sub_class, atlas, {sub1, sub2, sub3});
cohort.getGroups().add(group.getID(), group);

% act
SubjectMultiplexMRI.save_to_xls(cohort, save_dir_rule1, save_dir_path1, save_dir_rule2, save_dir_path2);

load_cohort = SubjectMultiplexMRI.load_from_xls(sub_class, atlas, save_dir_rule1, save_dir_path1, save_dir_rule2, save_dir_path2);

% assert
assert(isequal(cohort.getSubjects().length(), load_cohort.getSubjects().length()), ...
    [BRAPH2.STR ':SubjectMultiplexMRI:SaveLoadXLS'], ...
    'Problems saving or loading a cohort.')
assert(isequal(cohort.getGroups().length(), load_cohort.getGroups().length()), ...
    [BRAPH2.STR ':SubjectMultiplexMRI:SaveLoadXLS'], ...
    'Problems saving or loading a cohort.')
for i = 1:1:max(cohort.getSubjects().length(), load_cohort.getSubjects().length())
    sub = cohort.getSubjects().getValue(i);
    sub_loaded = load_cohort.getSubjects().getValue(i);
    data1 = sub.getData(input_rule1);
    data_loaded1 = sub_loaded.getData(input_rule1);
    data2 = sub.getData(input_rule2);
    data_loaded2 = sub_loaded.getData(input_rule2);
    assert( ...
        isequal(sub.getID(), sub_loaded.getID()) & ...
        isequal(data1.getValue(), data_loaded1.getValue()) & ...
        isequal(data2.getValue(), data_loaded2.getValue()), ...
        [BRAPH2.STR ':SubjectMultiplexMRI:SaveLoadXLS'], ...
        'Problems saving or loading a cohort.')
end

delete(save_dir_path1)
delete(save_dir_path2)
delete(cohort_info_path)


%% Test 3: Save and Load cohort from TXT
% setup
sub_class = 'SubjectMultiplexMRI';
input_rule1 = 'MRI1';
input_rule2 = 'MRI2';
input_data1 = rand(atlas.getBrainRegions().length(), 1);
input_data2 = rand(atlas.getBrainRegions().length(), 1);
save_dir_rule1 = 'File1';
save_dir_rule2 = 'File2';
save_dir_path1 = [fileparts(which('test_braph2')) filesep 'trial_cohort_to_be_erased.txt'];
save_dir_path2 = [fileparts(which('test_braph2')) filesep 'trial_cohort_to_be_erased2.txt'];
save_cohort_file = [fileparts(which('test_braph2')) filesep 'cohort_info.txt'];
save_group_file = [fileparts(which('test_braph2')) filesep 'group_info.txt'];
sub1 = Subject.getSubject(sub_class, 'SubjectID1', 'label1', 'notes1', atlas, input_rule1, input_data1, input_rule2, input_data2);
sub2 = Subject.getSubject(sub_class, 'SubjectID2', 'label2', 'notes2', atlas, input_rule1, input_data1, input_rule2, input_data2);
sub3 = Subject.getSubject(sub_class, 'SubjectID3', 'label3', 'notes3', atlas, input_rule1, input_data1, input_rule2, input_data2);
group = Group(sub_class, 'GroupName1', 'TestGroup1', 'notes1', {sub1, sub2, sub3});

cohort = Cohort('cohorttest', 'label1', 'notes1', sub_class, atlas, {sub1, sub2, sub3});
cohort.getGroups().add(group.getID(), group);

% act
SubjectMultiplexMRI.save_to_txt(cohort, save_dir_rule1, save_dir_path1, save_dir_rule2, save_dir_path2);

load_cohort = SubjectMultiplexMRI.load_from_txt(sub_class, atlas, save_dir_rule1, save_dir_path1, save_dir_rule2, save_dir_path2);

% assert
assert(isequal(cohort.getSubjects().length(), load_cohort.getSubjects().length()), ...
    [BRAPH2.STR ':SubjectMultiplexMRI:SaveLoadTXT'], ...
    'Problems saving or loading a cohort.')
assert(isequal(cohort.getGroups().length(), load_cohort.getGroups().length()), ...
    [BRAPH2.STR ':SubjectMultiplexMRI:SaveLoadTXT'], ...
    'Problems saving or loading a cohort.')
for i = 1:1:max(cohort.getSubjects().length(), load_cohort.getSubjects().length())
    sub = cohort.getSubjects().getValue(i);
    sub_loaded = load_cohort.getSubjects().getValue(i);
    data1 = sub.getData(input_rule1);
    data_loaded1 = sub_loaded.getData(input_rule1);
    data2 = sub.getData(input_rule1);
    data_loaded2 = sub_loaded.getData(input_rule1);
    assert( ...
        isequal(sub.getID(), sub_loaded.getID()) & ...
        isequal(round(data1.getValue(), 3), round(data_loaded1.getValue(), 3)) & ...
        isequal(round(data2.getValue(), 3), round(data_loaded2.getValue(), 3 )), ...
        [BRAPH2.STR ':SubjectMultiplexMRI:SaveLoadTXT'], ...
        'Problems saving or loading a cohort.')
end

delete(save_dir_path1)
delete(save_dir_path2)
delete(save_cohort_file)
delete(save_group_file)

%% Test 4: Save and Load cohort from JSON
% setup
sub_class = 'SubjectMultiplexMRI';
input_rule1 = 'MRI1';
input_rule2 = 'MRI2';
input_data1 = rand(atlas.getBrainRegions().length(), 1);
input_data2 = rand(atlas.getBrainRegions().length(), 1);
save_dir_rule1 = 'File1';
save_dir_rule2 = 'File2';
save_dir_path1 = [fileparts(which('test_braph2')) filesep 'trial_cohort_to_be_erased.json'];
save_dir_path2 = [fileparts(which('test_braph2')) filesep 'trial_cohort_to_be_erased2.json'];
sub1 = Subject.getSubject(sub_class, 'SubjectID1', 'label1', 'notes1', atlas, input_rule1, input_data1, input_rule2, input_data2);
sub2 = Subject.getSubject(sub_class, 'SubjectID2', 'label2', 'notes2', atlas, input_rule1, input_data1, input_rule2, input_data2);
sub3 = Subject.getSubject(sub_class, 'SubjectID3', 'label3', 'notes3', atlas, input_rule1, input_data1, input_rule2, input_data2);
group = Group(sub_class, 'GroupName1', 'TestGroup1', 'notes1', {sub1, sub2, sub3});

cohort = Cohort('cohorttest', 'label1', 'notes1', sub_class, atlas, {sub1, sub2, sub3});
cohort.getGroups().add(group.getID(), group);

% act
SubjectMultiplexMRI.save_to_json(cohort, save_dir_rule1, save_dir_path1, save_dir_rule2, save_dir_path2);

load_cohort = SubjectMultiplexMRI.load_from_json(sub_class, atlas, save_dir_rule1, save_dir_path1, save_dir_rule2, save_dir_path2);

% assert
assert(isequal(cohort.getSubjects().length(), load_cohort.getSubjects().length()), ...
    [BRAPH2.STR ':SubjectMultiplexMRI:SaveLoadJSON'], ...
    'Problems saving or loading a cohort.')
assert(isequal(cohort.getGroups().length(), load_cohort.getGroups().length()), ...
    [BRAPH2.STR ':SubjectMultiplexMRI:SaveLoadJSON'], ...
    'Problems saving or loading a cohort.')
for i = 1:1:max(cohort.getSubjects().length(), load_cohort.getSubjects().length())
    sub = cohort.getSubjects().getValue(i);
    sub_loaded = load_cohort.getSubjects().getValue(i);
    data1 = sub.getData(input_rule1);
    data_loaded1 = sub_loaded.getData(input_rule1);
    data2 = sub.getData(input_rule1);
    data_loaded2 = sub_loaded.getData(input_rule1);
    assert( ...
        isequal(sub.getID(), sub_loaded.getID()) & ...
        isequal(round(data1.getValue(), 3), round(data_loaded1.getValue(), 3)) & ...
        isequal(round(data2.getValue(), 3), round(data_loaded2.getValue(), 3 )), ...
        [BRAPH2.STR ':SubjectMultiplexMRI:SaveLoadTXT'], ...
        'Problems saving or loading a cohort.')
end

delete(save_dir_path1)
delete(save_dir_path2)