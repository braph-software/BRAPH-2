%% ¡header!
NNClassifierData_CON_WU < NNClassifierData (nnd, data of a neural network classifier with connectivity data) produces a dataset to train or test a neural netowrk classifier using connectivity data. 

%% ¡description!
This dataset can be used to train or test a neural network classifier. The
INPUTS and TARGETS are the two cells for trianing a neurla network. The INPUTS 
cell is obtained direcly from DTI connectivity matrices, and is represent as 
floating point feature cell. Feature selection procedure can be implemented 
when constructing the INPUTS. The TARGETS cell holds the target values for 
the trianing samples. 

%% ¡props_update!
%%% ¡prop!
TRAIN_G_DICT_1 (result, idict) is the graph (GraphWU) from subject group 1 in training set.
%%%% ¡settings!
'GraphWU'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'GraphWU')
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'GraphWU');
gr = nnd.get('TRAIN_GR1');
atlas = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0 
    atlas = gr.get('SUB_DICT').getItem(1).get('BA');
end
gr = nnd.get('TRAIN_GR1');
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
TRAIN_G_DICT_2 (result, idict) is the graph (GraphWU) from subject group 2 in training set.
%%%% ¡settings!
'GraphWU'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'GraphWU')
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'GraphWU');
gr = nnd.get('TRAIN_GR2');
atlas = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0 
    atlas = gr.get('SUB_DICT').getItem(1).get('BA');
end
gr = nnd.get('TRAIN_GR2');
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
VAL_G_DICT_1 (result, idict) is the graph (GraphWU) from subject group 1 in validation set.
%%%% ¡settings!
'GraphWU'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'GraphWU')
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'GraphWU');
gr = nnd.get('VAL_GR1');
atlas = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0 
    atlas = gr.get('SUB_DICT').getItem(1).get('BA');
end
gr = nnd.get('VAL_GR1');
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
VAL_G_DICT_2 (result, idict) is the graph (GraphWU) from subject group 2 in validation set.
%%%% ¡settings!
'GraphWU'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'GraphWU')
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'GraphWU');
gr = nnd.get('VAL_GR2');
atlas = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0 
    atlas = gr.get('SUB_DICT').getItem(1).get('BA');
end
gr = nnd.get('VAL_GR2');
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