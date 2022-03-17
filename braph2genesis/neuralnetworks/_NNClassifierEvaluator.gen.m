%% ¡header!
NNClassifierEvaluator < NNEvaluator (nne, evaluator for a neural network classifier) evaluates the performance of a neural network classifier with a specific dataset.

%% ¡description!
This evaluator evaluates the performance of a neural network classifier
in terms of the receiver operating characteristic curve (ROC), the area 
under the ROC curve (AUC), and the confusion matrix.

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
AUC (result, cell) is an area under the curve score obtained from the dataset.
%%%% ¡calculate!
if nne.get('NN_GR_PREDICTION').get('SUB_DICT').length() == 0
    value = {};
else
    pred = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nne.memorize('NN_GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    pred = cell2mat(pred);
    y = cellfun(@(x) x.get('TARGET'), nne.memorize('NN_GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    y = categorical(y);
    classes = categories(y);
    targets = onehotencode(y, 1);
    [X, Y, T, auc] = perfcurve(y, pred(2, :), classes(2));
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

    value = {auc, X, Y};
end

%%% ¡prop!
CONFUSION_MATRIX (result, matrix) is a confusion matrix obtained with a cut-off of 0.5.
%%%% ¡calculate!
if nne.get('NN_GR_PREDICTION').get('SUB_DICT').length() == 0
    value = [];
else
    pred = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nne.memorize('NN_GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    pred = cell2mat(pred);
    pred = pred > 0.5;

    % get ground truth
    y = cellfun(@(x) x.get('TARGET'), nne.get('NN_GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    y = categorical(y);
    classes = categories(y);
    targets = onehotencode(y, 1);
    %targets_mark = categories(onehotdecode(targets, classes, 2));
    % calculate the confusion matrix
    [cm, order] = confusionmat(targets(2, :), double(pred(2, :)));
    if nne.get('PLOT_CM')
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
FEATURE_MAP (result, cell) is a feature map obtained with feature selection analysis.
%%%% ¡calculate!
value = nne.get('NN_GR').get('FEATURE_MASK');
% % mask = nne.get('NN_GR_PREDICTION').get('FEATURE_MASK');
% % if ~isempty(selected_idx)
% %     switch string(nne.get('NNDATA').get('INPUT_TYPE'))
% %         case 'graph_measures'
% %             feature = nne.get('NNDATA').get('MEASURES');
% %             x_ticklabel = feature;
% %             y_ticklabel = '';
% %             fontsize = 12;
% % 
% %         case 'adjacency_matrices'
% %             x_ticklabel = 0:size(fm, 2);
% %             y_ticklabel = 0:size(fm, 1);
% %             fontsize = 5;
% % 
% %         case 'structural_data'
% %             data = nne.get('NNDATA').data_construction(nne.get('NNDATA').get('GR1'));
% %             feature = data{1};
% %             fm = zeros(1, length(feature));
% %             br = nne.get('NNDATA').get('GR1').get('SUB_DICT').getItem(1).get('BA').get('BR_DICT').getItems();
% %             br = cellfun(@(v)v.get('ID'), br, 'UniformOutput', false);
% %             x_ticklabel = br;
% %             y_ticklabel = '';
% %             fontsize = 5;
% %         otherwise
% %     end
% % 
% % 
% %     if nne.get('PLOT_MAP')
% %         figure
% %         x = [1 size(fm, 2)];
% %         y = [0 size(fm, 1)];
% %         image(x, y, mask{1}, 'CDataMapping', 'scaled')
% % 
% %         xticks([1:size(fm, 2)]);
% %         yticks([1:size(fm, 1)]);
% %         xticklabels(x_ticklabel);
% %         yticklabels(y_ticklabel);
% %         a = get(gca,'XTickLabel');
% %         set(gca, 'XTickLabel', a, 'fontsize', fontsize, 'FontWeight', 'bold')
% %         a = get(gca,'YTickLabel');
% %         set(gca, 'YTickLabel', a, 'fontsize', fontsize, 'FontWeight', 'bold')
% %         colorbar
% %         directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
% %         if ~exist(directory, 'dir')
% %             mkdir(directory)
% %         end
% %         filename = [directory filesep 'connection_mask.svg'];
% %         saveas(gcf, filename);
% %     end
% % 
% %     value = fm;
% % else
% %     value = [];
% % end

%% ¡props_update!
%%% ¡prop!
NN (data, item) is a neural network model that needs to be evaluated.
%%%% ¡settings!
'NNClassifierDNN'
%%%% ¡default!
NNClassifierDNN()

%%% ¡prop!
NN_GR_PREDICTION (result, item) is a group of NN subjects containing the prediction from the neural network.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
if nne.get('NN_GR').get('SUB_DICT').length() == 0
    value = NNGroup();
else
    nn = nne.get('NN');
    nn_gr = nne.get('NN_GR');
    inputs = nn.construct_inputs(nn_gr);
    net = nn.to_net(nn.get('MODEL'));
    predictions = net.predict(inputs);

    nn_gr_pred = NNGroup( ...
        'SUB_CLASS', nn_gr.get('SUB_CLASS'), ...
        'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
        );

    nn_gr_pred.set( ...
        'ID', nn_gr.get('ID'), ...
        'LABEL', nn_gr.get('LABEL'), ...
        'NOTES', nn_gr.get('NOTES'), ...
        'FEATURE_LABEL', nn_gr.get('FEATURE_LABEL'), ...
        'FEATURE_MASK', nn_gr.get('FEATURE_MASK') ...
        );

    % add subejcts from all groups
    sub_dict = nn_gr_pred.get('SUB_DICT');
    subs = nn_gr.get('SUB_DICT').getItems();
    for i = 1:1:length(subs)
        sub = subs{i}.deepclone();
        sub.set('PREDICTION', {predictions(i, :)});
        sub_dict.add(sub);
    end
    nn_gr_pred.set('SUB_DICT', sub_dict);

    value = nn_gr_pred;
end