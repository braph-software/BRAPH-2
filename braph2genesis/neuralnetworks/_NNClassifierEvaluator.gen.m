%% ¡header!
NNClassifierEvaluator < NNEvaluator (nne, evaluator of a neural network classifier) evaluates the performance of a neural network classifier with a specific dataset.

%% ¡description!
This evaluator evaluates the performance of a neural network classifier
in terms of the receiver operating characteristic curve (ROC), the area under the
ROC curve (AUC) and the confusion matrix.

%% ¡props!
%%% ¡prop!
PLOT_CM (data, logical) is an option for the plot of the confusion matrix.
%%%% ¡default!
false

%%% ¡prop!
PLOT_MAP (data, logical) is an option for the plot of the feature map.
%%%% ¡default!
false

%%% ¡prop!
PLOT_ROC (data, logical) is an option for the plot of the receiver operating characteristic curve.
%%%% ¡default!
false

%%% ¡prop!
AUC (result, scalar) is an area under the curve score obtained from the dataset.
%%%% ¡calculate!
pred = nne.get('PREDICTION');
targets = nne.get('NNDATA').get('TARGETS');
classifier = nne.get('NN');
net = classifier.to_net(classifier.get('MODEL'));
class_names = net.Layers(end).Classes; 
[X, Y, T, auc] = perfcurve(categorical(targets{1}), pred(:,2), class_names(2));
if nne.get('PLOT_ROC')
    plot(X, Y, 'LineWidth', 3.0, 'Color', 'Black')
    xlabel('False positive rate') 
    ylabel('True positive rate')
    title('ROC for Classification')
    legend(sprintf('ROC (AU-ROC = %.2f)', auc), 'Location', 'southeast', 'FontSize', 12);
    legend('boxoff');
    directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
    if ~exist(directory, 'dir')
        mkdir(directory)
    end
    filename = [directory filesep 'roc.svg'];
    saveas(gcf, filename);
end

value = auc;

%%% ¡prop!
VAL_AUC (result, cell) is an area under the curve score obtained from the validation set.
%%%% ¡calculate!
pred = nne.get('VAL_PREDICTION');
targets = nne.get('NNDATA').get('VAL_TARGETS');
classifier = nne.get('NN');
net = classifier.to_net(classifier.get('MODEL'));
class_names = net.Layers(end).Classes; 
[X, Y, T, auc] = perfcurve(categorical(targets{1}), pred(:,2), class_names(2));
if nne.get('PLOT_ROC')
    plot(X, Y, 'LineWidth', 3.0, 'Color', 'Black')
    xlabel('False positive rate') 
    ylabel('True positive rate')
    title('ROC for Classification')
    legend(sprintf('ROC (AU-ROC = %.2f)', auc), 'Location', 'southeast', 'FontSize', 12);
    legend('boxoff');
    directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
    if ~exist(directory, 'dir')
        mkdir(directory)
    end
    filename = [directory filesep 'val_roc.svg'];
    saveas(gcf, filename);
end

value = {auc, X, Y};

%%% ¡prop!
CONFUSION_MATRIX (result, matrix) is a confusion matrix obtained with a cut-off of 0.5.
%%%% ¡calculate!
% get prediction
preds = nne.get('PREDICTION');
preds = preds > 0.5;

% get ground truth
targets = nne.get('NNDATA').get('TARGETS');
targets_mark = categories(categorical(targets{1}));
known = onehotencode(categorical(targets{1}), 1);

% calculate the confusion matrix
[cm, order] = confusionmat(known(2,:)', double(preds(:,2)));
if nne.get('PLOT_CM')
    figure
    heatmap(targets_mark, targets_mark, cm)
    directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
    if ~exist(directory, 'dir')
        mkdir(directory)
    end
    filename = [directory filesep 'confusion_matrix.svg'];
    saveas(gcf, filename);
end

value = cm;

%%% ¡prop!
VAL_CONFUSION_MATRIX (result, matrix) is a confusion matrix obtained with a cut-off of 0.5.
%%%% ¡calculate!
% get prediction
preds = nne.get('VAL_PREDICTION');
preds = preds > 0.5;

% get ground truth
targets = nne.get('NNDATA').get('VAL_TARGETS');
targets_mark = categories(categorical(targets{1}));
known = onehotencode(categorical(targets{1}), 1);

% calculate the confusion matrix
[cm, order] = confusionmat(known(2,:)', double(preds(:,2)));
if nne.get('PLOT_CM')
    figure
    heatmap(targets_mark, targets_mark, cm)
    directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
    if ~exist(directory, 'dir')
        mkdir(directory)
    end
    filename = [directory filesep 'val_confusion_matrix.svg'];
    saveas(gcf, filename);
end

value = cm;

%%% ¡prop!
FEATURE_MAP (result, matrix) is a feature map obtained with feature selection analysis.
%%%% ¡calculate!
selected_idx = nne.get('NNDATA').get('FEATURE_MASK');
adjs = nne.get('NNDATA').get('TRAIN_G_DICT_1').getItem(1).get('A');
fm = zeros(length(adjs{1}));
fm(selected_idx{1}) = 1;
if nne.get('PLOT_MAP')
    figure
    image(fm, 'CDataMapping', 'scaled')
    colorbar
    directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
    if ~exist(directory, 'dir')
        mkdir(directory)
    end
    filename = [directory filesep 'connection_mask.svg'];
    saveas(gcf, filename);
end

value = fm;

%% ¡props_update!
%%% ¡prop!
NNDATA (data, item) is a dataset for testing the neural networks.
%%%% ¡settings!
'NNClassifierData'

%%% ¡prop!
PREDICTION (result, matrix) is an output matrix of prediction from a neural network model.
%%%% ¡calculate!
nnd = nne.get('NNDATA');
classifier = nne.get('NN');
net = classifier.to_net(classifier.get('MODEL'));
inputs = nnd.get('INPUTS');
inputs = inputs{1};
inputs = reshape(inputs, [1, 1, size(inputs,1), size(inputs,2)]);

value = net.predict(inputs);

%%% ¡prop!
VAL_PREDICTION (result, matrix) is an output matrix of prediction for the validation set.
%%%% ¡calculate!
nnd = nne.get('NNDATA');
classifier = nne.get('NN');
net = classifier.to_net(classifier.get('MODEL'));
inputs = nnd.get('VAL_INPUTS');
inputs = inputs{1};
inputs = reshape(inputs, [1, 1, size(inputs,1), size(inputs,2)]);

value = net.predict(inputs);