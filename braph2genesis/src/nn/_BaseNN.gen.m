%% ¡header!
BaseNN < Element (nn, base neural network) is a base neural network.

%%% ¡description!
BaseNN provides the methods necessary for setting up neural networks.
Instances of this class should not be created. 
Use one of its subclasses instead.

%% ¡props!
%%% ¡prop!
ID (data, string) is a few-letter code for the machien learning analysis.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the machien learning analysis.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about  the machien learning analysis.

%%% ¡prop!
NEURAL_NETWORK_ANALYSIS (result, cell) is the machine learning analysis.

%% ¡methods!
function installed = check_toolbox_installation(nn)
    addons = matlab.addons.installedAddons;
    installed = all(ismember(["Deep Learning Toolbox"; "Deep Learning Toolbox Converter for ONNX Model Format"], addons.Name));
    if ~installed
        warning('Deep Learning Toolboxs are not both installed. Please refer to <a href="matlab: web(''https://se.mathworks.com/products/deep-learning.html'') ">Deep Learning Toolbox</a> and <a href="matlab: web(''https://se.mathworks.com/matlabcentral/fileexchange/67296-deep-learning-toolbox-converter-for-onnx-model-format'') ">Deep Learning Toolbox Converter for ONNX Model Format</a>');
    end
end

function nn_binary_format = net_binary_transformer(nn, net)
    filename = 'nn.bin';
    exportONNXNetwork(net,filename);
    fileID = fopen(filename);
    nn_binary_format = fread(fileID);
    fclose(fileID);
    delete nn.bin
end