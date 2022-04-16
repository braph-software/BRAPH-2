%% ¡header!
NNRegressorCrossValidation < Element (nncv, cross-validation for neural network regressor) cross-validate the performance of neural network regressors with a dataset.

%% ¡description!
This cross validation perform a k-fold cross validation of neural network
regressor with desired repetitions on a dataset. The dataset is split into
k consecutive folds with shuffling by default, and each fold is then used 
once as a validation while the k-1 remaining folds from the training set. 
The root-mean square error is calculated across folds and repetitions.

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the cross validation.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the cross validation.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the cross validation.

%%% ¡prop!
KFOLD (data, scalar) is the number of folds.
%%%% ¡default!
5

%%% ¡prop!
REPETITION (data, scalar) is the number of repetitions.
%%%% ¡default!
1

%%% ¡prop!
GR (data, item) is is a group of subjects.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
FEATURE_MASK (data, cell) is a given mask or a percentile to select relevant features.
%%%% ¡default!
num2cell(0.05)
%%%% ¡conditioning!
if ~iscell(value) & isnumeric(value)
    value = num2cell(value);
end
%%%% ¡gui!
pr = PlotPropSmartVector('EL', nncv, 'PROP', NNRegressorCrossValidation.FEATURE_MASK, 'MAX', 10000000, 'MIN', 0, varargin{:});

%%% ¡prop!
PLOT_MAP (data, logical) is an option for the plot of the feature map.
%%%% ¡default!
false

%%% ¡prop!
PLOT_SCATTER (data, logical) is an option for the plot of scatter plot.
%%%% ¡default!
false

%%% ¡prop!
SPLIT_KFOLD (result, cell) is a vector stating which subjects belong to each fold.
%%%% ¡calculate!
num_per_class = nncv.get('GR').get('SUB_DICT').length;
kfold = nncv.get('KFOLD');
shuffle_indexes = randperm(num_per_class, num_per_class);
num_per_fold = floor(num_per_class / kfold);
r_times = rem(num_per_class, kfold);
r = zeros(1, kfold);
r(randperm(kfold, r_times)) = 1;
jend = 0;
for j = 1:kfold
    jstart = jend + 1;
    if j == kfold
        index_kfold{j} = shuffle_indexes(jend+1:end);
    else
        jend = jend + num_per_fold + r(j);
        index_kfold{j} = shuffle_indexes(jstart:jend);
    end
end

value = index_kfold;

%%% ¡prop!
NNDS_DICT (result, idict) contains the NN data splits for k folds across repetitions.
%%%% ¡settings!
'NNRegressorDataSplit'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'NNRegressorDataSplit')
%%%% ¡calculate!
nnds_dict = IndexedDictionary('IT_CLASS', 'NNRegressorDataSplit');
if ~isa(nncv.get('GR').getr('SUB_DICT'), 'NoValue')
    for i = 1:1:nncv.get('REPETITION')
        idx_per_fold = nncv.get('SPLIT_KFOLD');
        for j = 1:1:nncv.get('KFOLD')
            nnds = NNRegressorDataSplit( ...
                'ID', ['NN dataset for fold #', num2str(j), ' in repetition #', num2str(i)], ...
                'GR', nncv.get('GR'), ...
                'SPLIT', idx_per_fold{j}, ...
                'FEATURE_MASK', nncv.get('FEATURE_MASK') ...
                );

            nnds_dict.add(nnds)
        end
    end
end

value = nnds_dict;
%%%% ¡gui!
pr = PPNNCrossValidation_NNDict('EL', nncv, 'PROP', NNRegressorCrossValidation.NNDS_DICT, varargin{:});

