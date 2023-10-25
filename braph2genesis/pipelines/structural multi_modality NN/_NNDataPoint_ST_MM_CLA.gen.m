%% ¡header!
NNDataPoint_ST_MM_CLA < NNDataPoint (dp, structural multimodality classification data point) is a data point for classification with structural multimodality data.

%%% ¡description!
A data point for classification with structural multimodality data (NNDataPoint_ST_MM_CLA) 
 contains the input and target for neural network analysis with a subject 
 with structural multiplex data (SubjectST_MP).
The input is the structural multiplex data of the subject.
The target is obtained from the variables of interest of the subject.

%%% ¡seealso!
SubjectST_MP

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the data point for classification with structural multimodality data.
%%%% ¡default!
'NNDataPoint_ST_MM_CLA'

%%% ¡prop!
NAME (constant, string) is the name of a data point for classification with structural multimodality data.
%%%% ¡default!
'Neural Network Structural Multimodality Data Point for Classification'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of a data point for classification with structural multimodality data.
%%%% ¡default!
'A data point for classification with structural multimodality data (NNDataPoint_ST_MM_CLA) contains the input and target for neural network analysis with a subject with structural multiplex data (SubjectST_MP). The input is the structural multiplex data of the subject. The target is obtained from the variables of interest of the subject.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of a data point for classification with structural multimodality data.
%%%% ¡settings!
'NNDataPoint_ST_MM_CLA'

%%% ¡prop!
ID (data, string) is a few-letter code for a data point for classification with structural multimodality data.
%%%% ¡default!
'NNDataPoint_ST_MM_CLA ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of a data point for classification with structural multimodality data.
%%%% ¡default!
'NNDataPoint_ST_MM_CLA label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about a data point for classification with structural multimodality data.
%%%% ¡default!
'NNDataPoint_ST_MM_CLA notes'

%%% ¡prop!
INPUT (result, cell) is the input value for this data point.
%%%% ¡calculate!
value = dp.get('SUB').get('ST_MP');
    
%%% ¡prop!
TARGET (result, stringlist) is the target values for this data point.
%%%% ¡calculate!
value = dp.get('TARGET_IDS');

%% ¡props!

%%% ¡prop!
SUB (data, item) is a subject with structural multimodality data.
%%%% ¡settings!
'SubjectST_MP'

%%% ¡prop!
TARGET_IDS (parameter, stringlist) is a list of variable-of-interest IDs to be used as the class targets.
					
%% ¡tests!

%%% ¡excluded_props!
[NNDataPoint_ST_MM_CLA.SUB]

