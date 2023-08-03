%% ¡header!
NNRegressorMLP < NNBase (nn, neural network architecture) trains a neural network model.

%%% ¡description!

%%% ¡seealso!
NNDataPoint, NNData

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the trainor for neural network analysis.
%%%% ¡default!
'NNRegressorMLP'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the trainor for neural network analysis.
%%%% ¡default!
'...'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the trainor for neural network analysis.
%%%% ¡settings!
'NNRegressorMLP'

%%% ¡prop!
ID (data, string) is a few-letter code for the trainor for neural network analysis.
%%%% ¡default!
'NNRegressorMLP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the trainor for neural network analysis.
%%%% ¡default!
'NNRegressorMLP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the trainor for neural network analysis.
%%%% ¡default!
'NNRegressorMLP notes'
    
%%% ¡prop!
DATA_FORMAT (data, string) is the data format of neural network inputs. In this case, it maps "CB" (channel, batch) data.
%%%% ¡default!
'CB'

%%% ¡prop!
DATA_CONSTRUCT (query, cell) constructs the data based on specified data_format that flows through the network.
%%%% ¡calculate!
inputs = nn.get('D').get('INPUTS');
if isempty(inputs)
    value = {};
else
    data = [];
    for i = 1:1:length(inputs)
        input = cell2mat(inputs{i});
        data = [data; input(:)'];
    end
    value = {data};
end

%%% ¡prop!
RESPONSE_CONSTRUCT (query, cell) constructs the responses based on specified data_format that flows through the network.
%%%% ¡calculate!
targets = nn.get('D').get('TARGETS');
if isempty(targets)
    value = {};
else
    response = [];
    for i = 1:1:length(targets)
        target = cell2mat(targets{i});
        response = [response; target(:)'];
    end
    value = {response};
end

%%% ¡prop!
MODEL (result, net) is a user defined neural network layers.
%%%% ¡calculate!
data = cell2mat(nn.get('DATA_CONSTRUCT'));
responses = cell2mat(nn.get('RESPONSE_CONSTRUCT'));
if isempty(data) || isempty(responses)
    value = network();
else
    data_format = nn.get('DATA_FORMAT');
    ind_channel = find(data_format == 'C');
    size_data = size(data);
    num_features = size_data(end);
    size_targets = size(responses);
    num_responses = size_targets(end);
    numLayers = nn.get('DENSE_LAYERS');
    layers = [featureInputLayer(num_features, 'Name', 'input')];
    for i = 1:1:length(numLayers)
        layers = [layers
            fullyConnectedLayer(numLayers(i), 'Name', ['fc' num2str(i)])
            batchNormalizationLayer('Name', ['batchNormalization' num2str(i)])
            dropoutLayer('Name', ['dropout' num2str(i)])
            ];
    end
    layers = [layers
        reluLayer('Name', 'relu1')
        fullyConnectedLayer(num_responses, 'Name', 'fc_output')
        regressionLayer('Name', 'output')
        ];

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
    value = trainNetwork(data, responses, layers, options);
end

%% ¡props!

%%% ¡prop!
DENSE_LAYERS (data, rvector) is a user defined neural network layers.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
train the regressor with example data
%%%% ¡code!

% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'])
    test_NNDataPoint_CON_REG % create example files
end

% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Groups of SubjectCON
im_gr = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_REG')) filesep 'Example data NN REG CON XLS' filesep 'CON_Group_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr = im_gr.get('GR');

% create a item list of NNDataPoint_CON_REG
it_list = cellfun(@(x) NNDataPoint_CON_REG( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', x.get('VOI_DICT').get('KEYS')), ...
    gr.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create a NNDataPoint_CON_REG DICT
dp_list = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_CON_REG', ...
        'IT_LIST', it_list ...
        );

% create a NNData containing the NNDataPoint_CON_REG DICT
d = NNData( ...
    'DP_CLASS', 'NNDataPoint_CON_REG', ...
    'DP_DICT', dp_list ...
    );

nn = NNRegressorMLP('D', d, 'DENSE_LAYERS', [20 20]);
trained_model = nn.get('MODEL');

% Check whether the number of fully-connected layer matches (excluding fc_output layer)
assert(length(nn.get('DENSE_LAYERS')) == sum(contains({trained_model.Layers.Name}, 'fc')) - 1, ...
    [BRAPH2.STR ':NNRegressorMLP:' BRAPH2.FAIL_TEST], ...
    'NNRegressorMLP does not construct the layers correctly. The number of the inputs should be the same as the length of dense layers the property.' ...
    )
