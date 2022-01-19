%% ¡header!
ModelEvaluator_Classification_CON_WU < ModelEvaluator_Classification (me, model evaluator of a neural network classifier using connectivity data) evaluates the performance of a neural network classifier with a specific connectivity dataset.

%% ¡description!
This model evaluator evaluates the performance of a neural network classifier
with a connectivity dataset in terms of the receiver operating characteristic curve (ROC),
the area under the ROC curve (AUC) and the confusion matrix.

%% ¡props_update!
%%% ¡prop!
DATASET_PROCESSOR (data, item) is the dataset processor contains the connectivity dataset and the neural network classifier
%%%% ¡settings!
'DatasetProcessor_Classification_CON_WU'

%% ¡tests!
%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_CON_WU_NN
