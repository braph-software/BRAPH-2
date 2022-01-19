%% ¡header!
DatasetProcessor_Classification_CON_WU < DatasetProcessor_Classification (dp, data processor of neural network classifier using connectivity data) produces a dataset to train or test neural netowrk classifier using connectivity data. 

%% ¡description!
This dataset processor uses connectivity data as input and produce the dataset 
that can be used to train or test a neural network classifier. 
Feature selection procedure can be implemented.

%% ¡props!
%%% ¡prop!
G_DICT_1 (result, idict) is the graph (GraphWU) ensemble obtained from subject group 1.
%%%% ¡settings!
'GraphWU'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'GraphWU')
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'GraphWU');
gr = dp.get('GR1');
atlas = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0 
    atlas = gr.get('SUB_DICT').getItem(1).get('BA');
end
gr = dp.get('GR1');
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
gr = dp.get('GR2');
atlas = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0 
    atlas = gr.get('SUB_DICT').getItem(1).get('BA');
end
gr = dp.get('GR2');
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
X_RAW (result, cell) is the dataset without feature selection.
%%%% ¡calculate!
adjs_gr1 = dp.get('G_DICT_1').getItems();
data_gr1 = {};
for i = 1:length(adjs_gr1)
    data_gr1{end+1} = cell2mat(adjs_gr1{i}.get('A'));
end
adjs_gr2 = dp.get('G_DICT_2').getItems();
data_gr2 = {};
for i = 1:length(adjs_gr2)
    data_gr2{end+1} = cell2mat(adjs_gr2{i}.get('A'));
end

%value = {[data_gr1 data_gr2]};
value = [data_gr1 data_gr2];

%%% ¡prop!
X_MASKED (result, cell) is the dataset with feature selection.
%%%% ¡calculate!
x_raw = dp.get('X_RAW');
if(isempty(dp.get('FEATURE_SELECTION_MASK')))
    mask = dp.get('FEATURE_SELECTION').get('FEATURE_SELECTION_MASK');
else
    mask = dp.get('FEATURE_SELECTION_MASK');
end
x_masked = cellfun(@(v)v(mask{1}),x_raw,'UniformOutput',false);
x_masked = cat(2, x_masked{:});

value = {x_masked};

%%% ¡prop!
Y (result, cell) is the label for the dataset.
%%%% ¡calculate!
y1 = repmat(string(dp.get('GR1').get('ID')), dp.get('GR1').get('SUB_DICT').length(), 1);
y2 = repmat(string(dp.get('GR2').get('ID')), dp.get('GR2').get('SUB_DICT').length(), 1);

value = {[y1; y2]'};

%% ¡props_update!
%%% ¡prop!
GR1 (data, item) is the subject group 1, which also defines the subject class SubjectCON.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON')

%%% ¡prop!
GR2 (data, item) is the subject group 2, which also defines the subject class SubjectCON.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON')

%% ¡tests!
%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_CON_WU_NN