%% ¡header!
ImporterGroupSubjectCONXLS < Importer (im, importer of CON subject group from XLS/XLSX) imports a group of subjects with connectivity data from a series of XLS/XLSX file.

%%% ¡description!
ImporterGroupSubjectCONXLS imports a group of subjects with connectivity data from a series of XLS/XLSX file and their covariates from another XLS/XLSX file.
All these files must be in the same folder; also, no other files should be in the folder.
Each file contains a table of values corresponding to the adjacency matrix.
The XLS/XLSX file containing the covariates must be inside another folder in the same directory 
than file with data and consists of of the following columns:
Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.

%%% ¡seealso!
Element, Importer, ExporterGroupSubjectCONXLS

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the CON subject group files from which to load the subject group.

%%% ¡prop!
FILE_COVARIATES (data, string) is the XLS/XLSX file from where to load the covariates age and sex of the CON subject group.
%%%% ¡default!
''

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

    % analyzes file
    files_XLSX = dir(fullfile(directory, '*.xlsx'));
    files_XLS = dir(fullfile(directory, '*.xls'));
    files = [files_XLSX; files_XLS];

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
end

value = gr;

%% ¡methods!
function uigetdir(im)
    % UIGETDIR opens a dialog box to set the directory from where to load the XLS/XLSX files of the CON subject group.

    directory = uigetdir('Select directory');
    if isfolder(directory)
        im.set('DIRECTORY', directory);
    end
end

function uigetfile(im)
    % UIGETFILE opens a dialog box to set the XLS/XLSX file from where to load the covariates of CON subject group.
    
    [filename, filepath, filterindex] = uigetfile({'*.xlsx';'*.xls'}, 'Select Excel file');
    if filterindex
        file = [filepath filename];
        im.set('FILE', file);
    end
end