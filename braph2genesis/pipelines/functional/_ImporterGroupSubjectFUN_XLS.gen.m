%% ¡header!
ImporterGroupSubjectFUN_XLS < Importer (im, importer of FUN subject group from XLS/XLSX) imports a group of subjects with functional data from a series of XLS/XLSX file.

%%% ¡description!
ImporterGroupSubjectFUN_XLS imports a group of subjects with functional data from a series of XLS/XLSX file and their covariates (optional) from another XLS/XLSX file.
All these files must be in the same folder; also, no other files should be in the folder.
Each file contains a table with each row correspoding to a time serie and each column to a brain region.
The XLS/XLSX file containing the covariates must be inside another folder in the same group directory 
and consists of the following columns:
Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.

%%% ¡seealso!
Element, Importer, ExporterGroupSubjectFUN_XLS

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the FUN subject group files from which to load the subject group.

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
if ~isfolder(directory)&& ~braph2_testing()
    im.uigetdir()
    directory = im.get('DIRECTORY');
end
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
        files_XLSX = dir(fullfile(directory, '*.xlsx'));
        files_XLS = dir(fullfile(directory, '*.xls'));
        files = [files_XLSX; files_XLS];

        % Check if there are covariates to add (age and sex)
        cov_folder = dir(directory);
        cov_folder = cov_folder([cov_folder(:).isdir] == 1);
        cov_folder = cov_folder(~ismember({cov_folder(:).name}, {'.', '..'}));
        if ~isempty(cov_folder)
            file_cov_XLSX = dir(fullfile([directory filesep() cov_folder.name], '*.xlsx'));
            file_cov_XLS = dir(fullfile([directory filesep() cov_folder.name], '*.xls'));
            file_cov = [file_cov_XLSX; file_cov_XLS];
            [~, ~, raw_covariates] = xlsread(fullfile([directory filesep() cov_folder.name], file_cov.name));
            age = raw_covariates(2:end, 2);
            sex = raw_covariates(2:end, 3);
        else
            age = {[0]};
            age = age(ones(length(files), 1));
            unassigned =  {'unassigned'};
            sex = unassigned(ones(length(files), 1));
        end
        
        braph2waitbar(wb, .15, 'Loading subject group ...')

        if length(files) > 0

            % adds subjects
            for i = 1:1:length(files)
                braph2waitbar(wb, .30 + .70 * i / length(files), ['Loading subject ' num2str(i) ' of ' num2str(length(files)) ' ...'])

                % read file
                FUN = xlsread(fullfile(directory, files(i).name));

                % brain atlas
                ba = im.get('BA');
                br_number = size(FUN, 2);
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
                [~, sub_id] = fileparts(files(i).name);
                sub = SubjectFUN( ...
                    'ID', sub_id, ...
                    'BA', ba, ...
                    'age', age{i}, ...
                    'sex', sex{i} ...
                    );

                sub.set('FUN', FUN);
                subdict.add(sub);
            end
            gr.set('sub_dict', subdict);
        end
    catch e
        braph2waitbar(wb, 'close')
        
        rethrow(e)
    end
    
    braph2waitbar(wb, 'close')
    
elseif ~braph2_testing()
    error([BRAPH2.STR ':ImporterGroupSubjectFUN_XLS: ' BRAPH2.BUG_IO]);
end

value = gr;

%% ¡methods!
function uigetdir(im)
    % UIGETDIR opens a dialog box to set the directory from where to load the XLS/XLSX files of the FUN subject group.

    directory = uigetdir('Select directory');
    if ischar(directory) && isfolder(directory)
        im.set('DIRECTORY', directory);
    end
end