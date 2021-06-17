%% ¡header!
AnalyzeEnsemble_CON_BUT < AnalyzeEnsemble (a, graph analysis with connectivity data of fixed threshold) is a graph analysis using connectivity data of fixed threshold.

%% ¡description!
This graph analysis uses connectivity data and analyzes them using
binary undirected multigraphs with fixed thresholds.

%%% ¡seealso!
AnalyzeEnsemble_CON_WU, Subject_CON, MultigraphBUT.

%% ¡props!

%%% ¡prop!
THRESHOLDS (parameter, rvector) is the vector of thresholds.
%%%% ¡default!
0

%% ¡props_update!

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON')

%%% ¡prop!
G_DICT (result, idict) is the graph (MultigraphBUT) ensemble obtained from this analysis.
%%%% ¡settings!
'MultigraphBUT'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'MultigraphBUT')
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'MultigraphBUT');
node_labels = '';
gr = a.get('GR');
thresholds = a.get('THRESHOLDS');

if ~isempty(gr) && ~isa(gr, 'NoValue')   
    node_dict = gr.get('SUB_DICT').getItem(1).get('BA').get('BR_DICT');
    node_labels_tmp = cellfun(@(x) x.get('ID') , node_dict.getItems(), 'UniformOutput', false);
    % i have to transform the labels to a string because we dont have a format
    % for a cell of strings.
    for i = 1:length(node_labels_tmp)
        node_labels = [node_labels ',' node_labels_tmp{i}];
    end
    node_labels = node_labels(2:end);
end

for i = 1:1:gr.get('SUB_DICT').length()
	sub = gr.get('SUB_DICT').getItem(i);
    g = MultigraphBUT( ...
        'ID', ['g ' sub.get('ID')], ...
        'B', Callback('EL', sub, 'TAG', 'CON'), ...
        'THRESHOLDS', thresholds, ...
        'NODELABELS', node_labels ...
        );
    g_dict.add(g)
end

value = g_dict;
%%%% ¡gui!
pl = PPAnalyzeEnsembleGraph('EL', a, 'PROP', AnalyzeEnsemble_CON_BUT.G_DICT, varargin{:});

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_CON_BUT