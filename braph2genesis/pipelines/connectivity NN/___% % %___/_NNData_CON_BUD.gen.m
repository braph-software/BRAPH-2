%% ¡header!
NNData_CON_BUD < NNData (nnd, data for neural network) produces a dataset to train or test a neural netowrk model for connectivity data. 

%% ¡description!
This NN data generates a group of NN subjects, each of which contains the 
input as adjacency matrices or graph measures from connectivity data. 
The generated NN group can be used to train or test a neural network model.

%% ¡props!

%%% ¡prop!
DENSITIES (parameter, rvector) is the vector of densities.
%%%% ¡default!
5
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', nnd, 'PROP', NNData_CON_BUD.DENSITIES, ...
    'MIN', 0, 'MAX', 100, ...
    'DEFAULT', NNData_CON_BUD.getPropDefault('DENSITIES'), ...
    varargin{:});

%% ¡props_update!

%%% ¡prop!
ANALYZE_ENSEMBLE (data, item) contains the graphs of the group.
%%%% ¡settings!
'AnalyzeEnsemble_CON_BUD'
%%%% ¡postprocessing!
if ~braph2_testing && ~isa(nnd.get('GR'), 'NoValue')
    nnd.memorize('ANALYZE_ENSEMBLE').set('GR', nnd.get('GR'));
end

%%% ¡prop!
GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
%%%% ¡settings!
'MultigraphBUD'
%%%% ¡postprocessing!
if ~braph2_testing
    if isa(nnd.getr('GRAPH_TEMPLATE'), 'NoValue')
        if nnd.get('GR').get('SUB_DICT').length() > 0
            nnd.set('GRAPH_TEMPLATE', MultigraphBUD('BAS', nnd.get('GR').get('SUB_DICT').getItem(1).get('BA')));
        else
            nnd.set('GRAPH_TEMPLATE', MultigraphBUD());
        end
    end
end


%%% ¡prop!
INPUT_TYPE (parameter, option) is the input type for training or testing the NN.
%%%% ¡settings!
{'adjacency_matrices' 'graph_measures'}

%%% ¡prop!
G (parameter, item) is the graph for calculating the graph measures.
%%%% ¡settings!
'MultigraphBUD'

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
densities = nnd.get('DENSITIES');

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
    g = MultigraphBUD( ...
        'ID', ['g ' sub.get('ID')], ...
        'B', Callback('EL', sub, 'TAG', 'CON'), ...
        'DENSITIES', densities, ...
        'BAS', atlas ...
        );

    if string(nnd.get('INPUT_TYPE')) == "adjacency_matrices"
        adj = g.get('A');
        input = {};
        for j = 1:1:length(adj)
            input{j} = adj{j,j};
        end
        input_label = {'MultigraphBUD'};

    elseif string(nnd.get('INPUT_TYPE')) == "graph_measures"
        input_nodal = [];
        input_binodal = [];
        input_global = [];
        mlist = cellfun(@(x) x.get('ID'), nnd.get('Measures').getItems(), 'UniformOutput', false);
        if isempty(mlist)
            nnd.getMeasureEnsemble('Degree');
            mlist = cellfun(@(x) x.get('ID'), nnd.get('Measures').getItems(), 'UniformOutput', false);
        end
        input_label = mlist;
        for j = 1:length(mlist)
            m_value = nnd.getCalculatedMeasure(g, mlist{j});
            if Measure.is_nodal(mlist{j})
                input_nodal = [input_nodal cell2mat(m_value)];
            elseif Measure.is_global(mlist{j})
                input_global = [input_global cell2mat(m_value)];
            else
                input_binodal = [input_binodal cell2mat(m_value)];
            end
        end
        input = {input_global input_nodal input_binodal};
    end

    nn_sub = NNSubject( ...
        'ID', [sub.get('ID') ' in ' gr.get('ID')], ...
        'BA', atlas, ...
        'age', sub.get('age'), ...
        'sex', sub.get('sex'), ...
        'G', g, ...
        'INPUT', input, ...
        'INPUT_TYPE', nnd.get('INPUT_TYPE'), ...
        'INPUT_LABEL', input_label, ...
        'TARGET_NAME', nnd.get('TARGET_NAME') ...
        );

    nn_sub_dict.add(nn_sub);
    
	braph2waitbar(wb, .30 + .70 * i / gr.get('SUB_DICT').length(), ['Constructing subject ' num2str(i) ' of ' num2str(gr.get('SUB_DICT').length())  ' in ' gr.get('ID') ' ...'])
end

nn_gr.set('sub_dict', nn_sub_dict);

braph2waitbar(wb, 'close')

value = nn_gr;

%%% ¡prop!
TEMPLATE (parameter, item) is the analysis template to set the parameters.
%%%% ¡settings!
'NNData_CON_BUD'
%%%% ¡postprocessing!
if nnd.prop_set(NNData_CON_BUD.TEMPLATE, varargin{:})
    varargin = {};
    
    parameters = nnd.getProps(Category.PARAMETER);
    for i = 1:1:length(parameters)
        parameter = parameters(i);
        
        if parameter ~= NNData_CON_BUD.TEMPLATE
            varargin{length(varargin) + 1} = parameter;
            varargin{length(varargin) + 1} = Callback('EL', nnd.get('TEMPLATE'), 'PROP', parameter);
        end
    end
    
    nnd.set(varargin{:});
end

%% ¡tests!
%%% ¡test!
%%%% ¡name!
Example 1
%%%% ¡code!
example_NNCV_CON_BUD_Regression_GraphMeasures

%%% ¡test!
%%%% ¡name!
Example 2
%%%% ¡code!
example_NNCV_CON_BUD_Classification_AdjacencyMatrix