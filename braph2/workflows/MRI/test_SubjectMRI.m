% test SubjectMRI

br1 = BrainRegion('BR1', 'brain region 1', 'notes 1', 1, 1.1, 1.11);
br2 = BrainRegion('BR2', 'brain region 2', 'notes 2', 2, 2.2, 2.22);
br3 = BrainRegion('BR3', 'brain region 3', 'notes 3', 3, 3.3, 3.33);
br4 = BrainRegion('BR4', 'brain region 4', 'notes 4', 4, 4.4, 4.44);
br5 = BrainRegion('BR5', 'brain region 5', 'notes 5', 5, 5.5, 5.55);
atlas = BrainAtlas('BA', 'brain atlas', 'notes', 'BrainMesh_ICBM152.nv', {br1, br2, br3, br4, br5});

%% Test 1: Instantiation
sub = SubjectMRI('id', 'label', 'notes', atlas);

%% Test 2.1: Save and Load Cohort XLS
% setup
sub_class = 'SubjectMRI';
input_rule = 'MRI';
input_data = rand(atlas.getBrainRegions().length(), 1);
save_dir_rule = 'File';
save_dir_path = [fileparts(which('test_braph2')) filesep 'trial_cohort_to_be_erased.xlsx'];
save_cohort_file = [fileparts(which('test_braph2')) filesep 'cohort_info.txt'];
sub1 = Subject.getSubject(sub_class, 'SubjectID1', 'label1', 'notes1', atlas, input_rule, input_data);
sub2 = Subject.getSubject(sub_class, 'SubjectID2', 'label2', 'notes2', atlas, input_rule, input_data);
sub3 = Subject.getSubject(sub_class, 'SubjectID3', 'label3', 'notes3', atlas, input_rule, input_data);
group = Group(sub_class, 'GroupName1', 'TestGroup1', 'notes1', {sub1, sub2, sub3});

cohort = Cohort('cohorttest', 'label1', 'notes1', sub_class, atlas, {sub1, sub2, sub3});
cohort.getGroups().add(group.getID(), group);

% act
SubjectMRI.save_to_xls(cohort, save_dir_rule, save_dir_path);

load_cohort = SubjectMRI.load_from_xls([], sub_class, atlas, save_dir_rule, save_dir_path);

% assert
assert(isequal(cohort.getSubjects().length(), load_cohort.getSubjects().length()), ...
    'BRAPH:SubjectMRI:SaveLoadXLS', ...
    'Problems saving or loading a cohort.')
assert(isequal(cohort.getGroups().length(), load_cohort.getGroups().length()), ...
    'BRAPH:SubjectMRI:SaveLoadXLS', ...
    'Problems saving or loading a cohort.')
for i = 1:1:max(cohort.getSubjects().length(), load_cohort.getSubjects().length())
    sub = cohort.getSubjects().getValue(i);
    sub_loaded = load_cohort.getSubjects().getValue(i);
    data = sub.getData(input_rule);
    data_loaded = sub_loaded.getData(input_rule);
    assert( ...
        isequal(sub.getID(), sub_loaded.getID()) & ...
        isequal(data.getValue(), data_loaded.getValue()), ...
        'BRAPH:SubjectMRI:SaveLoadXLS', ...
        'Problems saving or loading a cohort.')
end

delete(save_dir_path)
delete(save_cohort_file)

%% Test 2.2: Save and load to same cohort from XLS
% setup
sub_class = 'SubjectMRI';
input_rule = 'MRI';
input_data = rand(atlas.getBrainRegions().length(), 1);
save_dir_rule = 'File';
save_dir_path = [fileparts(which('test_braph2')) filesep 'trial_cohort_to_be_erased.xlsx'];
save_dir_path_2 = [fileparts(which('test_braph2')) filesep 'trial_cohort_to_be_erased2.xlsx'];
save_cohort_file = [fileparts(which('test_braph2')) filesep 'cohort_info.txt'];

