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
ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
% % % %%%% ¡gui!
% % % % % % pr = PPAnalyzeEnsemble_ME_DICT('EL', a, 'PROP', AnalyzeEnsemble_CON_WU.ME_DICT, 'WAITBAR', true, varargin{:});

%%% ¡prop!
G_DICT (result, idict) is the graph (GraphWU) ensemble obtained from this analysis.
%%%% ¡settings!
'GraphWU'
% % % %%%% ¡default!
% % % IndexedDictionary('IT_CLASS', 'GraphWU')
% % % %%%% ¡calculate!
% % % g_dict = IndexedDictionary('IT_CLASS', 'GraphWU');
% % % gr = a.get('GR');
% % % 
% % % ba = BrainAtlas();
% % % if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0 
% % %     ba = gr.get('SUB_DICT').getItem(1).get('BA');
% % % end
% % % 
% % % gr = a.get('GR');
% % % for i = 1:1:gr.get('SUB_DICT').length()
% % % 	sub = gr.get('SUB_DICT').getItem(i);
% % %     g = GraphWU( ...
% % %         'ID', ['g ' sub.get('ID')], ...
% % %         'BAS', ba, ...
% % %         'B', Callback('EL', sub, 'TAG', 'CON') ...
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
% % % % % % %% ¡methods!
% % % % % % function pr = getPPCompareEnsemble_CPDict(a, varargin) 
% % % % % %     %GETPPCOMPAREENSEMBLE_CPDICT returns the comparison ensemble plot panel compatible with the analysis.
% % % % % %     %
% % % % % %     % PR = GETPPCOMPAREENSEMBLE_CPDICT(A) returns the comparison ensemble plot panel
% % % % % %     %  that is compatible with the analyze ensemble.
% % % % % %     %
% % % % % %     % See also CompareEnsemble.
% % % % % %     
% % % % % %     pr = PPCompareEnsemble_CPDict_WU(varargin{:});
% % % % % % end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
% % % example_CON_WU