% Script example workflow ST
clear
%#ok<*NOPTS>

%% Load BrainAtlas
[file, path, filterindex] = uigetfile('*.xlsx');
if filterindex
    atlas_file = fullfile(path, file);
else
    atlas_file = [fileparts(which('example_ST.m')) filesep() 'example data ST (MRI)' filesep() 'desikan_atlas.xlsx'];
end
clear file filterindex path

im = ImporterBrainAtlasXLS( ...
    'FILE', atlas_file ...
    );
ba_loaded = im.get('BA');

disp(['Loaded BrainAtlas: ' ba_loaded.tostring()])

%% Load ST Subject Data for group 1
[file, path, filterindex] = uigetfile('.xlsx');
if filterindex
    group1_file = fullfile(path, file);
else
    group1_file = [fileparts(which('example_ST.m')) filesep() 'example data ST (MRI)' filesep() 'xls' filesep() 'ST_group1.xlsx'];
end
clear file path filterindex;

im1 = ImporterGroupSubjectSTXLS( ...
    'FILE', group1_file, ...
    'BA', ba_loaded ...
    );
gr_loaded1 = im1.get('GR');

disp(['Loaded Group 1: ' gr_loaded1.tostring()])

%% Load ST Subject Data for group 2 into the same cohort
[file, path, filterindex] = uigetfile('.xlsx');
if filterindex
    group2_file = fullfile(path, file);    
else    
    group2_file = [fileparts(which('example_ST.m')) filesep() 'example data ST (MRI)' filesep() 'xls' filesep() 'ST_group2.xlsx'];
end
clear file path filterindex;

im2 = ImporterGroupSubjectSTXLS( ...
    'FILE', group2_file, ...
    'BA', ba_loaded ...
    );
gr_loaded2 = im2.get('GR');

disp(['Loaded Group 2: ' gr_loaded2.tostring()])

%% Create Analysis
% analysis = AnalysisST_WU('analysis example ID', 'analysis example label', 'analysis example notes', cohort, {}, {}, {});
% disp('AnalysisST_WU created.')
% 
% groups = analysis.getCohort().getGroups();
% group_1 = groups.getValue(1);
% group_2 = groups.getValue(2);
% 
% %% Create Measurement
% measure = 'Degree';
% 
% measurement_group_1 = analysis.getMeasurement(measure, group_1) 
% measurement_group_2 = analysis.getMeasurement(measure, group_2)
% 
% %% Create RandomComparison
% measure = 'Degree';
% number_of_randomizations = 10;
% 
% random_comparison_group_1 = analysis.getRandomComparison(measure, group_1, 'RandomizationNumber', number_of_randomizations)
% random_comparison_group_2 = analysis.getRandomComparison(measure, group_2, 'RandomizationNumber', number_of_randomizations)
% 
% %% Create Comparison
% measure = 'Degree';
% number_of_permutations = 10;
% 
% comparison = analysis.getComparison(measure, group_1, group_2, 'PermutationNumber', number_of_permutations)
