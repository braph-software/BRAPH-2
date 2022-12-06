clear all
close all
clc

rng('default')  % For reproducibility

%% Specify the network parameters for the two groups
N_nodes = 68; % Desikan atlas

K1 = 2; % degree (mean node degree is 2K) - group 1
beta1 = 0.05; % Rewiring probability - group 1

K2 = K1; % degree (mean node degree is 2K) - group 2
beta2 = 0.4; % Rewiring probability - group 2

K3 = K1; % degree (mean node degree is 2K) - group 3
beta3 = 1.0; % Rewiring probability - group 3

%% Create the three graphs
h1 = WattsStrogatz(N_nodes, K1, beta1);
h2 = WattsStrogatz(N_nodes, K2, beta2);
h3 = WattsStrogatz(N_nodes, K3, beta3);

%% Plot the two graphs for double-check
figure(1)
plot(h1, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
title(['Group 1: Graph with $N = $ ' num2str(N_nodes) ...
    ' nodes, $K = $ ' num2str(K1) ', and $\beta = $ ' num2str(beta1)], ...
    'Interpreter','latex')
axis equal

figure(2)
plot(h2, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
title(['Group 2: Graph with $N = $ ' num2str(N_nodes) ...
    ' nodes, $K = $ ' num2str(K2) ', and $\beta = $ ' num2str(beta2)], ...
    'Interpreter','latex')
axis equal

figure(3)
plot(h3, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
title(['Group 3: Graph with $N = $ ' num2str(N_nodes) ...
    ' nodes, $K = $ ' num2str(K2) ', and $\beta = $ ' num2str(beta2)], ...
    'Interpreter','latex')
axis equal

%% After visualizing 1 specific example, create the groups
N_groups = 50;
gr1_matrices = cell(1, N_groups);
gr2_matrices = cell(1, N_groups);
gr3_matrices = cell(1, N_groups);

%% Loop
for i = 1:1:N_groups

    % create three WS graphs
    h1 = WattsStrogatz(N_nodes, K1, beta1);
    h2 = WattsStrogatz(N_nodes, K2, beta2);
    h3 = WattsStrogatz(N_nodes, K3, beta3);

    % extract the adjacency matrix
    A1 = full(adjacency(h1));
    A2 = full(adjacency(h2));
    A3 = full(adjacency(h3));
    A1(1:length(A1)+1:numel(A1)) = 0;
    A2(1:length(A2)+1:numel(A2)) = 0;
    A3(1:length(A3)+1:numel(A3)) = 0;
    
    % make the binary adjacency matrix weighted
    r = 0 + (0.5 - 0)*rand(size(A1));
    diffA = A1 - r;
    A1(A1 ~= 0) = diffA(A1 ~= 0);
    diffA = A2 - r;
    A2(A2 ~= 0) = diffA(A2 ~= 0);
    diffA = A3 - r;
    A3(A3 ~= 0) = diffA(A3 ~= 0);

    figure(1)
    imshow(A1)
    imshow(A2)
    imshow(A3)

    % place matrices in cells
    gr1_matrices{1, i} = A1;
    gr2_matrices{1, i} = A2;
    gr3_matrices{1, i} = A3;

end

%% output
% hence, save subjects in table

% Specify row and column names as well as names

% Subject Tags (names of the file)
sub_Tags = strings(N_groups, 1);
for i_sub = 1:1:length(sub_Tags)
    sub_Tags(i_sub) = string(['subject' num2str(i_sub)]);
end



%% Create the table - Group 1
tables_gr1 = cell(size(gr1_matrices));
tables_gr2 = cell(size(gr1_matrices));

mkdir('GroupName1');
mkdir('GroupName2');
mkdir('GroupName3');

for i_tab = 1:1:N_groups

    % create the table - group 1
    T_gr1 = array2table(gr1_matrices{i_tab});
    tables_gr1{i_tab} = T_gr1;
    file_name = strcat("GroupName1/", sub_Tags(i_tab), ".xlsx");
    writetable(T_gr1, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)

    % create the table - group 2
    T_gr2 = array2table(gr2_matrices{i_tab});
    tables_gr2{i_tab} = T_gr2;
    file_name = strcat("GroupName2/", sub_Tags(i_tab), ".xlsx");
    writetable(T_gr2, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
    
    % create the table - group 3
    T_gr3 = array2table(gr3_matrices{i_tab});
    tables_gr3{i_tab} = T_gr3;
    file_name = strcat("GroupName3/", sub_Tags(i_tab), ".xlsx");
    writetable(T_gr3, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
end