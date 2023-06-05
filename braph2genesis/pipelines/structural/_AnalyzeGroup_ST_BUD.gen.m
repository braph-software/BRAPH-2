%% ¡header!
AnalyzeGroup_ST_BUD < AnalyzeGroup (a, graph analysis with structural data at fixed density) is a graph analysis using structural data at fixed density.

%% ¡description!
AnalyzeGroup_ST_BUD uses structural data at fixed density and analyzes them using binary undirected graphs.

%%% ¡seealso!
SubjectST, MultigraphBUD.

%% ¡props_update!


%%% ¡prop!
NAME (constant, string) is the name of the group-based graph analysis with structural data at fixed density.
%%%% ¡default!
'AnalyzeGroup_ST_BUD'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the group-based graph analysis with structural data at fixed density.
%%%% ¡default!
'AnalyzeGroup_ST_BUD uses structural data at fixed density and analyzes them using binary undirected graphs.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the group-based graph analysis with structural data at fixed density.

%%% ¡prop!
ID (data, string) is a few-letter code for the group-based graph analysis with structural data at fixed density.
%%%% ¡default!
'AnalyzeGroup_ST_BUD ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the group-based graph analysis with structural data at fixed density.
%%%% ¡default!
'AnalyzeGroup_ST_BUD label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the group-based graph analysis with structural data at fixed density.
%%%% ¡default!
'AnalyzeGroup_ST_BUD notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectST.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST')

%%% ¡prop!
G (result, item) is the graph obtained from this analysis.
%%%% ¡settings!
'MultigraphBUD'
%%%% ¡calculate!
gr = a.get('GR');
% % % node_labels = '';
data_list = cellfun(@(x) x.get('ST'), gr.get('SUB_DICT').get('IT_LIST'), 'UniformOutput', false);
data = cat(2, data_list{:})'; % correlation is a column based operation

% % % atlas = BrainAtlas();
% % % if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0
% % %     atlas = gr.get('SUB_DICT').getItem(1).get('BA');
% % % end

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
    A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'));
% % % end

densities = a.get('DENSITIES'); % this is a vector

g = MultigraphBUD( ...
    'ID', ['g ' gr.get('ID')], ...
    'B', A, ...
    'DENSITIES', densities ... % % %     'LAYERTICKS', densities, ... % % %     'LAYERLABELS', cell2str(cellfun(@(x) [num2str(x) '%'], num2cell(densities), 'UniformOutput', false)), ... % % %     'BAS', atlas ...
    );

% % % if ~isa(a.getr('TEMPLATE'), 'NoValue')
% % %     g.set('TEMPLATE', a.get('TEMPLATE').memorize('G'))
% % % end    

value = g;

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

%%% ¡prop!
DENSITIES (parameter, rvector) is the vector of densities.
%%%% ¡default!
[1:1:10]
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', a, 'PROP', AnalyzeGroup_ST_BUD.DENSITIES, ...
    'MIN', 0, 'MAX', 100, ...
    'DEFAULT', AnalyzeGroup_ST_BUD.getPropDefault('DENSITIES'), ...
    varargin{:});

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
if ~isfile([fileparts(which('example_ST_WU')) filesep 'Example data ST XLS' filesep 'atlas.xlsx'])
    test_ImporterGroupSubjectST_XLS % create example files
end

example_ST_BUD