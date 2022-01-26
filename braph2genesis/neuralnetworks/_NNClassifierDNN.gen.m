%% ¡header!
NNClassifierDNN < NNBase (nn, classifier with dense layers) is a binary neural network classifier.

%% ¡description!
This classifier with fully-connected layers is trained for a classification of two groups of subject.

%% ¡props!
%%% ¡prop!
NNDATA (data, item) is a dataset for training or testing a neural network classifier.
%%%% ¡settings!
'NNClassifierData'

%%% ¡prop!
LAYERS (metadata, rvector) is a vector represents the number of neurons in each layer.
%%%% ¡postprocessing!
if isempty(nn.get('LAYERS'))
    inputs = nn.get('NNDATA').get('INPUTS');
    inputs = inputs{1};
    numFeatures = length(inputs);
    value = [floor(1.5 * numFeatures) floor(1.5 * numFeatures)];
    nn.set('LAYERS', value);
end

%%% ¡prop!
BATCH (data, scalar) is the size of the mini-batch to use for each training iteration.
%%%% ¡default!
8

%%% ¡prop!
EPOCHS (data, scalar) is the maximum number of epochs.
%%%% ¡default!
20

%%% ¡prop!
SHUFFLE (data, option) is an option for data shuffling.
%%%% ¡settings!
{'once' 'never' 'every-epoch'}

%%% ¡prop!
SOLVER (data, option) is an option for the solver.
%%%% ¡settings!
{'adam' 'sgdm' 'rmsprop'}

%%% ¡prop!
VERBOSE (data, logical) is an indicator to display trining progress information.
%%%% ¡default!
false

%%% ¡prop!
PLOT_TRAINING (data, logical) is an option for the plot of training-progress.
%%%% ¡default!
false

%%% ¡prop!
PLOT_LAYERS (data, logical) is an option for the plot of the layers.
%%%% ¡default!
false

%%% ¡prop!
TARGET_NAME (result, cell) is the names for the targets.
%%%% ¡calculate!
targets = nn.get('NNDATA').get('TARGETS');
value = unique(targets{1});

%%% ¡prop!
INPUT_FORMAT (data, string) is the data format of network inputs.
%%%% ¡default!
"BCSS"

%% ¡props_update!
%%% ¡prop!
MODEL (result, cell) is a trained neural network classifier.
%%%% ¡calculate!
if nn.check_nn_toolboxes()
    % get inputs
    inputs = nn.get('NNDATA').get('INPUTS');
    inputs = inputs{1};
    numFeatures = length(inputs);
    numClasses = 2;
    inputs = reshape(inputs, [1, 1, size(inputs, 1), size(inputs, 2)]);
    targets = nn.get('NNDATA').get('TARGETS');
    
    % init layers
    numLayer = nn.get('LAYERS');
    layers = [imageInputLayer([1 1 numFeatures], 'Name', 'input')];
    for i = 1:1:length(nn.get('LAYERS'))
        layers = [layers
            fullyConnectedLayer(numLayer(i), 'Name', ['fc' num2str(i)])
            batchNormalizationLayer('Name', ['batchNormalization' num2str(i)])
            ];
    end
    layers = [layers
        reluLayer('Name', 'relu1')
        fullyConnectedLayer(numClasses, 'Name', 'fc_output')
        softmaxLayer('Name', 'sfmax1')
        classificationLayer('Name', 'output')
        ];
    
    % plot layers
    if nn.get('PLOT_LAYERS')
        lgraph = layerGraph(layers);
        plot(lgraph)
    end
    
    % specify trianing parameters
    if nn.get('PLOT_TRAINING')
        plot_training = 'training-progress';
    else
        plot_training = 'none';
    end

    options = trainingOptions(nn.get('SOLVER'), ...
        'MiniBatchSize', nn.get('BATCH'), ...
        'MaxEpochs', nn.get('EPOCHS'), ...
        'Shuffle', nn.get('SHUFFLE'), ...
        'Plots', plot_training, ...
        'Verbose', nn.get('VERBOSE')); 
    
    % train the neural network
    net = trainNetwork(inputs, categorical(targets{1}), layers, options);

    % transform the net object to a cell
    value = nn.from_net(net);
else
    value = {};
end

%% ¡methods!
function net = to_net(nn, saved_nn)
    %TO_NET transforms the saved neural network 
    % in braph to a build-in object in matlab.
    %
    % NET = TO_NET(NN) transforms the saved neural network in braph
    %  to a build-in object in matlab. Firstly the saved neural network
    %  in braph is exported as an ONNX file, and then the file is 
    %  imported as a build-in neural network object in matlab.
    %  Typically, this method is called internally when a saved neural 
    %  network model is evaluated by a test data.
    
    net = to_net@BaseNN(nn, saved_nn, nn.get('INPUT_FORMAT'), "classification", nn.get('TARGET_NAME'));
end