%% ¡header!
NNEvaluator < Element (nne, evaluator of a neural network) evaluates the performance of a neural network with a specific dataset.

%% ¡description!
This evaluator evaluates the performance of a neural network.
Instances of this class should not be created. 
Use one of its subclasses instead.

%% ¡props!
%%% ¡prop!
ID (data, string) is a few-letter code for the evaluator.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the evaluator.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the evaluator.

%%% ¡prop!
NNDATA (data, item) is a dataset for neural networks.
%%%% ¡settings!
'NNData'

%%% ¡prop!
NN (data, item) is a neural network model that needs to be evaluated.
%%%% ¡settings!
'NNBase'

%%% ¡prop!
PREDICTION (result, matrix) is the predictions from a neural network.

%%% ¡prop!
VAL_PREDICTION (result, matrix) is the predictions from a neural network for validation set.