clear all
close all
clc

%% Fix the number of subjects - 3 groups in total
N_groups = 50;

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
    sub_Tags(i_sub) = string(['subject' num2str(i_sub)]);
end
column_Tags = {'ID' 'age', 'sex', 'edu'};
gr1_R = [cellstr(sub_Tags) num2cell(Gr1_Age) Gr1_Sex num2cell(Gr1_Edu)];
gr2_R = [cellstr(sub_Tags) num2cell(Gr2_Age) Gr2_Sex num2cell(Gr2_Edu)];
gr3_R = [cellstr(sub_Tags) num2cell(Gr3_Age) Gr3_Sex num2cell(Gr3_Edu)];

C_group1 = array2table(gr1_R, 'VariableNames', column_Tags);
C_group2 = array2table(gr2_R, 'VariableNames', column_Tags);
C_group3 = array2table(gr3_R, 'VariableNames', column_Tags);

%% output
mkdir('GroupName1/covariates');
mkdir('GroupName2/covariates');
mkdir('GroupName3/covariates');
writetable(C_group1, 'GroupName1/covariates/GroupName1_covariates.xlsx', 'WriteRowNames', true)
writetable(C_group2, 'GroupName2/covariates/GroupName2_covariates.xlsx', 'WriteRowNames', true)
writetable(C_group3, 'GroupName3/covariates/GroupName3_covariates.xlsx', 'WriteRowNames', true)
