clear all
close all
clc

rng('default')  % For reproducibility

%% Specify the network parameters for the two groups
N_nodes = 68; % Desikan atlas

K11 = 4; % degree (mean node degree is 2K) - group 1 layer 1
K12 = 5; % degree (mean node degree is 2K) - group 1 layer 2
beta1 = 0.08; % Rewiring probability - group 1

K21 = K11; % degree (mean node degree is 2K) - group 2 layer 1
K22 = 2; % degree (mean node degree is 2K) - group 2 layer 2
beta2 = 0.9; % Rewiring probability - group 2

%% Create the four graphs
h11 = WattsStrogatz(N_nodes, K11, beta1);
h12 = WattsStrogatz(N_nodes, K12, beta1);
h21 = WattsStrogatz(N_nodes, K21, beta2);
h22 = WattsStrogatz(N_nodes, K22, beta2);

%% Plot the four graphs for double-check
figure(1)
plot(h11, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
title(['Group 1: Graph with $N = $ ' num2str(N_nodes) ...
    ' nodes, $K = $ ' num2str(K11) ', and $\beta = $ ' num2str(beta1)], ...
    'Interpreter','latex')
axis equal

figure(2)
plot(h12, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
title(['Group 1: Graph with $N = $ ' num2str(N_nodes) ...
    ' nodes, $K = $ ' num2str(K12) ', and $\beta = $ ' num2str(beta1)], ...
    'Interpreter','latex')
axis equal

figure(3)
plot(h21, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
title(['Group 2: Graph with $N = $ ' num2str(N_nodes) ...
    ' nodes, $K = $ ' num2str(K21) ', and $\beta = $ ' num2str(beta2)], ...
    'Interpreter','latex')
axis equal

figure(4)
plot(h22, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
title(['Group 2: Graph with $N = $ ' num2str(N_nodes) ...
    ' nodes, $K = $ ' num2str(K22) ', and $\beta = $ ' num2str(beta2)], ...
    'Interpreter','latex')
axis equal

%% Extract the adjacency matrices for the two groups
A11 = full(adjacency(h11));
A12 = full(adjacency(h12));
A21 = full(adjacency(h21));
A22 = full(adjacency(h22));
A11(1:length(A11)+1:numel(A11)) = 1;
A12(1:length(A12)+1:numel(A12)) = 1;
A21(1:length(A21)+1:numel(A21)) = 1;
A22(1:length(A22)+1:numel(A22)) = 1;

% this is needed to make the matrices positive definite
A11 = A11*transpose(A11);
A12 = A12*transpose(A12);
A21 = A21*transpose(A21);
A22 = A22*transpose(A22);

figure(1)
imshow(A11)
figure(2)
imshow(A12)
figure(3)
imshow(A21)
figure(4)
imshow(A22)

%% These matrices will be covariance matrices for the two groups
% Specify the mean
mu_gr11 = ones(1, length(A11));
mu_gr12 = ones(1, length(A12));
mu_gr21 = ones(1, length(A21));
mu_gr22 = ones(1, length(A22));

%% Create time series for the two groups
N_groups = 50;
R11 = mvnrnd(mu_gr11, A11, N_groups);
R12 = mvnrnd(mu_gr12, A12, N_groups);
R21 = mvnrnd(mu_gr21, A21, N_groups);
R22 = mvnrnd(mu_gr22, A22, N_groups);

%% Normalize the time series
% % % mean_R11 = mean(R11);
% % % std_R11 = std(R11);
% % % R11 = (R11 - mean(R11)) ./ std(R11);
% % % 
% % % mean_R12 = mean(R12);
% % % std_R12 = std(R12);
% % % R12 = (R12 - mean(R12)) ./ std(R12);
% % % 
% % % mean_R21 = mean(R21);
% % % std_R21 = std(R21);
% % % R21 = (R21 - mean(R21)) ./ std(R21);
% % % 
% % % mean_R22 = mean(R22);
% % % std_R22 = std(R22);
% % % R22 = (R22 - mean(R22)) ./ std(R22);


%% We need only positive values
R11 = R11 + abs(min(min(R11)));
R12 = R12 + abs(min(min(R12)));
R21 = R21 + abs(min(min(R21)));
R22 = R22 + abs(min(min(R22)));

%% The subjects will be saved in a table - Specify row and column names
% row
sub_Tags = strings(size(R11,1), 1);
for i_sub = 1:1:length(sub_Tags)
    sub_Tags(i_sub) = string(['sub_' num2str(i_sub)]);
end
label_Tags = strings(size(R11,1), 1);
for i_sub = 1:1:length(label_Tags)
    label_Tags(i_sub) = string(['Label ' num2str(i_sub)]);
end
note_Tags = strings(size(R11,1), 1);
for i_sub = 1:1:length(note_Tags)
    note_Tags(i_sub) = string(['Note ' num2str(i_sub)]);
end

% column
reg_Tags = strings(1, size(R11,2) + 3);
reg_Tags(1, 1) = 'ID';
reg_Tags(1, 2) = 'Label';
reg_Tags(1, 3) = 'Notes';
for i_reg = 4:1:length(reg_Tags)
    reg_Tags(1, i_reg) = string(['Region_' num2str(i_reg-3)]);
end
%% Create the table - Group 1
R11 = [cellstr(sub_Tags) cellstr(label_Tags) cellstr(note_Tags) num2cell(R11)];
T_group11 = array2table(R11, 'VariableNames', reg_Tags);

R12 = [cellstr(sub_Tags) cellstr(label_Tags) cellstr(note_Tags) num2cell(R12)];
T_group12 = array2table(R12, 'VariableNames', reg_Tags);

%% Create the table - Group 2
R21 = [cellstr(sub_Tags) cellstr(label_Tags) cellstr(note_Tags) num2cell(R21)];
T_group21 = array2table(R21, 'VariableNames', reg_Tags);

R22 = [cellstr(sub_Tags) cellstr(label_Tags) cellstr(note_Tags) num2cell(R22)];
T_group22 = array2table(R22, 'VariableNames', reg_Tags);

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
mkdir('GroupName1');
mkdir('GroupName2');

% Group 1
writetable(T_group11, 'ST_MP_Group_1/layer1.xlsx', 'WriteRowNames', true, 'Sheet', 1)
writetable(C_group1, 'ST_MP_Group_1/layer1.xlsx', 'WriteRowNames', true, 'Sheet', 2)
writetable(T_group12, 'ST_MP_Group_1/layer2.xlsx', 'WriteRowNames', true, 'Sheet', 1)

% Group 2
writetable(T_group21, 'ST_MP_Group_2/layer1.xlsx', 'WriteRowNames', true, 'Sheet', 1)
writetable(C_group2, 'ST_MP_Group_2/layer1.xlsx', 'WriteRowNames', true, 'Sheet', 2)
writetable(T_group22, 'ST_MP_Group_2/layer2.xlsx', 'WriteRowNames', true, 'Sheet', 1)



