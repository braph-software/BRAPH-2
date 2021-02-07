%EXAMPLE_CON
% Script example workflow CON WU

clear

%% Load BrainAtlas
[file, path, filterindex] = uigetfile('*.xlsx');
if filterindex
    atlas_file = fullfile(path, file);
else
    atlas_file = [fileparts(which('example_CON.m')) filesep 'example data CON (DTI)' filesep 'desikan_atlas.xlsx'];
end
clear file filterindex path

ba_loaded = ImporterBrainAtlasXLS('File', atlas_file).get('BA');

disp(['Loaded BrainAtlas: ' ba_loaded.tostring()])

%% Load CON Subject Data for group 1 from XLSX
group_1_dir = uigetdir('Select directory');
if ~isfolder(group_1_dir)
    group_1_dir = [fileparts(which('example_CON.m')) filesep 'example data CON (DTI)' filesep 'xls'  filesep 'GroupName1'];
end

gr_loaded_1 = ImporterGroupSubjectFUNXLS('DIRECTORY', group_1_dir, 'BA', ba_loaded).get('GR');

disp(['Loaded Group 1: ' gr_loaded_1.tostring()])

%% Load CON Subject Data for group 2 from XLSX
group_2_dir = uigetdir('Select directory');
if ~isfolder(group_2_dir)
    group_2_dir = [fileparts(which('example_CON.m')) filesep 'example data CON (DTI)' filesep 'xls' filesep 'GroupName2'];
end

gr_loaded_2 = ImporterGroupSubjectFUNXLS('DIRECTORY', group_2_dir, 'BA', ba_loaded).get('GR');

disp(['Loaded Group 2: ' gr_loaded_2.tostring()])