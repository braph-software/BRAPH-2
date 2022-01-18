%% ¡header!
ModelEvaluator_Classification < ModelEvaluator (me, model evaluator of a neural network classifier)

%% ¡description!
This dataset processor uses connectivity data as input and produce the dataset 
that can be used to train a neural network classifier. Feature selection procedure
can be implemented.

%% ¡props!
%%% ¡prop!
GR1 (data, item) is the subject group 1.
%%%% ¡settings!
'Group'

%%% ¡prop!
GR2 (data, item) is the subject group 2.
%%%% ¡settings!
'Group'

%%% ¡prop!
FEATURE_SELECTION (data, item) is the subject group 2.
%%%% ¡settings!
'FeatureSelection'
%%%% ¡default!
me.get('TRAINED_MODEL').get('DATASET_PROCESSOR').get('FEATURE_SELECTION')

%%% ¡prop!
DATASET_PREPROCESS(result, item)
%%%% ¡settings!
'DatasetProcessor_Classification'

%%% ¡AUC!
DATASET_PREPROCESS(result, item)
%%%% ¡settings!
'DatasetProcessor_Classification'
