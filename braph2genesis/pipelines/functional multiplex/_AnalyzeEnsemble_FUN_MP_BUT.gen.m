%% ¡header!
AnalyzeEnsemble_FUN_MP_BUT < AnalyzeEnsemble (a, graph analysis with functional multiplex data of fixed threshold) is an ensemble-based graph analysis using functional multiplex data of fixed threshold.

%%% ¡description!
This graph analysis (AnalyzeEnsemble_FUN_MP_BUT) analyzes functional multiplex data 
using binary undirected multigraphs with fixed thresholds.

%%% ¡seealso!
SubjectFUN_MP, MultiplexBUT

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the .
%%%% ¡default!
''

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ensemble-based .
%%%% ¡default!
'This graph analysis (AnalyzeEnsemble_FUN_MP_BUT) analyzes functional multiplex data using binary undirected multigraphs with fixed thresholds.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the .

%%% ¡prop!
ID (data, string) is a few-letter code for the .
%%%% ¡default!
' ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the .
%%%% ¡default!
' label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the .
%%%% ¡default!
' notes'













%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectFUN_MP.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN_MP')

%%% ¡prop!
ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
%%%% ¡gui_!
% % % pr = PPAnalyzeEnsembleMP_ME_DICT('EL', a, 'PROP', AnalyzeEnsemble_FUN_MP_BUT.ME_DICT, 'WAITBAR', true, varargin{:});

%%% ¡prop!
G_DICT (result, idict) is the graph (MultiplexBUT) ensemble obtained from this analysis.
%%%% ¡settings!
'MultiplexBUT'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'MultiplexBUT')
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'MultiplexBUT');
gr = a.get('GR');
node_labels = '';

ba = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0 
    ba = gr.get('SUB_DICT').getItem(1).get('BA');
end

T = a.get('REPETITION');
fmin = a.get('F_MIN');
fmax = a.get('F_MAX');
thresholds = a.get('THRESHOLDS'); % this is a vector
for i = 1:1:gr.get('SUB_DICT').length()
    A = cell(1, 2);
	sub = gr.get('SUB_DICT').getItem(i);
    FUN_MP = sub.getr('FUN_MP');
    L = sub.get('L');
    
    for j = 1:1:L
        data = FUN_MP{j};
        fs = 1 / T;
        
        if fmax > fmin && T > 0
            NFFT = 2 * ceil(size(data, 1) / 2);
            ft = fft(data, NFFT);  % Fourier transform
            f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
            ft(f < fmin | f > fmax, :) = 0;
            data = ifft(ft, NFFT);
        end
        
        A(j) = {Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'))};
    end
    
    g = MultiplexBUT( ...
        'ID', ['g ' sub.get('ID')], ...
        'B', A, ...
        'THRESHOLDS', thresholds, ...
        'BAS', ba ...
        );
    g_dict.add(g)
    
    if isa(a.getr('TEMPLATE'), 'NoValue')
        g.set('TEMPLATE', a.memorize('GRAPH_TEMPLATE'))
    else
        g.set('TEMPLATE', a.get('TEMPLATE').memorize('GRAPH_TEMPLATE'))        
    end    
end

value = g_dict;

%% ¡props!

%%% ¡prop!
REPETITION (parameter, scalar) is the number of repetitions
%%%% ¡default!
1

%%% ¡prop!
F_MIN (parameter, scalar) is the minimum frequency value
%%%% ¡default!
0

%%% ¡prop!
F_MAX (parameter, scalar) is the maximum frequency value
%%%% ¡default!
Inf

%%% ¡prop!
CORRELATION_RULE (parameter, option) is the correlation type.
%%%% ¡settings!
Correlation.CORRELATION_RULE_LIST(1:3)
%%%% ¡default!
Correlation.CORRELATION_RULE_LIST{1}

%%% ¡prop!
NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
%%%% ¡settings!
Correlation.NEGATIVE_WEIGHT_RULE_LIST
%%%% ¡default!
Correlation.NEGATIVE_WEIGHT_RULE_LIST{1}

%%% ¡prop!
THRESHOLDS (parameter, rvector) is the vector of thresholds.
%%%% ¡default!
[-1:.5:1]
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', a, 'PROP', AnalyzeEnsemble_FUN_MP_BUT.THRESHOLDS, ...
    'MIN', -1, 'MAX', 1, ...
    'DEFAULT', AnalyzeEnsemble_FUN_MP_BUT.getPropDefault('THRESHOLDS'), ...
    varargin{:});

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
if ~isfile([fileparts(which('SubjectFUN_MP')) filesep 'Example data FUN_MP XLS' filesep 'atlas.xlsx'])
    test_ImporterGroupSubjectFUN_MP_XLS % create example files
end

example_FUN_MP_BUT