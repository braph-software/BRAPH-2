clear all
close all
clc

rng('default')  % For reproducibility

%% Specify the network parameters for the three groups
N_nodes = 68; % Desikan atlas


%% Create a random vector with specific mean for the three groups
N_groups = 100;

for i = 1:1:N_groups
    deviation = 1.5;
    mean = 6;
    R1(i, :) = deviation.*randn(N_nodes, 1) + mean;
    
    deviation = 1.5;
    mean = 3;
    R2(i, :) = deviation.*randn(N_nodes, 1) + mean;
    
    deviation = 1.5;
    mean = 1;
    R3(i, :) = deviation.*randn(N_nodes, 1) + mean;
end

%% We need only positive values
R1 = R1 + abs(min(min(R1)));
R2 = R2 + abs(min(min(R2)));
R3 = R3 + abs(min(min(R3)));

%% The subjects will be saved in a table - Specify row and column names
% row
sub_Tags = strings(size(R1, 1), 1);
for i_sub = 1:1:length(sub_Tags)
    sub_Tags(i_sub) = string(['sub_' num2str(i_sub)]);
end
label_Tags = strings(size(R1, 1), 1);
for i_sub = 1:1:length(label_Tags)
    label_Tags(i_sub) = string(['Label ' num2str(i_sub)]);
end
note_Tags = strings(size(R1, 1), 1);
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

%% Create the table - Group 3
R3 = [cellstr(sub_Tags) cellstr(label_Tags) cellstr(note_Tags) num2cell(R3)];
T_group3 = array2table(R3, 'VariableNames', reg_Tags);

%% Create covariates
% Age - radnomly drawn between 50 and 80 years old
Age_init = 50;
Age_fin  = 80;
Gr1_Age = floor(Age_init + (Age_fin-Age_init) .* rand(N_groups, 1));
Gr2_Age = ceil(Age_init + (Age_fin-Age_init) .* rand(N_groups, 1));
Gr3_Age = ceil(Age_init + (Age_fin-Age_init) .* rand(N_groups, 1));

% Sex
gr1_randsex = randn(N_groups, 1);
gr2_randsex = randn(N_groups, 1);
gr3_randsex = randn(N_groups, 1);
Gr1_Sex = num2cell(gr1_randsex);
Gr2_Sex = num2cell(gr2_randsex);
Gr3_Sex = num2cell(gr3_randsex);

Gr1_Sex(gr1_randsex <= 0) = {'Male'};
Gr1_Sex(gr1_randsex > 0) = {'Female'};
Gr2_Sex(gr2_randsex <= 0) = {'Male'};
Gr2_Sex(gr2_randsex > 0) = {'Female'};
Gr3_Sex(gr3_randsex <= 0) = {'Male'};
Gr3_Sex(gr3_randsex > 0) = {'Female'};

% Education - draw from normal distribution
Edu_init = 5;
Edu_fin = 11;
Gr1_Edu = floor(Edu_init + (Edu_fin-Edu_init) .* abs(randn(N_groups, 1)));
Gr2_Edu = ceil(Edu_init + (Edu_fin-Edu_init) .* abs(randn(N_groups, 1)));
Gr3_Edu = ceil(Edu_init + (Edu_fin-Edu_init) .* abs(randn(N_groups, 1)));

% covariate tabble
sub_Tags = strings(N_groups, 1);
for i_sub = 1:1:length(sub_Tags)
    sub_Tags(i_sub) = string(['sub_' num2str(i_sub)]);
end
column_Tags = {'ID' 'age', 'sex', 'edu'};
gr1_R = [cellstr(sub_Tags) num2cell(Gr1_Age) Gr1_Sex num2cell(Gr1_Edu)];
gr2_R = [cellstr(sub_Tags) num2cell(Gr2_Age) Gr2_Sex num2cell(Gr2_Edu)];
gr3_R = [cellstr(sub_Tags) num2cell(Gr3_Age) Gr3_Sex num2cell(Gr3_Edu)];

C_group1 = array2table(gr1_R, 'VariableNames', column_Tags);
C_group2 = array2table(gr2_R, 'VariableNames', column_Tags);
C_group3 = array2table(gr3_R, 'VariableNames', column_Tags);

%% output
writetable(T_group1, 'ST_group1.xlsx', 'WriteRowNames', true, 'Sheet', 1)
writetable(C_group1, 'ST_group1.xlsx', 'WriteRowNames', true, 'Sheet', 2)
writetable(T_group2, 'ST_group2.xlsx', 'WriteRowNames', true, 'Sheet', 1)
writetable(C_group2, 'ST_group2.xlsx', 'WriteRowNames', true, 'Sheet', 2)
writetable(T_group3, 'ST_group3.xlsx', 'WriteRowNames', true, 'Sheet', 1)
writetable(C_group3, 'ST_group3.xlsx', 'WriteRowNames', true, 'Sheet', 2)




