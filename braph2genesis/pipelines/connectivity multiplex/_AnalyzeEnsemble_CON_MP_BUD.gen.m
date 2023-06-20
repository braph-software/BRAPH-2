%% ¡header!
AnalyzeEnsemble_CON_MP_BUD < AnalyzeEnsemble (a, graph analysis with connectivity multiplex data of fixed density) is an ensemble-based graph analysis using connectivity multiplex data of fixed density.

%%% ¡description!
This graph analysis (AnalyzeEnsemble_CON_MP_BUD) analyzes connectivity multiplex data 
using binary undirected multigraphs with fixed densities.

%%% ¡seealso!
SubjectCON_MP, MultiplexBUD

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the ensemble-based graph analysis with connectivity multiplex data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_CON_MP_BUD'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis with connectivity multiplex data of fixed density.
%%%% ¡default!
'This graph analysis (AnalyzeEnsemble_CON_MP_BUD) analyzes connectivity multiplex data using binary undirected multigraphs with fixed densities.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis with connectivity multiplex data of fixed density.

%%% ¡prop!
ID (data, string) is a few-letter code for the ensemble-based graph analysis with connectivity multiplex data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_CON_MP_BUD ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ensemble-based graph analysis with connectivity multiplex data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_CON_MP_BUD label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis with connectivity multiplex data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_CON_MP_BUD notes'













%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON_MP.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_MP')

%%% ¡prop!
ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
%%%% ¡gui_!
% % % pr = PPAnalyzeEnsembleMP_ME_DICT('EL', a, 'PROP', AnalyzeEnsemble_CON_MP_BUD.ME_DICT, 'WAITBAR', true, varargin{:});

%%% ¡prop!
G_DICT (result, idict) is the graph (MultiplexBUD) ensemble obtained from this analysis.
%%%% ¡settings!
'MultiplexBUD'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'MultiplexBUD')
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'MultiplexBUD');
gr = a.get('GR');
node_labels = '';

ba = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0    
    ba = gr.get('SUB_DICT').getItem(1).get('BA');
end

densities = a.get('DENSITIES'); % this is a vector
for i = 1:1:gr.get('SUB_DICT').length()
	sub = gr.get('SUB_DICT').getItem(i);
    
    g = MultiplexBUD( ...
        'ID', ['g ' sub.get('ID')], ...
        'B', Callback('EL', sub, 'TAG', 'CON_MP'), ...
        'DENSITIES', densities, ...
        'BAS', ba ...
        );
    g_dict.add(g)

    if isa(a.getr('TEMPLATE'), 'NoValue')
        g.set('TEMPLATE', a.memorize('GRAPH_TEMPLATE'))        
    else
        g.set('TEMPLATE', a.get('TEMPLATE').memorize('GRAPH_TEMPLATE'))
    end
end

value = g_dict;

%% ¡props!

%%% ¡prop!
DENSITIES (parameter, rvector) is the vector of densities.
%%%% ¡default!
[1:1:10]
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', a, 'PROP', AnalyzeEnsemble_CON_MP_BUD.DENSITIES, ...
    'MIN', 0, 'MAX', 100, ...
    'DEFAULT', AnalyzeEnsemble_CON_MP_BUD.getPropDefault('DENSITIES'), ...
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

example_CON_MP_BUD