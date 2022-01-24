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

%%%% ¡prop!
DATA (data, item) 
%%%% ¡settings!
'NNData'

%%% ¡prop!
TRAINED_NN (result, cell) is a trained neural network model.
%%%% ¡calculate!
value = nn.from_net(net);

%FIXME: check format of this prop - check that it works for all NN

% % % %%%% ¡gui!
% % % pl = PlotPropNNAnalysis('EL', nn, 'PROP', BaseNN.NEURAL_NETWORK_ANALYSIS, varargin{:});

%% ¡methods!
function installed = check_nn_toolboxes(nn) %FIXME
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
function nn_str = from_net(nn, net)
%FIXME: update function name everywhere
    %FROM_NET transforms the build-in neural network object in matlab 
    % to a string format that can be saved as a string in braph.
    % 
    % NN_STR = FROM_NET(NN, NET) transforms the build-in neural network
    %  object NET to a string format. Firstly, the NET is exported to an
    %  ONNX file and then the file is imported as a string format which 
    %  can be saved in braph.
    %  Typically, this method is called internally when a neural network
    %  model is trained and ready to be saved in braph.
    
    warning('off', 'MATLAB:mir_warning_unrecognized_pragma')

    directory = [fileparts(which('test_braph2')) filesep 'trial_nn_to_be_erased'];
    if ~exist(directory, 'dir')
        mkdir(directory)
    end
    filename = [directory filesep 'nn_from_matlab_to_be_erased.onnx'];

    exportONNXNetwork(net, filename);
    
    fileID = fopen(filename);
    nn_str = {fread(fileID), net.Layers(end).Classes};	    
    fclose(fileID);
    
    rmdir(directory, 's')
end
function net = to_net(nn)
%FIXME: update function name everywhere
    %TO_NET transforms the saved neural network 
    % in braph to a build-in object in matlab.
    %
    % NET = TO_NET(NN) transforms the saved neural network in braph
    %  to a build-in object in matlab. Firstly the saved neural network
    %  in braph is exported as an ONNX file, and then the file is 
    %  imported as a build-in neural network object in matlab.
    %  Typically, this method is called internally when a saved neural 
    %  network model is evaluated by a test data.

    warning('off', 'MATLAB:mir_warning_unrecognized_pragma')

    directory = [fileparts(which('test_braph2')) filesep 'trial_nn_to_be_erased'];
    if ~exist(directory, 'dir')
        mkdir(directory)
    end
    filename = [directory filesep 'nn_from_string_to_be_erased.onnx'];

    fileID = fopen(filename, 'w');
    trained_nn = nn.get('TRAINED_NN');
    fwrite(fileID, trained_nn{1});
    fclose(fileID);
    
    net = importONNXNetwork(filename, 'OutputLayerType', 'classification', 'Classes', trained_nn{2}, 'InputDataFormats', 'BCSS');
    
    rmdir(directory, 's')
end

%FIXME: test(s) to demonstrate how this works with various NN
%% ¡tests!

%%% ¡test!
%%%% ¡name!
neural network saving and transforming
%%%% ¡code!
nn = NNbase();
assert(nn.to_net(get('TRAINED_NN')), ...
    net, ...
    'Problems saving a neural network.')
