%% ¡header!
NNRegressorCrossValidation < NNRegressorEvaluator (nncv, cross-validation for neural network regressor) cross-validate the performance of neural network regressors with a dataset.

%% ¡description!
This cross validation perform a k-fold cross validation of neural network
regressor with desired repetitions on a dataset. The dataset is split into
k consecutive folds with shuffling by default, and each fold is then used 
once as a validation while the k-1 remaining folds from the training set. 
The root-mean square error is calculated across folds and repetitions.

%% ¡props!

%%% ¡prop!
LAYERS (parameter, rvector) is a vector representing the number of neurons in each layer.
%%%% ¡default!
[100 100]
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', nncv, 'PROP', NNRegressorCrossValidation.LAYERS, 'MAX', 100000, 'MIN', 1, 'UNIQUE_VALUE', false, varargin{:});

%%% ¡prop!
BATCH (parameter, scalar) is the size of the mini-batch to use for each training iteration.
%%%% ¡default!
8

%%% ¡prop!
EPOCHS (parameter, scalar) is a maximum number of epochs.
%%%% ¡default!
20

%%% ¡prop!
SHUFFLE (parameter, option) is an option for data shuffling.
%%%% ¡settings!
{'once' 'never' 'every-epoch'}

%%% ¡prop!
SOLVER (parameter, option) is an option for the solver.
%%%% ¡settings!
{'adam' 'sgdm' 'rmsprop'}

%%% ¡prop!
FEATURE_SELECTION_RATIO (parameter, scalar) is the ratio of selected features.
%%%% ¡default!
1

%%% ¡prop!
VERBOSE (parameter, logical) is an indicator to display trining progress information.
%%%% ¡default!
false

%%% ¡prop!
PLOT_TRAINING (parameter, logical) is an option for the plot of training-progress.
%%%% ¡default!
false

%%% ¡prop!
PLOT_LAYERS (parameter, logical) is an option for the plot of layer architecture.
%%%% ¡default!
false

%%% ¡prop!
KFOLD (data, scalar) is the number of folds.
%%%% ¡default!
5

%%% ¡prop!
SPLIT_KFOLD (result, cell) is a vector stating which subjects belong to each fold.
%%%% ¡calculate!
num_per_class = nncv.get('GR').get('SUB_DICT').length;
kfold = nncv.get('KFOLD');
shuffle_indexes = randperm(num_per_class, num_per_class);
num_per_fold = floor(num_per_class / kfold);
r_times = rem(num_per_class, kfold);
r = zeros(1, kfold);
r(randperm(kfold, r_times)) = 1;
jend = 0;
for j = 1:kfold
    jstart = jend + 1;
    if j == kfold
        index_kfold{j} = shuffle_indexes(jend+1:end);
    else
        jend = jend + num_per_fold + r(j);
        index_kfold{j} = shuffle_indexes(jstart:jend);
    end
end

value = index_kfold;

%%% ¡prop!
NNDS_DICT (result, idict) contains the NN data splits for k folds across repetitions.
%%%% ¡settings!
'NNRegressorDataSplit'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'NNRegressorDataSplit')
%%%% ¡calculate!
nnds_dict = IndexedDictionary('IT_CLASS', 'NNRegressorDataSplit');
if ~isa(nncv.get('GR').getr('SUB_DICT'), 'NoValue')
    idx_per_fold = nncv.get('SPLIT_KFOLD');

    % create the 1st nnds and act as a template
    nnds_tmp = NNRegressorDataSplit( ...
        'ID', ['NN dataset for fold #', num2str(1)], ...
        'GR', nncv.get('GR'), ...
        'SPLIT', idx_per_fold{1} ...
        );
    nnds_dict.add(nnds_tmp)

    % create the following nnds and use that template
    for i = 2:1:nncv.get('KFOLD')
        nnds = NNRegressorDataSplit( ...
            'ID', ['NN dataset for fold #', num2str(i)], ...
            'GR', nncv.get('GR'), ...
            'SPLIT', idx_per_fold{i} ...
            );

        nnds_dict.add(nnds);
    end
end

value = nnds_dict;

