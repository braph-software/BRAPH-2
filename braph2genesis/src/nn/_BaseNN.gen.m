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

%%% ¡prop!
TRAINED_NN (result, cell) is the trained neural network model.

% % % %%% ¡prop!
% % % NEURAL_NETWORK_ANALYSIS (result, cell) is the machine learning analysis.
% % % %%%% ¡gui!
% % % pl = PlotPropNNAnalysis('EL', nn, 'PROP', BaseNN.NEURAL_NETWORK_ANALYSIS, varargin{:});

%% ¡methods!
function installed = check_toolbox_installation(nn)
    %check_toolbox_installation checks if the deep-learning-required toolboxes are installed.
    %
    % INSTALLED = CHECK_TOOLBOX_INSTALLATION(NN) check the toolbox 
    %  "Deep Learning Toolbox" and "Deep learning Toolbox Converter 
    %  for ONNX Model Format" installation status. If they are not
    %  installed, then it will throw a warning.
    %  Typically, this method is only called internally when training
    %  the any subclass of the neural network models.
    addons = matlab.addons.installedAddons;
    installed = all(ismember(["Deep Learning Toolbox"; "Deep Learning Toolbox Converter for ONNX Model Format"], addons.Name));
    if ~installed
        warning('Deep Learning Toolboxs are not installed. Please refer to <a href="matlab: web(''https://se.mathworks.com/products/deep-learning.html'') ">Deep Learning Toolbox</a> and <a href="matlab: web(''https://se.mathworks.com/matlabcentral/fileexchange/67296-deep-learning-toolbox-converter-for-onnx-model-format'') ">Deep Learning Toolbox Converter for ONNX Model Format</a>');
    end
end

function nn_braph_format = transform_to_braph_format(nn)
    %transform_to_braph_format transforms the build-in neural network 
    % object in matlab to a binary format that can be saved as a cell
    % in braph.
    %
    % NN_BRAPH_FORMAT = TRANSFORM_TO_BRAPH_FORMAT(NN) transforms the
    %  build-in neural network object to a binary format by firstly 
    %  converting it to ONNX file and then reading the file as binary file.
    %  Typically, this method is called internally when a neural network
    %  model is trained and ready to be saved in braph.
    filename = 'nn.bin';
    exportONNXNetwork(nn.get('TRAINED_NN'), filename);
    fileID = fopen(filename);
    nn_braph_format = fread(fileID);
    fclose(fileID);
    delete nn.bin
end

function nn_matlab_format = transform_to_matlab_format(nn)
    %transform_to_matlab_format transforms the saved neural network 
    % in braph to a build-in object in matlab.
    %
    % NN_MATLAB_FORMAT = TRANSFORM_TO_MATLAB_FORMAT(NN) transforms the
    %  saved neural network in braph to a build-in object in matlab by
    %  firstly saving the neural network in binary format as ONNX file
    %  then importing the file as ONNX object.
    %  Typically, this method is called internally when a saved neural 
    %  network model is evaluated by a test data.
    filename = 'nn.onnx';
    fileID = fopen(filename, 'w');
    fwrite(fileID, cell2mat(nn.get('TRAINED_NN')));
    fclose(fileID);
    nn_matlab_format = importONNXNetwork(filename, 'OutputLayerType', 'classification', 'Classes', string(nn.class_name));
    delete nn.onnx
end