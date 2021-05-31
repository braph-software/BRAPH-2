%% ¡header!
ImporterGroupSubjectFUNMPTXT < Importer (im, importer of FUN MP subject group from TXT) imports a group of subjects with functional multiplex data from an TXT file.

%%% ¡description!
ImporterGroupSubjectFUNMPTXT imports a group of subjects with functional multiplex data from an TXT file and their covariates (optional) from another TXT file.
All these files must be in the same folder; also, no other files should be in the folder.
Each TXT file contains a table with each row correspoding to a time serie and each column to a brain region.
The TXT file containing the covariates must be in the same group directory 
and consists of the following columns:
Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.

%%% ¡seealso!
Element, Importer, ExporterGroupSubjectFUNMPTXT

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the FUN MP subject group files from which to load the L layers of the subject group.

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
        file_cov = dir(fullfile(directory, '*.txt'));
        if isfile(fullfile(directory, file_cov.name))
            raw_covariates = readtable([directory filesep() file_cov.name], 'Delimiter', '	');
            age = raw_covariates{:, 2};
            sex = raw_covariates{:, 3};
        else
            age = ones(subjects_number,1);
            unassigned =  {'unassigned'};
            sex = unassigned(ones(length(subject_folders), 1));
        end
        
        % get all layers per subject folder
        waitbar(.45, f, 'Processing your data ...')
        for i = 1:1:length(subject_folders)
            if i == floor(length(subject_folders)/2)
                 waitbar(.70, f, 'Almost there ...')  
            end
            subjects_paths = [directory filesep() subject_folders(i).name];
            % analyzes file
            files = dir(fullfile(subjects_paths, '*.txt'));
            
            FUN_MP = cell(1, length(files));
            % get all layers per subject folder
            for j = 1:1:length(files)
                FUN_MP(j) = {table2array(readtable(fullfile(subjects_paths, files(j).name), 'Delimiter', '	'))};
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
    % UIGETDIR opens a dialog box to set the directory from where to load the TXT files of the FUN MP subject group with L layers.

    directory = uigetdir('Select directory');
    if isfolder(directory)
        im.set('DIRECTORY', directory);
    end
end