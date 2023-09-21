%% ¡header!
NNClassifierMLP_CrossValidation < NNCrossValidation (nncv, neural network cross-validation) is a process for evaluating multi-layer perceptron classifiers using cross-validation.

%%% ¡description!
A cross validation for multi-layer perceptron classifiers (NNClassifierMLP_CrossValidation) is a process that facilitates the evaluation of multi-layer perceptron classifiers using cross-validation. 
 It involves splitting a dataset into multiple subsets (folds), training the model on some folds while validating on others, and then repeating the process for all combinations of folds. 
 This helps in assessing the generalization performance of the model and detecting overfitting.

To train all the neural networks for all folds, use: nncv.get('TRAIN')

%%% ¡seealso!
NNDataPoint, NNDataset, NNEvaluator

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidation.ID
%%%% ¡title!
Cross Validation ID

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidation.LABEL
%%%% ¡title!
Cross Validation LABEL

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidation.VERBOSE
%%%% ¡title!
VERBOSE ON/OFF

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidation.PLOT_TRAINING
%%%% ¡title!
PLOT TRAINING PROGRESS

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidation.EPOCHS
%%%% ¡title!
Training EPOCHS

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidation.BATCH
%%%% ¡title!
Training BATCH SIZE

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidation.SHUFFLE
%%%% ¡title!
Training SHUFFLE

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidation.SOLVER
%%%% ¡title!
Training SOLVER

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidation.NN_TEMPLATE
%%%% ¡title!
Template for Neural Network Classifier

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidation.NNEVALUATOR_TEMPLATE
%%%% ¡title!
Template for Neural Network Evaluator

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidation.D
%%%% ¡title!
DATASET

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidation.D_LIST
%%%% ¡title!
Dataset List

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidation.NN_LIST
%%%% ¡title!
Neural Network Regressor List

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidation.EVALUATOR_LIST
%%%% ¡title!
Neural Network Evaluator List

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidation.AV_AUC
%%%% ¡title!
Average of Area Under Receiver Operating Characteristic Curve

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidation.AV_MACRO_AUC
%%%% ¡title!
Average of Macro Area Under Receiver Operating Characteristic Curve

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidation.C_MATRIX
%%%% ¡title!
Confusion Matrix

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidation.P
%%%% ¡title!
Permutation Times for Feature Importance

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_CrossValidation.AV_FEATURE_IMPORTANCE
%%%% ¡title!
Average of Feature Importance

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the cross-validation.
%%%% ¡default!
'NNClassifierMLP_CrossValidation'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the cross-validation.
%%%% ¡default!
'A cross validation for multi-layer perceptron classifiers (NNClassifierMLP_CrossValidation) is a process that facilitates the evaluation of multi-layer perceptron classifiers using cross-validation. It involves splitting a dataset into multiple subsets (folds), training the model on some folds while validating on others, and then repeating the process for all combinations of folds. This helps in assessing the generalization performance of the model and detecting overfitting.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the cross-validation.
%%%% ¡settings!
'NNClassifierMLP_CrossValidation'

%%% ¡prop!
ID (data, string) is a few-letter code for the cross-validation.
%%%% ¡default!
'NNClassifierMLP_CrossValidation ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the cross-validation.
%%%% ¡default!
'NNClassifierMLP_CrossValidation label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the cross-validation.
%%%% ¡default!
'NNClassifierMLP_CrossValidation notes'

%%% ¡prop!
NN_TEMPLATE (parameter, item) is the neural network template to set all neural network parameters.
%%%% ¡settings!
'NNClassifierMLP'

%%% ¡prop!
NNEVALUATOR_TEMPLATE (parameter, item) is the neural network evaluator template to set all evalutor parameters.
%%%% ¡settings!
'NNClassifierMLP_Evaluator'

%%% ¡prop!
NN_LIST (result, itemlist) contains the neural network models corresponding to k folds.
%%%% ¡calculate!
d_list = nncv.get('D_LIST');

if isempty(d_list)
    value = {};
else
    for i = 1:length(d_list)
        d_training_set{i} = d_list;
        d_training_set{i}(i) = [];  % Exclude the i-th element
        d_training_set{i} = NNDatasetCombine('D_LIST', d_training_set{i}).get('D');
    end
    
    d_training_set = d_training_set';
    
    if ~isa(nncv.getr('NN_TEMPLATE'), 'NoValue')
        nn_template = nncv.get('NN_TEMPLATE');
    else
        nn_template = NNClassifierMLP( ...
            'EPOCHS', nncv.get('EPOCHS'), ...
            'BATCH', nncv.get('BATCH'), ...
            'SHUFFLE', nncv.get('SHUFFLE'), ...
            'SOLVER', nncv.get('SOLVER'), ...
            'VERBOSE', nncv.get('VERBOSE'), ...
            'PLOT_TRAINING', nncv.get('PLOT_TRAINING'));
    end
    
    value = cellfun(@(d) NNClassifierMLP( ...
        'TEMPLATE', nn_template, 'D', d), ...
        d_training_set, 'UniformOutput', false);
