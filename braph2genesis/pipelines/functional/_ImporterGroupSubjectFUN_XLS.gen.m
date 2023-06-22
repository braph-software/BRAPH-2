%% ¡header!
ImporterGroupSubjectFUN_XLS < Importer (im, importer of FUN subject group from XLS/XLSX) imports a group of subjects with functional data from a series of XLS/XLSX file.

%%% ¡description!
ImporterGroupSubjectFUN_XLS imports a group of subjects with functional 
 data from a series of XLS/XLSX files contained in a folder named "GROUP_ID". 
 All these files must be in the same folder; also, no other files should be 
 in the folder. Each file contains a table with each row correspoding to a 
 time serie and each column to a brain region.
The variables of interest are from another XLS/XLSX file named "GROUP_ID.vois.xlsx" 
 (if exisitng) consisting of the following columns: 
 Subject ID (column 1), covariates (subsequent columns). 
 The 1st row contains the headers, the 2nd row a string with the categorical
 variables of interest, and each subsequent row the values for each subject.

%%% ¡seealso!
Group, SubjectFUN, ExporterGroupSubjectFUN_XLS

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the FUN subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectFUN_XLS'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the FUN subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectFUN_XLS imports a group of subjects with functional data from a series of XLS/XLSX file and their covariates (optional) from another XLS/XLSX file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the FUN subject group importer from XLS/XLSX.
%%% ¡settings!
'ImporterGroupSubjectFUN_XLS'

%%% ¡prop!
ID (data, string) is a few-letter code for the FUN subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectFUN_XLS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the FUN subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectFUN_XLS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the FUN subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectFUN_XLS notes'

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the FUN subject group files from which to load the subject group.
%%%% ¡default!
fileparts(which('test_braph2'))

%%% ¡prop!
GET_DIR (query, item) opens a dialog box to set the directory from where to load the XLS/XLSX files of the FUN subject group.
%%%% ¡settings!
'ImporterGroupSubjectFUN_XLS'
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
GR (result, item) is a group of subjects with functional data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectFUN', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN'))
%%%% ¡calculate!
% creates empty Group
gr = Group( ...
    'SUB_CLASS', 'SubjectFUN', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN') ...
    );

gr.lock('SUB_CLASS');

directory = im.get('DIRECTORY');
if isfolder(directory)    
    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading directory ...');

    [~, name] = fileparts(directory);
    gr.set( ...
        'ID', name, ...
        'LABEL', name, ...
        'NOTES', ['Group loaded from ' directory] ...
        );

    try
        braph2waitbar(wb, .15, 'Loading subject group ...')

        % analyzes file
        files = [dir(fullfile(directory, '*.xlsx')); dir(fullfile(directory, '*.xls'))];

        if ~isempty(files)
            % brain atlas
            ba = im.get('BA');
            if ba.get('BR_DICT').get('LENGTH') == 0
                % adds the number of regions of the first file to the brain atlas
                br_number = size(xlsread(fullfile(directory, files(1).name)), 2);
                br_dict = ba.memorize('BR_DICT');
                for j = 1:1:br_number
                    br_dict.get('ADD', BrainRegion('ID', ['br' int2str(j)]))
                end
            end

            % adds subjects
            sub_dict = gr.memorize('SUB_DICT');
            for i = 1:1:length(files)
                braph2waitbar(wb, .15 + .85 * i / length(files), ['Loading subject ' num2str(i) ' of ' num2str(length(files)) ' ...'])

                % read file
                [~, sub_id] = fileparts(files(i).name);

                FUN = xlsread(fullfile(directory, files(i).name));
                if size(FUN, 2) ~= ba.get('BR_DICT').get('LENGTH')
                    error( ...
                        [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO], ...
                        [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO '\\n' ...
                        'The file ' sub_id ' should contain a matrix with ' int2str(ba.get('BR_DICT').get('LENGTH')) ' columns corresponding to the brain regions, ' ...
                        'while it contains ' int2str(size(FUN, 2)) ' columns.'] ...
                        )
                end

                sub = SubjectFUN( ...
                    'ID', sub_id, ...
                    'BA', ba, ...
                    'FUN', FUN ...
                    );
                sub_dict.get('ADD', sub);
            end
            
            % variables of interest
            vois = [];
            if isfile([directory '.vois.xls'])
                [~, ~, vois] = xlsread([directory '.vois.xls']);
            elseif isfile([directory '.vois.xlsx'])
                [~, ~, vois] = xlsread([directory '.vois.xlsx']);
            end
            if ~isempty(vois)
                for i = 3:1:size(vois, 1)
                    sub_id = vois{i, 1};
                    sub = sub_dict.get('IT', sub_id);
                    for v = 2:1:size(vois, 2)
                        voi_id = vois{1, v};
                        if isnumeric(vois{2, v}) % VOINumeric
                            sub.memorize('VOI_DICT').get('ADD', ...
                                VOINumeric( ...
                                    'ID', voi_id, ...
                                    'V', vois{i, v} ...
                                    ) ...
                                );
                        elseif ischar(vois{2, v}) % VOICategoric
                            sub.memorize('VOI_DICT').get('ADD', ...
                                VOICategoric( ...
                                    'ID', voi_id, ...
                                    'CATEGORIES', str2cell(vois{2, v}), ...
                                    'V', find(strcmp(vois{i, v}, str2cell(vois{2, v}))) ...
                                    ) ...
                                );
                        end                        
                    end
                end
            end
        end
    catch e
        braph2waitbar(wb, 'close')
        
        rethrow(e)
    end
    
    braph2waitbar(wb, 'close')
