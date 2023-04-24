%% ¡header!
ImporterGroupSubjectFUN_MP_TXT < Importer (im, importer of FUN MP subject group from TXT) imports a group of subjects with functional multiplex data from an TXT file.

%%% ¡description!
ImporterGroupSubjectFUN_MP_TXT imports a group of subjects with functional multiplex data from an TXT file and their covariates (optional) from another TXT file.
All these files must be in the same folder; also, no other files should be in the folder.
Each TXT file contains a table with each row correspoding to a time serie and each column to a brain region.
The TXT file containing the covariates must be in the same group directory 
and consists of the following columns:
Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.

%%% ¡seealso!
Group, SubjectFUN_MP, ExporterGroupSubjectFUN_MP_TXT

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the FUN MP subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectFUN_MP_TXT'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the FUN MP subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectFUN_MP_TXT imports a group of subjects with functional multiplex data from an TXT file and their covariates (optional) from another TXT file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the FUN MP subject group importer from TXT.

%%% ¡prop!
ID (data, string) is a few-letter code for the FUN MP subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectFUN_MP_TXT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the FUN MP subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectFUN_MP_TXT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the FUN MP subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectFUN_MP_TXT notes'

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the FUN MP subject group files from which to load the L layers of the subject group.
%%%% ¡default!
fileparts(which('test_braph2'))

%%% ¡prop!
GET_DIR (query, item) opens a dialog box to set the directory from where to load the TXT files of the FUN MP subject group with L layers.
%%%% ¡settings!
'ImporterGroupSubjectFUN_MP_TXT'
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
        subject_folders = dir(directory);
        subject_folders = subject_folders([subject_folders(:).isdir] == 1);
        subject_folders = subject_folders(~ismember({subject_folders(:).name}, {'.', '..'}));

        if ~isempty(subject_folders)
            braph2waitbar(wb, .15, 'Loading subject group ...')

% % %             % Check if there are covariates to add (age and sex)
% % %             file_cov = dir(fullfile(directory, '*.txt'));
% % %             if isfile(fullfile(directory, file_cov.name))
% % %                 raw_covariates = readtable([directory filesep() file_cov.name], 'Delimiter', '	');
% % %                 age = raw_covariates{:, 2};
% % %                 sex = raw_covariates{:, 3};
% % %             else
% % %                 age = ones(subject_folders, 1);
% % %                 unassigned =  {'unassigned'};
% % %                 sex = unassigned(ones(length(subject_folders), 1));
% % %             end

            % get all layers per subject folder
            for i = 1:1:length(subject_folders)
                braph2waitbar(wb, .25 + .75 * i / length(subject_folders), ['Loading subject ' num2str(i) ' of ' num2str(length(subject_folders)) ' ...'])

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
                if ba.get('BR_DICT').get('LENGTH') ~= br_number
                    ba = BrainAtlas();
                    idict = ba.get('BR_DICT');
                    for j = 1:1:br_number
                        br_id = ['br' int2str(j)];
                        br = BrainRegion('ID', br_id);
                        idict.add(br)
                    end
                    ba.set('br_dict', idict);
                end

                sub_dict = gr.get('SUB_DICT');

                sub = SubjectFUN_MP( ...
                    'ID', subject_folders(i).name, ...
                    'BA', ba, ...
                    'L', length(files), ...
                    'FUN_MP', FUN_MP, ... % % % 'age', age(i), ... % % % 'sex', sex{i} ...
                    );

                sub_dict.get('ADD', sub);
            end
            gr.set('sub_dict', sub_dict);
        end
    catch e
        braph2waitbar(wb, 'close')
        
        rethrow(e)
    end
    
    braph2waitbar(wb, 'close')
else
    error([BRAPH2.STR ':ImporterGroupSubjectFUN_TXT:' BRAPH2.CANCEL_IO], ...
        [BRAPH2.STR ':ImporterGroupSubjectFUN_TXT:' BRAPH2.CANCEL_IO '\\n' ...
        'The prop DIRECTORY must be an existing directory, but it is ''' directory '''.'] ...
        );
end

value = gr;

%% ¡tests!

%%% ¡excluded_props!
[ImporterGroupSubjectFUN_MP_TXT.GET_DIR]