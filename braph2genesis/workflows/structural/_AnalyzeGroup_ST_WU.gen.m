%% ¡header!
AnalyzeGroup_ST_WU < AnalyzeGroup (a, graph analysis with structural data) is a graph analysis using structural data.

%% ¡description!
This graph analysis uses structural data and analyzes them using weighted undirected graphs,
binary undirected multigraphs with fixed thresholds,
or binary undirected multigraphs with fixed densities.

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

%% ¡props_update!

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectST.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST')

%%% ¡prop!
G (result, item) is the graph obtained from this analysis.
%%%% ¡settings!
'GraphWU'
%%%% ¡default!
GraphWU()
%%%% ¡calculate!
gr = a.get('GR');
data_list = cellfun(@(x) x.get('ST'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
data = cat(2, data_list{:})'; % correlation is a column based operation

A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'));

g = GraphWU( ...
    'ID', ['g ' gr.get('ID')], ...
    'B', A ...
    );

value = g;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_ST_WU