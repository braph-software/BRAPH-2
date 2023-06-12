%% ¡header!
AnalyzeGroup_FUN_GA_WU < AnalyzeGroup (a, graph analysis with averaged functional data) is a graph analysis using averaged functional data.

%% ¡description!
AnalyzeGroup_FUN_GA_WU uses functional data averaged over a group 
and analyzes them using weighted undirected graphs.

%% ¡seealso!
SubjectFUN, GraphWU

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the graph analysis with averaged functional data.
%%%% ¡default!
'AnalyzeGroup_CON_GA_WU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the graph analysis with averaged functional data.
%%%% ¡default!
'AnalyzeGroup_FUN_GA_WU uses functional data averaged over a group and analyzes them using weighted undirected graphs.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the graph analysis with averaged functional data.

%%% ¡prop!
ID (data, string) is a few-letter code for the graph analysis with averaged functional data.
%%%% ¡default!
'AnalyzeGroup_CON_GA_WU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph analysis with averaged functional data.
%%%% ¡default!
'AnalyzeGroup_CON_GA_WU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph analysis with averaged functional data.
%%%% ¡default!
'AnalyzeGroup_CON_GA_WU notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectFUN.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN')

%%% ¡prop!
G (result, item) is the average graph obtained from this analysis.
%%%% ¡settings!
'GraphWU'
%%%% ¡default!
GraphWU()
%%%% ¡calculate!
gr = a.get('GR');
T = a.get('REPETITION');
fmin = a.get('F_MIN');
fmax = a.get('F_MAX');
A_fun = [];
for i = 1:1:gr.get('SUB_DICT').get('LENGTH')
	sub = gr.get('SUB_DICT').get('IT', i);
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
A_fun = A_fun / gr.get('SUB_DICT').get('LENGTH');

% % % ba = BrainAtlas();
% % % if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0
% % %     ba = gr.get('SUB_DICT').getItem(1).get('BA');
% % % end

g = GraphWU( ...
    'ID', ['Graph ' gr.get('ID')], ...
    'B', A_fun ... % % % 'BAS', ba ...
    );

value = g;

%% ¡props!

%%% ¡prop!
REPETITION (parameter, scalar) is the number of repetitions
%%%% ¡default!
1

%%% ¡prop!
F_MIN (parameter, scalar)is the minimum frequency value
%%%% ¡default!
0

%%% ¡prop!
F_MAX (parameter, scalar)is the maximum frequency value
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
example_FUN_GA_WU