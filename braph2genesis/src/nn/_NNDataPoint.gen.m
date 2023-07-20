%% ¡header!
NNDataPoint < ConcreteElement (dp, neural network data point) is a datapoint for neural network analysis.

%%% ¡description!
NNDataPoint contains the input and target for neural network analysis.
Instances of this class should not be created. Use one of its subclasses instead.
Its subclasses shall be specifically designed to cater to different use cases such as classification task, regression task, or data generation.

%%% ¡seealso!
NNData

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the datapoint for neural network analysis.
%%%% ¡default!
'NNDataPoint'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the datapoint for neural network analysis.
%%%% ¡default!
'NNDataPoint contains the input and target for neural network analysis. Instances of this class should not be created. Use one of its subclasses instead. Its subclasses shall be specifically designed to cater to different use cases such as classification task, regression task, or data generation.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the datapoint for neural network analysis.
%%%% ¡settings!
'NNDataPoint'

%%% ¡prop!
ID (data, string) is a few-letter code for the datapoint for neural network analysis.
%%%% ¡default!
'NNDataPoint ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the datapoint for neural network analysis.
%%%% ¡default!
'NNDataPoint label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the datapoint for neural network analysis.
%%%% ¡default!
'NNDataPoint notes'

%% ¡props!

%%% ¡prop!
INPUT (result, cell) is the input value for this data point.

%%% ¡prop!
TARGET (result, cell) is the target value for this data point.