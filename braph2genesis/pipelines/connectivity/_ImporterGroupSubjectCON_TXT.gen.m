%% ¡header!
ImporterGroupSubjectCON_TXT < Importer (im, importer of CON subject group from TXT) imports a group of subjects with connectivity data from a series of TXT file.

%%% ¡description!
ImporterGroupSubjectCON_TXT imports a group of subjects with connectivity data from a series of TXT file and their covariates (optional) from another TXT file.
All these files must be in the same folder; also, no other files should be in the folder.
Each file contains a table of values corresponding to the adjacency matrix.
The TXT file containing the covariates must be inside another folder in the same group directory 
and consists of the following columns:
Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.

%%% ¡seealso!
Group, SunbjectCON, ExporterGroupSubjectCON_TXT

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the CON subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectCON_TXT'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the CON subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectCON_TXT imports a group of subjects with connectivity data from a series of TXT file and their covariates (optional) from another TXT file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the CON subject group importer from TXT.

%%% ¡prop!
ID (data, string) is a few-letter code for the CON subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectCON_TXT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the CON subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectCON_TXT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the CON subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectCON_TXT notes'

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the CON subject group files from which to load the subject group.
%%%% ¡default!
fileparts(which('test_braph2'))

%%% ¡prop!
GET_DIR (query, item) opens a dialog box to set the directory from where to load the TXT files of the CON subject group.
%%%% ¡settings!
'ImporterGroupSubjectCON_TXT'
%%%% ¡calculate!
directory = uigetdir('Select directory');
if ischar(directory) && isfolder(directory)
	im.set('DIRECTORY', directory);
end
value = im;

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
GR (result, item) is a group of subjects with connectivity data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectCON', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'))
%%%% ¡calculate!
% creates empty Group
gr = Group( ...
    'SUB_CLASS', 'SubjectCON', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON') ...
    );

gr.lock('SUB_CLASS');

directory = im.get('DIRECTORY');
if isfolder(directory)  
    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading directory ...');
    
    % sets group props
    [~, name] = fileparts(directory);
    gr.set( ...
        'ID', name, ...
        'LABEL', name, ...
        'NOTES', ['Group loaded from ' directory] ...
    );

    try
        % analyzes file
        files = dir(fullfile(directory, '*.txt'));

% % %         % Check if there are covariates to add (age and sex)
% % %         cov_folder = dir(directory);
% % %         cov_folder = cov_folder([cov_folder(:).isdir] == 1);
% % %         cov_folder = cov_folder(~ismember({cov_folder(:).name}, {'.', '..'}));
% % %         if ~isempty(cov_folder)
% % %             file_cov = dir(fullfile([directory filesep() cov_folder.name], '*.txt'));
% % %             raw_covariates = readtable([directory filesep() cov_folder.name filesep() file_cov.name], 'Delimiter', '	');
% % %             age = raw_covariates{:, 2};
% % %             sex = raw_covariates{:, 3};
% % %         else
% % %             age = ones(length(files), 1);
% % %             unassigned =  {'unassigned'};
% % %             sex = unassigned(ones(length(files), 1));
% % %         end

        braph2waitbar(wb, .15, 'Loading subjecy group ...')

        if ~isempty(files)
            % brain atlas
            ba = im.get('BA');
            raw = readtable(fullfile(directory, files(1).name), 'Delimiter', '	');
            br_number = size(raw, 1);  
            if ba.get('BR_DICT').get('LENGTH') ~= br_number
                ba = BrainAtlas();
                idict = ba.get('BR_DICT');
                for j = 1:1:br_number
                    br_id = ['br' int2str(j)];
                    br = BrainRegion('ID', br_id);
                    idict.get('ADD', br)
                end
                ba.set('BR_DICT', idict);
            end

            subdict = gr.get('SUB_DICT');

            % adds subjects
            for i = 1:1:length(files)
                braph2waitbar(wb, .25 + .75 * i / length(files), ['Loading subject ' num2str(i) ' of ' num2str(length(files)) ' ...'])

                % read file
                CON = table2array(readtable(fullfile(directory, files(i).name), 'Delimiter', '	'));
                [~, sub_id] = fileparts(files(i).name);
                sub = SubjectCON( ...
                    'ID', sub_id, ...
                    'BA', ba, ... % % %                     'age', age(i), ... % % %                     'sex', sex{i}, ...
                    'CON', CON ...
                );
                subdict.get('ADD', sub);
            end
            gr.set('SUB_DICT', subdict);
        end
    catch e
        braph2waitbar(wb, 'close')
        
        rethrow(e)
    end
    
	braph2waitbar(wb, 'close')
