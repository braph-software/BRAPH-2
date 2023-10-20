%% ¡header!
NNClassifierMLP_Evaluator < NNEvaluator (nne, neural network evaluator for classification) evaluates the performance of a multi-layer perceptron classifier with a given dataset.

%%% ¡description!
A neural network evaluator for multi-layer perceptron classifier (NNClassifierMLP_Evaluator) evaluates the performance of a multi-layer perceptron classifier with a given dataset.
NNClassifierMLP_Evaluator evaluates the performance of the trained classifier with a given dataset in terms of various classification metrics (e.g., confusion matrix, area under the receiver operating characteristic curve).

%%% ¡seealso!
NNDataPoint_CON_CLA, NNClassifierMLP

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_Evaluator.ID
%%%% ¡title!
Cross Validation ID

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_Evaluator.LABEL
%%%% ¡title!
Cross Validation LABEL

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_Evaluator.AUC
%%%% ¡title!
Area Under Receiver Operating Characteristic Curve

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_Evaluator.PFROC
%%%% ¡title!
Plot Receiver Operating Characteristic Curve

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_Evaluator.MACRO_AUC
%%%% ¡title!
Macro Area Under Receiver Operating Characteristic Curve

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_Evaluator.C_MATRIX
%%%% ¡title!
Confusion Matrix

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_Evaluator.P
%%%% ¡title!
Permutation Times for Feature Importance

%%% ¡prop!
%%%% ¡id!
NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE
%%%% ¡title!
Feature Importance

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the neural network evaluator.
%%%% ¡default!
'NNClassifierMLP_Evaluator'

%%% ¡prop!
NAME (constant, string) is the name of the neural network evaluator for the classification task.
%%%% ¡default!
'NNClassifierMLP_Evaluator'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the neural network evaluator for the classification task.
%%%% ¡default!
'A neural network evaluator for multi-layer perceptron classifier (NNClassifierMLP_Evaluator) evaluates the performance of a multi-layer perceptron classifier with a given dataset. NNClassifierMLP_Evaluator evaluates the performance of the trained classifier with a given dataset in terms of various classification metrics (e.g., confusion matrix, area under the receiver operating characteristic curve).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the neural network evaluator for the classification task.
%%%% ¡settings!
'NNClassifierMLP_Evaluator'

%%% ¡prop!
ID (data, string) is a few-letter code for the neural network evaluator for the classification task.
%%%% ¡default!
'NNClassifierMLP_Evaluator ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the neural network evaluator for the classification task.
%%%% ¡default!
'NNClassifierMLP_Evaluator label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the neural network evaluator for the classification task.
%%%% ¡default!
'NNClassifierMLP_Evaluator notes'
    
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
PFROC (gui, item) contains the panel figure of the ROC plot for classification model.
%%%% ¡settings!
'NNClassifierMLP_EvaluatorPF_ROC'
%%%% ¡postprocessing!
if isa(nne.getr('PFROC'), 'NoValue')
    nne.set('PFROC', NNClassifierMLP_EvaluatorPF_ROC('NNE', nne));
end
%%%% ¡gui!
pr = PanelPropItem('EL', nne, 'PROP', NNClassifierMLP_Evaluator.PFROC, ...
    'GUICLASS', 'GUIFig', ...
	'BUTTON_TEXT', ['ROC Plot'], ...
    varargin{:});

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
[~, maxIndices] = max(predictions, [], 2);
predictions = logical(full(sparse(1:numel(maxIndices), maxIndices, 1, size(predictions, 1), size(predictions, 2))));
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
P (parameter, scalar) is the permutation number.
%%%% ¡default!
1e+2
%%%% ¡check_prop!
check = value > 0 && value == round(value);

%%% ¡prop!
PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
%%%% ¡calculate!
value = randi(intmax('uint32'), 1, nne.get('P'));

%%% ¡prop!
FEATURE_IMPORTANCE (result, cell) quantifies the average significance and impact of individual input features within neural network models. Various techniques, such as permutation feature importance for MLPs and gradient-based analysis for CNNs, can be applied to quantify this aspect.
%%%% ¡calculate!
all_fi = nne.get('NN').get('FEATURE_IMPORTANCE', nne.get('D'), nne.get('P'), nne.get('PERM_SEEDS'));
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
%%%% ¡gui!
input_dataset = nne.get('D');
dp_class = input_dataset.get('DP_CLASS');
graph_dp_classes = {NNDataPoint_Graph_CLA().get('NAME'), NNDataPoint_Graph_REG().get('NAME')};
measure_dp_classes = {NNDataPoint_Measure_CLA().get('NAME'), NNDataPoint_Measure_REG().get('NAME')};

if any(strcmp(dp_class, graph_dp_classes)) % GRAPH input
    pr = NNxMLP_xPP_FI_Graph('EL', nne, 'D', input_dataset, 'PROP', NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE, varargin{:});
elseif any(strcmp(dp_class, measure_dp_classes))% MEASURE input
    pr = NNxMLP_xPP_FI_Measure('EL', nne, 'D', input_dataset, 'PROP', NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE, varargin{:});
else % DATA input
    pr = NNxMLP_xPP_FI_Data('EL', nne, 'D', input_dataset, 'PROP', NNClassifierMLP_Evaluator.FEATURE_IMPORTANCE, varargin{:});
end

%% ¡tests!

%%% ¡excluded_props!
[NNClassifierMLP_Evaluator.PFROC]

%%% ¡test!
%%%% ¡name!
Evaluate a classifier with the example data
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
nne = NNClassifierMLP_Evaluator('NN', nn, 'D', d);

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