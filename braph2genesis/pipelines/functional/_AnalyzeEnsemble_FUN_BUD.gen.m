%% ¡header!
AnalyzeEnsemble_FUN_BUD < AnalyzeEnsemble (a, graph analysis with functional data of fixed density) is an ensemble-based graph analysis using functional data of fixed density.

%%% ¡description!
This graph analysis (AnalyzeEnsemble_FUN_BUD) analyzes functional data 
using binary undirected multigraphs with fixed densities.

%%% ¡seealso!
SubjectFUN, MultigraphBUD

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_BUD.ID
%%%% ¡title!
Analysis ID

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_BUD.LABEL
%%%% ¡title!
Analysis NAME

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_BUD.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_BUD.GR
%%%% ¡title!
SUBJECT GROUP

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_BUD.DENSITIES
%%%% ¡title!
DENSITIES [0% ... 100%]

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_BUD.REPETITION
%%%% ¡title!
REPETITION TIME [s]

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_BUD.F_MIN
%%%% ¡title!
MIN FREQUENCY [Hz]

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_BUD.F_MAX
%%%% ¡title!
MAX FREQUENCY [Hz]

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_BUD.CORRELATION_RULE
%%%% ¡title!
CORRELATION RULE

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_BUD.NEGATIVE_WEIGHT_RULE
%%%% ¡title!
NEGATIVE WEIGHTS RULE

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_BUD.ME_DICT
%%%% ¡title!
Group-averaged MEASURES

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_BUD.G_DICT
%%%% ¡title!
Individual GRAPHS

%%% ¡prop!
%%%% ¡id!
AnalyzeEnsemble_FUN_BUD.NOTES
%%%% ¡title!
Analysis NOTES

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the ensemble-based graph analysis with functional data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_FUN_BUD'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ensemble-based graph analysis with functional data of fixed density.
%%%% ¡default!
'This graph analysis (AnalyzeEnsemble_FUN_BUD) analyzes functional data using binary undirected multigraphs with fixed densities.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ensemble-based graph analysis with functional data of fixed density.
%%% ¡settings!
'AnalyzeEnsemble_FUN_BUD'

%%% ¡prop!
ID (data, string) is a few-letter code for the ensemble-based graph analysis with functional data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_FUN_BUD ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ensemble-based graph analysis with functional data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_FUN_BUD label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ensemble-based graph analysis with functional data of fixed density.
%%%% ¡default!
'AnalyzeEnsemble_FUN_BUD notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectFUN.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN')

%%% ¡prop!
GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
%%%% ¡settings!
'MultigraphBUD'

%%% ¡prop!
G_DICT (result, idict) is the graph (MultigraphBUD) ensemble obtained from this analysis.
%%%% ¡settings!
'MultigraphBUD'
%%%% ¡_calculate!
% % % % g_dict = IndexedDictionary('IT_CLASS', 'MultigraphBUD');
% % % % gr = a.get('GR');
% % % % 
% % % % ba = BrainAtlas();
% % % % if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0
% % % %     ba = gr.get('SUB_DICT').getItem(1).get('BA');
% % % % end
% % % % 
% % % % T = a.get('REPETITION');
% % % % fmin = a.get('F_MIN');
% % % % fmax = a.get('F_MAX');
% % % % densities = a.get('DENSITIES'); % this is a vector
% % % % for i = 1:1:gr.get('SUB_DICT').length()
% % % % 	sub = gr.get('SUB_DICT').getItem(i);
% % % %     data = sub.getr('FUN');
% % % %     fs = 1 / T;
% % % %     
% % % %     if fmax > fmin && T > 0
% % % %         NFFT = 2 * ceil(size(data, 1) / 2);
% % % %         ft = fft(data, NFFT);  % Fourier transform
% % % %         f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
% % % %         ft(f < fmin | f > fmax, :) = 0;
% % % %         data = ifft(ft, NFFT);
% % % %     end
% % % %     
% % % %     A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'));      
% % % %     
% % % %     g = MultigraphBUD( ...
% % % %         'ID', ['g ' sub.get('ID')], ...
% % % %         'B', A, ...
% % % %         'DENSITIES', densities, ...
% % % %         'LAYERTICKS', densities, ...
% % % %         'BAS', ba ...
% % % %         );
% % % %     g_dict.add(g)
% % % % 
% % % %     if isa(a.getr('TEMPLATE'), 'NoValue')
% % % %         g.set('TEMPLATE', a.memorize('GRAPH_TEMPLATE'))        
% % % %     else
% % % %         g.set('TEMPLATE', a.get('TEMPLATE').memorize('GRAPH_TEMPLATE'))
% % % %     end
% % % % end
% % % % 
% % % % value = g_dict;

%%% ¡prop!
ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
%%%% ¡_gui!
% % % pr = PPAnalyzeEnsemble_ME_DICT('EL', a, 'PROP', AnalyzeEnsemble_FUN_BUD.ME_DICT, 'WAITBAR', true, varargin{:});

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

%%% ¡prop!
DENSITIES (parameter, rvector) is the vector of densities.
%%%% ¡default!
[1:1:10]
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', a, 'PROP', AnalyzeEnsemble_FUN_BUD.DENSITIES, ...
    'MIN', 0, 'MAX', 100, ...
    'DEFAULT', AnalyzeEnsemble_FUN_BUD.getPropDefault('DENSITIES'), ...
    varargin{:});

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

example_FUN_BUD