%% ¡header!
NNDataPoint_FUN_CLA < NNDataPoint (dp, functional classification data point) is a data point for classification with functional data.

%%% ¡description!
A data point for classification with functional data (NNDataPoint_FUN_CLA) 
 contains the input and target for neural network analysis with a subject with functional data (SubjectFUN).
The input is the functional data of the subject.
The target is obtained from the variables of interest of the subject.

%%% ¡seealso!
SubjectFUN

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the data point for classification with functional data.
%%%% ¡default!
'NNDataPoint_FUN_CLA'

%%% ¡prop!
NAME (constant, string) is the name of a data point for classification with functional data.
%%%% ¡default!
'Neural Network Functional Data Point for Classification'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of a data point for classification with functional data.
%%%% ¡default!
'A data point for classification with functional data (NNDataPoint_FUN_CLA) contains the input and target for neural network analysis with a subject with functional data (SubjectFUN). The input is the functional data of the subject. The target is obtained from the variables of interest of the subject.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of a data point for classification with functional data.
%%%% ¡settings!
'NNDataPoint_FUN_CLA'

%%% ¡prop!
ID (data, string) is a few-letter code for a data point for classification with functional data.
%%%% ¡default!
'NNDataPoint_FUN_CLA ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of a data point for classification with functional data.
%%%% ¡default!
'NNDataPoint_FUN_CLA label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about a data point for classification with functional data.
%%%% ¡default!
'NNDataPoint_FUN_CLA notes'

%%% ¡prop!
INPUT (result, cell) is the input value for this data point.
%%%% ¡calculate!
value = {dp.get('SUB').get('FUN')};
    
%%% ¡prop!
TARGET (result, cell) is the target value for this data point.
%%%% ¡calculate!
value = dp.get('TARGET_IDS');

%% ¡props!

%%% ¡prop!
SUB (data, item) is a subject with functional data.
%%%% ¡settings!
'SubjectFUN'

%%% ¡prop!
TARGET_IDS (parameter, stringlist) is a list of variable-of-interest IDs to be used as classification targets.
					
%% ¡tests!

%%% ¡excluded_props!
[NNDataPoint_FUN_CLA.SUB]

%%% ¡test!
%%%% ¡name!
Create example files for classification
%%%% ¡code!
data_dir = [fileparts(which('NNDataPoint_FUN_CLA')) filesep 'Example data NN CLA FUN XLS'];
if ~isdir(data_dir)
    mkdir(data_dir);

    % Brain Atlas
    im_ba = ImporterBrainAtlasXLS('FILE', 'aal90_atlas.xlsx');
    ba = im_ba.get('BA');
    ex_ba = ExporterBrainAtlasXLS( ...
        'BA', ba, ...
        'FILE', [data_dir filesep() 'atlas.xlsx'] ...
        );
    ex_ba.get('SAVE')
    N = ba.get('BR_DICT').get('LENGTH');

    % saves RNG
    rng_settings_ = rng(); rng('default')

    sex_options = {'Female' 'Male'};

    %% Specify the network parameters for the two groups
    N_nodes = 90; % AAL atlas
    
    %% Specify length of time series 
    N_tslength = 200;
    
    %% Specify number of subjects
    N_groups = 10;
    
    %% Group 1
    gr1_ts = cell(1, N_groups);
    gr1_name = 'FUN_Group_1_XLS';
    gr1_dir = [data_dir filesep() gr1_name];
    mkdir(gr1_dir);
    vois1 = [
    {{'Subject ID'} {'Age'} {'Sex'}}
    {{} {} cell2str(sex_options)}
    ];
    for i_gr = 1:1:10 % subject number
        sub_id = ['SubjectFUN_' num2str(i_gr)];
        % create WS graphs with random beta
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
        gr1_ts{1, i_gr} = R;
        
        writetable(array2table(R), [gr1_dir filesep() sub_id '.xlsx'], 'WriteVariableNames', false)

        % variables of interest
        vois1 = [vois1; {sub_id, randi(90), sex_options(randi(2))}];

    end
    writetable(table(vois1), [data_dir filesep() gr1_name '.vois.xlsx'], 'WriteVariableNames', false)

    %% Group 2
    gr2_ts = cell(1, N_groups);
    gr2_name = 'FUN_Group_2_XLS';
    gr2_dir = [data_dir filesep() gr2_name];
    mkdir(gr2_dir);
    vois2 = [
    {{'Subject ID'} {'Age'} {'Sex'}}
    {{} {} cell2str(sex_options)}
    ];
    for i_gr = 11:1:20 % subject number
        sub_id = ['SubjectFUN_' num2str(i_gr)];
        % create WS graphs with random beta
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
        gr2_ts{1, i_gr} = R;
        
        writetable(array2table(R), [gr2_dir filesep() sub_id '.xlsx'], 'WriteVariableNames', false)

        % variables of interest
        vois2 = [vois2; {sub_id, randi(90), sex_options(randi(2))}];

    end
    writetable(table(vois2), [data_dir filesep() gr2_name '.vois.xlsx'], 'WriteVariableNames', false)

    %% Group 3
    gr3_ts = cell(1, N_groups);
    gr3_name = 'FUN_Group_3_XLS';
    gr3_dir = [data_dir filesep() gr3_name];
    mkdir(gr3_dir);
    vois3 = [
    {{'Subject ID'} {'Age'} {'Sex'}}
    {{} {} cell2str(sex_options)}
    ];
    for i_gr = 21:1:30  % subject number
        sub_id = ['SubjectFUN_' num2str(i_gr)];
        % create WS graphs with random beta
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
        gr3_ts{1, i_gr} = R;
        
        writetable(array2table(R), [gr3_dir filesep() sub_id '.xlsx'], 'WriteVariableNames', false)

        % variables of interest
        vois3 = [vois3; {sub_id, randi(90), sex_options(randi(2))}];

    end
    writetable(table(vois3), [data_dir filesep() gr3_name '.vois.xlsx'], 'WriteVariableNames', false)

    % reset RNG
    rng(rng_settings_)