sub1 = Subject.getSubject(sub_class, 'SubjectID1', 'label1', 'notes1', atlas, input_rule, input_data);
sub2 = Subject.getSubject(sub_class, 'SubjectID2', 'label2', 'notes2', atlas, input_rule, input_data);
sub3 = Subject.getSubject(sub_class, 'SubjectID3', 'label3', 'notes3', atlas, input_rule, input_data);
group = Group(sub_class, 'GroupName1', 'TestGroup1', 'notes1', {sub1, sub2, sub3});
cohort = Cohort('cohorttest', 'label1', 'notes1', sub_class, atlas, {sub1, sub2, sub3});
cohort.getGroups().add(group.getID(), group);

sub4 = Subject.getSubject(sub_class, 'SubjectID4', 'label4', 'notes4', atlas, input_rule, input_data);
sub5 = Subject.getSubject(sub_class, 'SubjectID5', 'label5', 'notes5', atlas, input_rule, input_data);
sub6 = Subject.getSubject(sub_class, 'SubjectID6', 'label6', 'notes6', atlas, input_rule, input_data);
group2 = Group(sub_class, 'GroupName2', 'TestGroup2', 'notes2', {sub4, sub5, sub6});
cohort_2 = Cohort('cohorttest2', 'label2', 'notes2', sub_class, atlas, {sub4, sub5, sub6});
cohort_2.getGroups().add(group2.getID(), group2);

% act
SubjectMRI.save_to_xls(cohort, save_dir_rule, save_dir_path);
SubjectMRI.save_to_xls(cohort_2, save_dir_rule, save_dir_path_2);
load_cohort = SubjectMRI.load_from_xls([], sub_class, atlas, save_dir_rule, save_dir_path);

% load 
load_cohort_2 =SubjectMRI.load_from_xls(load_cohort, sub_class, atlas, save_dir_rule, save_dir_path_2);

% assert
assert(isequal(cohort.getSubjects().length() + cohort_2.getSubjects().length(), load_cohort_2.getSubjects().length()), ...
    'BRAPH:SubjectMRI:SaveLoadXLS', ...
    'Problems saving or loading a cohort.')
assert(isequal(cohort.getGroups().length() + cohort_2.getGroups().length(), load_cohort_2.getGroups().length()), ...
    'BRAPH:SubjectMRI:SaveLoadXLS', ...
    'Problems saving or loading a cohort.')
for i = 1:1:min(cohort.getSubjects().length(), load_cohort_2.getSubjects().length())
    sub = cohort.getSubjects().getValue(i);
    sub2 = cohort_2.getSubjects().getValue(i);    
    subs_loaded = load_cohort.getSubjects();
    for j = 1:1:subs_loaded.length()
        s = subs_loaded.getValue(j);
        ids_loaded{j} = s.getID(); %#ok<SAGROW>
    end

    assert(ismember(sub.getID(), ids_loaded),  ...
        'BRAPH:SubjectMRI:SaveLoadXLS', ...
        'Problems saving or loading a cohort.')
    
    assert(ismember(sub2.getID(), ids_loaded),  ...
        'BRAPH:SubjectMRI:SaveLoadXLS', ...
        'Problems saving or loading a cohort.')
end

delete(save_dir_path)
delete(save_dir_path_2)
delete(save_cohort_file)

%% Test 3.1: Save and Load cohort from TXT
% setup
sub_class = 'SubjectMRI';
input_rule = 'MRI';
input_data = rand(atlas.getBrainRegions().length(), 1);
save_dir_rule = 'File';
save_dir_path = [fileparts(which('test_braph2')) filesep 'trial_cohort_to_be_erased.txt'];
save_cohort_file = [fileparts(which('test_braph2')) filesep 'cohort_info.txt'];
save_group_file = [fileparts(which('test_braph2')) filesep 'group_info.txt'];
sub1 = Subject.getSubject(sub_class, 'SubjectID1', 'label1', 'notes1', atlas, input_rule, input_data);
sub2 = Subject.getSubject(sub_class, 'SubjectID2', 'label2', 'notes2', atlas, input_rule, input_data);
sub3 = Subject.getSubject(sub_class, 'SubjectID3', 'label3', 'notes3', atlas, input_rule, input_data);
group = Group(sub_class, 'GroupName1', 'TestGroup1', 'notes1', {sub1, sub2, sub3});

