%% ¡header!
AnalyzeEnsemble_CON_BUT < AnalyzeEnsemble (a, graph analysis with connectivity data of fixed threshold) is an ensemble-based graph analysis using connectivity data of fixed threshold.

%%% ¡description!
This ensemble-based graph analysis (AnalyzeEnsemble_CON_BUT) analyzes 
connectivity data using binary undirected multigraphs with fixed thresholds.

%%% ¡seealso!
SubjectCON, MultigraphBUT

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the ensenmble-based graph analysis using connectivity data of fixed threshold.
%%%% ¡default!
'AnalyzeEnsemble_CON_BUT'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ensenmble-based graph analysis using connectivity data of fixed threshold.
%%%% ¡default!
'This ensemble-based graph analysis (AnalyzeEnsemble_CON_BUT) analyzes connectivity data using binary undirected multigraphs with fixed thresholds.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ensenmble-based graph analysis using connectivity data of fixed threshold.

%%% ¡prop!
ID (data, string) is a few-letter code for the ensenmble-based graph analysis using connectivity data of fixed threshold.
%%%% ¡default!
'AnalyzeEnsemble_CON_BUT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ensenmble-based graph analysis using connectivity data of fixed threshold.
%%%% ¡default!
'AnalyzeEnsemble_CON_BUT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ensenmble-based graph analysis using connectivity data of fixed threshold.
%%%% ¡default!
'AnalyzeEnsemble_CON_BUT notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON')

%%% ¡prop!
ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
%%%% ¡_gui!
% % % pr = PPAnalyzeEnsemble_ME_DICT('EL', a, 'PROP', AnalyzeEnsemble_CON_BUT.ME_DICT, 'WAITBAR', true, varargin{:});

%%% ¡prop!
G_DICT (result, idict) is the graph (MultigraphBUT) ensemble obtained from this analysis.
%%%% ¡settings!
'MultigraphBUT'
%%%% ¡_default!
% % % IndexedDictionary('IT_CLASS', 'MultigraphBUT')
%%%% ¡_calculate!
% % % g_dict = IndexedDictionary('IT_CLASS', 'MultigraphBUT');
% % % node_labels = '';
% % % gr = a.get('GR');
% % % thresholds = a.get('THRESHOLDS');
% % % 
% % % ba = BrainAtlas();
% % % if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0 
% % %     ba = gr.get('SUB_DICT').getItem(1).get('BA');
% % % end
% % % 
% % % for i = 1:1:gr.get('SUB_DICT').length()
% % % 	sub = gr.get('SUB_DICT').getItem(i);
% % %     g = MultigraphBUT( ...
% % %         'ID', ['g ' sub.get('ID')], ...
% % %         'B', Callback('EL', sub, 'TAG', 'CON'), ...
% % %         'LAYERTICKS', thresholds, ...  
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
THRESHOLDS (parameter, rvector) is the vector of thresholds.
%%%% ¡default!
[-1:.5:1]
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', a, 'PROP', AnalyzeEnsemble_CON_BUT.THRESHOLDS, ...
    'MIN', -1, 'MAX', 1, ...
    'DEFAULT', AnalyzeEnsemble_CON_BUT.getPropDefault('THRESHOLDS'), ...
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

example_CON_BUT