%% ¡header!
AnalyzeEnsemble_CON_FUN_MP_BUD < AnalyzeEnsemble (a, graph analysis with connectivity and functional multiplex data of fixed density) is an ensemble-based graph analysis using connectivity and functional multiplex data of fixed density.

%%% ¡description!
This graph analysis (AnalyzeEnsemble_CON_FUN_MP_BUD) analyzes connectivity 
and functional multiplex data using binary undirected graphs at fixed densities.

%%% ¡seealso!
SubjectCON_FUN_MP, MultiplexBUD

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.ID
%%%% ¡title!
Analysis ID

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.LABEL
%%%% ¡title!
Analysis NAME

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.GR
%%%% ¡title!
SUBJECT GROUP

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.DENSITIES
%%%% ¡title!
DENSITIES [0% ... 100%]

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.REPETITION
%%%% ¡title!
REPETITION TIME [s]

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.F_MIN
%%%% ¡title!
MIN FREQUENCY [Hz]

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.F_MAX
%%%% ¡title!
MAX FREQUENCY [Hz]

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.CORRELATION_RULE
%%%% ¡title!
CORRELATION RULE

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.NEGATIVE_WEIGHT_RULE
%%%% ¡title!
NEGATIVE WEIGHTS RULE

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.ME_DICT
%%%% ¡title!
Group-averaged MEASURES

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.G_DICT
%%%% ¡title!
Individual GRAPHS

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_CON_FUN_MP_BUD.NOTES
%%%% ¡title!
Analysis NOTES

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the ensemble-based graph analysis with connectivity and functional multiplex data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_CON_FUN_MP_BUD'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis with connectivity and functional multiplex data of fixed density.
%%%% ¡default!
'This graph analysis (AnalyzeEnsemble_CON_FUN_MP_BUD) analyzes connectivity and functional multiplex data using binary undirected graphs at fixed densities.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis with connectivity and functional multiplex data of fixed density.
%%%% ¡settings!
'AnalyzeEnsemble_CON_FUN_MP_BUD'

%%% ¡prop!
ID (data, string) is a few-letter code for the ensemble-based graph analysis with connectivity and functional multiplex data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_CON_FUN_MP_BUD ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ensemble-based graph analysis with connectivity and functional multiplex data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_CON_FUN_MP_BUD label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis with connectivity and functional multiplex data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_CON_FUN_MP_BUD notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON_FUN_MP.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_FUN_MP')

%%% ¡prop!
GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
%%%% ¡settings!
'MultiplexBUD'

%%% ¡prop!
G_DICT (result, idict) is the multiplex (MultiplexBUD) ensemble obtained from this analysis.
%%%% ¡settings!
'MultiplexBUD'
%%%% ¡_default!
% % % IndexedDictionary('IT_CLASS', 'MultiplexBUD')
%%%% ¡_calculate!
% % % g_dict = IndexedDictionary('IT_CLASS', 'MultiplexBUD');
% % % node_labels = '';
% % % gr = a.get('GR');
% % % 
% % % ba = BrainAtlas();
% % % if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0   
% % %     ba = gr.get('SUB_DICT').getItem(1).get('BA');
% % % end
% % % 
% % % T = a.get('REPETITION');
% % % fmin = a.get('F_MIN');
% % % fmax = a.get('F_MAX');
% % % densities = a.get('DENSITIES'); % this is a vector
% % % for i = 1:1:gr.get('SUB_DICT').length()
% % %     A = cell(1, 2);
% % % 	sub = gr.get('SUB_DICT').getItem(i);
% % %     CON_FUN_MP = sub.getr('CON_FUN_MP');
% % %     
% % %     % CON data
% % %     A(1) = CON_FUN_MP(1);
% % %     
% % %     % FUN data
% % %     data = CON_FUN_MP{2};
% % %     fs = 1 / T;
% % %     
% % %     if fmax > fmin && T > 0
% % %         NFFT = 2 * ceil(size(data, 1) / 2);
% % %         ft = fft(data, NFFT);  % Fourier transform
% % %         f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
% % %         ft(f < fmin | f > fmax, :) = 0;
% % %         data = ifft(ft, NFFT);
% % %     end
% % %     
% % %     A(2) = {Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'))};
% % %     
% % %     g = MultiplexBUD( ...
% % %         'ID', ['g ' sub.get('ID')], ...
% % %         'B', A, ...
% % %         'DENSITIES', densities, ...
% % %         'BAS', ba ...
% % %         );
% % %     g_dict.add(g)
% % %     
% % %     if isa(a.getr('TEMPLATE'), 'NoValue')
% % %         g.set('TEMPLATE', a.memorize('GRAPH_TEMPLATE'))        
% % %     else
% % %         g.set('TEMPLATE', a.get('TEMPLATE').memorize('GRAPH_TEMPLATE'))
% % %     end    
% % % end
% % % 
% % % value = g_dict;

%%% ¡prop!
ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
%%%% ¡_gui!
% % % pr = PPAnalyzeEnsembleMP_ME_DICT('EL', a, 'PROP', AnalyzeEnsemble_CON_FUN_MP_BUD.ME_DICT, 'WAITBAR', true, varargin{:});

%% ¡props!

%%% ¡prop!
REPETITION (parameter, scalar) is the number of repetitions for functional data.
%%%% ¡default!
1

%%% ¡prop!
F_MIN (parameter, scalar) is the minimum frequency value for functional data.
%%%% ¡default!
0

%%% ¡prop!
F_MAX (parameter, scalar) is the maximum frequency value for functional data.
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
[1:1:10]
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', a, 'PROP', AnalyzeEnsemble_CON_FUN_MP_BUD.DENSITIES, ...
    'MIN', 0, 'MAX', 100, ...
    'DEFAULT', AnalyzeEnsemble_CON_FUN_MP_BUD.getPropDefault('DENSITIES'), ...
    varargin{:});

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
if ~isfile([fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP XLS' filesep 'atlas.xlsx'])
    test_SubjectCON_FUN_MP % create example files
end

example_CON_FUN_MP_BUD
