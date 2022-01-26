%% ¡header!
NNClassifierEvaluator < NNEvaluator (nne, evaluator of a neural network classifier) evaluates the performance of a neural network classifier with a specific dataset.

%% ¡description!
This evaluator evaluates the performance of a neural network classifier
in terms of the receiver operating characteristic curve (ROC), the area under the
ROC curve (AUC) and the confusion matrix.

%% ¡props!
%%% ¡prop!
AUC (result, scalar) is an area under the curve score obtained from the dataset.
%%%% ¡calculate!
pred = nne.get('PREDICTION');
targets = nne.get('NNDATA').get('TARGETS');
classifier = nne.get('NN');
net = classifier.to_net(classifier.get('MODEL'));
class_names = net.Layers(end).Classes; 
[X, Y, T, auc] = perfcurve(categorical(targets{1}), pred(:,2), class_names(2));

value = auc;

%%% ¡prop!
VAL_AUC (result, scalar) is an area under the curve score obtained from the validation set.
%%%% ¡calculate!
pred = nne.get('VAL_PREDICTION');
targets = nne.get('NNDATA').get('VAL_TARGETS');
classifier = nne.get('NN');
net = classifier.to_net(classifier.get('MODEL'));
class_names = net.Layers(end).Classes; 
[X, Y, T, auc] = perfcurve(categorical(targets{1}), pred(:,2), class_names(2));

value = auc;

%%% ¡prop!
CONFUSION_MATRIX (result, matrix) is a confusion matrix obtained with a cut-off of 0.5.
%%%% ¡calculus!
value = 0

%% ¡props_update!
%%% ¡prop!
NNDATA (data, item) is a dataset for testing the neural networks.
%%%% ¡settings!
'NNClassifierData'

%%% ¡prop!
PREDICTION (result, matrix) is an output matrix of prediction from a neural network model.
%%%% ¡calculate!
nnd = nne.get('NNDATA');
classifier = nne.get('NN');
net = classifier.to_net(classifier.get('MODEL'));
inputs = nnd.get('INPUTS');
inputs = inputs{1};
inputs = reshape(inputs, [1, 1, size(inputs,1), size(inputs,2)]);

value = net.predict(inputs);

%%% ¡prop!
VAL_PREDICTION (result, matrix) is an output matrix of prediction for the validation set.
%%%% ¡calculate!
nnd = nne.get('NNDATA');
classifier = nne.get('NN');
net = classifier.to_net(classifier.get('MODEL'));
inputs = nnd.get('VAL_INPUTS');
inputs = inputs{1};
inputs = reshape(inputs, [1, 1, size(inputs,1), size(inputs,2)]);

value = net.predict(inputs);