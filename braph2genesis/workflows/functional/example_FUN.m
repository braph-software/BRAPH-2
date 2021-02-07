%EXAMPLE_FUN
% Script example workflow Functional WU

clear

%% Load BrainAtlas
[file, path, filterindex] = uigetfile('*.xlsx');
if filterindex
    atlas_file = fullfile(path, file);
else
    atlas_file = [fileparts(which('example_FUN.m')) filesep 'example data FUN (fMRI)' filesep 'desikan_atlas.xlsx'];
end
clear file filterindex path

ba_loaded = ImporterBrainAtlasXLS('File', atlas_file).get('BA');

disp(['Loaded BrainAtlas: ' ba_loaded.tostring()])

%% Load FNC Subject Data for group 1 from XLSX
[file, path, filterindex] = uigetfile('.xlsx');
if filterindex
    group_1_file = fullfile(path, file);
else
    group_1_file = [fileparts(which('example_FUN.m')) filesep 'example data FNC (fMRI)'  filesep 'xls' filesep 'GroupName1'];
end
clear file path filterindex;

gr_loaded_1 = ImporterGroupSubjectFUNXLS('DIRECTORY', group_1_file, 'BA', ba_loaded).get('GR');

disp(['Loaded Group 1: ' gr_loaded_1.tostring()])

%% Load FNC Subject Data for group 2 from XLSX
[file, path, filterindex] = uigetfile('.xlsx');
if filterindex
    group_2_file = fullfile(path, file);
else
    group_2_file = [fileparts(which('example_FUN.m')) filesep 'example data FNC (fMRI)'  filesep 'xls' filesep 'GroupName2'];
end
clear file path filterindex;

gr_loaded_2 = ImporterGroupSubjectFUNXLS('DIRECTORY', group_2_file, 'BA', ba_loaded).get('GR');

disp(['Loaded Group 2: ' gr_loaded_2.tostring()])
