%% ¡header!
NNClassifierEvaluator < NNEvaluator (nne, evaluator for a neural network classifier) evaluates the performance of a neural network classifier with a specific dataset.

%% ¡description!
This evaluator evaluates the performance of a neural network classifier
in terms of the receiver operating characteristic curve (ROC), the area 
under the ROC curve (AUC), and the confusion matrix.

%% ¡props!

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
        figure
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

    value = {X, Y};
end
%%%% ¡gui_!
% % % pr = PPNNClassifierEvaluator_AUC('EL', nne, 'PROP', NNClassifierEvaluator.AUC, varargin{:});

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
        figure
        heatmap(classes, classes, cm)
        directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
        if ~exist(directory, 'dir')
            mkdir(directory)
        end
        filename = [directory filesep 'confusion_matrix.svg'];
        saveas(gcf, filename);

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
PFFI (gui, item) contains the panel figure of the feature importance.
%%%% ¡settings!
'PFFeatureImportance'
%%%% ¡postprocessing!
if ~braph2_testing % to avoid problems with isqual when the element is recursive
    nne.memorize('PFROC').set('NNE', nne)
end
%%%% ¡gui!
pr = PanelPropItem('EL', nne, 'PROP', NNClassifierEvaluator.PFFI, ...
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