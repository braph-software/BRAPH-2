%% ¡header!
NNClassifierGAT < NNBase (nn, classifier with graph attention networks) is a graph neural network classifier.

%% ¡description!
This classifier is composed of graph attention layers.
The Classifier trains on NN groups which contain the inputs and targets.

%% ¡props!

%%% ¡prop!
BATCH (data, scalar) is the size of the mini-batch to use for each training iteration.
%%%% ¡default!
8

%%% ¡prop!
EPOCHS (data, scalar) is a maximum number of epochs.
%%%% ¡default!
400

%%% ¡prop!
HIDDEN_FEATURE_MAPS (data, scalar) is the number of hidden feature maps.
%%%% ¡default!
96

%%% ¡prop!
ATTENTION_HEAD (data, rvector) is a vector representing the number of heads in each attetion operation.
%%%% ¡default!
[]
%%%% ¡postprocessing!
if isempty(nn.get('ATTENTION_HEAD'))
    if nn.get('GR').get('SUB_DICT').length() > 0
        nn.set('ATTENTION_HEAD', [3 3 5]);
    end
end
%%%% ¡gui!
pr = PlotPropSmartVector('EL', nn, 'PROP', NNClassifierGAT.ATTENTION_HEAD, 'MAX', 1000, 'MIN', 1, varargin{:});

%%% ¡prop!
PLOT_TRAINING (metadata, logical) is an option for the plot of training-progress.
%%%% ¡default!
false

%% ¡props_update!

%%% ¡prop!
MODEL (result, net) is a trained graph attention network classifier.
%%%% ¡calculate!
if BRAPH2.installed('NN', 'warning')
    % get inputs
    nn_gr = nn.get('GR');
    if nn_gr.get('SUB_DICT').length() == 0
        value = network();
    else
        w = warning('query', 'MATLAB:mir_warning_unrecognized_pragma');
        warning('off', w.identifier);
        
        [mbq, ds, numFeatures, numClasses] = nn.reconstruct_dataset(nn_gr);
        numEpochs = nn.get('EPOCHS');
        learnRate = 0.01;
        
        % define parameters for GTN
        numHeads = struct;
        parameters = struct;

        specified_numHeads = nn.get('ATTENTION_HEAD');
        numHiddenFeatureMaps = nn.get('HIDDEN_FEATURE_MAPS');
        numInputFeatures = numFeatures;
        numOutputFeatureMaps = specified_numHeads(end) * numClasses;

        for i = 1:1:length(specified_numHeads)
            currentAttention = "attn" + num2str(i);
            numHeads.(currentAttention) = specified_numHeads(i);
            if i == 1
                sz = [numInputFeatures numHiddenFeatureMaps];
                numOut = numHiddenFeatureMaps;
                numIn = numInputFeatures;
            elseif i == length(specified_numHeads)
                sz = [numHiddenFeatureMaps numOutputFeatureMaps];
                numOut = numClasses;
                numIn = numHiddenFeatureMaps;
            else
                sz = [numHiddenFeatureMaps numHiddenFeatureMaps];
                numOut = numHiddenFeatureMaps;
                numIn = numHiddenFeatureMaps;
            end
            parameters.(currentAttention).weights.linearWeights = nn.initializeGlorot(sz, numOut, numIn);
            if i == length(specified_numHeads)
                parameters.(currentAttention).weights.attentionWeights = nn.initializeGlorot([numOutputFeatureMaps 2], 1, 2 * numOut);
            else
                parameters.(currentAttention).weights.attentionWeights = nn.initializeGlorot([numOut 2], 1, 2 * numOut);
            end
        end

        % Initialize the training progress plot.
        if nn.get('PLOT_TRAINING')
            figure
        end
        C = colororder;
        lineLossTrain = animatedline(Color = C(2, :));
        lineLossValidation = animatedline( ...
            LineStyle = "--", ...
            Marker = "o", ...
            MarkerFaceColor = "black");
        ylim([0 inf])
        xlabel("Iteration")
        ylabel("Loss")
        grid on

        iteration = 0;
        start = tic;
        trailingAvg = [];
        trailingAvgSq = [];
        % Loop over epochs.
        for epoch = 1:numEpochs

            % Shuffle data.
            shuffle(mbq);

            while hasdata(mbq)
                iteration = iteration + 1;

                % Read mini-batches of data.
                [XTrain, ATrain, numNodes, TTrain] = next(mbq);

                % Evaluate the model loss and gradients using dlfeval and the
                % modelLoss function.
                [loss, gradients, Y] = dlfeval(@nn.modelLoss, parameters, XTrain, ATrain, numNodes, TTrain, numHeads);

                % Update the network parameters using the Adam optimizer.
                [parameters, trailingAvg, trailingAvgSq] = adamupdate(parameters, gradients, ...
                    trailingAvg, trailingAvgSq, iteration, learnRate);

                % Display the training progress.
                D = duration(0, 0, toc(start), 'Format', "hh:mm:ss");
                title("Epoch: " + epoch + ", Elapsed: " + string(D))
                loss = double(extractdata(gather(loss)));
                if nn.get('PLOT_TRAINING')
                    addpoints(lineLossTrain,iteration,loss)
                    drawnow
                end
            end
        end
        value = parameters;
        
        % resume nnet warning status
        warning(w.state, w.identifier);
    end
