%% ¡header!
AnalyzeGroup_ST_MP_BUT < AnalyzeGroup (a, graph analysis with structural multiplex data of fixed threshold) is a graph analysis using structural multiplex data of fixed threshold.

%% ¡description!
This graph analysis uses structural multiplex data of fixed threshold and 
analyzes them using binary undirected graphs.

%%% ¡seealso!
AnalyzeGroup_ST_MP_WU, AnalyzeGroup_ST_MP_BUD, Subject_ST_MP, MultiplexBUT.

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
pr = PanelPropRVectorSmart('EL', a, 'PROP', AnalyzeGroup_ST_BUD.DENSITIES, ...
    'MIN', -1, 'MAX', 1, ...
    'DEFAULT', AnalyzeGroup_ST_BUT.getPropDefault('THRESHOLDS'), ...
    varargin{:});

%% ¡props_update!

%%% ¡prop!
TEMPLATE (parameter, item) is the analysis template to set the parameters.
%%%% ¡settings!
'AnalyzeGroup_ST_MP_BUT'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectST_MP.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST_MP')

%%% ¡prop!
G (result, item) is the graph obtained from this analysis.
%%%% ¡settings!
'MultiplexBUT'
%%%% ¡default!
MultiplexBUT()
%%%% ¡calculate!
gr = a.get('GR');
data_list = cellfun(@(x) x.get('ST_MP'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
atlas = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0
    atlas = gr.get('SUB_DICT').getItem(1).get('BA');
end

if any(strcmp(a.get('CORRELATION_RULE'), {Correlation.PEARSON_CV, Correlation.SPEARMAN_CV}))
    age_list = cellfun(@(x) x.get('age'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
    age = cat(2, age_list{:})';
    sex_list = cellfun(@(x) x.get('sex'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
    sex = zeros(size(age));
    for i=1:length(sex_list)
        switch lower(sex_list{i})
            case 'female'
                sex(i) = 1;
            case 'male'
                sex(i) = -1;
            otherwise
                sex(i) = 0;
        end
    end
    covariates = [age, sex];
end

if isempty(data_list)
    layerlabels = {'', ''};
    A ={[], []};
else
    L = gr.get('SUB_DICT').getItem(1).get('L');  % number of layers
    br_number = gr.get('SUB_DICT').getItem(1).get('ba').get('BR_DICT').length();  % number of regions
    data = cell(L, 1);
    for i=1:L
        data_layer = zeros(length(data_list), br_number);
        for j=1:length(data_list)
            sub_cell = data_list{j};
            data_layer(j, :) = sub_cell{i}';
        end
        data(i) = {data_layer};
    end
    
    layerlabels = {};
    A = cell(1, L);
    thresholds = a.get('THRESHOLDS'); 
    for i = 1:length(thresholds)
        layerlabels = [layerlabels, cellfun(@(x) ['L' num2str(x) ' ' num2str(thresholds(i))], num2cell(1:L), 'UniformOutput', false)];
    end
    for i = 1:L
        if any(strcmp(a.get('CORRELATION_RULE'), {Correlation.PEARSON_CV, Correlation.SPEARMAN_CV}))
            A(i) = {Correlation.getAdjacencyMatrix(data{i}, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'), covariates)};
        else
            A(i) = {Correlation.getAdjacencyMatrix(data{i}, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'))};
        end
    end
end
thresholds = a.get('THRESHOLDS'); % this is a vector

g = MultiplexBUT( ...
    'ID', ['g ' gr.get('ID')], ...
    'B', A, ...
    'THRESHOLDS', thresholds, ... 
    'LAYERTICKS', thresholds, ...
    'LAYERLABELS', cell2str(layerlabels), ...
    'BAS', atlas ...
    );

value = g;
%%%% ¡gui_!
% % % pr = PPAnalyzeGroupMP_G('EL', a, 'PROP', AnalyzeGroup_ST_MP_BUT.G, 'WAITBAR', true, varargin{:});

% % % %% ¡methods!
% % % function pr = getPPCompareGroup_CPDict(a, varargin) 
% % %     %GEPPPCOMPAREGROUP_CPDICT returns the comparison plot panel compatible with the analysis.
% % %     %
% % %     % PR = GEPPPCOMPAREGROUP_CPDICT(A) returns the comparison plot panel
% % %     %  that is compatible with the analyze group.
% % %     %
% % %     % See also CompareGroup.
% % %     
% % %     pr = PPCompareGroup_CPDict_ST_MP_BUT(varargin{:});
% % % end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_ST_MP_BUT