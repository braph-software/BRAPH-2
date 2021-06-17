%% ¡header!
AnalyzeGroup_ST_MP_BUT < AnalyzeGroup (a, graph analysis with structural multiplex data of fixed threshold) is a graph analysis using structural multiplex data of fixed threshold.

%% ¡description!
This graph analysis uses structural multiplex data of fixed threshold and 
analyzes them using binary undirected graphs.

%%% ¡seealso!
AnalyzeGroup_ST_MP_WU, AnalyzeGroup_ST_MP_BUD, Subject_ST_MP, MultiplexBUT.

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
USE_COVARIATES (parameter, logical) determines the use of covariates in the analysis.
%%%% ¡default!
false

%%% ¡prop!
THRESHOLDS (parameter, rvector) is the vector of thresholds.
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
'MultiplexBUT'
%%%% ¡default!
MultiplexBUT()
%%%% ¡calculate!
gr = a.get('GR');
data_list = cellfun(@(x) x.get('ST_MP'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
node_dict = gr.get('SUB_DICT').getItem(1).get('BA').get('BR_DICT');
node_labels_tmp = cellfun(@(x) x.get('ID') , node_dict.getItems(), 'UniformOutput', false);
node_labels = '';

% i have to transform the labels to a string because we dont have a format
% for a cell of strings. 
for i = 1:length(node_labels_tmp)
    node_labels = [node_labels ',' node_labels_tmp{i}];
end
node_labels = node_labels(2:end);

if a.get('USE_COVARIATES')
    age_list = cellfun(@(x) x.get('age'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
    age = cat(2, age_list{:})';
    sex_list = cellfun(@(x) x.get('sex'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
    sex = zeros(size(age));
    for i=1:length(sex_list)
        switch lower(sex_list{i})
            case 'female'
                sex(i) = 1;
            case 'male'
                sex(i) = 0;
            otherwise
                sex(i) = -1;
        end
    end
    covariates = [age, sex];
end

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
        if a.get('USE_COVARIATES')
            A(i) = {Correlation.getAdjacencyMatrix(data{i}, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'), covariates)};
        else
            A(i) = {Correlation.getAdjacencyMatrix(data{i}, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'))};
        end
    end
end
thresholds = a.get('THRESHOLDS'); % this is a vector

g = MultiplexBUT( ...
    'ID', ['g ' gr.get('ID')], ...
    'B', A, ...
    'THRESHOLDS', thresholds, ...
    'NODELABELS', node_labels ...
    );

value = g;
%%%% ¡gui!
pl = PPAnalyzeGroupGraph('EL', a, 'PROP', AnalyzeGroup_ST_MP_BUT.G, varargin{:});

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_ST_MP_BUT