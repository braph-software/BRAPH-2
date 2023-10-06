%% ¡header!
CombineGroups_CON_FUN_MP < ConcreteElement (co, combiner of CON and FUN subject groups) combines a group of subjects with connectivity data with a group of subjects with functional data.

%%% ¡description!
CombineGroups_CON_FUN_MP combines a group of subjects with connectivity 
 data (SubjectCON) with a group of subjects with functional data (SubjectFUN)
 into a group of subjects with connectivity and functional data 
 (SubjectCON_FUN_MP). The subject ids of the two groups must match.
The brain atlas and variables of interest are copied from the SubjectCON group.

%%% ¡seealso!
SubjectCON_FUN_MP, SubjectCON, SubjectFUN, SeparateGroups_CON_FUN

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the combiner of CON and FUN subject groups.
%%%% ¡default!
'CombineGroups_CON_FUN_MP'

%%% ¡prop!
NAME (constant, string) is the name of the combiner of CON and FUN subject groups.
%%%% ¡default!
'CombineGroups_CON_FUN_MP'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the combiner of CON and FUN subject groups.
%%%% ¡default!
'CombineGroups_CON_FUN_MP combines a group of subjects with connectivity data (SubjectCON) with a group of subjects with functional data (SubjectFUN) into a group of subjects with connectivity and functional data (SubjectCON_FUN_MP). The subject ids of the two groups must match. The brain atlas and variables of interest are copied from the SubjectCON group.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the combiner of CON and FUN subject groups.
%%% ¡settings!
'CombineGroups_CON_FUN_MP'

%%% ¡prop!
ID (data, string) is a few-letter code for the combiner of CON and FUN subject groups.
%%%% ¡default!
'CombineGroups_CON_FUN_MP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the combiner of CON and FUN subject groups.
%%%% ¡default!
'CombineGroups_CON_FUN_MP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the combiner of CON and FUN subject groups.
%%%% ¡default!
'CombineGroups_CON_FUN_MP notes'

%% ¡props!

%%% ¡prop!
WAITBAR (metadata, logical) detemines whether to show the waitbar.

%%% ¡prop!
GR_CON (data, item) is a group of subjects with connectivity data.
%%%% ¡settings!
'Group'
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'))
%%%% ¡check_prop!
check = any(strcmp(value.get('SUB_CLASS'), SubjectCON.getSubclasses()));

%%% ¡prop!
GR_FUN (data, item) is a group of subjects with functional data.
%%%% ¡settings!
'Group'
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN'))
%%%% ¡check_prop!
check = any(strcmp(value.get('SUB_CLASS'), SubjectFUN.getSubclasses()));

%%% ¡prop!
GR_CON_FUN_MP (result, item) is a group of subjects with connectivity and functional data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get('SUB_CLASS'), SubjectCON_FUN_MP.getSubclasses()));
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_FUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP'))
%%%% ¡calculate!
wb = braph2waitbar(co.get('WAITBAR'), 0, 'Combining subject groups ...');

% get connectivity and functional groups
gr_CON = co.get('GR_CON');
gr_FUN = co.get('GR_FUN');
if gr_CON.get('SUB_DICT').get('LENGTH') ~= gr_FUN.get('SUB_DICT').get('LENGTH')
    error( ...
        [BRAPH2.STR ':' class(co) ':' BRAPH2.WRONG_INPUT], ...
        [BRAPH2.STR ':' class(co) ':' BRAPH2.WRONG_INPUT '\\n' ...
        'The groups to be combined must have the same number of subjects, ', ...
        'while group CON has ' int2str(gr_CON.get('SUB_DICT').get('LENGTH')) ' subjects and group FUN has ' int2str(gr_FUN.get('SUB_DICT').get('LENGTH')) ' subjects.'] ...
        )   
end
    
% creates empty group
gr = Group( ...
    'SUB_CLASS', 'SubjectCON_FUN_MP', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP'), ...
    'ID', [gr_CON.get('ID') ' + ' gr_FUN.get('ID')], ...
    'LABEL', [gr_CON.get('LABEL') ' -- ' gr_FUN.get('LABEL')], ...
    'NOTES', ['Group combining the connectivity group ' gr_CON.get('ID') ' and the functional group ' gr_FUN.get('ID')] ...
    );

