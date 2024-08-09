%% ¡header!
NNxMLP_FeatureImportanceAcrossMeasures < NNxMLP_FeatureImportance (nnfiam, neural network feature importace for multi-layer perceptron) provides feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.

%%% ¡description!
Neural Network Feature Importance Across Graph Measures (NNxMLP_FeatureImportanceAcrossMeasures) 
 assesses the importance of graph measures by measuring the increase in model error 
 when specific graph measure values are randomly shuffled.

%%% ¡seealso!
NNxMLP_FeatureImportance, NNDataPoint_Measure_CLA, NNDataPoint_Measure_REG

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossMeasures.ID
%%%% ¡title!
Feature Importance MLP ID

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossMeasures.LABEL
%%%% ¡title!
Feature Importance MLP LABEL

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossMeasures.D
%%%% ¡title!
Neural Networks Dataset

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossMeasures.NN
%%%% ¡title!
Neural Networks

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossMeasures.P
%%%% ¡title!
Permutation Number

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossMeasures.APPLY_BONFERRONI
%%%% ¡title!
Bonferroni Correction ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossMeasures.APPLY_CONFIDENCE_INTERVALS
%%%% ¡title!
Confidence Intervals ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossMeasures.SIG_LEVEL
%%%% ¡title!
Significant level

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossMeasures.FEATURE_IMPORTANCE
%%%% ¡title!
Feature Importance Score

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportanceAcrossMeasures.VERBOSE
%%%% ¡title!
VERBOSE ON/OFF

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'NNxMLP_FeatureImportanceAcrossMeasures'

%%% ¡prop!
NAME (constant, string) is the name of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'Feature Importace for Multi-layer Perceptron Across Graph Measures'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'Neural Network Feature Importance Across Graph Measures (NNxMLP_FeatureImportanceAcrossMeasures) assesses the importance of graph measures by measuring the increase in model error when specific graph measure values are randomly shuffled.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡settings!
'NNxMLP_FeatureImportanceAcrossMeasures'

%%% ¡prop!
ID (data, string) is a few-letter code of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'NNxMLP_FeatureImportanceAcrossMeasures ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'NNxMLP_FeatureImportanceAcrossMeasures label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the feature importance analysis for multi-layer perceptron (MLP) across all included graph measures.
%%%% ¡default!
'NNxMLP_FeatureImportanceAcrossMeasures notes'
  
%%% ¡prop!
FEATURE_IMPORTANCE (result, cell) is determined by applying Bonferroni correction for the permutation and obtaining the value by the average of the permutation number times of shuffled loss, which then in trun are divided by base loss for normalizaiton.
%%%% ¡gui!
input_dataset = nnfiam.get('D');
m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
pr = PanelPropCell('EL', nnfiam, 'PROP', NNxMLP_FeatureImportanceAcrossMeasures.FEATURE_IMPORTANCE, ...
    'TABLE_HEIGHT', s(40), ...
    'ROWNAME', {}, ...
    'COLUMNNAME', m_list, ...
    varargin{:});

%%% ¡prop!
COMP_FEATURE_INDICES (result, cell) provides the indices of combined features, represented as a cell array containing sets of feature indices, such as {[1, 2], [2, 3], [1, 3]}.
%%%% ¡calculate!
input_dataset = nnfiam.get('D');
if isa(input_dataset.getr('DP_DICT'), 'NoValue')
    value = {};
    return
end
m_list = input_dataset.get('DP_DICT').get('IT', 1).get('M_LIST');
example_input_cell = input_dataset.get('DP_DICT').get('IT', 1).get('INPUT');
for i = 1:length(m_list)
    single_measure_indexes = nnfiam.get('INPUT_MASK', example_input_cell, i, 1);
    flattened_indexes = nnfiam.get('FLATTEN_CELL', single_measure_indexes);
    comp_feature_indices{i} = find(flattened_indexes);
end

value = comp_feature_indices;

%% ¡props!

%%% ¡prop!
INPUT_MASK (query, empty) creates a mask that covers the top-level index of interest in the input cell array, maintaining the same structure.
%%%% ¡calculate!
if isempty(varargin)
    value = {};
    return
end
cell_array = varargin{1};
index = varargin{2};
current_level = varargin{3};
mask = cell(size(cell_array));

for i = 1:length(cell_array)
    if iscell(cell_array{i})
        if ismember(i, index)
            index_for_cell = 1:1:length(cell_array{i});
        else
            index_for_cell = 0;
        end
        mask{i} = NNxMLP_FeatureImportanceAcrossMeasures().get('INPUT_MASK' ,cell_array{i}, index_for_cell, current_level + 1);
    else
        if ismember(i, index)
            mask{i} = ones(size(cell_array{i}));
        else
            mask{i} = zeros(size(cell_array{i}));
        end
    end
end
value = mask;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Test INPUT_MASK the query for simple cell array
%%%% ¡code!
target_cell = {[1 2], [3 4], [5 6 7]};
target_index = [1 2 3];
mask_cell{1} = {[1 1], [0 0], [0 0 0]};
mask_cell{2} = {[0 0], [1 1], [0 0 0]};
mask_cell{3} = {[0 0], [0 0], [1 1 1]};

for i = 1:length(target_index)
    index = target_index(i);
    generated_mask_cell = NNxMLP_FeatureImportanceAcrossMeasures().get('INPUT_MASK', target_cell, index, 1);

    assert(isequal(generated_mask_cell, mask_cell{i}), ...
        [BRAPH2.STR ':NNxMLP_FeatureImportanceAcrossMeasures:' BRAPH2.FAIL_TEST], ...
        'NNxMLP_FeatureImportanceAcrossMeasures does not create the input mask of interest correctly.' ...
        )
end

%%% ¡test!
%%%% ¡name!
Test INPUT_MASK the query for multiple nested cell array
%%%% ¡code!
target_cell = {{[1 2], [3 4], [5 6 7]}, {[8], [9 10]}};
target_index = [1 2];
mask_cell{1} = {{[1 1], [1 1], [1 1 1]}, {[0], [0 0]}};
mask_cell{2} = {{[0 0], [0 0], [0 0 0]}, {[1], [1 1]}};

for i = 1:length(target_index)
    index = target_index(i);
    generated_mask_cell = NNxMLP_FeatureImportanceAcrossMeasures().get('INPUT_MASK', target_cell, index, 1);

    assert(isequal(generated_mask_cell, mask_cell{i}), ...
        [BRAPH2.STR ':NNxMLP_FeatureImportanceAcrossMeasures:' BRAPH2.FAIL_TEST], ...
        'NNxMLP_FeatureImportanceAcrossMeasures does not create the input mask of interest correctly.' ...
        )
end