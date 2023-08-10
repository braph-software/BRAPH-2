clear all
close all
clc

rng('default')  % For reproducibility

%% Specify the network parameters for the two groups
N_nodes = 68; % Desikan atlas

K = 2; % degree (mean node degree is 2K)
beta_init = 0.2; % Rewiring probability


%% Create the graph
h = WattsStrogatz(N_nodes, K, beta_init);

%% Plot the graph for double-check
figure(1)
plot(h, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
title(['Group: Graph with $N = $ ' num2str(N_nodes) ...
    ' nodes, $K = $ ' num2str(K) ', and $\beta = $ ' num2str(beta_init)], ...
    'Interpreter','latex')
axis equal

%% After visualizing 1 specific example, create the groups
N_groups = 50;
gr_matrices = cell(1, N_groups);

%% Loop
for i = 1:1:N_groups

    % create WS graphs with random beta
    beta(i) = rand(1);
    h = WattsStrogatz(N_nodes, K, beta(i));
%     if(mod(i, 1) == 0)
%         figure(1)
%         plot(h, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
%         title(['Group: Graph with $N = $ ' num2str(N_nodes) ...
%             ' nodes, $K = $ ' num2str(K) ', and $\beta = $ ' num2str(beta(i))], ...
%             'Interpreter','latex')
%         axis equal
%     end
    % extract the adjacency matrix
    A = full(adjacency(h));
    A(1:length(A)+1:numel(A)) = 0;
    % make the binary adjacency matrix weighted
    r = 0 + (0.5 - 0)*rand(size(A));
    diffA = A - r;
    A(A ~= 0) = diffA(A ~= 0);
    figure(1)
    imshow(A)

    % place matrices in cells
    gr_matrices{1, i} = A;

end

%% output
% hence, save subjects in table

% Specify row and column names as well as names

% Subject Tags (names of the file)
sub_Tags = strings(N_groups, 1);
for i_sub = 1:1:length(sub_Tags)
    sub_Tags(i_sub) = string(['subject' num2str(i_sub)]);
end


%% Create the table
tables_gr = cell(size(gr_matrices));

mkdir('GroupName');

for i_tab = 1:1:N_groups
    % create the table - group 1
    T_gr = array2table(gr_matrices{i_tab});
    file_name = strcat("GroupName/", sub_Tags(i_tab), ".xlsx");
    writetable(T_gr, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
end

%% covariate
% Age - radnomly drawn between 50 and 80 years old
Age_init = 50;
Age_fin  = 80;
Gr_Age = rescale(beta, Age_init, Age_fin);

% Sex
gr_randsex = randn(N_groups, 1);
Gr_Sex = num2cell(gr_randsex);

Gr_Sex(gr_randsex <= 0) = {'Male'};
Gr_Sex(gr_randsex > 0) = {'Female'};

% Education - draw from normal distribution
Edu_init = 5;
Edu_fin = 11;
Gr_Edu = floor(Edu_init + (Edu_fin-Edu_init) .* abs(randn(N_groups, 1)));

% covariate tabble
sub_Tags = strings(N_groups, 1);
for i_sub = 1:1:length(sub_Tags)
    sub_Tags(i_sub) = string(['subject' num2str(i_sub)]);
end
column_Tags = {'ID' 'age', 'sex', 'edu'};
gr_R = [cellstr(sub_Tags) num2cell(Gr_Age') Gr_Sex num2cell(Gr_Edu)];

C_group = array2table(gr_R, 'VariableNames', column_Tags);

%% output
mkdir('GroupName/covariates');
writetable(C_group, 'GroupName/covariates/GroupName_covariates.xlsx', 'WriteRowNames', true)