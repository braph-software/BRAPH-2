%% ¡header!
NNClassifierCrossValidation_CON_WU < NNClassifierCrossValidation (nncv, cross-validation of a neural network classifier) cross-validates the performance of a neural network classifier with a dataset.

%% ¡description!
This cross validation performan k-fold cross validation of a neural network
classifier with desired repetitions for connectivity data. The dataset is 
split into k consecutive folds with shuffling by default, and each fold is 
then used once as a validation while the k-1 remaining folds form the 
training set. The confusion matrix, ROC curves, AUCs, and contributing maps 
are calculated across the testing sets over k folds.

%% ¡props_update!

%%% ¡prop!
GR1 (data, item) is a group of subjects defined as SubjectCON class.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON')

%%% ¡prop!
GR2 (data, item) is a group of subjects defined as SubjectCON class.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON')

%%% ¡prop!
NND_DICT (result, idict) is the NN evaluators for k folds across repetitions.
%%%% ¡settings!
'NNClassifierData_CON_WU'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'NNClassifierData_CON_WU')
%%%% ¡calculate!
nnd_dict = IndexedDictionary('IT_CLASS', 'NNClassifierData_CON_WU');
if ~isa(nncv.get('GR1').getr('SUB_DICT'), 'NoValue')
    for i = 1:1:nncv.get('REPETITION')
        idx_per_fold_gr1 = nncv.get('SPLIT_KFOLD_GR1');
        idx_per_fold_gr2 = nncv.get('SPLIT_KFOLD_GR2');
        for j = 1:1:nncv.get('KFOLD')
            nnd = NNClassifierData_CON_WU( ...
                'ID', ['kfold ', num2str(j), 'repetition ', num2str(i)], ...
                'GR1', nncv.get('GR1'), ...
                'GR2', nncv.get('GR2'), ...
                'INPUT_TYPE', nncv.get('INPUT_TYPE'), ...
                'MEASURES', nncv.get('MEASURES'), ...
                'SPLIT_GR1', idx_per_fold_gr1{j}, ...
                'SPLIT_GR2', idx_per_fold_gr2{j}, ...
                'FEATURE_MASK', 0.05 ...
                );

            nnd.memorize('GR_VAL_FS');
            nnd.memorize('GR_TRAIN_FS');

            nnd_dict.add(nnd)
        end
    end
end

value = nnd_dict;

%% ¡tests!
%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_NNCV_CON_WU_Classification_AdjacencyMatrix