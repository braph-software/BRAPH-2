%EXAMPLE_ST
% Script example workflow ST

clear

%% Load BrainAtlas
[file, path, filterindex] = uigetfile('*.xlsx');
if filterindex
    atlas_file = fullfile(path, file);
else
    atlas_file = [fileparts(which('example_ST.m')) filesep 'example data ST (MRI)' filesep 'desikan_atlas.xlsx'];
end
clear file filterindex path

ba_loaded = ImporterBrainAtlasXLS('FILE', atlas_file).get('BA');

disp(['Loaded BrainAtlas: ' ba_loaded.tostring()])

%% Load ST Subject Data for group 1 from XLSX
[file, path, filterindex] = uigetfile('.xlsx');
if filterindex
    group_1_file = fullfile(path, file);
else
    group_1_file = [fileparts(which('example_ST.m')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group1.xlsx'];
end
clear file path filterindex;

gr_loaded_1 = ImporterGroupSubjectSTXLS('FILE', group_1_file, 'BA', ba_loaded).get('GR');

disp(['Loaded Group 1: ' gr_loaded_1.tostring()])

%% Load ST Subject Data for group 2 from XLSX
[file, path, filterindex] = uigetfile('.xlsx');
if filterindex
    group_2_file = fullfile(path, file);    
else    
    group_2_file = [fileparts(which('example_ST.m')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group2.xlsx'];
end
clear file path filterindex;

gr_loaded_2 = ImporterGroupSubjectSTXLS('FILE', group_2_file, 'BA', ba_loaded).get('GR');

disp(['Loaded Group 2: ' gr_loaded_2.tostring()])