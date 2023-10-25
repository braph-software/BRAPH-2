%% ¡header!
NNDataPoint_ST_CLA < NNDataPoint (dp, structural classification data point) is a data point for classification with structural data.

%%% ¡description!
A data point for classification with structural data (NNDataPoint_ST_CLA) 
 contains the input and target for neural network analysis with a subject with structural data (SubjectST).
The input is the structural data of the subject.
The target is obtained from the variables of interest of the subject.

%%% ¡seealso!
SubjectST

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the data point for classification with structural data.
%%%% ¡default!
'NNDataPoint_ST_CLA'

%%% ¡prop!
NAME (constant, string) is the name of a data point for classification with structural data.
%%%% ¡default!
'Neural Network Structural Data Point for Classification'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of a data point for classification with structural data.
%%%% ¡default!
'A data point for classification with structural data (NNDataPoint_ST_CLA) contains the input and target for neural network analysis with a subject with structural data (SubjectST). The input is the structural data of the subject. The target is obtained from the variables of interest of the subject.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of a data point for classification with structural data.
%%%% ¡settings!
'NNDataPoint_ST_CLA'

%%% ¡prop!
ID (data, string) is a few-letter code for a data point for classification with structural data.
%%%% ¡default!
'NNDataPoint_ST_CLA ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of a data point for classification with structural data.
%%%% ¡default!
'NNDataPoint_ST_CLA label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about a data point for classification with structural data.
%%%% ¡default!
'NNDataPoint_ST_CLA notes'

%%% ¡prop!
INPUT (result, cell) is the input value for this data point.
%%%% ¡calculate!
value = {dp.get('SUB').get('ST')};
    
%%% ¡prop!
TARGET (result, stringlist) is the target values for this data point.
%%%% ¡calculate!
value = dp.get('TARGET_IDS');

%% ¡props!

%%% ¡prop!
SUB (data, item) is a subject with structural data.
%%%% ¡settings!
'SubjectST'

%%% ¡prop!
TARGET_IDS (parameter, stringlist) is a list of variable-of-interest IDs to be used as the class targets.
					
%% ¡tests!

%%% ¡excluded_props!
[NNDataPoint_ST_CLA.SUB]

