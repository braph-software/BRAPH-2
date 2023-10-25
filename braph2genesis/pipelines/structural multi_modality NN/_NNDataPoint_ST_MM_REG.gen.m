%% ¡header!
NNDataPoint_ST_MM_REG < NNDataPoint (dp, structural multimodality regression data point) is a data point for regression with structural multimodality data.

%%% ¡description!
A data point for regression with structural multimodality data (NNDataPoint_ST_MM_REG) 
 contains the input and target for neural network analysis with a subject 
 with structural multiplex data (SubjectST_MP).
The input is the structural multiplex data of the subject.
The target is obtained from the variables of interest of the subject.

%%% ¡seealso!
SubjectST_MP

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the data point for regression with structural multimodality data.
%%%% ¡default!
'NNDataPoint_ST_MM_REG'

%%% ¡prop!
NAME (constant, string) is the name of a data point for regression with structural multimodality data.
%%%% ¡default!
'Neural Network Structural Multimodality Data Point for Regression'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of a data point for regression with structural multimodality data.
%%%% ¡default!
'A data point for regression with structural multimodality data (NNDataPoint_ST_MM_REG) contains the input and target for neural network analysis with a subject with structural multiplex data (SubjectST_MP). The input is the structural multiplex data of the subject. The target is obtained from the variables of interest of the subject.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of a data point for regression with structural multimodality data.
%%%% ¡settings!
'NNDataPoint_ST_MM_REG'

%%% ¡prop!
ID (data, string) is a few-letter code for a data point for regression with structural multimodality data.
%%%% ¡default!
'NNDataPoint_ST_MM_REG ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of a data point for regression with structural multimodality data.
%%%% ¡default!
'NNDataPoint_ST_MM_REG label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about a data point for regression with structural multimodality data.
%%%% ¡default!
'NNDataPoint_ST_MM_REG notes'

%%% ¡prop!
INPUT (result, cell) is the input value for this data point.
%%%% ¡calculate!
value = dp.get('SUB').get('ST_MP');

%%% ¡prop!
TARGET (result, cell) is the target value for this data point.
%%%% ¡calculate!
value = cellfun(@(x) dp.get('SUB').get('VOI_DICT').get('IT', x).get('V'), dp.get('TARGET_IDS'), 'UniformOutput', false);

%% ¡props!

%%% ¡prop!
SUB (data, item) is a subject with structural multimodality data.
%%%% ¡settings!
'SubjectST_MP'

%%% ¡prop!
TARGET_IDS (parameter, stringlist) is a list of variable-of-interest IDs to be used as regression targets.
					
%% ¡tests!

%%% ¡excluded_props!
[NNDataPoint_ST_MM_REG.SUB]

%%% ¡test!
%%%% ¡name!
Create example files for regression
%%%% ¡code!
data_dir = [fileparts(which('NNDataPoint_ST_MM_REG')) filesep 'Example data NN REG ST_MM XLS'];
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
    gr_name = 'ST_MM_Group_XLS';
    
    % Group 1
    N_subjects = 50;
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
    sub_Tags1 = strings(size(R11, 1), 1);
    for i_sub = 1:1:length(sub_Tags1)
        sub_Tags1(i_sub) = string(['sub_' num2str(i_sub)]);
    end
    label_Tags1 = strings(size(R11, 1), 1);
    for i_sub = 1:1:length(label_Tags1)
        label_Tags1(i_sub) = string(['Label ' num2str(i_sub)]);
    end
    note_Tags1 = strings(size(R11, 1), 1);
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
    gr_dir = [data_dir filesep() gr_name];
    mkdir(gr_dir)
    writetable(T_group11, [gr_dir filesep() 'ST_MM_Group_XLS.1.xlsx'], 'WriteRowNames', true)
    writetable(T_group12, [gr_dir filesep() 'ST_MM_Group_XLS.2.xlsx'], 'WriteRowNames', true)

    % variables of interest
    vois = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    for i = 1:1:N_subjects
        vois = [vois; {sub_Tags1{i}, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois), [data_dir filesep() gr_name '.vois.xlsx'], 'WriteVariableNames', false)

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
Create a NNDataset containg NNDataPoint_ST_MM_REG with simulated data
%%%% ¡code!
% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_ST_MM_REG')) filesep 'Example data NN REG ST_MM XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

% Load Group of SubjectST_MP
im_gr = ImporterGroupSubjectST_MP_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_ST_MM_REG')) filesep 'Example data NN REG ST_MM XLS' filesep 'ST_MM_Group_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr = im_gr.get('GR');

% create a item list of NNDataPoint_ST_MM_REG
it_list = cellfun(@(x) NNDataPoint_ST_MM_REG( ...
    'ID', x.get('ID'), ...
    'SUB', x, ...
    'TARGET_IDS', x.get('VOI_DICT').get('KEYS')), ...
    gr.get('SUB_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create a NNDataPoint_ST_MM_REG DICT
dp_list = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_ST_MM_REG', ...
        'IT_LIST', it_list ...
        );

% create a NNDataset containing the NNDataPoint_ST_MM_REG DICT
d = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_ST_MM_REG', ...
    'DP_DICT', dp_list ...
    );

% Check whether the number of inputs matches
assert(length(d.get('INPUTS')) == gr.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_ST_MM_REG:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_ST_MM_REG does not construct the dataset correctly. The number of the inputs should be the same as the number of imported subjects.' ...
		)

% Check whether the number of targets matches
assert(length(d.get('TARGETS')) == gr.get('SUB_DICT').get('LENGTH'), ...
		[BRAPH2.STR ':NNDataPoint_ST_MM_REG:' BRAPH2.FAIL_TEST], ...
		'NNDataPoint_ST_MM_REG does not construct the dataset correctly. The number of the targets should be the same as the number of imported subjects.' ...
		)

% Check whether the content of input for a single datapoint matches
for index = 1:1:gr.get('SUB_DICT').get('LENGTH')
    individual_input = d.get('DP_DICT').get('IT', index).get('INPUT');
    known_input = gr.get('SUB_DICT').get('IT', index).get('ST_MP');

    assert(isequal(individual_input, known_input), ...
        [BRAPH2.STR ':NNDataPoint_ST_MM_REG:' BRAPH2.FAIL_TEST], ...
        'NNDataPoint_ST_MM_REG does not construct the dataset correctly. The input value is not derived correctly.' ...
        )
end

%%% ¡test! 
%%%% ¡name!
Example training-test regression
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_ST_MM_REG')) filesep 'Example data NN REG ST_MM XLS' filesep 'atlas.xlsx'])
    test_NNDataPoint_ST_MM_REG % create example files
end

example_NN_ST_MM_REG

%%% ¡test! 
%%%% ¡name!
Example cross-validation regression
%%%% ¡code!
% ensure the example data is generated
if ~isfile([fileparts(which('NNDataPoint_ST_MM_REG')) filesep 'Example data NN REG ST_MM XLS' filesep 'atlas.xlsx'])
    test_NNDataPoint_ST_MM_REG % create example files
end

example_NNCV_ST_MM_REG