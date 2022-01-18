%% ¡header!
AnalyzeKFoldCrossValidationClassification < Element (cv, k-fold cross validation analysis of classification) is cross-validation analysis for classification task

%% ¡description!
AnalyzeKFoldCrossValidationClassification provides the methods necessary for all cross-validation analysis subclasses.
Instances of this class should not be created. 
Use one of its subclasses instead.

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the cross validation analysis.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the cross validation analysis.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the cross validation analysis.

%%% ¡prop!
GR1 (data, item) is the subject group 1, which also defines the subject class.
%%%% ¡settings!
'Group'

%%% ¡prop!
GR2 (data, item) is the subject group 2, which also defines the subject class.
%%%% ¡settings!
'Group'

%%% ¡prop!
KFOLD (parameter, scalar) is the number of folds for the cross validation analysis.
%%%% ¡default!
5

%%% ¡prop!
DENSITY_OF_FEATURE_SELECTION (parameter, scalar) is the densities of feature selection, which is the process of reducing the number of input variables.
%%%% ¡default!
0.05

%%% ¡prop!
G_DICT_1 (result, idict) is the graph ensemble obtained from subject group 1.
%%%% ¡settings!
'Graph'
%%%% ¡calculate!
value = IndexedDictionary('IT_CLASS', 'Graph');

%%% ¡prop!
G_DICT_2 (result, idict) is the graph ensemble obtained from subject group 2.
%%%% ¡settings!
'Graph'
%%%% ¡calculate!
value = IndexedDictionary('IT_CLASS', 'Graph');

%%% ¡prop!
AVERAGE_AUC (result, scalar) is the AUC obtained across k folds
%%%% ¡calculate!
classifier_nn_dict = cv.memorize('CLASSIFIER_NN_DICT');
for i = 1:1:classifier_nn_dict.length()
    auc(i) = classifier_nn_dict.getItem(i).get('TEST_AUC');
end
value = mean(auc);
