clear all
close all
clc

rng('default')  % For reproducibility

%% Specify the network parameters for the two groups
N_nodes = 148; % Destrieux atlas

K1 = 4; % degree (mean node degree is 2K) - group 1
beta1 = 0.08; % Rewiring probability - group 1

K2 = K1; % degree (mean node degree is 2K) - group 2
beta2 = 0.7; % Rewiring probability - group 2

%% Create the two graphs
h1 = WattsStrogatz(N_nodes, K1, beta1);
h2 = WattsStrogatz(N_nodes, K2, beta2);

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

%% Extract the adjacency matrices for the two groups
A1 = full(adjacency(h1));
A2 = full(adjacency(h1));
A1(1:length(A1)+1:numel(A1)) = 1;
A2(1:length(A2)+1:numel(A2)) = 1;

% this is needed to make the matrices positive definite
A1 = A1*transpose(A1);
A2 = A2*transpose(A2);

figure(1)
imshow(A1)
imshow(A2)

%% These matrices will be covariance matrices for the two groups
% Specify the mean
mu_gr1 = ones(1, length(A1));
mu_gr2 = ones(1, length(A2));

%% Create time series for the two groups
N_groups = 50;
R1 = mvnrnd(mu_gr1, A1, N_groups);
R2 = mvnrnd(mu_gr2, A2, N_groups);

%% Normalize the time series
mean_R1 = mean(R1);
std_R1 = std(R1);
R1 = (R1 - mean(R1)) ./ std(R1);

mean_R2 = mean(R2);
std_R2 = std(R2);
R2 = (R2 - mean(R2)) ./ std(R2);

%% We need only positive values
R1 = R1 + abs(min(min(R1)));
R2 = R2 + abs(min(min(R2)));

%% The subjects will be saved in a table - Specify row and column names
% row
sub_Tags = strings(size(R1,1), 1);
for i_sub = 1:1:length(sub_Tags)
    sub_Tags(i_sub) = string(['sub_' num2str(i_sub)]);
end
label_Tags = strings(size(R1,1), 1);
for i_sub = 1:1:length(label_Tags)
    label_Tags(i_sub) = string(['Label ' num2str(i_sub)]);
end
note_Tags = strings(size(R1,1), 1);
for i_sub = 1:1:length(note_Tags)
    note_Tags(i_sub) = string(['Note ' num2str(i_sub)]);
end

% column
reg_Tags = strings(1, size(R1,2) + 3);
reg_Tags(1, 1) = 'ID';
reg_Tags(1, 2) = 'Label';
reg_Tags(1, 3) = 'Notes';
for i_reg = 4:1:length(reg_Tags)
    reg_Tags(1, i_reg) = string(['Region_' num2str(i_reg-3)]);
end
%% Create the table - Group 1
R1 = [cellstr(sub_Tags) cellstr(label_Tags) cellstr(note_Tags) num2cell(R1)];
T_group1 = array2table(R1, 'VariableNames', reg_Tags);

%% Create the table - Group 2
R2 = [cellstr(sub_Tags) cellstr(label_Tags) cellstr(note_Tags) num2cell(R2)];
T_group2 = array2table(R2, 'VariableNames', reg_Tags);

%% Create covariates
% Age - radnomly drawn between 50 and 80 years old
Age_init = 50;
Age_fin  = 80;
Gr1_Age = floor(Age_init + (Age_fin-Age_init) .* rand(N_groups, 1));
Gr2_Age = ceil(Age_init + (Age_fin-Age_init) .* rand(N_groups, 1));

% Sex
gr1_randsex = randn(N_groups, 1);
gr2_randsex = randn(N_groups, 1);
Gr1_Sex = num2cell(gr1_randsex);
Gr2_Sex = num2cell(gr2_randsex);

Gr1_Sex(gr1_randsex <= 0) = {'Male'};
Gr1_Sex(gr1_randsex > 0) = {'Female'};
Gr2_Sex(gr2_randsex <= 0) = {'Male'};
Gr2_Sex(gr2_randsex > 0) = {'Female'};

% Education - draw from normal distribution
Edu_init = 5;
Edu_fin = 11;
Gr1_Edu = floor(Edu_init + (Edu_fin-Edu_init) .* abs(randn(N_groups, 1)));
Gr2_Edu = ceil(Edu_init + (Edu_fin-Edu_init) .* abs(randn(N_groups, 1)));

% covariate tabble
sub_Tags = strings(N_groups, 1);
for i_sub = 1:1:length(sub_Tags)
    sub_Tags(i_sub) = string(['sub_' num2str(i_sub)]);
end
column_Tags = {'ID' 'age', 'sex', 'edu'};
gr1_R = [cellstr(sub_Tags) num2cell(Gr1_Age) Gr1_Sex num2cell(Gr1_Edu)];
gr2_R = [cellstr(sub_Tags) num2cell(Gr2_Age) Gr2_Sex num2cell(Gr2_Edu)];

C_group1 = array2table(gr1_R, 'VariableNames', column_Tags);
C_group2 = array2table(gr2_R, 'VariableNames', column_Tags);

%% output
writetable(T_group1, 'ST_Group_1.xlsx', 'WriteRowNames', true, 'Sheet', 1)
writetable(C_group1, 'ST_Group_1.xlsx', 'WriteRowNames', true, 'Sheet', 2)
writetable(T_group2, 'ST_Group_2.xlsx', 'WriteRowNames', true, 'Sheet', 1)
writetable(C_group2, 'ST_Group_2.xlsx', 'WriteRowNames', true, 'Sheet', 2)




