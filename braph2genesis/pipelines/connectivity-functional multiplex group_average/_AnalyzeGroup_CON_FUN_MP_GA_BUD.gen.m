%% ¡header!
AnalyzeGroup_CON_FUN_MP_GA_BUD < AnalyzeGroup (a, graph analysis with connectivity and functional multiplex data of fixed density) is a graph analysis using connectivity and functional multiplex data of fixed density.

%% ¡description!
This graph analysis uses connectivity and functional multiplex data of 
fixed density and analyzes them using binary undirected graphs.

%%% ¡seealso!
AnalyzeGroup_CON_FUN_MP_WU, SubjectCON_FUN_MP, MultiplexBUD.

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
Correlation.CORRELATION_RULE_LIST(1:3)
%%%% ¡default!
Correlation.CORRELATION_RULE_LIST{1}

%%% ¡prop!
NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights of functional data.
%%%% ¡settings!
Correlation.NEGATIVE_WEIGHT_RULE_LIST
%%%% ¡default!
Correlation.NEGATIVE_WEIGHT_RULE_LIST{1}

%%% ¡prop!
DENSITIES (parameter, rvector) is the vector of densities.
%%%% ¡default!
0

%% ¡props_update!

%%% ¡prop!
TEMPLATE (parameter, item) is the analysis template to set the parameters.
%%%% ¡settings!
'AnalyzeGroup_CON_FUN_MP_GA_BUD'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON_FUN_MP.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_FUN_MP')

%%% ¡prop!
G (result, item) is the average multiplex graph obtained from this analysis.
%%%% ¡settings!
'MultiplexBUD'
%%%% ¡default!
MultiplexBUD()
%%%% ¡calculate!
gr = a.get('GR');
T = a.get('REPETITION');
fmin = a.get('FREQUENCYRULEMIN');
fmax = a.get('FREQUENCYRULEMAX');
densities = a.get('DENSITIES'); % this is a vector
A = cell(1, 2);
data = cell(1, 2);
layerlabels = {};

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
    
    for i = 1:length(densities)
        layerlabels = [...
            layerlabels, ['C ' num2str(densities(i)) '%'], ...
            ['F ' num2str(densities(i)) '%']];
    end   
end

A(1) = {data{1}/gr.get('SUB_DICT').length()};
A(2) = {data{2}/gr.get('SUB_DICT').length()};

ba = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0
    ba = gr.get('SUB_DICT').getItem(1).get('BA');
end
                    
g = MultiplexBUD( ...
    'ID', ['g ' gr.get('ID')], ...
    'B', A, ...
    'DENSITIES', densities, ... 
    'LAYERTICKS', densities, ...
    'LAYERLABELS', cell2str(layerlabels), ...
    'BAS', ba ...
    );

value = g;

%% ¡methods!
function pr = getPPCompareGroup_CPDict(a, varargin) 
    %GEPPPCOMPAREGROUP_CPDICT returns the comparison plot panel compatible with the analysis.
    %
    % PR = GEPPPCOMPAREGROUP_CPDICT(A) returns the comparison plot panel
    %  that is compatible with the analyze group.
    %
    % See also CompareGroup.
    
    pr = PPCompareGroup_CPDict_CON_FUN_MP_GA_BUD(varargin{:});
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_CON_FUN_MP_GA_BUD