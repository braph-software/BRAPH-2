%% ¡header!
NNDataPoint_CON_WU_REG < NNDataPoint (dp, neural network data point) is a datapoint for neural network analysis.

%%% ¡description!
NNDataPoint_CON_WU_REG contains the input and target for neural network analysis.
The input is derived from the adjacency matrice of Graph WU, which corresponds the subject with the connectivity data.
The target is obtained from the covariate list to be the dependnt variables for regrssion task.

%% ¡props_update!
%%% ¡prop!
NAME (constant, string) is the name of the datapoint for neural network analysis.
%%%% ¡default!
'NNDataPoint_CON_WU_REG'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the datapoint for neural network analysis.
%%%% ¡default!
'NNDataPoint_CON_WU_REG contains the input and target for neural network analysis. The input is obtained from the adjacency matrice of Graph WU which take in the connectivity data. The target is obtained from the covariate list to be the dependnt variable.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the datapoint for neural network analysis.
%%%% ¡settings!
'NNDataPoint_CON_WU_REG'

%%% ¡prop!
ID (data, string) is a few-letter code for the datapoint for neural network analysis.
%%%% ¡default!
'NNDataPoint_CON_WU_REG ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the datapoint for neural network analysis.
%%%% ¡default!
'NNDataPoint_CON_WU_REG label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the datapoint for neural network analysis.
%%%% ¡default!
'NNDataPoint_CON_WU_REG notes'

%% ¡props!

%%% ¡prop!
SUB (data, item) is a subject with connectivity data.
%%%% ¡settings!
'SubjectCON'

%%% ¡prop!
DEPENDANT_VARIABLES (parameter, stringlist) is a list of dependant variables to be used as regression targets.

%%% ¡prop!
INPUT (result, cell) is the input value for this data point.
%%%% ¡calculate!
g = GraphWU( ...
    'ID', ['g ' dp.get('SUB').get('ID')], ...
    'B', Callback('EL', dp.get('SUB'), 'TAG', 'CON') ...
    );

value = g.get('A');
    
%%% ¡prop!
TARGET (result, cell) is the target value for this data point.
%%%% ¡calculate!
value = cellfun(@(x) dp.get('SUB').get('VOI_DICT').get('IT', x).get('V'), dp.get('DEPENDANT_VARIABLES'), 'UniformOutput', false);
					
%% ¡tests!

%%% ¡test!
%%%% ¡name!
Create example files for regression
%%%% ¡code!
data_dir = [fileparts(which('NNDataPoint_CON_WU_REG')) filesep 'Example data NN REGRESSION CON XLS'];
if ~isdir(data_dir)
    mkdir(data_dir);

    % Brain Atlas
    im_ba = ImporterBrainAtlasXLS('FILE', 'desikan_atlas.xlsx');
    ba = im_ba.get('BA');
    ex_ba = ExporterBrainAtlasXLS( ...
        'BA', ba, ...
        'FILE', [data_dir filesep() 'atlas.xlsx'] ...
        );
    ex_ba.get('SAVE')
    N = ba.get('BR_DICT').get('LENGTH');

    % saves RNG
    rng_settings_ = rng(); rng('default')

    sex_options = {'Female' 'Male'};

    % Group 
    K = 2; % degree (mean node degree is 2K)
    beta = 0.3; % Rewiring probability
    gr_name = 'CON_Group_XLS';
    gr_dir = [data_dir filesep() gr_name];
    mkdir(gr_dir);
    vois = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    for i = 1:1:100 % subject number
        sub_id = ['SubjectCON_' num2str(i)];
        % create WS graphs with random beta
        beta(i) = rand(1);
        h = WattsStrogatz(N, K, beta(i)); % create WS graph
        % figure(1) % Plot the two graphs to double-check
        % plot(h1, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
        % title(['Group 1: Graph with $N = $ ' num2str(N_nodes) ...
        %     ' nodes, $K = $ ' num2str(K1) ', and $\beta = $ ' num2str(beta1)], ...
        %     'Interpreter','latex')
        % axis equal

        A = full(adjacency(h)); A(1:length(A)+1:numel(A)) = 0; % extract the adjacency matrix
        r = 0 + (0.5 - 0)*rand(size(A)); diffA = A - r; A(A ~= 0) = diffA(A ~= 0); % make the adjacency matrix weighted
        A = max(A, transpose(A)); % make the adjacency matrix symmetric

        writetable(array2table(A), [gr_dir filesep() sub_id '.xlsx'], 'WriteVariableNames', false)

        % variables of interest
        vois = [vois; {sub_id, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois), [data_dir filesep() gr_name '.vois.xlsx'], 'WriteVariableNames', false)

    % reset RNG
    rng(rng_settings_)
end
%%% ¡test_functions!
function h = WattsStrogatz(N, K, beta)
% H = WattsStrogatz(N,K,beta) returns a Watts-Strogatz model graph with N
% nodes, N*K edges, mean node degree 2*K, and rewiring probability beta.
%
% beta = 0 is a ring lattice, and beta = 1 is a random graph.

% Connect each node to its K next and previous neighbors. This constructs
% indices for a ring lattice.
    s = repelem((1:N)', 1, K);
    t = s + repmat(1:K, N, 1);
    t = mod(t - 1, N) + 1;
    
    % Rewire the target node of each edge with probability beta
    for source = 1:N
        switchEdge = rand(K, 1) < beta;
        
        newTargets = rand(N, 1);
        newTargets(source) = 0;
        newTargets(s(t == source)) = 0;
        newTargets(t(source, ~switchEdge)) = 0;
        
        [~, ind] = sort(newTargets, 'descend');
        t(source, switchEdge) = ind(1:nnz(switchEdge));
    end
    
    h = graph(s,t);
end

%%% ¡test! 
%%%% ¡name!
Create a NNData containg NNDataPoint_CON_WU_REG 

% %%% !test!
% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_CON_WU_REG')) filesep 'Example data NN REGRESSION CON XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Groups of SubjectCON
im_gr = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_WU_REG')) filesep 'Example data NN REGRESSION CON XLS' filesep 'CON_Group_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr = im_gr.get('GR');

% create a NNData
it_list = cellfun(@(x) NNDataPoint_CON_WU_REG( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'DEPENDANT_VARIABLES', x.get('VOI_DICT').get('KEYS')), ...
    gr.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

dp_list = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_CON_WU_REG', ...
        'IT_LIST', it_list ...
        );

d = NNData( ...
    'DP_CLASS', 'NNDataPoint_CON_WU_REG', ...
    'DP_DICT', dp_list ...
    );

% Check whether the number of inputs matches
assert(length(d.get('INPUTS')) == gr.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_CON_WU_REG:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_CON_WU_REG does not construct the dataset correctly. The number of the inputs should be same as the number of imported subjects.' ...
		)

% Check whether the number of targets matches
assert(length(d.get('TARGETS')) == gr.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_CON_WU_REG:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_CON_WU_REG does not construct the dataset correctly. The number of the targets should be same as the number of imported subjects.' ...
		)

% Check whether the content of input for a single datapoint matches
index = randi([1 gr.get('SUB_DICT').get('LENGTH')]);
individual_input = d.get('DP_DICT').get('IT', index);
known_input = GraphWU( ...
    'ID', ['g ' gr.get('SUB_DICT').get('IT', index).get('ID')], ...
    'B', Callback('EL', gr.get('SUB_DICT').get('IT', 1), 'TAG', 'CON') ...
    ).get('A');

assert(length(d.get('TARGETS')) == gr.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_CON_WU_REG:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_CON_WU_REG does not construct the dataset correctly. The input value is not derived correctly.' ...
		)
