%% ¡header!
ImporterGroupSubjectST_MP_XLS < Importer (im, importer of ST MP subject group from XLS/XLSX) imports a group of subjects with structural multiplex data from a series of XLS/XLSX files.

%%% ¡description!
ImporterGroupSubjectST_MP_XLS imports a group of subjects with structural 
 multiplex data from a series of XLS/XLSX files contained in a folder named 
 "GROUP_ID". All these files must be in the same folder; also, no other 
 files should be in the folder. Each file corresponds to a layer of the 
 multiplex and should be labeled with the layer number indicated as, e.g., 
 "GROUP_ID.1.xlsx" and "GROUP_ID.2.xlsx". 
 Each file contains the following columns: Subject ID (column 1), Subject 
 LABEL (column 2), Subject NOTES (column 3) and BrainRegions 
 (columns 4-end; one brain region value per column). The first row contains 
 the headers and each subsequent row the values for each subject.
The variables of interest are from another XLS/XLSX file named "GROUP_ID.vois.xlsx" 
 (if exisitng) consisting of the following columns: 
 Subject ID (column 1), covariates (subsequent columns). 
 The 1st row contains the headers, the 2nd row a string with the categorical
 variables of interest, and each subsequent row the values for each subject.

%%% ¡seealso!
Group, SubjectST_MP, ExporterGroupSubjectST_MP_XLS

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the ST MP subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectST_MP_XLS'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ST MP subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectST_MP_XLS imports a group of subjects with structural multiplex data and their covariates (optional) from a series of XLS/XLSX file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ST MP subject group importer from XLS/XLSX.
%%%% ¡settings!
'ImporterGroupSubjectST_MP_XLS'

%%% ¡prop!
ID (data, string) is a few-letter code for the ST MP subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectST_MP_XLS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ST MP subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectST_MP_XLS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ST MP subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectST_MP_XLS notes'

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the ST MP subject group files from which to load the L layers of the subject group.
%%%% ¡default!
fileparts(which('test_braph2'))

