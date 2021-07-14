%% ¡header!
AnalyzeGroup_FUN_WU < AnalyzeGroup (a, graph analysis with functional data) is a graph analysis using functional data.

%% ¡description!
This graph analysis uses functional data and analyzes them using weighted undirected graphs,
binary undirected multigraphs with fixed thresholds,
or binary undirected multigraphs with fixed densities.

%% ¡props!
%%% ¡prop!
REPETITION(parameter, scalar) is the number of repetitions
%%%% ¡default!
1
%%% ¡prop!
FREQUENCYRULEMIN(parameter, scalar)is the minimum frequency value
%%%% ¡default!
0
%%% ¡prop!
FREQUENCYRULEMAX(parameter, scalar)is the maximum frequency value
%%%% ¡default!
Inf

%%% ¡prop!
CORRELATION_RULE (parameter, option) is the correlation type.
%%%% ¡settings!
Correlation.CORRELATION_RULE_LIST
%%%% ¡default!
Correlation.CORRELATION_RULE_LIST{1}

%%% ¡prop!
NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
%%%% ¡settings!
Correlation.NEGATIVE_WEIGHT_RULE_LIST
%%%% ¡default!
Correlation.NEGATIVE_WEIGHT_RULE_LIST{1}

%% ¡props_update!

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectFUN.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN')

%%% ¡prop!
G (result, idict) is the average graph obtained from this analysis.
%%%% ¡settings!
'GraphWU'
%%%% ¡default!
GraphWU()
%%%% ¡calculate!
gr = a.get('GR');
T = a.get('REPETITION');
fmin = a.get('FREQUENCYRULEMIN');
fmax = a.get('FREQUENCYRULEMAX');
A_fun = [];
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
    
    if i == 1
        A_fun = A;
    else
        A_fun = A_fun + A;
    end    
end

g = GraphWU( ...
    'ID', ['g ' gr.get('ID')], ...
    'B', A_fun/gr.get('SUB_DICT').length() ...
    );
value = g;
%%%% ¡gui!
pl = PPAnalyzeGroupGraph('EL', a, 'PROP', AnalyzeGroup_FUN_WU.G, varargin{:});

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_FUN_WU_Group