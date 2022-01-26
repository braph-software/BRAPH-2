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
function nn_cell = from_net(nn, net)
    %FROM_NET transforms the build-in neural network object in matlab 
    % to a string format that can be saved as cell in braph.
    % 
    % NN_CELL = FROM_NET(NN, NET) transforms the build-in neural network
    %  object NET to a cell format. Firstly, the NET is exported to an
    %  ONNX file and then the file is imported as a string format which 
    %  can be saved in braph.
    %  Typically, this method is called internally when a neural network
    %  model is trained and ready to be saved in braph.
    
    warning('off', 'MATLAB:mir_warning_unrecognized_pragma')

    directory = [fileparts(which('test_braph2')) filesep 'trial_nn_from_matlab_to_be_erased'];
    if ~exist(directory, 'dir')
        mkdir(directory)
    end
    filename = [directory filesep 'nn_from_matlab_to_be_erased.onnx'];

    exportONNXNetwork(net, filename);
    
    fileID = fopen(filename);
    nn_cell = {fread(fileID), net.Layers(end).Classes};		
    fclose(fileID);
    
    rmdir(directory, 's')
end
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

    warning('off', 'MATLAB:mir_warning_unrecognized_pragma')
    warning('off','nnet_cnn:internal:cnn:analyzer:NetworkAnalyzer:NetworkHasWarnings')

    directory = [fileparts(which('test_braph2')) filesep 'trial_nn_from_braph_to_be_erased'];
    if ~exist(directory, 'dir')
        mkdir(directory)
    end
    filename = [directory filesep 'nn_from_braph_to_be_erased.onnx'];

    fileID = fopen(filename, 'w');
    fwrite(fileID, saved_nn{1});
    fclose(fileID);
   
    net = importONNXNetwork(filename, 'InputDataFormats', 'BCSS', 'OutputLayerType' , 'classification', 'Classes', saved_nn{2});

    rmdir(directory, 's')
end
