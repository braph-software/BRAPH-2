%% ¡header!
NNClassifierCV < Element (nncv, cross-validation of a neural network classifier) cross-validate the performance of a neural network classifier .

%% ¡description!
This cross validation performan k-fold cross validation of a neural network
classifier with desired repetitions. The dataset is split into k consecutive 
folds with shuffling by default, and each fold is then used once as a 
validation while the k-1 remaining folds form the training set. 
The confusion matrix, ROC curves, AUCs, and weighted contributing maps will
be calculated across folds.

%% ¡props!
%%% ¡prop!
KFOLD (data, scalar) is the number of folds
%%%% ¡default!
5

%%% ¡prop!
REPETITION (data, scalar) is the number of repetition
%%%% ¡default!
5

%%% ¡prop!
GR1 (data, item) is the subject group 1.
%%%% ¡settings!
'Group'

%%% ¡prop!
GR2 (data, item) is the subject group 2.
%%%% ¡settings!
'Group'

%%% ¡prop!
INPUT_TYPE (data, option) is the input type for training or testing the NN.
%%%% ¡settings!
{'adjacency_matrices' 'graph_measures'}

%%% ¡prop!
MEASURES (data, cell) is the graph measures as input to NN.
%%%% ¡default!
{'DegreeAv', 'DegreeAv', 'DegreeAv', 'DegreeAv', 'DegreeAv'}

%%% ¡prop!
FEATURE_MASK (data, scalar) is a mask for selected features.
%%%% ¡default!
0.05

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
SPLIT_KFOLD_GR1 (result, rvector) is a vector stating which subjects belong to each fold.
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
SPLIT_KFOLD_GR2 (result, rvector) is a vector stating which subjects belong to each fold.
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
CONFUSION_MATRIX (result, matrix) is an add-up confusion matrix across k folds for all repeition.
%%%% ¡calculate!
nne_dict = nncv.memorize('NNE_DICT');
cm_val = 0;
for i = 1:1:nne_dict.length()
    cm_val = cm_val + nne_dict.getItem(i).memorize('VAL_CONFUSION_MATRIX');
end
if nncv.get('PLOT_CM')
    targets = nne_dict.getItem(i).get('NNDATA').get('TARGETS');
    targets_mark = categories(categorical(targets{1}));
    figure
    heatmap(targets_mark, targets_mark, cm_val)
    directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
    if ~exist(directory, 'dir')
        mkdir(directory)
    end
    filename = [directory filesep 'cv_confusion_matrix.svg'];
    saveas(gcf, filename);
end

value = cm_val;

%%% ¡prop!
AUC (result, rvector) is the area under the curve scores across k folds for all repeition..
%%%% ¡calculate!
nne_dict = nncv.memorize('NNE_DICT');
auc = {};
X = {};
Y = {};
for i = 1:1:nne_dict.length()
    auc_val = nne_dict.getItem(i).memorize('VAL_AUC');
    auc{i} = auc_val{1};
    X{i} = auc_val{2};
    Y{i} = auc_val{3};
end

if nncv.get('PLOT_ROC')
    intervals = linspace(0, 1, 100);
    mean_curve = 0;
    for i = 1:1:nne_dict.length()
        hline(i) = plot(X{i}, Y{i},'k-', 'LineWidth', 1.5);
        hline(i).Color = [hline(i).Color 0.05];
        hold on;
        Xadjusted = zeros(1, length(X{i}));
        aux= 0.00001;
        for i = 1 : length(X{i})
            if i ~= 1
                Xadjusted(i) = X{i}(i) + aux;
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

value = cell2mat(auc);

%%% ¡prop!
AUC_CIU (result, scalar) is the upper boundary of 95% confident internal for AUC.
%%%% ¡calculate!
auc = nncv.get('AUC');
[~, CI] = nncv.get_CI(auc);

value = CI(2);

%%% ¡prop!
AUC_CIL (result, scalar) is the lower boundary of 95% confident internal for AUC.
%%%% ¡calculate!
auc = nncv.get('AUC');
[~, CI] = nncv.get_CI(auc);

value = CI(1);

%%% ¡prop!
CONTRIBUTION_MAP (result, matrix) is a heat map obtained with feature selection analysis and the AUC value.
%%%% ¡calculate!
nne_dict = nncv.memorize('NNE_DICT');
heat_map = 0;
for i = 1:1:nne_dict.length()
    feature_map =  nne_dict.getItem(i).memorize('FEATURE_MAP');
    auc_val = nne_dict.getItem(i).memorize('VAL_AUC');
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
        ticklabel = nne_dict.getItem(i).get('NNDATA').get('MEASURES');
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

%%% ¡prop!
NNE_DICT (result, idict) is the NN evaluators for k folds.
%%%% ¡settings!
'NNClassifierEvaluator'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'NNClassifierEvaluator')

%% ¡methods!
function [avg, CI] = get_CI(nncv, scores)
    avg = mean(scores);
    SEM = std(scores)/sqrt(length(scores));               % Standard Error
    ts = tinv([0.025  0.975],length(scores)-1);      % T-Score
    CI = avg + ts*SEM;
end