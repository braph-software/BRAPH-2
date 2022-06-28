%% ¡header!
NNClassifierCrossValidation < Element (nncv, cross-validation for neural network classifiers) cross-validate the performance of neural network classifiers with a dataset.

%% ¡description!
This cross validation perform a k-fold cross validation of a neural network
classifier with desired repetitions on a dataset. The dataset is split into
k consecutive folds with shuffling by default, and each fold is then used 
once as a validation while the k-1 remaining folds from the training set. 
The confusion matrix, ROC curves, AUCs, and weighted contributing maps will
be calculated across folds and repetitions.

%% ¡props!
%%% ¡prop!
ID (data, string) is a few-letter code for the cross validation.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the cross validation.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the cross validation.

%%% ¡prop!
KFOLD (data, scalar) is the number of folds.
%%%% ¡default!
5

%%% ¡prop!
REPETITION (data, scalar) is the number of repetitions.
%%%% ¡default!
1

%%% ¡prop!
GR1 (data, item) is is a group of subjects.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
GR2 (data, item) is is a group of subjects.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
FEATURE_MASK (parameter, cell) is a given mask or a percentile to select relevant features.
%%%% ¡default!
num2cell(0.05)
%%%% ¡conditioning!
if ~iscell(value) & isnumeric(value)
    value = num2cell(value);
end
%%%% ¡gui!
pr = PlotPropSmartVector('EL', nncv, 'PROP', NNClassifierCrossValidation.FEATURE_MASK, 'MAX', 10000000, 'MIN', 0, varargin{:});


%%% ¡prop!
PLOT_CM (data, logical) is an option for the plot of the confusion matrix.
%%%% ¡default!
false

%%% ¡prop!
PLOT_MAP (data, logical) is an option for the plot of the heat map.
%%%% ¡default!
false

%%% ¡prop!
PLOT_ROC (data, logical) is an option for the plot of the receiver operating characteristic curve.
%%%% ¡default!
false

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
    for i = 1:1:nncv.get('REPETITION')
        idx_per_fold_gr1 = nncv.get('SPLIT_KFOLD_GR1');
        idx_per_fold_gr2 = nncv.get('SPLIT_KFOLD_GR2');
        for j = 1:1:nncv.get('KFOLD')
            nnds = NNClassifierDataSplit( ...
                'ID', ['NN dataset for fold #', num2str(j), ' in repetition #', num2str(i)], ...
                'GR1', nncv.get('GR1'), ...
                'GR2', nncv.get('GR2'), ...
                'SPLIT_GR1', idx_per_fold_gr1{j}, ...
                'SPLIT_GR2', idx_per_fold_gr2{j}, ...
                'FEATURE_MASK', nncv.get('FEATURE_MASK') ...
                );

            nnds_dict.add(nnds)
        end
    end
end

value = nnds_dict;
%%%% ¡gui!
pr = PPNNCrossValidation_NNDict('EL', nncv, 'PROP', NNClassifierCrossValidation.NNDS_DICT, varargin{:});

%%% ¡prop!
NN_DICT (result, idict) contains the NN classifiers for k folds for all repetitions.
%%%% ¡settings!
'NNClassifierDNN'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'NNClassifierDNN')
%%%% ¡calculate!
nn_dict = IndexedDictionary('IT_CLASS', 'NNClassifierDNN');
if nncv.memorize('NNDS_DICT').length() > 0
    for i = 1:1:nncv.get('NNDS_DICT').length()
        nnds = nncv.get('NNDS_DICT').getItem(i);
        gr_train = nnds.get('GR_TRAIN_FS');
        
        if length(nncv.get('FEATURE_MASK')) == 1 && length(cell2mat(nncv.get('FEATURE_MASK'))) == 1 % given percentile
            ratio = cell2mat(nncv.get('FEATURE_MASK'));
        else
            ratio = 1.0;
        end

        nn = NNClassifierDNN( ...
            'ID', ['NN model cooperated with ', nnds.get('ID')], ...
            'GR', gr_train, ...
            'FEATURE_SELECTION_RATIO', ratio, ...
            'PLOT_TRAINING', false, ...
            'SHUFFLE', 'every-epoch' ...
            );
            
        nn_dict.add(nn)
    end
end

value = nn_dict;
%%%% ¡gui!
pr = PPNNCrossValidation_NNDict('EL', nncv, 'PROP', NNClassifierCrossValidation.NN_DICT, varargin{:});

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
            
        nne_dict.add(nne)
    end
end

value = nne_dict;
%%%% ¡gui!
pr = PPNNCrossValidation_NNDict('EL', nncv, 'PROP', NNClassifierCrossValidation.NNE_DICT, varargin{:});

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
        'NOTES', 'All of the predictions are obtained from the validation of each fold', ...
        'SUB_CLASS', gr.get('SUB_CLASS'), ...
        'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject') ...
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
%%%% ¡gui!
pr = PPNNData_GR_NN('EL', nncv, 'PROP', NNClassifierCrossValidation.GR_PREDICTION, varargin{:});

%%% ¡prop!
CONFUSION_MATRIX (result, matrix) is an add-up confusion matrix across k folds for all repeitions.
%%%% ¡calculate!
if nncv.memorize('GR_PREDICTION').get('SUB_DICT').length() == 0
    value = [];
