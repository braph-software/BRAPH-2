%% ¡header!
AnalyzeEnsemble_FUN_MP_WU < AnalyzeEnsemble (a, graph analysis with functional multiplex data) is a graph analysis using functional multiplex data.

%%% ¡description!
This graph analysis uses functional multiplex data and analyzes them using weighted undirected graphs,
binary undirected multigraphs with fixed thresholds,
or binary undirected multigraphs with fixed densities.

%%% ¡seealso!
SubjectFUN_MP, MultiplexWU.

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the .
%%%% ¡default!
''

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the .
%%%% ¡default!
''

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
% % % pr = PPAnalyzeEnsembleMP_ME_DICT('EL', a, 'PROP', AnalyzeEnsemble_FUN_MP_WU.ME_DICT, 'WAITBAR', true, varargin{:});

%%% ¡prop!
G_DICT (result, idict) is the graph (MultiplexWU) ensemble obtained from this analysis.
%%%% ¡settings!
'MultiplexWU'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'MultiplexWU')
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'MultiplexWU');
gr = a.get('GR');

ba = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0
    ba = gr.get('SUB_DICT').getItem(1).get('BA');
end

T = a.get('REPETITION');
fmin = a.get('F_MIN');
fmax = a.get('F_MAX');
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
    
    g = MultiplexWU( ...
        'ID', ['g ' sub.get('ID')], ...
        'B', A, ...
        'BAS', ba ...
        );
    g_dict.add(g)
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

example_FUN_MP_WU