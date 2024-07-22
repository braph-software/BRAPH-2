%% ¡header!
NNDataPoint_Shuffled < NNDataPoint (dp, permuted neural network data point for multi-layer perceptron) is a data point with permuted features for for multi-layer perceptron neural network.

%%% ¡description!
A permuted neural network data point for multi-layer perceptron (NNDataPointMLP_Shuffled) contains a data point with its permuted inputs and original targets for multi-layer perceptron neural network analysis.
The permuted inputs are used to evaluate the impact of specific features on the performance of the multi-layer perceptron neural network.

%%% ¡seealso!
NNDataPoint, NNDataset

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the data point for neural network analysis .
%%%% ¡default!
'NNDataPoint_Permuted'

%%% ¡prop!
NAME (constant, string) is the name of the data point for neural network analysis.
%%%% ¡default!
'Permuted Neural Network Data Point'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the data point for neural network analysis.
%%%% ¡default!
'A permuted neural network data point (NNDataPoint_Permuted) contains a data point with its permuted inputs and original targets for neural network analysis. The permuted inputs are used to evaluate the impact of specific features on the performance of the neural network.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the data point for neural network analysis.
%%%% ¡settings!
'NNDataPoint_Permuted'

%%% ¡prop!
ID (data, string) is a few-letter code for the data point for neural network analysis.
%%%% ¡default!
'NNDataPoint_Permuted ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the data point for neural network analysis.
%%%% ¡default!
'NNDataPoint_Permuted label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the data point for neural network analysis.
%%%% ¡default!
'NNDataPoint_Permuted notes'

%%% ¡prop!
INPUT (result, cell) is the input value for this data point.
%%%% ¡calculate!
value = dp.get('SHUFFLED_INPUT');

%% ¡props!
%%% ¡prop!
SHUFFLED_INPUT (data, cell) is the shuffled input value for this data point.