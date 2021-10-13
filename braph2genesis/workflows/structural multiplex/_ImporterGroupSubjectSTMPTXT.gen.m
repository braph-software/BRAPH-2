%% ¡header!
ImporterGroupSubjectSTMPTXT < Importer (im, importer of ST MP subject group from TXT) imports a group of subjects with structural multiplex data from an TXT file.

%%% ¡description!
ImporterGroupSubjectSTMPTXT imports a group of subjects with structural multiplex data from an TXT file and their covariates from another TXT file.
The files from the same group containing the data from L layers must be in the same folder.
Each TXT file consists of the following columns: 
Group ID (column 1), Group LABEL (column 2), Group NOTES (column 3) and
BrainRegions of that layer (column 4-end; one brainregion value per column).
The first row contains the headers and each subsequent row the values for each subject.
The TXT file containing the covariates must be inside another folder in the same group directory 
than file with data and consists of the following columns:
Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.

%%% ¡seealso!
Element, Importer, ExporterGroupSubjectSTMPTXT

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the ST MP subject group files from which to load the L layers of the subject group.

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
directory = im.get('DIRECTORY');
if ~isfolder(directory) && ~is_braph_testing()
    im.uigetdir()
    directory = im.get('DIRECTORY');
end
if isfolder(directory)
    % sets group props
    f = waitbar(0, 'Reading Directory ...', 'Name', BRAPH2.NAME, 'Visible', 'off');
    set_icon(f)
    set(f, 'Visible', 'on');
    [~, name] = fileparts(directory);
    gr.set( ...
        'ID', name, ...
        'LABEL', name, ...
        'NOTES', ['Group loaded from ' directory] ...
    );

    % analyzes files
    files = dir(fullfile(directory, '*.txt'));
    
    if length(files) > 0
        % brain atlas
        ba = im.get('BA');
        raw_tmp = readtable(fullfile(directory, files(1).name), 'Delimiter', '	');
        br_number = size(raw_tmp, 2) - 3;
        subjects_number = size(raw_tmp, 1);
        if ba.get('BR_DICT').length ~= br_number
            ba = BrainAtlas();
            idict = ba.get('BR_DICT');
            for j = 1:1:br_number
                br_id = ['br' int2str(j)];
                br = BrainRegion('ID', br_id);
                idict.add(br)
            end
            ba.set('br_dict', idict);
        end
        waitbar(.15, f, 'Loading your Group ...');
        subdict = gr.get('SUB_DICT');
        
        % Check if there are covariates to add (age and sex)
        cov_folder = dir(directory);
        cov_folder = cov_folder([cov_folder(:).isdir] == 1);
        cov_folder = cov_folder(~ismember({cov_folder(:).name}, {'.', '..'}));
        if ~isempty(cov_folder)
            raw_covariates = readtable([directory filesep() cov_folder.name filesep() name '_covariates.txt'], 'Delimiter', '\t');
            age = raw_covariates{:, 2};
            sex = raw_covariates{:, 3};
        else
            age = ones(subjects_number,1);
            unassigned =  {'unassigned'};
            sex = unassigned(ones(subjects_number, 1));
        end

        % multiplex data, subjects, number of layers
        waitbar(.45, f, 'Loading your Group ...')
        all_subjects_data = cell(length(files), subjects_number, br_number);
        subjects_info = cell(subjects_number, 3);
        layers_number = length(files);
        
        for i = 1:1:length(files)
            raw = readtable(fullfile(directory, files(i).name), 'Delimiter', '	');
            if i == 1  % just 1 time
                % info
                subjects_info(:, :) = table2cell(raw(:, 1:3));
            end
            % multiplex data
            data = table2cell(raw(:, 4: size(raw, 2)));  % we remove id, labl, notes (column 1 to 3)
            all_subjects_data(i, :, :) = reshape(data, [1 subjects_number br_number]);
        end
                            
        % cycle over subjects, add subjects
        for i = 1:1:size(all_subjects_data, 2)
            waitbar(.5, f, ['Loading your Subject: ' num2str(i) '/' num2str(size(all_subjects_data, 2) - 1) ' ...'])
            layer_subject = reshape(all_subjects_data(:, i, :), [layers_number br_number]);
            for l = 1:1:layers_number
                ST_MP(l) = {cell2mat(layer_subject(l, :)')};
            end
            
            % create subject
            sub = SubjectST_MP( ...
                'ID', subjects_info{i, 1}, ...
                'LABEL', subjects_info{i, 2}, ...
                'NOTES', subjects_info{i, 3}, ...
                'BA', ba, ...
                'L', layers_number, ...
                'ST_MP', ST_MP, ...
                'age', age(i), ...
                'sex', sex{i} ...
                );
            subdict.add(sub);
        end
        gr.set('sub_dict', subdict);
    end
end
if exist('f', 'var')
    waitbar(1, f, 'Finishing')
    pause(.5)
    close(f)
end
value = gr;

%% ¡methods!
function uigetdir(im)
    % UIGETDIR opens a dialog box to set the directory from where to load the TXT files of the ST MP subject group with L layers.

    directory = uigetdir('Select directory');
    if isfolder(directory)
        im.set('DIRECTORY', directory);
    end
end

function uigetfile(im)
    % UIGETFILE opens a dialog box to set the TXT file from where to load the ST MP subject group.
    
    [filename, filepath, filterindex] = uigetfile('*.txt', 'Select TXT file');
    if filterindex
        file = [filepath filename];
        im.set('FILE', file);
    end
end