%% ¡header!
ETG < Element (et, test Element G) tests use of exporting and importing the JSON format of neural network.

%%% ¡description!
ETF1 tests use of exporting and importing the JSON format of neural network.

%%% ¡seealso!
Element, Category, Format

%% ¡props!

%%% ¡prop!
MODEL_SERIES (data, net) is a net.

%%% ¡prop!
MODEL_DAG (data, net) is a net.

%%% ¡prop!
MODEL_DL (data, net) is a net.

%%% ¡prop!
MODEL_NETWORK (data, net) is a net.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Test classification model for JSON encoding and decoding
%%%% ¡probability!
.1
%%%% ¡code!
if BRAPH2.installed('NN', 'warning') && BRAPH2.insatlled('ONNXCONVERTER', 'warning')
    % create neural network objects
    size_x = 28;
    size_y = 28;
    num_channel = 1;
    num_neuron = 100;
    num_class = 10;
    layers = [
        imageInputLayer([size_x size_y num_channel], 'Name', 'input', 'Mean', rand(size_x, size_y, num_channel))
        fullyConnectedLayer(num_neuron, 'Name', 'fc1', 'Weights', rand(num_neuron, size_x * size_y), 'Bias', rand(num_neuron, 1))
        fullyConnectedLayer(num_class, 'Name', 'fc2', 'Weights', rand(num_class, num_neuron), 'Bias', rand(num_class, 1))
        softmaxLayer('Name', 'softmax')
        classificationLayer('Classes', categorical(1:num_class), 'Name', 'classOutput')
        ];
    net_series = SeriesNetwork(layers);
    lgraph = layerGraph(layers);
    net_dag = assembleNetwork(lgraph);
    lgraph = removeLayers(lgraph, 'classOutput');
    net_dl = dlnetwork(lgraph);

    etg = ETG( ...
        'MODEL_SERIES', net_series, ...
        'MODEL_DAG', net_dag, ...
        'MODEL_DL', net_dl, ...
        'MODEL_NETWORK', network() ...
        );

    [json, struct, el_list] = encodeJSON(etg);
    [etg_dec, struct_dec, el_list_dec] = Element.decodeJSON(json);
end
%%% ¡test!
%%%% ¡name!
Test regression model for JSON encoding and decoding
%%%% ¡probability!
.1
%%%% ¡code!
if BRAPH2.installed('NN', 'warning') && BRAPH2.insatlled('ONNXCONVERTER', 'warning')
    % create neural network objects
    size_x = 28;
    size_y = 28;
    num_channel = 1;
    num_neuron = 100;
    num_class = 10;
    layers = [
        imageInputLayer([size_x size_y num_channel], 'Name', 'input', 'Mean', rand(size_x, size_y, num_channel))
        fullyConnectedLayer(num_neuron, 'Name', 'fc1', 'Weights', rand(num_neuron, size_x * size_y), 'Bias', rand(num_neuron, 1))
        fullyConnectedLayer(num_class, 'Name', 'fc2', 'Weights', rand(num_class, num_neuron), 'Bias', rand(num_class, 1))
        softmaxLayer('Name', 'softmax')
        regressionLayer('Name', 'regressOutput')
        ];
    net_series = SeriesNetwork(layers);
    lgraph = layerGraph(layers);
    net_dag = assembleNetwork(lgraph);
    lgraph = removeLayers(lgraph, 'regressOutput');
    net_dl = dlnetwork(lgraph);

    etg = ETG( ...
        'MODEL_SERIES', net_series, ...
        'MODEL_DAG', net_dag, ...
        'MODEL_DL', net_dl, ...
        'MODEL_NETWORK', network() ...
        );

    [json, struct, el_list] = encodeJSON(etg);
    [etg_dec, struct_dec, el_list_dec] = Element.decodeJSON(json);
end