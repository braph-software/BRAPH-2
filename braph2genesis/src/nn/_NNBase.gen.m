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
MODEL (result, cell) is a trained neural network.
%%%% ¡gui!
pr = PPNNBase_Model('EL', nn, 'PROP', nn.MODEL, varargin{:});

%% ¡methods!
function installed = check_nn_toolboxes(nn)
    %CHECK_NN_TOOLBOXES checks whether the deep-learning-required toolboxes are installed.
    %
    % INSTALLED = CHECK_NN_TOOLBOXES(NN) checks the installation of the toolboxes:
    %  "Deep Learning Toolbox" and 
    %  "Deep learning Toolbox Converter for ONNX Model Format" installation status. 
    %  If they are not installed, then it throws a warning.
    %  Typically, this method is only called internally when training
    %  any subclass of the neural networks.
    
    addons = matlab.addons.installedAddons;
    installed = all(ismember(["Deep Learning Toolbox"; "Deep Learning Toolbox Converter for ONNX Model Format"], addons.Name));
    if ~installed
        warning(['Some of the required deep-learning toolboxs are not installed. ' ...
            'Please, refer to ' ...
            '<a href="matlab: web(''https://se.mathworks.com/products/deep-learning.html'') ">Deep Learning Toolbox</a> ' ...
            'and ' ...
            '<a href="matlab: web(''https://se.mathworks.com/matlabcentral/fileexchange/67296-deep-learning-toolbox-converter-for-onnx-model-format'') ">Deep Learning Toolbox Converter for ONNX Model Format</a>'])
    end
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Net import and export
%%%% ¡code!
net = squeezenet;
img = rand(net.Layers(1).InputSize);
pred_from_original_net = predict(net, img);

net_braph = NNBase().to_net(NNBase().from_net(squeezenet), "BCSS", "classification");
pred_from_braph = predict(net_braph, img);

assert(max(abs(pred_from_braph - pred_from_original_net)) < 1E-06, ...
    [BRAPH2.STR ':NNBase:' BRAPH2.BUG_ERR], ...
    'Prediction is not being calculated correctly for neural networks.')