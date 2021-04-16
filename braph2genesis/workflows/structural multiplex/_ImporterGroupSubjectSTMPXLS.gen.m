%% ¡header!
ImporterGroupSubjectSTMPXLS < Importer (im, importer of ST MP subject group from XLS/XLSX) imports a group of subjects with structural multiplex data from an XLS/XLSX file.

%%% ¡description!
ImporterGroupSubjectSTMPXLS imports a group of subjects with structural multiplex data from an XLS/XLSX file.
The XLS/XLSX file consists of the following columns: 
Group ID (column 1), Group LABEL (column 2), Group NOTES (column 3) and
BrainRegions (column 4-end; one brainregion value per column).
The first row contains the headers and each subsequent row the values for each subject.

%%% ¡seealso!
Element, Importer, ExporterGroupSubjectSTMPXLS

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the ST MP subject group files from which to load the N layers of the subject group.

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
if isfolder(directory)
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
        br_number = size(raw_tmp, 2) - 3;
        subjects_number = size(raw_tmp, 1) - 3;
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
            raw = xlsread(fullfile(directory, files(i).name));
            if i == 1  % just 1 time
                % info
                subjects_info(:, :) = raw{:, 1:3};
                % covariates = xlsread(fullfile(directory, files(k).name), 'Sheet', 2, 'ReadVariableNames', 1);
            end
            % multiplex data
            data = raw{:, 4: size(raw_tmp, 2)};  % we remove id, lbl, notes (column 1 to 3)
            all_subjects_data(i, :, :) = reshape(num2cell(data), [1 subjects_number br_number]);
        end
        
        % cycle over subjects, add subjects
        for i = 1:1:size(all_subjects_data, 2)
            layer_subject = reshape(all_subjects_data(:, i, :), [layers_number br_number]);
            for l = 1:1:layers_number
                ST_MP(l) = {layer_subject(l, :)'};
            end
            
            % transform covariates table to useful arrays
%             cov_keys = covariates.Properties.VariableNames;
%             cov_vals = table2array(covariates);
%             for j = 1:1:length(cov_keys)
%                 covs{1, j} = cov_keys{j}; %#ok<AGROW>
%                 covs{2, j} = cov_vals(i, j); %#ok<AGROW>
%             end
            
            % create subject
            sub = SubjectST_MP( ...
                'ID', subjects_info(i, 1), ...
                'LABEL', subjects_info(i, 2), ...
                'NOTES', subjects_info(i, 3), ...
                'BA', ba, ...
                'ST_MP', ST_MP, ...
                'N', layers_number ...
            );
            subdict.add(sub);
        end
        gr.set('sub_dict', subdict);
    end
end

value = gr;

%% ¡methods!
function uigetdir(im)
    % UIGETDIR opens a dialog box to set the directory from where to load the XLS/XLSX files of the ST MP subject group with N layers.

    directory = uigetdir('Select directory');
    if isfolder(directory)
        im.set('DIRECTORY', directory);
    end
end