%% ¡header!
NNxMLP_FeatureImportance_CrossValidation < ConcreteElement (nnficv, neural network feature importace for multi-layer perceptron) provides the importance of features across all folds for multi-layer perceptron (MLP) using shuffled feature method.

%%% ¡description!
Neural Network Feature Importance for Multi-Layer Perceptron with Cross-Validation (NNxMLP_FeatureImportance_CrossValidation)
 assesses the importance of features across all folds by measuring the increase in model error when the feature values are randomly shuffled. 
The feature importance score for each feature is then averaged across all folds. 
It applies a template to all folds of NNxMLP_FeatureImportance for setting up the parameters of the permutation method, 
 such as a user-defined confidence interval, and adjusts for multiple comparisons with the Bonferroni correction.

%%% ¡seealso!
NNxMLP_FeatureImportance, NNClassifierMLP_CrossValidation, NNRegressorMLP_CrossValidation

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_CrossValidation.ID
%%%% ¡title!
Feature Importance MLP Cross Validation ID

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_CrossValidation.LABEL
%%%% ¡title!
Feature Importance MLP Cross Validation LABEL

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_CrossValidation.NNCV
%%%% ¡title!
Neural Networks Cros Cross Validations Validation

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_CrossValidation.FI_TEMPLATE
%%%% ¡title!
Template for Feature Importance Analysis

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_CrossValidation.P
%%%% ¡title!
Permutation Number

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_CrossValidation.APPLY_BONFERRONI
%%%% ¡title!
Bonferroni Correction ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_CrossValidation.APPLY_CONFIDENCE_INTERVALS
%%%% ¡title!
Confidence Interval ON/OFF

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_CrossValidation.SIG_LEVEL
%%%% ¡title!
Significant Level

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_CrossValidation.RESHAPED_AV_FEATURE_IMPORTANCE
%%%% ¡title!
Feature Importance Score

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_CrossValidation.FI_LIST
%%%% ¡title!
Feature Importance List

%%% ¡prop!
%%%% ¡id!
NNxMLP_FeatureImportance_CrossValidation.VERBOSE
%%%% ¡title!
VERBOSE ON/OFF

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the neural network feature importance for cross validation.
%%%% ¡default!
'NNxMLP_FeatureImportance_CrossValidation'

%%% ¡prop!
NAME (constant, string) is the name of the neural network feature importance for cross validation.
%%%% ¡default!
'Feature Importace for Multi-layer Perceptron'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the neural network feature importance for cross validation.
%%%% ¡default!
'Neural Network Feature Importance for Multi-Layer Perceptron with Cross-Validation (NNxMLP_FeatureImportance_CrossValidation) assesses the importance of features across all folds by measuring the increase in model error when the feature values are randomly shuffled. The feature importance score for each feature is then averaged across all folds. It applies a template to all folds of NNxMLP_FeatureImportance for setting up the parameters of the permutation method, such as a user-defined confidence interval, and adjusts for multiple comparisons with the Bonferroni correction.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the neural network feature importance for cross validation.
%%%% ¡settings!
'NNxMLP_FeatureImportance_CrossValidation'

%%% ¡prop!
ID (data, string) is a few-letter code of the neural network feature importance for cross validation.
%%%% ¡default!
'NNxMLP_FeatureImportance_CrossValidation ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the neural network feature importance for cross validation.
%%%% ¡default!
'NNxMLP_FeatureImportance_CrossValidation label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the neural network feature importance for cross validation.
%%%% ¡default!
'NNxMLP_FeatureImportance_CrossValidation notes'
    
%% ¡props!

%%% ¡prop!
NNCV (data, item) is the neural network cross validation to be tested on feature importance.
%%%% ¡settings!
'NNCrossValidation'

%%% ¡prop!
FI_TEMPLATE (parameter, item) is the feature importance template to set all feature importance analysis and visualization parameters.
%%%% ¡settings!
'NNxMLP_FeatureImportance'
%%%% ¡gui!
pr = PanelPropItem('EL', nnficv, 'PROP', NNxMLP_FeatureImportance_CrossValidation.FI_TEMPLATE, ...
    'BUTTON_TEXT', ['FEATURE IMPORTANCE TEMPLATE (' nnficv.get('FI_TEMPLATE').getClass() ')'], ...
    varargin{:});

%%% ¡prop!
FI_LIST (result, itemlist) contains a list of feature importance analysis for all folds.
%%%% ¡settings!
'NNxMLP_FeatureImportance'
%%%% ¡calculate!
if ~isa(nnficv.getr('FI_TEMPLATE'), 'NoValue')
    fi_template = nnficv.get('FI_TEMPLATE');
else
    fi_template = NNxMLP_FeatureImportance( ...
        'P', nnficv.get('P'), ...
        'APPLY_BONFERRONI', nnficv.get('APPLY_BONFERRONI'), ...
        'APPLY_CONFIDENCE_INTERVALS', nnficv.get('APPLY_CONFIDENCE_INTERVALS'), ...
        'SIG_LEVEL', nnficv.get('SIG_LEVEL'));
end

d_list = nnficv.get('NNCV').get('D_LIST');
nn_list = nnficv.get('NNCV').get('NN_LIST');
for i = 1:length(d_list)
    fi = fi_template.copy();
    d = d_list{i};
    nn = nn_list{i};
    fi.set('TEMPLATE', fi_template, 'D', d, 'NN', nn);
    fi_list{i} = fi;
