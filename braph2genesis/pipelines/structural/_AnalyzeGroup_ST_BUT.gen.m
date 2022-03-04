%% ¡header!
AnalyzeGroup_ST_BUT < AnalyzeGroup (a, graph analysis with structural data of fixed threshold) is a graph analysis using structural data of fixed threshold.

%% ¡description!
This graph analysis uses structural data of fixed threshold and analyzes them using binary undirected graphs.

%%% ¡seealso!
AnalyzeGroup_ST_WU, Subject_ST, MultigraphBUT.

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
0
%%%% ¡gui!
pr = PlotPropSmartVector('EL', a, 'PROP', AnalyzeGroup_ST_BUT.THRESHOLDS, 'MAX', 1, 'MIN', 0, varargin{:});

%% ¡props_update!

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectST.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST')

%%% ¡prop!
G (result, item) is the graph obtained from this analysis.
%%%% ¡settings!
'MultigraphBUT'
%%%% ¡default!
MultigraphBUT()
%%%% ¡calculate!
gr = a.get('GR');
node_labels = '';
data_list = cellfun(@(x) x.get('ST'), gr.get('SUB_DICT').getItems, 'UniformOutput', false);
data = cat(2, data_list{:})'; % correlation is a column based operation
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
                sex(i) = 0;
            otherwise
                sex(i) = -1;
        end
    end
    A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'), [age, sex]);
else
    A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'));
end

thresholds = a.get('THRESHOLDS'); 
            
g = MultigraphBUT( ...
    'ID', ['g ' gr.get('ID')], ...
    'B', A, ...
    'THRESHOLDS', thresholds, ...
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
    
    pr = PPCompareGroup_CPDict_BUT(varargin{:});
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_ST_BUT