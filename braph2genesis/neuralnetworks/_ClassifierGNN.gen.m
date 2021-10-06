%% ¡header!
ClassifierGNN < BaseNN (nn, classifier with graph nerual network) is a classifier consists of graph neural network.

%% ¡description!
This node classifier is composed of graph neural network layers and classification output layer.
Instances of this class should not be created. 
Use one of its subclasses instead.

%% ¡props!
%%% ¡prop!
TRAINING_ACCURACY (result, scalar) is the accuracy of the classifier obtained from the training data.

%%% ¡prop!
TEST_ACCURACY (result, scalar) is the accuracy of the classifier obtained from test data.

%% ¡methods!
function [score, prediction] = accuracy(YPred, target, classes)
    % Decode probability vectors into class labels
    prediction = onehotdecode(YPred, classes, 2);
    score = sum(prediction == target)/numel(target);
end

function weights = initialize_glorot(sz,numOut,numIn,className)
    arguments
        sz
        numOut
        numIn
        className = 'single'
    end

    Z = 2*rand(sz,className) - 1;
    bound = sqrt(6 / (numIn + numOut));

    weights = bound * Z;
    weights = dlarray(weights);
end

function [gradients, loss, dlYPred] = model_gradients(dlX, adjacencyTrain, T, parameters)

    dlYPred = model(dlX, adjacencyTrain, parameters);

    loss = crossentropy(dlYPred, T, 'DataFormat', 'BC');

    gradients = dlgradient(loss, parameters);

end

function nn_obj_format = net_obj_transformer(nn)
    filename = 'nn.onnx';
    fileID = fopen(filename,'w');
    fwrite(fileID, cell2mat(nn.get('NEURAL_NETWORK')));
    fclose(fileID);
    nn_obj_format = importONNXNetwork(filename,'OutputLayerType','classification','Classes',string(nn.class_name));
    delete nn.onnx
end