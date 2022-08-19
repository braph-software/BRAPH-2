%% ¡header!
NNData_FUN_WU < NNData (nnd, data for neural network) produces a dataset to train or test a neural netowrk model for functional data. 

%% ¡description!
This NN data generates a group of NN subjects, each of which contains the 
input as adjacency matrices or graph measures from functional data. 
The generated NN group can be used to train or test a neural network model.

%% ¡props!

%%% ¡prop!
REPETITION(parameter, scalar) is the number of repetitions.
%%%% ¡default!
1

%%% ¡prop!
FREQUENCYRULEMIN(parameter, scalar)is the minimum frequency value.
%%%% ¡default!
0
%%% ¡prop!
FREQUENCYRULEMAX(parameter, scalar)is the maximum frequency value.
%%%% ¡default!
Inf

%%% ¡prop!
CORRELATION_RULE (parameter, option) is the correlation type.
%%%% ¡settings!
Correlation.CORRELATION_RULE_LIST
%%%% ¡default!
Correlation.CORRELATION_RULE_LIST{1}

%%% ¡prop!
NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
%%%% ¡settings!
Correlation.NEGATIVE_WEIGHT_RULE_LIST
%%%% ¡default!
Correlation.NEGATIVE_WEIGHT_RULE_LIST{1}

%% ¡props_update!

%%% ¡prop!
INPUT_TYPE (data, option) is the input type for training or testing the NN.
%%%% ¡settings!
{'adjacency_matrices' 'graph_measures'}

%%% ¡prop!
GR (data, item) is a group of subjects defined as SubjectFUN class.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN')

%%% ¡prop!
G (data, item) is the graph for calculating the graph measures.
%%%% ¡default!
GraphWU()

%%% ¡prop!
GR_NN (result, item) is a group of NN subjects.
%%%% ¡settings!
'NNGroup'
%%%% ¡default!
NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'))
%%%% ¡calculate!
wb = braph2waitbar(nnd.get('WAITBAR'), 0, 'Constructing NN input ...');

gr = nnd.get('GR');
T = nnd.get('REPETITION');
fmin = nnd.get('FREQUENCYRULEMIN');
fmax = nnd.get('FREQUENCYRULEMAX');
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
    data = sub.getr('FUN');
    fs = 1 / T;
    
    if fmax > fmin && T > 0
        NFFT = 2 * ceil(size(data, 1) / 2);
        ft = fft(data, NFFT);  % Fourier transform
        f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
        ft(f < fmin | f > fmax, :) = 0;
        data = ifft(ft, NFFT);
    end
    
    A = Correlation.getAdjacencyMatrix(data, nnd.get('CORRELATION_RULE'), nnd.get('NEGATIVE_WEIGHT_RULE'));
    
    g = GraphWU( ...
        'ID', ['g ' sub.get('ID')], ...
        'B', A, ...
        'BAS', atlas ...
        );
    
    if string(nnd.get('INPUT_TYPE')) == "adjacency_matrices"
        input = g.get('A'); 
        input_label = {'GraphWU'};

    elseif string(nnd.get('INPUT_TYPE')) == "graph_measures"
        input_nodal = [];
        input_binodal = [];
        input_global = [];
        mlist = nnd.get('MEASURES');
        input_label = mlist;
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
'NNData_FUN_WU'
%%%% ¡postprocessing!
if nnd.prop_set(NNData_FUN_WU.TEMPLATE, varargin{:})
    varargin = {};
    
    parameters = nnd.getProps(Category.PARAMETER);
    for i = 1:1:length(parameters)
        parameter = parameters(i);
        
        if parameter ~= NNData_FUN_WU.TEMPLATE
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
example_NN_FUN_WU_Regression_AdjacencyMatrix

%%% ¡test!
%%%% ¡name!
Example 2
%%%% ¡code!
example_NN_FUN_WU_Classification_AdjacencyMatrix

%%% ¡test!
%%%% ¡name!
Example 3
%%%% ¡code!
example_NN_FUN_WU_Classification_GraphMeasures

%%% ¡test!
%%%% ¡name!
Example 4
%%%% ¡code!
example_NNCV_FUN_WU_Classification_AdjacencyMatrix