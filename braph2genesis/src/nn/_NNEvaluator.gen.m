%% ¡header!
ModelEvaluator < Element (me, model evaluator of a neural network model) evaluates the performance of a neural network model with a specific dataset.

%% ¡description!
This model evaluator evaluates the performance of a neural network model.
Instances of this class should not be created. 
Use one of its subclasses instead.

%% ¡props!
%%% ¡prop!
DATA (data, item) is a dataset processor contains a dataset and a neural network model.
%%%% ¡settings!
'DatasetProcessor'
%FIXME: update

%%% ¡prop!
TRAINED_NN (data, item) is a trained neural network model.
%%%% ¡settings!
'BaseNN'
%FIXME: update