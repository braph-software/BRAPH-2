%% ¡header!
ImporterGroupSubjectCON_TXT < Importer (im, importer of CON subject group from TXT) imports a group of subjects with connectivity data from a series of TXT files.

%%% ¡description!
ImporterGroupSubjectCON_TXT imports a group of subjects with connectivity 
 data from a series of tab-separated TXT files contained in a folder named 
 "GROUP_ID". All these files must be in the same folder; also, no other 
 files should be in the folder. Each file contains a table of values 
 corresponding to the adjacency matrix.
The variables of interest are from another tab-separated TXT file named 
 "GROUP_ID.vois.txt" (if exisitng) consisting of the following columns: 
 Subject ID (column 1), covariates (subsequent columns). 
 The 1st row contains the headers, the 2nd row a string with the categorical
 variables of interest, and each subsequent row the values for each subject.

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
%%%% ¡settings!
'ImporterGroupSubjectCON_TXT'

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
    
    [~, name] = fileparts(directory);
    gr.set( ...
        'ID', name, ...
        'LABEL', name, ...
        'NOTES', ['Group loaded from ' directory] ...
        );

    try
        braph2waitbar(wb, .15, 'Loading subjecy group ...')

        % analyzes file
        files = dir(fullfile(directory, '*.txt'));

        if ~isempty(files)
            % brain atlas
            ba = im.get('BA');
            if ba.get('BR_DICT').get('LENGTH') == 0
                % adds the number of regions of the first file to the brain atlas
                br_number = size(readtable(fullfile(directory, files(1).name), 'Delimiter', '\t'), 1);
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

                CON = table2array(readtable(fullfile(directory, files(i).name), 'Delimiter', '\t'));
                if size(CON, 1) ~= ba.get('BR_DICT').get('LENGTH') || size(CON, 2) ~= ba.get('BR_DICT').get('LENGTH')
                    error( ...
                        [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO], ...
                        [BRAPH2.STR ':' class(im) ':' BRAPH2.ERR_IO '\\n' ...
                        'The file ' sub_id ' should contain a matrix ' int2str(ba.get('BR_DICT').get('LENGTH')) 'x' int2str(ba.get('BR_DICT').get('LENGTH')) ', ' ...
                        'while it is ' int2str(size(CON, 1)) 'x' int2str(size(CON, 2)) '.'] ...
                        )
                end
                
                sub = SubjectCON( ...
                    'ID', sub_id, ...
                    'BA', ba, ...
                    'CON', CON ...
                );
                sub_dict.get('ADD', sub);
            end
            
            % variables of interest
            if isfile([directory '.vois.txt'])
                vois = textread([directory '.vois.txt'], '%s', 'delimiter', '\t', 'whitespace', '');
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
        end
    catch e
        braph2waitbar(wb, 'close')
        
        rethrow(e)
    end
    
	braph2waitbar(wb, 'close')
else
    error([BRAPH2.STR ':ImporterGroupSubjectCON_TXT:' BRAPH2.ERR_IO], ...
        [BRAPH2.STR ':ImporterGroupSubjectCON_TXT:' BRAPH2.ERR_IO '\\n' ...
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
if ~isdir(data_dir)
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
        sub_id = ['SubjectCON_MP_' num2str(i)];

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
    writetable(table(vois1), [data_dir filesep() gr1_name '.vois.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

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
        sub_id = ['SubjectCON_MP_' num2str(i)];

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

        writetable(array2table(A2), [gr2_dir filesep() 'SubjectCON_' num2str(i) '.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

        % variables of interest
        vois2 = [vois2; {sub_id, randi(90), sex_options(randi(2))}];
    end
    writetable(table(vois2), [data_dir filesep() gr2_name '.vois.txt'], 'Delimiter', '\t', 'WriteVariableNames', false)

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