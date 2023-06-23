%% ¡header!
AnalyzeEnsemble_CON_FUN_MP_WU < AnalyzeEnsemble (a, graph analysis with connectivity and functional multiplex data) is an ensemble-based graph analysis using connectivity and functional multiplex data.

%%% ¡description!
This graph analysis (AnalyzeEnsemble_CON_FUN_MP_WU) analyzes 
connectivity and functional multiplex data using weighted undirected graphs.

%%% ¡seealso!
SubjectCON_FUN_MP, MultiplexWU

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the ensemble-based graph analysis with connectivity and functional multiplex data.
%%%% ¡default!
'AnalyzeEnsemble_CON_FUN_MP_WU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis with connectivity and functional multiplex data.
%%%% ¡default!
'This graph analysis (AnalyzeEnsemble_CON_FUN_MP_WU) analyzes connectivity and functional multiplex data using weighted undirected graphs.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis with connectivity and functional multiplex data.
%%%% ¡settings!
'AnalyzeEnsemble_CON_FUN_MP_WU'

%%% ¡prop!
ID (data, string) is a few-letter code for the ensemble-based graph analysis with connectivity and functional multiplex data.
%%%% ¡default!
'AnalyzeEnsemble_CON_FUN_MP_WU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ensemble-based graph analysis with connectivity and functional multiplex data.
%%%% ¡default!
'AnalyzeEnsemble_CON_FUN_MP_WU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis with connectivity and functional multiplex data.
%%%% ¡default!
'AnalyzeEnsemble_CON_FUN_MP_WU notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON_FUN_MP.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_FUN_MP')

%%% ¡prop!
GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
%%%% ¡settings!
'MultiplexWU'

%%% ¡prop!
G_DICT (result, idict) is the multiplex (MultiplexWU) ensemble obtained from this analysis.
%%%% ¡settings!
'MultiplexWU'
%%%% ¡_default!
% % % IndexedDictionary('IT_CLASS', 'MultiplexWU')
%%%% ¡_calculate!
% % % g_dict = IndexedDictionary('IT_CLASS', 'MultiplexWU');
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
% % %     g = MultiplexWU( ...
% % %         'ID', ['g ' sub.get('ID')], ...
% % %         'B', A, ...
% % %         'BAS', ba ...
% % %         );
% % %     g_dict.add(g)
% % % end
% % % 
% % % value = g_dict;

%%% ¡prop!
ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
%%%% ¡_gui!
% % % pr = PPAnalyzeEnsembleMP_ME_DICT('EL', a, 'PROP', AnalyzeEnsemble_CON_FUN_MP_WU.ME_DICT, 'WAITBAR', true, varargin{:});

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

example_CON_FUN_MP_WU