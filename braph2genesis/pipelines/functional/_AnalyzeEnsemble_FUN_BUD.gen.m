%% ¡header!
AnalyzeEnsemble_FUN_BUD < AnalyzeEnsemble (a, graph analysis with functional data of fixed density) is a graph analysis using functional data of fixed density.

%% ¡description!
This graph analysis uses functional data of fixed density and analyzes them using binary undirected graphs.

%%% ¡seealso!
AnalyzeEnsemble_FUN_WU, AnalyzeEnsemble_FUN_BUT, Subject_FUN, MultigraphBUD.

%% ¡props!
%%% ¡prop!
REPETITION(parameter, scalar) is the number of repetitions
%%%% ¡default!
1

%%% ¡prop!
FREQUENCYRULEMIN(parameter, scalar) is the minimum frequency value
%%%% ¡default!
0

%%% ¡prop!
FREQUENCYRULEMAX(parameter, scalar) is the maximum frequency value
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

%% ¡props_update!

%%% ¡prop!
TEMPLATE (parameter, item) is the analysis template to set the parameters.
%%%% ¡settings!
'AnalyzeEnsemble_FUN_BUD'

%%% ¡prop!
GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
%%%% ¡settings!
'MultigraphBUD'
%%%% ¡postprocessing!
if ~braph2_testing
    if isa(a.getr('GRAPH_TEMPLATE'), 'NoValue')
        if a.get('GR').get('SUB_DICT').length() > 0
            a.set('GRAPH_TEMPLATE', ...
                MultigraphBUD('DENSITIES',  Callback('EL', a, 'TAG', 'DENSITIES'), ...
                'BAS', a.get('GR').get('SUB_DICT').getItem(1).get('BA')));
        else
            a.set('GRAPH_TEMPLATE', MultigraphBUD('DENSITIES',  Callback('EL', a, 'TAG', 'DENSITIES')));
        end       
    end
    a.get('GRAPH_TEMPLATE').set( ...
        'LAYERTICKS', a.get('DENSITIES'), ...
        'LAYERLABELS', cell2str(cellfun(@(x) num2str(x), num2cell(a.get('DENSITIES')), 'UniformOutput', false)) ...
        )
end

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
fmin = a.get('FREQUENCYRULEMIN');
fmax = a.get('FREQUENCYRULEMAX');
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

% % % %% ¡methods!
% % % function pr = getPPCompareEnsemble_CPDict(a, varargin) 
% % %     %GETPPCOMPAREENSEMBLE_CPDICT returns the comparison ensemble plot panel compatible with the analysis.
% % %     %
% % %     % PR = GETPPCOMPAREENSEMBLE_CPDICT(A) returns the comparison ensemble plot panel
% % %     %  that is compatible with the analyze ensemble.
% % %     %
% % %     % See also CompareEnsemble.
% % %     
% % %     pr = PPCompareEnsemble_FUN_CPDict_BUD(varargin{:});
% % % end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_FUN_BUD