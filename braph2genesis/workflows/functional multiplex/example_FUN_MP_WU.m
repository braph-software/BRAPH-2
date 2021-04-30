%EXAMPLE_FUN_MP_WU
% Script example workflow FUN_MP WU

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('example_FUN_WU')) filesep 'example data FUN (fMRI)' filesep 'desikan_atlas.xlsx']);

ba = im_ba.get('BA');