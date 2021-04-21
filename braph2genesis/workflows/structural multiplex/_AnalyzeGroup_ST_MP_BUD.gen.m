%% ¡header!
AnalyzeGroup_ST_MP_BUD < AnalyzeGroup (a, graph analysis with structural multiplex data of fixed density) is a graph analysis using structural multiplex data of fixed density.

%% ¡description!
This graph analysis uses structural multiplex data of fixed density and 
analyzes them using binary undirected graphs.

%%% ¡seealso!
AnalyzeGroup_ST_MP_WU, AnalyzeGroup_ST_MP_BUT, Subject_ST_MP, MultiplexBUD.

%% ¡props!

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

%%% ¡prop!
DENSITIES (parameter, rvector) is the vector of densities.
%%%% ¡default!
0

%% ¡props_update!

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectST_MP.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST_MP')

%%% ¡prop!
G (result, item) is the graph obtained from this analysis.
%%%% ¡settings!
'MultiplexBUD'
%%%% ¡default!
MultiplexBUD()
%%%% ¡calculate!
gr = a.get('GR');
data_list = cellfun(@(x) x.get('ST_MP'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
if isempty(data_list)
    A ={[], []};
else
    L = gr.get('SUB_DICT').getItem(1).get('L');  % number of layers
    br_number = gr.get('SUB_DICT').getItem(1).get('ba').get('BR_DICT').length();  % number of regions
    data = cell(L, 1);
    for i=1:L
        data_layer = zeros(length(data_list), br_number);
        for j=1:length(data_list)
            sub_cell = data_list{j};
            data_layer(j, :) = sub_cell{i}';
        end
        data(i) = {data_layer};
    end
    
    A = cell(1, L);
    for i = 1:L
        A(i) = {Correlation.getAdjacencyMatrix(data{i}, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'))};
    end
end
densities = a.get('DENSITIES'); % this is a vector

g = MultiplexBUD( ...
    'ID', ['g ' gr.get('ID')], ...
    'B', A, ...
    'DENSITIES', densities ...
    );

value = g;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_ST_MP_BUD