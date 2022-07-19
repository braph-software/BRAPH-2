%% ¡header!
NNRegressorEvaluator < NNEvaluator (nne, evaluator for a neural network regressor) evaluates the performance of a neural network regressor with a specific dataset.

%% ¡description!
This evaluator evaluates the performance of a neural network regressor
on root mean square error (RMSE).

%% ¡props!

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
SCATTER_CHART (result, matrix) creates a scatter chart with circular markers at the locations specified by predictions and targets.
%%%% ¡calculate!
if nne.get('GR_PREDICTION').get('SUB_DICT').length() == 0
    value = 0;
else
    preds = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nne.memorize('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    preds = cell2mat(preds);
    targets = cellfun(@(x) cell2mat(x.get('TARGET')), nne.get('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    targets = cell2mat(targets);
    value = [preds' targets'];
    if nne.get('PLOT_SCATTER')
        figure
        scatter(preds, targets);
        hold on
        plot([min(preds) max(preds)], [min(targets) max(targets), 'k']);
        hold off
        xlabel('Prediction')
        ylabel('Target')
        title('Scatter plot for regression')
        directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
        if ~exist(directory, 'dir')
            mkdir(directory)
        end
        filename = [directory filesep 'scatter.svg'];
        saveas(gcf, filename);
    end
end
%%%% ¡gui_!
% % % pr = PPNNRegressorEvaluator_Scatter_Chart('EL', nne, 'PROP', NNRegressorEvaluator.SCATTER_CHART, varargin{:});

%%% ¡prop!
PFSP (gui, item) contains the panel figure of the scatter plot.
%%%% ¡settings!
'PFScatterPlot'
%%%% ¡postprocessing!
if ~braph2_testing % to avoid problems with isqual when the element is recursive
    nne.memorize('PFROC').set('NNE', nne)
end
%%%% ¡gui!
pr = PanelPropItem('EL', nne, 'PROP', NNRegressorEvaluator.PFSP, ...
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
pr = PanelPropItem('EL', nne, 'PROP', NNRegressorEvaluator.PFFI, ...
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
        %sub.set('PREDICTION', {predictions(i, :)});
        sub_dict.add(sub);
    end
    nn_gr_pred.set('SUB_DICT', sub_dict);

    value = nn_gr_pred;
end