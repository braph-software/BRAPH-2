%% ¡header!
ClassifierNN < BaseNN (nn, classifier with dense layers) is a binary neural network classifier.

%% ¡description!
This classifier with dense layers is trained for a classification of two groups of subject.

%% ¡props!
%%% ¡prop!
DATASET_PROCESSOR (data, item) is a dataset processor that prepares the dataset for training or testing a neural network model.
%%%% ¡settings!
'DatasetProcessor'
%FIXM: update - specialize to NNClassifierData

%% ¡props_update!
%%% ¡prop!
TRAINED_NN (result, cell) is a trained neural network classifier.
%%%% ¡calculate!
if nn.check_nn_toolboxes()
    x_masked = nn.get('DATASET_PROCESSOR').get('X_MASKED');
    x_masked = x_masked{1};
    layers = nn.getLayers(length(x_masked), 2);
    x_masked = reshape(x_masked, [1, 1, size(x_masked, 1), size(x_masked, 2)]);
    y = nn.get('DATASET_PROCESSOR').get('Y');
    lgraph = layerGraph(layers);
    options = trainingOptions('adam', ...
        'MiniBatchSize', 8, ...
        'MaxEpochs', 20, ...
        'Shuffle', 'every-epoch', ...
        'Plots', 'none', ...
        'Verbose', true); % FIXME: make all relevant parameters props
    net = trainNetwork(x_masked, categorical(y{1}), layers, options);

    value = nn.transform_to_braph_format(net);
else
    value = '';
end

%FIXME: integrate with calculate + props
function layers = getLayers(nn, numFeatures, numClasses)
    layers = [
        imageInputLayer([1 1 numFeatures], 'Normalization', 'zscore', 'Name', 'input')
        fullyConnectedLayer(floor(1.5 * numFeatures), 'Name', 'fc1')
        batchNormalizationLayer('Name', 'batchNormalization1')
        fullyConnectedLayer(floor(1.5 * numFeatures), 'Name', 'fc2')
        batchNormalizationLayer('Name', 'batchNormalization2')
        reluLayer('Name', 'relu1')
        fullyConnectedLayer(numClasses, 'Name', 'fc3')
        softmaxLayer('Name', 'sfmax1')
        classificationLayer('Name', 'output')];
    lgraph = layerGraph(layers);
    plot(lgraph)
end