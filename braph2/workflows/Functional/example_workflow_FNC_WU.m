% Script example workflow FNC WU
clear
%#ok<*NOPTS>

%% Load BrainAtlas
[file, path, filterindex] = uigetfile('*.xlsx');
if filterindex
    atlas_file = fullfile(path, file);
else
    atlas_file = [fileparts(which('example_workflow_FNC_WU.m')) filesep() 'example data FNC (fMRI)' filesep() 'desikan_atlas.xlsx'];
end
clear file filterindex path

atlas = BrainAtlas.load_from_xls('File', atlas_file);

disp(['Loaded BrainAtlas: ' atlas.tostring()])
%%
sub_class = 'SubjectFNC';
input_rule = 'FNC';
input_data = rand(atlas.getBrainRegions().length(), 10);
save_dir_rule = 'RootDirectory';
save_dir_path = [fileparts(which('test_braph2')) filesep 'trial_cohort_to_be_erased'];
sub1 = Subject.getSubject(sub_class, 'SubjectID1', 'label1', 'notes1', atlas, input_rule, input_data);
sub2 = Subject.getSubject(sub_class, 'SubjectID2', 'label2', 'notes2', atlas, input_rule, input_data);
sub3 = Subject.getSubject(sub_class, 'SubjectID3', 'label3', 'notes3', atlas, input_rule, input_data);
sub4 = Subject.getSubject(sub_class, 'SubjectID4', 'label4', 'notes4', atlas, input_rule, input_data);
sub5 = Subject.getSubject(sub_class, 'SubjectID5', 'label5', 'notes5', atlas, input_rule, input_data);
group = Group(sub_class, 'GroupName1', 'TestGroup1', 'notes1', {sub1, sub2, sub3});
group2 = Group(sub_class, 'GroupName2', 'TestGroup2', 'notes2', {sub4, sub5});

cohort = Cohort('cohorttest', 'label1', 'notes1', sub_class, atlas, {sub1, sub2, sub3, sub4, sub5});
cohort.getGroups().add(group.getID(), group);
cohort.getGroups().add(group2.getID(), group2);

%% Load FNC Subject Data for group 1
[file, path, filterindex] = uigetfile('.xlsx');
if filterindex
    group1_file = fullfile(path, file);
else
    group1_file = [fileparts(which('example_workflow_FNC_WU.m')) filesep() 'example data FNC (fMRI)'  filesep() 'txt' filesep() 'GroupName1'];
end
clear file path filterindex;

cohort = SubjectFNC.load_from_xls(atlas, 'File', group1_file);

disp(['Loaded Group 1: ' cohort.tostring()])

%% Load FNC Subject Data for group 2 into the same cohort
[file, path, filterindex] = uigetfile('.xlsx');
if filterindex
    group2_file = fullfile(path, file);    
else    
    group2_file = [fileparts(which('example_workflow_FNC_WU.m')) filesep() 'example data FNC (fMRI)'  filesep() 'txt' filesep() 'GroupName2'];
end
clear file path filterindex;

cohort = SubjectFNC.load_from_xls(cohort', 'File', group2_file);

disp(['Loaded Group 2: ' cohort.tostring()])

%% Create Analysis
analysis = AnalysisFNC_WU('analysis example ID', 'analysis example label', 'analysis example notes', cohort, {}, {}, {});
disp('AnalysisFNC_WU created.')

groups = analysis.getCohort().getGroups();
group_1 = groups.getValue(1);
group_2 = groups.getValue(2);

%% Create Measurement
measure = 'Degree';

measurement_group_1 = analysis.getMeasurement(measure, group_1) 
measurement_group_2 = analysis.getMeasurement(measure, group_2)

%% Create RandomComparison
measure = 'Degree';
number_of_randomizations = 10;

random_comparison_group_1 = analysis.getRandomComparison(measure, group_1, 'RandomizationNumber', number_of_randomizations)
random_comparison_group_2 = analysis.getRandomComparison(measure, group_2, 'RandomizationNumber', number_of_randomizations)

%% Create Comparison
measure = 'Degree';
number_of_permutations = 10;

comparison = analysis.getComparison(measure, group_1, group_2, 'PermutationNumber', number_of_permutations)
