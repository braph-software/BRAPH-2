%% ¡header!
AnalyzeGroup_ST_BUT < AnalyzeGroup (a, graph analysis with structural data at fixed threshold) is a graph analysis using structural data at fixed threshold.

%% ¡description!
AnalyzeGroup_ST_BUT uses structural data at fixed threshold and analyzes them using binary undirected graphs.

%%% ¡seealso!
SubjectST, MultigraphBUT

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the group-based graph analysis with structural data at fixed threshold.
%%%% ¡default!
'AnalyzeGroup_ST_BUT'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the group-based graph analysis with structural data at fixed threshold.
%%%% ¡default!
'AnalyzeGroup_ST_BUT uses structural data at fixed threshold and analyzes them using binary undirected graphs.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the group-based graph analysis with structural data at fixed threshold.

%%% ¡prop!
ID (data, string) is a few-letter code for the group-based graph analysis with structural data at fixed threshold.
%%%% ¡default!
'AnalyzeGroup_ST_BUT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the group-based graph analysis with structural data at fixed threshold.
%%%% ¡default!
'AnalyzeGroup_ST_BUT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the group-based graph analysis with structural data at fixed threshold.
%%%% ¡default!
'AnalyzeGroup_ST_BUT notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectST.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST')

%%% ¡prop!
G (result, item) is the graph obtained from this analysis.
%%%% ¡settings!
'MultigraphBUT'
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

thresholds = a.get('THRESHOLDS'); 
            
g = MultigraphBUT( ...
    'ID', ['g ' gr.get('ID')], ...
    'B', A, ...
	'THRESHOLDS', thresholds ... % % %     'LAYERTICKS', thresholds, ... % % %     'LAYERLABELS', cell2str(cellfun(@(x) num2str(x), num2cell(thresholds), 'UniformOutput', false)), ... % % %     'BAS', atlas ...
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
THRESHOLDS (parameter, rvector) is the vector of thresholds.
%%%% ¡default!
[-1:.5:1]
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', a, 'PROP', AnalyzeGroup_ST_BUT.THRESHOLDS, ...
    'MIN', -1, 'MAX', 1, ...
    'DEFAULT', AnalyzeGroup_ST_BUT.getPropDefault('THRESHOLDS'), ...
    varargin{:});

%% ¡tests!

% % % %%% ¡test!
% % % %%%% ¡name!
% % % Example
% % % %%%% ¡code!
% % % example_ST_BUT