%% ¡header!
NNRegressorEvaluator < NNEvaluator (nne, evaluator of a neural network regressor) evaluates the performance of a neural network regressor with a specific dataset.

%% ¡description!
This evaluator evaluates the performance of a neural network regressor
on root mean square error (RMSE).

%% ¡props!
%%% ¡prop!
RMSE (result, scalar) is the root mean squared error between targets and predictions.
%%%% ¡calculate!
preds = nne.get('PREDICTION');
targets = nne.get('NNDATA').get('TARGETS');
value = sqrt(mean((preds{1} - targets{1}).^2));

%%% ¡prop!
VAL_RMSE (result, scalar) is the root mean squared error between targets and predictions for validation set.
%%%% ¡calculate!
preds = nne.get('VAL_PREDICTION');
targets = nne.get('NNDATA').get('VAL_TARGETS');
value = sqrt(mean((preds{1} - targets{1}).^2));

%% ¡props_update!
%%% ¡prop!
NNDATA (data, item) is a dataset for testing the neural networks.
%%%% ¡settings!
'NNRegressorData'

%%% ¡prop!
PREDICTION (result, cell) is an output cell of prediction from a neural network model.
%%%% ¡calculate!
nnd = nne.get('NNDATA');
regressor = nne.get('NN');
net = regressor.to_net(regressor.get('MODEL'));
inputs = nnd.get('INPUTS');
inputs = inputs{1};
inputs = reshape(inputs, [1, 1, size(inputs,1), size(inputs,2)]);

value = {net.predict(inputs)};

%%% ¡prop!
VAL_PREDICTION (result, cell) is an output matrix of prediction for the validation set.
%%%% ¡calculate!
nnd = nne.get('NNDATA');
regressor = nne.get('NN');
net = regressor.to_net(regressor.get('MODEL'));
inputs = nnd.get('VAL_INPUTS');
inputs = inputs{1};
inputs = reshape(inputs, [1, 1, size(inputs,1), size(inputs,2)]);

value = {net.predict(inputs)};