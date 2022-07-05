%% ¡header!
AnalyzeEnsemble_CON_BUD < AnalyzeEnsemble (a, graph analysis with connectivity data of fixed density) is a graph analysis using connectivity data of fixed density.

%% ¡description!
This graph analysis uses connectivity data and analyzes them using
binary undirected multigraphs with fixed densities.

%%% ¡seealso!
AnalyzeEnsemble_CON_WU, Subject_CON, MultigraphBUD.

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

%% ¡props_update!

%%% ¡prop!
TEMPLATE (parameter, item) is the analysis template to set the parameters.
%%%% ¡settings!
'AnalyzeEnsemble_CON_BUD'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON')

%%% ¡prop!
ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
%%%% ¡gui_!
% % % pr = PPAnalyzeEnsemble_ME_DICT('EL', a, 'PROP', AnalyzeEnsemble_CON_BUD.ME_DICT, 'WAITBAR', true, varargin{:});

%%% ¡prop!
G_DICT (result, idict) is the graph (MultigraphBUD) ensemble obtained from this analysis.
%%%% ¡settings!
'MultigraphBUD'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'MultigraphBUD')
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'MultigraphBUD');
gr = a.get('GR');
densities = a.get('DENSITIES');
node_labels = '';

ba = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0
    ba = gr.get('SUB_DICT').getItem(1).get('BA');
end

for i = 1:1:gr.get('SUB_DICT').length()
	sub = gr.get('SUB_DICT').getItem(i);
    g = MultigraphBUD( ...
        'ID', ['g ' sub.get('ID')], ...
        'B', Callback('EL', sub, 'TAG', 'CON'), ...
        'DENSITIES', densities, ...
        'BAS', ba ...
        );
    g_dict.add(g)
end

value = g_dict;

% % % %% ¡methods!
% % % function pr = getPPCompareEnsemble_CPDict(a, varargin) 
% % %     %GETPPCOMPAREENSEMBLE_CPDICT returns the comparison ensemble plot panel compatible with the analysis.
% % %     %
% % %     % PR = GETPPCOMPAREENSEMBLE_CPDICT(A) returns the comparison ensemble plot panel
% % %     %  that is compatible with the analyze ensemble.
% % %     %
% % %     % See also CompareEnsemble.
% % %     
% % %     pr = PPCompareEnsemble_CPDict_BUD(varargin{:});
% % % end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_CON_BUD