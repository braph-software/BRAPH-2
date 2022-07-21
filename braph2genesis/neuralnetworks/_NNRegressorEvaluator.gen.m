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
elseif any(ismember(nne.get('GR').get('SUB_DICT').getItem(1).get('INPUT_LABEL'), subclasses('Graph', [], [], true))) && nne.get('NN').get('FEATURE_SELECTION_RATIO') == 1
    % now it only works for (1) input being adj of a graph and (2) no feature selection 
    nn = nne.get('NN');
    gr = nne.get('GR');
    net = nn.get('MODEL');

    [inputs, num_features] = nn.reconstruct_inputs(gr);
    [targets, classes] = nn.reconstruct_targets(gr);

    original_loss = double(sqrt(mean((net.predict(inputs) - targets).^2)));

    if isa(net, 'NoValue') || ~BRAPH2.installed('NN', 'msgbox')
        value = {};
    else
        % scramble the input feature 1 by 1
        parfor i = 1:1:num_features
            scrambled_inputs = inputs;
            permuted_value = squeeze(normrnd(mean(inputs(:, :, i, :)), std(inputs(:, :, i, :)), squeeze(size(inputs(:, :, i, :)))));
            scrambled_inputs(:, :, i, :) = permuted_value;
            scrambled_loss = double(sqrt(mean((net.predict(scrambled_inputs) - targets).^2)));
            feature_importance(i)= scrambled_loss / original_loss;
        end
        feature_importance = reshape(feature_importance, gr.get('SUB_DICT').getItem(1).get('BA').get('BR_DICT').length(), []);

        % re-assign the cell array when the input is obtained from a multigraph
        if size(feature_importance, 1) < size(feature_importance, 2) && mod(size(feature_importance, 2), size(feature_importance, 1)) == 0
            n = size(feature_importance, 2) / size(feature_importance, 1);
            feature_importance_tmp = feature_importance;
            for i = 1:1:n
                istart = (i - 1) * size(feature_importance_tmp, 1) + 1;
                iend = i*size(feature_importance_tmp, 1);
                feature_importances{i} = double(rescale(feature_importance_tmp(:, istart:iend)));
            end
            value = feature_importances;
        else
            value = {rescale(double(feature_importance))};
        end
    end
else
    value = {};
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
end
%%%% ¡gui_!
% % % pr = PanelPropMatrix('EL', nne, 'PROP', NNRegressorEvaluator.SCATTER_CHART, ...
% % %     'ROWNAME', {'Prediction', 'Target'},...
% % %     'COLUMNNAME', {cellfun(@(x) cell2mat(x.get('ID'))', nne.memorize('GR').get('SUB_DICT').getItems(), 'UniformOutput', false)},...
% % %     varargin{:});

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

    % add subejcts, it has to be created as new subjects
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
        sub_dict.add(sub);
    end
    nn_gr_pred.set('SUB_DICT', sub_dict);

    value = nn_gr_pred;
end