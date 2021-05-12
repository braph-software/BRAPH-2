%% ¡header!
ImporterGroupSubjectFUNMPXLS < Importer (im, importer of FUN MP subject group from XLS/XLSX) imports a group of subjects with functional multiplex data from a series of XLS/XLSX file.

%%% ¡description!
ImporterGroupSubjectFUNMPXLS imports a group of subjects with functional multiplex data from a series of XLS/XLSX file and their covariates from another XLS/XLSX file.
All these files must be in the same folder; also, no other files should be in the folder.
Each file contains a table with each row correspoding to a time serie and each column to a brain region.
The XLS/XLSX file containing the covariates must be inside another folder in the same directory 
than file with data and consists of of the following columns:
Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.

%%% ¡seealso!
Element, Importer, ExporterGroupSubjectFUNMPXLS

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the FUN MP subject group files from which to load the subject group.

%%% ¡prop!
FILE_COVARIATES (data, string) is the XLS/XLSX file from where to load the covariates age and sex of the FUN MP subject group.
%%%% ¡default!
''

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
GR (result, item) is a group of subjects with functional multiplex data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectFUN_MP', [], [], true))); 
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN_MP'))
%%%% ¡calculate!
% creates empty Group
gr = Group( ...
    'SUB_CLASS', 'SubjectFUN_MP', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectFUN_MP') ...
    );

directory = im.get('DIRECTORY');
file_covariates = im.memorize('FILE_COVARIATES');
if isfolder(directory)    
    % sets group props
    f = waitbar(0, 'Reading Directory ...', 'Name', BRAPH2.NAME);
    set_icon(f)
    [~, name] = fileparts(directory);
    gr.set( ...
        'ID', name, ...
        'LABEL', name, ...
        'NOTES', ['Group loaded from ' directory] ...
    );

    subject_folders = dir(directory);
    subject_folders = subject_folders([subject_folders(:).isdir] == 1);
    subject_folders = subject_folders(~ismember({subject_folders(:).name}, {'.', '..'}));
    
    if length(subject_folders) > 0
        waitbar(.15, f, 'Loading your data ...');
        % Check if there are covariates to add (age and sex)
        if isfile(file_covariates)
            [~, ~, raw_covariates] = xlsread(file_covariates);
            age = raw_covariates(2:end, 2);
            sex = raw_covariates(2:end, 3);
        else
            age = {[0]};
            age = age(ones(length(files), 1));
            unassigned =  {'unassigned'};
            sex = unassigned(ones(1, length(subject_folders)));
        end
        
        % get all layers per subject folder
        waitbar(.45, f, 'Processing your data ...')
        for i = 1:1:length(subject_folders)
            if i == floor(length(subjects_folders)/2)
                 waitbar(.70, f, 'Almost there ...')  
            end
            subjects_paths = [directory filesep() subject_folders(i).name];
            % analyzes file
            files_XLSX = dir(fullfile(subjects_paths, '*.xlsx'));
            files_XLS = dir(fullfile(subjects_paths, '*.xls'));
            files = [files_XLSX; files_XLS];
            
            FUN_MP = cell(1, length(files));
            % get all layers per subject folder
            for j = 1:1:length(files)
                FUN_MP(j) = {xlsread(fullfile(subjects_paths, files(j).name))};
            end
            
            % brain atlas
            ba = im.get('BA');
            br_number = size(FUN_MP{1}, 2);
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
            sub = SubjectFUN_MP( ...
                'ID', subject_folders(i).name, ...
                'BA', ba, ...
                'L', length(files), ...
                'FUN_MP', FUN_MP, ...
                'age', age{i}, ...
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
    % UIGETDIR opens a dialog box to set the directory from where to load the XLS/XLSX files of the FUN MP subject group with L layers.

    directory = uigetdir('Select directory');
    if isfolder(directory)
        im.set('DIRECTORY', directory);
    end
end

function uigetfile(im)
    % UIGETFILE opens a dialog box to set the XLS/XLSX file from where to load the covariates of FUN MP subject group.
    
    [filename, filepath, filterindex] = uigetfile({'*.xlsx';'*.xls'}, 'Select Excel file');
    if filterindex
        file = [filepath filename];
        im.set('FILE', file);
    end
end