%% ¡header!
RegressorNN < BaseNN (nn, regressor with nerual networks) is a regressor consist of neural network.

%% ¡description!
This regressor is composed of artificial neural network layers and regression output layer.

%% ¡props!
%%% ¡prop!
TRAINING_RMSE (result, scalar) is the model root mean square error obtained from the training data.

%%% ¡prop!
TEST_RMSE (result, scalar) is the model root mean square error obtained from the test data.


%% ¡methods!
function layers = getLayers(nn, numFeatures)
    layers = [
        imageInputLayer([1 1 numFeatures],'Normalization', 'zscore','Name','input')
        fullyConnectedLayer(floor(1.5*numFeatures),'Name','fc1')
        batchNormalizationLayer('Name','batchNormalization1')
        fullyConnectedLayer(floor(1.5*numFeatures),'Name','fc2')
        batchNormalizationLayer('Name','batchNormalization2')
        reluLayer('Name','relu1')
        fullyConnectedLayer(1,'Name','fc3')
        regressionLayer('Name','output')];
    lgraph = layerGraph(layers);
    plot(lgraph)
end