% Script example workflow CON WU
clear
%#ok<*NOPTS>

%% Load BrainAtlas
[file, path, filterindex] = uigetfile('*.xlsx');
if filterindex
    atlas_file = fullfile(path, file);
else
    atlas_file = [fileparts(which('example_CON.m')) filesep() 'example data CON (DTI)' filesep() 'desikan_atlas.xlsx'];
end
clear file filterindex path

ba_loaded = ImporterBrainAtlasXLS('File', atlas_file).get('BA');

disp(['Loaded BrainAtlas: ' ba_loaded.tostring()])

% %% Subjects
% % input_data = rand(atlas.getBrainRegions().length(), atlas.getBrainRegions().length());
% % sub11 = Subject.getSubject('SubjectCON', 'SubjectID11', 'label1', 'notes1', atlas, 'CON', input_data);
% % sub12 = Subject.getSubject('SubjectCON', 'SubjectID12', 'label2', 'notes2', atlas, 'CON', input_data);
% % sub13 = Subject.getSubject('SubjectCON', 'SubjectID13', 'label3', 'notes3', atlas, 'CON', input_data);
% % sub14 = Subject.getSubject('SubjectCON', 'SubjectID14', 'label4', 'notes4', atlas, 'CON', input_data);
% % sub15 = Subject.getSubject('SubjectCON', 'SubjectID15', 'label5', 'notes5', atlas, 'CON', input_data);
% % group = Group('SubjectCON', 'GroupName2', 'TestGroup2', 'notes2', {sub11, sub12, sub13, sub14, sub15});
% % cohort = Cohort('trial_cohort', 'label1', 'notes1', 'SubjectCON', atlas, {sub11, sub12, sub13, sub14, sub15});
% % cohort.getGroups().add(group.getID(), group);
% % SubjectCON.save_to_json(cohort);

%% Load CON Subject Data for group 1 from XLSX
[file, path, filterindex] = uigetfile('.xlsx');
if filterindex
    group1_file = fullfile(path, file);
else
    group1_file = [fileparts(which('example_CON.m')) filesep() 'example data CON (DTI)' filesep() 'xls'  filesep() 'GroupName1'];
end
clear file path filterindex;

gr_loaded1 = ImporterGroupSubjectFUNXLS('DIRECTORY', group1_file, 'BA', ba_loaded).get('GR');

disp(['Loaded Group 1: ' gr_loaded1.tostring()])

%% Load CON Subject Data for group 2 from XLSX
[file, path, filterindex] = uigetfile('.xlsx');
if filterindex
    group2_file = fullfile(path, file);    
else    
    group2_file = [fileparts(which('example_CON.m')) filesep() 'example data CON (DTI)' filesep() 'xls' filesep() 'GroupName2'];
end
clear file path filterindex;

gr_loaded2 = ImporterGroupSubjectFUNXLS('DIRECTORY', group2_file, 'BA', ba_loaded).get('GR');

disp(['Loaded Group 2: ' gr_loaded2.tostring()])

% %% Create Analysis
% analysis = AnalysisCON_WU('analysis example ID', 'analysis example label', 'analysis example notes', cohort, {}, {}, {});
% disp('AnalysisCON_WU created.')
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
