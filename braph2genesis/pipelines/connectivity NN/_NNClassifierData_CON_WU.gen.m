%% ¡header!
NNClassifierData_CON_WU < NNClassifierData (nnd, data of a neural network classifier with connectivity data) produces a dataset to a neural netowrk classifier using connectivity data. 

%% ¡description!
This dataset can be used to train or test a neural network classifier. The
INPUTS and TARGETS are the two cells for trianing a neurla network. The INPUTS 
cell is obtained direcly from DTI adjacency matrices, and it is represented as 
floating point feature cell. Feature selection procedure can be implemented 
when constructing the INPUTS. The TARGETS cell holds the target values for 
the trianing samples. 

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
NN_GR1 (result, group) is a group of subjects defined as NNSubject class.
%%%% ¡settings!
'NNGroup'
%%%% ¡default!
NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'))
%%%% ¡calculate!
gr = nnd.get('GR1');
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
        ...
        'G', g, ...
        'INPUT', input, ...
        'TARGET', gr.get('ID') ...
        );
    nn_sub_dict.add(nn_sub);
end
nn_gr.set('sub_dict', nn_sub_dict);

value = nn_gr;

%%% ¡prop!
NN_GR2 (result, group)  is a group of subjects defined as NNSubject class.
%%%% ¡settings!
'NNGroup'
%%%% ¡default!
NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'))
%%%% ¡calculate!
gr = nnd.get('GR2');
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
        input_nodal(isnan(input_nodal)) = 0;
        input_binodal(isnan(input_binodal)) = 0;
        input_global(isnan(input_global)) = 0;
        input = {input_nodal input_global input_binodal};
    end

    nn_sub = NNSubject( ...
        'ID', [sub.get('ID') ' in ' gr.get('ID')], ...
        'BA', atlas, ...
        'age', sub.get('age'), ...
        'sex', sub.get('sex'), ...
        'G', g, ...
        'INPUT', input, ...
        'TARGET', gr.get('ID') ...
        );
    nn_sub_dict.add(nn_sub);
end
nn_gr.set('sub_dict', nn_sub_dict);

value = nn_gr;

%% ¡tests!
%%% ¡test!
%%%% ¡name!
Example 1
%%%% ¡code!
example_NN_CON_WU_Classification_GraphMeasures

%%% ¡test!
%%%% ¡name!
Example 2
%%%% ¡code!
example_NN_CON_WU_Classification_AdjacencyMatrix