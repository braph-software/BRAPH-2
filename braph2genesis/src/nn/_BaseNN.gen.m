%% ¡header!
BaseNN < Element (nn, base neural network) is a base neural network.

%%% ¡description!
BaseNN provides the methods necessary for setting up neural networks.
Instances of this class should not be created. 
Use one of its subclasses instead.


%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the classification.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the classification.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the classification.

%%% ¡prop!
NEURAL_NETWORK_ANALYSIS (result, cell) is the neural network trained from this analysis.

%% ¡methods!
function nn_binary_format = net_binary_transformer(nn, net)
    filename = 'nn.bin';
    exportONNXNetwork(net,filename);
    fileID = fopen(filename);
    nn_binary_format = fread(fileID);
    fclose(fileID);
    delete nn.bin
end


