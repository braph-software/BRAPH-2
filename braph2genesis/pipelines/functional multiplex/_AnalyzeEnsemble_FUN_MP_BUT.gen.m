%% ¡header!
AnalyzeEnsemble_FUN_MP_BUT < AnalyzeEnsemble (a, graph analysis with functional multiplex data of fixed threshold) is an ensemble-based graph analysis using functional multiplex data of fixed threshold.

%%% ¡description!
This graph analysis (AnalyzeEnsemble_FUN_MP_BUT) analyzes functional multiplex data 
using binary undirected multigraphs with fixed thresholds.

%%% ¡seealso!
SubjectFUN_MP, MultiplexBUT

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_MP_BUT.ID
%%%% ¡title!
Analysis ID

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_MP_BUT.LABEL
%%%% ¡title!
Analysis NAME

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_MP_BUT.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_MP_BUT.GR
%%%% ¡title!
SUBJECT GROUP

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_MP_BUT.GRAPH_TEMPLATE
%%%% ¡title!
GRAPH & MEASURE PARAMETERS

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_MP_BUT.THRESHOLDS
%%%% ¡title!
THRESHOLDS [-1 ... 1]

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_MP_BUT.REPETITION
%%%% ¡title!
REPETITION TIME [s]

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_MP_BUT.F_MIN
%%%% ¡title!
MIN FREQUENCY [Hz]

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_MP_BUT.F_MAX
%%%% ¡title!
MAX FREQUENCY [Hz]

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_MP_BUT.CORRELATION_RULE
%%%% ¡title!
CORRELATION RULE

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_MP_BUT.NEGATIVE_WEIGHT_RULE
%%%% ¡title!
NEGATIVE WEIGHTS RULE

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_MP_BUT.ME_DICT
%%%% ¡title!
Group-averaged MEASURES

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_MP_BUT.G_DICT
%%%% ¡title!
Individual GRAPHS

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_MP_BUT.NOTES
%%%% ¡title!
Analysis NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'AnalyzeEnsemble_FUN_MP_BUT'

%%% ¡prop!
NAME (constant, string) is the name of the ensemble-based graph analysis with functional multiplex data of fixed threshold.
%%%% ¡default!
'AnalyzeEnsemble_FUN_MP_BUT'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis with functional multiplex data of fixed threshold.
%%%% ¡default!
'This graph analysis (AnalyzeEnsemble_FUN_MP_BUT) analyzes functional multiplex data using binary undirected multigraphs with fixed thresholds.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis with functional multiplex data of fixed threshold.
%%%% ¡settings!
'AnalyzeEnsemble_FUN_MP_BUT'

%%% ¡prop!
ID (data, string) is a few-letter code for the ensemble-based graph analysis with functional multiplex data of fixed threshold.
%%%% ¡default!
'AnalyzeEnsemble_FUN_MP_BUT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ensemble-based graph analysis with functional multiplex data of fixed threshold.
%%%% ¡default!
'AnalyzeEnsemble_FUN_MP_BUT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis with functional multiplex data of fixed threshold.
%%%% ¡default!
'AnalyzeEnsemble_FUN_MP_BUT notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectFUN_MP.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN_MP')

%%% ¡prop!
GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
%%%% ¡settings!
'MultiplexBUT'

%%% ¡prop!
G_DICT (result, idict) is the graph (MultiplexBUT) ensemble obtained from this analysis.
%%%% ¡settings!
'MultiplexBUT'
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'MultiplexBUT');
gr = a.get('GR');

T = a.get('REPETITION');
fs = 1 / T;
fmin = a.get('F_MIN');
fmax = a.get('F_MAX');

thresholds = a.get('THRESHOLDS'); % this is a vector

for i = 1:1:gr.get('SUB_DICT').get('LENGTH')
	sub = gr.get('SUB_DICT').get('IT', i);
    FUN_MP = sub.getr('FUN_MP');
    L = sub.get('L');
    
    A = cell(1, L);

    for j = 1:1:L
        data = FUN_MP{j};
        
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
        'LAYERLABELS', cellfun(@(x) ['L' num2str(x)], num2cell([1:1:L]), 'UniformOutput', false), ...
        'NODELABELS', a.get('GR').get('SUB_DICT').get('IT', 1).get('BA').get('BR_DICT').get('KEYS') ...
        );
    g_dict.get('ADD', g)
end

