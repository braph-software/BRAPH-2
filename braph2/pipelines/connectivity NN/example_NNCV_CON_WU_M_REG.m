%% EXAMPLE_NNCV_CON_WU_M_REG
% Script example pipeline for NN regression cross-validation with input of GraphWU measures derived from SubjectCON 

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectCON
im_gr = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'CON_Group_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr = im_gr.get('GR');

%% Analysis CON WU
a_WU = AnalyzeEnsemble_CON_WU( ...
    'GR', gr ...
    );

a_WU.get('MEASUREENSEMBLE', 'Degree').get('M');
a_WU.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
a_WU.get('MEASUREENSEMBLE', 'Distance').get('M');

%% Create NNData composed of corresponding NNDataPoints
% create a item list of NNDataPoint_Measure_REG
it_list = cellfun(@(g, sub) NNDataPoint_Measure_REG( ...
    'ID', sub.get('ID'), ...
    'G', g, ...
    'M_LIST', a_WU.get('ME_DICT').get('KEYS'), ...
    'SUB', sub, ...
    'TARGET_IDS', sub.get('VOI_DICT').get('KEYS')), ...
    a_WU.get('G_DICT').get('IT_LIST'), gr.get('SUB_DICT').get('IT_LIST'),...
    'UniformOutput', false);

% create a NNDataPoint_Measure_REG DICT
dp_dict = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_Measure_REG', ...
        'IT_LIST', it_list ...
        );

% create a NNData containing the NNDataPoint_CON_REG DICT
d = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Measure_REG', ...
    'DP_DICT', dp_dict ...
    );

%% Create a regressor cross-validation
nne_template = NNRegressorMLP_Evaluator('P', 2);
nncv = NNRegressorMLP_CrossValidation('D', {d}, 'KFOLDS', 5, 'NNEVALUATOR_TEMPLATE', nne_template);
nncv.get('TRAIN');

%% Evaluate the performance
av_corr_coeff = nncv.get('AV_CORR');
av_coeff_determination = nncv.get('AV_DET');
av_mae = nncv.get('AV_MAE');
av_mse = nncv.get('AV_MSE');
av_rmse = nncv.get('AV_RMSE');