elseif ~braph2_testing()
    error([BRAPH2.STR ':ImporterGroupSubjectCON_TXT:' BRAPH2.CANCEL_IO], ...
        [BRAPH2.STR ':ImporterGroupSubjectCON_TXT:' BRAPH2.CANCEL_IO '\\n' ...
        'The prop DIRECTORY must be an existing directory, but it is ''' directory '''.'] ...
        );
end

value = gr;

%% ¡tests!

%%% ¡excluded_props!
[ImporterGroupSubjectCON_TXT.GET_DIR]

%%% ¡test!
%%%% ¡name!
Create example files
%%%% ¡code!
data_dir = [fileparts(which('SubjectCON')) filesep 'Example data CON TXT'];
mkdir(data_dir);

% Brain Atlas
im_ba = ImporterBrainAtlasTXT('FILE', 'desikan_atlas.txt');
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

% Group 1
K1 = 2; % degree (mean node degree is 2K) - group 1
beta1 = 0.3; % Rewiring probability - group 1
gr1_name = 'CON_Group_1_TXT';
gr1_dir = [data_dir filesep() gr1_name];
mkdir(gr1_dir);
vois1 = [
    {{'Subject ID'} {'Age'} {'Sex'}}
    {{} {} {['{' sprintf(' ''%s'' ', sex_options{:}) '}']}}
    ];
for i = 1:1:50 % subject number
    sub_id = ['SubjectCON_' num2str(i)];
    
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

    writetable(array2table(A1), [gr1_dir filesep() sub_id '.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)
    
    % variables of interest
    vois1 = [vois1; {sub_id, randi(90), sex_options(randi(2))}];
end
writetable(table(vois1), [data_dir filesep() gr1_name '_vois.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

% Group 2
K2 = 2; % degree (mean node degree is 2K) - group 2
beta2 = 0.85; % Rewiring probability - group 2
gr2_name = 'CON_Group_2_TXT';
gr2_dir = [data_dir filesep() gr2_name];
mkdir(gr2_dir);
vois2 = [
    {{'Subject ID'} {'Age'} {'Sex'}}
    {{} {} {['{' sprintf(' ''%s'' ', sex_options{:}) '}']}}
    ];
for i = 51:1:100
    sub_id = ['SubjectCON_' num2str(i)];

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

    writetable(array2table(A2), [gr2_dir filesep() 'SubjectCON_' num2str(i) '.txt'], 'WriteVariableNames', false)
    
    % variables of interest
    vois2 = [vois2; {sub_id, randi(90), sex_options(randi(2))}];
end
writetable(table(vois2), [data_dir filesep() gr2_name '_vois.txt'], 'WriteVariableNames', false)

% reset RNG
rng(rng_settings_)

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
GUI
%%%% ¡probability!
.01
%%%% ¡parallel!
false
%%%% ¡code!
im_ba = ImporterBrainAtlasTXT('FILE', [fileparts(which('SubjectCON')) filesep 'Example data CON TXT' filesep 'atlas.txt']);
ba = im_ba.get('BA');

im_gr = ImporterGroupSubjectCON_TXT( ...
    'DIRECTORY', [fileparts(which('SubjectCON')) filesep 'Example data CON TXT' filesep 'CON_Group_1_TXT'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr = im_gr.get('GR');

gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')