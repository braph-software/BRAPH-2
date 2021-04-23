%% ¡header!
ImporterGroupSubjectSTMPXLS < Importer (im, importer of ST MP subject group from XLS/XLSX) imports a group of subjects with structural multiplex data from an XLS/XLSX file.

%%% ¡description!
ImporterGroupSubjectSTMPXLS imports a group of subjects with structural multiplex data from a series of XLS/XLSX file and their covariates from another XLS/XLSX file.
The files from the same group containing the data from L layers must be in the same folder.
Each XLS/XLSX file consists of the following columns: 
Subject ID (column 1), Subject LABEL (column 2), Subject NOTES (column 3) and
BrainRegions of that layer (column 4-end; one brainregion value per column).
The first row contains the headers and each subsequent row the values for each subject.
The XLS/XLSX file containing the covariates must be inside another folder in the same directory 
than file with data and consists of of the following columns:
Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.

%%% ¡seealso!
Element, Importer, ExporterGroupSubjectSTMPXLS

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the ST MP subject group files from which to load the L layers of the subject group.

%%% ¡prop!
FILE_COVARIATES (data, string) is the XLS/XLSX file from where to load the covariates age and sex of the ST MP subject group.
%%%% ¡default!
''

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

directory = im.get('DIRECTORY');
file_covariates = im.memorize('FILE_COVARIATES');
if isfolder(directory)
    % Check if there are covariates to add (age and sex)
    if isfile(file_covariates)
        [~, ~, raw_covariates] = xlsread(file_covariates);
        age = raw_covariates(2:end, 2);
        sex = raw_covariates(2:end, 3);
    else
        age = {[0]};
        age = age(ones(50,1));
        unassigned =  {'unassigned'};
        sex = unassigned(ones(50, 1));
    end
    
    % sets group props
    [~, name] = fileparts(directory);
    gr.set( ...
        'ID', name, ...
        'LABEL', name, ...
        'NOTES', ['Group loaded from ' directory] ...
    );

    % analyzes files
    files_XLSX = dir(fullfile(directory, '*.xlsx'));
    files_XLS = dir(fullfile(directory, '*.xls'));
    files = [files_XLSX; files_XLS];

    if length(files) > 0
        % brain atlas
        ba = im.get('BA');
        raw_tmp = xlsread(fullfile(directory, files(1).name));
        br_number = size(raw_tmp, 2) ;
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

        subdict = gr.get('SUB_DICT');
        
        % multiplex data, subjects, number of layers
        all_subjects_data = cell(length(files), subjects_number, br_number);
        subjects_info = cell(subjects_number, 3);
        layers_number = length(files);
        
        for i = 1:1:length(files)
            [~, ~, raw] = xlsread(fullfile(directory, files(i).name));
            if i == 1  % just 1 time
                % info
                subjects_info(:, :) = raw(2:end, 1:3);
                % covariates = xlsread(fullfile(directory, files(k).name), 'Sheet', 2, 'ReadVariableNames', 1);
            end
            % multiplex data
            data = raw(2:end, 4: size(raw, 2));  % we remove id, labl, notes (column 1 to 3)
            all_subjects_data(i, :, :) = reshape(data, [1 subjects_number br_number]);
        end
        
        % cycle over subjects, add subjects
        for i = 1:1:size(all_subjects_data, 2)
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
                'age', age{i}, ...
                'sex', sex{i} ...
            );
            subdict.add(sub);
        end
        gr.set('sub_dict', subdict);
    end
end

value = gr;

%% ¡methods!
function uigetdir(im)
    % UIGETDIR opens a dialog box to set the directory from where to load the XLS/XLSX files of the ST MP subject group with L layers.

    directory = uigetdir('Select directory');
    if isfolder(directory)
        im.set('DIRECTORY', directory);
    end
end

function uigetfile(im)
    % UIGETFILE opens a dialog box to set the XLS/XLSX file from where to load the covariates of ST MP subject group.
    
    [filename, filepath, filterindex] = uigetfile({'*.xlsx';'*.xls'}, 'Select Excel file');
    if filterindex
        file = [filepath filename];
        im.set('FILE', file);
    end
end