%%% ¡prop!
GET_DIR (query, item) opens a dialog box to set the directory from where to load the XLS/XLSX files of the ST MP subject group with L layers.
%%%% ¡settings!
'ImporterGroupSubjectST_MP_XLS'
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
GR (result, item) is a group of subjects with structural multiplex data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectST_MP', [], [], true))); 
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST_MP'))
%%%% ¡calculate!
% creates empty Group
gr = Group( ...
    'SUB_CLASS', 'SubjectST_MP', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST_MP') ...
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
        braph2waitbar(wb, .15, 'Loading subject group ...');
        
        files = [dir(fullfile(directory, '*.xlsx')); dir(fullfile(directory, '*.xls'))];

        if ~isempty(files)
            % brain atlas
            braph2waitbar(wb, .25, 'Loading brain atlas ...')
            ba = im.get('BA');
            [~, ~, raw] = xlsread(fullfile(directory, files(1).name));
            br_number = size(raw, 2) - 3;
            if ba.get('BR_DICT').get('LENGTH') == 0
                % adds the number of regions of the first file to the brain atlas
                ba = BrainAtlas();
                br_dict = ba.memorize('BR_DICT');
                for j = 4:1:length(raw)
                    br_id = raw{1, j};
                    br = BrainRegion('ID', br_id);
                    br_dict.get('ADD', br)
                end
            end
            if br_number ~= ba.get('BR_DICT').get('LENGTH')
                error( ...
                    [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO], ...
                    [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO '\\n' ...
                    'The file ' files(1).name ' should contain a matrix with ' int2str(ba.get('BR_DICT').get('LENGTH')) ' columns corresponding to the brain regions, ' ...
                    'while it contains ' int2str(br_number) ' columns.'] ...
                    )
            end
            
            % determines the number of layers
            L = 0;
            for i = 1:1:length(files)
                [~, gr_id_layer_no] = fileparts(files(i).name);
                splits = regexp(gr_id_layer_no, '(.+)\\.(\\d+)', 'tokens');
                gr_id = splits{1}{1};
                L = max(L, str2double(splits{1}{2}));
            end

            % adds subjects
            sub_dict = gr.memorize('SUB_DICT');
            for i = 2:1:size(raw, 1)
                braph2waitbar(wb, .25 + .75 * (i - 1) / size(raw, 1), ['Loading subject ' num2str(i - 1) ' of ' num2str(size(raw, 1) - 1) ' ...'])
                
                % read files
                ST_MP = {};
                for l = 1:1:L
                    filename = fullfile(directory, [gr_id '.' int2str(l) '.xls']);
                    if isfile(filename)
                        [~, ~, raw] = xlsread(filename);
                    else
                        [~, ~, raw] = xlsread([filename 'x']);
                    end
                    ST = zeros(br_number, 1);
                    for j = 1:1:length(ST)
                        ST(j) = raw{i, 3 + j};
                    end
                    ST_MP = [ST_MP, ST];
                end
                
                sub = SubjectST_MP( ...
                    'ID', num2str(raw{i, 1}), ...
                    'LABEL', num2str(raw{i, 2}), ...
                    'NOTES', num2str(raw{i, 3}), ...
                    'BA', ba, ...
                    'L', L, ...
                    'ST_MP', ST_MP ...
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
    error([BRAPH2.STR ':ImporterGroupSubjectST_MP_XLS:' BRAPH2.ERR_IO], ...
        [BRAPH2.STR ':ImporterGroupSubjectST_MP_XLS:' BRAPH2.ERR_IO '\\n' ...
        'The prop DIRECTORY must be an existing directory, but it is ''' directory '''.'] ...
        );
end

value = gr;

%% ¡tests!

%%% ¡excluded_props!
[ImporterGroupSubjectST_MP_XLS.GET_DIR]

%%% ¡test!
%%%% ¡name!
Create example files
%%%% ¡code!
data_dir = [fileparts(which('SubjectST_MP')) filesep 'Example data ST_MP XLS'];
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

    sex_options = {'Female' 'Male'};

    % Group 1
    K11 = 4; % degree (mean node degree is 2K) - group 1 layer 1
    K12 = 5; % degree (mean node degree is 2K) - group 1 layer 2
    beta1 = 0.08; % Rewiring probability - group 1

    % Create the graphs
    h11 = WattsStrogatz(N, K11, beta1);
    h12 = WattsStrogatz(N, K12, beta1);
    % figure(1)
    % plot(h11, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
    % title(['Group 1: Graph with $N = $ ' num2str(N_nodes) ...
    %     ' nodes, $K = $ ' num2str(K11) ', and $\beta = $ ' num2str(beta1)], ...
    %     'Interpreter','latex')
    % axis equal
    % 
    % figure(2)
    % plot(h12, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
    % title(['Group 1: Graph with $N = $ ' num2str(N_nodes) ...
    %     ' nodes, $K = $ ' num2str(K12) ', and $\beta = $ ' num2str(beta1)], ...
    %     'Interpreter','latex')
    % axis equal

    % Extract the adjacency matrices
    A11 = full(adjacency(h11));
    A12 = full(adjacency(h12));
    A11(1:length(A11)+1:numel(A11)) = 1;
    A12(1:length(A12)+1:numel(A12)) = 1;

    % this is needed to make the matrices positive definite
    A11 = A11*transpose(A11);
    A12 = A12*transpose(A12);
    % figure(1)
    % imshow(A11)
    % figure(2)
    % imshow(A12)

    % These matrices will be covariance matrices
    % Specify the mean
    mu_gr11 = ones(1, length(A11));
    mu_gr12 = ones(1, length(A12));

    % Create time series
    R11 = mvnrnd(mu_gr11, A11, N_subjects);
    R12 = mvnrnd(mu_gr12, A12, N_subjects);

    % % Normalize the time series
    % mean_R11 = mean(R11);
    % std_R11 = std(R11);
    % R11 = (R11 - mean(R11)) ./ std(R11);
    % 
    % mean_R12 = mean(R12);
    % std_R12 = std(R12);
    % R12 = (R12 - mean(R12)) ./ std(R12);

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
    gr1_dir = [data_dir filesep() 'ST_MP_Group_1_XLS'];
    mkdir(gr1_dir)
    writetable(T_group11, [gr1_dir filesep() 'ST_MP_Group_1_XLS.1.xlsx'], 'WriteRowNames', true)
    writetable(T_group12, [gr1_dir filesep() 'ST_MP_Group_1_XLS.2.xlsx'], 'WriteRowNames', true)

    % variables of interest
    vois1 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    for i = 1:1:N_subjects
        vois1 = [vois1; {sub_Tags1{i}, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois1), [data_dir filesep() 'ST_MP_Group_1_XLS.vois.xlsx'], 'WriteVariableNames', false)

    % Group 2
    K21 = K11; % degree (mean node degree is 2K) - group 2 layer 1
    K22 = 2; % degree (mean node degree is 2K) - group 2 layer 2
    beta2 = 0.9; % Rewiring probability - group 2

    % Create the graphs
    h21 = WattsStrogatz(N, K21, beta2);
    h22 = WattsStrogatz(N, K22, beta2);
    % figure(3)
    % plot(h21, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
    % title(['Group 2: Graph with $N = $ ' num2str(N_nodes) ...
    %     ' nodes, $K = $ ' num2str(K21) ', and $\beta = $ ' num2str(beta2)], ...
    %     'Interpreter','latex')
    % axis equal
    % 
    % figure(4)
    % plot(h22, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
    % title(['Group 2: Graph with $N = $ ' num2str(N_nodes) ...
    %     ' nodes, $K = $ ' num2str(K22) ', and $\beta = $ ' num2str(beta2)], ...
    %     'Interpreter','latex')
    % axis equal

    % Extract the adjacency matrices 
    A21 = full(adjacency(h21));
    A22 = full(adjacency(h22));
    A21(1:length(A21)+1:numel(A21)) = 1;
    A22(1:length(A22)+1:numel(A22)) = 1;

    % this is needed to make the matrices positive definite
    A21 = A21*transpose(A21);
    A22 = A22*transpose(A22);
    % figure(3)
    % imshow(A21)
    % figure(4)
    % imshow(A22)

    % These matrices will be covariance matrices
    % Specify the mean
    mu_gr21 = ones(1, length(A21));
    mu_gr22 = ones(1, length(A22));

    % Create time series
    R21 = mvnrnd(mu_gr21, A21, N_subjects);
    R22 = mvnrnd(mu_gr22, A22, N_subjects);

    % % Normalize the time series
    % mean_R21 = mean(R21);
    % std_R21 = std(R21);
    % R21 = (R21 - mean(R21)) ./ std(R21);
    % 
    % mean_R22 = mean(R22);
    % std_R22 = std(R22);
    % R22 = (R22 - mean(R22)) ./ std(R22);

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
    gr2_dir = [data_dir filesep() 'ST_MP_Group_2_XLS'];
    mkdir(gr2_dir)
    writetable(T_group21, [gr2_dir filesep() 'ST_MP_Group_2_XLS.1.xlsx'], 'WriteRowNames', true)
    writetable(T_group22, [gr2_dir filesep() 'ST_MP_Group_2_XLS.2.xlsx'], 'WriteRowNames', true)

    % variables of interest
    vois2 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} cell2str(sex_options)}
        ];
    for i = 1:1:N_subjects
        vois2 = [vois2; {sub_Tags2{i}, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois2), [data_dir filesep() 'ST_MP_Group_2_XLS.vois.xlsx'], 'WriteVariableNames', false)

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
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('SubjectST_MP')) filesep 'Example data ST_MP XLS' filesep 'atlas.xlsx']);
ba = im_ba.get('BA');

im_gr = ImporterGroupSubjectST_MP_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectST_MP')) filesep 'Example data ST_MP XLS' filesep 'ST_MP_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr = im_gr.get('GR');

gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')