%%% ¡test!
%%%% ¡name!
Create example files
%%%% ¡code!
data_dir = [fileparts(which('NNDataPoint_ST_MM_CLA')) filesep 'Example data NN CLA ST_MM XLS'];
if ~isdir(data_dir)
    mkdir(data_dir);
    
    % Brain Atlas
    im_ba = ImporterBrainAtlasXLS('FILE', 'desikan_atlas.xlsx');
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
    gr1_name = 'ST_MM_Group_1_XLS';
    gr2_name = 'ST_MM_Group_2_XLS';
    gr3_name = 'ST_MM_Group_3_XLS';
    sex_options = {'Female' 'Male'};

    % Group 1
    K11 = 4; % degree (mean node degree is 2K) - group 1 layer 1
    K12 = 5; % degree (mean node degree is 2K) - group 1 layer 2
    beta1 = 0.08; % Rewiring probability - group 1

    % Create the graphs
    h11 = WattsStrogatz(N, K11, beta1);
    h12 = WattsStrogatz(N, K12, beta1);

    % Extract the adjacency matrices
    A11 = full(adjacency(h11));
    A12 = full(adjacency(h12));
    A11(1:length(A11)+1:numel(A11)) = 1;
    A12(1:length(A12)+1:numel(A12)) = 1;

    % this is needed to make the matrices positive definite
    A11 = A11*transpose(A11);
    A12 = A12*transpose(A12);
    
    % These matrices will be covariance matrices
    % Specify the mean
    mu_gr11 = ones(1, length(A11));
    mu_gr12 = ones(1, length(A12));

    % Create time series
    R11 = mvnrnd(mu_gr11, A11, N_subjects);
    R12 = mvnrnd(mu_gr12, A12, N_subjects);

    % We need only positive values
    R11 = R11 + abs(min(min(R11)));
    R12 = R12 + abs(min(min(R12)));

    % The subjects will be saved in a table - Specify row and column names
    % row
    sub_Tags1 = strings(size(R11,1), 1);
    for i_sub = 1:1:length(sub_Tags1)
        sub_Tags1(i_sub) = string(['sub_' num2str(i_sub)]);
    end
    label_Tags1 = strings(size(R11,1), 1);
    for i_sub = 1:1:length(label_Tags1)
        label_Tags1(i_sub) = string(['Label ' num2str(i_sub)]);
    end
    note_Tags1 = strings(size(R11,1), 1);
    for i_sub = 1:1:length(note_Tags1)
        note_Tags1(i_sub) = string(['Note ' num2str(i_sub)]);
    end

    % column
    reg_Tags = strings(1, size(R11,2) + 3);
    reg_Tags(1, 1) = 'ID';
    reg_Tags(1, 2) = 'Label';
    reg_Tags(1, 3) = 'Notes';
    for i_reg = 4:1:length(reg_Tags)
        reg_Tags(1, i_reg) = string(['Region_' num2str(i_reg-3)]);
    end

    % Create the table - Group 1
    R11 = [cellstr(sub_Tags1) cellstr(label_Tags1) cellstr(note_Tags1) num2cell(R11)];
    T_group11 = array2table(R11, 'VariableNames', reg_Tags);

    R12 = [cellstr(sub_Tags1) cellstr(label_Tags1) cellstr(note_Tags1) num2cell(R12)];
    T_group12 = array2table(R12, 'VariableNames', reg_Tags);

    % create the table
    gr1_dir = [data_dir filesep() gr1_name];
    mkdir(gr1_dir)
    writetable(T_group11, [gr1_dir filesep() gr1_name '.1.xlsx'], 'WriteRowNames', true)
    writetable(T_group12, [gr1_dir filesep() gr1_name '.2.xlsx'], 'WriteRowNames', true)

    % variables of interest
    vois1 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    for i = 1:1:N_subjects
        vois1 = [vois1; {sub_Tags1{i}, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois1), [data_dir filesep() gr1_name '.vois.xlsx'], 'WriteVariableNames', false)

    % Group 2
    K21 = K11; % degree (mean node degree is 2K) - group 2 layer 1
    K22 = 2; % degree (mean node degree is 2K) - group 2 layer 2
    beta2 = 0.9; % Rewiring probability - group 2

    % Create the graphs
    h21 = WattsStrogatz(N, K21, beta2);
    h22 = WattsStrogatz(N, K22, beta2);

    % Extract the adjacency matrices 
    A21 = full(adjacency(h21));
    A22 = full(adjacency(h22));
    A21(1:length(A21)+1:numel(A21)) = 1;
    A22(1:length(A22)+1:numel(A22)) = 1;

    % this is needed to make the matrices positive definite
    A21 = A21*transpose(A21);
    A22 = A22*transpose(A22);

    % These matrices will be covariance matrices
    % Specify the mean
    mu_gr21 = ones(1, length(A21));
    mu_gr22 = ones(1, length(A22));

    % Create time series
    R21 = mvnrnd(mu_gr21, A21, N_subjects);
    R22 = mvnrnd(mu_gr22, A22, N_subjects);

    % We need only positive values
    R21 = R21 + abs(min(min(R21)));
    R22 = R22 + abs(min(min(R22)));

    % row
    sub_Tags2 = strings(size(R21, 1), 1);
    for i_sub = 1:1:length(sub_Tags2)
        sub_Tags2(i_sub) = string(['sub_' num2str(i_sub + N_subjects)]);
    end
    label_Tags2 = strings(size(R21, 1), 1);
    for i_sub = 1:1:length(label_Tags2)
        label_Tags2(i_sub) = string(['Label ' num2str(i_sub + N_subjects)]);
    end
    note_Tags2 = strings(size(R21, 1), 1);
    for i_sub = 1:1:length(note_Tags2)
        note_Tags2(i_sub) = string(['Note ' num2str(i_sub + N_subjects)]);
    end

    % Create the table - Group 2
    R21 = [cellstr(sub_Tags2) cellstr(label_Tags2) cellstr(note_Tags2) num2cell(R21)];
    T_group21 = array2table(R21, 'VariableNames', reg_Tags);

    R22 = [cellstr(sub_Tags2) cellstr(label_Tags2) cellstr(note_Tags2) num2cell(R22)];
    T_group22 = array2table(R22, 'VariableNames', reg_Tags);

    % create the table
    gr2_dir = [data_dir filesep() gr2_name];
    mkdir(gr2_dir)
    writetable(T_group21, [gr2_dir filesep() gr2_name '.1.xlsx'], 'WriteRowNames', true)
    writetable(T_group22, [gr2_dir filesep() gr2_name '.2.xlsx'], 'WriteRowNames', true)

    % variables of interest
    vois2 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    for i = 1:1:N_subjects
        vois2 = [vois2; {sub_Tags2{i}, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois2), [data_dir filesep() gr2_name '.vois.xlsx'], 'WriteVariableNames', false)

    % Group 3
    K31 = K11; % degree (mean node degree is 2K) - group 3 layer 1
    K32 = 2; % degree (mean node degree is 2K) - group 3 layer 2
    beta3 = 0.6; % Rewiring probability - group 3

    % Create the graphs
    h31 = WattsStrogatz(N, K31, beta3);
    h32 = WattsStrogatz(N, K32, beta3);

    % Extract the adjacency matrices 
    A31 = full(adjacency(h31));
    A32 = full(adjacency(h32));
    A31(1:length(A31)+1:numel(A31)) = 1;
    A32(1:length(A32)+1:numel(A32)) = 1;

    % this is needed to make the matrices positive definite
    A31 = A31*transpose(A31);
    A32 = A32*transpose(A32);

    % These matrices will be covariance matrices
    % Specify the mean
    mu_gr31 = ones(1, length(A31));
    mu_gr32 = ones(1, length(A32));

    % Create time series
    R31 = mvnrnd(mu_gr31, A31, N_subjects);
    R32 = mvnrnd(mu_gr32, A32, N_subjects);

    % We need only positive values
    R31 = R31 + abs(min(min(R31)));
    R32 = R32 + abs(min(min(R32)));

    % row
    sub_Tags3 = strings(size(R31, 1), 1);
    for i_sub = 1:1:length(sub_Tags3)
        sub_Tags3(i_sub) = string(['sub_' num2str(i_sub + N_subjects)]);
    end
    label_Tags3 = strings(size(R31, 1), 1);
    for i_sub = 1:1:length(label_Tags3)
        label_Tags3(i_sub) = string(['Label ' num2str(i_sub + N_subjects)]);
    end
    note_Tags3 = strings(size(R31, 1), 1);
    for i_sub = 1:1:length(note_Tags3)
        note_Tags3(i_sub) = string(['Note ' num2str(i_sub + N_subjects)]);
    end

    % Create the table - Group 3
    R31 = [cellstr(sub_Tags3) cellstr(label_Tags3) cellstr(note_Tags3) num2cell(R31)];
    T_group31 = array2table(R31, 'VariableNames', reg_Tags);

    R32 = [cellstr(sub_Tags3) cellstr(label_Tags3) cellstr(note_Tags3) num2cell(R32)];
    T_group32 = array2table(R32, 'VariableNames', reg_Tags);

    % create the table
    gr3_dir = [data_dir filesep() gr3_name];
    mkdir(gr3_dir)
    writetable(T_group31, [gr3_dir filesep() gr3_name '.1.xlsx'], 'WriteRowNames', true)
    writetable(T_group32, [gr3_dir filesep() gr3_name '.2.xlsx'], 'WriteRowNames', true)

    % variables of interest
    vois3 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    for i = 1:1:N_subjects
        vois3 = [vois3; {sub_Tags3{i}, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois3), [data_dir filesep() gr3_name '.vois.xlsx'], 'WriteVariableNames', false)
    
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
Create a NNDataset containg NNDataPoint_ST_MM_CLA with simulated data
%%%% ¡code!
% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_ST_MM_CLA')) filesep 'Example data NN CLA ST_MM XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Group 1
im_gr1 = ImporterGroupSubjectST_MP_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_ST_MM_CLA')) filesep 'Example data NN CLA ST_MM XLS' filesep 'ST_MM_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

