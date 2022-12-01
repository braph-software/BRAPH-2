%% ¡header!
AnalyzeGroup_ST_RawData < AnalyzeGroup (a, graph analysis with structural data) is a graph analysis using structural data.

%% ¡description!
This graph analysis uses structural data and analyzes them using weighted undirected graphs,
binary undirected multigraphs with fixed thresholds,
or binary undirected multigraphs with fixed densities.

%% ¡props!

%%% ¡prop!
AVERAGE (result, matrix) is the group  average.
%%%% ¡calculate!
gr = a.get('GR');
data_list = cellfun(@(x) x.get('ST'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
data = cat(2, data_list{:})'; 
value = mean(data, 2);

%%% ¡prop!
STD (result, matrix) is the group  std.
%%%% ¡calculate!
gr = a.get('GR');
data_list = cellfun(@(x) x.get('ST'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
data = cat(2, data_list{:})'; 
value = std(data);


%% ¡props_update!

%%% ¡prop!
TEMPLATE (parameter, item) is the analysis template to set the parameters.
%%%% ¡settings!
'AnalyzeGroup_ST_RawData'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectST.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST')

%%% ¡prop!
G (result, item) is the graph obtained from this analysis.
%%%% ¡settings!
'GraphP'
%%%% ¡default!
GraphP()
%%%% ¡calculate!
gr = a.get('GR');
data_list = cellfun(@(x) x.get('ST'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
data = cat(2, data_list{:})'; % correlation is a column based operation
A= data;

ba = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0
    ba = gr.get('SUB_DICT').getItem(1).get('BA');
end

g = GraphP( ...
    'ID', ['g ' gr.get('ID')], ...
    'B', A, ...
    'BAS', ba ...
    );

if ~isa(a.getr('TEMPLATE'), 'NoValue')
    g.set('TEMPLATE', a.get('TEMPLATE').memorize('G'))
end    

value = g;