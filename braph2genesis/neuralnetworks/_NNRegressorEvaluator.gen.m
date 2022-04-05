%% ¡header!
NNRegressorEvaluator < NNEvaluator (nne, evaluator for a neural network regressor) evaluates the performance of a neural network regressor with a specific dataset.

%% ¡description!
This evaluator evaluates the performance of a neural network regressor
on root mean square error (RMSE).

%% ¡props!
%%% ¡prop!
PLOT_MAP (data, logical) is an option for the plot of the feature map.
%%%% ¡default!
false

%%% ¡prop!
RMSE (result, scalar) is the root mean squared error between targets and predictions for validation set.
%%%% ¡calculate!
if nne.get('GR_PREDICTION').get('SUB_DICT').length() == 0
    value = 0;
else
    preds = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nne.memorize('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    preds = cell2mat(preds);
    targets = cellfun(@(x) cell2mat(x.get('TARGET')), nne.get('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    targets = cell2mat(targets);
    value = sqrt(mean((preds - targets).^2));
end

%%% ¡prop!
SCATTER_PLOT (result, scalar) creates a scatter plot with circular markers at the locations specified by predictions and targets.
%%%% ¡calculate!
if nne.get('GR_PREDICTION').get('SUB_DICT').length() == 0
    value = 0;
else
    preds = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nne.memorize('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    preds = cell2mat(preds);
    targets = cellfun(@(x) cell2mat(x.get('TARGET')), nne.get('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    targets = cell2mat(targets);
    figure
    scatter(preds, targets);
    hold on
    plot([min(preds) max(preds)], [min(targets) max(targets)]);
    hold off
    plot()
    xlabel('Prediction')
    ylabel('Target')
    title('Scatter plot for regression')
    directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
    if ~exist(directory, 'dir')
        mkdir(directory)
    end
    filename = [directory filesep 'roc.svg'];
    saveas(gcf, filename);
    value = 0;
end

%%% ¡prop!
FEATURE_MAP (result, cell) is a feature map obtained with feature selection analysis.
%%%% ¡calculate!
sub_dict = nne.get('GR').get('SUB_DICT');
if sub_dict.length() == 0
    value = {};
else
    value = sub_dict.getItem(1).get('FEATURE_MASK');
end

% TODO: visulazie the feature maps for all cases
% % % selected_idx = nne.get('NNDATA').get('FEATURE_MASK');
% % % if length(selected_idx) == 1 && abs(selected_idx) <= 1
% % %     selected_idx = nne.get('NNDATA').get('FEATURE_MASK_ANALYSIS');
% % % end
% % % if ~isempty(selected_idx)
% % %     switch string(nne.get('NNDATA').get('INPUT_TYPE'))
% % %         case 'graph_measures'
% % %             feature = nne.get('NNDATA').get('MEASURES');
% % %             fm = zeros(1, length(feature));
% % %             x_ticklabel = feature;
% % %             y_ticklabel = '';
% % %             fontsize = 12;
% % % 
% % %         case 'adjacency_matrices'
% % %             feature = nne.get('NNDATA').get('TRAIN_G_DICT').getItem(1).get('A');
% % %             fm = zeros(length(feature{1}));
% % %             x_ticklabel = 0:size(fm, 2);
% % %             y_ticklabel = 0:size(fm, 1);
% % %             fontsize = 5;
% % % 
% % %         case 'structural_data'
% % %             data = nne.get('NNDATA').data_construction(nne.get('NNDATA').get('GR'));
% % %             feature = data{1};
% % %             fm = zeros(1, length(feature));
% % %             br = nne.get('NNDATA').get('GR').get('SUB_DICT').getItem(1).get('BA').get('BR_DICT').getItems();
% % %             br = cellfun(@(v)v.get('ID'), br, 'UniformOutput', false);
% % %             x_ticklabel = br;
% % %             y_ticklabel = '';
% % %             fontsize = 5;
% % %         otherwise
% % %     end
% % % 
% % %     fm(selected_idx) = 1;
% % % 
% % %     if nne.get('PLOT_MAP')
% % %         figure
% % %         x = [1 size(fm, 2)];
% % %         y = [0 size(fm, 1)];
% % %         image(x, y, fm, 'CDataMapping', 'scaled')
% % % 
% % %         xticks([1:size(fm, 2)]);
% % %         yticks([1:size(fm, 1)]);
% % %         xticklabels(x_ticklabel);
% % %         yticklabels(y_ticklabel);
% % %         a = get(gca,'XTickLabel');
% % %         set(gca, 'XTickLabel', a, 'fontsize', fontsize, 'FontWeight', 'bold')
% % %         a = get(gca,'YTickLabel');
% % %         set(gca, 'YTickLabel', a, 'fontsize', fontsize, 'FontWeight', 'bold')
% % %         colorbar
% % %         directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
% % %         if ~exist(directory, 'dir')
% % %             mkdir(directory)
% % %         end
% % %         filename = [directory filesep 'connection_mask.svg'];
% % %         saveas(gcf, filename);
% % %     end
% % % 
% % %     value = fm;
% % % else
% % %     value = [];
% % % end

%% ¡props_update!

%%% ¡prop!
NN (data, item) is a neural network model that needs to be evaluated.
%%%% ¡settings!
'NNRegressorDNN'
%%%% ¡default!
NNRegressorDNN()

%%% ¡prop!
GR_PREDICTION (result, item) is a group of NN subjects containing the prediction from the neural network.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
if nne.get('GR').get('SUB_DICT').length() == 0
    value = NNGroup();
else
    nn = nne.get('NN');
    nn_gr = nne.get('GR');
    inputs = nn.reconstruct_inputs(nn_gr);
    net = nn.to_net(nn.get('MODEL'));
    predictions = net.predict(inputs);

    nn_gr_pred = NNGroup( ...
        'SUB_CLASS', nn_gr.get('SUB_CLASS'), ...
        'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
        );

    nn_gr_pred.set( ...
        'ID', nn_gr.get('ID'), ...
        'LABEL', nn_gr.get('LABEL'), ...
        'NOTES', nn_gr.get('NOTES') ...
        );

    % add subejcts
    sub_dict = nn_gr_pred.get('SUB_DICT');
    subs = nn_gr.get('SUB_DICT').getItems();
    for i = 1:1:length(subs)
        sub = subs{i}.deepclone();
        sub.set('PREDICTION', {predictions(i)});
        sub_dict.add(sub);
    end
    nn_gr_pred.set('SUB_DICT', sub_dict);

    value = nn_gr_pred;
end