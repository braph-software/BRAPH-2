%% ¡header!
ImporterGroupSubjectST_TXT < Importer (im, importer of ST subject group from TXT) imports a group of subjects with structural data from an TXT file.

%%% ¡description!
ImporterGroupSubjectST_XLS imports a group of subjects with structural data 
 from a TXT file named "GROUP_ID.txt". This file contains the 
 following columns: Subject ID (column 1), Subject LABEL (column 2), 
 Subject NOTES (column 3) and BrainRegions (columns 4-end; one brainregion 
 value per column). The first row contains the headers and each subsequent 
 row the values for each subject.
The variables of interest are from another TXT file named "GROUP_ID.vois.txt" 
 (if existing) consisting of the following columns: 
 Subject ID (column 1), covariates (subsequent columns). 
 The 1st row contains the headers, the 2nd row a string with the categorical
 variables of interest, and each subsequent row the values for each subject.

%%% ¡seealso!
Group, SubjectST, ExporterGroupSubjectST_TXT

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the ST subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectST_TXT'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ST subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectST_TXT imports a group of subjects with structural data from an TXT file and their covariates from another TXT file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ST subject group importer from TXT.
%%%% ¡settings!
'ImporterGroupSubjectST_TXT'

%%% ¡prop!
ID (data, string) is a few-letter code for the ST subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectST_TXT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ST subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectST_TXT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ST subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectST_TXT notes'

%% ¡props!

%%% ¡prop!
FILE (data, string) is the TXT file from where to load the ST subject group.
%%%% ¡default!
''

%%% ¡prop!
GET_FILE (query, item) opens a dialog box to set the TXT file from where to load the ST subject group.
%%%% ¡settings!
'ImporterGroupSubjectST_TXT'
%%%% ¡calculate!
[filename, filepath, filterindex] = uigetfile('*.txt', 'Select TXT file');
if filterindex
    file = [filepath filename];
	im.set('FILE', file);
end
value = im;

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
GR (result, item) is a group of subjects with structural data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectST', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'))
%%%% ¡calculate!
% creates empty Group
gr = Group( ...
    'SUB_CLASS', 'SubjectST', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST') ...
    );

gr.lock('SUB_CLASS');

% analyzes file
file = im.get('FILE');
if isfile(file)
    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading File ...');
    
    [~, name, ext] = fileparts(file);
    gr.set( ...
        'ID', name, ...
        'LABEL', [name ext], ...
        'NOTES', ['Group loaded from ' file] ...
        );
    
    try
        braph2waitbar(wb, .15, 'Loading subject group ...')

        raw = readtable(file, 'Delimiter', '\t');
        
        % brain atlas
        braph2waitbar(wb, .25, 'Loading brain atlas ...')
        ba = im.get('BA');
        br_number = size(raw, 2) - 3;
        if ba.get('BR_DICT').get('LENGTH') == 0
            ba = BrainAtlas();
            br_dict = ba.memorize('BR_DICT');
            for j = 4:1:size(raw, 2)
                br_id = raw.Properties.VariableNames{j};
                br = BrainRegion('ID', br_id);
                br_dict.get('ADD', br)
            end
        end
        if br_number ~= ba.get('BR_DICT').get('LENGTH')
            error( ...
                [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO], ...
                [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO '\\n' ...
                'The file ' name '.' ext ' should contain a matrix with ' int2str(ba.get('BR_DICT').get('LENGTH')) ' columns corresponding to the brain regions, ' ...
                'while it contains ' int2str(br_number) ' columns.'] ...
                )
        end
                
        % adds subjects
        sub_dict = gr.memorize('SUB_DICT');
        for i = 1:1:size(raw, 1)
            braph2waitbar(wb, .25 + .75 * i / size(raw, 1), ['Loading subject ' num2str(i) ' of ' num2str(size(raw, 1)) ' ...'])
            
            ST = zeros(br_number, 1);
            for j = 1:1:length(ST)
                ST(j) = raw{i, 3 + j};
            end
            sub = SubjectST( ...
                'ID', char(raw{i, 1}), ...
                'LABEL', char(raw{i, 2}), ...
                'NOTES', char(raw{i, 3}), ...
                'BA', ba, ...
                'ST', ST ...
                );
            sub_dict.get('ADD', sub);
        end
        
        % variables of interest
        if isfile([fileparts(file) filesep() name  '.vois.txt'])
            vois = textread([fileparts(file) filesep() name  '.vois.txt'], '%s', 'delimiter', '\t', 'whitespace', '');
            vois = reshape(vois, find(strcmp('', vois), 1) - 1, [])';
            for i = 3:1:size(vois, 1)
                sub_id = vois{i, 1};
                sub = sub_dict.get('IT', sub_id);
                for v = 2:1:size(vois, 2)
                    voi_id = vois{1, v};
                    if isempty(vois{2, v}) % VOINumeric
                        sub.memorize('VOI_DICT').get('ADD', ...
                            VOINumeric( ...
                                'ID', voi_id, ...
                                'V', str2num(vois{i, v}) ...
                                ) ...
                            );
                    elseif ~isempty(vois{2, v}) % VOICategoric
                        categories = eval(vois{2, v});
                        sub.memorize('VOI_DICT').get('ADD', ...
                            VOICategoric( ...
                                'ID', voi_id, ...
                                'CATEGORIES', str2cell(categories), ...
                                'V', find(strcmp(vois{i, v}, categories)) ...
                                ) ...
                            );
                    end                        
                end
            end
        end
    catch e
        braph2waitbar(wb, 'close')
        
        rethrow(e)
    end
    
    braph2waitbar(wb, 'close')
