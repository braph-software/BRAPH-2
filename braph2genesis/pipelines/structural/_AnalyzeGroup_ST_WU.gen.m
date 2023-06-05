%% ¡header!
AnalyzeGroup_ST_WU < AnalyzeGroup (a, graph analysis with structural data) is a graph analysis using structural data.

%% ¡description!
AnalyzeGroup_ST_WU uses structural data and analyzes them using weighted undirected graphs.

%% ¡seealso!
SubjectST, GraphWU

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the group-based graph analysis with structural data.
%%%% ¡default!
'AnalyzeGroup_ST_WU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the group-based graph analysis with structural data.
%%%% ¡default!
'AnalyzeGroup_ST_WU uses structural data and analyzes them using weighted undirected graphs.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the group-based graph analysis with structural data.

%%% ¡prop!
ID (data, string) is a few-letter code for the group-based graph analysis with structural data.
%%%% ¡default!
'AnalyzeGroup_ST_WU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the group-based graph analysis with structural data.
%%%% ¡default!
'AnalyzeGroup_ST_WU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the group-based graph analysis with structural data.
%%%% ¡default!
'AnalyzeGroup_ST_WU notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectST.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST')

%%% ¡prop!
G (result, item) is the graph obtained from this analysis.
%%%% ¡settings!
'GraphWU'
%%%% ¡default!
GraphWU()
%%%% ¡_calculate!
% % % gr = a.get('GR');
% % % data_list = cellfun(@(x) x.get('ST'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
% % % data = cat(2, data_list{:})'; % correlation is a column based operation
% % % 
% % % if any(strcmp(a.get('CORRELATION_RULE'), {Correlation.PEARSON_CV, Correlation.SPEARMAN_CV}))
% % %     age_list = cellfun(@(x) x.get('age'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
% % %     age = cat(2, age_list{:})';
% % %     sex_list = cellfun(@(x) x.get('sex'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
% % %     sex = zeros(size(age));
% % %     for i=1:length(sex_list)
% % %         switch lower(sex_list{i})
% % %             case 'female'
% % %                 sex(i) = 1;
% % %             case 'male'
% % %                 sex(i) = -1;
% % %             otherwise
% % %                 sex(i) = 0;
% % %         end
% % %     end
% % %     A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'), [age, sex]);
% % % else
% % %     A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'));
% % % end
% % % 
% % % ba = BrainAtlas();
% % % if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0
% % %     ba = gr.get('SUB_DICT').getItem(1).get('BA');
% % % end
% % % 
% % % g = GraphWU( ...
% % %     'ID', ['g ' gr.get('ID')], ...
% % %     'B', A, ...
% % %     'BAS', ba ...
% % %     );
% % % 
% % % if ~isa(a.getr('TEMPLATE'), 'NoValue')
% % %     g.set('TEMPLATE', a.get('TEMPLATE').memorize('G'))
% % % end    
% % % 
% % % value = g;

%% ¡props!

%%% ¡prop!
CORRELATION_RULE (parameter, option) is the correlation type.
%%%% ¡settings!
Correlation.CORRELATION_RULE_LIST
%%%% ¡default!
Correlation.PEARSON

%%% ¡prop!
NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
%%%% ¡settings!
Correlation.NEGATIVE_WEIGHT_RULE_LIST
%%%% ¡default!
Correlation.ZERO

%% ¡tests!

% % % %%% ¡test!
% % % %%%% ¡name!
% % % Example
% % % %%%% ¡code!
% % % example_ST_WU