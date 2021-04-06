%% ¡header!
AnalysisST < Analysis (a, graph analysis with structural data) is a graph analysis using structural data.

%% ¡description!
This graph analysis uses structural data and analyzes them using weighted undirected graphs,
binary undirected multigraphs with fixed thresholds,
or binary undirected multigraphs with fixed densities.

%% ¡props!

%%% ¡prop!
G_CLASS (parameter, option) is the graph class.
%%%% ¡settings!
{'GraphWU', 'MultigraphBUT', 'MultigraphBUD'}
%%%% ¡default!
'GraphWU'

%%% ¡prop!
THRESHOLDS (data, rvector) is the vector of thresholds.

%%% ¡prop!
DENSITIES (data, rvector) is the vector of densities.

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
GR (data, item) is the subject group, which also defines the subject class SubjectST.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST')

%%% ¡prop!
G (result, item) is the graph obtained from this analysis, it can be GraphWU, MultigraphBUT, or MultigraphBUD.
%%%% ¡settings!
'Graph'
%%%% ¡check_value!
check = any(strcmp(value.getClass(), a.getPropSettings('G_CLASS')));
%%%% ¡default!
GraphWU()
%%%% ¡calculate!
gr = a.get('GR');
data_list = cellfun(@(x) x.get('ST'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
data = cat(2, data_list{:})'; % correlation is a column based operation

A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'));
switch a.get('G_CLASS')
    case 'GraphWU'
        g = GraphWU( ...
            'ID', ['g ' gr.get('ID')], ...
            'B', A ...
            );
    case 'MultigraphBUT'
        g = MultigraphBUT( ...
            'ID', ['g ' gr.get('ID')], ...
            'THRESHOLDS', a.get('THRESHOLDS'), ...
            'B', A ...
            );
    case 'MultigraphBUD'
        g = MultigraphBUD( ...
            'ID', ['g ' gr.get('ID')], ...
            'DENSITIES', a.get('DENSITIES'), ...
            'B', A ...
            );    
end

value = g;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_ST