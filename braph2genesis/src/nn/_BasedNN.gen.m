%% ¡header!
BasedNN < Element (nn, based neural network) is a based neural network.

%%% ¡description!
basedNN provides the methods necessary for setting up based neural networks.
Instances of this class should not be created. 
Use one of its subclasses instead.

%%% ¡seealso!
Regression

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the classification.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the classification.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the classification.

%%% ¡prop!
GR1 (data, item) is the subject group, which also defines the subject class.
%%%% ¡settings!
'Group'

%%% ¡prop!
GR2 (data, item) is the subject group, which also defines the subject class.
%%%% ¡settings!
'Group'

%%% ¡prop!
G_DICT (result, idict) is the graph enemble obtained from this analysis.
%%%% ¡settings!
'Graph'
%%%% ¡calculate!
value = IndexedDictionary('IT_CLASS', 'Graph');

%%% ¡prop!
NEURAL_NETWORK (result, string) is the loss between the labels and predictions


%% ¡methods!
function tbl = getTrainingTable(nn)
    tbl = nn.X_tblTrain
end

function tbl = getTrainingLable(nn)
    tbl = nn.y_tblTrain
end

function tbl = getTestTable(nn)
    tbl = nn.X_tblTest
end

function tbl = getTestLable(nn)
    tbl = nn.y_tblTest
end

function transformed_net = net_transformer(net)
    % output path should be specified
    transformed_net = [fileparts(which('example_CON_WU')) filesep 'trained_net.onnx']
    exportONNXNetwork(net,filename)
end
