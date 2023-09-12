%% ¡header!
NNClassifier_Evaluator < NNEvaluator (nne, neural network evaluator for classification) evaluates the performance of a neural network classifier with a given dataset.

%%% ¡description!
A neural network evaluator for classifier (NNClassifier_Evaluator) evaluates the performance of a neural network classifier with a given dataset.
NNClassifier_Evaluator evaluates the performance of the trained classifier with a given dataset in terms of various classification metrics (e.g., confusion matrix, area under the receiver operating characteristic curve).

%%% ¡seealso!
NNDataPoint_CON_CLA, NNClassifierMLP

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the neural network evaluator for the classification task.
%%%% ¡default!
'NNClassifier_Evaluator'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the neural network evaluator for the classification task.
%%%% ¡default!
'A neural network evaluator for classifier (NNClassifier_Evaluator) evaluates the performance of a neural network classifier with a given dataset. NNClassifier_Evaluator evaluates the performance of the trained classifier with a given dataset in terms of various classification metrics (e.g., confusion matrix, area under the receiver operating characteristic curve).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the neural network evaluator for the classification task.
%%%% ¡settings!
'NNClassifier_Evaluator'

%%% ¡prop!
ID (data, string) is a few-letter code for the neural network evaluator for the classification task.
%%%% ¡default!
'NNClassifier_Evaluator ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the neural network evaluator for the classification task.
%%%% ¡default!
'NNClassifier_Evaluator label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the neural network evaluator for the classification task.
%%%% ¡default!
'NNClassifier_Evaluator notes'
    
%%% ¡prop!
NN (data, item) contains a trained neural network classifier.
%%%% ¡settings!
'NNClassifierMLP'

%% ¡props!

%%% ¡prop!
GROUND_TRUTH (query, stringlist) returns the matrix of ground truth derived from the targets.
%%%% ¡calculate!
targets = nne.get('D').get('TARGETS');
if isempty(targets)
    value = {''};
else
    for i = 1:length(targets)
        value(i, :) = targets{i};
    end
end

%%% ¡prop!
AUC (result, rvector) provides the value of the area under the receiver operating characteristic curve.
%%%% ¡calculate!
predictions = cell2mat(nne.get('NN').get('PREDICT', nne.get('D')));
if isempty(predictions)
    value = [];
else
    class_names = nne.get('NN').get('MODEL').Layers(end).Classes;
    ground_truth = categorical(nne.get('GROUND_TRUTH'));
    rocNet = rocmetrics(ground_truth, predictions, class_names);
    value = rocNet.AUC;
end

%%% ¡prop!
MACRO_AUC (result, scalar) provides the metric of the average AUC value.
%%%% ¡calculate!
auc = nne.get('AUC');
if isempty(auc)
    value = 0;
else
    value = double(mean(auc));
end

%%% ¡prop!
C_MATRIX (result, matrix) provides the confusion matrix.
%%%% ¡calculate!
predictions = cell2mat(nne.get('NN').get('PREDICT', nne.get('D')));
predictions = bsxfun(@eq, predictions, max(predictions, [], 2));
if isempty(predictions)
    value = [];
else
    classNames = nne.get('NN').get('MODEL').Layers(end).Classes;
    for i = 1:length(predictions)
        classified(i) = classNames(predictions(i, :));
    end
    ground_truth = categorical(nne.get('GROUND_TRUTH'));
    value = confusionmat(classified, ground_truth);
end

%%% ¡prop!
FEATURE_IMPORTANCE (result, cell) quantifies the average significance and impact of individual input features within neural network models. Various techniques, such as permutation feature importance for MLPs and gradient-based analysis for CNNs, can be applied to quantify this aspect.
%%%% ¡calculate!
all_fi = nne.get('NN').get('FEATURE_IMPORTANCE', nne.get('D'));
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
evaluate a classifier with the example data
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

% combine the two datasets
d = NNDatasetCombine('D_LIST', {d1, d2}).get('D');

nn = NNClassifierMLP('D', d, 'LAYERS', [10 10 10]);
nn.get('TRAIN');
nne = NNClassifier_Evaluator('NN', nn, 'D', d);

% Check whether the ground truth are derived as expected
ground_truth = nne.get('GROUND_TRUTH');
targets = d.get('TARGETS');

for i = 1:size(ground_truth, 1)
    check(i) = isequal(targets{i}, ground_truth(i, :));
end
assert(all(check), ...
    [BRAPH2.STR ':NNEvaluator_CLA:' BRAPH2.FAIL_TEST], ...
    'NNEvaluator_CLA does not calculate the ground truth correctly.' ...
    )

% Check whether the number of predictions are the same as the input datapoints
predictions = cell2mat(nne.get('NN').get('PREDICT', nne.get('D')));
num_predictions = length(predictions);
num_datapoints = nne.get('D').get('DP_DICT').get('LENGTH');
assert(isequal(num_predictions, num_datapoints), ...
    [BRAPH2.STR ':NNEvaluator_CLA:' BRAPH2.FAIL_TEST], ...
    'NNEvaluator_CLA does not calculate the predictions correctly.' ...
    )

% Check whether the dimension of the confusion matrix matches with the number of classes
c_matrix = nne.get('C_MATRIX');
dim_c = size(c_matrix, 1);
num_classes = numel(nne.get('NN').get('MODEL').Layers(end).Classes);
assert(isequal(dim_c, num_classes), ...
    [BRAPH2.STR ':NNEvaluator_CLA:' BRAPH2.FAIL_TEST], ...
    'NNEvaluator_CLA does not calculate the confusion matrix correctly.' ...
    )

% Check whether the dimension of the AUC matches with the number of classes
auc = nne.get('AUC');
dim_auc = length(auc);
num_classes = numel(nne.get('NN').get('MODEL').Layers(end).Classes);
assert(isequal(dim_auc, num_classes), ...
    [BRAPH2.STR ':NNEvaluator_CLA:' BRAPH2.FAIL_TEST], ...
    'NNEvaluator_CLA does not calculate the confusion matrix correctly.' ...
    )