elseif ~isempty(file)
    error([BRAPH2.STR ':ImporterGroupSubjectST_TXT:' BRAPH2.CANCEL_IO], ...
        [BRAPH2.STR ':ImporterGroupSubjectST_TXT:' BRAPH2.CANCEL_IO '\\n' ...
        'The prop FILE must be an existing file, but it is ''' file '''.'] ...
        );
end

value = gr;

%% ¡tests!

%%% ¡excluded_props!
[ImporterGroupSubjectST_TXT.GET_FILE]

%%% ¡test!
%%%% ¡name!
Create example files
%%%% ¡code!
data_dir = [fileparts(which('SubjectST')) filesep 'Example data ST TXT'];
if ~isdir(data_dir)
    mkdir(data_dir);

    % Brain Atlas
    im_ba = ImporterBrainAtlasTXT('FILE', 'destrieux_atlas.txt');
    ba = im_ba.get('BA');
    ex_ba = ExporterBrainAtlasTXT( ...
        'BA', ba, ...
        'FILE', [data_dir filesep() 'atlas.txt'] ...
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
    writetable(array2table([cellstr(sub_Tags1) cellstr(label_Tags1) cellstr(note_Tags1) num2cell(R1)], 'VariableNames', reg_Tags), [data_dir filesep() 'ST_Group_1.txt'], 'Delimiter', '\t', 'WriteRowNames', true)

    % variables of interest
    vois1 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} {['{' sprintf(' ''%s'' ', sex_options{:}) '}']}}
        ];
    for i = 1:1:N_subjects
        vois1 = [vois1; {sub_Tags1{i}, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois1), [data_dir filesep() 'ST_Group_1.vois.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

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

    writetable(array2table([cellstr(sub_Tags2) cellstr(label_Tags2) cellstr(note_Tags2) num2cell(R2)], 'VariableNames', reg_Tags), [data_dir filesep() 'ST_Group_2.txt'], 'Delimiter', '\t', 'WriteRowNames', true)

    % variables of interest
    vois2 = [
        {{'Subject ID'} {'Age'} {'Sex'}}
        {{} {} {['{' sprintf(' ''%s'' ', sex_options{:}) '}']}}
        ];
    for i = 1:1:N_subjects
        vois2 = [vois2; {sub_Tags2{i}, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois2), [data_dir filesep() 'ST_Group_2.vois.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

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
im_ba = ImporterBrainAtlasTXT('FILE', [fileparts(which('SubjectST')) filesep 'Example data ST TXT' filesep 'atlas.txt']);
ba = im_ba.get('BA');

im_gr = ImporterGroupSubjectST_TXT( ...
    'FILE', [fileparts(which('SubjectST')) filesep 'Example data ST TXT' filesep 'ST_Group_1.txt'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr = im_gr.get('GR');

gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')