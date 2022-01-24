%% ¡header!
NNClassifierDNN < NNBase (nn, classifier with dense layers) is a binary neural network classifier.

%% ¡description!
This classifier with dense layers is trained for a classification of two groups of subject.

%% ¡props!
%%% ¡prop!
NNClassifierData (data, item) is a dataset for training or testing a neural network classifier.
%%%% ¡settings!
'NNClassifierData'

%%% ¡prop!
MINI_BATCH_SIZE (data, scalar) is the size of the mini-batch to use for each training iteration.
%%%% ¡default!
8

%%% ¡prop!
MAX_EPOCHS (data, scalar) is the maximum number of epochs.
%%%% ¡default!
20

%%% ¡prop!
SHUFFLE (data, OPTION) is a option for data shuffling.
%%%% ¡settings!
{'once' 'never' 'every-epoch'}
%%%% ¡default!
'once'

%%% ¡prop!
PLOT_TRAINING_PROGRESS (data, OPTION) is an option for plots of training-progress during network training.
%%%% ¡settings!
{'none' 'training-progress'}
%%%% ¡default!
'none'

%%% ¡prop!
VERBOSE (data, logical) is an option for plots of training-progress during network training.
%%%% ¡default!
0

%%% ¡prop!
PLOT_LAYERS (data, logical) is an option for plots of the layers.
%%%% ¡default!
0

%% ¡props_update!
%%% ¡prop!
TRAINED_NN (result, cell) is a trained neural network classifier.
%%%% ¡calculate!
if nn.check_nn_toolboxes()
    % get inputs
    inputs = nn.get('NNClassifierData').get('INPUTS');
    inputs = inputs{1};
    numFeatures = length(inputs);
    numClasses = 2;
    inputs = reshape(inputs, [1, 1, size(inputs, 1), size(inputs, 2)]);
    targets = nn.get('NNClassifierData').get('TARGETS');
    
    % init layers
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
    
    % plot layers
    if nn.get('PLOT_LAYERS')
        lgraph = layerGraph(layers);
        plot(lgraph)
    end
    
    % specify trianing parameters
    options = trainingOptions('adam', ...
        'MiniBatchSize', nn.get('MINI_BATCH_SIZE'), ...
        'MaxEpochs', nn.get('MAX_EPOCHS'), ...
        'Shuffle', nn.get('SHUFFLE'), ...
        'Plots', nn.get('PLOT_TRAINING_PROGRESS'), ...
        'Verbose', nn.get('VERBOSE')); 
    
    % train the neural network
    net = trainNetwork(inputs, categorical(targets{1}), layers, options);
    %value = nn.from_net(net);
    value = {net};
else
    value = '';
end