else
    error([BRAPH2.STR ':ImporterGroupSubjectFUN_XLS:' BRAPH2.ERR_IO], ...
        [BRAPH2.STR ':ImporterGroupSubjectFUN_XLS:' BRAPH2.ERR_IO '\\n' ...
        'The prop DIRECTORY must be an existing directory, but it is ''' directory '''.'] ...
        );
end

value = gr;

%% ¡tests!

%%% ¡excluded_props!
[ImporterGroupSubjectFUN_XLS.GET_DIR]

%%% ¡test!
%%%% ¡name!
Create example files
%%%% ¡code!
data_dir = [fileparts(which('SubjectFUN')) filesep 'Example data FUN XLS'];
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

    T = 200; % Length of the time series

    sex_options = {'Female' 'Male'};

    % Group 1 - 5 modules of 18 nodes each
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
    gr1_name = 'FUN_Group_1_XLS';
    gr1_dir = [data_dir filesep() gr1_name];
    mkdir(gr1_dir);
    vois1 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    for i = 1:1:50 % subject number
        sub_id = ['SubjectFUN_' num2str(i)];

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

        writetable(array2table(R1), [gr1_dir filesep() sub_id '.xlsx'], 'WriteVariableNames', false)

        % variables of interest
        vois1 = [vois1; {sub_id, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois1), [data_dir filesep() gr1_name '.vois.xlsx'], 'WriteVariableNames', false)

    % Group 2 - 2 modules of 45 nodes each
    % initialize values for the WS model
    K2 = [3 7];
    beta2 = [0.02 0.85];
    % initialize the indices where the matrices will be placed
    indices1 = 1:1:45;
    indices2 = 46:1:90;
    indices = {indices1; indices2};
    gr2_name = 'FUN_Group_2_XLS';
    gr2_dir = [data_dir filesep() gr2_name];
    mkdir(gr2_dir);
    vois2 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    for i = 51:1:100
        sub_id = ['SubjectFUN_' num2str(i)];

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

        writetable(array2table(R2), [gr2_dir filesep() 'SubjectFUN_' num2str(i) '.xlsx'], 'WriteVariableNames', false)

        % variables of interest
        vois2 = [vois2; {sub_id, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois2), [data_dir filesep() gr2_name '.vois.xlsx'], 'WriteVariableNames', false)

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
GUI
%%%% ¡probability!
.01
%%%% ¡parallel!
false
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('SubjectFUN')) filesep 'Example data FUN XLS' filesep 'atlas.xlsx']);
ba = im_ba.get('BA');

im_gr = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectFUN')) filesep 'Example data FUN XLS' filesep 'FUN_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr = im_gr.get('GR');

gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')