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
.01
%%%% ¡code!
if BRAPH2.installed('NN', 'warning') && BRAPH2.installed('ONNXCONVERTER', 'warning')
    % switch off the nnet warning
    w = warning('query', 'MATLAB:mir_warning_unrecognized_pragma');
    warning('off', w.identifier);

    % create neural network objects
    size_x = 28;
    size_y = 28;
    num_channel = 1;
    num_neuron = 100;
    num_class = 10;
    layers = [
        imageInputLayer([size_x size_y num_channel], 'Name', 'input', 'Mean', rand(size_x, size_y, num_channel, 'single'))
        fullyConnectedLayer(num_neuron, 'Name', 'fc1', 'Weights', rand(num_neuron, size_x * size_y, 'single'), 'Bias', rand(num_neuron, 1, 'single'))
        fullyConnectedLayer(num_class, 'Name', 'fc2', 'Weights', rand(num_class, num_neuron, 'single'), 'Bias', rand(num_class, 1, 'single'))
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

    % test the NN prediction
    img = rand(net_series.Layers(1).InputSize);
    
    pred = predict(etg.get('MODEL_SERIES'), img);
    pred_dec = predict(etg_dec.get('MODEL_SERIES'), img);

    assert(max(abs(pred - pred_dec)) < 1E-04, ...
        [BRAPH2.STR ':ETG:' BRAPH2.BUG_ERR], ...
        'Prediction is not being calculated correctly with the model from JSON.')

    pred = predict(etg.get('MODEL_DAG'), img);
    pred_dec = predict(etg_dec.get('MODEL_DAG'), img);

    assert(max(abs(pred - pred_dec)) < 1E-04, ...
        [BRAPH2.STR ':ETG:' BRAPH2.BUG_ERR], ...
        'Prediction is not being calculated correctly with the model from JSON.')

    % resume nnet warning status 
    warning(w.state, w.identifier);
end

%%% ¡test!
%%%% ¡name!
Test regression model for JSON encoding and decoding
%%%% ¡probability!
.01
%%%% ¡code!
if BRAPH2.installed('NN', 'warning') && BRAPH2.installed('ONNXCONVERTER', 'warning')
    % switch off the nnet warning
    w = warning('query', 'MATLAB:mir_warning_unrecognized_pragma');
    warning('off', w.identifier);

    % create neural network objects
    size_x = 28;
    size_y = 28;
    num_channel = 1;
    num_neuron = 100;
    num_class = 1;
    layers = [
        imageInputLayer([size_x size_y num_channel], 'Name', 'input', 'Mean', rand(size_x, size_y, num_channel))
        fullyConnectedLayer(num_neuron, 'Name', 'fc1', 'Weights', rand(num_neuron, size_x * size_y), 'Bias', rand(num_neuron, 1))
        fullyConnectedLayer(num_class, 'Name', 'fc2', 'Weights', rand(num_class, num_neuron), 'Bias', rand(num_class, 1))
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

    % test the NN prediction
    img = rand(net_series.Layers(1).InputSize);

    pred = predict(etg.get('MODEL_SERIES'), img);
    pred_dec = predict(etg_dec.get('MODEL_SERIES'), img);

    assert(max(abs(pred - pred_dec)) < 1E-04, ...
        [BRAPH2.STR ':ETG:' BRAPH2.BUG_ERR], ...
        'Prediction is not being calculated correctly with the model from JSON.')

    pred = predict(etg.get('MODEL_DAG'), img);
    pred_dec = predict(etg_dec.get('MODEL_DAG'), img);

    assert(max(abs(pred - pred_dec)) < 1E-04, ...
        [BRAPH2.STR ':ETG:' BRAPH2.BUG_ERR], ...
        'Prediction is not being calculated correctly with the model from JSON.')

    % resume nnet warning status 
    warning(w.state, w.identifier);
end

%%% ¡test!
%%%% ¡name!
Test regression model for saving/loading b2 file
%%%% ¡probability!
.01
%%%% ¡code!
if BRAPH2.installed('NN', 'warning') && BRAPH2.installed('ONNXCONVERTER', 'warning')
    % switch off the nnet warning
    w = warning('query', 'MATLAB:mir_warning_unrecognized_pragma');
    warning('off', w.identifier);

    % create neural network objects
    size_x = 28;
    size_y = 28;
    num_channel = 1;
    num_neuron = 100;
    num_class = 1;
    layers = [
        imageInputLayer([size_x size_y num_channel], 'Name', 'input', 'Mean', rand(size_x, size_y, num_channel))
        fullyConnectedLayer(num_neuron, 'Name', 'fc1', 'Weights', rand(num_neuron, size_x * size_y), 'Bias', rand(num_neuron, 1))
        fullyConnectedLayer(num_class, 'Name', 'fc2', 'Weights', rand(num_class, num_neuron), 'Bias', rand(num_class, 1))
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

    directory = [fileparts(which('test_braph2')) filesep 'trial_net_element_to_be_erased'];
    if ~exist(directory, 'dir')
        mkdir(directory)
    end
    filename = [directory filesep 'nn_b2_out.b2'];
    
    saved_out = BRAPH2.save(etg, filename);
    assert(saved_out, ...
        [BRAPH2.STR ':ETG:' BRAPH2.BUG_ERR], ...
        'ETG is not saved successfully as b2 file.')

    [etg_dec, build, matlab_release, matlab_release_details] = BRAPH2.load(filename);
    
    rmdir(directory, 's');

    % test the NN prediction
    img = rand(net_series.Layers(1).InputSize);

    pred = predict(etg.get('MODEL_SERIES'), img);
    pred_dec = predict(etg_dec.get('MODEL_SERIES'), img);

    assert(max(abs(pred - pred_dec)) < 1E-04, ...
        [BRAPH2.STR ':ETG:' BRAPH2.BUG_ERR], ...
        'Prediction is not being calculated correctly with the model from b2 file.')

    pred = predict(etg.get('MODEL_DAG'), img);
    pred_dec = predict(etg_dec.get('MODEL_DAG'), img);

    assert(max(abs(pred - pred_dec)) < 1E-04, ...
        [BRAPH2.STR ':ETG:' BRAPH2.BUG_ERR], ...
        'Prediction is not being calculated correctly with the model from b2 file.')

    % resume nnet warning status 
    warning(w.state, w.identifier);
end