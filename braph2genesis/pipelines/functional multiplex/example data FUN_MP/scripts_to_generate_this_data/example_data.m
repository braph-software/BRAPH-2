clear all
close all
clc

rng('default')  % For reproducibility

%% Specify the network parameters for the two groups
N_nodes = 90; % AAL atlas

%% Specify length of time series 
N_tslength = 200;

%% Specify number of subjects
N_groups = 50;

%% Group 1 properties
gr1_ts1 = cell(1, N_groups); % 5 modules of 18 nodes each
gr1_ts2 = cell(1, N_groups); % 4 modules: 2 of 22 nodes each and 2 of 23 nodes each
gr1_ts3 = cell(1, N_groups); % 3 modules of 30 nodes each

% initialize values for the WS model
K1 = [3 4 5 6 7];
K2 = [3 4 5 6];
K3 = [4 5 7];
beta1 = [0.02 0.1 0.3 0.5 0.8];
beta2 = [0.02 0.1 0.3 0.4];
beta3 = [0.1 0.3 0.8];

% initialize the indices where the matrices will be placed
indices1 = {1:18; 19:36; 37:54; 55:72; 73:90};
indices2 = {1:22; 23:44; 45:67; 68:90};
indices3 = {1:30; 31:60; 61:90};

% Loop to create ts for each subject
for i_gr1 = 1:1:N_groups

    % randomize the parameters
    K_temp = K1(randperm(length(K1)));
    beta_temp = beta1(randperm(length(beta1)));
    
    K_temp2 = K2(randperm(length(K2)));
    beta_temp2 = beta2(randperm(length(beta2)));
    
    K_temp3 = K3(randperm(length(K3)));
    beta_temp3 = beta3(randperm(length(beta3)));

    % initialize matrix for the subject
    A_full1 = zeros(N_nodes);
    A_full2 = zeros(N_nodes);
    A_full3 = zeros(N_nodes);

    % loop over each module
    % layer 1
    for i_mod = 1:1:5
        A_full1(indices1{i_mod},indices1{i_mod}) = full(adjacency(WattsStrogatz(18, K_temp(i_mod), beta_temp(i_mod))));
    end
    % layer 2
    for i_mod = 1:1:2
        A_full2(indices2{i_mod},indices2{i_mod}) = full(adjacency(WattsStrogatz(22, K_temp2(i_mod), beta_temp2(i_mod))));
    end
    for i_mod = 3:1:4
        A_full2(indices2{i_mod},indices2{i_mod}) = full(adjacency(WattsStrogatz(23, K_temp2(i_mod), beta_temp2(i_mod))));
    end
    % layer 3
    for i_mod = 1:1:3
        A_full3(indices3{i_mod},indices3{i_mod}) = full(adjacency(WattsStrogatz(30, K_temp3(i_mod), beta_temp3(i_mod))));
    end
    A_full1(1:length(A_full1)+1:numel(A_full1)) = 1;
    A_full2(1:length(A_full2)+1:numel(A_full2)) = 1;
    A_full3(1:length(A_full3)+1:numel(A_full3)) = 1;

    % this is needed to make the matrices positive definite
    A_full1 = A_full1*transpose(A_full1);
    A_full2 = A_full2*transpose(A_full2);
    A_full3 = A_full3*transpose(A_full3);
    
    figure(1)
    imshow(A_full1)
    figure(2)
    imshow(A_full2)
    figure(3)
    imshow(A_full3)


    % This matrix will be covariance matrices for the two groups
    % Specify the mean
    mu_gr11 = ones(1, length(A_full1));
    mu_gr12 = ones(1, length(A_full2));
    mu_gr13 = ones(1, length(A_full3));
     
    % calculate time series
    R11 = mvnrnd(mu_gr11, A_full1, N_tslength);
    R12 = mvnrnd(mu_gr12, A_full2, N_tslength);
    R13 = mvnrnd(mu_gr13, A_full3, N_tslength);
    
    % Normalize the time series
    R11 = (R11 - mean(R11)) ./ std(R11);
    R12 = (R12 - mean(R12)) ./ std(R12);
    R13 = (R13 - mean(R13)) ./ std(R13);
    
    % place in the array
    gr1_ts1{1, i_gr1} = R11;
    gr1_ts2{1, i_gr1} = R12;
    gr1_ts3{1, i_gr1} = R13;
end

%% Group 2 properties
% 2 modules of 45 nodes each

