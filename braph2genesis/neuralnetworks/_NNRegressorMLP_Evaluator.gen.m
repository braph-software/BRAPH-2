%% ¡header!
NNRegressorMLP_Evaluator < NNEvaluator (nne, neural network evaluator for regressor) evaluates the performance of a multi-layer perceptron regressor with a given dataset.

%%% ¡description!
A neural network evaluator for regressor (NNRegressorMLP_Evaluator) evaluates the performance of a multi-layer perceptron regressor with a given dataset.
NNRegressorMLP_Evaluator evaluates the performance of the trained regressor with a given dataset in terms of various regression metrics (e.g., coefficient of determination, mean squared error).

%%% ¡seealso!
NNDataPoint_CON_REG, NNRegressorMLP

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the neural network evaluator for the regression task.
%%%% ¡default!
'NNRegressorMLP_Evaluator'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the neural network evaluator for the regression task.
%%%% ¡default!
'A neural network evaluator for regressor (NNRegressorMLP_Evaluator) evaluates the performance of a multi-layer perceptron regressor with a given dataset. NNRegressorMLP_Evaluator evaluates the performance of the trained regressor with a given dataset in terms of various regression metrics (e.g., coefficient of determination, mean squared error).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the neural network evaluator for the regression task.
%%%% ¡settings!
'NNRegressorMLP_Evaluator'

%%% ¡prop!
ID (data, string) is a few-letter code for the neural network evaluator for the regression task.
%%%% ¡default!
'NNRegressorMLP_Evaluator ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the neural network evaluator for the regression task.
%%%% ¡default!
'NNRegressorMLP_Evaluator label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the neural network evaluator for the regression task.
%%%% ¡default!
'NNRegressorMLP_Evaluator notes'
    
%%% ¡prop!
NN (data, item) contains a trained neural network regressor.
%%%% ¡settings!
'NNRegressorMLP'

%% ¡props!

%%% ¡prop!
GROUND_TRUTH (query, matrix) returns the matrix of ground truth derived from the targets.
%%%% ¡calculate!
targets = nne.get('D').get('TARGETS');
if isempty(targets)
    value = [];
else
    for i = 1:length(targets)
        value(i, :) = cell2mat(targets{i});
    end
end

%%% ¡prop!
CORR (result, rvector) provides the metric of the correlation of coefficients.
%%%% ¡calculate!
predictions = nne.get('NN').get('PREDICT', nne.get('D'));
if isempty(predictions)
    value = [];
else
    predictions = cell2mat(predictions);
    ground_truth = nne.get('GROUND_TRUTH');
    num_dp = size(ground_truth, 1);
    num_target = size(ground_truth, 2);
    for i = 1:num_target
        corr_matrix = corrcoef(predictions(:, i), ground_truth(:, i));
        value(i) = corr_matrix(1, 2);
    end
end

%%% ¡prop!
DET (result, rvector) provides the coefficient of determination, a measure showing how well the predictions are replicated by the model.
%%%% ¡calculate!
predictions = nne.get('NN').get('PREDICT', nne.get('D'));
if isempty(predictions)
    value = [];
else
    predictions = cell2mat(predictions);
    ground_truth = nne.get('GROUND_TRUTH');
    num_dp = size(ground_truth, 1);
    num_target = size(ground_truth, 2);
    for i = 1:num_target
        corr_matrix = corrcoef(predictions(:, i), ground_truth(:, i));
        value(i) = corr_matrix(1, 2)^2;
    end
end

%%% ¡prop!
MAE (result, rvector) provides the metric of the mean absolute error.
%%%% ¡calculate!
predictions = nne.get('NN').get('PREDICT', nne.get('D'));
if isempty(predictions)
    value = [];
else
    predictions = cell2mat(predictions);
    ground_truth = nne.get('GROUND_TRUTH');
    num_dp = size(ground_truth, 1);
    num_target = size(ground_truth, 2);
    for i = 1:num_target
        value(i) = mean(abs(predictions(:, i) - ground_truth(:, i)));
    end
end

%%% ¡prop!
MSE (result, rvector) provides the metric of the mean squared error.
%%%% ¡calculate!
predictions = nne.get('NN').get('PREDICT', nne.get('D'));
if isempty(predictions)
    value = [];
else
    predictions = cell2mat(predictions);
    ground_truth = nne.get('GROUND_TRUTH');
    num_dp = size(ground_truth, 1);
    num_target = size(ground_truth, 2);
    for i = 1:num_target
        value(i) = mean((predictions(:, i) - ground_truth(:, i)).^2);
    end
end