sub_dict = gr.get('SUB_DICT');
sub_dict_gr_CON = gr_CON.get('SUB_DICT');
sub_dict_gr_FUN = gr_FUN.get('SUB_DICT');

for i = 1:1:gr_CON.get('SUB_DICT').get('LENGTH')
    braph2waitbar(wb, .15 + .85 * i / gr_CON.get('SUB_DICT').get('LENGTH'), ['Combining subject ' num2str(i) ' of ' num2str(gr_CON.get('SUB_DICT').get('LENGTH')) ' ...'])

    sub_CON = sub_dict_gr_CON.get('IT', i);
    sub_id = sub_CON.get('ID');
    
    sub_FUN = sub_dict_gr_FUN.get('IT', sub_id);
    
    sub = SubjectCON_FUN_MP( ...
        'ID', sub_id, ...
        'BA', sub_CON.get('BA'), ...
        'VOI_DICT', sub_CON.get('VOI_DICT').copy(), ...
        'CON', sub_CON.get('CON'), ...
        'FUN', sub_FUN.get('FUN') ...
        );
    sub_dict.get('ADD', sub);
end

value = gr;

braph2waitbar(wb, 'close')

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Create example files
%%%% ¡code!
data_dir = [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP XLS'];
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
    N_subjects_group1 = 10;
    N_subjects_group2 = 10;
    N_subjects_group3 = 10;
    N_tslength = 200;
    
    % Group 1
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
    gr1_ts1 = cell(1, N_subjects_group1); % layer 1
    gr1_ts2 = cell(1, N_subjects_group1); % layer 2
    gr_name1_1 = 'CON_Group1_XLS';
    gr_name1_2 = 'FUN_Group1_XLS';
    vois1 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    sub_id = cell(1, N_subjects_group1);
    for i = 1:1:N_subjects_group1 % subject number
        sub_id(i) = {['SubjectCON_FUN_MP_' num2str(i)]};

        % randomize the parameters
        K_temp = K1(randperm(length(K1)));
        beta_temp = beta1(randperm(length(beta1)));
        % initialize matrix for the subject
        A_full1 = zeros(N);
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
        gr1_ts1{1, i} = R11;
        gr1_ts2{1, i} = A_full2;
        
        % variables of interest
        vois1 = [vois1; {sub_id{i}, randi(90), sex_options(randi(2))}];
    end
    % Create the tables - functional layer
    %tables_gr11 = cell(size(gr1_ts1));
    mkdir([data_dir filesep() 'Functional' filesep() gr_name1_2]);
    for i_tab = 1:1:N_subjects_group1
        T_gr11 = array2table(gr1_ts1{i_tab});
        %tables_gr11{i_tab} = T_gr11;
        file_name = [data_dir filesep() 'Functional' filesep() gr_name1_2 filesep() sub_id{i_tab} '.xlsx'];
        writetable(T_gr11, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
    end
    
    % Create the tables - connectivity layer
    %tables_gr12 = cell(size(gr1_ts2));
    mkdir([data_dir filesep() 'Connectivity' filesep() gr_name1_1]);
    for i_tab = 1:1:N_subjects_group1
        T_gr12 = array2table(gr1_ts2{i_tab});
        %tables_gr12{i_tab} = T_gr12;
        file_name = [data_dir filesep() 'Connectivity' filesep() gr_name1_1 filesep() sub_id{i_tab} '.xlsx'];
        writetable(T_gr12, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
    end
    writetable(table(vois1), [data_dir filesep() 'Connectivity' filesep() gr_name1_1 '.vois.xlsx'], 'WriteVariableNames', false)
    writetable(table(vois1), [data_dir filesep() 'Functional' filesep() gr_name1_2 '.vois.xlsx'], 'WriteVariableNames', false)
    
    % Group 2
    % initialize values for the WS model
    K2 = [3 7];
    beta2 = [0.02 0.85];
    % initialize the indices where the matrices will be placed
    indices1 = 1:1:45;
    indices2 = 46:1:90;
    indices = {indices1; indices2};
    gr2_ts1 = cell(1, N_subjects_group2); % layer 1
    gr2_ts2 = cell(1, N_subjects_group2); % layer 2
    gr2_name1 = 'CON_Group2_XLS';
    gr2_name2 = 'FUN_Group2_XLS';
    vois2 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    sub_id = cell(1, N_subjects_group1);
    for i = N_subjects_group1+1:1:N_subjects_group1+N_subjects_group2 % subject number
        sub_id(i) = {['SubjectCON_FUN_MP_' num2str(i)]};
        
        % randomize the parameters
        K_temp = K2(randperm(length(K2)));
        beta_temp = beta2(randperm(length(beta2)));
        % initialize matrix for the subject
        A_full1 = zeros(N);
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
        gr2_ts1{1, i} = R21;
        gr2_ts2{1, i} = A_full2;
        
        % variables of interest
        vois2 = [vois2; {sub_id{i}, randi(90), sex_options(randi(2))}];
    end
    % Create the tables - functional layer
    %tables_gr11 = cell(size(gr2_ts1));
    mkdir([data_dir filesep() 'Functional' filesep() gr2_name2]);
    for i_tab = N_subjects_group1+1:1:N_subjects_group1 + N_subjects_group2
        T_gr21 = array2table(gr2_ts1{i_tab});
        %tables_gr21{i_tab} = T_gr21;
        file_name = [data_dir filesep() 'Functional' filesep() gr2_name2 filesep() sub_id{i_tab} '.xlsx'];
        writetable(T_gr21, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
    end
    
    % Create the tables - connectivity layer
    %tables_gr12 = cell(size(gr2_ts2));
    mkdir([data_dir filesep() 'Connectivity' filesep() gr2_name1]);
    for i_tab = N_subjects_group1+1:1:N_subjects_group1 + N_subjects_group2
        T_gr22 = array2table(gr2_ts2{i_tab});
        %tables_gr22{i_tab} = T_gr22;
        file_name = [data_dir filesep() 'Connectivity' filesep() gr2_name1 filesep() sub_id{i_tab} '.xlsx'];
        writetable(T_gr22, file_name, 'WriteRowNames', false, 'WriteVariableNames', false)
    end  
    writetable(table(vois2), [data_dir filesep() 'Connectivity' filesep() gr2_name1 '.vois.xlsx'], 'WriteVariableNames', false)
    writetable(table(vois2), [data_dir filesep() 'Functional' filesep() gr2_name2 '.vois.xlsx'], 'WriteVariableNames', false)
    
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
Basic functioning
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP XLS' filesep 'atlas.xlsx']);
ba = im_ba.get('BA');

im_gr_CON = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP XLS' filesep 'Connectivity' filesep 'CON_Group1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr_CON = im_gr_CON.get('GR');

im_gr_FUN = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP XLS' filesep 'Functional' filesep 'FUN_Group1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr_FUN = im_gr_FUN.get('GR');

co = CombineGroups_CON_FUN_MP( ...
    'GR_CON', gr_CON, ...
    'GR_FUN', gr_FUN ...
    );
gr = co.get('GR_CON_FUN_MP');

gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')

assert(gr.get('SUB_DICT').get('LENGTH') == gr_CON.get('SUB_DICT').get('LENGTH'), ...
	[BRAPH2.STR ':CombineGroups_CON_FUN_MP:' BRAPH2.FAIL_TEST], ...
    'Problems combining the groups.')
for i = 1:1:gr_CON.get('SUB_DICT').get('LENGTH')
    sub_CON = gr_CON.get('SUB_DICT').get('IT', i);
    sub_FUN = gr_FUN.get('SUB_DICT').get('IT', i);
    sub = gr.get('SUB_DICT').get('IT', i);
    
    assert( ...
        isequal(sub.get('ID'), sub_CON.get('ID')) & ...
        isequal(sub.get('BA').get('ID'), sub_CON.get('BA').get('ID')) & ...
        isequal(sub.get('VOI_DICT').get('IT', 'Age').get('V'), sub_CON.get('VOI_DICT').get('IT', 'Age').get('V')) & ... 
        isequal(sub.get('VOI_DICT').get('IT', 'Sex').get('V'), sub_CON.get('VOI_DICT').get('IT', 'Sex').get('V')) & ...
        isequal(sub.get('CON'), sub_CON.get('CON')) & ...
        isequal(sub.get('FUN'), sub_FUN.get('FUN')), ...
        [BRAPH2.STR ':CombineGroups_CON_FUN_MP:' BRAPH2.FAIL_TEST], ...
        'Problems combining the groups.')    
end
