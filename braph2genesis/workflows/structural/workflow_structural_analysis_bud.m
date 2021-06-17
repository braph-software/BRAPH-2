% Workflow Structural Analysis BUD

% ID - Workflow of Structural Analysis BUD

% This is the workflow script to create an analysis of a group of subjects
% with structural data and a binary undirected graph using densities.
% Brain Atlas is set to Desikan Atlas example BrainAtlas. 
% Group is set to example group. Modify the path of the files to your needs.

%% BrainAtlas
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('example_ST_BUD')) filesep 'example data ST (MRI)' filesep 'desikan_atlas.xlsx']);

ba = im_ba.get('BA');

%% Groups
%%% XLS
im_gr = ImporterGroupSubjectSTXLS( ...
    'FILE', [fileparts(which('example_ST_BUD')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group1.xlsx'], ...
    'BA', ba ...
    );

gr = im_gr.get('GR');

%% Analysis
%%% BUD
densities = [0 20 40 60 80 100];
a_BUD = AnalyzeGroup_ST_BUD('GR', gr, 'DENSITIES', densities);


