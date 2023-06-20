%% ¡header!
AnalyzeEnsemble_FUN_BUD < AnalyzeEnsemble (a, graph analysis with functional data of fixed density) is an ensemble-based graph analysis using functional data of fixed density.

%%% ¡description!
This graph analysis (AnalyzeEnsemble_FUN_BUD) analyzes functional data 
using binary undirected multigraphs with fixed densities.

%%% ¡seealso!
SubjectFUN, MultigraphBUD

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the .
%%%% ¡default!
''

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the .
%%%% ¡default!
'This graph analysis (AnalyzeEnsemble_FUN_BUD) analyzes functional data using binary undirected multigraphs with fixed densities.'

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
GR (data, item) is the subject group, which also defines the subject class SubjectFUN.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN')

%%% ¡prop!
ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
%%%% ¡gui_!
% % % pr = PPAnalyzeEnsemble_ME_DICT('EL', a, 'PROP', AnalyzeEnsemble_FUN_BUD.ME_DICT, 'WAITBAR', true, varargin{:});

%%% ¡prop!
G_DICT (result, idict) is the graph (MultigraphBUD) ensemble obtained from this analysis.
%%%% ¡settings!
'MultigraphBUD'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'MultigraphBUD')
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'MultigraphBUD');
gr = a.get('GR');

ba = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0
    ba = gr.get('SUB_DICT').getItem(1).get('BA');
end

T = a.get('REPETITION');
fmin = a.get('F_MIN');
fmax = a.get('F_MAX');
densities = a.get('DENSITIES'); % this is a vector
for i = 1:1:gr.get('SUB_DICT').length()
	sub = gr.get('SUB_DICT').getItem(i);
    data = sub.getr('FUN');
    fs = 1 / T;
    
    if fmax > fmin && T > 0
        NFFT = 2 * ceil(size(data, 1) / 2);
        ft = fft(data, NFFT);  % Fourier transform
        f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
        ft(f < fmin | f > fmax, :) = 0;
        data = ifft(ft, NFFT);
    end
    
    A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'));      
    
    g = MultigraphBUD( ...
        'ID', ['g ' sub.get('ID')], ...
        'B', A, ...
        'DENSITIES', densities, ...
        'LAYERTICKS', densities, ...
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
DENSITIES (parameter, rvector) is the vector of densities.
%%%% ¡default!
[1:1:10]
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', a, 'PROP', AnalyzeEnsemble_FUN_BUD.DENSITIES, ...
    'MIN', 0, 'MAX', 100, ...
    'DEFAULT', AnalyzeEnsemble_FUN_BUD.getPropDefault('DENSITIES'), ...
    varargin{:});

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
if ~isfile([fileparts(which('SubjectFUN')) filesep 'Example data FUN XLS' filesep 'atlas.xlsx'])
    test_ImporterGroupSubjectFUN_XLS % create example files
end

example_FUN_BUD