else
    pred = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nncv.get('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    pred = cell2mat(pred);
    pred = pred > 0.5;

    % get ground truth
    nn = nncv.get('NN_DICT').getItem(1);
    gr = nncv.get('GR_PREDICTION');
    [targets, classes] = nn.reconstruct_targets(gr);
    % calculate the confusion matrix
	[cm, order] = confusionmat(targets(2, :), double(pred(2, :)));
    if nncv.get('PLOT_CM')
        figure
        heatmap(classes, classes, cm)
        directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
        if ~exist(directory, 'dir')
            mkdir(directory)
        end
        filename = [directory filesep 'confusion_matrix.svg'];
        saveas(gcf, filename);
    end

    value = cm;
end
%%%% ¡gui!
pr = PPNNClassifierCrossValidation_Confusion_Matrix('EL', nncv, 'PROP', NNClassifierCrossValidation.CONFUSION_MATRIX, varargin{:});

%%% ¡prop!
AUC (result, cell) is the area under the curve scores across k folds for all repetitions.
%%%% ¡calculate!
nne_dict = nncv.memorize('NNE_DICT');
auc = {};
X = {};
Y = {};
if nne_dict.length() > 0
    for i = 1:1:nne_dict.length()
        auc_val = nne_dict.getItem(i).get('AUC');
        auc{i} = auc_val{1};
        X{i} = auc_val{2};
        Y{i} = auc_val{3};
    end

    if nncv.get('PLOT_ROC')
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
            mean_curve = mean_curve + (interp1(Xadjusted, Y{i}, intervals))/nne_dict.length();
        end
        hline(i + 1) = plot(intervals, mean_curve, 'Color', 'Black', 'LineWidth', 3.0);
        xlabel('False positive rate');
        ylabel('True positive rate');
        title('ROC for Classification');
        legend(hline(i+1), sprintf('average ROCs (AU-ROC = %.2f)', mean(cell2mat(auc))), 'Location', 'southeast', 'FontSize', 12);
        legend('boxoff');
        directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
        if ~exist(directory, 'dir')
            mkdir(directory)
        end
        filename = [directory filesep 'cv_roc.svg'];
        saveas(gcf, filename);
    end
    value = {auc, X, Y};
else
    value = {};
end
%%%% ¡gui!
pr = PPNNClassifierCrossValidation_AUC('EL', nncv, 'PROP', NNClassifierCrossValidation.AUC, varargin{:});

%%% ¡prop!
AUC_CIU (result, scalar) is the upper boundary of 95% confident internal for AUC.
%%%% ¡calculate!
auc = nncv.get('AUC');
if isempty(auc)
    value = 0;
else
    [~, CI] = nncv.get_CI(auc{1});
    value = CI(2);
end

%%% ¡prop!
AUC_CIL (result, scalar) is the lower boundary of 95% confident internal for AUC.
%%%% ¡calculate!
auc = nncv.get('AUC');
if isempty(auc)
    value = 0;
else
    [~, CI] = nncv.get_CI(auc{1});
    value = CI(1);
end

%%% ¡prop!
FEATURE_MAP (result, cell) is a heat map obtained with feature selection analysis and the AUC value.
%%%% ¡calculate!
nne_dict = nncv.memorize('NNE_DICT');
heat_map = {};
if ~isempty(nne_dict.getItems()) && ~isempty(nne_dict.getItem(1).get('AUC')) && ~any(ismember(subclasses('Measure'), nncv.get('GR_PREDICTION').get('SUB_DICT').getItem(1).get('INPUT_LABEL')))
    tmp_map = nne_dict.getItem(1).get('GR_PREDICTION').get('SUB_DICT').getItem(1).get('FEATURE_MASK');
    for i = 1:1:length(tmp_map)
        heat_map{i} = zeros(size(tmp_map{i}));
    end
    for i = 1:1:nne_dict.length()
        feature_map = nne_dict.getItem(i).get('GR_PREDICTION').get('SUB_DICT').getItem(1).get('FEATURE_MASK');
        auc_val = nne_dict.getItem(i).get('AUC');
        feature_map_out = feature_map;
        for j = 1:1:length(feature_map)
            fm_tmp = feature_map{j};
            fm_tmp(fm_tmp == 1) = auc_val{1};
            feature_map_out{j} = fm_tmp;
        end
        heat_map = cellfun(@(x, y) x + y, heat_map, feature_map_out, 'UniformOutput', false);
    end
    heat_map = cellfun(@(x) x / nne_dict.length(), heat_map, 'UniformOutput', false);
    if nncv.get('PLOT_MAP')
        for i = 1:1:length(heat_map)
            heat_map_tmp = heat_map{i};
            figure
            x = [1 size(heat_map_tmp, 2)];
            y = [0 size(heat_map_tmp, 1)];
            image(x, y, heat_map_tmp, 'CDataMapping', 'scaled')
            colorbar
            directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
            if ~exist(directory, 'dir')
                mkdir(directory)
            end
            filename = [directory filesep 'cv_feature_map.svg'];
            saveas(gcf, filename);
        end
    end
else
    %TODO: check the msgbox is needed 
    %braph2msgbox("No visualization for the feature map", "For now, we only provide the feature map visualization for input of adjacency matrix or structural data.")
end

value = heat_map;
%%%% ¡gui!
pr = PPNNCrossValidation_Feature_Map('EL', nncv, 'PROP', NNClassifierCrossValidation.FEATURE_MAP, varargin{:});


%% ¡methods!
function [avg, CI] = get_CI(nncv, scores)
    %GET_CI calculates the 95% confidence interval.
    % 
    % [AVG, CI] = GET_CI(NNCV, SCORES) calculates the 95% confidence interval
    %  of the input scores which are in a form of rvector. AVG is the mean 
    %  value of the input scores. CI are the upper and lower boundary of
    %  the corresponding 95% confidence interval.

    avg = mean(scores);
    SEM = std(scores)/sqrt(length(scores));               
    ts = tinv([0.025  0.975],length(scores)-1);     
    CI = avg + ts*SEM;
end