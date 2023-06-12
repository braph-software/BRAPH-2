%% ¡header!
AnalyzeGroup_CON_MP_GA_WU < AnalyzeGroup (a, group-based graph analysis with connectivity multiplex data) is a graph analysis using connectivity multiplex data.

%% ¡description!
This graph analysis uses connectivity multiplex data and analyzes them using weighted undirected graphs,
binary undirected multigraphs with fixed thresholds,
or binary undirected multigraphs with fixed densities.

%%% ¡seealso!
SubjectCON_MP, MultiplexWU.

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the group-based graph analysis with connectivity multiplex data.
%%%% ¡default!
'AnalyzeGroup_CON_MP_GA_WU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the group-based graph analysis with connectivity multiplex data.
%%%% ¡default!
'This graph analysis uses connectivity multiplex data and analyzes them using weighted undirected graphs, binary undirected multigraphs with fixed thresholds, or binary undirected multigraphs with fixed densities.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the group-based graph analysis with connectivity multiplex data.

%%% ¡prop!
ID (data, string) is a few-letter code for the group-based graph analysis with connectivity multiplex data.
%%%% ¡default!
'AnalyzeGroup_CON_MP_GA_WU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the group-based graph analysis with connectivity multiplex data.
%%%% ¡default!
'AnalyzeGroup_CON_MP_GA_WU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the group-based graph analysis with connectivity multiplex data.
%%%% ¡default!
'AnalyzeGroup_CON_MP_GA_WU notes'










%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON_MP.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_MP')

%%% ¡prop!
G (result, item) is the average graph (MultiplexWU) obtained from this analysis.
%%%% ¡settings!
'MultiplexWU'
%%%% ¡default!
MultiplexWU()
%%%% ¡calculate!
gr = a.get('GR');
subjects_number = gr.get('SUB_DICT').length();

ba = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && subjects_number > 0
    ba = gr.get('SUB_DICT').getItem(1).get('BA');
end

A_conmp = cell(1, 2);
for i = 1:1:subjects_number
    sub = gr.get('SUB_DICT').getItem(i);
    CON_MP = sub.getr('CON_MP');
    L = sub.get('L');
    
    for j = 1:1:L
        data = CON_MP{j};
        
        if i == 1
            A_conmp(j) = {data};
        else
            A_conmp(j) = {A_conmp{j} + data};
        end
    end
end

L = length(A_conmp);
g = MultiplexWU( ...
    'ID', ['g ' gr.get('ID')], ...
    'B', cellfun(@(a) a/subjects_number, A_conmp, 'UniformOutput', false), ... % % % 'LAYERTICKS', [1:1:L], ...
    'LAYERLABELS', cell2str(cellfun(@(x) ['L' num2str(x)], num2cell([1:1:L]), 'UniformOutput', false)), ...
    'BAS', ba ...
    );
value = g;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_CON_MP_GA_WU