%% ¡header!
AnalyzeEnsemble_CON_OMP_WU < AnalyzeEnsemble (a, graph analysis with connectivity ordinal multiplex data) is an ensemble-based graph analysis using connectivity ordinal multiplex data.

%%% ¡description!
This graph analysis (AnalyzeEnsemble_CON_OMP_WU) analyzes connectivity 
ordinal multiplex data using weighted undirected graphs.

%%% ¡seealso!
SubjectCON_MP, OrdMxWU

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the ensemble-based graph analysis with connectivity ordinal multiplex data.
%%%% ¡default!
'AnalyzeEnsemble_CON_OMP_WU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis with connectivity ordinal multiplex data.
%%%% ¡default!
'This graph analysis (AnalyzeEnsemble_CON_OMP_WU) analyzes connectivity ordinal multiplex data using weighted undirected graphs.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis with connectivity ordinal multiplex data.
%%%% ¡settings!
'AnalyzeEnsemble_CON_OMP_WU'

%%% ¡prop!
ID (data, string) is a few-letter code for the ensemble-based graph analysis with connectivity ordinal multiplex data.
%%%% ¡default!
'AnalyzeEnsemble_CON_OMP_WU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ensemble-based graph analysis with connectivity ordinal multiplex data.
%%%% ¡default!
'AnalyzeEnsemble_CON_OMP_WU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis with connectivity ordinal multiplex data.
%%%% ¡default!
'AnalyzeEnsemble_CON_OMP_WU notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON_MP.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_MP')

%%% ¡prop!
COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
%%%% ¡default!
getCompatibleMeasures('OrdMxWU')

%%% ¡prop!
G_DICT (result, idict) is the graph (OrdMxWU) ensemble obtained from this analysis.
%%%% ¡settings!
'OrdMxWU'
%%%% ¡_default!
% % % IndexedDictionary('IT_CLASS', 'OrdMxWU')
%%%% ¡_calculate!
% % % g_dict = IndexedDictionary('IT_CLASS', 'OrdMxWU');
% % % gr = a.get('GR');
% % % 
% % % ba = BrainAtlas();
% % % if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0
% % %     ba = gr.get('SUB_DICT').getItem(1).get('BA');
% % % end
% % % 
% % % for i = 1:1:gr.get('SUB_DICT').length()
% % % 	sub = gr.get('SUB_DICT').getItem(i);
% % %     CON_MP = sub.getr('CON_MP');
% % % 
% % %     g = OrdMxWU( ...
% % %         'ID', ['g ' sub.get('ID')], ...
% % %         'BAS', ba, ...
% % %         'B', Callback('EL', sub, 'TAG', 'CON_MP') ...
% % %         );
% % %     g_dict.add(g)
% % %     
% % %     if isa(a.getr('TEMPLATE'), 'NoValue')
% % %         g.set('TEMPLATE', a.memorize('GRAPH_TEMPLATE'))
% % %     else
% % %         g.set('TEMPLATE', a.get('TEMPLATE').memorize('GRAPH_TEMPLATE'))
% % %     end
% % % end
% % % 
% % % value = g_dict;

%%% ¡prop!
ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
%%%% ¡_gui!
% % % pr = PPAnalyzeEnsembleMP_ME_DICT('EL', a, 'PROP', AnalyzeEnsemble_CON_MP_WU.ME_DICT, 'WAITBAR', true, varargin{:});

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
if ~isfile([fileparts(which('SubjectCON_MP')) filesep 'Example data CON_MP XLS' filesep 'atlas.xlsx'])
    test_ImporterGroupSubjectCON_MP_XLS % create example files
end

example_CON_OMP_WU