%%% ¡test!
%%%% ¡name!
Create example files
%%%% ¡code!
data_dir = [fileparts(which('NNDataPoint_ST_CLA')) filesep 'Example data NN CLA ST XLS'];
if ~isdir(data_dir)
    mkdir(data_dir);

    % Brain Atlas
    im_ba = ImporterBrainAtlasXLS('FILE', 'destrieux_atlas.xlsx');
    ba = im_ba.get('BA');
    ex_ba = ExporterBrainAtlasXLS( ...
        'BA', ba, ...
        'FILE', [data_dir filesep() 'atlas.xlsx'] ...
        );
    ex_ba.get('SAVE')
    N = ba.get('BR_DICT').get('LENGTH');

    % saves RNG
    rng_settings_ = rng(); rng('default')

    N_subjects = 50;

    sex_options = {'Female' 'Male'};

    % Group 1
    K1 = 4; % degree (mean node degree is 2K) - group 1
    beta1 = 0.08; % Rewiring probability - group 1

    h1 = WattsStrogatz(N, K1, beta1); % create graph
    % figure(1)
    % plot(h1, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
    % title(['Group 1: Graph with $N = $ ' num2str(N) ...
    %     ' nodes, $K = $ ' num2str(K1) ', and $\beta = $ ' num2str(beta1)], ...
    %     'Interpreter','latex')
    % axis equal

    A1 = full(adjacency(h1)); A1(1:length(A1)+1:numel(A1)) = 1; % Extract the adjacency matrix
    A1 = A1*transpose(A1); % this is needed to make the matrices positive definite
    % imshow(A1)

    % These matrices will be covariance matrices for the two groups
    mu_gr1 = ones(1, length(A1)); % Specify the mean
    R1 = mvnrnd(mu_gr1, A1, N_subjects); % Create time series for the two groups
    mean_R1 = mean(R1); std_R1 = std(R1); R1 = (R1 - mean(R1)) ./ std(R1); % Normalize the time series
    R1 = R1 + abs(min(min(R1))); % We need only positive values

    % row
    sub_Tags1 = strings(size(R1, 1), 1);
    for i_sub = 1:1:length(sub_Tags1)
        sub_Tags1(i_sub) = string(['sub_' num2str(i_sub)]);
    end
    label_Tags1 = strings(size(R1, 1), 1);
    for i_sub = 1:1:length(label_Tags1)
        label_Tags1(i_sub) = string(['Label ' num2str(i_sub)]);
    end
    note_Tags1 = strings(size(R1, 1), 1);
    for i_sub = 1:1:length(note_Tags1)
        note_Tags1(i_sub) = string(['Note ' num2str(i_sub)]);
    end

    % column
    reg_Tags = strings(1, size(R1,2) + 3);
    reg_Tags(1, 1) = 'ID';
    reg_Tags(1, 2) = 'Label';
    reg_Tags(1, 3) = 'Notes';
    for i_reg = 4:1:length(reg_Tags)
        reg_Tags(1, i_reg) = string(['Region_' num2str(i_reg - 3)]);
    end

    % create the table
    writetable(array2table([cellstr(sub_Tags1) cellstr(label_Tags1) cellstr(note_Tags1) num2cell(R1)], 'VariableNames', reg_Tags), [data_dir filesep() 'ST_Group_1.xlsx'], 'WriteRowNames', true)

    % variables of interest
    vois1 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    for i = 1:1:N_subjects
        vois1 = [vois1; {sub_Tags1{i}, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois1), [data_dir filesep() 'ST_Group_1.vois.xlsx'], 'WriteVariableNames', false)

    % Group 2
    K2 = K1; % degree (mean node degree is 2K) - group 2
    beta2 = 0.7; % Rewiring probability - group 2

    h2 = WattsStrogatz(N, K2, beta2);
    % figure(2)
    % plot(h2, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
    % title(['Group 2: Graph with $N = $ ' num2str(N) ...
    %     ' nodes, $K = $ ' num2str(K2) ', and $\beta = $ ' num2str(beta2)], ...
    %     'Interpreter','latex')
    % axis equal

    A2 = full(adjacency(h1)); A2(1:length(A2)+1:numel(A2)) = 1;
    A2 = A2*transpose(A2);
    % imshow(A2)

    mu_gr2 = ones(1, length(A2));
    R2 = mvnrnd(mu_gr2, A2, N_subjects);
    mean_R2 = mean(R2); std_R2 = std(R2); R2 = (R2 - mean(R2)) ./ std(R2);
    R2 = R2 + abs(min(min(R2)));

    % row
    sub_Tags2 = strings(size(R1, 1), 1);
    for i_sub = 1:1:length(sub_Tags2)
        sub_Tags2(i_sub) = string(['sub_' num2str(i_sub + N_subjects)]);
    end
    label_Tags2 = strings(size(R1, 1), 1);
    for i_sub = 1:1:length(label_Tags2)
        label_Tags2(i_sub) = string(['Label ' num2str(i_sub + N_subjects)]);
    end
    note_Tags2 = strings(size(R1, 1), 1);
    for i_sub = 1:1:length(note_Tags2)
        note_Tags2(i_sub) = string(['Note ' num2str(i_sub + N_subjects)]);
    end

    writetable(array2table([cellstr(sub_Tags2) cellstr(label_Tags2) cellstr(note_Tags2) num2cell(R2)], 'VariableNames', reg_Tags), [data_dir filesep() 'ST_Group_2.xlsx'], 'WriteRowNames', true)

    % variables of interest
    vois2 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    for i = 1:1:N_subjects
        vois2 = [vois2; {sub_Tags2{i}, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois2), [data_dir filesep() 'ST_Group_2.vois.xlsx'], 'WriteVariableNames', false)

    % Group 3
    K3 = K1; % degree (mean node degree is 2K) - group 2
    beta3 = 0.9; % Rewiring probability - group 2

    h3 = WattsStrogatz(N, K3, beta3);
    % figure(3)
    % plot(h3, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
    % title(['Group 3: Graph with $N = $ ' num2str(N) ...
    %     ' nodes, $K = $ ' num2str(K3) ', and $\beta = $ ' num2str(beta3)], ...
    %     'Interpreter','latex')
    % axis equal

    A3 = full(adjacency(h1)); A3(1:length(A3)+1:numel(A3)) = 1;
    A3 = A3*transpose(A3);
    % imshow(A2)

    mu_gr3 = ones(1, length(A3));
    R3 = mvnrnd(mu_gr3, A3, N_subjects);
    mean_R3 = mean(R3); std_R3 = std(R3); R3 = (R3 - mean(R3)) ./ std(R3);
    R3 = R3 + abs(min(min(R3)));

    % row
    sub_Tags3 = strings(size(R1, 1), 1);
    for i_sub = 1:1:length(sub_Tags3)
        sub_Tags3(i_sub) = string(['sub_' num2str(i_sub + 2*N_subjects)]);
    end
    label_Tags3 = strings(size(R1, 1), 1);
    for i_sub = 1:1:length(label_Tags3)
        label_Tags3(i_sub) = string(['Label ' num2str(i_sub + 2*N_subjects)]);
    end
    note_Tags3 = strings(size(R1, 1), 1);
    for i_sub = 1:1:length(note_Tags3)
        note_Tags3(i_sub) = string(['Note ' num2str(i_sub + 2*N_subjects)]);
    end

    writetable(array2table([cellstr(sub_Tags3) cellstr(label_Tags3) cellstr(note_Tags3) num2cell(R3)], 'VariableNames', reg_Tags), [data_dir filesep() 'ST_Group_3.xlsx'], 'WriteRowNames', true)

    % variables of interest
    vois3 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    for i = 1:1:N_subjects
        vois3 = [vois3; {sub_Tags3{i}, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois3), [data_dir filesep() 'ST_Group_3.vois.xlsx'], 'WriteVariableNames', false)

    % reset RNG
    rng(rng_settings_)
end

%%% ¡test_functions!
function h = WattsStrogatz(N,K,beta)
% H = WattsStrogatz(N,K,beta) returns a Watts-Strogatz model graph with N
% nodes, N*K edges, mean node degree 2*K, and rewiring probability beta.
%
% beta = 0 is a ring lattice, and beta = 1 is a random graph.

% Connect each node to its K next and previous neighbors. This constructs
% indices for a ring lattice.
s = repelem((1:N)',1,K);
t = s + repmat(1:K,N,1);
t = mod(t-1,N)+1;

% Rewire the target node of each edge with probability beta
for source=1:N
    switchEdge = rand(K, 1) < beta;
    
    newTargets = rand(N, 1);
    newTargets(source) = 0;
    newTargets(s(t==source)) = 0;
    newTargets(t(source, ~switchEdge)) = 0;
    
    [~, ind] = sort(newTargets, 'descend');
    t(source, switchEdge) = ind(1:nnz(switchEdge));
end

h = graph(s,t);
end

%%% ¡test! 
%%%% ¡name!
Create a NNDataset containg NNDataPoint_ST_CLA with simulated data
%%%% ¡code!
% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_ST_CLA')) filesep 'Example data NN CLA ST XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Groups of SubjectST
im_gr1 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('NNDataPoint_ST_CLA')) filesep 'Example data NN CLA ST XLS' filesep 'ST_Group_1.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('NNDataPoint_ST_CLA')) filesep 'Example data NN CLA ST XLS' filesep 'ST_Group_2.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

% create item lists of NNDataPoint_ST_CLA
[~, group_folder_name] = fileparts(im_gr1.get('FILE'));
it_list1 = cellfun(@(x) NNDataPoint_ST_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', {group_folder_name}), ...
    gr1.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

[~, group_folder_name] = fileparts(im_gr2.get('FILE'));
it_list2 = cellfun(@(x) NNDataPoint_ST_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', {group_folder_name}), ...
    gr2.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create NNDataPoint_ST_CLA DICT items
dp_list1 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_ST_CLA', ...
        'IT_LIST', it_list1 ...
        );

dp_list2 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_ST_CLA', ...
        'IT_LIST', it_list2 ...
        );

% create a NNDataset containing the NNDataPoint_ST_CLA DICT
d1 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_ST_CLA', ...
    'DP_DICT', dp_list1 ...
    );

d2 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_ST_CLA', ...
    'DP_DICT', dp_list2 ...
    );

% Check whether the number of inputs matches
assert(length(d1.get('INPUTS')) == gr1.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_ST_CLA:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_ST_CLA does not construct the dataset correctly. The number of the inputs should be the same as the number of imported subjects of group 1.' ...
		)

assert(length(d2.get('INPUTS')) == gr2.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_ST_CLA:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_ST_CLA does not construct the dataset correctly. The number of the inputs should be the same as the number of imported subjects of group 2.' ...
		)

% Check whether the number of targets matches
assert(length(d1.get('TARGETS')) == gr1.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_ST_CLA:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_ST_CLA does not construct the dataset correctly. The number of the targets should be the same as the number of imported subjects of group 1.' ...
		)

assert(length(d2.get('TARGETS')) == gr2.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_ST_CLA:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_ST_CLA does not construct the dataset correctly. The number of the targets should be the same as the number of imported subjects of group 2.' ...
		)

% Check whether the content of input for a single datapoint matches
for index = 1:1:gr1.get('SUB_DICT').get('LENGTH')
    individual_input = d1.get('DP_DICT').get('IT', index).get('INPUT');
    known_input = {gr1.get('SUB_DICT').get('IT', index).get('ST')};

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_ST_CLA:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_ST_CLA does not construct the dataset correctly. The input value is not derived correctly.' ...
        )
end

for index = 1:1:gr2.get('SUB_DICT').get('LENGTH')
    individual_input = d2.get('DP_DICT').get('IT', index).get('INPUT');
    known_input = {gr2.get('SUB_DICT').get('IT', index).get('ST')};

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_ST_CLA:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_ST_CLA does not construct the dataset correctly. The input value is not derived correctly.' ...
        )
end

%%% ¡test! 
%%%% ¡name!
Example training-test classification
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_ST_CLA')) filesep 'Example data NN CLA ST XLS' filesep 'atlas.xlsx'])
    test_NNDataPoint_ST_CLA % create example files
end

example_NN_ST_CLA

%%% ¡test! 
%%%% ¡name!
Example cross-validation classification
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_ST_CLA')) filesep 'Example data NN CLA ST XLS' filesep 'atlas.xlsx'])
    test_NNDataPoint_ST_CLA % create example files
end

example_NNCV_ST_CLA