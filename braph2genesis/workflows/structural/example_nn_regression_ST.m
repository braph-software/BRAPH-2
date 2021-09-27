%EXAMPLE_NN_REGRESSION
% Script example workflow 

clear variables %#ok<*NASGU>


%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'desikan_atlas.xlsx']);

ba = im_ba.get('BA');

%% Load Groups of SubjectST
im_gr1 = ImporterGroupSubjectSTXLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group1.xlsx'], ...
    'BA', ba ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectSTXLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group2.xlsx'], ...
    'BA', ba ...
    );

gr2 = im_gr2.get('GR');

%% Neural network
nn_regressor_ST = RegressorNN_ST( ...
    'GR1', gr1, ...
    'GR2', gr2 ...
    );

% nn result calculation
nn_regressor_ST.memorize('NEURAL_NETWORK_ANALYSIS');
test_mse = nn_regressor_ST.get('TEST_RMSE');
train_mse = nn_regressor_ST.get('TRAINING_RMSE');