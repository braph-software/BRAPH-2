%% ¡header!
AnalyzeEnsemble_FUN_MP_WU < AnalyzeEnsemble (a, graph analysis with functional multiplex data) is a graph analysis using functional multiplex data.

%% ¡description!
This graph analysis uses functional multiplex data and analyzes them using weighted undirected graphs,
binary undirected multigraphs with fixed thresholds,
or binary undirected multigraphs with fixed densities.

%%% ¡seealso!
AnalyzeEnsemble_FUN_MP_BUD, AnalyzeEnsemble_FUN_MP_BUT, Subject_FUN_MP, MultiplexWU.

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
'AnalyzeEnsemble_FUN_MP_WU'

%%% ¡prop!
GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
%%%% ¡settings!
'MultiplexWU'
%%%% ¡postprocessing!
if ~braph2_testing
    if isa(a.getr('GRAPH_TEMPLATE'), 'NoValue')
        a.set('GRAPH_TEMPLATE', MultiplexWU())

        if a.get('GR').get('SUB_DICT').length() > 0
            a.get('GRAPH_TEMPLATE').set('BAS', a.get('GR').get('SUB_DICT').getItem(1).get('BA'))
        end
    end
    if a.get('GR').get('SUB_DICT').length() > 0
        L = a.get('GR').get('SUB_DICT').getItem(1).get('L');  % number of layers
        layerlabels = cell2str(cellfun(@(x) ['L' num2str(x)], num2cell([1:1:L]), 'UniformOutput', false));
        
        a.get('GRAPH_TEMPLATE').set('LAYERLABELS', layerlabels)
    end
end

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
fmin = a.get('FREQUENCYRULEMIN');
fmax = a.get('FREQUENCYRULEMAX');
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

% % % %% ¡methods!
% % % function pr = getPPCompareEnsemble_CPDict(a, varargin) 
% % %     %GETPPCOMPAREENSEMBLE_CPDICT returns the comparison ensemble plot panel compatible with the analysis.
% % %     %
% % %     % PR = GETPPCOMPAREENSEMBLE_CPDICT(A) returns the comparison ensemble plot panel
% % %     %  that is compatible with the analyze ensemble.
% % %     %
% % %     % See also CompareEnsemble.
% % %     
% % %     pr = PPCompareEnsembleMP_FUN_CPDict_WU(varargin{:});
% % % end

%% ¡tests!

% % % %%% ¡test!
% % % %%%% ¡name!
% % % Example
% % % %%%% ¡code!
% % % example_FUN_MP_WU