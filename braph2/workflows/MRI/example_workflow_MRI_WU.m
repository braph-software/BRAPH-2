% Script example workflow MRI WU
clear

%% Load BrainAtlas
[file, path, filterindex] = uigetfile('*.xlsx');
if filterindex
    atlas_file = fullfile(path, file);
else
    atlas_file = [fileparts(which('example_workflow_MRI_WU.m')) filesep() 'example data MRI' filesep() 'example_desikan_atlas.xlsx'];
end
clear file filterindex path

atlas = BrainAtlas.load_from_xls('File', atlas_file);

disp(['Loaded BrainAtlas: ' atlas.tostring()])

%% Load MRI Subject Data for group 1
[file, path, filterindex] = uigetfile('.xlsx');
if filterindex
    group1_file = fullfile(path, file);
else
    group1_file = [fileparts(which('workflows')) filesep() 'MRI' filesep() 'example data MRI' filesep() 'xls' filesep() 'gr1_MRI.xlsx'];
end
clear file path filterindex;

cohort = SubjectMRI.load_from_xls(atlas, 'File', group1_file);

disp(['Loaded Group 1: ' cohort.tostring()])

%% Load MRI Subject Data for group 2 into the same cohort
[file, path, filterindex] = uigetfile('.xlsx');

if filterindex
    group2_file = fullfile(path, file);
    cohort_group_2 = SubjectMRI.load_from_xls(cohort_group_1', 'File', group2_file);
else
    disp('Failed to load SubjectMRI group 2.')
    clear file path filterindex;
end

%% Create Analysis
% analysis = AnalysisMRI_WU('analysis example ID', 'analysis example label', 'analysis example notes', cohort_group_2, {}, {}, {});
% disp(['Analysis created: ' analysis.getID()])
%
% % Create Measurement
% measure = 'Degree';
% groups = analysis.getGroups();
%
% measurement = MeasurementMRI_WU('ID example measure 1', 'label example measure l', 'notes example measure 1', atlas, measure, group);
%
%
% Create Comparison
% Create RandomComparison
