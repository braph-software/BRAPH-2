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
NN_TRAINED (data, item) is a trained neural network.
%%%% ¡settings!
'NNBase'

%%% ¡prop!
NN_PREDICTION (result, matrix) is the predictions from neural networks.

%%% ¡prop!
NN_VAL_PREDICTION (result, matrix) is the predictions from neural networks for validation set.