% Load Group 2
im_gr2 = ImporterGroupSubjectST_MP_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_ST_MM_CLA')) filesep 'Example data NN CLA ST_MM XLS' filesep 'ST_MM_Group_2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

% create item lists of NNDataPoint_ST_MM_CLA
[~, group_folder_name] = fileparts(im_gr1.get('DIRECTORY'));
it_list1 = cellfun(@(x) NNDataPoint_ST_MM_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', {group_folder_name}), ...
    gr1.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

[~, group_folder_name] = fileparts(im_gr2.get('DIRECTORY'));
it_list2 = cellfun(@(x) NNDataPoint_ST_MM_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', {group_folder_name}), ...
    gr2.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create NNDataPoint_ST_MM_CLA DICT items
dp_list1 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_ST_MM_CLA', ...
        'IT_LIST', it_list1 ...
        );

dp_list2 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_ST_MM_CLA', ...
        'IT_LIST', it_list2 ...
        );

% create a NNDataset containing the NNDataPoint_ST_MM_CLA DICT
d1 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_ST_MM_CLA', ...
    'DP_DICT', dp_list1 ...
    );

d2 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_ST_MM_CLA', ...
    'DP_DICT', dp_list2 ...
    );

% Check whether the number of inputs matches
assert(length(d1.get('INPUTS')) == gr1.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_ST_MM_CLA:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_ST_MM_CLA does not construct the dataset correctly. The number of the inputs should be the same as the number of imported subjects of group 1.' ...
		)

