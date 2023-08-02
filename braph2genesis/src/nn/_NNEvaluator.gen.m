%% ¡header!
NNEvaluator < ConcreteElement (nn, neural network trainor) evaluates a neural network model with a dataset.

%%% ¡description!

%%% ¡seealso!
NNDataPoint, NNData

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the trainor for neural network analysis.
%%%% ¡default!
'NNEvaluator'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the trainor for neural network analysis.
%%%% ¡default!
'...'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the trainor for neural network analysis.
%%%% ¡settings!
'NNEvaluator'

%%% ¡prop!
ID (data, string) is a few-letter code for the trainor for neural network analysis.
%%%% ¡default!
'NNEvaluator ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the trainor for neural network analysis.
%%%% ¡default!
'NNEvaluator label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the trainor for neural network analysis.
%%%% ¡default!
'NNEvaluator notes'
    
%% ¡props!

%%% ¡prop!
D (data, item) is the data to be used to evaluate the NN.
%%%% ¡settings!
'NNData'

%%% ¡prop!
NN (data, item) is a trained neural network model.
%%%% ¡settings!
'NNBase'

%%% ¡prop!
PREDICTIONS (result, cell) is a trained neural network model.
