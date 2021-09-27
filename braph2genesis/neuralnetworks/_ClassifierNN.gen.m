%% ¡header!
ClassifierNN < BaseNN (nn, classifier with nerual networks) is a classifier consists of artificial neural network.

%% ¡description!
This classifier is composed of artificial neural network layers and classification output layer.

%% ¡props!
%%% ¡prop!
TRAINING_ACCURACY (result, scalar) is the accuracy of the classifier obtained from the training data.

%%% ¡prop!
TEST_ACCURACY (result, scalar) is the accuracy of the classifier obtained from test data.


%% ¡methods!
function layers = getLayers(nn, numFeatures, numClasses)
    layers = [
        imageInputLayer([1 1 numFeatures],'Normalization', 'zscore','Name','input')
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

function m = getTrainingConfusionMatrix(nn)
    net = net_obj_transformer(nn.get('trained_net'));
    YPred = classify(net, nn.get('trained_net'));
	YTest = nn.y_tblTrain;
    % plot result
    [m,order] = confusionmat(YTest,YPred)
    figure
    confusionchart(YTest,YPred, ...
        'Title','Classification', ...
        'RowSummary','row-normalized', ...
        'ColumnSummary','column-normalized');
end

function m = getTestConfusionMatrix(nn)
    net = net_obj_transformer(nn.get('NEURAL_NETWORK'));
    YPred = classify(net, nn.X_tblTest);
	YTest = nn.y_tblTest;
    % plot result
    [m,order] = confusionmat(YTest,YPred)
    figure
    confusionchart(YTest,YPred, ...
        'Title','Classification', ...
        'RowSummary','row-normalized', ...
        'ColumnSummary','column-normalized');
end

function nn_obj_format = net_obj_transformer(nn)
    filename = 'nn.onnx';
    fileID = fopen(filename,'w');
    fwrite(fileID, cell2mat(nn.get('NEURAL_NETWORK')));
    fclose(fileID);
    nn_obj_format = importONNXNetwork(filename,'OutputLayerType','classification','Classes',string(nn.class_name));
    delete nn.onnx
end