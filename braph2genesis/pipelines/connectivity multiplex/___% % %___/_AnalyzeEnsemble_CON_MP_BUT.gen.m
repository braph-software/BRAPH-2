%% ¡header!
AnalyzeEnsemble_CON_MP_BUT < AnalyzeEnsemble (a, graph analysis with connectivity multiplex data of fixed threshold) is an ensemble-based graph analysis using connectivity multiplex data of fixed threshold.

%%% ¡description!
This graph analysis (AnalyzeEnsemble_CON_MP_BUT) analyzes connectivity multiplex data 
using binary undirected multigraphs with fixed thresholds.

%%% ¡seealso!
SubjectCON_MP, MultiplexBUT

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the ensemble-based graph analysis with connectivity multiplex data of fixed threshold.
%%%% ¡default!
'AnalyzeEnsemble_CON_MP_BUT'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis with connectivity multiplex data of fixed threshold.
%%%% ¡default!
'This graph analysis (AnalyzeEnsemble_CON_MP_BUT) analyzes connectivity multiplex data using binary undirected multigraphs with fixed thresholds.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis with connectivity multiplex data of fixed threshold.
%%%% ¡settings!
'AnalyzeEnsemble_CON_MP_BUT'

%%% ¡prop!
ID (data, string) is a few-letter code for the ensemble-based graph analysis with connectivity multiplex data of fixed threshold.
%%%% ¡default!
'AnalyzeEnsemble_CON_MP_BUT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ensemble-based graph analysis with connectivity multiplex data of fixed threshold.
%%%% ¡default!
'AnalyzeEnsemble_CON_MP_BUT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis with connectivity multiplex data of fixed threshold.
%%%% ¡default!
'AnalyzeEnsemble_CON_MP_BUT notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON_MP.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_MP')

%%% ¡prop!
GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
%%%% ¡settings!
'MultiplexBUT'

%%% ¡prop!
G_DICT (result, idict) is the graph (MultiplexBUT) ensemble obtained from this analysis.
%%%% ¡settings!
'MultiplexBUT'
%%%% ¡_default!
% % % IndexedDictionary('IT_CLASS', 'MultiplexBUT')
%%%% ¡_calculate!
% % % g_dict = IndexedDictionary('IT_CLASS', 'MultiplexBUT');
% % % gr = a.get('GR');
% % % node_labels = '';
% % % 
% % % ba = BrainAtlas();
% % % if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0 
% % %     ba = gr.get('SUB_DICT').getItem(1).get('BA');
% % % end
% % % 
% % % thresholds = a.get('THRESHOLDS'); % this is a vector
% % % for i = 1:1:gr.get('SUB_DICT').length()
% % % 	sub = gr.get('SUB_DICT').getItem(i);
% % %     
% % %     g = MultiplexBUT( ...
% % %         'ID', ['g ' sub.get('ID')], ...
% % %         'B', Callback('EL', sub, 'TAG', 'CON_MP'), ...
% % %         'THRESHOLDS', thresholds, ...
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

%%% ¡prop!
ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
%%%% ¡_gui!
% % % pr = PPAnalyzeEnsembleMP_ME_DICT('EL', a, 'PROP', AnalyzeEnsemble_CON_MP_BUT.ME_DICT, 'WAITBAR', true, varargin{:});

%% ¡props!

%%% ¡prop!
THRESHOLDS (parameter, rvector) is the vector of thresholds.
%%%% ¡default!
[-1:.5:1]
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', a, 'PROP', AnalyzeEnsemble_CON_MP_BUT.THRESHOLDS, ...
    'MIN', -1, 'MAX', 1, ...
    'DEFAULT', AnalyzeEnsemble_CON_MP_BUT.getPropDefault('THRESHOLDS'), ...
    varargin{:});

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

example_CON_MP_BUT