%% ¡header!
ClassifierNN < BaseNN (nn, classifier with dense layer) is a neural network classifier using dti data for classification.

%% ¡description!
This classifier with neural network is trained for classification of groups.

%% ¡props!
%%% ¡prop!
X_TRAIN (data, cell) is the training dataset.

%%% ¡prop!
Y_TRAIN (data, cell) is the label for training dataset.

%%% ¡prop!
X_TEST (data, cell) is the test dataset.

%%% ¡prop!
Y_TEST (data, cell) is the label for test dataset.

%% ¡props_update!
%%% ¡prop!
TRAINED_NN (result, cell) is the neural network classifier trained by training dataset.
%%%% ¡calculate!
value = train_neural_network(nn);

%%% ¡prop!
TEST_AUC (result, cell) is the AUC score obtained from test dataset.
%%%% ¡calculate!
trained_nn = nn.get('TRAINED_NN');
value = get_test_auc(trained_nn);

%%% ¡prop!
TRAIN_AUC (result, cell) is the AUC score obtained from training dataset.
%%%% ¡calculate!
trained_nn = nn.get('TRAINED_NN');
value = get_train_auc(trained_nn);

%%% ¡prop!
PREDICTION_TEST (data, cell) is the prediction for test dataset.

%%% ¡prop!
PREDICTION_TRAIN (data, cell) is the prediction for trainingz dataset.

%% ¡methods!
function value = train_neural_network(nn)
    if(nn.check_toolbox_installation())
        layers = nn.getLayers(length(nn.get('X_TRAIN')), 2);
        lgraph = layerGraph(layers);
        plot(lgraph)
        options = trainingOptions('adam', ...
                    'MiniBatchSize',8, ...
                    'MaxEpochs',20, ...
                    'Shuffle','every-epoch', ...
                    'Plots','none', ...
                    'Verbose',true);
        net = trainNetwork(nn.get('X_TRAIN'), categorical(nn.get('Y_TRAIN')), layers, options);
        
        YPred = {classify(net, nn.get('X_TRAIN'),'ExecutionEnvironment', 'cpu')};
        nn.set('PREDCITION_TRAIN', YPred);
        
        YPred = {classify(net, nn.get('X_TEST'),'ExecutionEnvironment', 'cpu')};
        nn.set('PREDCITION_TEST', YPred);

        trained_nn_binary_form = nn.net_binary_transformer(net);
        value = trained_nn_binary_form;
    else
        value = {};
    end
end

function auc = get_test_auc(nn)
   auc = perfcurve(nn.get('Y_TEST'), nn.get('PREDICTION_TEST'), distinct_classes(2));
end

function auc = get_train_auc(nn)
   auc = perfcurve(nn.get('Y_TRAIN'), nn.get('PREDICTION_TRAIN'), distinct_classes(2));
end

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