%% EXAMPLE_NN_FUN_REG
% Script example pipeline for NN regression with the input of SubjectFUN 

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_FUN_REG')) filesep 'Example data NN REG FUN XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectFUN
im_gr = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_FUN_REG')) filesep 'Example data NN REG FUN XLS' filesep 'FUN_Group_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr = im_gr.get('GR');

%% Create NNData composed of corresponding NNDataPoints
% create a item list of NNDataPoint_FUN_REG
it_list = cellfun(@(x) NNDataPoint_FUN_REG( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', x.get('VOI_DICT').get('KEYS')), ...
    gr.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create a NNDataPoint_FUN_REG DICT
dp_dict = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_FUN_REG', ...
        'IT_LIST', it_list ...
        );

% create a NNData containing the NNDataPoint_FUN_REG DICT
d = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_FUN_REG', ...
    'DP_DICT', dp_dict ...
    );

%% Split the NNData into training set and test set
d_split = NNDatasetSplit('D', d, 'SPLIT', {0.7, 0.3});
d_training = d_split.get('D_LIST_IT', 1);
d_test = d_split.get('D_LIST_IT', 2);

%% Create a MLP regressor with training set
nn = NNRegressorMLP('D', d_training, 'LAYERS', [20 20]);
nn.get('TRAIN');

%% Evaluate the regressor with the test set
nne_test = NNRegressorMLP_Evaluator('D', d_test, 'NN', nn, 'P', 1);
corr_coeff = nne_test.get('CORR');
coeff_determination = nne_test.get('DET');
mae = nne_test.get('MAE');
mse = nne_test.get('MSE');
rmse = nne_test.get('RMSE');
%fi = nne_test.get('FEATURE_IMPORTANCE'); %% uncomment this when the
% feature importance element is ready