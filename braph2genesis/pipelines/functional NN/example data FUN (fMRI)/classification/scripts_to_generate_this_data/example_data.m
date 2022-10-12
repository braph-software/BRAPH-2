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

%% Group 1 properties
% 5 modules of 18 nodes each

gr1_ts = cell(1, N_groups);

% initialize values for the WS model
K1 = [3 4 5 6 7];
beta1 = [0.02 0.1 0.5 0.8 1.0];

% initialize the indices where the matrices will be placed
indices1 = 1:1:18;
indices2 = 19:1:36;
indices3 = 37:1:54;
indices4 = 55:1:72;
indices5 = 73:1:90;
indices = {indices1; indices2; indices3; indices4; indices5};

% Loop to create ts for each subject
for i_gr1 = 1:1:N_groups

    % randomize the parameters
    K_temp = K1(randperm(length(K1)));
    beta_temp = beta1(randperm(length(beta1)));

    % initialize matrix for the subject
    A_full = zeros(N_nodes);

    % loop over each module
    for i_mod = 1:1:5
        A_full(indices{i_mod},indices{i_mod}) = full(adjacency(WattsStrogatz(18, K_temp(i_mod), beta_temp(i_mod))));
    end
    A_full(1:length(A_full)+1:numel(A_full)) = 1;

    % this is needed to make the matrices positive definite
    A_full = A_full*transpose(A_full);
    
    figure(1)
    imshow(A_full)
    % This matrix will be covariance matrices for the two groups
    % Specify the mean
    mu_gr1 = ones(1, length(A_full));

    % calculate time series
    R1 = mvnrnd(mu_gr1, A_full, N_tslength);

    % Normalize the time series
    mean_R1 = mean(R1);
    std_R1 = std(R1);
    R1 = (R1 - mean(R1)) ./ std(R1);

    % place in the array
    gr1_ts{1, i_gr1} = R1;

end

%% Group 2 properties
% 2 modules of 45 nodes each

gr2_ts = cell(1, N_groups);

% initialize values for the WS model
K2 = [3 7];
beta2 = [0.02 0.85];

% initialize the indices where the matrices will be placed
indices1 = 1:1:45;
indices2 = 46:1:90;
indices = {indices1; indices2};

% Loop to create ts for each subject
for i_gr2 = 1:1:N_groups

    % randomize the parameters
    K_temp = K2(randperm(length(K2)));
    beta_temp = beta2(randperm(length(beta2)));

    % initialize matrix for the subject
    A_full = zeros(N_nodes);
    % loop over each module
    for i_mod = 1:1:2
        A_full(indices{i_mod},indices{i_mod}) = full(adjacency(WattsStrogatz(45, K_temp(i_mod), beta_temp(i_mod))));
    end
    A_full(1:length(A_full)+1:numel(A_full)) = 1;

    % this is needed to make the matrices positive definite
    A_full = A_full*transpose(A_full);
    
    figure(1)
    imshow(A_full)
    % This matrix will be covariance matrices for the two groups
    % Specify the mean
    mu_gr2 = ones(1, length(A_full));

    % calculate time series
    R2 = mvnrnd(mu_gr2, A_full, N_tslength);

    % Normalize the time series
    mean_R2 = mean(R2);
    std_R2 = std(R2);
    R2 = (R2 - mean(R2)) ./ std(R2);

    % place in the array
    gr2_ts{1, i_gr2} = R2;

end
 
%% The subjects will be saved in a table - Specify row and column names
sub_Tags = strings(size(R2,1), 1);
for i_sub = 1:1:length(sub_Tags)
    sub_Tags(i_sub) = string(['subject' num2str(i_sub)]);
end
% column
% % reg_Tags = strings(1, size(R2,2));
% % for i_reg = 1:1:length(reg_Tags)
% %     reg_Tags(1, i_reg) = string(['Region_' num2str(i_reg)]);
% % end

%% Create the table - Group 1
tables_gr1 = cell(size(gr1_ts));
tables_gr2 = cell(size(gr1_ts));
mkdir('GroupName1');
mkdir('GroupName2');
for i_tab = 1:1:N_groups

    % create the table - group 1
    T_gr1 = array2table(gr1_ts{i_tab});
    tables_gr1{i_tab} = T_gr1;
    file_name = strcat("GroupName1/", sub_Tags(i_tab), ".xlsx");
    writetable(T_gr1, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
    
    % create the table - group 2
    T_gr2 = array2table(gr2_ts{i_tab});
    tables_gr2{i_tab} = T_gr2;
    file_name = strcat("GroupName2/", sub_Tags(i_tab), ".xlsx");
    writetable(T_gr2, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
end




