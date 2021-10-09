%% ¡header!
GraphClassifierGNN_FUN < ClassifierGNN (gnn, graph classifier with functional data) is a graph neural network classifier using functional data for classification.

%% ¡description!
This classifier classifies graphs using functional data with graph neural network. The graph classification task is one where an algorithm, in this example, a GNN has to predict the labels of unlabelled graphs.
In this example, a graph is represented by a connectom of individual. Nodal graph measures represent nodes in the graph and the correlation betweeens brain regions obtained from functional time series represent links in the graph.
Graph labels are the diagnosis of individual, for example, MCI. As such, input to the GNN are connectom along with graph nodal measures and the outputs are predictions of the type of diagnosis.

%% ¡props!
%%% ¡prop!
GR1 (data, item) is the subject group 1, which also defines the subject class SubjectST.
%%%% ¡settings!
'Group'
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN')

%%% ¡prop!
GR2 (data, item) is the subject group 2, which also defines the subject class SubjectST.
%%%% ¡settings!
'Group'
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN')

%%% ¡prop!
FEATURES1 (data, CELL) is the cell consists of features matrix for each individual in group 1.

%%% ¡prop!
FEATURES2 (data, CELL) is the cell consists of features matrix for each individual in group 2.

%%% ¡prop!
LINKS1 (data, CELL) is the links for the nodes in group 1.

%%% ¡prop!
LINKS2 (data, CELL) is the links for the nodes in group 2.

%%% ¡prop!
FEATURES_TRAIN (result, matrix) is the training features separated from the whole dataset.
%%%% ¡calculate!
analysis = gnn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{2};

%%% ¡prop!
LINKS_TRAIN (result, matrix) is the training links separated from the whole dataset.
%%%% ¡calculate!
analysis = gnn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{3};

%%% ¡prop!
Y_TBLTRAIN (result, matrix) is the labels for the training dataset.
%%%% ¡calculate!
analysis = gnn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{4};

%%% ¡prop!
FEATURES_TEST (result, matrix) is the test features separated from the whole dataset.
%%%% ¡calculate!
analysis = gnn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{5};

%%% ¡prop!
LINKS_TEST (result, matrix)is the test links separated from the whole dataset.
%%%% ¡calculate!
analysis = gnn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{6};

%%% ¡prop!
Y_TBLTEST (result, matrix) is the labels for the test dataset.
%%%% ¡calculate!
analysis = gnn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{7};

%%% ¡prop!
TRAINED_NET (result, rvector) is the trained neural network.
%%%% ¡calculate!
analysis = gnn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{1};

%% ¡props_update!
%%% ¡prop!
TRAINING_ACCURACY (result, scalar) is the training accuracy obtained from training dataset.
%%%% ¡calculate!
analysis = gnn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{8};

%%% ¡prop!
TEST_ACCURACY (result, scalar) is the test accuracy obtained from test dataset.
%%%% ¡calculate!
analysis = gnn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{9};

%%% ¡prop!
NEURAL_NETWORK_ANALYSIS (result, cell) is the machine learning analysis.
%%%% ¡calculate!
value = calculate_results(gnn);

%% ¡methods!
function dlY = model(gnn, dlX, A, parameters)

    % Normalize adjacency matrix
    L = gnn.normalize_adjacency(A);

    n = 64;
    Z1 = dlX;

    Z2 = L * Z1 * parameters.W1;

    for i = 1:n-1
        Z1 = [Z1 dlX];
    end
    Z2 = relu(Z2) + Z1;

    Z3 = L * Z2 * parameters.W2;
    Z3 = relu(Z3) + Z2;

    Z4 = L * Z3 * parameters.W3;
    Z4 = dlarray(Z4,'ST');
    dlY = avgpool(Z4, 200, 'PoolFormat','S','Stride',200);
    dlY = reshape(dlY, [size(dlY,1), size(dlY,2)]);
    dlY = softmax(dlY, 'DataFormat', 'BC');
end

function adj = getBatchedAdjacency(gnn, links)
    adj = [];
    for i = 1:length(links)
        link = links{i};
        istart = 1+(i-1)*size(link,1);
        iend = (i)*size(link,1);
        adj(istart:iend,istart:iend) = link;
    end
end