%%% ¡prop!
NN_DICT (result, idict) contains the NN regressors for k folds for all repetitions.
%%%% ¡settings!
'NNRegressorDNN'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'NNRegressorDNN')
%%%% ¡calculate!
nn_dict = IndexedDictionary('IT_CLASS', 'NNRegressorDNN');
if nncv.memorize('NNDS_DICT').length() > 0
    for i = 1:1:nncv.get('NNDS_DICT').length()
        nnds = nncv.get('NNDS_DICT').getItem(i);
        gr_train = nnds.get('GR_TRAIN_FS');

        nn = NNRegressorDNN( ...
                'ID', ['NN model cooperated with ', nnds.get('ID')], ...
                'GR', gr_train, ...
                'VERBOSE', true, ...
                'PLOT_TRAINING', false, ...
                'SHUFFLE', 'every-epoch' ...
                );
            
        nn_dict.add(nn)
    end
end

value = nn_dict;
%%%% ¡gui!
pr = PPNNCrossValidation_NNDict('EL', nncv, 'PROP', NNRegressorCrossValidation.NN_DICT, varargin{:});

%%% ¡prop!
NNE_DICT (result, idict) contains the NN evaluators for k folds for all repetitions.
%%%% ¡settings!
'NNRegressorEvaluator'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'NNRegressorEvaluator')
%%%% ¡calculate!
nne_dict = IndexedDictionary('IT_CLASS', 'NNRegressorEvaluator');
if nncv.memorize('NN_DICT').length() > 0
    for i = 1:1:nncv.get('NN_DICT').length()
        nn = nncv.get('NN_DICT').getItem(i);
        nnds = nncv.get('NNDS_DICT').getItem(i);
        gr_val = nnds.get('GR_VAL_FS');

        nne = NNRegressorEvaluator( ...
                'ID', ['NN evaluator cooperated with ', nnds.get('ID')], ...
                'GR', gr_val, ...
                'NN', nn ...
                );
            
        nne_dict.add(nne)
    end
end

value = nne_dict;
%%%% ¡gui!
pr = PPNNCrossValidation_NNDict('EL', nncv, 'PROP', NNRegressorCrossValidation.NNE_DICT, varargin{:});

%%% ¡prop!
GR_PREDICTION (result, item) is a group of NN subjects with prediction from NN.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
if nncv.memorize('NNE_DICT').length() > 0
    gr = nncv.get('NNE_DICT').getItem(1).get('GR_PREDICTION');
    gr_prediction = NNGroup( ...
        'ID', 'NN Group with NN prediction', ...
        'LABEL', 'The predictions are obatined from K-fold cross validation', ...
        'NOTES', 'All of the predictions are obtained from the validation of each fold', ...
        'SUB_CLASS', gr.get('SUB_CLASS'), ...
        'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject') ...
        );

    % add subejcts from NNE_DICT
    sub_dict = gr_prediction.get('SUB_DICT');

    for i = 1:1:nncv.memorize('NNE_DICT').length()
        nne = nncv.memorize('NNE_DICT').getItem(i);
        for j = 1:1:nne.memorize('GR_PREDICTION').get('SUB_DICT').length()
            sub = nne.memorize('GR_PREDICTION').get('SUB_DICT').getItem(j);
            sub_dict.add(sub);
        end
    end

    gr_prediction.set('SUB_DICT', sub_dict);
else
    gr_prediction = NNGroup();
end

value = gr_prediction;
%%%% ¡gui!
pr = PPNNData_GR_NN('EL', nncv, 'PROP', NNRegressorCrossValidation.GR_PREDICTION, varargin{:});

%%% ¡prop!
RMSE (result, scalar) is the root mean squared error between targets and predictions across k folds for all repeitions.
%%%% ¡calculate!
if nncv.memorize('GR_PREDICTION').get('SUB_DICT').length() == 0
    value = 0;
