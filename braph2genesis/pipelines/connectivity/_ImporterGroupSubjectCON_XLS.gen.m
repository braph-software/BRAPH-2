%% ¡header!
ImporterGroupSubjectCON_XLS < Importer (im, importer of CON subject group from XLS/XLSX) imports a group of subjects with connectivity data from a series of XLS/XLSX file.

%%% ¡description!
ImporterGroupSubjectCON_XLS imports a group of subjects with connectivity data from a series of XLS/XLSX file and their covariates (optional) from another XLS/XLSX file.
All these files must be in the same folder; also, no other files should be in the folder.
Each file contains a table of values corresponding to the adjacency matrix.
The XLS/XLSX file containing the covariates must be inside another folder in the same group directory 
and consists of the following columns:
Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.

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
[fileparts(which('SubjectCON')) filesep 'example data CON' filesep 'xls' filesep 'GroupCON1']

%%% ¡prop!
GET_DIR (query, item) opens a dialog box to set the directory from where to load the XLS/XLSX files of the CON subject group.
%%%% ¡settings!
'ImporterBrainAtlasXLS'
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
if ~isfolder(directory)
    directory = ImporterGroupSubjectCON_XLS.getPropDefault('DIRECTORY');
end

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
            % brain atlas
            ba = im.get('BA');
            br_number = size(xlsread(fullfile(directory, files(1).name)), 1);
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

            % adds subjects
            for i = 1:1:length(files)
                braph2waitbar(wb, .30 + .70 * i / length(files), ['Loading subject ' num2str(i) ' of ' num2str(length(files)) ' ...'])

                % read file
                CON = xlsread(fullfile(directory, files(i).name));
                [~, sub_id] = fileparts(files(i).name);
                sub = SubjectCON( ...
                    'ID', sub_id, ...
                    'BA', ba, ...
                    'age', age{i}, ...
                    'sex', sex{i}, ...
                    'CON', CON ...
                );
                subdict.add(sub);
            end
            gr.set('sub_dict', subdict);
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