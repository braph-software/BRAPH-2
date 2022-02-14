%% ¡header!
NNRegressorDNN < NNBase (nn, regressor with dense layers) is a neural network regressor.

%% ¡description!
This regressor is a fully-connected-layer neural network by training with
backpropagation on the data provided by NNData. The Regressor trains on two
cells: cell INPUTS from NNData holds the training samples represented as 
floating point feature vectors, and the cell TARGETS, which holds the target
values for the trianing samples.

%% ¡props!
%%% ¡prop!
LAYERS (data, rvector) is a vector represents the number of neurons in each layer.

%%% ¡prop!
BATCH (data, scalar) is the size of the mini-batch to use for each training iteration.
%%%% ¡default!
4

%%% ¡prop!
EPOCHS (data, scalar) is the maximum number of epochs.
%%%% ¡default!
500

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
TARGET_NAME (result, string) is the names for the targets.
%%%% ¡calculate!
value = nn.get('NNDATA').get('TARGET_NAME');

%%% ¡prop!
INPUT_FORMAT (data, string) is the data format of network inputs.
%%%% ¡default!
'BCSS'

%% ¡props_update!
%%% ¡prop!
NNDATA (data, item) is a dataset for training or testing a neural network regressor.
%%%% ¡settings!
'NNRegressorData'
%%%% ¡default!
NNRegressorData()

%%% ¡prop!
MODEL (result, cell) is a trained neural network regressor.
%%%% ¡calculate!
if nn.check_nn_toolboxes()
    % get inputs
    inputs = nn.get('NNDATA').get('INPUTS');
    inputs = inputs{1};
    numFeatures = length(inputs);
    inputs = reshape(inputs, [1, 1, size(inputs, 1), size(inputs, 2)]);
    targets = nn.get('NNDATA').get('TARGETS');
    if(isempty(targets{1}))
        value = {[]};
    else
        % init layers
        numLayer = nn.get('LAYERS');
        if isempty(numLayer)
            inputs_tmp = nn.get('NNDATA').get('INPUTS');
            if ~isempty(inputs_tmp{1})
                inputs_tmp = inputs_tmp{1};
                numFeatures = length(inputs_tmp);
                value = [floor(1.5 * numFeatures) floor(1.5 * numFeatures)];
                nn.set('LAYERS', value);
            end
        end
        layers = [imageInputLayer([1 1 numFeatures], 'Name', 'input')];
        for i = 1:1:length(numLayer)
            layers = [layers
                fullyConnectedLayer(numLayer(i), 'Name', ['fc' num2str(i)])
                batchNormalizationLayer('Name', ['batchNormalization' num2str(i)])
                ];
        end
        layers = [layers
            reluLayer('Name', 'relu1')
            fullyConnectedLayer(1, 'Name', 'fc_output')
            regressionLayer
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
        net = trainNetwork(inputs, targets{1}, layers, options);

        % transform the net object to a cell
        value = nn.from_net(net);
    end
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
    
    net = to_net@NNBase(nn, saved_nn, nn.get('INPUT_FORMAT'), "regression");
end