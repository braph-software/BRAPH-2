%% ¡header!
ClassifierGNN < BaseNN (gnn, classifier with graph nerual network) is a classifier consists of graph neural network.

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
function [score, prediction] = accuracy(gnn, YPred, target, classes)
    % Decode probability vectors into class labels
    prediction = onehotdecode(YPred, classes, 2);
    score = sum(prediction == target)/numel(target);
end

function weights = initialize_glorot(gnn, sz,numOut,numIn,className)
    arguments
        gnn
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

function [gradients, loss, dlYPred] = model_gradients(gnn, dlX, adjacencyTrain, T, parameters)

    dlYPred = model(dlX, adjacencyTrain, parameters);

    loss = crossentropy(dlYPred, T, 'DataFormat', 'BC');

    gradients = dlgradient(loss, parameters);

end

function normAdjacency = normalize_adjacency(gnn, adjacency)

    % Compute degree of nodes
    degree = sum(adjacency, 2);

    % Compute inverse square root of degree
    degreeInvSqrt = sparse(sqrt(1./degree));

    % Normalize adjacency matrix
    normAdjacency = diag(degreeInvSqrt) * adjacency * diag(degreeInvSqrt);

end

function features = normalize_features(gnn, features)

    % Get the mean and variance from the training data
    meanFeatures = mean(features{1});
    varFeatures = var(features{1}, 1);

    % Standardize training and test data
    for i = 1:2
        features{i} = (features{i} - meanFeatures)./sqrt(varFeatures);
    end

end

function nn_obj_format = net_obj_transformer(gnn)
    filename = 'nn.onnx';
    fileID = fopen(filename,'w');
    fwrite(fileID, cell2mat(gnn.get('NEURAL_NETWORK')));
    fclose(fileID);
    nn_obj_format = importONNXNetwork(filename,'OutputLayerType','classification','Classes',string(gnn.class_name));
    delete nn.onnx
end