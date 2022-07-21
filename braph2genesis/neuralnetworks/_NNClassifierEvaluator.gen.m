%% ¡header!
NNClassifierEvaluator < NNEvaluator (nne, evaluator for a neural network classifier) evaluates the performance of a neural network classifier with a specific dataset.

%% ¡description!
This evaluator evaluates the performance of a neural network classifier
in terms of the receiver operating characteristic curve (ROC), the area 
under the ROC curve (AUC), and the confusion matrix.

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
    original_loss = crossentropy(net.predict(inputs)', targets);
    if isa(net, 'NoValue') || ~BRAPH2.installed('NN', 'msgbox')
        feature_importance = 0;
    else
        parfor i = 1:1:num_features
            scram_inputs = inputs;
            permuted_value = squeeze(normrnd(mean(inputs(:, :, i, :)), std(inputs(:, :, i, :)), squeeze(size(inputs(:, :, i, :)))));
            scram_inputs(:, :, i, :) = permuted_value;
            scram_loss = crossentropy(net.predict(scram_inputs)', targets);
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
pr = PanelPropItem('EL', nne, 'PROP', NNClassifierEvaluator.PFFI, ...
    'GUICLASS', 'GUIFig', ...
    varargin{:});

%%% ¡prop!
AUC (result, scalar) is an area under the curve score.
%%%% ¡calculate!
if nne.get('GR_PREDICTION').get('SUB_DICT').length() == 0
    value = {};
else
    pred = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nne.memorize('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    pred = cell2mat(pred);
    nn = nne.get('NN');
    gr = nne.get('GR');
    [inputs, ~] = nn.reconstruct_inputs(gr);
    [targets, classes] = nn.reconstruct_targets(gr);
    targets = onehotdecode(targets, classes, 1);
    [X, Y, T, auc] = perfcurve(targets, pred(2, :), classes(2));

    value = double(auc);
end
%%%% ¡gui_!
% % % pr = PPNNClassifierEvaluator_AUC('EL', nne, 'PROP', NNClassifierEvaluator.AUC, varargin{:});

%%% ¡prop!
ROC (result, cell) is a receiver operating characteristic curve.
%%%% ¡calculate!
if nne.get('GR_PREDICTION').get('SUB_DICT').length() == 0
    value = {};
else
    pred = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nne.memorize('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    pred = cell2mat(pred);
    nn = nne.get('NN');
    gr = nne.get('GR');
    [inputs, ~] = nn.reconstruct_inputs(gr);
    [targets, classes] = nn.reconstruct_targets(gr);
    targets = onehotdecode(targets, classes, 1);
    [X, Y, T, auc] = perfcurve(targets, pred(2, :), classes(2));
    value = {X, Y};
end

%%% ¡prop!
PFROC (gui, item) contains the panel figure of the receiver operating characteristic curve.
%%%% ¡settings!
'PFReceiverOperatingCharacteristic'
%%%% ¡postprocessing!
if ~braph2_testing % to avoid problems with isqual when the element is recursive
    if isa(nne.getr('PFROC'), 'NoValue')
        nne.memorize('PFROC').set('NNE', nne)
    else
        nne.set('PFROC', PFReceiverOperatingCharacteristic('NNE', nne))
    end    
end
%%%% ¡gui!
pr = PanelPropItem('EL', nne, 'PROP', NNClassifierEvaluator.PFROC, ...
    'GUICLASS', 'GUIFig', ...
    varargin{:});

%%% ¡prop!
CONFUSION_MATRIX (result, matrix) is a confusion matrix obtained with a cut-off of 0.5.
%%%% ¡calculate!
if nne.get('GR_PREDICTION').get('SUB_DICT').length() == 0
    value = [];
else
    pred = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nne.memorize('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    pred = cell2mat(pred);
    pred = pred > 0.5;

    % get ground truth
    nn = nne.get('NN');
    gr = nne.get('GR');
    [inputs, ~] = nn.reconstruct_inputs(gr);
    [targets, classes] = nn.reconstruct_targets(gr);
    % calculate the confusion matrix
	[cm, order] = confusionmat(targets(2, :), double(pred(2, :)));
    value = cm;
end
%%%% ¡gui_!
% % % pr = PanelPropCell('EL', nne, 'PROP', NNClassifierEvaluator.CONFUSION_MATRIX, varargin{:});

%%% ¡prop!
PFCM (gui, item) contains the panel figure of the confusion matrix.
%%%% ¡settings!
'PFConfusionMatrix'
%%%% ¡postprocessing!
if ~braph2_testing % to avoid problems with isqual when the element is recursive
    nne.memorize('PFCM').set('NNE', nne)
end
%%%% ¡gui!
pr = PanelPropItem('EL', nne, 'PROP', NNClassifierEvaluator.PFCM, ...
    'GUICLASS', 'GUIFig', ...
    varargin{:});

%% ¡props_update!

%%% ¡prop!
NN (data, item) is a neural network model that needs to be evaluated.
%%%% ¡settings!
'NNClassifierDNN'
%%%% ¡default!
NNClassifierDNN()

%%% ¡prop!
GR_PREDICTION (result, item) is a group of NN subjects containing the prediction from the neural network.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
if nne.get('GR').get('SUB_DICT').length() == 0
    value = NNGroup();
else
    nn = nne.get('NN');
    gr = nne.get('GR');
    inputs = nn.reconstruct_inputs(gr);
    net = nn.get('MODEL');
    if isa(net, 'NoValue') || ~BRAPH2.installed('NN', 'msgbox')
        predictions = zeros(gr.get('SUB_DICT').length(), 2);
    else
        predictions = net.predict(inputs);
    end

    gr_pred = NNGroup( ...
        'SUB_CLASS', gr.get('SUB_CLASS'), ...
        'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject'), ...
        'ID', gr.get('ID'), ...
        'LABEL', gr.get('LABEL'), ...
        'NOTES', gr.get('NOTES'), ...
        'FEATURE_SELECTION_MASK', gr.get('FEATURE_SELECTION_MASK') ...
        );

    % add subejcts from all groups
    sub_dict = gr_pred.get('SUB_DICT');
    subs = gr.get('SUB_DICT').getItems();
    for i = 1:1:length(subs)
        sub = NNSubject( ...
            'ID', [subs{i}.get('ID') ' in ' gr.get('ID')], ...
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
    gr_pred.set('SUB_DICT', sub_dict);

    value = gr_pred;
end