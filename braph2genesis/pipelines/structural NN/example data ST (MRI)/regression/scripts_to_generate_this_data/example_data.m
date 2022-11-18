clear all
close all
clc

rng('default')  % For reproducibility

%% Specify the network parameters for one group
N_nodes = 68; % Desikan atlas


%% Create a random vector with specific mean for the three groups
N_groups = 100;

for i = 1:1:N_groups
    %deviation = 1 + (2 - 1)*rand(1);
    mean_all(i) = 30 + (10 - 1)*rand(1);
    %R(i, :) = deviation.*randn(N_nodes, 1) + mean_all(i);
    R_ind = randn(N_nodes, 1) + mean_all(i);
    R_ind(R_ind < 0) = 0;
    mean_all(i) = mean(R_ind, 'all');
    R(i, :) = R_ind;
end

%% We need only positive values
%R = R + abs(min(min(R)));
%R(R < 0) = 0;

%% The subjects will be saved in a table - Specify row and column names
% row
sub_Tags = strings(size(R, 1), 1);
for i_sub = 1:1:length(sub_Tags)
    sub_Tags(i_sub) = string(['sub_' num2str(i_sub)]);
end
label_Tags = strings(size(R, 1), 1);
for i_sub = 1:1:length(label_Tags)
    label_Tags(i_sub) = string(['Label ' num2str(i_sub)]);
end
note_Tags = strings(size(R, 1), 1);
for i_sub = 1:1:length(note_Tags)
    note_Tags(i_sub) = string(['Note ' num2str(i_sub)]);
end

% column
reg_Tags = strings(1, size(R, 2) + 3);
reg_Tags(1, 1) = 'ID';
reg_Tags(1, 2) = 'Label';
reg_Tags(1, 3) = 'Notes';
for i_reg = 4:1:length(reg_Tags)
    reg_Tags(1, i_reg) = string(['Region_' num2str(i_reg-3)]);
end
%% Create the table - Group
R = [cellstr(sub_Tags) cellstr(label_Tags) cellstr(note_Tags) num2cell(R)];
T_group = array2table(R, 'VariableNames', reg_Tags);

%% Create covariates
% Age - radnomly drawn between 50 and 80 years old
Age_init = 10;
Age_fin  = 80;
Gr_Age = rescale(mean_all, Age_init, Age_fin);
%Gr_Age = mean_all;
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
    sub_Tags(i_sub) = string(['sub_' num2str(i_sub)]);
end
column_Tags = {'ID' 'age', 'sex', 'edu'};
gr_R = [cellstr(sub_Tags) num2cell(Gr_Age') Gr_Sex num2cell(Gr_Edu)];

C_group = array2table(gr_R, 'VariableNames', column_Tags);

%% output
writetable(T_group, 'ST_group.xlsx', 'WriteRowNames', true, 'Sheet', 1)
writetable(C_group, 'ST_group.xlsx', 'WriteRowNames', true, 'Sheet', 2)