end
value = fi_list;
%%% ¡prop!
P (parameter, scalar) is the permutation number that determines the statistical significance of the features. 
%%%% ¡default!
1e+2
%%%% ¡check_prop!
check = value > 0 && value == round(value);
%%%% ¡postset!
nnficv.memorize('FI_TEMPLATE').set('P', nnficv.getCallback('P'));

%%% ¡prop!
PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.
%%%% ¡calculate!
value = randi(intmax('uint32'), 1, nnfi.get('P'));

%%% ¡prop!
APPLY_BONFERRONI (parameter, logical) determines whether to apply bonferroni correction.
%%%% ¡default!
true
%%%% ¡postset!
nnficv.memorize('FI_TEMPLATE').set('APPLY_BONFERRONI', nnficv.getCallback('APPLY_BONFERRONI'));

%%% ¡prop!
APPLY_CONFIDENCE_INTERVALS (parameter, logical) determines whether to apply user-defined percent confidence interval.
%%%% ¡default!
true
%%%% ¡postset!
nnficv.memorize('FI_TEMPLATE').set('APPLY_CONFIDENCE_INTERVALS', nnficv.getCallback('APPLY_CONFIDENCE_INTERVALS'));

%%% ¡prop!
VERBOSE (metadata, logical) is an indicator to display permutation progress information.
%%%% ¡default!
false

%%% ¡prop!
SIG_LEVEL (parameter, scalar) determines the significant level.
%%%% ¡default!
0.05
%%%% ¡postset!
nnficv.memorize('FI_TEMPLATE').set('SIG_LEVEL', nnficv.getCallback('SIG_LEVEL'));

%%% ¡prop!
WAITBAR (gui, logical) determines whether to show the waitbar.
%%%% ¡default!
true

%%% ¡prop!
INTERRUPTIBLE (gui, scalar) sets whether the permutation computation is interruptible for multitasking.
%%%% ¡default!
.001

%%% ¡prop!
AV_FEATURE_IMPORTANCE (result, cell) is determined by applying bonferroni correction for the permutation and obtaining the value by the average of the permutation number times of shuffled loss, which then in trun are divided by base loss for normalizaiton.
%%%% ¡calculate!
fi_list = nnficv.memorize('FI_LIST');
fi_value_list = cellfun(@(fi) cell2mat(fi.memorize('FEATURE_IMPORTANCE')'), fi_list, 'UniformOutput', false);

value = {mean(cell2mat(fi_value_list'), 1)};

%%% ¡prop!
RESHAPED_AV_FEATURE_IMPORTANCE (result, cell) reshapes the cell of feature importances with the input data.
%%%% ¡calculate!
cell1 = nnficv.get('AV_FEATURE_IMPORTANCE');
datasets = nnficv.get('NNCV').get('D_LIST');
cell2 = datasets{1}.get('DP_DICT').get('IT', 1).get('INPUT');
if ~isequal(numel(cell1), numel(cell2)) 
    cell1 = nnficv.get('MAP_TO_CELL', cell2mat(cell1), cell2);
end

value = cell1;

%%% ¡prop!
MAP_TO_CELL (query, empty) maps a single vector back to the original cell array structure.
%%%% ¡calculate!
if isempty(varargin)
    value = {};
    return
end
vector = varargin{1};
cell_template = varargin{2};
mappedCellArray = cell_template;
index = 1;
for i = 1:numel(cell_template)
    cellData = cell_template{i};
    if iscell(cellData)
        % Map the vector to nested cell arrays recursively
        numElements = nnficv.get('COUNT_ELEMENTS', cellData);
        nestedVector = vector(index:index + numElements - 1);
        mappedCellArray{i} = nnficv.get('MAP_TO_CELL', nestedVector, cellData);
        index = index + numElements;
    else
        % Assign elements from the vector to cells
        numElements = numel(cellData);
        mappedCellArray{i} = reshape(vector(index:index + numElements - 1), size(cellData));
        index = index + numElements;
    end
end

value = mappedCellArray;

%%% ¡prop!
COUNT_ELEMENTS (query, empty) counts the total number of elements within a nested cell array.
%%%% ¡calculate!
if isempty(varargin)
    value = {};
    return
end
cell_data = varargin{1};
count = 0;
for i = 1:numel(cell_data)
    if iscell(cell_data{i})
        count = count + nnficv.get('COUNT_ELEMENTS', cell_data{i});
    else
        count = count + numel(cell_data{i});
    end
end

value = count;

%%% ¡prop!
FLATTEN_CELL (query, empty) flattens a cell array into to a single vector.
%%%% ¡calculate!
if isempty(varargin)
    value = {};
    return
end
cell_input = varargin{1};
flattened_input = [];
while ~isempty(cell_input)
    currentData = cell_input{end};  % Get the last element from the stack
    cell_input = cell_input(1:end-1);   % Remove the last element

    if iscell(currentData)
        % If it's a cell array, add its contents to the stack
        cell_input = [cell_input currentData{:}];
    else
        % If it's numeric or other data, append it to the vector
        flattened_input = [currentData(:); flattened_input];
    end
end
value = flattened_input;

%% ¡tests!

%%% ¡excluded_props!
[NNxMLP_FeatureImportance_CrossValidation.FI_TEMPLATE]