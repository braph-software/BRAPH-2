%% ¡header!
AnalyzeKFoldCrossValidationClassification_CON_WU < AnalyzeKFoldCrossValidationClassification (cv, k-fold cross validation analysis of classification with connectivity data) is cross-validation analysis for classification task using connectivity data

%% ¡description!
This cross validation analysis uses connectivity data as input and performs training and testing
on the classifiers.

%% ¡props!
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

%%% ¡prop!


%% ¡props_update!
%%% ¡prop!
GR1 (data, item) is the subject group 1, which also defines the subject class SubjectCON.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON')

%%% ¡prop!
GR2 (data, item) is the subject group 2, which also defines the subject class SubjectCON.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON')

%%% ¡prop!
DS_DICT (result, idict) is the datasets for k folds obtained from subject group 1.
%%%% ¡settings!
'DatasetProcessor'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'DatasetProcessor')
%%%% ¡calculate!
ds_dict = IndexedDictionary('IT_CLASS', 'DatasetProcessor');
gr = a.get('GR1');
atlas = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0 
    atlas = gr.get('SUB_DICT').getItem(1).get('BA');
end
gr = a.get('GR');
for i = 1:1:gr.get('SUB_DICT').length()
	sub = gr.get('SUB_DICT').getItem(i);
    g = GraphWU( ...
        'ID', ['g ' sub.get('ID')], ...
        'BRAINATLAS', atlas, ...
        'B', Callback('EL', sub, 'TAG', 'CON') ...
        );
    g_dict.add(g)
end

value = g_dict;

%%% ¡prop!
G_DICT_2 (result, idict) is the graph (GraphWU) ensemble obtained from subject group 2.
%%%% ¡settings!
'GraphWU'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'GraphWU')
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'GraphWU');
gr = a.get('GR2');
atlas = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0 
    atlas = gr.get('SUB_DICT').getItem(1).get('BA');
end
gr = a.get('GR');
for i = 1:1:gr.get('SUB_DICT').length()
	sub = gr.get('SUB_DICT').getItem(i);
    g = GraphWU( ...
        'ID', ['g ' sub.get('ID')], ...
        'BRAINATLAS', atlas, ...
        'B', Callback('EL', sub, 'TAG', 'CON') ...
        );
    g_dict.add(g)
end

value = g_dict;

%% ¡tests!
%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_CON_WU_NN