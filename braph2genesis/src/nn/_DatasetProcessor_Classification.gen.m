%% ¡header!
DatasetProcessor_Classification < DatasetProcessor (dp, data processor of neural network classifier) produces the dataset for training or testing a neural netowrk classifier.  

%% ¡description!
This dataset processor produces the dataset that can be used to train
or test a neural network classifier. Feature selection procedure can be implemented.
Instances of this class should not be created. 
Use one of its subclasses instead.


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
FEATURE_SELECTION (data, item) is the feature selection analysis.
%%%% ¡settings!
'FeatureSelection'
%%%% ¡default!
FeatureSelection('DatasetProcessor', dp);

%%% ¡prop!
CLASSIFIER_NN (data, item) is the neural network classifier.
%%%% ¡settings!
'ClaasifierNN'
%%%% ¡default!
ClassifierNN('DatasetProcessor', dp);