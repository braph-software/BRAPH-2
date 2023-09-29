%% ¡header!
NNCrossValidation < ConcreteElement (nncv, neural network cross-validation) is a process for evaluating neural network models using cross-validation.

%%% ¡description!
A cross validation (NNCrossValidation) is a process that facilitates the evaluation of neural network models using cross-validation. 
 It involves splitting a dataset into multiple subsets (folds), training the model on some folds while validating on others, and then repeating the process for all combinations of folds. 
 This helps in assessing the generalization performance of the model and detecting overfitting.

To train all the neural networks for all folds, use: nncv.get('TRAIN')

%%% ¡seealso!
NNDataset, NNEvaluator, NNBase

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'NNCrossValidation'

%%% ¡prop!
NAME (constant, string) is the name of the cross-validation.
%%%% ¡default!
'NNCrossValidation'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the cross-validation.
%%%% ¡default!
'A cross validation (NNCrossValidation) is a process that facilitates the evaluation of neural network models using cross-validation. It involves splitting a dataset into multiple subsets (folds), training the model on some folds while validating on others, and then repeating the process for all combinations of folds. This helps in assessing the generalization performance of the model and detecting overfitting.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the cross-validation.
%%%% ¡settings!
'NNCrossValidation'

%%% ¡prop!
ID (data, string) is a few-letter code for the cross-validation.
%%%% ¡default!
'NNCrossValidation ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the cross-validation.
%%%% ¡default!
'NNCrossValidation label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the cross-validation.
%%%% ¡default!
'NNCrossValidation notes'
    
%% ¡props!

%%% ¡prop!
KFOLDS (data, scalar) is the number of folds.
%%%% ¡default!
5

%%% ¡prop!
SPLIT (data, cell) is a cell containing the ratio numbers or the vectors stating which datapoints belong to the splitted neural network datasets.
%%%% ¡postprocessing!
split = nncv.get('SPLIT');
kfolds = nncv.get('KFOLDS');
d = nncv.get('D');
if isempty(split) && length(d) > 0 && d{1}.get('DP_DICT').get('LENGTH') > kfolds
    nncv.set('SPLIT', repmat({1 / kfolds}, 1, kfolds));
end

%%% ¡prop!
D (data, itemlist) is the datasets from groups to be cross-validated.
%%%% ¡settings!
'NNDataset'

%%% ¡prop!
NN_TEMPLATE (parameter, item) is the neural network template to set all neural network parameters.
%%%% ¡settings!
'NNBase'

%%% ¡prop!
NNEVALUATOR_TEMPLATE (parameter, item) is the neural network evaluator template to set all evalutor parameters.
%%%% ¡settings!
'NNEvaluator'

%%% ¡prop!
DSP (result, itemlist) is a list of dataset splitter that splits the dataset per group.
%%%% ¡settings!
'NNDatasetSplit'
%%%% ¡calculate!
d_list = nncv.get('D');
value = cellfun(@(d) NNDatasetSplit('D', d, 'SPLIT', nncv.get('SPLIT')), d_list, 'UniformOutput', false);

%%% ¡prop!
DCO (result, itemlist) is a list of dataset combiners that combines the datasets per fold.
%%%% ¡settings!
'NNDatasetCombine'
%%%% ¡calculate!
dsp_list = nncv.get('DSP');
if length(dsp_list) == 0
    value = {};
else
    kfolds = nncv.get('KFOLDS');
    for i = 1:1:kfolds
        d_splitted_list = cellfun(@(dsp) dsp.get('D_LIST_IT', i), dsp_list, 'UniformOutput', false);
        dp_dict = IndexedDictionary(...
            'IT_CLASS', d_splitted_list{1}.get('DP_CLASS'), ...
            'IT_LIST',  d_splitted_list ...
            );
        value{i} = NNDatasetCombine('D_LIST', d_splitted_list);
    end
    value = value';
end

%%% ¡prop!
D_LIST (result, itemlist) contains the split datasets corresponding to the k folds.
%%%% ¡calculate!
dco_list = nncv.get('DCO');
if length(dco_list) == 0
    value = {};
else
    value = cellfun(@(dco) dco.get('D'), dco_list, 'UniformOutput', false);
end

%%% ¡prop!
NN_LIST (result, itemlist) contains the neural network models corresponding to the k folds.

%%% ¡prop!
EVALUATOR_LIST (result, itemlist) contains the evaluators corresponding to the k folds.

%%% ¡prop!
EPOCHS (parameter, scalar) is the maximum number of epochs.
%%%% ¡default!
20

%%% ¡prop!
BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.
%%%% ¡default!
8

%%% ¡prop!
SHUFFLE (parameter, option) is an option for data shuffling.
%%%% ¡settings!
{'once' 'never' 'every-epoch'}

%%% ¡prop!
SOLVER (parameter, option) is an option for the solver.
%%%% ¡settings!
{'adam' 'sgdm' 'rmsprop'}

%%% ¡prop!
VERBOSE (metadata, logical) is an indicator to display training progress information.
%%%% ¡default!
false

%%% ¡prop!
PLOT_TRAINING (metadata, option) determines whether to plot the training progress.
%%%% ¡settings!
{'none' 'training-progress'}

%%% ¡prop!
TRAIN (query, empty) trains all neural network models for all folds.
%%%% ¡calculate!
nn_list = nncv.memorize('NN_LIST');
for i = 1:1:length(nn_list)
    nn_list{i}.memorize('MODEL');
end
value = [];

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Creating a cross-validation object
%%%% ¡code!
% create a NNData containing NNDataPoints 
num_dp = 9; 
dp_ids = cell(1, num_dp);

for i = 1:num_dp
    dp_ids{i} = ['dp_', num2str(i)];
end

d = NNDataset('DP_DICT', IndexedDictionary(...
    'IT_CLASS', 'NNDataPoint', ...
    'IT_LIST',  cellfun(@(x) NNDataPoint('ID', x), ...
    dp_ids(1:num_dp), 'UniformOutput', false) ...
    ));

% create the cross-validation process
nncv = NNCrossValidation('D', {d}, 'KFOLDS', 5);

% Check whether the number of datapoint from all d_list matches
d_list = nncv.get('D_LIST');
num_dp_from_nncv = 0;
for i = 1:length(d_list)
    num_dp_from_nncv = num_dp_from_nncv + d_list{i}.get('DP_DICT').get('LENGTH');
end
assert(num_dp_from_nncv == num_dp, ...
    [BRAPH2.STR ':NNCrossValidation:' BRAPH2.FAIL_TEST], ...
    'NNCrossValidation does not split the dataset correctly.' ...
    )

% create the cross-validation process with specifying the datapoints in each
% fold
nncv = NNCrossValidation('D', {d}, 'KFOLDS', 5, 'SPLIT', {[1 2], [3 4], [5 6], [7 8], [9]});

% Check whether the number of datapoint in each fold matches
split = nncv.get('SPLIT');
d_list = nncv.get('D_LIST');
for i = 1:length(split)
    check(i) = d_list{i}.get('DP_DICT').get('LENGTH') == length(split{i});
end
assert(all(check), ...
    [BRAPH2.STR ':NNCrossValidation:' BRAPH2.FAIL_TEST], ...
    'NNCrossValidation does not split the dataset correctly.' ...
    )