cohort = Cohort('cohorttest', 'label1', 'notes1', sub_class, atlas, {sub1, sub2, sub3});
cohort.getGroups().add(group.getID(), group);

% act
SubjectMRI.save_to_txt(cohort, save_dir_rule, save_dir_path);

load_cohort = SubjectMRI.load_from_txt([], sub_class, atlas, save_dir_rule, save_dir_path);

% assert
assert(isequal(cohort.getSubjects().length(), load_cohort.getSubjects().length()), ...
    'BRAPH:SubjectMRI:SaveLoadTXT', ...
    'Problems saving or loading a cohort.')
assert(isequal(cohort.getGroups().length(), load_cohort.getGroups().length()), ...
    'BRAPH:SubjectMRI:SaveLoadTXT', ...
    'Problems saving or loading a cohort.')
for i = 1:1:max(cohort.getSubjects().length(), load_cohort.getSubjects().length())
    sub = cohort.getSubjects().getValue(i);
    sub_loaded = load_cohort.getSubjects().getValue(i);
    data = sub.getData(input_rule);
    data_loaded = sub_loaded.getData(input_rule);
    assert( ...
        isequal(sub.getID(), sub_loaded.getID()) & ...
        isequal(round(data.getValue(), 3), round(data_loaded.getValue(), 3)), ...
        'BRAPH:SubjectMRI:SaveLoadTXT', ...
        'Problems saving or loading a cohort.')
end

delete(save_dir_path)
delete(save_cohort_file)
delete(save_group_file)

%% Test 4.1: Save and Load cohort from JSON
% setup
sub_class = 'SubjectMRI';
input_rule = 'MRI';
input_data = rand(atlas.getBrainRegions().length(), 1);
save_dir_rule = 'File';
save_dir_path = [fileparts(which('test_braph2')) filesep 'trial_cohort_to_be_erased.json'];
sub1 = Subject.getSubject(sub_class, 'SubjectID1', 'label1', 'notes1', atlas, input_rule, input_data);
sub2 = Subject.getSubject(sub_class, 'SubjectID2', 'label2', 'notes2', atlas, input_rule, input_data);
sub3 = Subject.getSubject(sub_class, 'SubjectID3', 'label3', 'notes3', atlas, input_rule, input_data);
group = Group(sub_class, 'GroupName1', 'TestGroup1', 'notes1', {sub1, sub2, sub3});

cohort = Cohort('cohorttest', 'label1', 'notes1', sub_class, atlas, {sub1, sub2, sub3});
cohort.getGroups().add(group.getID(), group);

% act
SubjectMRI.save_to_json(cohort, save_dir_rule, save_dir_path);

load_cohort = SubjectMRI.load_from_json(sub_class, atlas, save_dir_rule, save_dir_path);

% assert
assert(isequal(cohort.getSubjects().length(), load_cohort.getSubjects().length()), ...
    'BRAPH:SubjectMRI:SaveLoadTXT', ...
    'Problems saving or loading a cohort.')
assert(isequal(cohort.getGroups().length(), load_cohort.getGroups().length()), ...
    'BRAPH:SubjectMRI:SaveLoadTXT', ...
    'Problems saving or loading a cohort.')
for i = 1:1:max(cohort.getSubjects().length(), load_cohort.getSubjects().length())
    sub = cohort.getSubjects().getValue(i);
    sub_loaded = load_cohort.getSubjects().getValue(i);
    data = sub.getData(input_rule);
    data_loaded = sub_loaded.getData(input_rule);
    assert( ...
        isequal(sub.getID(), sub_loaded.getID()) & ...
        isequal(round(data.getValue(), 3), round(data_loaded.getValue(), 3)), ...
        'BRAPH:SubjectMRI:SaveLoadTXT', ...
        'Problems saving or loading a cohort.')
end

delete(save_dir_path)