%% ¡header!
NNData < ConcreteElement (d, neural network data) is a dataset for neural network analysis.

%%% ¡description!
NNData represents a dataset containing datapoints whose class is defined by the DP_CLASS property.
NNData can contain all the necessary inputs and targets.

%%% ¡seealso!
NNDataPoint, NNDataCombine, NNDataSplit

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the dataset for neural network analysis.
%%%% ¡default!
'NNData'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the dataset for neural network analysis.
%%%% ¡default!
'NNData represents a dataset containing datapoints whose class is defined by the DP_CLASS property. NNData can contain all the necessary inputs and targets.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the dataset for neural network analysis.
%%%% ¡settings!
'NNData'

%%% ¡prop!
ID (data, string) is a few-letter code for the dataset for neural network analysis.
%%%% ¡default!
'NNData ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the dataset for neural network analysis.
%%%% ¡default!
'NNData label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the dataset for neural network analysis.
%%%% ¡default!
'NNData notes'
    
%% ¡props!

%%% ¡prop!
DP_CLASS (parameter, class) is the class of the data points
%%%% ¡settings!
'NNDataPoint'

%%% ¡prop!
DP_DICT (data, idict) is an indexed dictionary containing the data points.
%%%% ¡settings!
'NNDataPoint'

%%% ¡prop!
INPUTS (result, cell) is a collection of the inputs from all data points.
%%%% ¡calculate!
value = cellfun(@(dp) dp.get('INPUT'), d.get('DP_DICT').get('IT_LIST'), 'UniformOutput', false);

%%% ¡prop!
TARGETS (result, cell) is a collection of the targets from all data points.
%%%% ¡calculate!
value = cellfun(@(dp) dp.get('TARGET'), d.get('DP_DICT').get('IT_LIST'), 'UniformOutput', false);