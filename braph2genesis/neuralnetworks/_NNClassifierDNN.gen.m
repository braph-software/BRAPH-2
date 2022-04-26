%% ¡header!
NNClassifierDNN < NNBase (nn, classifier with dense layers) is a neural network classifier.

%% ¡description!
This classifier is composed of fully-connected layers.
The Classifier trains on NN groups which contain the inputs and targets.

%% ¡props!

%%% ¡prop!
LAYERS (data, rvector) is a vector representing the number of neurons in each layer.
%%%% ¡default!
[]
%%%% ¡postprocessing!
if isempty(nn.get('LAYERS'))
    if nn.get('GR').get('SUB_DICT').length() > 0
        [inputs, num_features] = nn.reconstruct_inputs(nn.get('GR'));
        value = [floor(1.5 * num_features) floor(1.5 * num_features)];
        nn.set('LAYERS', value);
    end
end
%%%% ¡gui!
pr = PlotPropSmartVector('EL', nn, 'PROP', NNClassifierDNN.LAYERS, 'MAX', 100000, 'MIN', 1, varargin{:});

%%% ¡prop!
BATCH (data, scalar) is the size of the mini-batch to use for each training iteration.
%%%% ¡default!
8

%%% ¡prop!
EPOCHS (data, scalar) is a maximum number of epochs.
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
true

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
MODEL (result, net) is a trained neural network classifier.
%%%% ¡calculate!
if BRAPH2.installed('NN', 'warning')
    % get inputs
    nn_gr = nn.get('GR');
    if nn_gr.get('SUB_DICT').length() == 0
        value = network();
    else
        [inputs, num_features] = nn.reconstruct_inputs(nn_gr);
        [targets, classes] = nn.reconstruct_targets(nn_gr);
        numClasses = length(classes);
        targets = onehotdecode(targets, classes, 1);
        
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
            figure();
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
        value = net;
    end
else
    value = NoValue();
end

%% ¡methods!
function [inputs, num_features] = reconstruct_inputs(nn, gr)
%RECONSTRUCT_INPUTS reconstructs the inputs for NN
%
% [INPUTS, NUM_FEATURES] = RECONSTRUCT_INPUTS(NN, GR) reconstructs the
%   inputs from NN group. According to the tyep of this fully-connected NN,
%   this function will flatten the input into a vector for each datapoint
%   and return the number of features for input layer as well.

    if gr.get('SUB_DICT').length() == 0
        inputs = [];
        num_features = 0;
    else
        mask = gr.get('SUB_DICT').getItem(1).get('FEATURE_MASK');
        inputs = [];
        inputs_tmp = gr.get('INPUTS');
        for i = 1:1:length(inputs_tmp)
            input = inputs_tmp{i};
            input_per_sub = cellfun(@(x, y) x(y == 1), input, mask, 'UniformOutput', false);
            input_per_sub = cell2mat(input_per_sub');
            inputs = [inputs input_per_sub];
        end
        num_features = length(inputs(:, 1));
        inputs = reshape(inputs, [1, 1, num_features, gr.get('SUB_DICT').length()]);
    end
end
function [targets, classes] = reconstruct_targets(nn, gr)
%RECONSTRUCT_TARGETS reconstructs the targets for NN
%
% [TARGETS, CLASSES] = RECONSTRUCT_TARGETS(NN, GR) reconstructs the targets
%  from NN group, by concatenating the target of NN Subjects.
%  CLASSES is the categories name of the unique targets.

    if gr.get('SUB_DICT').length() == 0
        targets = [];
        classes = [];
    else
        targets = gr.get('TARGETS');
        targets = cellfun(@(x) cell2mat(x)', targets, 'UniformOutput', false);
        targets = cell2mat(targets);
        classes = categories(categorical(cellfun(@(x) x.get('TARGET_NAME'), gr.get('SUB_DICT').getItems(), 'UniformOutput', false)));
    end
end