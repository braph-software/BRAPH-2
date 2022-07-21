%% ¡header!
NNRegressorEvaluator < NNEvaluator (nne, evaluator for a neural network regressor) evaluates the performance of a neural network regressor with a specific dataset.

%% ¡description!
This evaluator evaluates the performance of a neural network regressor
on root mean square error (RMSE).

%% ¡props!

%%% ¡prop!
FEATURE_PERMUTATION_IMPORTANCE (result, cell) is feature importance evaluated by permuting the feature with random numbers
%%%% ¡calculate!
if nne.get('GR').get('SUB_DICT').length() == 0
    value = {};
else
    %%%%%%%%
    nn = nne.get('NN');
    gr = nne.get('GR');
%     mask_tmp = gr.get('SUB_DICT').getItem(1).get('FEATURE_MASK');
%     masks = {};
%     for i = 1:1:length(mask_tmp)
%         mask = mask_tmp{i};
%         [~, idx_all] = sort(mask(:), 'descend');
%         percentile = nn.get('FEATURE_SELECTION_RATIO');
%         num_top_idx = ceil(percentile * numel(mask));
%         mask(idx_all(1:num_top_idx)) = 1;
%         mask(idx_all(end - (length(idx_all) - num_top_idx - 1):end)) = 0;
%         masks{i} = mask;
%     end
    [inputs, num_features] = nn.reconstruct_inputs(gr);
    [targets, classes] = nn.reconstruct_targets(gr);
    net = nn.get('MODEL');
    feature_importance = [];
    original_loss = double(sqrt(mean((net.predict(inputs) - targets).^2)));
    if isa(net, 'NoValue') || ~BRAPH2.installed('NN', 'msgbox')
        feature_importance = 0;
    else
        parfor i = 1:1:num_features
            scram_inputs = inputs;
            permuted_value = squeeze(normrnd(mean(inputs(:, :, i, :)), std(inputs(:, :, i, :)), squeeze(size(inputs(:, :, i, :)))));
            scram_inputs(:, :, i, :) = permuted_value;
            scram_loss = double(sqrt(mean((net.predict(scram_inputs) - targets).^2)));
            feature_importance(i)= scram_loss/original_loss;
        end
    end
    feature_importance = rescale(feature_importance);
    feature_importance = reshape(feature_importance, gr.get('SUB_DICT').getItem(1).get('BA').get('BR_DICT').length(), []);

    value = {rescale(feature_importance)};
end

%%% ¡prop!
PFFI (gui, item) contains the panel figure of the feature importance.
%%%% ¡settings!
'PFFeatureImportance'
%%%% ¡postprocessing!
if ~braph2_testing % to avoid problems with isqual when the element is recursive
    nne.memorize('PFFI').set('NNE', nne)
end
%%%% ¡gui!
pr = PanelPropItem('EL', nne, 'PROP', NNRegressorEvaluator.PFFI, ...
    'GUICLASS', 'GUIFig', ...
    varargin{:});

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
    value = double(sqrt(mean((preds - targets).^2)));
end

%%% ¡prop!
SCATTER_CHART (result, matrix) creates a scatter chart with circular markers at the locations specified by predictions and targets.
%%%% ¡calculate!
if nne.get('GR_PREDICTION').get('SUB_DICT').length() == 0
    value = 0;
else
    preds = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nne.memorize('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    preds = cell2mat(preds);
    targets = cellfun(@(x) cell2mat(x.get('TARGET')), nne.get('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    targets = cell2mat(targets);
    value = double([preds' targets']);
% % %         figure
% % %         scatter(preds, targets);
% % %         hold on
% % %         plot([min(preds) max(preds)], [min(targets) max(targets)]);
% % %         hold off
% % %         xlabel('Prediction')
% % %         ylabel('Target')
% % %         title('Scatter plot for regression')
% % %         directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
% % %         if ~exist(directory, 'dir')
% % %             mkdir(directory)
% % %         end
% % %         filename = [directory filesep 'scatter.svg'];
% % %         saveas(gcf, filename);
end
%%%% ¡gui_!
% % % pr = PPNNRegressorEvaluator_Scatter_Chart('EL', nne, 'PROP', NNRegressorEvaluator.SCATTER_CHART, varargin{:});

%%% ¡prop!
PFSP (gui, item) contains the panel figure of the scatter plot.
%%%% ¡settings!
'PFScatterPlot'
%%%% ¡postprocessing!
if ~braph2_testing % to avoid problems with isqual when the element is recursive
    nne.memorize('PFSP').set('NNE', nne)
end
%%%% ¡gui!
pr = PanelPropItem('EL', nne, 'PROP', NNRegressorEvaluator.PFSP, ...
    'GUICLASS', 'GUIFig', ...
    varargin{:});

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
    net = nn.get('MODEL');
    if isa(net, 'NoValue') || ~BRAPH2.installed('NN', 'msgbox')
        predictions = zeros(nn_gr.get('SUB_DICT').length(), 1);
    else
        predictions = net.predict(inputs);
    end
    nn_gr_pred = NNGroup( ...
        'SUB_CLASS', nn_gr.get('SUB_CLASS'), ...
        'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
        );

    nn_gr_pred.set( ...
        'ID', nn_gr.get('ID'), ...
        'LABEL', nn_gr.get('LABEL'), ...
        'NOTES', nn_gr.get('NOTES'), ...
        'FEATURE_SELECTION_MASK', nn_gr.get('FEATURE_SELECTION_MASK') ...
        );

    % add subejcts from all groups
    sub_dict = nn_gr_pred.get('SUB_DICT');
    subs = nn_gr.get('SUB_DICT').getItems();
    for i = 1:1:length(subs)
        sub = NNSubject( ...
            'ID', [subs{i}.get('ID') ' in ' nn_gr.get('ID')], ...
            'BA', subs{i}.get('BA'), ...
            'age', subs{i}.get('age'), ...
            'sex', subs{i}.get('sex'), ...
            'input', subs{i}.get('input'), ...
            'PREDICTION', {predictions(i, :)}, ...
            'TARGET', subs{i}.get('TARGET'), ...
            'TARGET_NAME', subs{i}.get('TARGET_NAME') ...
            );
        %sub.set('PREDICTION', {predictions(i, :)});
        sub_dict.add(sub);
    end
    nn_gr_pred.set('SUB_DICT', sub_dict);

    value = nn_gr_pred;
end