%% ¡header!
NNDataSplit < ConcreteElement (dsp, splitter of a neural network data) splites a neural network data.

%%% ¡description!
NNDataSplit splits a dataset.

%%% ¡seealso!
NNData

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the splitter of a neural network data.
%%%% ¡default!
'NNDataSplit'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the splitter of a neural network data.
%%%% ¡default!
'NNDataSplit represents a dataset wherein each datapoint, the corresponding class defined as DP_CLASS property. NNData encloses all the necessary inputs and targets, readily available for integration into neural network analysis procedures.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the splitter of a neural network data.
%%%% ¡settings!
'NNDataSplit'

%%% ¡prop!
ID (data, string) is a few-letter code for the splitter of a neural network data.
%%%% ¡default!
'NNDataSplit ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the splitter of a neural network data.
%%%% ¡default!
'NNDataSplit label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the splitter of a neural network data.
%%%% ¡default!
'NNDataSplit notes'
    
%% ¡props!

%%% ¡prop!
D (data, item) is a dataset for neural network analysis.
%%%% ¡settings!
'NNData'

%%% ¡prop!
SPLIT (data, cell) is an cell containing the ratio numbers or the vectors stating which datapoints belong to the splitted neural network datasets.
%%%% ¡check_prop!

%%%% ¡preset!

%%% ¡prop!
D_SPLIT (result, itemlist) is the itemlist of splitted neural network datasets.
%%%% ¡calculate!
