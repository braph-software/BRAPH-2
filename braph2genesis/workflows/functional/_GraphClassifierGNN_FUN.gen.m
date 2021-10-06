%% ¡header!
GraphClassifierGNN_FUN < ClassifierGNN (gnn, graph classifier with functional data) is a graph neural network classifier using functional data for classification.

%% ¡description!
This classifier uses functional data and trains graph neural network for classification

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
analysis = gnn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{2};

%%% ¡prop!
Y_TBLTRAIN (result, matrix) is the labels for the training dataset.
%%%% ¡calculate!
analysis = gnn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{3};

%%% ¡prop!
X_TBLTEST (result, matrix) is the test dataset separated from the whole dataset.
%%%% ¡calculate!
analysis = gnn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{4};

%%% ¡prop!
Y_TBLTEST (result, matrix) is the labels for the test dataset.
%%%% ¡calculate!
analysis = gnn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{5};

%%% ¡prop!
TRAINED_NET (result, rvector) is the trained neural network.
%%%% ¡calculate!
analysis = gnn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{1};

%% ¡props_update!
%%% ¡prop!
TRAINING_ACCURACY (result, scalar) is the root mean square error obtained from training dataset.
%%%% ¡calculate!
analysis = gnn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{6};

%%% ¡prop!
TEST_ACCURACY (result, scalar) is the root mean square error obtained from test dataset.
%%%% ¡calculate!
analysis = gnn.get('NEURAL_NETWORK_ANALYSIS');
value = analysis{7};

%%% ¡prop!
NEURAL_NETWORK_ANALYSIS (result, cell) is the machine learning analysis.
%%%% ¡calculate!
value = calculate_results(gnn);

%% ¡methods!
function dlY = model(dlX, A, parameters)

    % Normalize adjacency matrix
    L = normalizeAdjacency(A);

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
    dlY = avgpool(Z4, 90, 'PoolFormat','S','Stride',90);
    dlY = reshape(dlY, [size(dlY,1), size(dlY,2)]);
    dlY = softmax(dlY, 'DataFormat', 'BC');
end

function value = calculate_results(gnn)
    % import the data
    gr1 = gnn.get('GR1');
    data_list = cellfun(@(x) x.get('ST'), gr1.get('SUB_DICT').getItems, 'UniformOutput', false);
    data = cat(2, data_list{:})'; 
    age_list = cellfun(@(x) x.get('age'), gr1.get('SUB_DICT').getItems, 'UniformOutput', false);
    label = cat(2, age_list{:})';

    gr2 = gnn.get('GR2');
    data_list = cellfun(@(x) x.get('ST'), gr1.get('SUB_DICT').getItems, 'UniformOutput', false);
    data = [data; cat(2, data_list{:})'];
    age_list = cellfun(@(x) x.get('age'), gr2.get('SUB_DICT').getItems, 'UniformOutput', false);
    label = [label; cat(2, age_list{:})'];

    dataset = array2table(data);
    
    features = cell(1,2);
    labels = cell(1,2);
    adjacency = cell(1,2);
    %features{1} = getBatchedFeatureVector(subjTrain);
    %features{2} = getBatchedFeatureVector(subjTest);
    %labels{1} = labelTrain';
    %labels{2} = labelTest';
    %adjacency{1} = getBatchedAdjacency(subjTrain);
    %adjacency{2} = getBatchedAdjacency(subjTest);
    features = gnn.normalize_features(features);
    
    
    if(~isempty(features{1}))
        featureTrain = features{1};
        adjacencyTrain = adjacency{1};
        targetTrain = labels{1};

        featureValidation = features{2};
        adjacencyValidation = adjacency{2};
        targetValidation = labels{2};

        labelsAll = cat(1,labels{:});
        classes = categories(labelsAll)

        figure
        histogram(labelsAll)
        xlabel('Category')
        ylabel('Frequency')
        title('Label Counts')

        numInputFeatures = size(featureTrain,2)
        numHiddenFeatureMaps = 64*numInputFeatures;
        numOutputFeatures = numel(classes)
        sz = [numInputFeatures numHiddenFeatureMaps];
        numOut = numHiddenFeatureMaps;
        numIn = numInputFeatures;
        parameters.W1 = initializeGlorot(sz,numOut,numIn,'double');

        sz = [numHiddenFeatureMaps numHiddenFeatureMaps];
        numOut = numHiddenFeatureMaps;
        numIn = numHiddenFeatureMaps;
        parameters.W2 = initializeGlorot(sz,numOut,numIn,'double');

        sz = [numHiddenFeatureMaps numOutputFeatures];
        numOut = numOutputFeatures;
        numIn = numHiddenFeatureMaps;
        parameters.W3 = initializeGlorot(sz,numOut,numIn,'double');
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
            [gradients, loss, dlYPred] = dlfeval(@modelGradients, dlX, adjacencyTrain, T, parameters);

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
                score = accuracy(dlYPred, targetTrain, classes);
                addpoints(lineAccuracyTrain,epoch,double(gather(score)))

                drawnow

                % Display validation metrics.
                if epoch == 1 || mod(epoch,validationFrequency) == 0
                    % Loss.
                    dlYPredValidation = model(dlXValidation, adjacencyValidation, parameters);
                    lossValidation = crossentropy(dlYPredValidation, TValidation, 'DataFormat', 'BC');
                    addpoints(lineLossValidation,epoch,double(gather(extractdata(lossValidation))))

                    % Accuracy score.
                    scoreValidation = accuracy(dlYPredValidation, targetValidation, classes);
                    addpoints(lineAccuracyValidation,epoch,double(gather(scoreValidation)))

                    drawnow
                end
            end
        end

        featureTest = features{2};
        adjacencyTest = adjacency{2};
        targetTest = labels{2};
        dlXTest = dlarray(featureTest);
        dlYPredTest = model(dlXTest, adjacencyTest, parameters);
        [scoreTest, predTest] = accuracy(dlYPredTest, targetTest, classes);
        [X,Y,T,AUC] = perfcurve(targetTest,dlYPredTest(:,idx_pos),'amyloid_p');
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
        figure
        [~,idx] = sort(classAccuracy,'descend');
        histogram('Categories',classes(idx), ...
            'BinCounts',classAccuracy(idx), ...
            'Barwidth',0.8)
        xlabel("Category")
        ylabel("Accuracy")
        title("Class Accuracy Score")
        [confusionMatrix, order] = confusionmat(targetTest, predTest);
        figure
        cm = confusionchart(confusionMatrix, classes, ...
            'ColumnSummary','column-normalized', ...
            'RowSummary','row-normalized', ...
            'Title', 'ADNI Confusion Chart');
        
        % get string format of nn
        neural_network = gnn.net_binary_transformer(net);
    else
        neural_network = [];
        X_tblTrain = [];
        y_tblTrain = [];
        X_tblTest = [];
        y_tblTest = [];
        training_accuracy = 0;
        test_accuracy = 0;
    end
    % return all the values
    value = {neural_network, X_tblTrain, y_tblTrain, X_tblTest, y_tblTest, training_accuracy, test_accuracy};
end

%% ¡tests!
%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
%example_nn_regression_ST