if ~isa(a.get('GRAPH_TEMPLATE'), 'NoValue')
    for i = 1:1:g_dict.get('LENGTH')
        g_dict.get('IT', i).set('TEMPLATE', a.get('GRAPH_TEMPLATE'))
    end
end

value = g_dict;

%%% ¡prop!
ME_DICT (result, idict) contains the calculated measures of the graph ensemble.

%% ¡props!

%%% ¡prop!
REPETITION (parameter, scalar) is the number of repetitions.
%%%% ¡default!
1

%%% ¡prop!
F_MIN (parameter, scalar) is the minimum frequency value.
%%%% ¡default!
0

%%% ¡prop!
F_MAX (parameter, scalar) is the maximum frequency value.
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
%%%% ¡postset!
a.memorize('GRAPH_TEMPLATE').set('THRESHOLDS', a.getCallback('THRESHOLDS'));

%% ¡tests!

%%% ¡excluded_props!
[AnalyzeEnsemble_FUN_MP_BUT.TEMPLATE AnalyzeEnsemble_FUN_MP_BUT.GRAPH_TEMPLATE]

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
create_data_FUN_MP_XLS() % only creates files if the example folder doesn't already exist
example_FUN_MP_BUT

%%% ¡test!
%%%% ¡name!
GUI - Analysis
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', 'aal90_atlas.xlsx');
ba = im_ba.get('BA');

gr = Group('SUB_CLASS', 'SubjectFUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN_MP'));
for i = 1:1:10
    sub = SubjectFUN_MP( ...
        'ID', ['SUB FUN_MP ' int2str(i)], ...
        'LABEL', ['Subejct FUN_MP ' int2str(i)], ...
        'NOTES', ['Notes on subject FUN_MP ' int2str(i)], ...
        'BA', ba, ...
        'L', 3, ...
        'LAYERLABELS', {'L1' 'L2' 'L3'}, ...
        'FUN_MP', {rand(10, ba.get('BR_DICT').get('LENGTH')), rand(10, ba.get('BR_DICT').get('LENGTH')), rand(10, ba.get('BR_DICT').get('LENGTH'))} ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr.get('SUB_DICT').get('ADD', sub)
end

a = AnalyzeEnsemble_FUN_MP_BUT('GR', gr, 'THRESHOLDS', -1:.5:1);

gui = GUIElement('PE', a, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')

%%% ¡test!
%%%% ¡name!
GUI - Comparison
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', 'aal90_atlas.xlsx');
ba = im_ba.get('BA');

gr1 = Group('SUB_CLASS', 'SubjectFUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN_MP'));
for i = 1:1:10
    sub = SubjectFUN_MP( ...
        'ID', ['SUB FUN_MP ' int2str(i)], ...
        'LABEL', ['Subejct FUN_MP ' int2str(i)], ...
        'NOTES', ['Notes on subject FUN_MP ' int2str(i)], ...
        'BA', ba, ...
        'L', 3, ...
        'LAYERLABELS', {'L1' 'L2' 'L3'}, ...
        'FUN_MP', {rand(10, ba.get('BR_DICT').get('LENGTH')), rand(10, ba.get('BR_DICT').get('LENGTH')), rand(10, ba.get('BR_DICT').get('LENGTH'))} ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr1.get('SUB_DICT').get('ADD', sub)
end

gr2 = Group('SUB_CLASS', 'SubjectFUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN_MP'));
for i = 1:1:10
    sub = SubjectFUN_MP( ...
        'ID', ['SUB FUN_MP ' int2str(i)], ...
        'LABEL', ['Subejct FUN_MP ' int2str(i)], ...
        'NOTES', ['Notes on subject FUN_MP ' int2str(i)], ...
        'BA', ba, ...
        'L', 3, ...
        'LAYERLABELS', {'L1' 'L2' 'L3'}, ...
        'FUN_MP', {rand(10, ba.get('BR_DICT').get('LENGTH')), rand(10, ba.get('BR_DICT').get('LENGTH')), rand(10, ba.get('BR_DICT').get('LENGTH'))} ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr2.get('SUB_DICT').get('ADD', sub)
end

a1 = AnalyzeEnsemble_FUN_MP_BUT('GR', gr1, 'THRESHOLDS', -1:.5:1);
a2 = AnalyzeEnsemble_FUN_MP_BUT('GR', gr2, 'TEMPLATE', a1);

c = CompareEnsemble( ...
    'P', 10, ...
    'A1', a1, ...
    'A2', a2, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );

gui = GUIElement('PE', c, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')