%% ¡tests!

%%% ¡test!
%%%% ¡name!
% % % Create example files XLS
%%%% ¡code!
data_dir = [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP XLS'];
mkdir(data_dir);

% Brain Atlas
im_ba = ImporterBrainAtlasXLS('FILE', 'aal90_atlas.xlsx');
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

% Group 1 directories
gr1_name = 'CON_FUN_MP_Group_1_XLS';
gr1_dir = [data_dir filesep() gr1_name];
mkdir([gr1_dir '.CON']);
mkdir([gr1_dir '.FUN']);

% Group 1 - CON + VOIS
K1 = 2; % degree (mean node degree is 2K) - group 1
beta1 = 0.3; % Rewiring probability - group 1
vois1 = [
    {{'Subject ID'} {'Age'} {'Sex'}}
    {{} {} cell2str(sex_options)}
    ];
for i = 1:1:50 % subject number
    sub_id = ['SubjectCON_FUN_MP_' num2str(i)];
    
    h1 = WattsStrogatz(N, K1, beta1); % create two WS graph
    % figure(1) % Plot the two graphs to double-check
    % plot(h1, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
    % title(['Group 1: Graph with $N = $ ' num2str(N_nodes) ...
    %     ' nodes, $K = $ ' num2str(K1) ', and $\beta = $ ' num2str(beta1)], ...
    %     'Interpreter','latex')
    % axis equal

    A1 = full(adjacency(h1)); A1(1:length(A1)+1:numel(A1)) = 0; % extract the adjacency matrix
    r = 0 + (0.5 - 0)*rand(size(A1)); diffA = A1 - r; A1(A1 ~= 0) = diffA(A1 ~= 0); % make the adjacency matrix weighted
    A1 = max(A1, transpose(A1)); % make the adjacency matrix symmetric

    writetable(array2table(A1), [gr1_dir '.CON' filesep() sub_id '.CON.xlsx'], 'WriteVariableNames', false)
    
    % variables of interest
    vois1 = [vois1; {sub_id, randi(90), sex_options(randi(2))}];
end
writetable(table(vois1), [data_dir filesep() gr1_name '.vois.xlsx'], 'WriteVariableNames', false)

% Group 1 directories
gr2_name = 'CON_FUN_MP_Group_2_XLS';
gr2_dir = [data_dir filesep() gr2_name];
mkdir([gr2_dir '.CON']);
mkdir([gr2_dir '.FUN']);

% Group 2 - CON + VOIS
K2 = 2; % degree (mean node degree is 2K) - group 2
beta2 = 0.85; % Rewiring probability - group 2
vois2 = [
    {{'Subject ID'} {'Age'} {'Sex'}}
    {{} {} cell2str(sex_options)}
    ];
for i = 51:1:100
    sub_id = ['SubjectCON_FUN_MP_' num2str(i)];

    h2 = WattsStrogatz(N, K2, beta2);
    % figure(2)
    % plot(h2, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
    % title(['Group 2: Graph with $N = $ ' num2str(N_nodes) ...
    %     ' nodes, $K = $ ' num2str(K2) ', and $\beta = $ ' num2str(beta2)], ...
    %     'Interpreter','latex')
    % axis equal

    A2 = full(adjacency(h2)); A2(1:length(A2)+1:numel(A2)) = 0;
    r = 0 + (0.5 - 0)*rand(size(A2)); diffA = A2 - r; A2(A2 ~= 0) = diffA(A2 ~= 0);
    A2 = max(A2, transpose(A2));

    writetable(array2table(A2), [gr2_dir '.CON' filesep() sub_id '.CON.xlsx'], 'WriteVariableNames', false)
    
    % variables of interest
    vois2 = [vois2; {sub_id, randi(90), sex_options(randi(2))}];
end
writetable(table(vois2), [data_dir filesep() gr2_name '.vois.xlsx'], 'WriteVariableNames', false)

% reset RNG
rng(rng_settings_)

%%% ¡test_functions!
function h = WattsStrogatz(N,K,beta)
% H = WattsStrogatz(N,K,beta) returns a Watts-Strogatz model graph with N
% nodes, N*K edges, mean node degree 2*K, and rewiring probability beta.
%
% beta = 0 is a ring lattice, and beta = 1 is a random graph.

% Connect each node to its K next and previous neighbors. This constructs
% indices for a ring lattice.
s = repelem((1:N)',1,K);
t = s + repmat(1:K,N,1);
t = mod(t-1,N)+1;

% Rewire the target node of each edge with probability beta
for source=1:N
    switchEdge = rand(K, 1) < beta;
    
    newTargets = rand(N, 1);
    newTargets(source) = 0;
    newTargets(s(t==source)) = 0;
    newTargets(t(source, ~switchEdge)) = 0;
    
    [~, ind] = sort(newTargets, 'descend');
    t(source, switchEdge) = ind(1:nnz(switchEdge));
end

h = graph(s,t);
end