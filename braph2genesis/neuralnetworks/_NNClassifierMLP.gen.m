%% ¡header!
NNClassifierMLP < NNBase (nn, multi-layer perceptron classifier) comprises a multi-layer perceptron classifier model and a given dataset.

%%% ¡description!
A neural network multi-layer perceptron classifier (NNClassifierMLP) comprises a multi-layer perceptron classifier model and a given dataset.
NNClassifierMLP trains the multi-layer perceptron classifier with a formatted inputs ("CB", channel and batch) derived from the given dataset.

%%% ¡seealso!
NNDataPoint_CON_CLA, NNClassifier_Evaluator

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the neural network multi-layer perceptron classifier.
%%%% ¡default!
'NNClassifierMLP'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the neural network multi-layer perceptron classifier.
%%%% ¡default!
'A neural network multi-layer perceptron classifier (NNClassifierMLP) comprises a multi-layer perceptron classifier model and a given dataset. NNClassifierMLP trains the multi-layer perceptron classifier with a formatted inputs ("CB", channel and batch) derived from the given dataset.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the neural network multi-layer perceptron classifier.
%%%% ¡settings!
'NNClassifierMLP'

%%% ¡prop!
ID (data, string) is a few-letter code for the neural network multi-layer perceptron classifier.
%%%% ¡default!
'NNClassifierMLP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the neural network multi-layer perceptron classifier.
%%%% ¡default!
'NNClassifierMLP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the neural network multi-layer perceptron classifier.
%%%% ¡default!
'NNClassifierMLP notes'

%%% ¡prop!
D (data, item) is the dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.
%%%% ¡settings!
'NNDataset'
%%%% ¡default!
NNDataset('DP_CLASS', 'NNDataPoint_CON_CLA')

%%% ¡prop!
DP_CLASSES (parameter, classlist) is the list of compatible data points.
%%%% ¡default!
{'NNDataPoint_CON_CLA' 'NNDataPoint_Graph_CLA' 'NNDataPoint_Measure_CLA'}

%%% ¡prop!
INPUTS (query, cell) constructs the data in the CB (channel-batch) format.
%%%% ¡calculate!
% inputs = nn.get('inputs', D) returns a cell array with the
%  inputs for all data points in dataset D.
if isempty(varargin)
    value = {};
    return
end
d = varargin{1};
inputs_group = d.get('INPUTS');
if isempty(inputs_group)
    value = {};
else
    flattened_inputs_group = [];
    for i = 1:1:length(inputs_group)
        inputs_individual = inputs_group{i};
        flattened_inputs_individual = [];
        while ~isempty(inputs_individual)
            currentData = inputs_individual{end};  % Get the last element from the stack
            inputs_individual = inputs_individual(1:end-1);   % Remove the last element

            if iscell(currentData)
                % If it's a cell array, add its contents to the stack
                inputs_individual = [inputs_individual currentData{:}];
            else
                % If it's numeric or other data, append it to the vector
                flattened_inputs_individual = [currentData(:); flattened_inputs_individual];
            end
        end
        flattened_inputs_group = [flattened_inputs_group; flattened_inputs_individual'];
    end
    value = {flattened_inputs_group};
end

%%% ¡prop!
MODEL (result, net) is a trained neural network model.
%%%% ¡calculate!
inputs = cell2mat(nn.get('INPUTS', nn.get('D')));
targets = nn.get('TARGET_IDS', nn.get('D'));
if isempty(inputs) || isempty(targets)
    value = network();
else
    number_features = size(inputs, 2);
    number_targets = size(targets, 2);
    targets = categorical(targets); 
    number_classes = numel(categories(targets));
    
    layers = nn.get('LAYERS');
    nn_architecture = [featureInputLayer(number_features, 'Name', 'Input')];
    for i = 1:1:length(layers)
        nn_architecture = [nn_architecture
            fullyConnectedLayer(layers(i), 'Name', ['Dense_' num2str(i)])
            batchNormalizationLayer('Name', ['BatchNormalization_' num2str(i)])
            dropoutLayer('Name', ['Dropout_' num2str(i)])
            ];
    end
    nn_architecture = [nn_architecture
        reluLayer('Name', 'Relu_output')
        fullyConnectedLayer(number_classes, 'Name', 'Dense_output')
        softmaxLayer
        classificationLayer('Name', 'Output')
        ];

    % specify trianing options
    options = trainingOptions(nn.get('SOLVER'), ...
        'MiniBatchSize', nn.get('BATCH'), ...
        'MaxEpochs', nn.get('EPOCHS'), ...
        'Shuffle', nn.get('SHUFFLE'), ...
        'Plots', nn.get('PLOT_TRAINING'), ...
        'Verbose', nn.get('VERBOSE'));

    % train the neural network
    value = trainNetwork(inputs, targets, nn_architecture, options);
end

%% ¡props!

%%% ¡prop!
TARGET_IDS (query, stringlist) constructs the target IDs which represent the class of each data point.
%%%% ¡calculate!
% targets = nn.get('TARGET_IDS', D) returns a cell array with the
%  targets for all data points in dataset D.
if isempty(varargin)
    value = {''};
    return
end
d = varargin{1};
targets = d.get('TARGETS');
if isempty(targets)
    value = {''};
else
    nn_targets = [];
    for i = 1:1:length(targets)
        target = targets{i};
        nn_targets = [nn_targets; target];
    end
    value = nn_targets;
end

%%% ¡prop!
LAYERS (data, rvector) defines the number of layers and their neurons.
%%%% ¡default!
[32 32]

%% ¡tests!

%%% ¡test!
%%%% ¡name!
train the classifier with example data
%%%% ¡code!

% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'])
    test_NNDataPoint_CON_CLA % create example files
end

% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Groups of SubjectCON
im_gr1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'CON_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'CON_Group_2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

% create item lists of NNDataPoint_CON_CLA
[~, group_folder_name] = fileparts(im_gr1.get('DIRECTORY'));
it_list1 = cellfun(@(x) NNDataPoint_CON_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', {group_folder_name}), ...
    gr1.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

[~, group_folder_name] = fileparts(im_gr2.get('DIRECTORY'));
it_list2 = cellfun(@(x) NNDataPoint_CON_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', {group_folder_name}), ...
    gr2.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create NNDataPoint_CON_CLA DICT items
dp_list1 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_CON_CLA', ...
        'IT_LIST', it_list1 ...
        );

dp_list2 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_CON_CLA', ...
        'IT_LIST', it_list2 ...
        );

% create a NNDataset containing the NNDataPoint_CON_CLA DICT
d1 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_CON_CLA', ...
    'DP_DICT', dp_list1 ...
    );

d2 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_CON_CLA', ...
    'DP_DICT', dp_list2 ...
    );

% combine the two datasets
d = NNDatasetCombine('D_LIST', {d1, d2}).get('D');

nn = NNClassifierMLP('D', d, 'LAYERS', [10 10 10]);
trained_model = nn.get('MODEL');

% Check whether the number of fully-connected layer matches (excluding Dense_output layer)
assert(length(nn.get('LAYERS')) == sum(contains({trained_model.Layers.Name}, 'Dense')) - 1, ...
    [BRAPH2.STR ':NNClassifierMLP:' BRAPH2.FAIL_TEST], ...
    'NNClassifierMLP does not construct the layers correctly. The number of the inputs should be the same as the length of dense layers the property.' ...
    )