%% ¡header!
AnalyzeEnsemble_CON_MP_BUD < AnalyzeEnsemble (a, graph analysis with connectivity multiplex data of fixed density) is a graph analysis using connectivity multiplex data of fixed density.

%% ¡description!
This graph analysis uses connectivity multiplex data of fixed density and 
analyzes them using binary undirected graphs.

%%% ¡seealso!
AnalyzeGroup_CON_MP_BUT, AnalyzeGroup_CON_MP_WU, SubjectCON_MP, MultiplexBUD.

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

%% ¡props_update!

%%% ¡prop!
TEMPLATE (parameter, item) is the analysis template to set the parameters.
%%%% ¡settings!
'AnalyzeEnsemble_CON_MP_BUD'

%%% ¡prop!
GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
%%%% ¡settings!
'MultiplexBUD'
%%%% ¡postprocessing!
if ~braph2_testing
    if isa(a.getr('GRAPH_TEMPLATE'), 'NoValue')
        a.set('GRAPH_TEMPLATE', MultiplexBUD('DENSITIES',  Callback('EL', a, 'TAG', 'DENSITIES')))

        if a.get('GR').get('SUB_DICT').length() > 0
            a.get('GRAPH_TEMPLATE').set('BAS', a.get('GR').get('SUB_DICT').getItem(1).get('BA'))
        end
    end
    if a.get('GR').get('SUB_DICT').length() > 0
        L = a.get('GR').get('SUB_DICT').getItem(1).get('L');  % number of layers
        densities = a.get('DENSITIES');
        layerlabels = {};
        
        for i = 1:length(densities)
            layerlabels = [layerlabels, cellfun(@(x) ['L' num2str(x) ' ' num2str(densities(i)) '%'], num2cell(1:L), 'UniformOutput', false)];
        end

        a.get('GRAPH_TEMPLATE').set('LAYERLABELS', cell2str(layerlabels))
        a.get('GRAPH_TEMPLATE').set('LAYERTICKS', densities)
    end
end

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

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% % % example_CON_MP_BUD