%EXAMPLE_NNCV_FUN_BUD_CLASSIFICATION_GRAPHMEASURES
% Script example pipeline for NN classification with the input of graph
% measures


clear variables %#ok<*NASGU>

%% Load brain atlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('example_NN_FUN_WU_Classification_AdjacencyMatrix')) filesep 'example data FUN (fMRI)' filesep 'classification' filesep 'aal90_atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load groups of SubjectFUN
im_gr1 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('example_NN_FUN_WU_Classification_AdjacencyMatrix')) filesep 'example data FUN (fMRI)' filesep 'classification' filesep 'xls' filesep 'GroupName1'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY',  [fileparts(which('example_NN_FUN_WU_Classification_AdjacencyMatrix')) filesep 'example data FUN (fMRI)' filesep 'classification' filesep 'xls' filesep 'GroupName2'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Construct the dataset
nnd1 = NNData_FUN_BUD( ...
    'GR', gr1, ...
    'INPUT_TYPE', 'graph_measures', ...
    'DENSITIES', [50 100], ...
    'TARGET_NAME', gr1.get('ID') ...
    );

nnd1.getMeasureEnsemble('Degree');
nnd1.getMeasureEnsemble('Diameter', 'Rule', 'subgraphs');
gr1_nn = nnd1.get('GR_NN');

nnd2 = NNData_FUN_BUD( ...
    'GR', gr2, ...
    'INPUT_TYPE', 'graph_measures', ...
    'TEMPLATE', nnd1, ...
    'TARGET_NAME', gr2.get('ID') ...
    );

gr2_nn = nnd2.get('GR_NN');

%% Initiate the cross validation analysis
nncv = NNClassifierCrossValidation( ...
    'GR1', gr1_nn, ...
    'GR2', gr2_nn, ...
    'KFOLD', 5 ...
    );

%% Evaluate the Performance
gr_cv = nncv.get('GR_PREDICTION');
auc_test = nncv.get('AUC');
cm_test = nncv.get('CONFUSION_MATRIX');

close all