%% ¡header!
AnalyzeEnsemble_CON_WU < AnalyzeEnsemble (a, graph analysis with connectivity data) is a ensenmble-based graph analysis using connectivity data.

%%% ¡description!
This ensemble-based graph analysis (AnalyzeEnsemble_CON_WU) analyzes connectivity data using weighted undirected graphs.

%%% ¡seealso!
SubjectCON, GraphWU

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the ensenmble-based graph analysis using connectivity data.
%%%% ¡default!
'AnalyzeEnsemble_CON_WU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ensenmble-based graph analysis using connectivity data.
%%%% ¡default!
'This ensemble-based graph analysis (AnalyzeEnsemble_CON_WU) analyzes connectivity data using weighted undirected graphs.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ensenmble-based graph analysis using connectivity data.
%%%% ¡default!
'AnalyzeEnsemble_CON_WU'

%%% ¡prop!
ID (data, string) is a few-letter code for the ensenmble-based graph analysis using connectivity data.
%%%% ¡default!
'AnalyzeEnsemble_CON_WU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ensenmble-based graph analysis using connectivity data.
%%%% ¡default!
'AnalyzeEnsemble_CON_WU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ensenmble-based graph analysis using connectivity data.
%%%% ¡default!
'AnalyzeEnsemble_CON_WU notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON')

%%% ¡prop!
GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
%%%% ¡settings!
'GraphWU'

%%% ¡prop!
G_DICT (result, idict) is the graph (GraphWU) ensemble obtained from this analysis.
%%%% ¡settings!
'GraphWU'
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'GraphWU');
gr = a.get('GR');

for i = 1:1:gr.get('SUB_DICT').get('LENGTH')
	sub = gr.get('SUB_DICT').get('IT', i);
    g = GraphWU( ...
        'ID', ['graph ' sub.get('ID')], ... 
        'TEMPLATE', a.memorize('GRAPH_TEMPLATE'), ...
        'B', sub.getCallback('CON') ...
        );
    g_dict.add(g)
end

value = g_dict;

%%% ¡prop!
ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
%%%% ¡_gui!
% % % pr = PPAnalyzeEnsemble_ME_DICT('EL', a, 'PROP', AnalyzeEnsemble_CON_WU.ME_DICT, 'WAITBAR', true, varargin{:});

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
if ~isfile([fileparts(which('SubjectCON')) filesep 'Example data CON XLS' filesep 'atlas.xlsx'])
    test_ImporterGroupSubjectCON_XLS % create example files
end

example_CON_WU