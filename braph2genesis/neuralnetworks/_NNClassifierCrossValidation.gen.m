%% ¡header!
NNClassifierCrossValidation < NNClassifierEvaluator (nncv, cross-validation for neural network classifiers) cross-validate the performance of neural network classifiers with a dataset.

%% ¡description!
This cross validation perform a k-fold cross validation of a neural network
classifier with desired repetitions on a dataset. The dataset is split into
k consecutive folds with shuffling by default, and each fold is then used 
once as a validation while the k-1 remaining folds from the training set. 
The confusion matrix, ROC curves, AUCs, and weighted contributing maps will
be calculated across folds and repetitions.

%% ¡props!
%%% ¡prop!

KFOLD (data, scalar) is the number of folds.
%%%% ¡default!
5

%%% ¡prop!
GR1 (data, item) is is a group of subjects.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
GR2 (data, item) is is a group of subjects.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
SPLIT_KFOLD_GR1 (result, cell) is a vector stating which subjects belong to each fold.
%%%% ¡calculate!
num_per_class = nncv.get('GR1').get('SUB_DICT').length;
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
SPLIT_KFOLD_GR2 (result, cell) is a vector stating which subjects belong to each fold.
%%%% ¡calculate!
num_per_class = nncv.get('GR2').get('SUB_DICT').length;
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
'NNClassifierDataSplit'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'NNClassifierDataSplit')
%%%% ¡calculate!
nnds_dict = IndexedDictionary('IT_CLASS', 'NNClassifierDataSplit');
if ~isa(nncv.get('GR1').getr('SUB_DICT'), 'NoValue')
    idx_per_fold_gr1 = nncv.get('SPLIT_KFOLD_GR1');
    idx_per_fold_gr2 = nncv.get('SPLIT_KFOLD_GR2');
    nnds_tmp = NNClassifierDataSplit( ...
        'ID', ['NN dataset for fold #', num2str(1), ' in repetition #', num2str(i)], ...
        'GR1', nncv.get('GR1'), ...
        'GR2', nncv.get('GR2'), ...
        'SPLIT_GR1', idx_per_fold_gr1{1}, ...
        'SPLIT_GR2', idx_per_fold_gr2{1} ...
        );
    nnds_dict.add(nnds_tmp);
    for i = 2:1:nncv.get('KFOLD')
        nnds = NNClassifierDataSplit( ...
            'ID', ['NN dataset for fold #', num2str(i)], ...
            'GR1', nncv.get('GR1'), ...
            'GR2', nncv.get('GR2'), ...
            'SPLIT_GR1', idx_per_fold_gr1{j}, ...
            'SPLIT_GR2', idx_per_fold_gr2{j}, ...
            'TEMPLATE', nnds_tmp ...
            );

        nnds_dict.add(nnds);
    end
end

value = nnds_dict;

