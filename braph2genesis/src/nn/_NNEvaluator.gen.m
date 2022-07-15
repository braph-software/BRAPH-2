%% ¡header!
NNEvaluator < Element (nne, evaluator for a neural network) evaluates the performance of a neural network with a specific dataset.

%% ¡description!
This evaluator evaluates the performance of a neural network.
Instances of this class should not be created. 
Use one of its subclasses instead.

%% ¡props!
%%% ¡prop!
ID (data, string) is a few-letter code for the evaluator.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the evaluator.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the evaluator.

%%% ¡prop!
NN (data, item) is a neural network model to be evaluated.
%%%% ¡settings!
'NNBase'

%%% ¡prop!
GR (data, item) is a group of NN subjects that the NN model will be evaluated on.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
GR_PREDICTION (result, item) is a group of NN subjects containing the prediction from the neural network.
%%%% ¡settings!
'NNGroup'
%%%% ¡gui!
pr = PPNNData_GR_NN('EL', nne, 'PROP', NNEvaluator.GR_PREDICTION, varargin{:});

%%% ¡prop!
FEATURE_MAP (result, cell) is a feature map obtained with feature selection analysis.
%%%% ¡calculate!
sub_dict = nne.get('GR').get('SUB_DICT');
if sub_dict.length() == 0
    value = {};
else
    value = sub_dict.getItem(1).get('FEATURE_MASK');
end
%%%% ¡gui!
pr = PPNNEvaluator_Feature_Map('EL', nne, 'PROP', NNEvaluator.FEATURE_MAP, varargin{:});
