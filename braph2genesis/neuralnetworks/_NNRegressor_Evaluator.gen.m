%% ¡header!
NNRegressor_Evaluator < NNEvaluator (nne, neural network evaluator for regressor) evaluates the performance of a neural network regressor with a given dataset.

%%% ¡description!
A neural network evaluator for regressor (NNRegressor_Evaluator) evaluates the performance of a neural network regressor with a given dataset.
NNRegressor_Evaluator evaluates the performance of the trained regressor with a given dataset in terms of various regression metrics (e.g., coefficient of determination, mean squared error).

%%% ¡seealso!
NNDataPoint_CON_REG, NNRegressorMLP

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the neural network evaluator for the regression task.
%%%% ¡default!
'NNRegressor_Evaluator'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the neural network evaluator for the regression task.
%%%% ¡default!
'A neural network evaluator for regressor (NNRegressor_Evaluator) evaluates the performance of a neural network regressor with a given dataset. NNRegressor_Evaluator evaluates the performance of the trained regressor with a given dataset in terms of various regression metrics (e.g., coefficient of determination, mean squared error).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the neural network evaluator for the regression task.
%%%% ¡settings!
'NNRegressor_Evaluator'

%%% ¡prop!
ID (data, string) is a few-letter code for the neural network evaluator for the regression task.
%%%% ¡default!
'NNRegressor_Evaluator ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the neural network evaluator for the regression task.
%%%% ¡default!
'NNRegressor_Evaluator label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the neural network evaluator for the regression task.
%%%% ¡default!
'NNRegressor_Evaluator notes'
    
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
CORRELATION_COEFF (result, rvector) provides the metric of the correlation of coefficients.
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
COEFF_OF_DETERMINATION (result, rvector) provides a measure of how well the predictions are replicated by the model.
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
MEAN_ABSOLUTE_ERROR (result, rvector) provides the metric of the mean absolute error.
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
MEAN_SQUARED_ERROR (result, rvector) provides the metric of the mean squared error.
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
ROOT_MEAN_SQUARED_ERROR (result, rvector) provides the metric of the root mean squared error.
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
PERMUTATION_FEATURE_IMPORTANCE (result, cell) assess the significance of each feature by randomly shuffling its values and measuring how much the performance of the model decreases.
%%%% ¡calculate!
value = {};

%% ¡tests!

%%% ¡test!
%%%% ¡name!
evaluate a regressor with the example data
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
nne = NNRegressor_Evaluator('NN', nn, 'D', d);
predictions = cell2mat(nn.get('PREDICT', d));

% Check whether the ground truth are derived as expected
ground_truth = nne.get('GROUND_TRUTH');
targets = d.get('TARGETS');

for i = 1:size(ground_truth, 1)
    check(i) = isequal(cell2mat(targets{i}), ground_truth(i, :));
end
assert(all(check), ...
    [BRAPH2.STR ':NNRegressor_Evaluator:' BRAPH2.FAIL_TEST], ...
    'NNRegressor_Evaluator does not calculate the ground truth correctly.' ...
    )

% Check whether the correlation coefficients are calculated as expected
calculated_value = nne.get('CORRELATION_COEFF');
for i = 1:size(ground_truth, 2)
    corr_matrix = corrcoef(predictions(:, i), ground_truth(:, i));
    known_value(i) = corr_matrix(1, 2);
end
assert(isequal(calculated_value, known_value), ...
    [BRAPH2.STR ':NNRegressor_Evaluator:' BRAPH2.FAIL_TEST], ...
    'NNRegressor_Evaluator does not calculate the correlation coefficients correctly.' ...
    )

% Check whether the correlation coefficients are calculated as expected
calculated_value = nne.get('COEFF_OF_DETERMINATION');
for i = 1:size(ground_truth, 2)
    corr_matrix = corrcoef(predictions(:, i), ground_truth(:, i));
    known_value(i) = corr_matrix(1, 2)^2;
end
assert(isequal(calculated_value, known_value), ...
    [BRAPH2.STR ':NNRegressor_Evaluator:' BRAPH2.FAIL_TEST], ...
    'NNRegressor_Evaluator does not calculate the coefficient of determination correctly.' ...
    )

% Check whether the mean absolute errors are calculated as expected
calculated_value = nne.get('MEAN_ABSOLUTE_ERROR');
for i = 1:size(ground_truth, 2)
    known_value(i) = mean(abs(predictions(:, i) - ground_truth(:, i)));
end
assert(isequal(calculated_value, known_value), ...
    [BRAPH2.STR ':NNRegressor_Evaluator:' BRAPH2.FAIL_TEST], ...
    'NNRegressor_Evaluator does not calculate the mean absolute errors correctly.' ...
    )

% Check whether the mean squared errors are calculated as expected
calculated_value = nne.get('MEAN_SQUARED_ERROR');
for i = 1:size(ground_truth, 2)
    known_value(i) = mean((predictions(:, i) - ground_truth(:, i)).^2);
end
assert(isequal(calculated_value, known_value), ...
    [BRAPH2.STR ':NNRegressor_Evaluator:' BRAPH2.FAIL_TEST], ...
    'NNRegressor_Evaluator does not calculate the mean squared errors correctly.' ...
    )

% Check whether the mean squared errors are calculated as expected
calculated_value = nne.get('ROOT_MEAN_SQUARED_ERROR');
for i = 1:size(ground_truth, 2)
    known_value(i) = sqrt(mean((predictions(:, i) - ground_truth(:, i)).^2));
end
assert(isequal(calculated_value, known_value), ...
    [BRAPH2.STR ':NNRegressor_Evaluator:' BRAPH2.FAIL_TEST], ...
    'NNRegressor_Evaluator does not calculate the root mean squared errors correctly.' ...
    )