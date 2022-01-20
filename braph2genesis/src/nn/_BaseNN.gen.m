%% ¡header!
BaseNN < Element (nn, base neural network) is a base neural network.

%%% ¡description!
BaseNN provides the methods necessary for setting up neural networks.
Instances of this class should not be created. 
Use one of its subclasses instead.

%% ¡props!
%%% ¡prop!
ID (data, string) is a few-letter code for the neural network analysis.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the neural.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the neural network.

%%%% ¡prop!
DATA (data, item) ... %FIXME

%%% ¡prop!
TRAINED_NN (result, cell) is a trained neural network model.
%FIXME: check format of this prop - check that it works for all NN

% % % %%% ¡prop!
% % % NEURAL_NETWORK_ANALYSIS (result, cell) is the machine learning analysis.
% % % %%%% ¡gui!
% % % pl = PlotPropNNAnalysis('EL', nn, 'PROP', BaseNN.NEURAL_NETWORK_ANALYSIS, varargin{:});

%% ¡methods!
function installed = check_toolboxes(nn) %FIXME
    %CHECK_TOOLBOX_INSTALLATION checks whether the deep-learning-required toolboxes are installed.
    %
    % INSTALLED = CHECK_TOOLBOX_INSTALLATION(NN) check the installation of the toolboxes:
    %  "Deep Learning Toolbox" and 
    %  "Deep learning Toolbox Converter for ONNX Model Format" installation status. 
    %  If they are not installed, then it throws a warning.
    %  Typically, this method is only called internally when training
    %  the any subclass of the neural network models.
    
    addons = matlab.addons.installedAddons;
    installed = all(ismember(["Deep Learning Toolbox"; "Deep Learning Toolbox Converter for ONNX Model Format"], addons.Name));
    if ~installed
        warning('Some of the required deep-learning toolboxs are not installed. ' ...
            'Please, refer to ' ...
            '<a href="matlab: web(''https://se.mathworks.com/products/deep-learning.html'') ">Deep Learning Toolbox</a> ' ...
            'and ' ...
            '<a href="matlab: web(''https://se.mathworks.com/matlabcentral/fileexchange/67296-deep-learning-toolbox-converter-for-onnx-model-format'') ">Deep Learning Toolbox Converter for ONNX Model Format</a>')
    end
end
function nn_str = from_net(nn, net)
%FIXME: update function name everywhere
    %TRANSFORM_TO_BRAPH_FORMAT transforms the build-in neural network 
    % object in matlab to a binary format that can be saved as a cell
    % in braph.
    %
    % NN_BRAPH_FORMAT = TRANSFORM_TO_BRAPH_FORMAT(NN, NET) transforms the
    %  build-in neural network object to a binary format by firstly 
    %  converting it to ONNX file and then reading the file as binary file.
    %  Typically, this method is called internally when a neural network
    %  model is trained and ready to be saved in braph.

%FIXME: explain net in comment
    
    warning('off', 'MATLAB:mir_warning_unrecognized_pragma')
%FIXME: put file in test folder
    filename = 'nn_from_matlab_to_be_erased.onnx';
    exportONNXNetwork(net, filename);
    fileID = fopen(filename);
    nn_str = {fread(fileID), net.Layers(end).Classes};	    
    fclose(fileID);
    delete nn_from_matlab_to_be_erased.onnx
end
function net = to_net(nn)
%FIXME: update function name everywhere
    %transform_to_matlab_format transforms the saved neural network 
    % in braph to a build-in object in matlab.
    %
    % NN_MATLAB_FORMAT = TRANSFORM_TO_MATLAB_FORMAT(NN) transforms the
    %  saved neural network in braph to a build-in object in matlab by
    %  firstly saving the neural network in binary format as ONNX file
    %  then importing the file as ONNX object.
    %  Typically, this method is called internally when a saved neural 
    %  network model is evaluated by a test data.

%FIXME: explain net in comment

    warning('off', 'MATLAB:mir_warning_unrecognized_pragma')
%FIXME: put file in test folder
    filename = 'nn_from_matlab_to_be_erased.onnx';
    fileID = fopen(filename, 'w');
    trained_nn = nn.get('TRAINED_NN');
    fwrite(fileID, trained_nn{1});
    fclose(fileID);
    net = importONNXNetwork(filename, 'OutputLayerType', 'classification', 'Classes', trained_nn{2}, 'InputDataFormats', 'BCSS');
    delete nn_from_matlab_to_be_erased.onnx
end

%FIXME: test(s) to demonstrate how this works with various NN