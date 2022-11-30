clear all
close all
clc

rng('default')  % For reproducibility

%% Specify the network parameters for the two groups
N_nodes = 90; % AAL atlas

%% Specify length of time series 
N_tslength = 200;

%% Specify number of subjects
N_groups = 100;

%% Group properties
% random N modules
gr_ts = cell(1, N_groups);

% Loop to create ts for each subject
for i_gr = 1:1:N_groups
    
    % initialize values for the WS model
    N_module = randi([1 8], 1);
    %N_module = 8;
    num_module(i_gr) = N_module;
    K_temp = 1:1:1+N_module-1;
    K = K_temp(randperm(N_module));
    beta = rand([1 N_module]);
    
    % initialize the indices where the matrices will be placed
    L_indice = floor(N_nodes/N_module);
    for j  = 1:1:N_module
        if j ~= N_module
            indices{j} = 1+(j-1)*L_indice:1+(j-1)*L_indice+L_indice-1;
        else
            indices{j} = 1+(j-1)*L_indice:N_nodes;
        end
    end

    % initialize matrix for the subject
    A_full = zeros(N_nodes);

    % loop over each module
    for i_mod = 1:1:N_module
        A_full(indices{i_mod},indices{i_mod}) = full(adjacency(WattsStrogatz(length(indices{i_mod}), K(i_mod), beta(i_mod))));
    end
    A_full(1:length(A_full)+1:numel(A_full)) = 1;

    % this is needed to make the matrices positive definite
    A_full = A_full*transpose(A_full);

    figure(1)
    imshow(A_full)

    % This matrix will be covariance matrices for the group
    % Specify the mean
    mu_gr = ones(1, length(A_full));

    % calculate time series
    R = mvnrnd(mu_gr, A_full, N_tslength);

    % Normalize the time series
    mean_R = mean(R);
    std_R = std(R);
    R = (R - mean(R)) ./ std(R);

    % place in the array
    gr_ts{1, i_gr} = R;
end

%% The subjects will be saved in a table - Specify row and column names
sub_Tags = strings(size(R, 1), 1);
for i_sub = 1:1:length(sub_Tags)
    sub_Tags(i_sub) = string(['subject' num2str(i_sub)]);
end

%% Create the table - Group 
tables_gr1 = cell(size(gr_ts));
mkdir('GroupName');
for i_tab = 1:1:N_groups

    T_gr = array2table(gr_ts{i_tab});
    tables_gr1{i_tab} = T_gr;
    file_name = strcat("GroupName/", sub_Tags(i_tab), ".xlsx");
    writetable(T_gr, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
end


%% covariate
% Age - radnomly drawn between 50 and 80 years old
Age_init = 50;
Age_fin  = 80;
Gr_Age = rescale(num_module, Age_init, Age_fin) + randi([-2 2], size(num_module));

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




