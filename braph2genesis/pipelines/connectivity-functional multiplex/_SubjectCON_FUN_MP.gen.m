%% ¡header!
SubjectCON_FUN_MP < Subject (sub, subject with connectivity and functional multiplex data) is a subject with connectivity and functional multiplex data (e.g. DTI and fMRI).

%%% ¡description!
Subject with connectivity and functional data (e.g. obtained from DTI and fMRI).
The first layer contains a connectivity matrix and the second layer contains functional data.

%%% ¡seealso!
CombineGroups_CON_FUN_MP, SeparateGroups_CON_FUN_MP

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
SubjectCON_FUN_MP.ID
%%%% ¡title!
Subject ID

%%% ¡prop!
%%%% ¡id!
SubjectCON_FUN_MP.LABEL
%%%% ¡title!
Subject LABEL

%%% ¡prop!
%%%% ¡id!
SubjectCON_FUN_MP.BA
%%%% ¡title!
Brain Atlas

%%% ¡prop!
%%%% ¡id!
SubjectCON_FUN_MP.VOI_DICT
%%%% ¡title!
Variables of Interest

%%% ¡prop!
%%%% ¡id!
SubjectCON_FUN_MP.CON
%%%% ¡title!
Connectivity DATA

%%% ¡prop!
%%%% ¡id!
SubjectCON_FUN_MP.FUN
%%%% ¡title!
Functional DATA

%%% ¡prop!
%%%% ¡id!
SubjectCON_FUN_MP.NOTES
%%%% ¡title!
Subject NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'SubjectCON_FUN_MP'

%%% ¡prop!
NAME (constant, string) is the name of the subject.
%%%% ¡default!
'SubjectCON_FUN_MP'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the subject.
%%%% ¡default!
'Subject with connectivity and functional data (e.g. obtained from DTI and fMRI). The first layer contains a connectivity matrix and the second layer contains functional data.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the subject.
%%% ¡settings!
'SubjectCON_FUN_MP'

%%% ¡prop!
ID (data, string) is a few-letter code for the subject.
%%%% ¡default!
'SubjectCON_FUN_MP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the subject.
%%%% ¡default!
'SubjectCON_FUN_MP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the subject.
%%%% ¡default!
'SubjectCON_FUN_MP notes'

%% ¡props!

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
CON (data, smatrix) is an adjacency matrix.
%%%% ¡check_value!
br_number = sub.get('BA').get('BR_DICT').get('LENGTH');
check = isequal(size(value), [br_number, br_number]); % Format.checkFormat(Format.SMATRIX, value) already checked
if check
    msg = 'All ok!';
else   
    msg = ['CON must be a square matrix with the dimensiton equal to the number of brain regions (' int2str(br_number) ').'];
end
%%%% ¡gui!
pr = PanelPropMatrix('EL', sub, 'PROP', SubjectCON.CON, ...
    'ROWNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
    'COLUMNNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
    varargin{:});

%%% ¡prop!
FUN (data, matrix) is an adjacency matrix.
%%%% ¡check_value!
br_number = sub.get('BA').get('BR_DICT').get('LENGTH');
check = size(value, 2) == br_number; % Format.checkFormat(Format.MATRIX, value) already checked
if check
    msg = 'All ok!';
else   
    msg = ['FUN must be a matrix with the same number of columns as the brain regions (' int2str(br_number) ').'];
end
%%%% ¡gui!
pr = PanelPropMatrix('EL', sub, 'PROP', SubjectFUN.FUN, ...
    'ROWNAME', {'numbered'}, ...
    'COLUMNNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
    varargin{:});

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GUI
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', 'desikan_atlas.xlsx');
ba = im_ba.get('BA');

