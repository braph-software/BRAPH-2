%% ¡header!
NNData < Element (nnd, data of neural network) produces a dataset to train or test a neural netowrk.  

%% ¡description!
This dataset can be used to train or test a neural network. 
Instances of this class should not be created. 
Use one of its subclasses instead.

%% ¡props!
%%% ¡prop!
ID (data, string) is a few-letter code for the graph analysis.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph analysis.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph analysis.

%%% ¡prop!
INPUT_TYPE (data, option) is the input type for training or testing the NN.
%%%% ¡settings!
{'adjacency_matrices' 'graph_measures' 'structural_data'}

%%% ¡prop!
MEASURES (data, classlist) is the graph measures as input to NN.
%%%% ¡settings!
{'Measure'}
%%%% ¡default!
{'DegreeAv', 'Degree'}

%%% ¡prop!
TARGET_NAME (data, string) is the name of the traget.
%%%% ¡default!
'diagnosis'

%%% ¡prop!
GR (data, item) is a group of subjects defined as SubjectCON class.
%%%% ¡settings!
'Group'
%%%% ¡default!
Group()

%%% ¡prop!
GR_NN (result, item) is a group of NN subjects.
%%%% ¡settings!
'NNGroup'
