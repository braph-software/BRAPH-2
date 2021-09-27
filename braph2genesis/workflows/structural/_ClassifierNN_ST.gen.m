%% ¡header!
ClassifierNN_ST < ClassifierNN (nn, classification with structural data) is a classifier using neural network with structural data.

%% ¡description!
This classifier uses structural data and trains neural network for classification.

%% ¡props!

%%% ¡prop!
FILE (data, string) is the XLS/XLSX file from where to load the ST subject group.
%%%% ¡default!
''

%%% ¡prop!
X_TBLTRAIN (result, matrix) is the neural network trained from this analysis.
%%%% ¡calculate!
analysis = nn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{2};

%%% ¡prop!
Y_TBLTRAIN (result, matrix) is the neural network trained from this analysis.
%%%% ¡calculate!
analysis = nn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{3};

%%% ¡prop!
X_TBLTEST (result, matrix) is the neural network trained from this analysis.
%%%% ¡calculate!
analysis = nn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{4};

%%% ¡prop!
Y_TBLTEST (result, matrix) is the neural network trained from this analysis.
%%%% ¡calculate!
analysis = nn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{5};

%%% ¡prop!
CLASSES (result, cell) is the neural network trained from this analysis.
%%%% ¡calculate!
analysis = nn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis(6);

%%% ¡prop!
TRAINED_NET (result, rvector) is the neural network trained from this analysis.
%%%% ¡calculate!
analysis = nn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{1};

%% ¡props_update!
%%% ¡prop!
TRAINING_ACCURACY (result, scalar) is the neural network trained from this analysis.
%%%% ¡calculate!
analysis = nn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{7};

%%% ¡prop!
TEST_ACCURACY (result, scalar) is the neural network trained from this analysis.
%%%% ¡calculate!
analysis = nn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{8};

%%% ¡prop!
NEURAL_NETWORK_ANALYSIS (result, cell) is the neural network trained from this analysis.
%%%% ¡calculate!
value = calculate_results(nn);

%% ¡methods!
function value = calculate_results(nn)
    % import the data
    %filename = "mr_adni.csv";
    filename = nn.get('FILE');
    if(~isempty(filename))
        tbl = readtable(filename,'TextType','String');

    
        % covert the label into categorical in order for prediction
        labelName = "DX";
        tbl = convertvars(tbl,labelName,'categorical');

        % show table
        tbl = splitvars(tbl);
        head(tbl)

        % show classes name
        class_names = categories(tbl{:,labelName})

        % split the data into training set and test set (85:15)
        numObservations = size(tbl,1);
        numObservationsTrain = floor(0.85*numObservations);
        numObservationsTest = numObservations - numObservationsTrain;

        idx = randperm(numObservations);
        idxTrain = idx(1:numObservationsTrain);
        idxTest = idx(numObservationsTrain+1:end);

        tblTrain = tbl(idxTrain,:);
        tblTest = tbl(idxTest,:);
        
        % specify the parameters and layers
        numFeatures = size(tbl,2) - 1;
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
        net = trainNetwork(tblTrain,layers,options);

        % get prediction accuracy on training set
        YPred = classify(net,tblTrain,'MiniBatchSize',miniBatchSize);
        YTrain = tblTrain{:,labelName};

        training_accuracy = sum(YPred == YTrain)/numel(YTrain)
        
        % get prediction accuracy on test set
        YPred = classify(net,tblTest,'MiniBatchSize',miniBatchSize);
        YTest = tblTest{:,labelName};

        test_accuracy = sum(YPred == YTest)/numel(YTest)
        
        % get string format of nn
        neural_network = nn.net_binary_transformer(net);
        
        tblTrain = tblTrain{:,1:end-1}
		tblTest = tblTest{:,1:end-1}
    else
        neural_network = [];
        tblTrain = [];
        YTrain = [];
        tblTest = [];
        YTest = [];
        class_names = [];
        training_accuracy = 0;
        test_accuracy = 0;
    end
    % return all the values
    value = {neural_network, tblTrain, YTrain, tblTest, YTest, class_names, training_accuracy, test_accuracy};
end

function m = getTrainingConfusionMatrix(nn)
    net = net_obj_transformer(nn.get('trained_net'));
    YPred = classify(net, nn.get('trained_net'));
	YTest = nn.y_tblTrain;
    % plot result
    [m,order] = confusionmat(YTest,YPred)
    figure
    confusionchart(YTest,YPred, ...
        'Title','Classification', ...
        'RowSummary','row-normalized', ...
        'ColumnSummary','column-normalized');
end

function m = getTestConfusionMatrix(nn)
    net = net_obj_transformer(nn.get('NEURAL_NETWORK'));
    YPred = classify(net, nn.X_tblTest);
	YTest = nn.y_tblTest;
    % plot result
    [m,order] = confusionmat(YTest,YPred)
    figure
    confusionchart(YTest,YPred, ...
        'Title','Classification', ...
        'RowSummary','row-normalized', ...
        'ColumnSummary','column-normalized');
end

function nn_obj_format = net_obj_transformer(nn)
    filename = 'nn.onnx';
    fileID = fopen(filename,'w');
    fwrite(fileID, cell2mat(nn.get('NEURAL_NETWORK')));
    fclose(fileID);
    nn_obj_format = importONNXNetwork(filename,'OutputLayerType','classification','Classes',string(nn.class_name));
    delete nn.onnx
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_nn_classification_ST