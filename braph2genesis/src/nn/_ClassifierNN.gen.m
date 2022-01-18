%% ¡header!
ClassifierNN < BaseNN (nn, classifier with dense layer) is a binary neural network classifier.

%% ¡description!
This classifier with neural network is trained for classification of two groups.

%% ¡props_update!
%%% ¡prop!
DATASET_PROCESSOR (data, item) is the dataset processor that prepares the dataset for training a neural network model.
%%%% ¡settings!
'DatasetProcessor'

%%% ¡prop!
TRAINED_NN (result, cell) is the neural network classifier trained by training dataset.
%%%% ¡calculate!
if(nn.check_toolbox_installation())
    layers = nn.getLayers(length(nn.get('DATASET_PROCESSOR').get('X_MASKED')), 2);
    lgraph = layerGraph(layers);
    plot(lgraph)
    options = trainingOptions('adam', ...
                'MiniBatchSize',8, ...
                'MaxEpochs',20, ...
                'Shuffle','every-epoch', ...
                'Plots','none', ...
                'Verbose',true);
    net = trainNetwork(nn.get('DATASET_PROCESSOR').get('X_MASKED'), categorical(nn.get('DATASET_PROCESSOR').get('Y')), layers, options);

    trained_nn_binary_form = nn.net_binary_transformer(net);
    value = trained_nn_binary_form;
else
    value = {};
end

%% ¡methods!
function layers = getLayers(nn, numFeatures, numClasses)
    layers = [
        imageInputLayer([1 1 numFeatures],'Normalization', 'zscore', 'Name', 'input')
        fullyConnectedLayer(floor(1.5*numFeatures),'Name','fc1')
        batchNormalizationLayer('Name','batchNormalization1')
        fullyConnectedLayer(floor(1.5*numFeatures),'Name','fc2')
        batchNormalizationLayer('Name','batchNormalization2')
        reluLayer('Name','relu1')
        fullyConnectedLayer(numClasses,'Name','fc3')
        softmaxLayer('Name','sfmax1')
        classificationLayer('Name','output')];
    lgraph = layerGraph(layers);
    plot(lgraph)
end