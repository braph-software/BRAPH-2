%% ¡header!
NNEvaluator < Element (nne, evaluator for a neural network) evaluates the performance of a neural network with a specific dataset.

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
WAITBAR (metadata, logical) detemines whether to show the waitbar.
%%%% ¡default!
true

%%% ¡prop!
NN (data, item) is a neural network model to be evaluated.
%%%% ¡settings!
'NNBase'

%%% ¡prop!
GR (data, item) is a group of NN subjects that the NN model will be evaluated on.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
GR_PREDICTION (result, item) is a group of NN subjects containing the prediction from the neural network.
%%%% ¡settings!
'NNGroup'