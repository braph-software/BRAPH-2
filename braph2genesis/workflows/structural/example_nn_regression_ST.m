%EXAMPLE_NN_REGRESSION
% Script example workflow 

clear variables %#ok<*NASGU>


%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'desikan_atlas.xlsx']);

ba = im_ba.get('BA');

%% Load Groups of SubjectST
im_gr = ImporterGroupSubjectSTXLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group1.xlsx'], ...
    'BA', ba ...
    );

gr = im_gr.get('GR');

%% Neural network
nn_regressor_ST = RegressorNN_ST( ...
    'GR', gr ...
    );


% nn result calculation
nn_regressor_ST.memorize('NEURAL_NETWORK_ANALYSIS');
test_mse = nn_regressor_ST.get('TEST_RMSE');
train_mse = nn_regressor_ST.get('TRAINING_RMSE');

% save the training progress figure
currentfig = findall(groot, 'Tag', 'NNET_CNN_TRAININGPLOT_UIFIGURE');
savefig(currentfig, [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'regression_training_progress.fig'])