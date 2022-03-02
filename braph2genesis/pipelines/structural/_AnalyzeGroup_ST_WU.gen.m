%% ¡header!
AnalyzeGroup_ST_WU < AnalyzeGroup (a, graph analysis with structural data) is a graph analysis using structural data.

%% ¡description!
This graph analysis uses structural data and analyzes them using weighted undirected graphs,
binary undirected multigraphs with fixed thresholds,
or binary undirected multigraphs with fixed densities.

%% ¡props!

%%% ¡prop!
CORRELATION_RULE (parameter, option) is the correlation type.
%%%% ¡settings!
Correlation.CORRELATION_RULE_LIST
%%%% ¡default!
Correlation.CORRELATION_RULE_LIST{1}
%%%% ¡conditioning!
if ~(isequal(value, Correlation.CORRELATION_RULE_LIST{4}) || isequal(value, Correlation.CORRELATION_RULE_LIST{5})) % Pearson, Spearman, or Kendall
    a.set('USE_COVARIATES', false);
end
%%%% ¡gui!
pr = PPAnalyzeGroup_CORRELATION_RULE('EL', a, 'PROP', AnalyzeGroup_ST_BUT.CORRELATION_RULE, varargin{:});

%%% ¡prop!
NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
%%%% ¡settings!
Correlation.NEGATIVE_WEIGHT_RULE_LIST
%%%% ¡default!
Correlation.NEGATIVE_WEIGHT_RULE_LIST{1}

%%% ¡prop!
USE_COVARIATES (parameter, logical) determines the use of covariates in the analysis.
%%%% ¡default!
false
%%%% ¡conditioning!
if value == true && ~(isequal(a.get('CORRELATION_RULE'), Correlation.CORRELATION_RULE_LIST{4}) || isequal(a.get('CORRELATION_RULE'), Correlation.CORRELATION_RULE_LIST{5}))
    a.set('CORRELATION_RULE', Correlation.CORRELATION_RULE_LIST{4}); % partial Pearson
end
%%%% ¡gui!
pr = PPAnalyzeGroup_USE_COVARIATES('EL', a, 'PROP', AnalyzeGroup_ST_BUT.USE_COVARIATES, varargin{:});

%% ¡props_update!

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
%%%% ¡calculate!
gr = a.get('GR');
data_list = cellfun(@(x) x.get('ST'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
data = cat(2, data_list{:})'; % correlation is a column based operation
atlas = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0
    atlas = gr.get('SUB_DICT').getItem(1).get('BA');
end

if a.get('USE_COVARIATES')
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
    A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'), [age, sex]);
else
    A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'));
end

g = GraphWU( ...
    'ID', ['g ' gr.get('ID')], ...
    'B', A, ...
    'BRAINATLAS', atlas ...
    );

value = g;

%% ¡methods!
function pr = getPPCompareGroup_CPDict(a, varargin) 
    %GEPPPCOMPAREGROUP_CPDICT returns the comparison plot panel compatible with the analysis.
    %
    % PR = GEPPPCOMPAREGROUP_CPDICT(A) returns the comparison plot panel
    %  that is compatible with the analyze group.
    %
    % See also CompareGroup.
    
    pr = PPCompareGroup_CPDict_ST_WU(varargin{:});
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_ST_WU