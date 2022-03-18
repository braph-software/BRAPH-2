%% ¡header!
NNClassifierDNN < NNBase (nn, classifier with dense layers) is a neural network classifier.

%% ¡description!
This regressor is composed of fully-connected layers.
The Classifier trains on NN groups which contain the inputs and targets.

%% ¡props!

%%% ¡prop!
LAYERS (data, rvector) is a vector representing the number of neurons in each layer.
%%%% ¡default!
[]
%%%% ¡postprocessing!
if isempty(nn.get('LAYERS'))
    inputs = nn.get('NN_GR').get('SUB_DICT').getItems();
    if ~isempty(inputs)
        input = inputs{1}.get('INPUT_FS');
        mask = nn.get('NN_GR').get('FEATURE_MASK');
        input_per_sub = cellfun(@(x, y) x(y == 1), input, mask, 'UniformOutput', false);
        input_per_sub = cell2mat(input_per_sub);
        numFeature = length(input_per_sub);
        value = [floor(1.5 * numFeature) floor(1.5 * numFeature)];
        nn.set('LAYERS', value);
    end
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
VERBOSE (metadata, logical) is an indicator to display trining progress information.
%%%% ¡default!
false

%%% ¡prop!
PLOT_TRAINING (metadata, logical) is an option for the plot of training-progress.
%%%% ¡default!
false

%%% ¡prop!
PLOT_LAYERS (metadata, logical) is an option for the plot of the layers.
%%%% ¡default!
false

%%% ¡prop!
INPUT_FORMAT (data, string) is the data format of neural network inputs.
%%%% ¡default!
'BCSS'

%% ¡props_update!

%%% ¡prop!
MODEL (result, cell) is a trained neural network classifier.
%%%% ¡calculate!
if nn.check_nn_toolboxes()
    % get inputs
    nn_gr = nn.get('NN_GR');
    if nn_gr.get('SUB_DICT').length() == 0
        value = {};
    else
        [inputs, num_features] = nn.construct_inputs(nn_gr);
        [targets, classes] = nn.construct_targets(nn_gr);
        numClasses = length(classes);
        
        % init layers
        numLayer = nn.get('LAYERS');
        layers = [imageInputLayer([1 1 num_features], 'Name', 'input')];
        for i = 1:1:length(numLayer)
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
        net = trainNetwork(inputs, targets, layers, options);

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
    
    [~, classes] = nn.construct_targets(nn.get('NN_GR'));
    net = to_net@NNBase(nn, saved_nn, nn.get('INPUT_FORMAT'), "classification", classes);
end
function [inputs, num_features] = reconstruct_inputs(nn, nn_gr)
%CONSTRUCT_INPUTS reconstructs the inputs for NN
%
% [INPUTS, NUM_FEATURES] = RECONSTRUCT_INPUTS(NN, NN_GR) reconstructs the
%   inputs from NN group. According to the tyep of this fully-connected NN,
%   this function will fatten the input into a vector for each datapoint.

    if nn_gr.get('SUB_DICT').length() == 0
        inputs = [];
        num_features = 0;
    else
        mask = nn_gr.get('SUB_DICT').getItem(1).get('FEATURE_MASK');
        inputs = [];
        inputs_tmp = nn_gr.get('INPUTS');
        for i = 1:1:length(inputs_tmp)
            input_per_sub = inputs_tmp(i);
            input_per_sub = cellfun(@(x, y) x(y == 1), input, mask, 'UniformOutput', false);
            input_per_sub = cell2mat(input_per_sub);
            inputs = [inputs; input_per_sub'];
        end
        num_features = length(inputs(1, :));
        inputs = reshape(inputs, [1, 1, num_features, nn_gr.get('SUB_DICT').length()]);
    end
end
function [targets, classes] = construct_targets(nn, nn_gr)
%CONSTRUCT_INPUTS constructs the targets for NN
%
% [TARGETS, CLASSES] = CONSTRUCT_TARGETS(NN, NN_GR) constructs the targets
%  from NN_GR, NN group, by concatenating the TARGET of NN Subjects.
%  CLASSES is the categories name of the unique targets.

    if nn_gr.get('SUB_DICT').length() == 0
        targets = [];
        classes = [];
    else
        targets = cellfun(@(x) x.get('TARGET'), nn_gr.get('SUB_DICT').getItems(), 'UniformOutput', false);
        targets = categorical(targets);
        classes = categories(targets);
    end
end