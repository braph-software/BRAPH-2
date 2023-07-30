%% ¡header!
NNBase < ConcreteElement (nn, neural network trainor) trains a neural network model.

%%% ¡description!

%%% ¡seealso!
NNDataPoint, NNData

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the trainor for neural network analysis.
%%%% ¡default!
'NNBase'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the trainor for neural network analysis.
%%%% ¡default!
'...'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the trainor for neural network analysis.
%%%% ¡settings!
'NNBase'

%%% ¡prop!
ID (data, string) is a few-letter code for the trainor for neural network analysis.
%%%% ¡default!
'NNBase ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the trainor for neural network analysis.
%%%% ¡default!
'NNBase label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the trainor for neural network analysis.
%%%% ¡default!
'NNBase notes'
    
%% ¡props!

%%% ¡prop!
BATCH (parameter, scalar) is the size of the mini-batch to use for each training iteration.
%%%% ¡default!
8

%%% ¡prop!
EPOCHS (parameter, scalar) is a maximum number of epochs.
%%%% ¡default!
20

%%% ¡prop!
SHUFFLE (parameter, option) is an option for data shuffling.
%%%% ¡settings!
{'once' 'never' 'every-epoch'}

%%% ¡prop!
VERBOSE (parameter, logical) is an indicator to display training progress information.
%%%% ¡default!
false

%%% ¡prop!
SOLVER (parameter, option) is an option for the solver.

%%% ¡prop!
D (data, item) is the data to be used to train the NN.
%%%% ¡settings!
'NNData'

%%% ¡prop!
NNArchitecture (data, net) is the neural network architectre.
%%%% ¡settings!
'NNArchitecture'

%%% ¡prop!
MODEL (result, net) is a trained neural network model.
%%%% ¡calculate!
%value = trainNetwork(inputs, targets, layers, options);