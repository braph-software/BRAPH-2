%% ¡header!
AnalyzeKFoldCrossValidation_CON_WU < Element (cv, classifier with dti data) is cross-validation analysis for classification task

%% ¡description!
This classifier using dti data with neural network and trains neural network for classification of groups.

%% ¡props!
%%% ¡prop!
A_1 (data, item) is the analysis group 1.
%%%% ¡settings!
'AnalyzeEnsemble'

%%% ¡prop!
A_2 (data, item) is the analysis group 2.
%%%% ¡settings!
'AnalyzeEnsemble'

%%% ¡prop!
KFOLD (parameter, scalar) is the number of repetitions
%%%% ¡default!
5

%%% ¡prop!
DENSITY_OF_FEATURE_SELECTION (parameter, scalar) is the number of repetitions
%%%% ¡default!
0.05

%%% ¡prop!
AVERAGE_AUC (result, scalar) is the AUC obtained across k folds
%%%% ¡calculate!
classifier_nn_dict = cv.memorize('CLASSIFIER_NN_DICT');
for i = 1:1:classifier_nn_dict.length()
    auc[i] = classifier_nn_dict.getItem(i).get('TEST_AUC');
end
value = mean(auc);

%%% ¡prop!
CLASSIFIER_NN_DICT (result, idict) contains the results of the neural network analysis acorss k folds
%%%% ¡settings!
'ClassifierNN'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'ClassifierNN');
%%%% ¡calculate!
classifier_nn_dict = IndexedDictionary('IT_CLASS', 'ClassifierNN');
[data_gr1, data_gr2, label_gr1, label_gr2] = nn.prepare_dataset();
index_for_kfold_split = nn.get_idx_for_kfold_split();
for i = 1:1:cv.get('KFOLD')
    [X_train, Y_train, X_test, Y_test] = nn.prepare_dataset(i);
    nn = ClassifierNN( ...
        'ID', ['fold ' string(i)], ...
        'X_TRAIN', X_train, ...
        'Y_TRAIN', Y_train, ...
        'X_TEST', X_test, ...
        'Y_TEST', Y_test, ...
        'DENSITY_OF_FEATURE_SELECTION', 0.05, ...
        );
    classifier_nn_dict.add(nn)
end

value = classifier_nn_dict;


%% ¡tests!
%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_CON_WU_NN