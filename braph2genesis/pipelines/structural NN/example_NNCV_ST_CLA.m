%% EXAMPLE_NN_ST_CLA
% Script example pipeline for NN classification with the input of SubjectST 

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_ST_CLA')) filesep 'Example data NN CLA ST XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectST
im_gr1 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('NNDataPoint_ST_CLA')) filesep 'Example data NN CLA ST XLS' filesep 'ST_Group_1.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('NNDataPoint_ST_CLA')) filesep 'Example data NN CLA ST XLS' filesep 'ST_Group_2.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

im_gr3 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('NNDataPoint_ST_CLA')) filesep 'Example data NN CLA ST XLS' filesep 'ST_Group_3.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr3 = im_gr3.get('GR');

%% Training-test split
% create item lists of NNDataPoint_ST_CLA
it_list1 = cellfun(@(x) NNDataPoint_ST_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', {gr1.get('ID')}), ...
    gr1.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

it_list2 = cellfun(@(x) NNDataPoint_ST_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', {gr2.get('ID')}), ...
    gr2.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

it_list3 = cellfun(@(x) NNDataPoint_ST_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', {gr3.get('ID')}), ...
    gr3.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create NNDataPoint_ST_CLA DICT items
dp_list1 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_ST_CLA', ...
        'IT_LIST', it_list1 ...
        );

dp_list2 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_ST_CLA', ...
        'IT_LIST', it_list2 ...
        );

dp_list3 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_ST_CLA', ...
        'IT_LIST', it_list3 ...
        );

% create a NNDataset containing the NNDataPoint_ST_CLA DICT
d1 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_ST_CLA', ...
    'DP_DICT', dp_list1 ...
    );

d2 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_ST_CLA', ...
    'DP_DICT', dp_list2 ...
    );

d3 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_ST_CLA', ...
    'DP_DICT', dp_list3 ...
    );

%% Create a classifier cross-validation
nne_template = NNClassifierMLP_Evaluator('P', 2);
nncv = NNClassifierMLP_CrossValidation('D', {d1, d2, d3}, 'KFOLDS', 2, 'NNEVALUATOR_TEMPLATE', nne_template);
nncv.get('TRAIN');

%% Evaluate the performance
confusion_matrix = nncv.get('C_MATRIX');
av_auc = nncv.get('AV_AUC');
av_macro_auc = nncv.get('AV_MACRO_AUC');
% av_fi = nncv.get('AV_FEATURE_IMPORTANCE'); % % % uncomment this when the feature importance element is ready
