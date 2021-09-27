%% ¡header!
ClassifierNN_ST < ClassifierNN (nn, classification with structural data) is a neural network classifier using structural data for classifying groups.

%% ¡description!
This classifier uses structural data and trains neural network for classification of groups.

%% ¡props!
%%% ¡prop!
GR1 (data, item) is the subject group 1, which also defines the subject class SubjectST.
%%%% ¡settings!
'Group'
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST')

%%% ¡prop!
GR2 (data, item) is the subject group 2, which also defines the subject class SubjectST.
%%%% ¡settings!
'Group'
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST')

%%% ¡prop!
X_TBLTRAIN (result, matrix) is the training dataset separated from the whole dataset.
%%%% ¡calculate!
analysis = nn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{2};

%%% ¡prop!
Y_TBLTRAIN (result, matrix) is the labels for the training dataset.
%%%% ¡calculate!
analysis = nn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{3};

%%% ¡prop!
X_TBLTEST (result, matrix) is the test dataset separated from the whole dataset.
%%%% ¡calculate!
analysis = nn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{4};

%%% ¡prop!
Y_TBLTEST (result, matrix) is the labels for the test dataset.
%%%% ¡calculate!
analysis = nn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{5};

%%% ¡prop!
CLASSES (result, cell) is the contained classes of the labels.
%%%% ¡calculate!
analysis = nn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis(6);

%%% ¡prop!
TRAINED_NET (result, rvector) is the trained neural network.
%%%% ¡calculate!
analysis = nn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{1};

%% ¡props_update!
%%% ¡prop!
TRAINING_ACCURACY (result, scalar) is the accuracy obtained from training dataset.
%%%% ¡calculate!
analysis = nn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{7};

%%% ¡prop!
TEST_ACCURACY (result, scalar) is the accuracy obtained from test dataset.
%%%% ¡calculate!
analysis = nn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{8};

%%% ¡prop!
NEURAL_NETWORK_ANALYSIS (result, cell) is the machine learning analysis.
%%%% ¡calculate!
value = calculate_results(nn);

%% ¡methods!
function value = calculate_results(nn)
    % import the data
    gr1 = nn.get('GR1');
    data_list = cellfun(@(x) x.get('ST'), gr1.get('SUB_DICT').getItems, 'UniformOutput', false);
    data = cat(2, data_list{:})'; 
    label = repmat(string(gr1.get('ID')), gr1.get('SUB_DICT').length(), 1);

    gr2 = nn.get('GR2');
    data_list = cellfun(@(x) x.get('ST'), gr1.get('SUB_DICT').getItems, 'UniformOutput', false);
    data = [data; cat(2, data_list{:})'];
    label = [label; repmat(string(gr2.get('ID')), gr2.get('SUB_DICT').length(), 1)];

    dataset = array2table(data);
    if(~isempty(dataset))
        label = array2table(label, 'VariableNames', {'DX'})
        dataset = [dataset label];
        dataset = convertvars(dataset,'DX', 'categorical');

        % show classes name
        class_names = categories(dataset{:,end})

        % split the data into training set and test set (85:15)
        numObservations = size(dataset,1);
        numObservationsTrain = floor(0.85*numObservations);
        numObservationsTest = numObservations - numObservationsTrain;

        idx = randperm(numObservations);
        idxTrain = idx(1:numObservationsTrain);
        idxTest = idx(numObservationsTrain+1:end);

        tblTrain = dataset(idxTrain, :);
        tblTest = dataset(idxTest, :);

        y_tblTrain = tblTrain{:, end};
        X_tblTrain = tblTrain{:, 1:end-1};
        X_tblTrain = reshape(X_tblTrain', [1, 1, size(X_tblTrain,2), size(X_tblTrain,1)]);
        y_tblTest = tblTest{:, end};
        X_tblTest = tblTest{:, 1:end-1};
        X_tblTest = reshape(X_tblTest', [1, 1, size(X_tblTest,2), size(X_tblTest,1)]);

        % specify the parameters and layers
        numFeatures = size(dataset,2) - 1;
        numClasses = numel(class_names);

        % get layers
        layers = nn.getLayers(numFeatures, numClasses)
        lgraph = layerGraph(layers);
        plot(lgraph)
        miniBatchSize = 16;

        options = trainingOptions('adam', ...
            'MiniBatchSize',miniBatchSize, ...
            'Shuffle','every-epoch', ...
            'Plots','training-progress', ...
            'Verbose',false);

        % fit the model
        net = trainNetwork(X_tblTrain, y_tblTrain, layers, options);

        % get prediction accuracy on training set
        YPred = classify(net, X_tblTrain);
        YTest = y_tblTrain;
        training_accuracy = sum(YPred == YTest)/numel(YTest)

        % get prediction accuracy on test set
        YPred = classify(net, X_tblTest);
        YTest = y_tblTest;
        test_accuracy = sum(YPred == YTest)/numel(YTest)

        % get string format of nn
        neural_network = nn.net_binary_transformer(net);
    else
        neural_network = [];
        X_tblTrain = [];
        y_tblTrain = [];
        X_tblTest = [];
        y_tblTest = [];
        class_names = [];
        training_accuracy = 0;
        test_accuracy = 0;
    end
    
    % return all the values
    value = {neural_network, X_tblTrain, y_tblTrain, X_tblTest, y_tblTest, class_names, training_accuracy, test_accuracy};
end

%% ¡tests!
%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_nn_classification_ST