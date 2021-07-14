%% ¡header!
AnalyzeGroup_CON_FUN_MP_WU < AnalyzeGroup(a, graph analysis with connectivity and functional multiplex data) is a graph analysis using connectivity and functional multiplex data.

%% ¡description!
This graph analysis uses connectivity and functional multiplex data and analyzes 
them using weighted undirected graphs,
binary undirected multigraphs with fixed thresholds,
or binary undirected multigraphs with fixed densities.

%%% ¡seealso!
AnalyzeGroup_CON_FUN_MP_BUD, SubjectCON_FUN_MP, MultiplexWU.

%% ¡props!
%%% ¡prop!
REPETITION(parameter, scalar) is the number of repetitions for functional data
%%%% ¡default!
1
%%% ¡prop!
FREQUENCYRULEMIN(parameter, scalar) is the minimum frequency value for functional data
%%%% ¡default!
0
%%% ¡prop!
FREQUENCYRULEMAX(parameter, scalar) is the maximum frequency value for functional data
%%%% ¡default!
Inf

%%% ¡prop!
CORRELATION_RULE (parameter, option) is the correlation type for functional data.
%%%% ¡settings!
Correlation.CORRELATION_RULE_LIST
%%%% ¡default!
Correlation.CORRELATION_RULE_LIST{1}

%%% ¡prop!
NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights of functional data.
%%%% ¡settings!
Correlation.NEGATIVE_WEIGHT_RULE_LIST
%%%% ¡default!
Correlation.NEGATIVE_WEIGHT_RULE_LIST{1}

%% ¡props_update!

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON_FUN_MP.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_FUN_MP')

%%% ¡prop!
G (result, item) is the average multiplex graph obtained from this analysis.
%%%% ¡settings!
'MultiplexWU'
%%%% ¡default!
MultiplexWU()
%%%% ¡calculate!
gr = a.get('GR');
T = a.get('REPETITION');
fmin = a.get('FREQUENCYRULEMIN');
fmax = a.get('FREQUENCYRULEMAX');
A = cell(1, 2);
data = cell(1, 2);

for i = 1:1:gr.get('SUB_DICT').length()
    sub = gr.get('SUB_DICT').getItem(i);
    CON_FUN_MP = sub.getr('CON_FUN_MP');
    
    % FUN data
    data_fun = CON_FUN_MP{2};
    fs = 1 / T;
    
    if fmax > fmin && T > 0
        NFFT = 2 * ceil(size(data_fun, 1) / 2);
        ft = fft(data_fun, NFFT);  % Fourier transform
        f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
        ft(f < fmin | f > fmax, :) = 0;
        data_fun = ifft(ft, NFFT);
    end
    
    A_fun = Correlation.getAdjacencyMatrix(data_fun, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'));
    
    % CON data
    if i == 1
        data(1) = CON_FUN_MP(1);
        data(2) = {A_fun};
    else
        data(1) = {data{1} + CON_FUN_MP{1}};
        data(2) = {data{2} + A_fun};
    end
    
end

A(1) = {data{1}/gr.get('SUB_DICT').length()};
A(2) = {data{2}/gr.get('SUB_DICT').length()};
					
g = MultiplexWU( ...
    'ID', ['g ' gr.get('ID')], ...
    'B', A ...
    );

value = g;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_CON_FUN_MP_WU_Group
    