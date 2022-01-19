%% ¡header!
ModelEvaluator_Classification < ModelEvaluator (me, model evaluator of a neural network classifier) evaluates the performance of a neural network classifier with specific dataset.

%% ¡description!
This model evaluator evaluates the performance of a neural network classifier
in terms of the receiver operating characteristic curve (ROC), the area under the
ROC curve (AUC) and the confusion matrix.

%% ¡prop!
%%% ¡prop!
PREDICTION (result, matrix)
%%%% ¡calculus!
value = 0

%%% ¡prop!
AUC (result, scalar)
%%%% ¡calculus!
value = 0

%%% ¡prop!
CONFUSION_MATRIX (result, matrix)
%%%% ¡calculus!
value = 0

%% ¡props_update!
%%% ¡prop!
DATASET_PREPROCESS (data, item) is the dataset for testing the classifier.
%%%% ¡settings!
'DatasetProcessor_Classification'



