%% ¡header!
ImporterGroupSubjectFUN_TXT < Importer (im, importer of FUN subject group from TXT) imports a group of subjects with connectivity data from a series of TXT file.

%%% ¡description!
ImporterGroupSubjectFUN_TXT imports a group of subjects with connectivity data from a series of TXT file and their covariates (optional) from another TXT file.
All these files must be in the same folder; also, no other files should be in the folder.
Each file contains a table with each row correspoding to a time serie and each column to a brain region.
The TXT file containing the covariates must be inside another folder in the same group directory 
and consists of the following columns:
Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.

%%% ¡seealso!
Group, SubjectFUN, ExporterGroupSubjectFUN_TXT

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the FUN subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectFUN_TXT'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the FUN subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectFUN_TXT imports a group of subjects with connectivity data from a series of TXT file and their covariates (optional) from another TXT file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the FUN subject group importer from TXT.

%%% ¡prop!
ID (data, string) is a few-letter code for the FUN subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectFUN_TXT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the FUN subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectFUN_TXT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the FUN subject group importer from TXT.
%%%% ¡default!
'ImporterGroupSubjectFUN_TXT notes'

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the FUN subject group files from which to load the subject group.
%%%% ¡default!
fileparts(which('test_braph2'))

%%% ¡prop!
GET_DIR (query, item) opens a dialog box to set the directory from where to load the TXT files of the FUN subject group.
%%%% ¡settings!
'ImporterGroupSubjectFUN_TXT'
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
        files = dir(fullfile(directory, '*.txt'));
        
% % %         % Check if there are covariates to add (age and sex)
% % %         cov_folder = dir(directory);
% % %         cov_folder = cov_folder([cov_folder(:).isdir] == 1);
% % %         cov_folder = cov_folder(~ismember({cov_folder(:).name}, {'.', '..'}));
% % %         if ~isempty(cov_folder)
% % %             file_cov = dir(fullfile([directory filesep() cov_folder.name], '*.txt'));
% % %             raw_covariates = readtable([directory filesep() cov_folder.name filesep() file_cov.name], 'Delimiter', '	');
% % %             age = raw_covariates{:, 2};
% % %             sex = raw_covariates{:, 3};
% % %         else
% % %             age = ones(length(files), 1);
% % %             unassigned =  {'unassigned'};
% % %             sex = unassigned(ones(length(files), 1));
% % %         end
        
        braph2waitbar(wb, .15, 'Loading subjecy group ...')

        if ~isempty(files)
            % brain atlas
            ba = im.get('BA');
            br_number = ba.get('BR_DICT').get('LENGTH');
            sub_dict = gr.get('SUB_DICT');
            
            % adds subjects
            for i = 1:1:length(files)
                braph2waitbar(wb, .25 + .75 * i / length(files), ['Loading subject ' num2str(i) ' of ' num2str(length(files)) ' ...'])

                % read file
                FUN = table2array(readtable(fullfile(directory, files(i).name), 'Delimiter', '	'));
                
                % brain atlas
                ba = im.get('BA');
                br_number = size(FUN, 2);
                if ba.get('BR_DICT').length ~= br_number
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
                
                [~, sub_id] = fileparts(files(i).name);
                sub = SubjectFUN( ...
                    'ID', sub_id, ...
                    'BA', ba ... % % % 'age', age(i), ... % % % 'sex', sex{i} ...
                    );
                
                sub.set('FUN', FUN);
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
    error([BRAPH2.STR ':ImporterGroupSubjectFUN_TXT:' BRAPH2.CANCEL_IO], ...
        [BRAPH2.STR ':ImporterGroupSubjectFUN_TXT:' BRAPH2.CANCEL_IO '\\n' ...
        'The prop DIRECTORY must be an existing directory, but it is ''' directory '''.'] ...
        );
end

value = gr;

%% ¡tests!

%%% ¡excluded_props!
[ImporterGroupSubjectFUN_TXT.GET_DIR]