%% ¡header!
ClassifierNN < BaseNN (nn, classifier with dense layers) is a binary neural network classifier.

%% ¡description!
This classifier with dense layers is trained for a classification of two groups of subjects.

%% ¡props_update!
%%% ¡prop!
DATASET_PROCESSOR (data, item) is a dataset processor that prepares the dataset for training a neural network model.
%%%% ¡settings!
'DatasetProcessor'

%%% ¡prop!
TRAINED_NN (result, cell) is a trained neural network classifier.
%%%% ¡calculate!
if(nn.check_toolbox_installation())
    layers = nn.getLayers(length(nn.get('DATASET_PROCESSOR').get('X_MASKED')), 2);
    lgraph = layerGraph(layers);
    options = trainingOptions('adam', ...
                'MiniBatchSize',8, ...
                'MaxEpochs',20, ...
                'Shuffle','every-epoch', ...
                'Plots','none', ...
                'Verbose',true);
    net = trainNetwork(nn.get('DATASET_PROCESSOR').get('X_MASKED'), categorical(nn.get('DATASET_PROCESSOR').get('Y')), layers, options);

    value = nn.transform_to_braph_format(net);
else
    value = {};
end

%% ¡methods!
function layers = getLayers(nn, numFeatures, numClasses)
    layers = [
        imageInputLayer([1 1 numFeatures], 'Normalization', 'zscore', 'Name', 'input')
        fullyConnectedLayer(floor(1.5*numFeatures), 'Name', 'fc1')
        batchNormalizationLayer('Name', 'batchNormalization1')
        fullyConnectedLayer(floor(1.5*numFeatures), 'Name', 'fc2')
        batchNormalizationLayer('Name', 'batchNormalization2')
        reluLayer('Name', 'relu1')
        fullyConnectedLayer(numClasses, 'Name', 'fc3')
        softmaxLayer('Name', 'sfmax1')
        classificationLayer('Name', 'output')];
    lgraph = layerGraph(layers);
    plot(lgraph)
end