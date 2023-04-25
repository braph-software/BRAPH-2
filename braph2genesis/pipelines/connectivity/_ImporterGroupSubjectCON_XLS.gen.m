%% ¡header!
ImporterGroupSubjectCON_XLS < Importer (im, importer of CON subject group from XLS/XLSX) imports a group of subjects with connectivity data from a series of XLS/XLSX file.

%%% ¡description!
ImporterGroupSubjectCON_XLS imports a group of subjects with connectivity 
 data from a series of XLS/XLSX file. All these files must be in the same 
 folder; also, no other files should be in the folder. Each file contains a 
 table of values corresponding to the adjacency matrix.
The variables of interest can be loaded from another XLS/XLSX consisting of 
 the following columns: Subject ID (column 1), covariates (subsequent columns). 
 The 1st row contains the headers, the 2nd row a string with the categorical
 variables of interewsy, and each subsequent row the values for each subject.

%%% ¡seealso!
Group, SubjectCON, ExporterGroupSubjectCON_XLS

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the CON subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectCON_XLS'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the CON subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectCON_XLS imports a group of subjects with connectivity data from a series of XLS/XLSX file and their covariates (optional) from another XLS/XLSX file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the CON subject group importer from XLS/XLSX.

%%% ¡prop!
ID (data, string) is a few-letter code for the CON subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectCON_XLS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the CON subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectCON_XLS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the CON subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectCON_XLS notes'

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the CON subject group files from which to load the subject group.
%%%% ¡default!
fileparts(which('test_braph2'))

%%% ¡prop!
GET_DIR (query, item) opens a dialog box to set the directory from where to load the XLS/XLSX files of the CON subject group.
%%%% ¡settings!
'ImporterGroupSubjectCON_XLS'
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
    % sets group props
    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading directory ...');
    
    [~, name] = fileparts(directory);
    gr.set( ...
        'ID', name, ...
        'LABEL', name, ...
        'NOTES', ['Group loaded from ' directory] ...
    );

    try
        % analyzes file
        files_XLSX = dir(fullfile(directory, '*.xlsx'));
        files_XLS = dir(fullfile(directory, '*.xls'));
        files = [files_XLSX; files_XLS];

% % %         % Check if there are covariates to add (age and sex)
% % %         cov_folder = dir(directory);
% % %         cov_folder = cov_folder([cov_folder(:).isdir] == 1);
% % %         cov_folder = cov_folder(~ismember({cov_folder(:).name}, {'.', '..'}));
% % %         if ~isempty(cov_folder)
% % %             file_cov_XLSX = dir(fullfile([directory filesep() cov_folder.name], '*.xlsx'));
% % %             file_cov_XLS = dir(fullfile([directory filesep() cov_folder.name], '*.xls'));
% % %             file_cov = [file_cov_XLSX; file_cov_XLS];
% % %             [~, ~, raw_covariates] = xlsread(fullfile([directory filesep() cov_folder.name], file_cov.name));
% % %             age = raw_covariates(2:end, 2);
% % %             sex = raw_covariates(2:end, 3);
% % %         else
% % %             age = {[0]};
% % %             age = age(ones(length(files), 1));
% % %             unassigned =  {'unassigned'};
% % %             sex = unassigned(ones(length(files), 1));
% % %         end

        braph2waitbar(wb, .15, 'Loading subject group ...')

        if ~isempty(files)
            % brain atlas
            ba = im.get('BA');
            br_number = size(xlsread(fullfile(directory, files(1).name)), 1);
            if ba.get('BR_DICT').get('LENGTH') ~= br_number
                ba = BrainAtlas();
                br_dict = ba.get('BR_DICT');
                for j = 1:1:br_number
                    br_id = ['br' int2str(j)];
                    br = BrainRegion('ID', br_id);
                    br_dict.get('ADD', br)
                end
                ba.set('BR_DICT', br_dict);
            end

            sub_dict = gr.get('SUB_DICT');

            % adds subjects
            for i = 1:1:length(files)
                braph2waitbar(wb, .325 + .75 * i / length(files), ['Loading subject ' num2str(i) ' of ' num2str(length(files)) ' ...'])

                % read file
                CON = xlsread(fullfile(directory, files(i).name));
                [~, sub_id] = fileparts(files(i).name);
                sub = SubjectCON( ...
                    'ID', sub_id, ...
                    'BA', ba, ... % % % 'age', age{i}, ... % % % 'sex', sex{i}, ...
                    'CON', CON ...
                );
                sub_dict.get('ADD', sub);
            end
            gr.set('SUB_DICT', sub_dict);
        end
    catch e
        braph2waitbar(wb, 'close')
        
        rethrow(e)
    end
    
    braph2waitbar(wb, 'close')
else
    error([BRAPH2.STR ':ImporterGroupSubjectCON_XLS:' BRAPH2.CANCEL_IO], ...
        [BRAPH2.STR ':ImporterGroupSubjectCON_XLS:' BRAPH2.CANCEL_IO '\\n' ...
        'The prop DIRECTORY must be an existing directory, but it is ''' directory '''.'] ...
        );
end

value = gr;

%% ¡tests!

%%% ¡excluded_props!
[ImporterGroupSubjectCON_XLS.GET_DIR]

%%% ¡test!
%%%% ¡name!
Create example files
%%%% ¡code!
data_dir = [fileparts(which('SubjectCON')) filesep 'Example data CON XLS'];
mkdir(data_dir);

% Brain Atlas
ba = ImporterBrainAtlasXLS('FILE', 'desikan_atlas.xlsx');
ExporterBrainAtlasXLS('FILE', [data_dir filesep() 'desikan_atlas.xlsx'])
N = ba.get('LENGTH');

% Group 1
K1 = 2; % degree (mean node degree is 2K) - group 1
beta1 = 0.3; % Rewiring probability - group 1
for i = 1:1:50 % subject number
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

    gr1_dir = [data_dir filesep() 'CON_Group_1_XLS'];
    mkdir(gr1_dir);
    writetable(array2table(A1), [gr1_dir filesep() 'SubjectCON_' num2str(i) '.xlsx'], 'WriteRowNames', false, 'WriteVariableNames', false)
end

% Group 2
K2 = 2; % degree (mean node degree is 2K) - group 2
beta2 = 0.85; % Rewiring probability - group 2
for i = 1:1:50
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

    gr2_dir = [data_dir filesep() 'CON_Group_2_XLS'];
    mkdir(gr2_dir);
    writetable(array2table(A2), [gr2_dir filesep() 'SubjectCON_' num2str(i) '.xlsx'], 'WriteRowNames', false, 'WriteVariableNames', false)
end

%%% ¡test!
%%%% ¡name!
GUI
%%%% ¡probability!
.01
%%%% ¡parallel!
false
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('SubjectCON')) filesep 'example data CON' filesep 'desikan_atlas.xlsx']);
ba = im_ba.get('BA');
im_gr = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectCON')) filesep 'example data CON' filesep 'xls' filesep 'CON_Group_1'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr = im_gr.get('GR');

gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')