gr2_ts1 = cell(1, N_groups);
gr2_ts2 = cell(1, N_groups);
gr2_ts3 = cell(1, N_groups);

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
    A_full1 = zeros(N_nodes);

    % loop over each module
    for i_mod = 1:1:2
    A_full1(indices{i_mod},indices{i_mod}) = full(adjacency(WattsStrogatz(45, K_temp(i_mod), beta_temp(i_mod))));
    end
    A_full1(1:length(A_full1)+1:numel(A_full1)) = 1;

    % this is needed to make the matrices positive definite
    A_full1 = A_full1*transpose(A_full1);
    
    % 70% of connections kept
    density = 70;
    A_full2 = A_full1;
    sorted_vector = sort(A_full2(:));
    index = round(length(sorted_vector) * (100 - density) / 100);
    if index == 0
        threshold = sorted_vector(1) - eps;
    elseif index >= length(sorted_vector)
        threshold = sorted_vector(end) + eps;
    else
        threshold = sorted_vector(index);
    end
    % Calculates thresholded graph
    A_full2(A_full2 < threshold) = 0;
    A_full2 = A_full2*transpose(A_full2);
    
    % 40% of connections kept
    density = 40;
    A_full3 = A_full1;
    sorted_vector = sort(A_full3(:));
    index = round(length(sorted_vector) * (100 - density) / 100);
    if index == 0
        threshold = sorted_vector(1) - eps;
    elseif index >= length(sorted_vector)
        threshold = sorted_vector(end) + eps;
    else
        threshold = sorted_vector(index);
    end
    % Calculates thresholded graph
    A_full3(A_full3 < threshold) = 0;
    A_full3 = A_full3*transpose(A_full3);

    figure(1)
    imshow(A_full1)
    figure(2)
    imshow(A_full2)
    figure(3)
    imshow(A_full3)

    % This matrix will be covariance matrices for the two groups
    % Specify the mean
    mu_gr21 = ones(1, length(A_full1));
    mu_gr22 = ones(1, length(A_full2));
    mu_gr23 = ones(1, length(A_full3));

    % calculate time series
    R21 = mvnrnd(mu_gr21, A_full1, N_tslength);
    R22 = mvnrnd(mu_gr22, A_full2, N_tslength);
    R23 = mvnrnd(mu_gr23, A_full3, N_tslength);    
    
    % Normalize the time series
    R21 = (R21 - mean(R21)) ./ std(R21);
    R22 = (R22 - mean(R22)) ./ std(R22);
    R23 = (R23 - mean(R23)) ./ std(R23);

    % place in the array
    gr2_ts1{1, i_gr2} = R21;
    gr2_ts2{1, i_gr2} = R22;
    gr2_ts3{1, i_gr2} = R23;

end
 
%% The subjects will be saved in a table - Specify row and column names
sub_Tags = strings(size(R21,1), 1);
for i_sub = 1:1:length(sub_Tags)
    sub_Tags(i_sub) = string(['subject' num2str(i_sub)]);
end
% column
% % reg_Tags = strings(1, size(R2,2));
% % for i_reg = 1:1:length(reg_Tags)
% %     reg_Tags(1, i_reg) = string(['Region_' num2str(i_reg)]);
% % end

%% Create the tables - Group 1
tables_gr11 = cell(size(gr1_ts1));
tables_gr12 = cell(size(gr1_ts2));
tables_gr13 = cell(size(gr1_ts3));
mkdir('FUN_MP_Group_1');

for i_tab = 1:1:N_groups
    % Create directory per subject
    mkdir(strcat('FUN_MP_Group_1/', sub_Tags(i_tab)));
    % create the tables - layer 1
    T_gr11 = array2table(gr1_ts1{i_tab});
    tables_gr11{i_tab} = T_gr11;
    file_name = strcat("FUN_MP_Group_1/", sub_Tags(i_tab), "/", sub_Tags(i_tab), "_1.xlsx");
    writetable(T_gr11, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
    
    % create the table - layer 2
    T_gr12 = array2table(gr1_ts2{i_tab});
    tables_gr12{i_tab} = T_gr12;
    file_name = strcat("FUN_MP_Group_1/", sub_Tags(i_tab), "/", sub_Tags(i_tab), "_2.xlsx");
    writetable(T_gr12, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
    
    % create the table - layer 3
    T_gr13 = array2table(gr1_ts3{i_tab});
    tables_gr13{i_tab} = T_gr13;
    file_name = strcat("FUN_MP_Group_1/", sub_Tags(i_tab), "/", sub_Tags(i_tab), "_3.xlsx");
    writetable(T_gr13, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
end

%% Create the tables - connectivity layer
tables_gr21 = cell(size(gr2_ts1));
tables_gr22 = cell(size(gr2_ts2));
tables_gr23 = cell(size(gr2_ts3));

mkdir('FUN_MP_Group_2');

for i_tab = 1:1:N_groups
    % Create directory per subject
    mkdir(strcat('FUN_MP_Group_2/', sub_Tags(i_tab)));
    % create the tables - layer 1
    T_gr21 = array2table(gr2_ts1{i_tab});
    tables_gr21{i_tab} = T_gr21;
    file_name = strcat("FUN_MP_Group_2/", sub_Tags(i_tab), "/", sub_Tags(i_tab), "_1.xlsx");
    writetable(T_gr21, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
    
    % create the table - layer 2
    T_gr22 = array2table(gr2_ts2{i_tab});
    tables_gr22{i_tab} = T_gr22;
    file_name = strcat("FUN_MP_Group_2/", sub_Tags(i_tab), "/", sub_Tags(i_tab), "_2.xlsx");
    writetable(T_gr22, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
    
    % create the table - layer 3
    T_gr23 = array2table(gr2_ts3{i_tab});
    tables_gr23{i_tab} = T_gr23;
    file_name = strcat("FUN_MP_Group_2/", sub_Tags(i_tab), "/", sub_Tags(i_tab), "_3.xlsx");
    writetable(T_gr23, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
end
