%% ¡header!
ClassificationST < ClassificationNN (nn, graph analysis with structural data) is a graph analysis using structural data.

%% ¡description!
This is a classification for structural data

%% ¡properties!
accuracy

%% ¡props!

%%% ¡prop!
CLASSNAMES (parameter, cell) is the correlation type.

%%% ¡prop!
FILE (metadata, string) is the file path, this has to change to gr eventually.
%%%% ¡default!
'mr_adni.csv'

%% ¡props_update!

%%% ¡prop!
Network (result, string) is the graph obtained from this analysis.
%%%% ¡default!
0
%%%% ¡calculate!
% gr = a.get('GR');
% data_list = cellfun(@(x) x.get('ST'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
% data = cat(2, data_list{:})'; % correlation is a column based operation

% import the data
filename = nn.get('FILE');
tbl = readtable(filename, 'TextType','String');

% covert the label into categorical in order for prediction
labelName = "DX";
tbl = convertvars(tbl,labelName, 'categorical');

% show table
tbl = splitvars(tbl);
head(tbl)

% show classes name
classNames = categories(tbl{:,labelName})

% % show classes name
% classNames = nn.get('CLASSNAMES');

% split the data into training set and test set (90:10)
numObservations = size(tbl, 1);
numObservationsTrain = floor(0.9*numObservations);
numObservationsTest = numObservations - numObservationsTrain;

idx = randperm(numObservations);
idxTrain = idx(1:numObservationsTrain);
idxTest = idx(numObservationsTrain+1:end);

tblTrain = tbl(idxTrain, :);
tblTest = tbl(idxTest, :);

y_tblTrain = tblTrain{:, end};
X_tblTrain = tblTrain{:, 1:end-1};
X_tblTrain = reshape(X_tblTrain', [1, 1, size(X_tblTrain,2), size(X_tblTrain,1)]);
y_tblTest = tblTest{:, end};
X_tblTest = tblTest{:, 1:end-1};
X_tblTest = reshape(X_tblTest', [1, 1, size(X_tblTest,2), size(X_tblTest,1)]);

% specify the parameters and layers
numFeatures = size(tbl, 2) - 1;
numClasses = numel(classNames);
layers = [
    %featureInputLayer(numFeatures,'Normalization', 'zscore','Name','input')
    imageInputLayer([1 1 numFeatures],'Normalization', 'zscore','Name','input')
    fullyConnectedLayer(floor(1.5*numFeatures),'Name','fc1')
    batchNormalizationLayer('Name','batchNormalization1')
    fullyConnectedLayer(floor(1.5*numFeatures),'Name','fc2')
    batchNormalizationLayer('Name','batchNormalization2')
    reluLayer('Name','relu1')
    fullyConnectedLayer(numClasses,'Name','fc3')
    softmaxLayer('Name','sfmax1')
    classificationLayer('Name','output')];
lgraph = layerGraph(layers);
plot(lgraph)
miniBatchSize = 16;

options = trainingOptions('sgdm', ...
    'MiniBatchSize',miniBatchSize, ...
    'Shuffle','every-epoch', ...
    'Plots','training-progress', ...
    'Verbose',false);

% fit the model
net = trainNetwork(X_tblTrain, y_tblTrain, layers, options);

% get prediction accuracy on training set
YPred = classify(net, X_tblTrain, 'MiniBatchSize', miniBatchSize);
YTest = y_tblTrain;

accuracy = sum(YPred == YTest)/numel(YTest);

% plot result
[m,order] = confusionmat(YTest,YPred)
figureconfusionchart(trueLabels,predictedLabels, ...
    'Title','AD Classification', ...
    'RowSummary','row-normalized', ...
    'ColumnSummary','column-normalized');

% get prediction accuracy on test set
YPred = classify(net, X_tblTest, 'MiniBatchSize', miniBatchSize);
YTest = y_tblTest;

nn.accuracy = sum(YPred == YTest)/numel(YTest);

net_string = transform (net) to string;

value = net;

%% ¡methods!
function accuracy = getAccuracy(nn)
    accuracy = nn.accuracy;
end





