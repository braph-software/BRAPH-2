% test SubjectDTI
br1 = BrainRegion('BR1', 'brain region 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 5, 55, 555);
atlas = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

%% Test 1: Instantiation
sub = SubjectDTI(atlas);

%% Test 2: Save and Load Cohort XLS
% setup
sub_class = 'SubjectDTI';
input_rule = 'DTI';
input_data = rand(atlas.getBrainRegions().length(), atlas.getBrainRegions().length());
save_dir_rule = 'RootDirectory';
save_dir_path = [fileparts(which('test_braph2')) filesep 'trial_cohort_to_be_erased'];
sub1 = Subject.getSubject(sub_class, atlas, 'SubjectID', '1', input_rule, input_data);
sub2 = Subject.getSubject(sub_class, atlas, 'SubjectID', '2', input_rule, input_data);
sub3 = Subject.getSubject(sub_class, atlas, 'SubjectID', '3', input_rule, input_data);
group = Group(sub_class, {sub1, sub2, sub3}, 'GroupName', 'TestGroup1');

cohort = Cohort('cohorttest', sub_class, atlas, {sub1, sub2, sub3});
cohort.getGroups().add(group.getName(), group);

% act
SubjectDTI.save_to_xls(cohort, save_dir_rule, save_dir_path);
load_cohort = SubjectDTI.load_from_xls(sub_class, atlas);
% assert

assert(isequal(cohort.getSubjects().length(), load_cohort.getSubjects().length()), ...
    'BRAPH:SubjectDTI:SaveLoadXLS', ...
    'Problems saving or loading a cohort.')
assert(isequal(cohort.getGroups().length(), load_cohort.getGroups().length()), ...
    'BRAPH:SubjectDTI:SaveLoadXLS', ...
    'Problems saving or loading a cohort.')
for i = 1:1:max(cohort.getSubjects().length(), load_cohort.getSubjects().length())
    sub = cohort.getSubjects().getValue(i);
    sub_loaded = load_cohort.getSubjects().getValue(i);
    data = sub.getData(input_rule);
    data_loaded = sub_loaded.getData(input_rule);
    assert( ...
        isequal(sub.getID(), sub_loaded.getID()) & ...
        isequal(data.getValue(), data_loaded.getValue()), ...
        'BRAPH:SubjectDTI:SaveLoadXLS', ...
        'Problems saving or loading a cohort.')
end

%% Save and load cohort TXT
% setup
sub_class = 'SubjectDTI';
input_rule = 'DTI';
input_data = rand(atlas.getBrainRegions().length(), atlas.getBrainRegions().length());
save_dir_rule = 'RootDirectory';
save_dir_path = [fileparts(which('test_braph2')) filesep 'trial_cohort_to_be_erased'];
sub1 = Subject.getSubject(sub_class, atlas, 'SubjectID', '1', input_rule, input_data);
sub2 = Subject.getSubject(sub_class, atlas, 'SubjectID', '2', input_rule, input_data);
sub3 = Subject.getSubject(sub_class, atlas, 'SubjectID', '3', input_rule, input_data);
group = Group(sub_class, {sub1, sub2, sub3}, 'GroupName', 'TestGroup1');

cohort = Cohort('cohorttest', sub_class, atlas, {sub1, sub2, sub3});
cohort.getGroups().add(group.getName(), group);

% act
SubjectDTI.save_to_txt(cohort, save_dir_rule, save_dir_path);
load_cohort = SubjectDTI.load_from_txt(sub_class, atlas);
% assert

assert(isequal(cohort.getSubjects().length(), load_cohort.getSubjects().length()), ...
    'BRAPH:SubjectDTI:SaveLoadTXT', ...
    'Problems saving or loading a cohort.')
assert(isequal(cohort.getGroups().length(), load_cohort.getGroups().length()), ...
    'BRAPH:SubjectDTI:SaveLoadTXT', ...
    'Problems saving or loading a cohort.')
for i = 1:1:max(cohort.getSubjects().length(), load_cohort.getSubjects().length())
    sub = cohort.getSubjects().getValue(i);
    sub_loaded = load_cohort.getSubjects().getValue(i);
    data = sub.getData(input_rule);
    data_loaded = sub_loaded.getData(input_rule);
    assert( ...
        isequal(sub.getID(), sub_loaded.getID()) & ...
        isequal(round(data.getValue(),3), round(data_loaded.getValue(),3)), ...
        'BRAPH:SubjectDTI:SaveLoadTXT', ...
        'Problems saving or loading a cohort.')
end