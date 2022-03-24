%% ¡header!
AnalyzeEnsemble_CON_FUN_MP_BUT < AnalyzeEnsemble (a, graph analysis with connectivity and functional multiplex data of fixed threshold) is a graph analysis using connectivity and functional multiplex data of fixed threshold.

%% ¡description!
This graph analysis uses connectivity and functional multiplex data of 
fixed threshold and analyzes them using binary undirected graphs.

%%% ¡seealso!
AnalyzeEnsemble_CON_FUN_MP_WU, AnalyzeEnsemble_CON_FUN_MP_BUD, SubjectCON_FUN_MP, MultiplexBUT.

%% ¡props!
%%% ¡prop!
REPETITION(parameter, scalar) is the number of repetitions for functional data
%%%% ¡default!
1
%%% ¡prop!
FREQUENCYRULEMIN(parameter, scalar)is the minimum frequency value for functional data
%%%% ¡default!
0
%%% ¡prop!
FREQUENCYRULEMAX(parameter, scalar)is the maximum frequency value for functional data
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

%%% ¡prop!
THRESHOLDS (parameter, rvector) is the vector of thresholds.
%%%% ¡default!
0
%%%% ¡gui!
pr = PlotPropSmartVector('EL', a, 'PROP', AnalyzeEnsemble_CON_FUN_MP_BUT.THRESHOLDS, 'MAX', 1, 'MIN', 0, varargin{:});

%% ¡props_update!

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON_FUN_MP.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_FUN_MP')

%%% ¡prop!
ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
%%%% ¡gui!
pr = PPAnalyzeEnsembleMP_ME_DICT('EL', a, 'PROP', AnalyzeEnsemble_CON_FUN_MP_BUT.ME_DICT, 'WAITBAR', true, varargin{:});

%%% ¡prop!
G_DICT (result, idict) is the multiplex (MultiplexBUT) ensemble obtained from this analysis.
%%%% ¡settings!
'MultiplexBUT'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'MultiplexBUT')
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'MultiplexBUT');
node_labels = '';
gr = a.get('GR');

if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0   
    atlas = gr.get('SUB_DICT').getItem(1).get('BA');
end

T = a.get('REPETITION');
fmin = a.get('FREQUENCYRULEMIN');
fmax = a.get('FREQUENCYRULEMAX');
thresholds = a.get('THRESHOLDS'); % this is a vector
for i = 1:1:gr.get('SUB_DICT').length()
    A = cell(1, 2);
	sub = gr.get('SUB_DICT').getItem(i);
    CON_FUN_MP = sub.getr('CON_FUN_MP');
    
    % CON data
    A(1) = CON_FUN_MP(1);
    
    % FUN data
    data = CON_FUN_MP{2};
    fs = 1 / T;
    
    if fmax > fmin && T > 0
        NFFT = 2 * ceil(size(data, 1) / 2);
        ft = fft(data, NFFT);  % Fourier transform
        f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
        ft(f < fmin | f > fmax, :) = 0;
        data = ifft(ft, NFFT);
    end
    
    A(2) = {Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'))};
    
    g = MultiplexBUT( ...
        'ID', ['g ' sub.get('ID')], ...
        'B', A, ...
        'THRESHOLDS', thresholds, ...
        'BRAINATLAS', atlas ...
        );
    g_dict.add(g)
end

value = g_dict;

%% ¡methods!
function pr = getPPCompareEnsemble_CPDict(a, varargin) 
    %GETPPCOMPAREENSEMBLE_CPDICT returns the comparison ensemble plot panel compatible with the analysis.
    %
    % PR = GETPPCOMPAREENSEMBLE_CPDICT(A) returns the comparison ensemble plot panel
    %  that is compatible with the analyze ensemble.
    %
    % See also CompareEnsemble.
    
    pr = PPCompareEnsembleMP_CON_FUN_CPDict_BUT(varargin{:});
end
%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_CON_FUN_MP_BUT