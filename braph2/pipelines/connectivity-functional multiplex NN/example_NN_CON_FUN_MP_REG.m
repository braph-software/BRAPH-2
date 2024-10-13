%% EXAMPLE_NN_CON_FUN_MP_REG
% Script example pipeline for NN regression with the input of SubjectCON_FUN_MP 

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_CON_FUN_MP_REG')) filesep 'Example data NN REG CON_FUN_MP XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectCON
im_gr = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_REG')) filesep 'Example data NN REG CON_FUN_MP XLS' filesep 'Connectivity' filesep 'CON_FUN_MP_Group_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr_CON = im_gr.get('GR');

%% Load Groups of SubjectFUN
im_gr = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_FUN_MP_REG')) filesep 'Example data NN REG CON_FUN_MP XLS' filesep 'Functional' filesep 'CON_FUN_MP_Group_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr_FUN = im_gr.get('GR');

%% Combine Groups of SubjectCON with Groups of SubjectFUN
co_gr = CombineGroups_CON_FUN_MP( ...
    'GR_CON', gr_CON, ...
    'GR_FUN', gr_FUN, ...
    'WAITBAR', true ...
    );

gr = co_gr.get('GR_CON_FUN_MP');

%% Create NNData composed of corresponding NNDataPoints
% create a item list of NNDataPoint_CON_FUN_MP_REG
it_list = cellfun(@(x) NNDataPoint_CON_FUN_MP_REG( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', x.get('VOI_DICT').get('KEYS')), ...
    gr.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create a NNDataPoint_CON_REG DICT
dp_dict = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_CON_FUN_MP_REG', ...
        'IT_LIST', it_list ...
        );

% create a NNData containing the NNDataPoint_CON_FUN_MP_REG DICT
d = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_CON_FUN_MP_REG', ...
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
nne_test = NNRegressorMLP_Evaluator('D', d_test, 'NN', nn);
corr_coeff = nne_test.get('CORR');
coeff_determination = nne_test.get('DET');
mae = nne_test.get('MAE');
mse = nne_test.get('MSE');
rmse = nne_test.get('RMSE');