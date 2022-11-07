%% ¡header!
NNClassifierEvaluator < NNEvaluator (nne, evaluator for a neural network classifier) evaluates the performance of a neural network classifier with a specific dataset.

%% ¡description!
This evaluator evaluates the performance of a neural network classifier
in terms of the receiver operating characteristic curve (ROC), the area 
under the ROC curve (AUC), and the confusion matrix.

%% ¡props!

%%% ¡prop!
FEATURE_PERMUTATION_IMPORTANCE (result, cell) is feature importance evaluated by permuting the features with random numbers
%%%% ¡calculate!
if nne.get('GR').get('SUB_DICT').length() == 0
    value = {};
elseif ~any(ismember(nne.get('GR').get('SUB_DICT').getItem(1).get('INPUT_LABEL'), subclasses('Measure', [], [], true)))
    % now it only works for (1) input being adj of a graph and (2) no feature selection 
    nn = nne.get('NN');
    gr = nne.get('GR');
    net = nn.get('MODEL');

    [inputs, num_features, masks] = nn.reconstruct_inputs(gr);
    [targets, classes] = nn.reconstruct_targets(gr);

    original_loss = crossentropy(net.predict(inputs)', targets);

    if isa(net, 'NoValue') || ~BRAPH2.installed('NN', 'msgbox')
        value = {};
    else
        % scramble the input feature 1 by 1
        parfor i = 1:1:num_features
            scrambled_inputs = inputs;
            permuted_value = squeeze(normrnd(mean(inputs(:, :, i, :)), std(inputs(:, :, i, :)), squeeze(size(inputs(:, :, i, :)))));
            scrambled_inputs(:, :, i, :) = permuted_value;
            scrambled_loss = crossentropy(net.predict(scrambled_inputs)', targets);
            feature_importance(i)= scrambled_loss / original_loss;
        end
        if nne.get('NN').get('FEATURE_SELECTION_RATIO') == 1
            feature_importance = reshape(feature_importance, gr.get('SUB_DICT').getItem(1).get('BA').get('BR_DICT').length(), []);
        else
            masks_3D = cell2mat(masks);
            f = zeros(size(masks_3D));
            f(find(masks_3D)) = feature_importance;
            feature_importance = f;
        end
        
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
        elseif size(feature_importance, 1) > size(feature_importance, 2) && size(feature_importance, 1) ~= 1 %% structural data
            n = size(feature_importance, 2);
            feature_importance_tmp = feature_importance;
            for i = 1:1:n
                feature_importances{i} = double(rescale(feature_importance_tmp(:, i)));
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
    nne.memorize('PFFI').set('NNE', nne, 'PROP', NNClassifierEvaluator.FEATURE_PERMUTATION_IMPORTANCE, 'BA', nne.get('GR').get('SUB_DICT').getItem(1).get('BA'))
end
%%%% ¡gui!
pr = PanelPropItem('EL', nne, 'PROP', NNClassifierEvaluator.PFFI, ...
    'GUICLASS', 'GUIFig', ...
    varargin{:});

%%% ¡prop!
AUC (result, scalar) is an area under the curve score.
%%%% ¡calculate!
if nne.get('GR_PREDICTION').get('SUB_DICT').length() == 0
    value = 0;
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
    nne.memorize('PFROC').set('NNE', nne)  
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
%%%% ¡gui!
pr = PanelPropMatrix('EL', nne, 'PROP', NNClassifierEvaluator.CONFUSION_MATRIX, ...
    'ROWNAME', char("{pr.get('EL').get('CLASS_NAME1') pr.get('EL').get('CLASS_NAME2')}"),...
    'COLUMNNAME', char("{pr.get('EL').get('CLASS_NAME1') pr.get('EL').get('CLASS_NAME2')}"),...
    varargin{:});

%%% ¡prop!
CLASS_NAME1 (metadata, string) is the class name for group 1.
%%%% ¡postprocessing!
if isempty(nne.get('CLASS_NAME1')) && ~braph2_testing
    if isa(nne.get('NN'), 'NoValue') || isa(nne.get('GR'), 'NoValue')
        nne.set('CLASS_NAME1', 'Group1');
    else
        nn = nne.get('NN');
        gr = nne.get('GR');
        [inputs, ~] = nn.reconstruct_inputs(gr);
        [targets, classes] = nn.reconstruct_targets(gr);
        nne.set('CLASS_NAME1', classes{1});
    end
end

%%% ¡prop!
CLASS_NAME2 (metadata, string) is the class name for group 2.
%%%% ¡postprocessing!
if isempty(nne.get('CLASS_NAME2')) && ~braph2_testing
    if isa(nne.get('NN'), 'NoValue') || isa(nne.get('GR'), 'NoValue')
        nne.set('CLASS_NAME2', 'Group2');
    else
        nn = nne.get('NN');
        gr = nne.get('GR');
        [inputs, ~] = nn.reconstruct_inputs(gr);
        [targets, classes] = nn.reconstruct_targets(gr);
        nne.set('CLASS_NAME2', classes{2});
    end
end

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
    [targets, classes] = nn.reconstruct_targets(gr);
    net = nn.memorize('MODEL');
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

    % add subejcts, it has to be created as new subjects
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