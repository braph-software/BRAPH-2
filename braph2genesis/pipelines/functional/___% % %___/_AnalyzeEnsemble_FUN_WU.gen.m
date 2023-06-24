%% ¡header!
AnalyzeEnsemble_FUN_WU < AnalyzeEnsemble (a, graph analysis with functional data) is an ensemble-based graph analysis using functional data.

%%% ¡description!
This graph analysis (AnalyzeEnsemble_FUN_WU) analyzes functional data 
using weighted undirected graphs.

%%% ¡seealso!
SubjectFUN, GraphWU

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the ensemble-based graph analysis with functional data.
%%%% ¡default!
'AnalyzeEnsemble_FUN_WU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis with functional data.
%%%% ¡default!
'This graph analysis (AnalyzeEnsemble_FUN_WU) analyzes functional data using weighted undirected graphs.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis with functional data.
%%% ¡settings!
'AnalyzeEnsemble_FUN_WU'

%%% ¡prop!
ID (data, string) is a few-letter code for the ensemble-based graph analysis with functional data.
%%%% ¡default!
'AnalyzeEnsemble_FUN_WU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ensemble-based graph analysis with functional data.
%%%% ¡default!
'AnalyzeEnsemble_FUN_WU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis with functional data.
%%%% ¡default!
'AnalyzeEnsemble_FUN_WU notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectFUN.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN')

%%% ¡prop!
GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
%%%% ¡settings!
'GraphWU'

%%% ¡prop!
G_DICT (result, idict) is the graph (GraphWU) ensemble obtained from this analysis.
%%%% ¡settings!
'GraphWU'
%%%% ¡_calculate!
% % % g_dict = IndexedDictionary('IT_CLASS', 'GraphWU');
% % % gr = a.get('GR');
% % % 
% % % T = a.get('REPETITION');
% % % fmin = a.get('F_MIN');
% % % fmax = a.get('F_MAX');
% % % 
% % % ba = BrainAtlas();
% % % if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0
% % %     ba = gr.get('SUB_DICT').getItem(1).get('BA');
% % % end
% % % 
% % % for i = 1:1:gr.get('SUB_DICT').length()
% % % 	sub = gr.get('SUB_DICT').getItem(i);
% % %     data = sub.getr('FUN');
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
% % %     A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'));
% % %     
% % %     g = GraphWU( ...
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
% % % pr = PPAnalyzeEnsemble_ME_DICT('EL', a, 'PROP', AnalyzeEnsemble_FUN_WU.ME_DICT, 'WAITBAR', true, varargin{:});

%% ¡props!

%%% ¡prop!
REPETITION (parameter, scalar) is the number of repetitions.
%%%% ¡default!
1

%%% ¡prop!
F_MIN (parameter, scalar) is the minimum frequency value.
%%%% ¡default!
0

%%% ¡prop!
F_MAX (parameter, scalar) is the maximum frequency value.
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
if ~isfile([fileparts(which('SubjectFUN')) filesep 'Example data FUN XLS' filesep 'atlas.xlsx'])
    test_ImporterGroupSubjectFUN_XLS % create example files
end

example_FUN_WU