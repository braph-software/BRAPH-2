clear all
close all
clc

rng('default')  % For reproducibility

%% Specify the network parameters for the two groups
N_nodes = 90; % AAL atlas

%% Specify length of time series 
N_tslength = 200;

%% Specify number of subjects
N_subjects = 50;

%% Group 1 properties
% 5 modules of 18 nodes each

gr1_ts1 = cell(1, N_subjects);
gr1_ts2 = cell(1, N_subjects);

% initialize values for the WS model
K1 = [3 4 5 6 7];
beta1 = [0.02 0.1 0.3 0.5 0.8];

% initialize the indices where the matrices will be placed
indices1 = 1:1:18;
indices2 = 19:1:36;
indices3 = 37:1:54;
indices4 = 55:1:72;
indices5 = 73:1:90;
indices = {indices1; indices2; indices3; indices4; indices5};

% Loop to create ts for each subject
for i_gr1 = 1:1:N_subjects

    % randomize the parameters
    K_temp = K1(randperm(length(K1)));
    beta_temp = beta1(randperm(length(beta1)));

    % initialize matrix for the subject
    A_full1 = zeros(N_nodes);

    % loop over each module
    for i_mod = 1:1:5
    A_full1(indices{i_mod},indices{i_mod}) = full(adjacency(WattsStrogatz(18, K_temp(i_mod), beta_temp(i_mod))));
    end
    A_full1(1:length(A_full1)+1:numel(A_full1)) = 1;

    % this is needed to make the matrices positive definite
    A_full1 = A_full1*transpose(A_full1);
    % 10% of connections kept
    density = 10;
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

    % make the adjacency matrix weighted
    r = 0 + (0.5 - 0)*rand(size(A_full2));
    diffA = A_full2 - r;
    A_full2(A_full2 ~= 0) = diffA(A_full2 ~= 0);
    
    % make the adjacency matrix symmetric
    A_full2 = max(A_full2, transpose(A_full2));
    
    figure(1)
    imshow(A_full1)
    figure(2)
    imshow(A_full2)


    % This matrix will be covariance matrices for the two groups
    % Specify the mean
    mu_gr11 = ones(1, length(A_full1));

    % calculate time series
    R11 = mvnrnd(mu_gr11, A_full1, N_tslength);

    % Normalize the time series
    mean_R11 = mean(R11);
    std_R11 = std(R11);
    R11 = (R11 - mean_R11) ./ std_R11;

    % place in the array
    gr1_ts1{1, i_gr1} = R11;
    gr1_ts2{1, i_gr1} = A_full2;

end

%% Group 2 properties
% 2 modules of 45 nodes each

gr2_ts1 = cell(1, N_subjects);
gr2_ts2 = cell(1, N_subjects);

% initialize values for the WS model
K2 = [3 7];
beta2 = [0.02 0.85];

% initialize the indices where the matrices will be placed
indices1 = 1:1:45;
indices2 = 46:1:90;
indices = {indices1; indices2};

% Loop to create ts for each subject
for i_gr2 = 1:1:N_subjects

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
    
    % make the adjacency matrix weighted
    r = 0 + (0.5 - 0)*rand(size(A_full2));
    diffA = A_full2 - r;
    A_full2(A_full2 ~= 0) = diffA(A_full2 ~= 0);

    % make the adjacency matrix symmetric
    A_full2 = max(A_full2, transpose(A_full2));
    
    figure(1)
    imshow(A_full1)
    figure(2)
    imshow(A_full2)


    % This matrix will be covariance matrices for the two groups
    % Specify the mean
    mu_gr2_1 = ones(1, length(A_full1));

    % calculate time series
    R21 = mvnrnd(mu_gr2_1, A_full1, N_tslength);

    % Normalize the time series
    mean_R21 = mean(R21);
    std_R21 = std(R21);
    R21 = (R21 - mean_R21) ./ std_R21;

    % place in the array
    gr2_ts1{1, i_gr2} = R21;
    gr2_ts2{1, i_gr2} = A_full2;

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

%% Create the tables - functional layer
tables_gr11 = cell(size(gr1_ts1));
tables_gr21 = cell(size(gr2_ts1));
mkdir('Functional/GroupName1');
mkdir('Functional/GroupName2');

for i_tab = 1:1:N_subjects

    % create the tables - group 1
    T_gr11 = array2table(gr1_ts1{i_tab});
    tables_gr11{i_tab} = T_gr11;
    file_name = strcat("Functional/GroupName1/", sub_Tags(i_tab), ".xlsx");
    writetable(T_gr11, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
    
    % create the table - group 2
    T_gr21 = array2table(gr2_ts1{i_tab});
    tables_gr21{i_tab} = T_gr21;
    file_name = strcat("Functional/GroupName2/", sub_Tags(i_tab), ".xlsx");
    writetable(T_gr21, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
end

%% Create the tables - connectivity layer
tables_gr12 = cell(size(gr1_ts2));
tables_gr22 = cell(size(gr2_ts2));
mkdir('Connectivity/GroupName1');
mkdir('Connectivity/GroupName2');

for i_tab = 1:1:N_subjects

    % create the tables - group 1
    T_gr12 = array2table(gr1_ts2{i_tab});
    tables_gr12{i_tab} = T_gr12;
    file_name = strcat("Connectivity/GroupName1/", sub_Tags(i_tab), ".xlsx");
    writetable(T_gr12, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
    
    % create the table - group 2
    T_gr22 = array2table(gr2_ts2{i_tab});
    tables_gr22{i_tab} = T_gr22;
    file_name = strcat("Connectivity/GroupName2/", sub_Tags(i_tab), ".xlsx");
    writetable(T_gr22, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
end


