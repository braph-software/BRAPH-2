%% ¡header!
AnalyzeEnsemble_FUN_WU < AnalyzeEnsemble (a, graph analysis with functional data) is a graph analysis using functional data.

%% ¡description!
This graph analysis uses functional data and analyzes them using weighted undirected graphs,
binary undirected multigraphs with fixed thresholds,
or binary undirected multigraphs with fixed densities.

%% ¡props!
%%% ¡prop!
REPETITION(parameter, scalar)is the number of repetitions
%%%% ¡default!
1
%%% ¡prop!
FRECUENCYRULEMIN(parameter, scalar)is the minimum frecuency value
%%%% ¡default!
0
%%% ¡prop!
FRECUENCYRULEMAX(parameter, scalar)is the maximum frecuency value
%%%% ¡default!
Inf

%% ¡props_update!

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectFUN.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN')

%%% ¡prop!
G_DICT (result, idict) is the graph (GraphWU) ensemble obtained from this analysis.
%%%% ¡settings!
'GraphWU'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'GraphWU')
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'GraphWU');

gr = a.get('GR');
T = a.get('REPETITION');
fmin = a.get('FRECUENCYRULEMIN');
fmax = a.get('FRECUENCYRULEMAX');
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
    
    g = GraphWU( ...
        'ID', ['g ' sub.get('ID')], ...
        'B', data ...
        );
    g_dict.add(g)
end

value = g_dict;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_FUN_WU