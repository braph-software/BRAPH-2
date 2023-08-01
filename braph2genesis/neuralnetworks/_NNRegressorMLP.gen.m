%% ¡header!
NNRegressorMLP < NNBase (nn, neural network architecture) trains a neural network model.

%%% ¡description!

%%% ¡seealso!
NNDataPoint, NNData

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the trainor for neural network analysis.
%%%% ¡default!
'NNRegressor'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the trainor for neural network analysis.
%%%% ¡default!
'...'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the trainor for neural network analysis.
%%%% ¡settings!
'NNRegressor'

%%% ¡prop!
ID (data, string) is a few-letter code for the trainor for neural network analysis.
%%%% ¡default!
'NNRegressor ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the trainor for neural network analysis.
%%%% ¡default!
'NNRegressor label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the trainor for neural network analysis.
%%%% ¡default!
'NNRegressor notes'
    
%%% ¡prop!
INPUT_FORMAT (data, string) is the data format of neural network inputs.
%%%% ¡default!
'BCSS'

%%% ¡prop!
MODEL (result, net) is a user defined neural network layers.
%%%% ¡calculate!
inputs_nn_format = nn.get('DATA_CONSTRUCT');
num_features = length(inputs_nn_format(:, 1));

numLayers = nna.get('DENSE_LAYERS');
numFeatures = nna.get('NUM_FEATURES');
layers = [imageInputLayer([1 1 num_features], 'Name', 'input')];
for i = 1:1:length(numLayers)
    layers = [layers
        fullyConnectedLayer(numLayer(i), 'Name', ['fc' num2str(i)])
        batchNormalizationLayer('Name', ['batchNormalization' num2str(i)])
        dropoutLayer('Name', ['dropout' num2str(i)])
        ];
end
layers = [layers
    reluLayer('Name', 'relu1')
    fullyConnectedLayer(1, 'Name', 'fc_output')
    regressionLayer('Name', 'output')
    ];

net = dlnetwork(layers);

% specify trianing options
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
value = trainNetwork(inputs, targets, net, options);

%%% ¡prop!
DATA_CONSTRUCT (query, cell) constructs the data based on specified data_format that flows through the network.
%%%% ¡calculate!
targets = nn.get('D').get('TARGETS');
inputs = nn.get('D').get('INPUTS');
value = [];
for i = 1:1:length(inputs)
    input = inputs{i};
    value = [value input];
end
num_features = length(inputs_nn_format(:, 1));
value = reshape(value, [1, 1, num_features, nn.get('D').get('DP_DICT').get('LENGTH')]);

%% ¡props!

%%% ¡prop!
DENSE_LAYERS (data, rvector) is a user defined neural network layers.