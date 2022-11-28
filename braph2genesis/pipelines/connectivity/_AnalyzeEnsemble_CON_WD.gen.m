%% ¡header!
AnalyzeEnsemble_CON_WD < AnalyzeEnsemble (a, graph analysis with connectivity data) is a graph analysis using connectivity data.

%% ¡description!
This graph analysis uses connectivity data and analyzes them using weighted directed graphs.

%% ¡props_update!

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON')

%%% ¡prop!
ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
%%%% ¡gui!
pr = PPAnalyzeEnsemble_ME_DICT('EL', a, 'PROP', AnalyzeEnsemble_CON_WD.ME_DICT, 'WAITBAR', true, varargin{:});

%%% ¡prop!
G_DICT (result, idict) is the graph (GraphWD) ensemble obtained from this analysis.
%%%% ¡settings!
'GraphWD'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'GraphWD')
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'GraphWD');
gr = a.get('GR');
atlas = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0 
    atlas = gr.get('SUB_DICT').getItem(1).get('BA');
end
gr = a.get('GR');
for i = 1:1:gr.get('SUB_DICT').length()
	sub = gr.get('SUB_DICT').getItem(i);
    g = GraphWD( ...
        'ID', ['g ' sub.get('ID')], ...
        'BRAINATLAS', atlas, ...
        'B', Callback('EL', sub, 'TAG', 'CON') ...
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
    
    pr = PPCompareEnsemble_CPDict_WD(varargin{:});
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_CON_WD