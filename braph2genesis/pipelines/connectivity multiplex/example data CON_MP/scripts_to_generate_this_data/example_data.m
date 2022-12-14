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
gr1_matrices1 = cell(1, N_groups); % 5 modules of 18 nodes each
gr1_matrices2 = cell(1, N_groups); % 3 modules of 30 nodes each

% initialize values for the WS model
K1 = [3 4 5 6 7];
K2 = [4 5 7];
beta1 = [0.02 0.1 0.3 0.5 0.8];
beta2 = [0.1 0.3 0.8];

% initialize the indices where the matrices will be placed
indices1 = {1:18; 19:36; 37:54; 55:72; 73:90};
indices2 = {1:30; 31:60; 61:90};

% Loop to create ts for each subject
for i_gr1 = 1:1:N_groups

    % randomize the parameters
    K_temp = K1(randperm(length(K1)));
    beta_temp = beta1(randperm(length(beta1)));
    
    K_temp2 = K2(randperm(length(K2)));
    beta_temp2 = beta2(randperm(length(beta2)));
    
    % initialize matrix for the subject
    A_full1 = zeros(N_nodes);
    A_full2 = zeros(N_nodes);

    % loop over each module
    % layer 1
    for i_mod = 1:1:5
        A_full1(indices1{i_mod},indices1{i_mod}) = full(adjacency(WattsStrogatz(18, K_temp(i_mod), beta_temp(i_mod))));
    end
    % layer 2
    for i_mod = 1:1:3
        A_full2(indices2{i_mod},indices2{i_mod}) = full(adjacency(WattsStrogatz(30, K_temp2(i_mod), beta_temp2(i_mod))));
    end
    A_full1(1:length(A_full1)+1:numel(A_full1)) = 0;
    A_full2(1:length(A_full2)+1:numel(A_full2)) = 0;
    
    % make the adjacency matrix weighted
    r = 0 + (0.5 - 0)*rand(size(A_full1));
    diffA = A_full1 - r;
    A_full1(A_full1 ~= 0) = diffA(A_full1 ~= 0);
    r = 0 + (0.5 - 0)*rand(size(A_full2));
    diffA = A_full2 - r;
    A_full2(A_full2 ~= 0) = diffA(A_full2 ~= 0);
    
    figure(1)
    imshow(A_full1)
    figure(2)
    imshow(A_full2)

    % place matrices in the cells
    gr1_matrices1{1, i_gr1} = A_full1;
    gr1_matrices2{1, i_gr1} = A_full2;
end

%% Group 2 properties
% 2 modules of 45 nodes each

gr2_matrices1 = cell(1, N_groups);
gr2_matrices2 = cell(1, N_groups);

% initialize values for the WS model
K1 = [3 7];
beta1 = [0.02 0.85];

% initialize the indices where the matrices will be placed
indices1 = 1:1:45;
indices2 = 46:1:90;
indices = {indices1; indices2};

% Loop to create ts for each subject
for i_gr2 = 1:1:N_groups

    % randomize the parameters
    K_temp = K1(randperm(length(K1)));
    beta_temp = beta1(randperm(length(beta1)));

    % initialize matrix for the subject
    A_full1 = zeros(N_nodes);

    % loop over each module
    for i_mod = 1:1:2
        A_full1(indices{i_mod},indices{i_mod}) = full(adjacency(WattsStrogatz(45, K_temp(i_mod), beta_temp(i_mod))));
    end
    
    A_full1(1:length(A_full1)+1:numel(A_full1)) = 0;
    
    % make the adjacency matrix weighted
    r = 0 + (0.5 - 0)*rand(size(A_full1));
    diffA = A_full1 - r;
    A_full1(A_full1 ~= 0) = diffA(A_full1 ~= 0);
    
    % 40% of connections kept
    density = 40;
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

    figure(1)
    imshow(A_full1)
    figure(2)
    imshow(A_full2)

    % place the matrices in the cells
    gr2_matrices1{1, i_gr2} = A_full1;
    gr2_matrices2{1, i_gr2} = A_full2;

end
 
%% The subjects will be saved in a table - Specify row and column names
sub_Tags = strings(N_groups, 1);
for i_sub = 1:1:length(sub_Tags)
    sub_Tags(i_sub) = string(['subject' num2str(i_sub)]);
end

%% Create the tables - Group 1
tables_gr11 = cell(size(gr1_matrices1));
tables_gr12 = cell(size(gr1_matrices2));
mkdir('GroupName1');

for i_tab = 1:1:N_groups
    % Create directory per subject
    mkdir(strcat('GroupName1/', sub_Tags(i_tab)));
    % create the tables - layer 1
    T_gr11 = array2table(gr1_matrices1{i_tab});
    tables_gr11{i_tab} = T_gr11;
    file_name = strcat("GroupName1/", sub_Tags(i_tab), "/", sub_Tags(i_tab), "_1.xlsx");
    writetable(T_gr11, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
    
    % create the table - layer 2
    T_gr12 = array2table(gr1_matrices2{i_tab});
    tables_gr12{i_tab} = T_gr12;
    file_name = strcat("GroupName1/", sub_Tags(i_tab), "/", sub_Tags(i_tab), "_2.xlsx");
    writetable(T_gr12, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)

end

%% Create the tables - Group 2
tables_gr21 = cell(size(gr2_matrices1));
tables_gr22 = cell(size(gr2_matrices2));

mkdir('GroupName2');

for i_tab = 1:1:N_groups
    % Create directory per subject
    mkdir(strcat('GroupName2/', sub_Tags(i_tab)));
    % create the tables - layer 1
    T_gr21 = array2table(gr2_matrices1{i_tab});
    tables_gr21{i_tab} = T_gr21;
    file_name = strcat("GroupName2/", sub_Tags(i_tab), "/", sub_Tags(i_tab), "_1.xlsx");
    writetable(T_gr21, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
    
    % create the table - layer 2
    T_gr22 = array2table(gr2_matrices2{i_tab});
    tables_gr22{i_tab} = T_gr22;
    file_name = strcat("GroupName2/", sub_Tags(i_tab), "/", sub_Tags(i_tab), "_2.xlsx");
    writetable(T_gr22, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)

end
