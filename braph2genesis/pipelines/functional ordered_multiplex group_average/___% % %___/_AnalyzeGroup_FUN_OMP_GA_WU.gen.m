%% ¡header!
AnalyzeGroup_FUN_OMP_GA_WU < AnalyzeGroup (a, graph analysis with functional ordinal multiplex data) is a graph analysis using functional ordinal multiplex data.

%% ¡description!
This graph analysis uses functional ordinal multiplex data and analyzes them 
using weighted undirected graphs.

%%% ¡seealso!
SubjectFUN_MP, OrderedMultiplexWU, AnalyzeGroup_FUN_MP_GA_WU.

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
Correlation.CORRELATION_RULE_LIST(1:3)
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
TEMPLATE (parameter, item) is the analysis template to set the parameters.
%%%% ¡settings!
'AnalyzeGroup_FUN_OMP_GA_WU'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectFUN_MP.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN_MP')

%%% ¡prop!
G (result, item) is the average graph (OrderedMultiplexWU) obtained from this analysis.
%%%% ¡settings!
'OrderedMultiplexWU'
%%%% ¡default!
OrderedMultiplexWU()
%%%% ¡calculate!
gr = a.get('GR');
subjects_number = gr.get('SUB_DICT').length();

T = a.get('REPETITION');
fmin = a.get('FREQUENCYRULEMIN');
fmax = a.get('FREQUENCYRULEMAX');
A_fun = cell(1, 2);
for i = 1:1:subjects_number
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
        
        A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'));
        
        if i == 1
            A_fun(j) = {A};
        else
            A_fun(j) = {A_fun{j} + A};
        end
    end
end

ba = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && subjects_number > 0
    ba = gr.get('SUB_DICT').getItem(1).get('BA');
end

L = length(A_fun);
g = OrderedMultiplexWU( ...
    'ID', ['g ' gr.get('ID')], ...
    'B', cellfun(@(a) a/subjects_number, A_fun, 'UniformOutput', false), ... % % % 'LAYERTICKS', [1:1:L], ...
    'LAYERLABELS', cell2str(cellfun(@(x) ['L' num2str(x)], num2cell([1:1:L]), 'UniformOutput', false)), ...    
    'BAS', ba ...
    );
value = g;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_FUN_OMP_GA_WU