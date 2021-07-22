%% ¡header!
AnalyzeGroup_CON_WU < AnalyzeGroup (a, graph analysis with connectivity data) is a graph analysis using connectivity data.

%% ¡description!
This graph analysis uses connectivity data and analyzes them using weighted undirected graphs,
binary undirected multigraphs with fixed thresholds,
or binary undirected multigraphs with fixed densities.

%% ¡props_update!

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON')

%%% ¡prop!
G (result, idict) is the average graph obtained from this analysis.
%%%% ¡settings!
'GraphWU'
%%%% ¡default!
GraphWU()
%%%% ¡calculate!
gr = a.get('GR');

for i = 1:1:gr.get('SUB_DICT').length()
	sub = gr.get('SUB_DICT').getItem(i);

    if i == 1
        A = sub.get('CON');
    else
        A = A + sub.get('CON');
    end
end

g = GraphWU( ...
    'ID', ['g ' gr.get('ID')], ...
    'B', A/gr.get('SUB_DICT').length() ...
    );
value = g;
%%%% ¡gui!
pl = PPAnalyzeGroupGraph('EL', a, 'PROP', AnalyzeGroup_CON_WU.G, varargin{:});

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_CON_WU_Group