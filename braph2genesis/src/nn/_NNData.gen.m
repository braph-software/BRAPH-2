%% ¡header!
NNData < Element (nnd, data of neural network) produces a dataset to train or test a neural netowrk.  

%% ¡description!
This dataset can be used to train or test a neural network. 
Feature selection procedure can be implemented.
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
INPUTS (result, cell) is the inputs for training or testing a neural network.