%%% ¡prop!
RMSE (result, rvector) provides the metric of the root mean squared error.
%%%% ¡calculate!
predictions = nne.get('NN').get('PREDICT', nne.get('D'));
if isempty(predictions)
    value = [];
else
    predictions = cell2mat(predictions);
    ground_truth = nne.get('GROUND_TRUTH');
    num_dp = size(ground_truth, 1);
    num_target = size(ground_truth, 2);
    for i = 1:num_target
        value(i) = sqrt(mean((predictions(:, i) - ground_truth(:, i)).^2));
    end
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

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Evaluate a regressor with the example data
%%%% ¡code!

% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'])
    test_NNDataPoint_CON_REG % create example files
end

% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Groups of SubjectCON
im_gr = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'CON_Group_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr = im_gr.get('GR');

% create a item list of NNDataPoint_CON_REG
it_list = cellfun(@(x) NNDataPoint_CON_REG( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', x.get('VOI_DICT').get('KEYS')), ...
    gr.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create a NNDataPoint_CON_REG DICT
dp_list = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_CON_REG', ...
        'IT_LIST', it_list ...
        );

% create a NNData containing the NNDataPoint_CON_REG DICT
d = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_CON_REG', ...
    'DP_DICT', dp_list ...
    );

nn = NNRegressorMLP('D', d, 'LAYERS', [20 20]);
nn.get('TRAIN');
nne = NNRegressorMLP_Evaluator('NN', nn, 'D', d);
predictions = cell2mat(nn.get('PREDICT', d));

% Check whether the ground truth are derived as expected
ground_truth = nne.get('GROUND_TRUTH');
targets = d.get('TARGETS');

for i = 1:size(ground_truth, 1)
    check(i) = isequal(cell2mat(targets{i}), ground_truth(i, :));
end
assert(all(check), ...
    [BRAPH2.STR ':NNRegressorMLP_Evaluator:' BRAPH2.FAIL_TEST], ...
    'NNRegressorMLP_Evaluator does not calculate the ground truth correctly.' ...
    )

% Check whether the correlation coefficients are calculated as expected
calculated_value = nne.get('CORR');
for i = 1:size(ground_truth, 2)
    corr_matrix = corrcoef(predictions(:, i), ground_truth(:, i));
    known_value(i) = corr_matrix(1, 2);
end
assert(isequal(calculated_value, known_value), ...
    [BRAPH2.STR ':NNRegressorMLP_Evaluator:' BRAPH2.FAIL_TEST], ...
    'NNRegressorMLP_Evaluator does not calculate the correlation coefficients correctly.' ...
    )

% Check whether the correlation of determination are calculated as expected
calculated_value = nne.get('DET');
for i = 1:size(ground_truth, 2)
    corr_matrix = corrcoef(predictions(:, i), ground_truth(:, i));
    known_value(i) = corr_matrix(1, 2)^2;
end
assert(isequal(calculated_value, known_value), ...
    [BRAPH2.STR ':NNRegressorMLP_Evaluator:' BRAPH2.FAIL_TEST], ...
    'NNRegressorMLP_Evaluator does not calculate the coefficient of determination correctly.' ...
    )

% Check whether the mean absolute errors are calculated as expected
calculated_value = nne.get('MAE');
for i = 1:size(ground_truth, 2)
    known_value(i) = mean(abs(predictions(:, i) - ground_truth(:, i)));
end
assert(isequal(calculated_value, known_value), ...
    [BRAPH2.STR ':NNRegressorMLP_Evaluator:' BRAPH2.FAIL_TEST], ...
    'NNRegressorMLP_Evaluator does not calculate the mean absolute errors correctly.' ...
    )

% Check whether the mean squared errors are calculated as expected
calculated_value = nne.get('MSE');
for i = 1:size(ground_truth, 2)
    known_value(i) = mean((predictions(:, i) - ground_truth(:, i)).^2);
end
assert(isequal(calculated_value, known_value), ...
    [BRAPH2.STR ':NNRegressorMLP_Evaluator:' BRAPH2.FAIL_TEST], ...
    'NNRegressorMLP_Evaluator does not calculate the mean squared errors correctly.' ...
    )

% Check whether the mean squared errors are calculated as expected
calculated_value = nne.get('RMSE');
for i = 1:size(ground_truth, 2)
    known_value(i) = sqrt(mean((predictions(:, i) - ground_truth(:, i)).^2));
end
assert(isequal(calculated_value, known_value), ...
    [BRAPH2.STR ':NNRegressorMLP_Evaluator:' BRAPH2.FAIL_TEST], ...
    'NNRegressorMLP_Evaluator does not calculate the root mean squared errors correctly.' ...
    )