%%% ¡prop!
NN_DICT (result, idict) contains the NN regressors for k folds for all repetitions.
%%%% ¡settings!
'NNRegressorDNN'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'NNRegressorDNN')
%%%% ¡calculate!
nn_dict = IndexedDictionary('IT_CLASS', 'NNRegressorDNN');
if ~isa(nncv.get('GR').getr('SUB_DICT'), 'NoValue')
    nnds = nncv.memorize('NNDS_DICT').getItem(1);
    gr_train = nnds.memorize('GR_TRAIN_FS');
    
    % create the 1st nn and act as a template
    nn_tmp = NNRegressorDNN( ...
        'ID', ['NN model cooperated with ', nnds.get('ID')], ...
        'GR', gr_train, ...
        'LAYERS', nncv.get('LAYERS'), ...
        'BATCH', nncv.get('BATCH'), ...
        'EPOCHS', nncv.get('EPOCHS'), ...
        'SHUFFLE', nncv.get('SHUFFLE'), ...
        'SOLVER', nncv.get('SOLVER'), ...
        'FEATURE_SELECTION_RATIO', nncv.get('FEATURE_SELECTION_RATIO'), ...
        'VERBOSE', nncv.get('VERBOSE'), ...
        'PLOT_TRAINING', nncv.get('PLOT_TRAINING'), ...
        'PLOT_LAYERS', nncv.get('PLOT_LAYERS') ...
        );
    nn_dict.add(nn_tmp)

    % create the following nn and use that template
    for i = 2:1:nncv.get('NNDS_DICT').length()
        nnds = nncv.memorize('NNDS_DICT').getItem(i);
        gr_train = nnds.memorize('GR_TRAIN_FS');

        nn = NNRegressorDNN( ...
                'ID', ['NN model cooperated with ', nnds.get('ID')], ...
                'GR', gr_train, ...
                'TEMPLATE', nn_tmp ...
                );
            
        nn_dict.add(nn);
    end
end

value = nn_dict;

%%% ¡prop!
NNE_DICT (result, idict) contains the NN evaluators for k folds for all repetitions.
%%%% ¡settings!
'NNRegressorEvaluator'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'NNRegressorEvaluator')
%%%% ¡calculate!
nne_dict = IndexedDictionary('IT_CLASS', 'NNRegressorEvaluator');
if ~isa(nncv.get('GR').getr('SUB_DICT'), 'NoValue')
    for i = 1:1:nncv.get('NN_DICT').length()
        nn = nncv.memorize('NN_DICT').getItem(i);
        nnds = nncv.memorize('NNDS_DICT').getItem(i);
        gr_val = nnds.memorize('GR_VAL_FS');

        nne = NNRegressorEvaluator( ...
                'ID', ['NN evaluator cooperated with ', nnds.get('ID')], ...
                'GR', gr_val, ...
                'NN', nn ...
                );
            
        nne_dict.add(nne);
    end
end

value = nne_dict;

%%% ¡prop!
FEATURE_IMPORTANCE (result, cell) is the feature importance obtained with permutation analysis.
%%%% ¡calculate!
if ~isa(nncv.get('GR').getr('SUB_DICT'), 'NoValue')
    if any(ismember(nncv.get('GR').get('SUB_DICT').getItem(1).get('INPUT_LABEL'), subclasses('Measure', [], [], true)))
        feature_importances = {};
        if ~braph2_testing
            questdlg('Feature importance analysis does not apply to the input of graph measures.', ...
                'User Request', ...
                'Ok', 'Ok');
        end
    else
        nne_dict = nncv.memorize('NNE_DICT');
        wb = braph2waitbar(nncv.get('WAITBAR'), 0, 'Analysing feature importance...');
        feature_importances = nne_dict.getItem(1).get('FEATURE_PERMUTATION_IMPORTANCE');
        braph2waitbar(wb, .30 + .70 * 1 / nne_dict.length, ['Analysing feature importance for the fold ' num2str(1) ' out of ', num2str(nne_dict.length), '...']);
        if length(feature_importances) == 0
            feature_importances = {};
        else
            for i = 2:1:nne_dict.length()
                feature_importance = nne_dict.getItem(i).get('FEATURE_PERMUTATION_IMPORTANCE');
                feature_importances = cellfun(@(x, y) x + y, feature_importances, feature_importance, 'UniformOutput', false);
                braph2waitbar(wb, .30 + .70 * i / nne_dict.length, ['Analysing feature importance for the fold ' num2str(i) ' out of ', num2str(nne_dict.length), '...']);
            end
            feature_importances = cellfun(@(x) x/nne_dict.length, feature_importances, 'UniformOutput', false);
        end
        braph2waitbar(wb, 'close')
    end
else
    feature_importances = {};
end

value = feature_importances;
%%%% ¡gui!
if ~braph2_testing && ~isa(nncv.get('GR').get('SUB_DICT'), 'NoValue')
    if string(nncv.get('GR').get('SUB_DICT').getItem(1).get('INPUT_TYPE')) == 'structural_data'
        pr = PPNNEvaluatorFeatureImportanceStructuralData('EL', nncv, 'PROP', NNRegressorCrossValidation.FEATURE_IMPORTANCE, varargin{:});
    elseif string(nncv.get('GR').get('SUB_DICT').getItem(1).get('INPUT_TYPE')) == 'adjacency_matrices'
        pr = PPNNEvaluatorFeatureImportanceAdjacency('EL', nncv, 'PROP', NNRegressorCrossValidation.FEATURE_IMPORTANCE, varargin{:});
    else
        pr = PanelPropCell('EL', nncv, 'PROP', NNRegressorCrossValidation.FEATURE_IMPORTANCE, varargin{:});
    end
