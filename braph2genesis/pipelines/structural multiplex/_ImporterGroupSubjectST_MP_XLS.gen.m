%% ¡header!
ImporterGroupSubjectST_MP_XLS < Importer (im, importer of ST MP subject group from XLS/XLSX) imports a group of subjects with structural multiplex data from a series of XLS/XLSX files.

%%% ¡description!
ImporterGroupSubjectST_MP_XLS imports a group of subjects with structural multiplex data and their covariates (optional) from a series of XLS/XLSX file.
The files from the same group containing the data from L layers must be in the same folder.
Each XLS/XLSX file consists of the following columns: 
Subject ID (column 1), Subject LABEL (column 2), Subject NOTES (column 3) and
BrainRegions of that layer (column 4-end; one brainregion value per column).
The first row contains the headers and each subsequent row the values for each subject.
The covariates must be on the second Sheet of the XLS/XLSX file containing data from layer 1. 
Sheet 2 consists of the following columns:
Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.

%%% ¡seealso!
Group, SubjectST_MP, ExporterGroupSubjectST_MP_XLS

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the ST MP subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectST_MP_XLS'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ST MP subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectST_MP_XLS imports a group of subjects with structural multiplex data and their covariates (optional) from a series of XLS/XLSX file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ST MP subject group importer from XLS/XLSX.

%%% ¡prop!
ID (data, string) is a few-letter code for the ST MP subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectST_MP_XLS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ST MP subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectST_MP_XLS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ST MP subject group importer from XLS/XLSX.
%%%% ¡default!
'ImporterGroupSubjectST_MP_XLS notes'

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the ST MP subject group files from which to load the L layers of the subject group.
%%%% ¡default!
fileparts(which('test_braph2'))

%%% ¡prop!
GET_DIR (query, item) opens a dialog box to set the directory from where to load the XLS/XLSX files of the ST MP subject group with L layers.
%%%% ¡settings!
'ImporterGroupSubjectST_MP_XLS'
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
        % analyzes files
        files_XLSX = dir(fullfile(directory, '*.xlsx'));
        files_XLS = dir(fullfile(directory, '*.xls'));
        files = [files_XLSX; files_XLS];

        if ~isempty(files)
            % brain atlas
            ba = im.get('BA');
            raw_tmp = xlsread(fullfile(directory, files(1).name));
            br_number = size(raw_tmp, 2) ;
            subjects_number = size(raw_tmp, 1);
            if ba.get('BR_DICT').get('LENGTH') ~= br_number
                ba = BrainAtlas();
                idict = ba.get('BR_DICT');
                for j = 1:1:br_number
                    br_id = ['br' int2str(j)];
                    br = BrainRegion('ID', br_id);
                    idict.get('ADD', br)
                end
                ba.set('br_dict', idict);
            end

            braph2waitbar(wb, .15, 'Loading subject group ...');

            sub_dict = gr.get('SUB_DICT');

% % %             % Check if there are covariates to add (age and sex)
% % %             sheets = sheetnames(fullfile(directory, files(1).name));
% % %             if length(sheets) > 1
% % %                 [~, ~, raw_covariates] = xlsread(fullfile(directory, files(1).name), 2);
% % %                 age = raw_covariates(2:end, 2);
% % %                 sex = raw_covariates(2:end, 3);
% % %             else
% % %                 age = {[0]};
% % %                 age = age(ones(subjects_number, 1));
% % %                 unassigned =  {'unassigned'};
% % %                 sex = unassigned(ones(subjects_number, 1));
% % %             end

            % multiplex data, subjects, number of layers
            all_subjects_data = cell(length(files), subjects_number, br_number);
            subjects_info = cell(subjects_number, 3);
            layers_number = length(files);

            for i = 1:1:length(files)
                [~, ~, raw] = xlsread(fullfile(directory, files(i).name));
                if i == 1  % just 1 time
                    % info
                    subjects_info(:, :) = raw(2:end, 1:3);
                end
                % multiplex data
                data = raw(2:end, 4: size(raw, 2));  % we remove id, labl, notes (column 1 to 3)
                all_subjects_data(i, :, :) = reshape(data, [1 subjects_number br_number]);
            end

            % cycle over subjects, add subjects
            for i = 1:1:size(all_subjects_data, 2)
                braph2waitbar(wb, .25 + .75 * i / size(all_subjects_data, 2), ['Loading subject ' num2str(i) ' of ' num2str(size(all_subjects_data, 2)) ' ...'])

                layer_subject = reshape(all_subjects_data(:, i, :), [layers_number br_number]);
                for l = 1:1:layers_number
                    ST_MP(l) = {cell2mat(layer_subject(l, :)')};
                end

                % create subject
                sub = SubjectST_MP( ...
                    'ID', num2str(subjects_info{i, 1}), ...
                    'LABEL', num2str(subjects_info{i, 2}), ...
                    'NOTES', num2str(subjects_info{i, 3}), ...
                    'BA', ba, ...
                    'L', layers_number, ...
                    'ST_MP', ST_MP, ... % % % 'age', age{i}, ... % % % 'sex', sex{i} ...
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
    error([BRAPH2.STR ':ImporterGroupSubjectST_MP_XLS:' BRAPH2.CANCEL_IO], ...
        [BRAPH2.STR ':ImporterGroupSubjectST_MP_XLS:' BRAPH2.CANCEL_IO '\\n' ...
        'The prop DIRECTORY must be an existing directory, but it is ''' directory '''.'] ...
        );
end

value = gr;

%% ¡tests!

%%% ¡excluded_props!
[ImporterGroupSubjectST_MP_XLS.GET_DIR]