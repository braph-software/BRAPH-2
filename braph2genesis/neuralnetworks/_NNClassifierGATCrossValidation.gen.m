%% ¡header!
NNClassifierGATCrossValidation < NNClassifierCrossValidation (nncv, cross-validation for graph attention network classifiers) cross-validate the performance of graph attention network classifiers with a dataset.

%% ¡description!
This cross validation perform a k-fold cross validation of a graph attention
network classifier with desired repetitions on a dataset. The dataset is 
split into k consecutive folds with shuffling by default, and each fold is 
then used once as a validation set while the k-1 remaining folds from the 
training set. The confusion matrix, ROC curves, AUCs, and weighted 
contributing maps will be calculated across folds and repetitions.

%% ¡props_update!

%%% ¡prop!
NN_DICT (result, idict) contains the NN GAT classifiers for k folds for all repetitions.
%%%% ¡settings!
'NNClassifierGAT'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'NNClassifierGAT')
%%%% ¡calculate!
nn_dict = IndexedDictionary('IT_CLASS', 'NNClassifierGAT');
if nncv.memorize('NNDS_DICT').length() > 0
    for i = 1:1:nncv.get('NNDS_DICT').length()
        nnds = nncv.get('NNDS_DICT').getItem(i);
        gr_train = nnds.get('GR_TRAIN_FS');

        nn = NNClassifierGAT( ...
                'ID', ['NN model cooperated with ', nnds.get('ID')], ...
                'GR', gr_train, ...
                'PLOT_TRAINING', false ...
                );
            
        nn_dict.add(nn)
    end
end

value = nn_dict;
%%%% ¡gui!
pr = PPNNCrossValidation_NNDict('EL', nncv, 'PROP', NNClassifierGATCrossValidation.NN_DICT, varargin{:});

%%% ¡prop!
NNE_DICT (result, idict) contains the NN GAY evaluators for k folds for all repetitions.
%%%% ¡settings!
'NNClassifierGATEvaluator'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'NNClassifierGATEvaluator')
%%%% ¡calculate!
nne_dict = IndexedDictionary('IT_CLASS', 'NNClassifierGATEvaluator');
if nncv.memorize('NN_DICT').length() > 0
    for i = 1:1:nncv.get('NN_DICT').length()
        nn = nncv.get('NN_DICT').getItem(i);
        nnds = nncv.get('NNDS_DICT').getItem(i);
        gr_val = nnds.get('GR_VAL_FS');

        nne = NNClassifierGATEvaluator( ...
                'ID', ['NN evaluator cooperated with ', nnds.get('ID')], ...
                'GR', gr_val, ...
                'NN', nn ...
                );
            
        nne_dict.add(nne)
    end
end

value = nne_dict;
%%%% ¡gui!
pr = PPNNCrossValidation_NNDict('EL', nncv, 'PROP', NNClassifierGATCrossValidation.NNE_DICT, varargin{:});

%%% ¡prop!
FEATURE_MAP (result, cell) is heat maps obtained with the attention from the NN GAT.
%%%% ¡calculate!
nne_dict = nncv.memorize('NNE_DICT');
heat_map = {};
if ~isempty(nne_dict.getItems()) && ~isempty(nne_dict.getItem(1).get('AUC')) && ~any(ismember(subclasses('Measure'), nncv.get('GR_PREDICTION').get('SUB_DICT').getItem(1).get('INPUT_LABEL')))
    tmp_map = nne_dict.getItem(1).get('GR_PREDICTION').get('SUB_DICT').getItem(1).get('FEATURE_MASK');
    for i = 1:1:length(tmp_map)
        heat_map{i} = zeros(size(tmp_map{i}));
    end
    for i = 1:1:nne_dict.length()
        feature_map = nne_dict.getItem(i).get('GR_PREDICTION').get('SUB_DICT').getItem(1).get('FEATURE_MASK');
        heat_map = cellfun(@(x, y) x + y, heat_map, feature_map, 'UniformOutput', false);
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
pr = PPNNCrossValidation_Feature_Map('EL', nncv, 'PROP', NNClassifierGATCrossValidation.FEATURE_MAP, varargin{:});
