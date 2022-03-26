%% ¡header!
NNData_CON_WU < NNData (nnd, data for neural network) produces a dataset to train or test a neural netowrk model for connectivity data. 

%% ¡description!
This NN data generates a group of NN subjects, each of which contains the 
input as adjacency matrices or graph measures from connectivity data. 
The generated NN group can be used to train or test a neural network model.

%% ¡props_update!

%%% ¡prop!
GR (data, item) is a group of subjects defined as SubjectCON class.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON')

%%% ¡prop!
GR_NN (result, item) is a group of NN subjects.
%%%% ¡settings!
'NNGroup'
%%%% ¡default!
NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'))
%%%% ¡calculate!
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

if gr.get('SUB_DICT').length() > 0
    nn_sub_dict = nn_gr.get('SUB_DICT');
    for i = 1:1:gr.get('SUB_DICT').length()
    	sub = gr.get('SUB_DICT').getItem(i);
        g = GraphWU( ...
            'ID', ['g ' sub.get('ID')], ...
            'BRAINATLAS', atlas, ...
            'B', Callback('EL', sub, 'TAG', 'CON') ...
            );

        if string(nnd.get('INPUT_TYPE')) == "adjacency_matrices"
            input = g.get('A');

        elseif string(nnd.get('INPUT_TYPE')) == "graph_measures"
            input_nodal = [];
            input_binodal = [];
            input_global = [];
            mlist = nnd.get('MEASURES');
            for j = 1:length(mlist)
                if Measure.is_nodal(mlist{j})
                    input_nodal = [input_nodal; cell2mat(g.getMeasure(mlist{j}).get('M'))];
                elseif Measure.is_global(mlist{j})
                    input_global = [input_global; cell2mat(g.getMeasure(mlist{j}).get('M'))];
                else
                    input_binodal = [input_binodal; cell2mat(g.getMeasure(mlist{j}).get('M'))];
                end
            end
            input = {input_nodal input_global input_binodal};
        end

        nn_sub = NNSubject( ...
            'ID', [sub.get('ID') ' in ' gr.get('ID')], ...
            'BA', atlas, ...
            'age', sub.get('age'), ...
            'sex', sub.get('sex'), ...
            'G', g, ...
            'INPUT', input, ...
            'TARGET_NAME', nnd.get('TARGET_NAME') ...
            );
        nn_sub_dict.add(nn_sub);
    end
    nn_gr.set('sub_dict', nn_sub_dict);
end

value = nn_gr;

%% ¡tests!
%%% ¡test!
%%%% ¡name!
Example 1
%%%% ¡code!
example_NN_CON_WU_Regression_AdjacencyMatrix

%%% ¡test!
%%%% ¡name!
Example 2
%%%% ¡code!
example_NN_CON_WU_Classification_AdjacencyMatrix

%%% ¡test!
%%%% ¡name!
Example 3
%%%% ¡code!
example_NN_CON_WU_Classification_GraphMeasures

%%% ¡test!
%%%% ¡name!
Example 4
%%%% ¡code!
example_NNCV_CON_WU_Classification_AdjacencyMatrix