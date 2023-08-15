%% ¡header!
NNBase < ConcreteElement (nn, neural network) comprises a neural network model with a dataset.

%%% ¡description!
A neural network base (NNBase) comprises a neural network model with a specific dataset, along with the required options for training the model.
Instances of this class should not be created. Use one of its subclasses instead.
Its subclasses shall be specifically designed to cater to different use cases such as a classifier, a regressor, or a generative model.

%%% ¡seealso!
NNDataPoint, NNDataset, NNEvaluator

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the nerual network base.
%%%% ¡default!
'NNBase'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the nerual network base.
%%%% ¡default!
'A neural network base (NNBase) comprises a neural network model with a specific dataset, along with the required options for training the model. Instances of this class should not be created. Use one of its subclasses instead. Its subclasses shall be specifically designed to cater to different use cases such as a classifier, a regressor, or a generative model.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the nerual network base.
%%%% ¡settings!
'NNBase'

%%% ¡prop!
ID (data, string) is a few-letter code for the nerual network base.
%%%% ¡default!
'NNBase ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the nerual network base.
%%%% ¡default!
'NNBase label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the nerual network base.
%%%% ¡default!
'NNBase notes'
    
%% ¡props!

%%% ¡prop!
D (data, item) is the dataset to train the neural network model.
%%%% ¡settings!
'NNDataset'

%%% ¡prop!
EPOCHS (parameter, scalar) is the maximum number of epochs.
%%%% ¡default!
20

%%% ¡prop!
BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.
%%%% ¡default!
8

%%% ¡prop!
SHUFFLE (parameter, option) is an option for data shuffling.
%%%% ¡settings!
{'once' 'never' 'every-epoch'}

%%% ¡prop!
SOLVER (parameter, option) is an option for the solver.
%%%% ¡settings!
{'adam' 'sgdm' 'rmsprop'}

%%% ¡prop!
MODEL (result, net) is a trained neural network model with the given dataset.
%%%% ¡calculate!
value = network();

%%% ¡prop!
INPUTS (query, cell) constructs the cell array of the data.
%%%% ¡calculate!
% inputs = nn.get('inputs', D) returns a cell array with the
%  inputs for all data points in dataset D.
if isempty(varargin)
    value = {};
    return
end
value = {};

%%% ¡prop!
TARGETS (query, cell) constructs the cell array of the targets.
%%%% ¡calculate!
% targets = nn.get('PREDICT', D) returns a cell array with the
%  targets for all data points in dataset D.
if isempty(varargin)
    value = {};
    return
end
value = {};

%%% ¡prop!
TRAIN (query, empty) trains the neural network model with the given dataset.
%%%% ¡calculate!
nn.memorize('MODEL');
value = [];

%%% ¡prop!
VERBOSE (parameter, logical) is an indicator to display training progress information.
%%%% ¡default!
false

%%% ¡prop!
PLOT_TRAINING (parameter, option) determines whether to plot the training progress.
%%%% ¡settings!
{'none' 'training-progress'}

%%% ¡prop!
PREDICT (query, cell) returns the predictions of the trained neural network for a dataset.
%%%% ¡calculate!
% PREDICTIONS = nn.get('PREDICT', D) returns a cell array with the
%  predictions for all data points in dataset D.
if isempty(varargin)
    value = {};
    return
end

d = varargin{1};
inputs = nn.get('INPUTS', d);
if isempty(inputs)
    predictions = {};
else
    net = nn.get('MODEL');
    predictions = {net.predict(cell2mat(inputs))};
end
value = predictions;
