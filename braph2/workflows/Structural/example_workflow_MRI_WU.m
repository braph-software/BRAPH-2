% Script example workflow MRI WU
clear
%#ok<*NOPTS>

%% Load BrainAtlas
[file, path, filterindex] = uigetfile('*.xlsx');
if filterindex
    atlas_file = fullfile(path, file);
else
    atlas_file = [fileparts(which('example_workflow_MRI_WU.m')) filesep() 'example data MRI' filesep() 'desikan_atlas.xlsx'];
end
clear file filterindex path

atlas = BrainAtlas.load_from_xls('File', atlas_file);

disp(['Loaded BrainAtlas: ' atlas.tostring()])

%% Load MRI Subject Data for group 1
[file, path, filterindex] = uigetfile('.xlsx');
if filterindex
    group1_file = fullfile(path, file);
else
    group1_file = [fileparts(which('example_workflow_MRI_WU.m')) filesep() 'example data MRI' filesep() 'xls' filesep() 'MRI_group1.xlsx'];
end
clear file path filterindex;

cohort = SubjectMRI.load_from_xls(atlas, 'File', group1_file);

disp(['Loaded Group 1: ' cohort.tostring()])

%% Load MRI Subject Data for group 2 into the same cohort
[file, path, filterindex] = uigetfile('.xlsx');
if filterindex
    group2_file = fullfile(path, file);    
else    
    group2_file = [fileparts(which('example_workflow_MRI_WU.m')) filesep() 'example data MRI' filesep() 'xls' filesep() 'MRI_group2.xlsx'];
end
clear file path filterindex;

cohort = SubjectMRI.load_from_xls(cohort', 'File', group2_file);

disp(['Loaded Group 2: ' cohort.tostring()])

%% Create Analysis
analysis = AnalysisMRI_WU('analysis example ID', 'analysis example label', 'analysis example notes', cohort, {}, {}, {});
disp('AnalysisMRI_WU created.')

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
