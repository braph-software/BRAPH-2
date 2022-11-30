%% ¡header!
NNData_ST < NNData (nnd, data for neural network) produces a dataset to train or test a neural netowrk model for structural data. 

%% ¡description!
This NN data generates a group of NN subjects, each of which contains the 
input as structural data. The generated NN group can be used to train or 
test a neural network model.

%% ¡props_update!

%%% ¡prop!
GR (data, item) is a group of subjects defined as SubjectST class.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST')

%%% ¡prop!
INPUT_TYPE (data, option) is the input type for training or testing the NN.
%%%% ¡settings!
{'structural_data'}
%%%% ¡default!
'structural_data'

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
    input = {sub.get('ST')};
    nn_sub = NNSubject( ...
        'ID', [sub.get('ID') ' in ' gr.get('ID')], ...
        'BA', atlas, ...
        'age', sub.get('age'), ...
        'sex', sub.get('sex'), ...
        'INPUT', input, ...
        'INPUT_TYPE', nnd.get('INPUT_TYPE'), ...
        'TARGET_NAME', nnd.get('TARGET_NAME')...
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
'NNData_ST'
%%%% ¡postprocessing!
if nnd.prop_set(NNData_ST.TEMPLATE, varargin{:})
    varargin = {};
    
    parameters = nnd.getProps(Category.PARAMETER);
    for i = 1:1:length(parameters)
        parameter = parameters(i);
        
        if parameter ~= NNData_ST.TEMPLATE
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
example_NN_ST_Regression

%%% ¡test!
%%%% ¡name!
Example 2
%%%% ¡code!
example_NN_ST_Classification

%%% ¡test!
%%%% ¡name!
Example 3
%%%% ¡code!
example_NNCV_ST_Classification