end

%% ¡props_update!

%%% ¡prop!
PFFI (gui, item) contains the panel figure of the feature importance.
%%%% ¡settings!
'PFFeatureImportance'
%%%% ¡postprocessing!
if ~braph2_testing % to avoid problems with isqual when the element is recursive
    nncv.memorize('PFFI').set('NNE', nncv, ...
        'PROP', NNRegressorCrossValidation.FEATURE_IMPORTANCE, ...
        'INPUT_TYPE', nncv.get('GR').get('SUB_DICT').getItem(1).get('INPUT_TYPE'), ...
        'BA', nncv.get('GR').get('SUB_DICT').getItem(1).get('BA'))
end
%%%% ¡gui!
pr = PanelPropItem('EL', nncv, 'PROP', NNRegressorCrossValidation.PFFI, ...
    'GUICLASS', 'GUIFig', ...
    varargin{:});

%%% ¡prop!
GR_PREDICTION (result, item) is a group of NN subjects with prediction from NN.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
if ~isa(nncv.get('GR').getr('SUB_DICT'), 'NoValue')
    gr = nncv.memorize('NNE_DICT').getItem(1).memorize('GR_PREDICTION');
    gr_prediction = NNGroup( ...
        'ID', 'NN Group with NN prediction', ...
        'LABEL', 'The predictions are obatined from K-fold cross validation', ...
        'NOTES', 'All of the predictions are obtained from the validation of each fold', ...
        'SUB_CLASS', gr.get('SUB_CLASS'), ...
        'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'), ...
        'FEATURE_SELECTION_MASK', gr.get('FEATURE_SELECTION_MASK') ...
        );

    % add subejcts from NNE_DICT
    sub_dict = gr_prediction.get('SUB_DICT');

    for i = 1:1:nncv.memorize('NNE_DICT').length()
        nne = nncv.memorize('NNE_DICT').getItem(i);
        for j = 1:1:nne.memorize('GR_PREDICTION').get('SUB_DICT').length()
            sub = nne.memorize('GR_PREDICTION').get('SUB_DICT').getItem(j);
            sub_dict.add(sub);
        end
    end

    gr_prediction.set('SUB_DICT', sub_dict);
else
    gr_prediction = NNGroup();
end

value = gr_prediction;

%%% ¡prop!
RMSE (result, scalar) is the root mean squared error between targets and predictions across k folds for all repeitions.
%%%% ¡calculate!
if nncv.memorize('GR_PREDICTION').get('SUB_DICT').length() == 0
    value = 0;
else
    preds = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nncv.memorize('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    preds = cell2mat(preds);
    targets = cellfun(@(x) cell2mat(x.get('TARGET')), nncv.get('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    targets = cell2mat(targets);
    value = double(sqrt(mean((preds - targets).^2)));
end

%%% ¡prop!
SCATTER_CHART (result, matrix) creates a scatter chart with circular markers at the locations specified by predictions and targets.
%%%% ¡calculate!
if isa(nncv.get('GR').getr('SUB_DICT'), 'NoValue')
    value = [];
else
    preds = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nncv.get('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    preds = cell2mat(preds);
    targets = cellfun(@(x) cell2mat(x.get('TARGET')), nncv.get('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    targets = cell2mat(targets);
    value = double([preds' targets']);
end
%%%% ¡gui!
pr = PanelPropMatrix('EL', nncv, 'PROP', NNRegressorCrossValidation.SCATTER_CHART, ...
    'ROWNAME', char("cellfun(@(x) x.get('ID'), pr.get('EL').memorize('GR').get('SUB_DICT').getItems(), 'UniformOutput', false)"), ...
    'COLUMNNAME', char("{'Prediction', 'Target'}"), ...
    varargin{:});

%%% ¡prop!
PFSP (gui, item) contains the panel figure of the scatter plot.
%%%% ¡settings!
'PFScatterPlot'
%%%% ¡postprocessing!
if ~braph2_testing % to avoid problems with isqual when the element is recursive
    nncv.memorize('PFSP').set('NNE', nncv);
end
%%%% ¡gui!
pr = PanelPropItem('EL', nncv, 'PROP', NNRegressorCrossValidation.PFSP, ...
    'GUICLASS', 'GUIFig', ...
    varargin{:});