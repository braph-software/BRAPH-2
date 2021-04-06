%% ¡header!
AnalysisCON < Analysis (a, graph analysis with connectivity data) is a graph analysis using connectivity data.

%% ¡description!
This graph analysis uses connectivity data and analyzes them using weighted undirected graphs,
binary undirected multigraphs with fixed thresholds,
or binary undirected multigraphs with fixed densities.

%% ¡props!

%%% ¡prop!
G_CLASS (parameter, option) is the graph class.
%%%% ¡settings!
{'GraphWUEnsemble', 'MultigraphBUTEnsemble', 'MultigraphBUDEnsemble'}

%%% ¡prop!
THRESHOLDS (data, rvector) is the vector of thresholds.

%%% ¡prop!
DENSITIES (data, rvector) is the vector of densities.

%% ¡props_update!

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON')

%%% ¡prop!
G (result, item) is the graph obtained from this analysis, it can be GraphWU, MultigraphBUT, or MultigraphBUD.
%%%% ¡settings!
'Graph'
%%%% ¡check_value!
check = any(strcmp(value.getClass(), a.getPropSettings('G_CLASS')));
%%%% ¡default!
GraphWUEnsemble()
%%%% ¡calculate!
ge = eval([a.get('G_CLASS') '()']);

gr = a.get('GR');
for i = 1:1:gr.get('SUB_DICT').length()
	sub = gr.get('SUB_DICT').getItem(i);
    switch ge.get('G_DICT').get('IT_CLASS')
        case 'GraphWU'
            g = GraphWU( ...
                'ID', ['g ' sub.get('ID')], ...
                'B', Callback('EL', sub, 'TAG', 'CON') ...
                );
        case 'MultigraphBUT'
            g = MultigraphBUTEnsemble( ...
                'ID', ['g ' sub.get('ID')], ...
                'THRESHOLDS', a.get('THRESHOLDS'), ...
                'B', Callback('EL', sub, 'TAG', 'CON') ...
                );
        case 'MultigraphBUD'
            g = MultigraphBUDEnsemble( ...
                'ID', ['g ' sub.get('ID')], ...
                'DENSITIES', a.get('DENSITIES'), ...
                'B', Callback('EL', sub, 'TAG', 'CON') ...
                );
    end
    ge.get('G_DICT').add(g)
end

value = ge;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_CON