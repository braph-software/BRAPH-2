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
PLOT_TRAINING (parameter, logical) is an option for the plot of training-progress.
%%%% ¡default!
false

%%% ¡prop!
PLOT_LAYERS (parameter, logical) is an option for the plot of layer architecture.
%%%% ¡default!
false

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

%% TODO: plotting the model architecture. 
%% Now it cannot be done because this kind of plot is a "figure" rather than a "uifigure".
% % % %%% ¡prop!
% % % PFNN (gui, item) contains the panel figure of the model architecture.
% % % %%%% ¡settings!
% % % 'PFNeuralNetworks'
% % % %%%% ¡postprocessing!
% % % if ~braph2_testing % to avoid problems with isqual when the element is recursive
% % %     nn.memorize('PFNN').set('NN', nn)
% % % end
% % % %%%% ¡gui!
% % % pr = PanelPropItem('EL', nn, 'PROP', NNBase.PFNN, ...
% % %     'GUICLASS', 'GUIFig', ...
% % %     varargin{:});

%%% ¡prop!
TEMPLATE (parameter, item) is the analysis template to set the parameters.
%%%% ¡settings!
'NNBase'
%%%% ¡postprocessing!
if nn.prop_set(NNBase.TEMPLATE, varargin{:})
    varargin = {};
    
    parameters = nn.getProps(Category.PARAMETER);
    for i = 1:1:length(parameters)
        parameter = parameters(i);
        
        if parameter ~= NNBase.TEMPLATE
            varargin{length(varargin) + 1} = parameter;
            varargin{length(varargin) + 1} = Callback('EL', nn.get('TEMPLATE'), 'PROP', parameter);
        end
    end
    
    nn.set(varargin{:});
end

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