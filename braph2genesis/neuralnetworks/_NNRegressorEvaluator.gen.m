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
FEATURE_MAP (result, matrix) is a feature map obtained with feature selection analysis.
%%%% ¡calculate!
selected_idx = nne.get('NNDATA').get('FEATURE_MASK');
if length(selected_idx) == 1 && abs(selected_idx) <= 1
    selected_idx = nne.get('NNDATA').get('FEATURE_MASK_ANALYSIS');
end
if ~isempty(selected_idx)
    if string(nne.get('NNDATA').get('INPUT_TYPE')) == 'graph_measures'
        feature = nne.get('NNDATA').get('MEASURES');
        fm = zeros(1, length(feature));
        ticklabel = feature;
        fontsize = 12;
    else
        feature = nne.get('NNDATA').get('TRAIN_G_DICT').getItem(1).get('A');
        fm = zeros(length(feature{1}));
        ticklabel = 0:size(fm, 2);
        fontsize = 5;
    end

    fm(selected_idx) = 1;

    if nne.get('PLOT_MAP')
        figure
        x = [1 size(fm, 2)];
        y = [0 size(fm, 1)];
        image(x, y, fm, 'CDataMapping', 'scaled')

        xticks([1:size(fm, 2)]);
        yticks([1:size(fm, 1)]);
        xticklabels(ticklabel);
        yticklabels(0:size(fm, 1));
        a = get(gca,'XTickLabel');
        set(gca, 'XTickLabel', a, 'fontsize', fontsize, 'FontWeight', 'bold')
        a = get(gca,'YTickLabel');
        set(gca, 'YTickLabel', a, 'fontsize', fontsize, 'FontWeight', 'bold')
        colorbar
        directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
        if ~exist(directory, 'dir')
            mkdir(directory)
        end
        filename = [directory filesep 'connection_mask.svg'];
        saveas(gcf, filename);
    end

    value = fm;
else
    value = [];
end

%%% ¡prop!
RMSE (result, scalar) is the root mean squared error between targets and predictions.
%%%% ¡calculate!
preds = nne.memorize('PREDICTION');
targets = nne.get('NNDATA').get('TARGETS');
if(isempty(targets{1}))
    value = 0;
else
    value = sqrt(mean((preds{1} - targets{1}).^2));
end

%%% ¡prop!
VAL_RMSE (result, scalar) is the root mean squared error between targets and predictions for validation set.
%%%% ¡calculate!
preds = nne.memorize('VAL_PREDICTION');
targets = nne.get('NNDATA').get('VAL_TARGETS');
if(isempty(targets{1}))
    value = 0;
else
    value = sqrt(mean((preds{1} - targets{1}).^2));
end

%% ¡props_update!
%%% ¡prop!
NNDATA (data, item) is a dataset for testing the neural networks.
%%%% ¡settings!
'NNRegressorData'
%%%% ¡default!
NNRegressorData()

%%% ¡prop!
PREDICTION (result, matrix) is an output cell of prediction from a neural network model.
%%%% ¡calculate!
nnd = nne.get('NNDATA');
inputs = nnd.memorize('INPUTS');
if isempty(inputs{1})
    value = [];
else
    regressor = nne.get('NN');
    net = regressor.to_net(regressor.get('MODEL'));
    inputs = nnd.memorize('INPUTS');
    inputs = inputs{1};
    inputs = reshape(inputs, [1, 1, size(inputs,1), size(inputs,2)]);

    value = {net.predict(inputs)};
end

%%% ¡prop!
VAL_PREDICTION (result, matrix) is an output cell of prediction for the validation set.
%%%% ¡calculate!
nnd = nne.get('NNDATA');
inputs = nnd.memorize('VAL_INPUTS');
if isempty(inputs{1})
    value = [];
else
    regressor = nne.get('NN');
    net = regressor.to_net(regressor.get('MODEL'));
    inputs = nnd.memorize('VAL_INPUTS');
    inputs = inputs{1};
    inputs = reshape(inputs, [1, 1, size(inputs,1), size(inputs,2)]);

    value = {net.predict(inputs)};
end