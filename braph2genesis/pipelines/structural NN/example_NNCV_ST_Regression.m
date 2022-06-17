%EXAMPLE_NNCV_ST_REGRESSION
% Script example pipeline for NN cross-validation for regression with the input of ROI values

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('example_NNCV_ST_Regression')) filesep 'example data ST (MRI)' filesep 'desikan_atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Group of SubjectST
im_gr = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('example_NNCV_ST_Regression')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group1.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr = im_gr.get('GR');

%% Construct the dataset
nnd = NNData_ST( ...
    'GR', gr, ...
    'INPUT_TYPE', 'structural_data', ...
    'TARGET_NAME', 'age' ...
    );

gr_nn = nnd.get('GR_NN');

%% Initiate the cross validation analysis
nncv = NNRegressorCrossValidation( ...
    'GR', gr_nn, ...
    'KFOLD', 5, ...
    'REPETITION', 1, ...
    'FEATURE_MASK', 0.05 ...
    );

%% Evaluate the Performance
gr_cv = nncv.get('GR_PREDICTION');
rmse_cv = nncv.get('RMSE');

close all