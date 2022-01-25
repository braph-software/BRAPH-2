%% ¡header!
NNEvaluator < Element (nne, evaluator of a neural network model) evaluates the performance of a neural network model with a specific dataset.

%% ¡description!
This model evaluator evaluates the performance of a neural network model.
Instances of this class should not be created. 
Use one of its subclasses instead.

%% ¡props!
%%% ¡prop!
NN_DATA (data, item) is a dataset for neural networks.
%%%% ¡settings!
'NNData'

%%% ¡prop!
NN_MODEL (data, item) is a neural network that need to be evaluated.
%%%% ¡settings!
'NNBase'

%%% ¡prop!
NN_PREDICTION (result, matrix) is the predictions from a neural network.

%%% ¡prop!
NN_VAL_PREDICTION (result, matrix) is the predictions from a neural network for validation set.