%% ¡header!
MeasureEnsemble < Element (me, graph ensemble measure) is a graph ensemble measure.

%%% ¡description!
Measure provides the methods necessary for a graph ensemble measure.

%%% ¡seealso!
AnalyzeEnsemble, CompareEnsemble

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the graph ensemble measure.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph ensemble measure.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph ensemble measure.

%%% ¡prop!
A (data, item) is the ensemble-based graph analysis.
%%%% ¡settings!
'AnalyzeEnsemble'

%%% ¡prop!
M (result, cell) is the measure result.
%%%% ¡calculate!
value = {};