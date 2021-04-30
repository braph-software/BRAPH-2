%% ¡header!
AnalyzeEnsemble_FUN_MP_WU < AnalyzeEnsemble (a, graph analysis with functional multiplex data) is a graph analysis using functional multiplex data.

%% ¡description!
This graph analysis uses functional multiplex data and analyzes them using weighted undirected graphs,
binary undirected multigraphs with fixed thresholds,
or binary undirected multigraphs with fixed densities.

%%% ¡seealso!
AnalyzeGroup_FUN_MP_BUD, AnalyzeGroup_FUN_MP_BUT, Subject_FUN_MP, MultiplexWU.

%% ¡props!
%%% ¡prop!
REPETITION(parameter, scalar) is the number of repetitions
%%%% ¡default!
1
%%% ¡prop!
FREQUENCYRULEMIN(parameter, scalar)is the minimum frequency value
%%%% ¡default!
0
%%% ¡prop!
FREQUENCYRULEMAX(parameter, scalar)is the maximum frequency value
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
GR (data, item) is the subject group, which also defines the subject class SubjectFUN_MP.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN_MP')

%%% ¡prop!
G_DICT (result, idict) is the graph (MultiplexWU) ensemble obtained from this analysis.
%%%% ¡settings!
'MultiplexWU'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'MultiplexWU')
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'MultiplexWU');