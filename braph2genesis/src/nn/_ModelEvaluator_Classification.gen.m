%% ¡header!
ModelEvaluator_Classification < ModelEvaluator (me, model evaluator of a neural network classifier) evaluates the performance of a neural network classifier with a specific dataset.

%% ¡description!
This model evaluator evaluates the performance of a neural network classifier
in terms of the receiver operating characteristic curve (ROC), the area under the
ROC curve (AUC) and the confusion matrix.

%% ¡props!
%%% ¡prop!
PREDICTION_NN (result, matrix) is an output matrix of prediction from a neural network model.
%%%% ¡calculate!
dp = me.get('DATASET_PROCESSOR');
nn = me.get('TRAINED_MODEL').transform_to_matlab_format();
x_masked = dp.get('X_MASKED');
x_masked = x_masked{1};
x_masked = reshape(x_masked, [1, 1, size(x_masked,1), size(x_masked,2)]);

value = nn.predict(x_masked);

%%% ¡prop!
AUC (result, scalar) is an area under the curve score obtained from the neural network prediction.
%%%% ¡calculate!
pred = me.get('PREDICTION_NN');
y = me.get('DATASET_PROCESSOR').get('Y');
nn = me.get('TRAINED_MODEL').transform_to_matlab_format();
class_names = nn.Layers(end).Classes; 
[X,Y,T,auc] = perfcurve(categorical(y{1}), pred(:,2), class_names(2));

value = auc;

%%% ¡prop!
CONFUSION_MATRIX (result, matrix) is a confusion matrix obtained from the neural network prediction by a cut-off of 0.5.
%%%% ¡calculus!
value = 0

%% ¡props_update!
%%% ¡prop!
DATASET_PROCESSOR (data, item) is a dataset processor contains a dataset and a neural network classifier.
%%%% ¡settings!
'DatasetProcessor_Classification'



