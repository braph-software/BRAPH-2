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
%%%% ¡gui!
pr = PlotPropSmartVector('EL', a, 'PROP', AnalyzeEnsemble_CON_BUT.THRESHOLDS, 'MAX', 1, 'MIN', 0, varargin{:});

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
atlas = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0 
    atlas = gr.get('SUB_DICT').getItem(1).get('BA');
end

for i = 1:1:gr.get('SUB_DICT').length()
	sub = gr.get('SUB_DICT').getItem(i);
    g = MultigraphBUT( ...
        'ID', ['g ' sub.get('ID')], ...
        'B', Callback('EL', sub, 'TAG', 'CON'), ...
        'THRESHOLDS', thresholds, ...
        'BRAINATLAS', atlas ...
        );
    g_dict.add(g)
end

value = g_dict;

%% ¡methods!
function pr = getPPCompareEnsemble_CPDict(a, varargin) 
    %GETPPCOMPAREENSEMBLE_CPDICT returns the comparison ensemble plot panel compatible with the analysis.
    %
    % PR = GETPPCOMPAREENSEMBLE_CPDICT(A) returns the comparison ensemble plot panel
    %  that is compatible with the analyze ensemble.
    %
    % See also CompareEnsemble.
    
    pr = PPCompareEnsemble_CPDict_BUT(varargin{:});
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_CON_BUT