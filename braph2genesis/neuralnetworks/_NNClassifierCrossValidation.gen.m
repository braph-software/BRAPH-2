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
FEATURE_MASK (data, cell) is a given mask or a percentile to select relevant features.
%%%% ¡default!
num2cell(0.05)
%%%% ¡conditioning!
if ~iscell(value) & isnumeric(value)
    value = num2cell(value);
end

%%% ¡prop!
PLOT_CM (data, logical) is an option for the plot of the confusion matrix.
%%%% ¡default!
true

%%% ¡prop!
PLOT_MAP (data, logical) is an option for the plot of the heat map.
%%%% ¡default!
true

%%% ¡prop!
PLOT_ROC (data, logical) is an option for the plot of the receiver operating characteristic curve.
%%%% ¡default!
true

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
                'ID', ['kfold ', num2str(j), ' repetition ', num2str(i)], ...
                'GR1', nncv.get('GR1'), ...
                'GR2', nncv.get('GR2'), ...
                'SPLIT_GR1', idx_per_fold_gr1{j}, ...
                'SPLIT_GR2', idx_per_fold_gr2{j}, ...
                'FEATURE_MASK', nncv.get('FEATURE_MASK') ...
                );

            nnds.memorize('GR_VAL_FS');
            nnds.memorize('GR_TRAIN_FS');

            nnds_dict.add(nnds)
        end
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
    for i = 1:1:nncv.get('NNDS_DICT').length()
        nnds = nncv.get('NNDS_DICT').getItem(i);
        gr_train = nnds.get('GR_TRAIN_FS');

        nn = NNClassifierDNN( ...
                'ID', nnds.get('ID'), ...
                'GR', gr_train, ...
                'VERBOSE', false, ...
                'SHUFFLE', 'every-epoch' ...
                );
            
        nn_dict.add(nn)
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
                'ID', nn.get('ID'), ...
                'GR', gr_val, ...
                'NN', nn ...
                );
            
        nne_dict.add(nne)
    end
end

value = nne_dict;

%%% ¡prop!
GR_PREDICTION (result, item) is a group of NN subjects with prediction from NN.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
if nncv.memorize('NNE_DICT').length() > 0
    gr = nncv.get('NNE_DICT').getItem(1).get('GR_PREDICTION');
    gr_prediction = NNGroup( ...
        'ID', gr.get('ID'), ...
        'LABEL', gr.get('LABEL'), ...
        'NOTES', gr.get('NOTES'), ...
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
    [inputs, ~] = nn.reconstruct_inputs(gr);
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
CONTRIBUTION_MAP (result, matrix) is a heat map obtained with feature selection analysis and the AUC value.
%%%% ¡calculate!
nne_dict = nncv.memorize('NNE_DICT');
heat_map = 0;
if ~isempty(nne_dict.getItems()) && ~isempty(nne_dict.getItem(1).get('VAL_AUC'))
    for i = 1:1:nne_dict.length()
        feature_map = nne_dict.getItem(i).get('GR_PREDICTION').get('SUB_DICT').getItem(1).get('FEATURE_MASK');
        auc_val = nne_dict.getItem(i).get('AUC');
        feature_map(feature_map == 1) = auc_val{1};
        heat_map = heat_map + feature_map;
    end
    heat_map = heat_map / nne_dict.length();
    if nncv.get('PLOT_MAP')
        figure
        x = [1 size(heat_map, 2)];
        y = [0 size(heat_map, 1)];
        image(x, y, heat_map, 'CDataMapping', 'scaled')
        if string(nne_dict.getItem(i).get('NNData').get('INPUT_TYPE')) == 'graph_measures'
            ticklabel = nncv.get('MEASURES');
            fontsize = 12;
        else
            ticklabel = 0:size(heat_map, 2);
            fontsize = 5;
        end
        xticks([1:size(heat_map, 2)]);
        yticks([1:size(heat_map, 1)]);
    	xticklabels(ticklabel);
        yticklabels(0:size(heat_map, 1));
        a = get(gca,'XTickLabel');
        set(gca, 'XTickLabel', a, 'fontsize', fontsize, 'FontWeight', 'bold')
        a = get(gca,'YTickLabel');
        set(gca, 'YTickLabel', a, 'fontsize', fontsize, 'FontWeight', 'bold')
        colorbar
        directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
        if ~exist(directory, 'dir')
            mkdir(directory)
        end
        filename = [directory filesep 'cv_contribution_map.svg'];
        saveas(gcf, filename);
    end

    value = heat_map;
else
    value = heat_map;
end

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