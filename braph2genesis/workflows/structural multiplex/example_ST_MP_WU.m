%EXAMPLE_ST_MP_WU
% Script example workflow ST MP WU

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('example_ST_MP_WU')) filesep 'example data ST_MP (MRI)' filesep 'desikan_atlas.xlsx']);

ba = im_ba.get('BA');

%% Load Groups of SubjectST

im_gr1 = ImporterGroupSubjectSTMPXLS( ...
    'DIRECTORY', [fileparts(which('example_ST_MP_WU')) filesep 'example data ST_MP (MRI)' filesep 'xls' filesep 'GroupName1'], ...
    'BA', ba ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectSTMPXLS( ...
    'DIRECTORY', [fileparts(which('example_ST_MP_WU')) filesep 'example data ST_MP (MRI)' filesep 'xls' filesep 'GroupName2'], ...
    'BA', ba ...
    );

gr2 = im_gr2.get('GR');