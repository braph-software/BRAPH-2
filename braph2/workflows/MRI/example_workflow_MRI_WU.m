% Script example workflow MRI WU
clear

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

%% Create Measurement
measure = 'Degree';
groups = analysis.getCohort().getGroups();

measurement_group_1 = analysis.getMeasurement(measure, groups.getValue(1));
measurement_group_2 = analysis.getMeasurement(measure, groups.getValue(2));

disp([measure ' for group 1: ' measurement_group_1.getMeasureValue()])
disp([measure ' for group 2: ' measurement_group_2.getMeasureValue()])

%% Create Comparison
number_of_permutations = 10;
comparison = analysis.getComparison(measure, groups.getValue(1), groups.getValue(2), 'PermutationNumber', number_of_permutations);
disp([measure ' comparison between groups: ' groups.getValue(1).getID() ' and ' groups.getValue(2).getID() ' : ' comparison.getDifference()])

%% Create RandomComparison
number_of_permutations = 10;
random_comparison = analysis.getRandomComparison(measure, groups.getValue(1), groups.getValue(2), 'PermutationNumber', number_of_permutations);
disp([measure ' random comparison between groups: ' groups.getValue(1).getID() ' and ' groups.getValue(2).getID() ' : ' random_comparison.getDifference()])

disp('Script has finished!')
