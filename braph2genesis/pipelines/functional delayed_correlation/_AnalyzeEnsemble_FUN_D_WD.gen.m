%% ¡header!
AnalyzeEnsemble_FUN_D_WD < AnalyzeEnsemble (a, graph analysis with functional data) is a graph analysis using functional data. 

%% ¡description!
This graph analysis uses functional data. The matrices are calculated using delayed correlation method.
The data will be analyzed using using weighted directed graphs.

%% ¡props!
%%% ¡prop!
REPETITION(parameter, scalar) is the number of repetitions (Repetion time for fMRI).
%%%% ¡default!
2.7
%%% ¡prop!
FREQUENCYRULEMIN(parameter, scalar)is the minimum frequency value
%%%% ¡default!
0
%%% ¡prop!
FREQUENCYRULEMAX(parameter, scalar)is the maximum frequency value
%%%% ¡default!
Inf
%%% ¡prop!
DELAYVALUE(parameter, scalar)is the value of the temporal delay at which matrices are calculated
%%%% ¡default!
1
%%%% ¡conditioning!
value = abs(floor(value));

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
ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
%%%% ¡gui!
pr = PPAnalyzeEnsemble_ME_DICT('EL', a, 'PROP', AnalyzeEnsemble_FUN_WU.ME_DICT, 'WAITBAR', true, varargin{:});

%%% ¡prop!
G_DICT (result, idict) is the graph (GraphWD) ensemble obtained from this analysis.
%%%% ¡settings!
'GraphWD'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'GraphWD')
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'GraphWD');

gr = a.get('GR');
T = a.get('REPETITION');
fmin = a.get('FREQUENCYRULEMIN');
fmax = a.get('FREQUENCYRULEMAX');
delta = a.get('DELAYVALUE');
atlas = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0
    atlas = gr.get('SUB_DICT').getItem(1).get('BA');
end
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
    
    %% Delayed correlation calculation
    % preallocate the connectivity matrix
    correlation = zeros(atlas.get('BR_DICT').length());
        
    % specify the data length for all outgoing regions
    conn_region1 = data(1:1:(size(data,1)-delta), :);

    % for each incoming region get the data and calculate
    % the correlation
    for j = 1:1:size(data, 2)
        conn_region2 = data(1+delta:1:size(data,1),j);

        correlation(:,j) = corr(conn_region1, conn_region2,...
            'type', a.get('CORRELATION_RULE'));
    end

    % Standard procedures on the matrix
    % take only the antisymmetric part
    A = correlation - transpose(correlation);

    % eliminate all the negative connections
    A(A < 0) = 0;

    % set the diagnoal entries to 0
    A(1:length(A)+1:numel(A)) = 0;


    g = GraphWD( ...
        'ID', ['g ' sub.get('ID')], ...
        'B', A, ...
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
    
    pr = PPCompareEnsemble_FUN_CPDict_WD(varargin{:});
end
%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_FUN_WD