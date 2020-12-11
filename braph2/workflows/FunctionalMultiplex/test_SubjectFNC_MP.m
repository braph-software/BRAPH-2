% test SubjectFNC
root = fileparts(which('SubjectFNC_MP'));
example = [root filesep() 'example data FNC_MP' filesep() 'desikan_atlas.xlsx'];
atlas = BrainAtlas.load_from_xls('File', example);

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
    data = sub.getData('FNC_MP_1');
    age = sub.getData('age');
    gender = sub.getData('gender');
    education = sub.getData('education');
    age_loaded = sub_loaded.getData('age');
    gender_loaded = sub_loaded.getData('gender');
    education_loaded = sub_loaded.getData('education');
    data_loaded = sub_loaded.getData('FNC_MP_1');
    
    assert( ...
        isequal(sub.getID(), sub_loaded.getID()) & ...
        isequal(data.getValue(), data_loaded.getValue()) & ...
        isequal(age.getValue(), age_loaded.getValue()) & ...
        isequal(gender.getValue(), gender_loaded.getValue()) & ...
        isequal(education.getValue(), education_loaded.getValue()), ...
        'BRAPH:SubjectFNC:SaveLoadXLS', ...
        'Problems saving or loading a cohort.')
end

rmdir(save_dir_path, 's')