else
    value = NoValue();
end

%% ¡methods!
function [mbq, ds, numFeatures, numClasses] = reconstruct_dataset(nn, gr)
    %RECONSTRUCT_DATASET reconstructs the dataset for NN.
    %
    % [MBQ, DS, NUMFEATURES, NUMCLASSES] = RECONSTRUCT_DATASET(NN, GR) reconstructs the
    %  inputs from NN group. According to the tyep of this Graph attention network,
    %  this function will construct a minibatchqueue MBQ that integrates dataset, DS, of
    %  features and adjacency matrices. NUMFEATURES is the number of features while
    %  NUMCLASSES is the number of classes.
    
    if gr.get('SUB_DICT').length() == 0
        mbq = {};
    else
        miniBatchSize = nn.get('BATCH');
        adjacency = [];
        features = [];
        targets = gr.get('TARGETS');
        labels = cellfun(@(x) cell2mat(x'), targets, 'UniformOutput', false);
        for i = 1:1:gr.get('SUB_DICT').length()
            sub = gr.get('SUB_DICT').getItem(i);
            adjacency_ind = sub.get('G').get('A');
            adjacency_ind = cell2mat(adjacency_ind);
            adjacency(:, :, i) = adjacency_ind;
            features_ind = sub.get('G').getMeasure('Degree').get('M');
            features_ind = cell2mat(features_ind);
            features(:, 1, i) = features_ind;
        end
        
        numFeatures = size(features, 2);
        muX = zeros(1, numFeatures);
        sigsqX = zeros(1, numFeatures);
        
        for i = 1:numFeatures
            X = nonzeros(features(:,i,:));
            muX(i) = mean(X);
            sigsqX(i) = var(X, 1);
        end
        
        numGraphs = size(features, 3);
        
        for j = 1:numGraphs
            validIdx = 1:nnz(features(:,1,j));
            features(validIdx,:,j) = (features(validIdx,:,j) - muX)./sqrt(sigsqX);
        end
        
        T = cat(1, labels{:});
        numClasses = size(T, 2);
        
        features = arrayDatastore(features, 'IterationDimension', 3);
        adjacency = arrayDatastore(adjacency, 'IterationDimension', 3);
        target = arrayDatastore(T);
        
        ds = combine(features, adjacency, target);
        
        mbq = minibatchqueue(ds, 4, ...
            MiniBatchSize = miniBatchSize, ...
            PartialMiniBatch = "discard", ...
            MiniBatchFcn = @nn.preprocessMiniBatch, ...
            OutputCast = "double", ...
            OutputAsDlarray = [1 0 0 0], ...
            OutputEnvironment = ["auto" "cpu" "cpu" "cpu"]);
    end
end
function [targets, classes] = reconstruct_targets(nn, gr)
    %RECONSTRUCT_TARGETS reconstructs the targets for NN.
    %
    % [TARGETS, CLASSES] = RECONSTRUCT_TARGETS(NN, GR) reconstructs the targets
    %  from NN group, by concatenating the target of NN Subjects.
    %  CLASSES is the categories name of the unique targets.
    
    if gr.get('SUB_DICT').length() == 0
        targets = [];
        classes = [];
    else
        targets = gr.get('TARGETS');
        targets = cellfun(@(x) cell2mat(x)', targets, 'UniformOutput', false);
        targets = cell2mat(targets);
        classes = categories(categorical(cellfun(@(x) x.get('TARGET_NAME'), gr.get('SUB_DICT').getItems(), 'UniformOutput', false)));
    end
end
function [outputFeatures, normAttentionCoeff] = attention(nn, inputFeatures, adjacency, weights, numHeads, aggregation)
    %ATTENTION computes node features using masked multihead self-attention.
    %
    % [OUTPUTFEATURES, NORMATTENTIONCOEFF] = attention(NN, INPUTFEATURES, ADJACENCY, WEIGHTS, NUMHEADS, AGGREGATION) 
    %  takes as inputs the feature matrix INPUTFEATURES, adjacency matrix ADJACENCY, learnable parameters WEIGHTS,
    %  the number of heads NUMHEADS, and aggregation method AGGREGATION for the multiple attention heads aggregation,
    %  and returns features using masked multihead self attention.

    % Split weights with respect to the number of heads and reshape the matrix to a 3-D array
    szFeatureMaps = size(weights.linearWeights);
    numOutputFeatureMapsPerHead = szFeatureMaps(2) / numHeads;
    linearWeights = reshape(weights.linearWeights, [szFeatureMaps(1), numOutputFeatureMapsPerHead, numHeads]);
    attentionWeights = reshape(weights.attentionWeights, [numOutputFeatureMapsPerHead, 2, numHeads]);
    
    % Compute linear transformations of input features
    value = pagemtimes(inputFeatures, linearWeights);
    
    % Compute attention coefficients
    query = pagemtimes(value, attentionWeights(:, 1, :));
    key = pagemtimes(value, attentionWeights(:, 2, :));
    
    attentionCoefficients = query + permute(key, [2, 1, 3]);
    attentionCoefficients = leakyrelu(attentionCoefficients, 0.2);
    
    % Compute masked attention coefficients
    mask = -10e9 * (1 - adjacency);
    attentionCoefficients = attentionCoefficients + mask;
    
    % Compute normalized masked attention coefficients
    normAttentionCoeff = softmax(attentionCoefficients, 'DataFormat', "BCU");
    
    % Normalize features using normalized masked attention coefficients
    headOutputFeatures = pagemtimes(normAttentionCoeff, value);
    
    % Aggregate features from multiple heads
    if strcmp(aggregation, "cat")
        outputFeatures = headOutputFeatures(:, :);
    else
        outputFeatures =  mean(headOutputFeatures, 3);
    end
end
function [features, adjacency, numNodes, target] = preprocessMiniBatch(nn, featureData, adjacencyData, targetData)
    %PREPROCESSMINIBATCH merges mini-batches of different graph instances into a single graph instance.
    %
    % [FEATURES, ADJACENCY, NUMNODES, TARGET] = preprocessMiniBatch(NN, FEATUREDATA, ADJACENCYDATA, TARGETDATA)
    %  takes as inputs the feature data FEATUREDATA, the adjacency data ADJACENCYDATA, and the target data TARGETDATA,
    %  and merges mini-batches of different graph instances into a single graph instance.

    % Extract feature and adjacency data from their cell array and concatenate the data along the third (batch) dimension
    featureData = cat(3,featureData{:});
    adjacencyData = cat(3,adjacencyData{:});
    
    % Extract target data if it exists
    if nargin > 3
        target = cat(1,targetData{:});
    end
    
    adjacency = sparse([]);
    features = [];
    numNodes = [];
    
    for i = 1:size(adjacencyData, 3)
        % Get the number of nodes in the current graph
        numNodesInGraph = nnz(featureData(:,1,i));
        numNodes = [numNodes; numNodesInGraph];
    
        % Get the indices of the actual nonzero data
        validIdx = 1:numNodesInGraph;
    
        % Remove zero paddings from adjacencyData
        tmpAdjacency = adjacencyData(validIdx, validIdx, i);
    
        % Add self connections
        tmpAdjacency = tmpAdjacency + eye(size(tmpAdjacency));
    
        % Build the adjacency matrix into a block diagonal matrix
        adjacency = blkdiag(adjacency, tmpAdjacency);
    
        % Remove zero paddings from featureData
        tmpFeatures = featureData(validIdx, :, i);
        features = [features; tmpFeatures];
    end
end
function [Y, attentionScore] = modelPredictions(nn, parameters, ds, numHeads)
    %MODELPREDICTIONS obtains model predictions for validating the network.
    %
    % [Y, ATTENTIONSCORE] = modelPredictions(NN, PARAMETERS, DS, NUMHEADS)
    %  takes as inputs the model parameters PARAMETERS, the datastore object 
    %  DS holding the features and adjacency data, and the number of heads
    %  NUMHEADS, and returns the model predictions by iterating over 
    %  mini-batches of data and preprocessing each mini-batch using 
    %  the preprocessMiniBatch function.
    
    Y = [];
    reset(ds)
    
    while hasdata(ds)
        
        data = read(ds);
        
        featureData = data(:, 1);
        adjacencyData = data(:, 2);
        
        [features,adjacency,numNodes] = nn.preprocessMiniBatch(featureData, adjacencyData);
        
        X = dlarray(features);
        
        [minibatchPred, attentionScore] = nn.model(parameters, X, adjacency, numNodes, numHeads);
        Y = [Y; minibatchPred];
    end
end
function [loss, gradients, Y] = modelLoss(nn, parameters, X, adjacencyTrain, numNodes, T, numHeads)
    %MODELLOSS calculates the gradients of the loss.
    %
    % [LOSS, GRADIENTS, Y] = MODELLOSS(NN, PARAMETERS, X, ADJACENCYTRAIN, NUMNODES, T, NUMHEADS)
    %  takes as inputs the model parameters PARAMETERS, the feature matrix X, 
    %  the adjacency matrix ADJACENCYTRAIN, the number of nodes per graph 
    %  NUMNODES, the binary encoded labels T, and the number of heads NUMHEADS,
    %  and returns the gradients GRADIENTS of the loss with respect to the model
    %  parameters, the corresponding loss LOSS, and the model predictions Y.
    
    Y = nn.model(parameters, X, adjacencyTrain, numNodes, numHeads);
    loss = crossentropy(Y, T, 'argetCategories', "independent", 'DataFormat', "BC");
    gradients = dlgradient(loss, parameters);
end
function [Y, attentionScores] = model(nn, parameters, X, A, numNodes, numHeads)
    %MODEL calculates the prediction and the attention scores.
    %
    % [Y, ATTENTIONSCORES] = model(NN, PARAMETERS, X, A, NUMNODES, NUMHEADS)
    %  takes as inputs the model parameters PARAMETERS, the feature matrix X,
    %  the adjacency matrix A, the number of nodes per graph NUMNODES, and
    %  the number of heads NUMHEADS, and returns the predictions and the 
    %  attention scores.
    
    attn_name = fieldnames(numHeads);
    weights = parameters.(attn_name{1}).weights;
    numHeadsAttention1 = numHeads.(attn_name{1});
    
    Z1 = X;
    [Z, attentionScores.attn1] = nn.attention(Z1, A, weights, numHeadsAttention1, "cat");
    Z  = nn.elu(Z);
    
    for i = 2:1:length(fieldnames(numHeads))
        weights = parameters.(attn_name{i}).weights;
        numHeadsAttention = numHeads.(attn_name{i});
        if i == length(fieldnames(numHeads))
            aggregation = "mean";
        else
            aggregation = "cat";
        end
        [Z_next, attentionScores.(attn_name{i})] = nn.attention(Z, A, weights, numHeadsAttention, aggregation);
        if i == length(fieldnames(numHeads))
            Z_next = nn.globalAveragePool(Z_next, numNodes);
        else
            Z_next  = nn.elu(Z_next) + Z;
        end
        Z = Z_next;
    end
    Y = sigmoid(Z);
end
function weights = initializeGlorot(nn, sz, numOut, numIn, className)
    %INITIALIZEGLOROT initializes the learnable weights.
    %
    % WEIGHTS = INITIALIZEGLOROT(NN, SZ, NUMOUT, NUMIN, CLASSNAME)
    %  takes as inputs the size of the weights SZ, the num of output NUMOUT,
    %  the number of input NUMIN, and the class name CLASSNAME, and returns
    %  the weights WEIGHTS.

    arguments
        nn
        sz
        numOut
        numIn
        className = 'single'
    end
    
    Z = 2 * rand(sz, className) - 1;
    bound = sqrt(6 / (numIn + numOut));
    
    weights = bound * Z;
    weights = dlarray(weights);
    
    end
    function outFeatures = globalAveragePool(nn, inFeatures, numNodes)
    
    numGraphs = numel(numNodes);
    numFeatures = size(inFeatures, 2);
    outFeatures = zeros(numGraphs, numFeatures, "like", inFeatures);
    
    startIdx = 1;
    for i = 1:numGraphs
    endIdx = startIdx + numNodes(i) - 1;
    idx = startIdx:endIdx;
    outFeatures(i, :) = mean(inFeatures(idx, :));
    startIdx = endIdx + 1;
    end
end
function y = elu(nn, x)
    %ELU implements the ELU activation function.   

    y = max(0, x) + (exp(min(0, x)) - 1);
end