gr = Group('SUB_CLASS', 'SubjectCON_FUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP'));
for i = 1:1:50
    sub = SubjectCON_FUN_MP( ...
        'ID', ['SUB CON ' int2str(i)], ...
        'LABEL', ['Subejct CON ' int2str(i)], ...
        'NOTES', ['Notes on subject CON ' int2str(i)], ...
        'BA', ba, ...
        'CON', rand(ba.get('BR_DICT').get('LENGTH')), ...
        'FUN', rand(10, ba.get('BR_DICT').get('LENGTH')) ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr.get('SUB_DICT').get('ADD', sub)
end

gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')

%%% ¡test!
%%%% ¡name!
Create example files XLS
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

    T = 200; % Length of the time series

    % Group 1 directories
    gr1_name = 'CON_FUN_MP_Group_1_XLS';
    gr1_dir = [data_dir filesep() gr1_name];
    mkdir([gr1_dir '.CON']);
    mkdir([gr1_dir '.FUN']);

    % Group 1 - CON + VOIS
    K1 = 2; % degree (mean node degree is 2K) - group 1
    beta1 = 0.3; % Rewiring probability - group 1
    vois1 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    for i = 1:1:50 % subject number
        sub_id = ['SubjectCON_FUN_MP_' num2str(i)];

        h1 = WattsStrogatz(N, K1, beta1); % create two WS graph
        % figure(1) % Plot the two graphs to double-check
        % plot(h1, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
        % title(['Group 1: Graph with $N = $ ' num2str(N_nodes) ...
        %     ' nodes, $K = $ ' num2str(K1) ', and $\beta = $ ' num2str(beta1)], ...
        %     'Interpreter','latex')
        % axis equal

        A1 = full(adjacency(h1)); A1(1:length(A1)+1:numel(A1)) = 0; % extract the adjacency matrix
        r = 0 + (0.5 - 0)*rand(size(A1)); diffA = A1 - r; A1(A1 ~= 0) = diffA(A1 ~= 0); % make the adjacency matrix weighted
        A1 = max(A1, transpose(A1)); % make the adjacency matrix symmetric

        writetable(array2table(A1), [gr1_dir '.CON' filesep() sub_id '.xlsx'], 'WriteVariableNames', false)

        % variables of interest
        vois1 = [vois1; {sub_id, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois1), [data_dir filesep() gr1_name '.vois.xlsx'], 'WriteVariableNames', false)

    % Group 1 directories
    gr2_name = 'CON_FUN_MP_Group_2_XLS';
    gr2_dir = [data_dir filesep() gr2_name];
    mkdir([gr2_dir '.CON']);
    mkdir([gr2_dir '.FUN']);

    % Group 2 - CON + VOIS
    K2 = 2; % degree (mean node degree is 2K) - group 2
    beta2 = 0.85; % Rewiring probability - group 2
    vois2 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    for i = 51:1:100
        sub_id = ['SubjectCON_FUN_MP_' num2str(i)];

        h2 = WattsStrogatz(N, K2, beta2);
        % figure(2)
        % plot(h2, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
        % title(['Group 2: Graph with $N = $ ' num2str(N_nodes) ...
        %     ' nodes, $K = $ ' num2str(K2) ', and $\beta = $ ' num2str(beta2)], ...
        %     'Interpreter','latex')
        % axis equal

        A2 = full(adjacency(h2)); A2(1:length(A2)+1:numel(A2)) = 0;
        r = 0 + (0.5 - 0)*rand(size(A2)); diffA = A2 - r; A2(A2 ~= 0) = diffA(A2 ~= 0);
        A2 = max(A2, transpose(A2));

        writetable(array2table(A2), [gr2_dir '.CON' filesep() sub_id '.xlsx'], 'WriteVariableNames', false)

        % variables of interest
        vois2 = [vois2; {sub_id, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois2), [data_dir filesep() gr2_name '.vois.xlsx'], 'WriteVariableNames', false)

    % Group 1 - FUN - 5 modules of 18 nodes each
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
    for i = 1:1:50 % subject number
        sub_id = ['SubjectCON_FUN_MP_' num2str(i)];

        % randomize the parameters
        K_temp = K1(randperm(length(K1)));
        beta_temp = beta1(randperm(length(beta1)));

        % initialize matrix for the subject
        A_full = zeros(N);

        % loop over each module
        for i_mod = 1:1:5
            A_full(indices{i_mod}, indices{i_mod}) = full(adjacency(WattsStrogatz(18, K_temp(i_mod), beta_temp(i_mod))));
        end
        A_full(1:length(A_full)+1:numel(A_full)) = 1;

        % this is needed to make the matrices positive definite
        A_full = A_full * transpose(A_full);
        % figure(1)
        % imshow(A_full)

        % This matrix will be covariance matrices for the two groups
        % Specify the mean
        mu_gr1 = ones(1, length(A_full));
        % calculate time series
        R1 = mvnrnd(mu_gr1, A_full, T);
        % Normalize the time series
        mean_R1 = mean(R1);
        std_R1 = std(R1);
        R1 = (R1 - mean(R1)) ./ std(R1);

        writetable(array2table(R1), [gr1_dir '.FUN' filesep() sub_id '.xlsx'], 'WriteVariableNames', false)
    end

    % Group 2 - FUN - 2 modules of 45 nodes each
    % initialize values for the WS model
    K2 = [3 7];
    beta2 = [0.02 0.85];
    % initialize the indices where the matrices will be placed
    indices1 = 1:1:45;
    indices2 = 46:1:90;
    indices = {indices1; indices2};
    for i = 51:1:100
        sub_id = ['SubjectCON_FUN_MP_' num2str(i)];

        % randomize the parameters
        K_temp = K2(randperm(length(K2)));
        beta_temp = beta2(randperm(length(beta2)));

        % initialize matrix for the subject
        A_full = zeros(N);

        % loop over each module
        for i_mod = 1:1:2
        A_full(indices{i_mod},indices{i_mod}) = full(adjacency(WattsStrogatz(45, K_temp(i_mod), beta_temp(i_mod))));
        end
        A_full(1:length(A_full)+1:numel(A_full)) = 1;

        % this is needed to make the matrices positive definite
        A_full = A_full * transpose(A_full);
        % figure(2)
        % imshow(A_full)

        % This matrix will be covariance matrices for the two groups
        % Specify the mean
        mu_gr2 = ones(1, length(A_full));

        % calculate time series
        R2 = mvnrnd(mu_gr2, A_full, T);

        % Normalize the time series
        mean_R2 = mean(R2);
        std_R2 = std(R2);
        R2 = (R2 - mean(R2)) ./ std(R2);

        writetable(array2table(R2), [gr2_dir '.FUN' filesep() sub_id '.xlsx'], 'WriteVariableNames', false)
    end

    % reset RNG
    rng(rng_settings_)
end

%%% ¡test!
%%%% ¡name!
Create example files TXT
%%%% ¡code!
data_dir = [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP TXT'];
if ~isdir(data_dir)
    mkdir(data_dir);

    % Brain Atlas
    im_ba = ImporterBrainAtlasTXT('FILE', 'aal90_atlas.txt');
    ba = im_ba.get('BA');
    ex_ba = ExporterBrainAtlasTXT( ...
        'BA', ba, ...
        'FILE', [data_dir filesep() 'atlas.txt'] ...
        );
    ex_ba.get('SAVE')
    N = ba.get('BR_DICT').get('LENGTH');

    % saves RNG
    rng_settings_ = rng(); rng('default')

    sex_options = {'Female' 'Male'};

    T = 200; % Length of the time series

    % Group 1 directories
    gr1_name = 'CON_FUN_MP_Group_1_TXT';
    gr1_dir = [data_dir filesep() gr1_name];
    mkdir([gr1_dir '.CON']);
    mkdir([gr1_dir '.FUN']);

    % Group 1 - CON + VOIS
    K1 = 2; % degree (mean node degree is 2K) - group 1
    beta1 = 0.3; % Rewiring probability - group 1
    vois1 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} {['{' sprintf(' ''%s'' ', sex_options{:}) '}']}}
        ];
    for i = 1:1:50 % subject number
        sub_id = ['SubjectCON_FUN_MP_' num2str(i)];

        h1 = WattsStrogatz(N, K1, beta1); % create two WS graph
        % figure(1) % Plot the two graphs to double-check
        % plot(h1, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
        % title(['Group 1: Graph with $N = $ ' num2str(N_nodes) ...
        %     ' nodes, $K = $ ' num2str(K1) ', and $\beta = $ ' num2str(beta1)], ...
        %     'Interpreter','latex')
        % axis equal

        A1 = full(adjacency(h1)); A1(1:length(A1)+1:numel(A1)) = 0; % extract the adjacency matrix
        r = 0 + (0.5 - 0)*rand(size(A1)); diffA = A1 - r; A1(A1 ~= 0) = diffA(A1 ~= 0); % make the adjacency matrix weighted
        A1 = max(A1, transpose(A1)); % make the adjacency matrix symmetric

        writetable(array2table(A1), [gr1_dir '.CON' filesep() sub_id '.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

        % variables of interest
        vois1 = [vois1; {sub_id, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois1), [data_dir filesep() gr1_name '.vois.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

    % Group 1 directories
    gr2_name = 'CON_FUN_MP_Group_2_TXT';
    gr2_dir = [data_dir filesep() gr2_name];
    mkdir([gr2_dir '.CON']);
    mkdir([gr2_dir '.FUN']);

    % Group 2 - CON + VOIS
    K2 = 2; % degree (mean node degree is 2K) - group 2
    beta2 = 0.85; % Rewiring probability - group 2
    vois2 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} {['{' sprintf(' ''%s'' ', sex_options{:}) '}']}}
        ];
    for i = 51:1:100
        sub_id = ['SubjectCON_FUN_MP_' num2str(i)];

        h2 = WattsStrogatz(N, K2, beta2);
        % figure(2)
        % plot(h2, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
        % title(['Group 2: Graph with $N = $ ' num2str(N_nodes) ...
        %     ' nodes, $K = $ ' num2str(K2) ', and $\beta = $ ' num2str(beta2)], ...
        %     'Interpreter','latex')
        % axis equal

        A2 = full(adjacency(h2)); A2(1:length(A2)+1:numel(A2)) = 0;
        r = 0 + (0.5 - 0)*rand(size(A2)); diffA = A2 - r; A2(A2 ~= 0) = diffA(A2 ~= 0);
        A2 = max(A2, transpose(A2));

        writetable(array2table(A2), [gr2_dir '.CON' filesep() sub_id '.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

        % variables of interest
        vois2 = [vois2; {sub_id, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois2), [data_dir filesep() gr2_name '.vois.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

    % Group 1 - FUN - 5 modules of 18 nodes each
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
    for i = 1:1:50 % subject number
        sub_id = ['SubjectCON_FUN_MP_' num2str(i)];

        % randomize the parameters
        K_temp = K1(randperm(length(K1)));
        beta_temp = beta1(randperm(length(beta1)));

        % initialize matrix for the subject
        A_full = zeros(N);

        % loop over each module
        for i_mod = 1:1:5
            A_full(indices{i_mod}, indices{i_mod}) = full(adjacency(WattsStrogatz(18, K_temp(i_mod), beta_temp(i_mod))));
        end
        A_full(1:length(A_full)+1:numel(A_full)) = 1;

        % this is needed to make the matrices positive definite
        A_full = A_full * transpose(A_full);
        % figure(1)
        % imshow(A_full)

        % This matrix will be covariance matrices for the two groups
        % Specify the mean
        mu_gr1 = ones(1, length(A_full));
        % calculate time series
        R1 = mvnrnd(mu_gr1, A_full, T);
        % Normalize the time series
        mean_R1 = mean(R1);
        std_R1 = std(R1);
        R1 = (R1 - mean(R1)) ./ std(R1);

        writetable(array2table(R1), [gr1_dir '.FUN' filesep() sub_id '.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)
    end

    % Group 2 - FUN - 2 modules of 45 nodes each
    % initialize values for the WS model
    K2 = [3 7];
    beta2 = [0.02 0.85];
    % initialize the indices where the matrices will be placed
    indices1 = 1:1:45;
    indices2 = 46:1:90;
    indices = {indices1; indices2};
    for i = 51:1:100
        sub_id = ['SubjectCON_FUN_MP_' num2str(i)];

        % randomize the parameters
        K_temp = K2(randperm(length(K2)));
        beta_temp = beta2(randperm(length(beta2)));

        % initialize matrix for the subject
        A_full = zeros(N);

        % loop over each module
        for i_mod = 1:1:2
        A_full(indices{i_mod},indices{i_mod}) = full(adjacency(WattsStrogatz(45, K_temp(i_mod), beta_temp(i_mod))));
        end
        A_full(1:length(A_full)+1:numel(A_full)) = 1;

        % this is needed to make the matrices positive definite
        A_full = A_full * transpose(A_full);
        % figure(2)
        % imshow(A_full)

        % This matrix will be covariance matrices for the two groups
        % Specify the mean
        mu_gr2 = ones(1, length(A_full));

        % calculate time series
        R2 = mvnrnd(mu_gr2, A_full, T);

        % Normalize the time series
        mean_R2 = mean(R2);
        std_R2 = std(R2);
        R2 = (R2 - mean(R2)) ./ std(R2);

        writetable(array2table(R2), [gr2_dir '.FUN' filesep() sub_id '.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)
    end

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
GUI XLS
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP XLS' filesep 'atlas.xlsx']);
ba = im_ba.get('BA');

im_gr_CON = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP XLS' filesep 'CON_FUN_MP_Group_1_XLS.CON'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr_CON = im_gr_CON.get('GR');

gui_CON = GUIElement('PE', gr_CON, 'CLOSEREQ', false);
gui_CON.get('DRAW')
gui_CON.get('SHOW')

gui_CON.get('CLOSE')

im_gr_FUN = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP XLS' filesep 'CON_FUN_MP_Group_1_XLS.FUN'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr_FUN = im_gr_FUN.get('GR');

gui_FUN = GUIElement('PE', gr_FUN, 'CLOSEREQ', false);
gui_FUN.get('DRAW')
gui_FUN.get('SHOW')

gui_FUN.get('CLOSE')

%%% ¡test!
%%%% ¡name!
GUI TXT
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasTXT('FILE', [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP TXT' filesep 'atlas.txt']);
ba = im_ba.get('BA');

im_gr_CON = ImporterGroupSubjectCON_TXT( ...
    'DIRECTORY', [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP TXT' filesep 'CON_FUN_MP_Group_1_TXT.CON'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr_CON = im_gr_CON.get('GR');

gui_CON = GUIElement('PE', gr_CON, 'CLOSEREQ', false);
gui_CON.get('DRAW')
gui_CON.get('SHOW')

gui_CON.get('CLOSE')

im_gr_FUN = ImporterGroupSubjectFUN_TXT( ...
    'DIRECTORY', [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP TXT' filesep 'CON_FUN_MP_Group_1_TXT.FUN'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr_FUN = im_gr_FUN.get('GR');

gui_FUN = GUIElement('PE', gr_FUN, 'CLOSEREQ', false);
gui_FUN.get('DRAW')
gui_FUN.get('SHOW')

gui_FUN.get('CLOSE')