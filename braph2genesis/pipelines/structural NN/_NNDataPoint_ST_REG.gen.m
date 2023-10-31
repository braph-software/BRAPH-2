%% ¡header!
NNDataPoint_ST_REG < NNDataPoint (dp, structural regression data point) is a data point for regression with structural data.

%%% ¡description!
A data point for regression with structural data (NNDataPoint_ST_REG) 
 contains the input and target for neural network analysis with a subject with structural data (SubjectST).
The input is the structural data of the subject.
The target is obtained from the variables of interest of the subject.

%%% ¡seealso!
SubjectST

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the data point for regression with structural data.
%%%% ¡default!
'NNDataPoint_ST_REG'

%%% ¡prop!
NAME (constant, string) is the name of a data point for regression with structural data.
%%%% ¡default!
'Neural Network Structural Data Point for Regression'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of a data point for regression with structural data.
%%%% ¡default!
'A data point for regression with structural data (NNDataPoint_ST_REG) contains the input and target for neural network analysis with a subject with structural data (SubjectST). The input is the structural data of the subject. The target is obtained from the variables of interest of the subject.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of a data point for regression with structural data.
%%%% ¡settings!
'NNDataPoint_ST_REG'

%%% ¡prop!
ID (data, string) is a few-letter code for a data point for regression with structural data.
%%%% ¡default!
'NNDataPoint_ST_REG ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of a data point for regression with structural data.
%%%% ¡default!
'NNDataPoint_ST_REG label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about a data point for regression with structural data.
%%%% ¡default!
'NNDataPoint_ST_REG notes'

%%% ¡prop!
INPUT (result, cell) is the input value for this data point.
%%%% ¡calculate!
value = {dp.get('SUB').get('ST')};
    
%%% ¡prop!
TARGET (result, cell) is the target value for this data point.
%%%% ¡calculate!
value = cellfun(@(x) dp.get('SUB').get('VOI_DICT').get('IT', x).get('V'), dp.get('TARGET_IDS'), 'UniformOutput', false);

%% ¡props!

%%% ¡prop!
SUB (data, item) is a subject with structural data.
%%%% ¡settings!
'SubjectST'

%%% ¡prop!
TARGET_IDS (parameter, stringlist) is a list of variable-of-interest IDs to be used as regression targets.
					
%% ¡tests!

%%% ¡excluded_props!
[NNDataPoint_ST_REG.SUB]

%%% ¡test!
%%%% ¡name!
Create example files for regression
%%%% ¡code!
data_dir = [fileparts(which('NNDataPoint_ST_REG')) filesep 'Example data NN REG ST XLS'];
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
    sex_options = {'Female' 'Male'};

    % Group 
    N_subjects = 50;
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
Create a NNDataset containg NNDataPoint_ST_REG with simulated data
%%%% ¡code!
% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_ST_REG')) filesep 'Example data NN REG ST XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Group of SubjectST
im_gr = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('NNDataPoint_ST_REG')) filesep 'Example data NN REG ST XLS' filesep 'ST_Group_1.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr = im_gr.get('GR');

% create a item list of NNDataPoint_ST_REG
it_list = cellfun(@(x) NNDataPoint_ST_REG( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', x.get('VOI_DICT').get('KEYS')), ...
    gr.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create a NNDataPoint_ST_REG DICT
dp_list = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_ST_REG', ...
        'IT_LIST', it_list ...
        );

% create a NNDataset containing the NNDataPoint_ST_REG DICT
d = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_ST_REG', ...
    'DP_DICT', dp_list ...
    );

% Check whether the number of inputs matches
assert(length(d.get('INPUTS')) == gr.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_ST_REG:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_ST_REG does not construct the dataset correctly. The number of the inputs should be the same as the number of imported subjects.' ...
		)

% Check whether the number of targets matches
assert(length(d.get('TARGETS')) == gr.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_ST_REG:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_ST_REG does not construct the dataset correctly. The number of the targets should be the same as the number of imported subjects.' ...
		)

% Check whether the content of input for a single datapoint matches
for index = 1:1:gr.get('SUB_DICT').get('LENGTH')
    individual_input = d.get('DP_DICT').get('IT', index).get('INPUT');
    known_input = {gr.get('SUB_DICT').get('IT', index).get('ST')};

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_ST_REG:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_ST_REG does not construct the dataset correctly. The input value is not derived correctly.' ...
        )
end

%%% ¡test! 
%%%% ¡name!
Example training-test regression
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_ST_REG')) filesep 'Example data NN REG ST XLS' filesep 'atlas.xlsx'])
    test_NNDataPoint_ST_REG % create example files
end

example_NN_ST_REG

%%% ¡test! 
%%%% ¡name!
Example cross-validation regression
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_ST_REG')) filesep 'Example data NN REG ST XLS' filesep 'atlas.xlsx'])
    test_NNDataPoint_ST_REG % create example files
end

example_NNCV_ST_REG