%%% ¡prop!
NN_DICT (result, idict) contains the NN classifiers for k folds for all repetitions.
%%%% ¡settings!
'NNClassifierDNN'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'NNClassifierDNN')
%%%% ¡calculate!
nn_dict = IndexedDictionary('IT_CLASS', 'NNClassifierDNN');
if nncv.memorize('NNDS_DICT').length() > 0
    nnds = nncv.get('NNDS_DICT').getItem(1);
    gr_train = nnds.get('GR_TRAIN_FS');

    nn_tmp = NNClassifierDNN( ...
        'ID', ['NN model cooperated with ', nnds.get('ID')], ...
        'GR', gr_train, ...
        'PLOT_TRAINING', false, ...
        'SHUFFLE', 'every-epoch' ...
        );

    nn_dict.add(nn_tmp);
    for i = 2:1:nncv.get('NNDS_DICT').length()
        nnds = nncv.get('NNDS_DICT').getItem(i);
        gr_train = nnds.get('GR_TRAIN_FS');

        nn = NNClassifierDNN( ...
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
'NNClassifierEvaluator'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'NNClassifierEvaluator')
%%%% ¡calculate!
nne_dict = IndexedDictionary('IT_CLASS', 'NNClassifierEvaluator');
if nncv.memorize('NN_DICT').length() > 0
    for i = 1:1:nncv.get('NN_DICT').length()
        nn = nncv.get('NN_DICT').getItem(i);
        nnds = nncv.get('NNDS_DICT').getItem(i);
        gr_val = nnds.get('GR_VAL_FS');

        nne = NNClassifierEvaluator( ...
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
nne_dict = nncv.memorize('NNE_DICT');
if ~isempty(nne_dict.getItems())
    feature_importance = nne_dict.getItem(1).get('FEATURE_PERMUTATION_IMPORTANCE');
    if length(feature_importance) == 0
        feature_importances = {}
    else
        feature_importances = {length(feature_importance)};
        for i = 1:1:nne_dict.length()
            feature_importance = nne_dict.getItem(i).get('FEATURE_PERMUTATION_IMPORTANCE');
            feature_importances = cellfun(@(x, y) x + y, feature_importances, feature_importance, 'UniformOutput', false);
        end
        feature_importances = cellfun(@(x) x/nne_dict.length, feature_importances, 'UniformOutput', false);
    end
else
    feature_importances = {};
end

value = feature_importances;

%% ¡props_update!

%%% ¡prop!
PFFI (gui, item) contains the panel figure of the feature importance.
%%%% ¡settings!
'PFFeatureImportance'
%%%% ¡postprocessing!
if ~braph2_testing % to avoid problems with isqual when the element is recursive
    nncv.memorize('PFROC').set('NNE', nncv)
end
%%%% ¡gui!
pr = PanelPropItem('EL', nncv, 'PROP', NNClassifierCrossValidation.PFFI, ...
    'GUICLASS', 'GUIFig', ...
    varargin{:});

%%% ¡prop!
GR_PREDICTION (result, item) is a group of NN subjects with prediction from NN.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
if nncv.memorize('NNE_DICT').length() > 0
    gr = nncv.get('NNE_DICT').getItem(1).get('GR_PREDICTION');
    gr_prediction = NNGroup( ...
        'ID', 'NN Group with NN prediction', ...
        'LABEL', 'The predictions are obatined from K-fold cross validation', ...
        'NOTES', 'All of the predictions are obtained from the validation set of each fold', ...
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
CONFUSION_MATRIX (result, matrix) is an add-up confusion matrix across k folds for all repeitions.
%%%% ¡calculate!
if nncv.memorize('GR_PREDICTION').get('SUB_DICT').length() == 0
    value = [];
else
    pred = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nncv.get('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    pred = cell2mat(pred);
    pred = pred > 0.5;

    % get the label of classes
    nn = nncv.get('NN_DICT').getItem(1);
    gr = nncv.get('GR_PREDICTION');
    [inputs, ~] = nn.reconstruct_inputs(gr);
    [targets, classes] = nn.reconstruct_targets(gr);
    
    % calculate the confusion matrix
    [cm, order] = confusionmat(targets(2, :), double(pred(2, :)));
    value = cm;
end
%%%% ¡gui!
pr = PanelPropMatrix('EL', nne, 'PROP', NNRegressorEvaluator.SCATTER_CHART, ...
    'ROWNAME', classes,...
    'COLUMNNAME', classes,...
    varargin{:});

%%% ¡prop!
PFCM (gui, item) contains the panel figure of the confusion matrix.
%%%% ¡settings!
'PFConfusionMatrix'
%%%% ¡postprocessing!
if ~braph2_testing % to avoid problems with isqual when the element is recursive
    nncv.memorize('PFCM').set('NNE', nncv)
end
%%%% ¡gui!
pr = PanelPropItem('EL', nncv, 'PROP', NNClassifierCrossValidation.PFCM, ...
    'GUICLASS', 'GUIFig', ...
    varargin{:});

%%% ¡prop!
AUC (result, scalar) is the area under the curve scores across k folds for all repetitions.
%%%% ¡calculate!
nne_dict = nncv.memorize('NNE_DICT');
auc = {};
if nne_dict.length() > 0
    for i = 1:1:nne_dict.length()
        auc_val = nne_dict.getItem(i).get('AUC');
        auc{i} = auc_val;
    end
    value = mean(cell2mat(auc));
else
    value = 0;
end

%%% ¡prop!
ROC (result, cell) is a receiver operating characteristic curve across k folds for all repetitions.
%%%% ¡calculate!
nne_dict = nncv.memorize('NNE_DICT');
auc = {};
X = {};
Y = {};
if nne_dict.length() > 0
    for i = 1:1:nne_dict.length()
        auc_val = nne_dict.getItem(i).get('AUC');
        auc{i} = auc_val;
        roc_val = nne_dict.getItem(i).get('ROC');
        X{i} = roc_val{1};
        Y{i} = roc_val{2};
    end

    intervals = linspace(0, 1, 100);
    mean_curve = 0;
    for i = 1:1:nne_dict.length()
        hline(i) = plot(X{i}, Y{i}, 'k-', 'LineWidth', 1.5);
        hline(i).Color = [hline(i).Color 0.05];
        hold on;
        Xadjusted = zeros(1, length(X{i}));
        aux= 0.00001;
        for j = 1 : length(X{i})
            if j ~= 1
                Xadjusted(j) = X{i}(j) + aux;
                aux = aux + 0.00001;
            end
        end
        all_lines(i, :) = interp1(Xadjusted, Y{i}, intervals);
        mean_curve = mean_curve + (interp1(Xadjusted, Y{i}, intervals))/nne_dict.length();
    end
    value = {intervals, mean_curve, std_curve};
else
    value = {};
end

%%% ¡prop!
PFROC (gui, item) contains the panel figure of the receiver operating characteristic curve.
%%%% ¡settings!
'PFReceiverOperatingCharacteristic'
%%%% ¡postprocessing!
if ~braph2_testing % to avoid problems with isqual when the element is recursive
    nncv.memorize('PFROC').set('NNE', nncv)
end
%%%% ¡gui!
pr = PanelPropItem('EL', nncv, 'PROP', NNClassifierCrossValidation.PFROC, ...
    'GUICLASS', 'GUIFig', ...
    varargin{:});