%% ¡header!
NNEvaluator_REG < NNEvaluator (nn, neural network trainor) evaluates a neural network model with a dataset.

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
    
%%% ¡prop!
NN (data, item) is a trained neural network model.
%%%% ¡settings!
'NNRegressorMLP'

%%% ¡prop!
PREDICTIONS (result, cell) is a trained neural network model.
%%%% ¡calculate!
value = {};

%% ¡props!
%%% ¡prop!
CORRELATION_COEFF (result, cell) is an option for data shuffling.

%%% ¡prop!
COEFF_OF_DETERMINATION (result, cell) is an option for data shuffling.

%%% ¡prop!
mean_absolute_error (result, cell) is an option for data shuffling.

%%% ¡prop!
mean_squared_error (result, cell) is an option for data shuffling.

%%% ¡prop!
root_mean_squared_error (result, cell) is an option for data shuffling.