end

%%% ¡test_functions!
function h = WattsStrogatz(N, K, beta)
% H = WattsStrogatz(N,K,beta) returns a Watts-Strogatz model graph with N
% nodes, N*K edges, mean node degree 2*K, and rewiring probability beta.
%
% beta = 0 is a ring lattice, and beta = 1 is a random graph.

% Connect each node to its K next and previous neighbors. This constructs
% indices for a ring lattice.
    s = repelem((1:N)', 1, K);
    t = s + repmat(1:K, N, 1);
    t = mod(t - 1, N) + 1;
    
    % Rewire the target node of each edge with probability beta
    for source = 1:N
        switchEdge = rand(K, 1) < beta;
        
        newTargets = rand(N, 1);
        newTargets(source) = 0;
        newTargets(s(t == source)) = 0;
        newTargets(t(source, ~switchEdge)) = 0;
        
        [~, ind] = sort(newTargets, 'descend');
        t(source, switchEdge) = ind(1:nnz(switchEdge));
    end
    
    h = graph(s,t);
end

%%% ¡test! 
%%%% ¡name!
Create a NNDataset containg NNDataPoint_FUN_CLA with simulated data
%%%% ¡code!
% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_FUN_CLA')) filesep 'Example data NN CLA FUN XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Groups of SubjectFUN
im_gr1 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_FUN_CLA')) filesep 'Example data NN CLA FUN XLS' filesep 'FUN_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_FUN_CLA')) filesep 'Example data NN CLA FUN XLS' filesep 'FUN_Group_2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

% create a item list of NNDataPoint_FUN_CLA
[~, group_folder_name] = fileparts(im_gr1.get('DIRECTORY'));
it_list1 = cellfun(@(x) NNDataPoint_FUN_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', {group_folder_name}), ...
    gr1.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

[~, group_folder_name] = fileparts(im_gr2.get('DIRECTORY'));
it_list2 = cellfun(@(x) NNDataPoint_FUN_CLA( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', {group_folder_name}), ...
    gr2.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create a NNDataPoint_FUN_CLA DICT
dp_list1 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_FUN_CLA', ...
        'IT_LIST', it_list1 ...
        );

dp_list2 = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_FUN_CLA', ...
        'IT_LIST', it_list2 ...
        );

% create a NNDataset containing the NNDataPoint_FUN_CLA DICT
d1 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_FUN_CLA', ...
    'DP_DICT', dp_list1 ...
    );

d2 = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_FUN_CLA', ...
    'DP_DICT', dp_list2 ...
    );

% Check whether the number of inputs matches
assert(length(d1.get('INPUTS')) == gr1.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_FUN_CLA:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_FUN_CLA does not construct the dataset correctly. The number of the inputs should be the same as the number of imported subjects of group1.' ...
		)

assert(length(d2.get('INPUTS')) == gr2.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_FUN_CLA:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_FUN_CLA does not construct the dataset correctly. The number of the inputs should be the same as the number of imported subjects of group2.' ...
		)

% Check whether the number of targets matches
assert(length(d1.get('TARGETS')) == gr1.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_FUN_CLA:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_FUN_CLA does not construct the dataset correctly. The number of the targets should be the same as the number of imported subjects of group1.' ...
		)

assert(length(d2.get('TARGETS')) == gr2.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_FUN_CLA:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_FUN_CLA does not construct the dataset correctly. The number of the targets should be the same as the number of imported subjects of group2.' ...
		)

% Check whether the content of input for a single datapoint matches
for index = 1:1:gr1.get('SUB_DICT').get('LENGTH')
    individual_input = d1.get('DP_DICT').get('IT', index).get('INPUT');
    known_input = {gr1.get('SUB_DICT').get('IT', index).get('FUN')};

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_FUN_CLA:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_FUN_CLA does not construct the dataset correctly. The input value is not derived correctly in group1.' ...
        )
end

for index = 1:1:gr2.get('SUB_DICT').get('LENGTH')
    individual_input = d2.get('DP_DICT').get('IT', index).get('INPUT');
    known_input = {gr2.get('SUB_DICT').get('IT', index).get('FUN')};

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_FUN_CLA:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_FUN_CLA does not construct the dataset correctly. The input value is not derived correctly in group2.' ...
        )
end

%%% ¡test! 
%%%% ¡name!
Example training-test classification
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_FUN_CLA')) filesep 'Example data NN CLA FUN XLS' filesep 'atlas.xlsx'])
    test_NNDataPoint_FUN_CLA % create example files
end

example_NN_FUN_CLA