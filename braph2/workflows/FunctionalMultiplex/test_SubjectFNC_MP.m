% test SubjectFNC

br1 = BrainRegion('BR1', 'brain region 1', 'notes 1', 1, 1.1, 1.11);
br2 = BrainRegion('BR2', 'brain region 2', 'notes 2', 2, 2.2, 2.22);
br3 = BrainRegion('BR3', 'brain region 3', 'notes 3', 3, 3.3, 3.33);
br4 = BrainRegion('BR4', 'brain region 4', 'notes 4', 4, 4.4, 4.44);
br5 = BrainRegion('BR5', 'brain region 5', 'notes 5', 5, 5.5, 5.55);
atlas = BrainAtlas('BA', 'brain atlas', 'notes', 'BrainMesh_ICBM152.nv', {br1, br2, br3, br4, br5});

%% Test 1: Instantiation
sub = SubjectFNC_MP('id', 'label', 'notes', atlas);

%% Save and load cohort from xls
% setup
sub_class = 'SubjectFNC_MP';
% create 5 subjects with 4 layers each
for i = 1:1:5  % subs
    for j = 1:1:4  % layers
        inputs{1, j} = ['FNC_MP_' num2str(j)]; %#ok<SAGROW> % this will be the layers id inside the dicts
        inputs{2, j} = rand(atlas.getBrainRegions().length(), 10); %#ok<SAGROW>
    end
    subs{i} = Subject.getSubject(sub_class, ['SubjectID' num2str(i)], 'label1', 'notes1', atlas, 'FNC_Layers', 4, 'age', randi(50), ...
        'gender', randi(2)-1, 'education', randi(20), inputs{:});  %#ok<SAGROW> 
end

save_dir_rule = 'RootDirectory';
save_dir_path = [fileparts(which('test_braph2')) filesep 'trial_cohort_to_be_erased'];

group = Group(sub_class, 'GroupName1', 'TestGroup1', 'notes1', {subs{1}, subs{2}, subs{3}});
group2 = Group(sub_class, 'GroupName2', 'TestGroup2', 'notes2', {subs{4}, subs{5}});

cohort = Cohort('cohorttest', 'label1', 'notes1', sub_class, atlas, subs);
cohort.getGroups().add(group.getID(), group);
cohort.getGroups().add(group2.getID(), group2);

% act
SubjectFNC_MP.save_to_xls(cohort, save_dir_rule, save_dir_path);

load_cohort = SubjectFNC_MP.load_from_xls(atlas, sub_class, 'Directory', save_dir_path);

% assert
assert(isequal(cohort.getSubjects().length(), load_cohort.getSubjects().length()), ...
    'BRAPH:SubjectFNC:SaveLoadXLS', ...
    'Problems saving or loading a cohort.')
assert(isequal(cohort.getGroups().length(), load_cohort.getGroups().length()), ...
    'BRAPH:SubjectFNC:SaveLoadXLS', ...
    'Problems saving or loading a cohort.')
for i = 1:1:max(cohort.getSubjects().length(), load_cohort.getSubjects().length())
    sub = cohort.getSubjects().getValue(i);
    sub_loaded = load_cohort.getSubjects().getValue(i);
    data = sub.getData(input_rule);
    data_loaded = sub_loaded.getData(input_rule);
    assert( ...
        isequal(sub.getID(), sub_loaded.getID()) & ...
        isequal(data.getValue(), data_loaded.getValue()), ...
        'BRAPH:SubjectFNC:SaveLoadXLS', ...
        'Problems saving or loading a cohort.')
end

rmdir(save_dir_path, 's')
