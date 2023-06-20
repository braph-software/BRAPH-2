%% ¡header!
AnalyzeEnsemble_CON_BUD < AnalyzeEnsemble (a, graph analysis with connectivity data of fixed density) is an ensemble-based graph analysis using connectivity data of fixed density.

%%% ¡description!
This ensemble-based graph analysis (AnalyzeEnsemble_CON_BUD) analyzes 
connectivity data using binary undirected multigraphs with fixed densities.

%%% ¡seealso!
SubjectCON, MultigraphBUD

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the ensenmble-based graph analysis using connectivity data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_CON_BUD'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ensenmble-based graph analysis using connectivity data of fixed density.
%%%% ¡default!
'This ensemble-based graph analysis (AnalyzeEnsemble_CON_BUD) analyzes connectivity data using binary undirected multigraphs with fixed densities.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ensenmble-based graph analysis using connectivity data of fixed density.

%%% ¡prop!
ID (data, string) is a few-letter code for the ensenmble-based graph analysis using connectivity data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_CON_BUD ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ensenmble-based graph analysis using connectivity data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_CON_BUD label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ensenmble-based graph analysis using connectivity data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_CON_BUD notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON')

%%% ¡prop!
ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
%%%% ¡_gui!
% % % pr = PPAnalyzeEnsemble_ME_DICT('EL', a, 'PROP', AnalyzeEnsemble_CON_BUD.ME_DICT, 'WAITBAR', true, varargin{:});

%%% ¡prop!
G_DICT (result, idict) is the graph (MultigraphBUD) ensemble obtained from this analysis.
%%%% ¡settings!
'MultigraphBUD'
%%%% ¡_default!
% % % IndexedDictionary('IT_CLASS', 'MultigraphBUD')
%%%% ¡_calculate!
% % % g_dict = IndexedDictionary('IT_CLASS', 'MultigraphBUD');
% % % gr = a.get('GR');
% % % densities = a.get('DENSITIES');
% % % node_labels = '';
% % % 
% % % ba = BrainAtlas();
% % % if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0
% % %     ba = gr.get('SUB_DICT').getItem(1).get('BA');
% % % end
% % % 
% % % for i = 1:1:gr.get('SUB_DICT').length()
% % % 	sub = gr.get('SUB_DICT').getItem(i);
% % %     g = MultigraphBUD( ...
% % %         'ID', ['g ' sub.get('ID')], ...
% % %         'B', Callback('EL', sub, 'TAG', 'CON'), ...
% % %         'LAYERTICKS', densities, ...
% % %         'BAS', ba ...
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

%% ¡props!

%%% ¡prop!
DENSITIES (parameter, rvector) is the vector of densities.
%%%% ¡default!
[1:1:10]
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', a, 'PROP', AnalyzeEnsemble_CON_BUD.DENSITIES, ...
    'MIN', 0, 'MAX', 100, ...
    'DEFAULT', AnalyzeEnsemble_CON_BUD.getPropDefault('DENSITIES'), ...
    varargin{:});

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

example_CON_BUD