assert(length(d2.get('INPUTS')) == gr2.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_ST_MM_CLA:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_ST_MM_CLA does not construct the dataset correctly. The number of the inputs should be the same as the number of imported subjects of group 2.' ...
		)

% Check whether the number of targets matches
assert(length(d1.get('TARGETS')) == gr1.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_ST_MM_CLA:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_ST_MM_CLA does not construct the dataset correctly. The number of the targets should be the same as the number of imported subjects of group 1.' ...
		)

assert(length(d2.get('TARGETS')) == gr2.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_ST_MM_CLA:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_ST_MM_CLA does not construct the dataset correctly. The number of the targets should be the same as the number of imported subjects of group 2.' ...
		)

% Check whether the content of input for a single datapoint matches
for index = 1:1:gr1.get('SUB_DICT').get('LENGTH')
    individual_input = d1.get('DP_DICT').get('IT', index).get('INPUT');
    known_input = gr1.get('SUB_DICT').get('IT', index).get('ST_MP');

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_ST_MM_CLA:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_ST_MM_CLA does not construct the dataset correctly. The input value is not derived correctly.' ...
        )
end
for index = 1:1:gr2.get('SUB_DICT').get('LENGTH')
    individual_input = d2.get('DP_DICT').get('IT', index).get('INPUT');
    known_input = gr2.get('SUB_DICT').get('IT', index).get('ST_MP');

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_ST_MM_CLA:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_ST_MM_CLA does not construct the dataset correctly. The input value is not derived correctly.' ...
        )
end

%%% ¡test! 
%%%% ¡name!
Example training-test classification
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_ST_MM_CLA')) filesep 'Example data NN CLA ST_MM XLS' filesep 'atlas.xlsx'])
    test_NNDataPoint_ST_MM_CLA % create example files
end

example_NN_ST_MM_CLA

%%% ¡test! 
%%%% ¡name!
Example cross-validation classification
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_ST_MM_CLA')) filesep 'Example data NN CLA ST_MM XLS' filesep 'atlas.xlsx'])
    test_NNDataPoint_ST_MM_CLA % create example files
end

example_NNCV_ST_MM_CLA