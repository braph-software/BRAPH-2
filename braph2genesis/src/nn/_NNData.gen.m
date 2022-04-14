%% ¡header!
NNData < Element (nnd, data for neural network) produces a dataset to train or test a neural netowrk model.  

%% ¡description!
This NN data generates a group of NN subjects, each of which contains the 
input as structural, adjacency matrices, or graph measures from all of the 
modalities. The generated NN group can be used to train or test neural 
network models.
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
WAITBAR (metadata, logical) detemines whether to show the waitbar.
%%%% ¡default!
true

%%% ¡prop!
INPUT_TYPE (data, option) is the input type for training or testing the NN.
%%%% ¡settings!
{'adjacency_matrices' 'graph_measures' 'structural_data'}
%%%% ¡gui!
pr = PPNNData_Input_Type('EL', nnd, 'PROP', NNData.INPUT_TYPE, varargin{:});

%%% ¡prop!
G (data, item) is the graph for calculating the graph measures.
%%%% ¡default!
GraphWU()

%%% ¡prop!
MEASURES (data, classlist) is the graph measures as input to NN.
%%%% ¡settings!
{'Measure'}
'Measure'
%%%% ¡default!
{'DegreeAv', 'Degree'}
%%%% ¡gui!
pr = PPNNData_Measures('EL', nnd, 'PROP', NNData.MEASURES, varargin{:});

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
%%%% ¡gui!
pr = PPNNData_GR_NN('EL', nnd, 'PROP', NNData.GR_NN, varargin{:});