else
    preds = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nncv.memorize('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    preds = cell2mat(preds);
    targets = cellfun(@(x) cell2mat(x.get('TARGET')), nncv.get('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    targets = cell2mat(targets);
    value = sqrt(mean((preds - targets).^2));
end


%%% ¡prop!
SCATTER_CHART (result, matrix) creates a scatter chart with circular markers at the locations specified by predictions and targets.
%%%% ¡calculate!
if nncv.get('GR_PREDICTION').get('SUB_DICT').length() == 0
    value = 0;
else
    preds = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nncv.get('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    preds = cell2mat(preds);
    targets = cellfun(@(x) cell2mat(x.get('TARGET')), nncv.get('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    targets = cell2mat(targets);
    value = [preds' targets'];
    if nncv.get('PLOT_SCATTER')
        figure
        scatter(preds, targets);
        hold on
        plot([min(preds) max(preds)], [min(targets) max(targets), 'k']);
        hold off
        xlabel('Prediction')
        ylabel('Target')
        title('Scatter plot for regression')
        directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
        if ~exist(directory, 'dir')
            mkdir(directory)
        end
        filename = [directory filesep 'scatter.svg'];
        saveas(gcf, filename);
    end
end
%%%% ¡gui!
pr = PPNNRegressorEvaluator_Scatter_Chart('EL', nncv, 'PROP', NNRegressorCrossValidation.SCATTER_CHART, varargin{:});

%%% ¡prop!
FEATURE_MAP (result, cell) is a heat map obtained with feature selection analysis and the AUC value.
%%%% ¡calculate!
nne_dict = nncv.memorize('NNE_DICT');
heat_map = {};
if ~isempty(nne_dict.getItems()) && ~isempty(nne_dict.getItem(1).get('RMSE')) && ~any(ismember(subclasses('Measure'), nncv.get('GR_PREDICTION').get('SUB_DICT').getItem(1).get('INPUT_LABEL')))
    tmp_map = nne_dict.getItem(1).get('GR_PREDICTION').get('SUB_DICT').getItem(1).get('FEATURE_MASK');
    for i = 1:1:length(tmp_map)
        heat_map{i} = zeros(size(tmp_map{i}));
    end
    for i = 1:1:nne_dict.length()
        feature_map = nne_dict.getItem(i).get('GR_PREDICTION').get('SUB_DICT').getItem(1).get('FEATURE_MASK');
        rmse = nne_dict.getItem(i).get('RMSE');
        if rmse == 0
            rmse = 0.01;
        end
        feature_map_out = feature_map;
        for j = 1:1:length(feature_map)
            fm_tmp = feature_map{j};
            fm_tmp(fm_tmp == 1) = 1 / rmse;
            feature_map_out{j} = fm_tmp;
        end
        heat_map = cellfun(@(x, y) x + y, heat_map, feature_map_out, 'UniformOutput', false);
    end
    heat_map = cellfun(@(x) x / nne_dict.length(), heat_map, 'UniformOutput', false);
    if nncv.get('PLOT_MAP')
        for i = 1:1:length(heat_map)
            heat_map_tmp = heat_map{i};
            figure
            x = [1 size(heat_map_tmp, 2)];
            y = [0 size(heat_map_tmp, 1)];
            image(x, y, heat_map_tmp, 'CDataMapping', 'scaled')
            colorbar
            directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
            if ~exist(directory, 'dir')
                mkdir(directory)
            end
            filename = [directory filesep 'cv_feature_map.svg'];
            saveas(gcf, filename);
        end
    end
else
    %TODO: check the msgbox is needed 
    %braph2msgbox("No visualization for the feature map", "For now, we only provide the feature map visualization for input of adjacency matrix or structural data.")
end
value = heat_map;
%%%% ¡gui!
pr = PPNNCrossValidation_Feature_Map('EL', nncv, 'PROP', NNRegressorCrossValidation.FEATURE_MAP, varargin{:});


%% ¡methods!
function [avg, CI] = get_CI(nncv, scores)
    %GET_CI calculates the 95% confidence interval.
    % 
    % [AVG, CI] = GET_CI(NNCV, SCORES) calculates the 95% confidence interval
    %  of the input scores which are in a form of rvector. AVG is the mean 
    %  value of the input scores. CI are the upper and lower boundary of
    %  the corresponding 95% confidence interval.

    avg = mean(scores);
    SEM = std(scores)/sqrt(length(scores));               
    ts = tinv([0.025  0.975],length(scores)-1);     
    CI = avg + ts*SEM;
end