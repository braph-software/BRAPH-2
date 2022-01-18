%% ¡header!
ModelEvaluator_Classification_CON_WU < ModelEvaluator_Classification (me, model evaluator of a neural network classifier)

%% ¡description!
This dataset processor uses connectivity data as input and produce the dataset 
that can be used to train a neural network classifier. Feature selection procedure
can be implemented.


%% ¡props_update!
%%% ¡prop!
GR1 (data, item) is the subject group 1, which also defines the subject class SubjectCON.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON')

%%% ¡prop!
GR2 (data, item) is the subject group 2, which also defines the subject class SubjectCON.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON')

%%% ¡prop!
DATASET_PROCESSOR (data, item) is the dataset processor that prepares the dataset for training a neural network model.
%%%% ¡settings!
'DatasetProcessor_Classification_CON_WU'
%%%% ¡default!
DatasetProcessor_Classification_CON_WU( ...
    'GR1', me.get('GR1'), ...
    'GR2', me.get('GR2'), ...
    'DENSITY_OF_FEATURE_SELECTION', 0.05, ...
    'FEATURE_SELECTION', me.get('TRAINED_MODEL').get('DATASET_PROCESSOR').get('FEATURE_SELECTION')...
    )

%%% ¡prop!
TRAINED_MODEL (data, item) is the dataset processor that prepares the dataset for training a neural network model.
%%%% ¡settings!
'ClassifierNN'

%% ¡tests!
%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_CON_WU_NN