end

%%% ¡prop!
EVALUATOR_LIST (result, itemlist) contains the evaluators corresponding to k folds.
%%%% ¡calculate!
d_list = nncv.get('D_LIST');
nn_list = nncv.get('NN_LIST');

if ~isa(nncv.getr('NNEVALUATOR_TEMPLATE'), 'NoValue')
    nne_template = nncv.get('NNEVALUATOR_TEMPLATE');
else
    nne_template = NNClassifierMLP_Evaluator( ...
        'P', nncv.get('P'));
end

value = cellfun(@(d, nn) NNClassifierMLP_Evaluator('TEMPLATE', nne_template, 'D', d, 'NN', nn), ...
    d_list, nn_list, 'UniformOutput', false);

%% ¡props!

%%% ¡prop!
P (parameter, scalar) is the permutation number.
%%%% ¡default!
1e+2
%%%% ¡check_prop!
check = value > 0 && value == round(value);

%%% ¡prop!
AV_AUC (result, rvector) provides the average value of the area under the receiver operating characteristic curve across k folds.
%%%% ¡calculate!
e_list = nncv.get('EVALUATOR_LIST');

aucs = cellfun(@(e) e.get('AUC'), ...
    e_list, 'UniformOutput', false);

if isempty(aucs)
    value = [];
else
    value = mean(cell2mat(aucs), 1);
end

%%% ¡prop!
AV_MACRO_AUC (result, scalar) provides the metric of the average macro AUC value across k folds.
%%%% ¡calculate!
e_list = nncv.get('EVALUATOR_LIST');

macro_aucs = cellfun(@(e) e.get('MACRO_AUC'), ...
    e_list, 'UniformOutput', false);

if isempty(macro_aucs)
    value = 0;
else
    value = mean(cell2mat(macro_aucs), 1);
end

%%% ¡prop!
C_MATRIX (result, matrix) provides the confusion matrix across k folds.
%%%% ¡calculate!
e_list = nncv.get('EVALUATOR_LIST');

c_matrices = cellfun(@(e) e.get('C_MATRIX'), ...
    e_list, 'UniformOutput', false);

combined_c_matrix = cellfun(@(x) double(x), c_matrices, 'UniformOutput', false);
value = sum(cat(3, combined_c_matrix{:}), 3);

%%% ¡prop!
AV_FEATURE_IMPORTANCE (result, cell) averages the feature importances across k folds.
%%%% ¡calculate!
e_list = nncv.get('EVALUATOR_LIST');

all_fi = cellfun(@(e) cell2mat(e.get('FEATURE_IMPORTANCE')), ...
    e_list, 'UniformOutput', false);

if isempty(cell2mat(all_fi))
    value = {};
else
    average_fi = zeros(size(all_fi{1}));
    for i = 1:numel(all_fi)
        % Add the current cell contents to the averageCell
        average_fi = average_fi + all_fi{i};
    end
    average_fi = average_fi / numel(all_fi);
    value = {average_fi};
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
evaluate a classifier cross-validation with the example data
%%%% ¡code!

% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'])
    test_NNDataPoint_CON_CLA % create example files
end

% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Groups of SubjectCON
im_gr1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'CON_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'CON_Group_2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

% create item lists of NNDataPoint_CON_CLA
[~, group_folder_name] = fileparts(im_gr1.get('DIRECTORY'));
it_list1 = cellfun(@(x) NNDataPoint_CON_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', {group_folder_name}), ...
    gr1.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

[~, group_folder_name] = fileparts(im_gr2.get('DIRECTORY'));
it_list2 = cellfun(@(x) NNDataPoint_CON_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', {group_folder_name}), ...
    gr2.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create NNDataPoint_CON_CLA DICT items
dp_list1 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_CON_CLA', ...
        'IT_LIST', it_list1 ...
        );

dp_list2 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_CON_CLA', ...
        'IT_LIST', it_list2 ...
        );

% create a NNDataset containing the NNDataPoint_CON_CLA DICT
d1 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_CON_CLA', ...
    'DP_DICT', dp_list1 ...
    );

d2 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_CON_CLA', ...
    'DP_DICT', dp_list2 ...
    );

kfolds = 7;
nncv = NNClassifierMLP_CrossValidation('KFOLDS', kfolds, 'D', {d1, d2});

nn_list = nncv.get('NN_LIST');
assert(length(nn_list) == kfolds, ...
    [BRAPH2.STR ':NNClassifierMLP_CrossValidation:' BRAPH2.FAIL_TEST], ...
    'NNClassifierMLP_CrossValidation does not calculate the neural network list correctly.' ...
    )
e_list = nncv.get('EVALUATOR_LIST');
assert(length(e_list) == kfolds, ...
    [BRAPH2.STR ':NNClassifierMLP_CrossValidation:' BRAPH2.FAIL_TEST], ...
    'NNClassifierMLP_CrossValidation does not calculate the evaluator list correctly.' ...
    )