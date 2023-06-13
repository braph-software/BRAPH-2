%% ¡header!
AnalyzeGroup_CON_GA_WU < AnalyzeGroup (a, graph analysis with averaged connectivity data) is a graph analysis using connectivity data averaged by group.

%% ¡description!
AnalyzeGroup_CON_GA_WU uses connectivity data averaged by group 
and analyzes them using weighted undirected graphs.

%% ¡seealso!
SubjectCON, GraphWU

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the graph analysis with averaged connectivity data.
%%%% ¡default!
'AnalyzeGroup_CON_GA_WU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the graph analysis with averaged connectivity data.
%%%% ¡default!
'AnalyzeGroup_CON_GA_WU uses connectivity data averaged by group and analyzes them using weighted undirected graphs.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the graph analysis with averaged connectivity data.

%%% ¡prop!
ID (data, string) is a few-letter code for the graph analysis with averaged connectivity data.
%%%% ¡default!
'AnalyzeGroup_CON_GA_WU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph analysis with averaged connectivity data.
%%%% ¡default!
'AnalyzeGroup_CON_GA_WU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph analysis with averaged connectivity data.
%%%% ¡default!
'AnalyzeGroup_CON_GA_WU notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON')

%%% ¡prop!
G (result, item) is the graph obtained from this analysis.
%%%% ¡settings!
'GraphWU'
%%%% ¡calculate!
gr = a.get('GR');
A = [];
for i = 1:1:gr.get('SUB_DICT').get('LENGTH')
	sub = gr.get('SUB_DICT').get('IT', i);

    if i == 1
        A = sub.get('CON');
    else
        A = A + sub.get('CON');
    end
end
A = A / gr.get('SUB_DICT').get('LENGTH')

% % % ba = BrainAtlas();
% % % if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0
% % %     ba = gr.get('SUB_DICT').get('IT', 1).get('BA');
% % % end

g = GraphWU( ...
    'ID', ['Graph ' gr.get('ID')], ...
    'B', A ... % % % 'BAS', ba ...
    );

value = g;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
if ~isfile([fileparts(which('test_ImporterGroupSubjectCON_XLS')) filesep 'Example data CON XLS' filesep 'atlas.xlsx'])
    test_ImporterGroupSubjectCON_XLS % create example files
end

example_CON_GA_WU