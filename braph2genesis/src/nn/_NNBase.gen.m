%% ¡header!
NNBase < Element (nn, base neural network) is a base neural network.

%%% ¡description!
NNBase provides the methods necessary for setting up neural networks.
Instances of this class should not be created. 
Use one of its subclasses instead.

%% ¡props!
%%% ¡prop!
ID (data, string) is a few-letter code for the neural network.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the neural network.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the neural network.

%%% ¡prop!
GR (data, item) is a group of NN subjects containing the information for training the neural network.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
MODEL (result, net) is a trained neural network.
%%%% ¡calculate!
if BRAPH2.installed('NN', 'warning')
    value = squeezenet;
else
    value = NoValue();
end
%%%% ¡gui_!
% % % pr = PPNNBase_Model('EL', nn, 'PROP', nn.MODEL, varargin{:});

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Net format verification
%%%% ¡code!
if BRAPH2.installed('NN', 'warning')
    net = squeezenet;
    img = rand(net.Layers(1).InputSize);
    pred_from_original_net = predict(net, img);

    net_braph = NNBase().get('MODEL');
    pred_from_braph = predict(net_braph, img);

    assert(isequal(pred_from_original_net, pred_from_braph), ...
        [BRAPH2.STR ':NNBase:' BRAPH2.BUG_ERR], ...
        'Prediction is not being calculated correctly for saved neural networks.')
end