function feature_vector = getBatchedFeatureVector(gnn, features)
    feature_vector = [];
    for i = 1:length(features)
        feature = features{i};
        feature_vector = [feature_vector; feature];
    end
end

function value = calculate_results(gnn)
    % import the data
    gr1 = gnn.get('GR1');
    labels = repmat(string(gr1.get('ID')), gr1.get('SUB_DICT').length(), 1);
    
    gr2 = gnn.get('GR2');
    labels = [labels; repmat(string(gr2.get('ID')), gr2.get('SUB_DICT').length(), 1)];
    
    labels = categorical(labels');
    
    features1 = gnn.get('FEATURES1');
    features2 = gnn.get('FEATURES2');
    features = [features1 features2];

    links1 = gnn.get('LINKS1');
    links2 = gnn.get('LINKS2');
    links = [links1 links2];
    
    % split the data into training set and test set (90:10)
    numObservations = size(labels, 2);
    numObservationsTrain = floor(0.8*numObservations);
    numObservationsTest = numObservations - numObservationsTrain;

    idx = randperm(numObservations);
    idxTrain = idx(1:numObservationsTrain);
    idxTest = idx(numObservationsTrain+1:end);

    featuresTrain = features(idxTrain);
    featuresTest = features(idxTest);
    labelTrain = labels(idxTrain);
    labelTest = labels(idxTest);
    linksTrain = links(idxTrain);
    linksTest = links(idxTest);
    
    features = cell(1,2);
    labels = cell(1,2);
    adjacency = cell(1,2);
    features{1} = gnn.getBatchedFeatureVector(featuresTrain);
    features{2} = gnn.getBatchedFeatureVector(featuresTest);
    labels{1} = labelTrain';
    labels{2} = labelTest';
    adjacency{1} = gnn.getBatchedAdjacency(linksTrain);
    adjacency{2} = gnn.getBatchedAdjacency(linksTest);
    
    features = gnn.normalize_features(features);
    
    if(~isempty(features))
        featureTrain = features{1};
        adjacencyTrain = adjacency{1};
        targetTrain = labels{1};

        featureValidation = features{2};
        adjacencyValidation = adjacency{2};
        targetValidation = labels{2};

        labelsAll = cat(1,labels{:});
        classes = categories(labelsAll)

        %figure
        %histogram(labelsAll)
        xlabel('Category')
        ylabel('Frequency')
        title('Label Counts')

        numInputFeatures = size(featureTrain,2)
        numHiddenFeatureMaps = 64*numInputFeatures;
        numOutputFeatures = numel(classes)
        sz = [numInputFeatures numHiddenFeatureMaps];
        numOut = numHiddenFeatureMaps;
        numIn = numInputFeatures;
        parameters.W1 = gnn.initialize_glorot(sz,numOut,numIn,'double');

        sz = [numHiddenFeatureMaps numHiddenFeatureMaps];
        numOut = numHiddenFeatureMaps;
        numIn = numHiddenFeatureMaps;
        parameters.W2 = gnn.initialize_glorot(sz,numOut,numIn,'double');

        sz = [numHiddenFeatureMaps numOutputFeatures];
        numOut = numOutputFeatures;
        numIn = numHiddenFeatureMaps;
        parameters.W3 = gnn.initialize_glorot(sz,numOut,numIn,'double');
        parameters
        numEpochs = 250;
        learnRate = 0.01;
        validationFrequency = 25;
        plots = "training-progress";
        executionEnvironment = "auto";
        if plots == "training-progress"
            figure

            % Accuracy.
            subplot(2,1,1)
            lineAccuracyTrain = animatedline('Color',[0 0.447 0.741]);
            lineAccuracyValidation = animatedline( ...
                'LineStyle','--', ...
                'Marker','o', ...
                'MarkerFaceColor','black');
            ylim([0 1])
            xlabel("Epoch")
            ylabel("Accuracy")
            grid on

            % Loss.
            subplot(2,1,2)
            lineLossTrain = animatedline('Color',[0.85 0.325 0.098]);
            lineLossValidation = animatedline( ...
                'LineStyle','--', ...
                'Marker','o', ...
                'MarkerFaceColor','black');
            ylim([0 inf])
            xlabel("Epoch")
            ylabel("Loss")
            grid on
        end
        trailingAvg = [];
        trailingAvgSq = [];
        dlX = dlarray(featureTrain);
        dlXValidation = dlarray(featureValidation);
        if (executionEnvironment == "auto" && canUseGPU) || executionEnvironment == "gpu"
            dlX = gpuArray(dlX);
        end
        T = onehotencode(targetTrain, 2, 'ClassNames', classes);
        TValidation = onehotencode(targetValidation, 2, 'ClassNames', classes);
        start = tic;
        % Loop over epochs.
        for epoch = 1:numEpochs

            % Evaluate the model gradients and loss using dlfeval and the
            % modelGradients function.
            [gradients, loss, dlYPred] = dlfeval(@gnn.model_gradients, dlX, adjacencyTrain, T, parameters);

            % Update the network parameters using the Adam optimizer.
            [parameters,trailingAvg,trailingAvgSq] = adamupdate(parameters,gradients, ...
                trailingAvg,trailingAvgSq,epoch,learnRate);

            % Display the training progress.
            if plots == "training-progress"
                subplot(2,1,1)
                D = duration(0,0,toc(start),'Format','hh:mm:ss');
                title("Epoch: " + epoch + ", Elapsed: " + string(D))

                % Loss.
                addpoints(lineLossTrain,epoch,double(gather(extractdata(loss))))

                % Accuracy score.
                score = gnn.accuracy(dlYPred, targetTrain, classes);
                addpoints(lineAccuracyTrain,epoch,double(gather(score)))

                drawnow

                % Display validation metrics.
                if epoch == 1 || mod(epoch,validationFrequency) == 0
                    % Loss.
                    dlYPredValidation = gnn.model(dlXValidation, adjacencyValidation, parameters);
                    lossValidation = crossentropy(dlYPredValidation, TValidation, 'DataFormat', 'BC');
                    addpoints(lineLossValidation,epoch,double(gather(extractdata(lossValidation))))

                    % Accuracy score.
                    scoreValidation = gnn.accuracy(dlYPredValidation, targetValidation, classes);
                    addpoints(lineAccuracyValidation,epoch,double(gather(scoreValidation)))

                    drawnow
                end
            end
        end
        
        % get training accuracy
        featureTrain = features{1};
        adjacencyTrain = adjacency{1};
        targetTrain = labels{1};
        dlXTest = dlarray(featureTrain);
        dlYPredTrain = gnn.model(dlXTest, adjacencyTrain, parameters);
        [scoreTrain, predTrain] = gnn.accuracy(dlYPredTrain, targetTrain, classes);
        training_accuracy = sum(targetTrain==predTrain)/length(predTrain);
        
        % get test accuracy
        featureTest = features{2};
        adjacencyTest = adjacency{2};
        targetTest = labels{2};
        dlXTest = dlarray(featureTest);
        dlYPredTest = gnn.model(dlXTest, adjacencyTest, parameters);
        [scoreTest, predTest] = gnn.accuracy(dlYPredTest, targetTest, classes);
        scoreTest
        numOfSamples = numel(targetTest);
        classTarget = zeros(numOfSamples, numOutputFeatures);
        classPred = zeros(numOfSamples, numOutputFeatures);
        for i = 1:numOutputFeatures
            classTarget(:,i) = targetTest==categorical(classes(i));
            classPred(:,i) = predTest==categorical(classes(i));
        end

        % Compute class-wise accuracy score
        classAccuracy = sum(classPred == classTarget)./numOfSamples;

        % Visualize class-wise accuracy score
        [confusionMatrix, order] = confusionmat(targetTest, predTest);
        figure
        cm = confusionchart(confusionMatrix, classes, ...
            'ColumnSummary','column-normalized', ...
            'RowSummary','row-normalized', ...
            'Title', 'Confusion Chart');
        
        test_accuracy = sum(targetTest==predTest)/length(predTest);
        % get string format of nn
        %neural_network = gnn.net_binary_transformer(net);
    else
        parameters = [];
        featureTrain = [];
        adjacencyTrain = [];
        targetTrain = [];
        featureTest = [];
        adjacencyTest = [];
        targetTest = [];
        training_accuracy = 0;
        test_accuracy = 0;
    end
    % return all the values
    value = {parameters, featureTrain, adjacencyTrain, targetTrain, featureTest, adjacencyTest, targetTest, training_accuracy, test_accuracy};
end

%% ¡tests!
%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_gnn_graph_classification_FUN_BUD