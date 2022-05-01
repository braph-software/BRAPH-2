%% ¡header!
NNDataGAT_CON_WU < NNData (nnd, data for neural network) produces a dataset to train or test a graph attention netowrk model for connectivity data. 

%% ¡description!
This NN data generates a group of NN subjects, each of which contains the 
input as WU adjacency matrices and graph measures from connectivity data. 
The generated NN group can be used to train or test a graph attetion network model.

%% ¡props_update!

%%% ¡prop!
INPUT_TYPE (data, option) is the input type for training or testing the NN.
%%%% ¡settings!
{'graph_measures'}

%%% ¡prop!
MEASURES (data, classlist) is the graph measures as input to NN.
%%%% ¡settings!
'Measure'
%%%% ¡default!
{'Degree'}
%%%% ¡gui!
pr = PPNNDataGAT_Measures('EL', nnd, 'PROP', NNDataGAT_CON_WU.MEASURES, varargin{:});

%%% ¡prop!
GR_NN (result, item) is a group of NN subjects.
%%%% ¡settings!
'NNGroup'
%%%% ¡default!
NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'))
%%%% ¡calculate!
wb = braph2waitbar(nnd.get('WAITBAR'), 0, 'Constructing NN input ...');

gr = nnd.get('GR');
nn_gr = NNGroup( ...
    'SUB_CLASS', 'NNSubject', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject') ...
    );

nn_gr.lock('SUB_CLASS');

nn_gr.set( ...
    'ID', gr.get('ID'), ...
    'LABEL', gr.get('LABEL'), ...
    'NOTES', gr.get('NOTES') ...
    );

atlas = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0 
    atlas = gr.get('SUB_DICT').getItem(1).get('BA');
end

nn_sub_dict = nn_gr.get('SUB_DICT');

for i = 1:1:gr.get('SUB_DICT').length()
    sub = gr.get('SUB_DICT').getItem(i);
    g = GraphWU( ...
        'ID', ['g ' sub.get('ID')], ...
        'BRAINATLAS', atlas, ...
        'B', Callback('EL', sub, 'TAG', 'CON') ...
        );
    
    input_label = {'GraphWU'};
    
    nn_sub = NNSubject( ...
        'ID', [sub.get('ID') ' in ' gr.get('ID')], ...
        'BA', atlas, ...
        'age', sub.get('age'), ...
        'sex', sub.get('sex'), ...
        'G', g, ...
        'MEASURES', nnd.get('MEASURES'), ...
        'INPUT', g.get('A'), ...
        'INPUT_LABEL', input_label, ...
        'TARGET_NAME', nnd.get('TARGET_NAME') ...
        );

    nn_sub_dict.add(nn_sub);
    
    braph2waitbar(wb, .30 + .70 * i / gr.get('SUB_DICT').length(), ['Constructing subject ' num2str(i) ' of ' num2str(gr.get('SUB_DICT').length())  ' in ' gr.get('ID') ' ...'])
end

nn_gr.set('sub_dict', nn_sub_dict);

braph2waitbar(wb, 'close')

value = nn_gr;

%% ¡tests!
%%% ¡test!
%%%% ¡name!
Example 1
%%%% ¡code!
example_NNGAT_CON_WU_Classification

%%% ¡test!
%%%% ¡name!
Example 2
%%%% ¡code!
example_NNGATCV_CON_WU_Classification
