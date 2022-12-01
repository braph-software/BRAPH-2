%EXAMPLE_ST_WU
% Script example pipeline ST WU

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'destrieux_atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectST
im_gr1 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group1.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group2.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Analysis ST WU
a_raw_data1 = AnalyzeGroup_ST_RawData('GR', gr1);
a_raw_data2 = AnalyzeGroup_ST_RawData('GR', gr2);

% measure calculation
g_WU1 = a_raw_data1.get('G');
raw_data_WU1 = g_WU1.getMeasure('RawData').get('M');
mean_raw_data_1 = a_raw_data1.get('AVERAGE');
std_raw_data_1 = a_raw_data1.get('STD');

g_WU2 = a_raw_data2.get('G');
raw_data_WU2 = g_WU2.getMeasure('RawData').get('M');
mean_raw_data_2 = a_raw_data2.get('AVERAGE');
std_raw_data_2 = a_raw_data2.get('STD');

% comparison
c_WU = CompareGroup( ...
    'P', 10, ...
    'A1', a_raw_data1, ...
    'A2', a_raw_data2, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );

raw_data_WU_diff = c_WU.getComparison('RawData').get('DIFF');
raw_data_WU_p1 = c_WU.getComparison('RawData').get('P1');
raw_data_WU_p2 = c_WU.getComparison('RawData').get('P2');
raw_data_WU_cil = c_WU.getComparison('RawData').get('CIL');
raw_data_WU_ciu = c_WU.getComparison('RawData').get('CIU');