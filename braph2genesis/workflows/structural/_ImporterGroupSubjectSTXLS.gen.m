%% ¡header!
ImporterGroupSubjectSTXLS < Importer (im, importer of ST subject group from XLS/XLSX) imports a group of subjects with structural data from an XLS/XLSX file.

%%% ¡description!
ImporterGroupSubjectSTXLS imports a group of subjects with structural data from an XLS/XLSX file and their covariates from another XLS/XLSX file.
The XLS/XLSX file consists of the following columns: 
Subject ID (column 1), Subject LABEL (column 2), Subject NOTES (column 3) and
BrainRegions (column 4-end; one brainregion value per column).
The first row contains the headers and each subsequent row the values for each subject.
The XLS/XLSX file containing the covariates must be inside a folder in the same directory 
than file with data and consists of of the following columns:
Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.

%%% ¡seealso!
Element, Importer, ExporterGroupSubjectSTXLS

%% ¡props!

%%% ¡prop!
FILE (data, string) is the XLS/XLSX file from where to load the ST subject group.
%%%% ¡default!
''

%%% ¡prop!
FILE_COVARIATES (data, string) is the XLS/XLSX file from where to load the covariates age and sex of the ST subject group.
%%%% ¡default!
''

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
GR (result, item) is a group of subjects with structural data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectST', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'))
%%%% ¡calculate!
% creates empty Group
gr = Group( ...
    'SUB_CLASS', 'SubjectST', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST') ...
    );

% analyzes file
file = im.memorize('FILE');
file_covariates = im.memorize('FILE_COVARIATES');
if isfile(file)
    [~, ~, raw] = xlsread(file);
    
    % Check if there are covariates to add (age and sex)
    if isfile(file_covariates)
        [~, ~, raw_covariates] = xlsread(file_covariates);
        age = raw_covariates(2:end, 2);
        sex = raw_covariates(2:end, 3);
    else
        age = {[0]};
        age = age(ones(size(raw, 1)-1,1));
        unassigned =  {'unassigned'};
        sex = unassigned(ones(size(raw, 1)-1, 1));
    end
    
    % sets group props
    [~, name, ext] = fileparts(file);
    gr.set( ...
        'ID', name, ...
        'LABEL', [name ext], ...
        'NOTES', ['Group loaded from ' file] ...
    );

    % brain atlas
    ba = im.get('BA');
    br_number = size(raw, 2) - 3;
    if ba.get('BR_DICT').length ~= br_number
        ba = BrainAtlas();
        idict = ba.get('BR_DICT');
        for j = 4:1:length(raw)
            br_id = raw{1, j};
            br = BrainRegion('ID', br_id);
            idict.add(br)
        end
        ba.set('br_dict', idict);
    end

    subdict = gr.get('SUB_DICT');
    
    % adds subjects
    for i = 2:1:size(raw, 1)
        ST = zeros(br_number, 1);
        for j = 1:1:length(ST)
            ST(j) = raw{i, 3 + j};
        end
        sub = SubjectST( ...
            'ID', raw{i, 1}, ...
            'LABEL', raw{i, 2}, ...
            'NOTES', raw{i, 3}, ...
            'BA', ba, ...
            'ST', ST, ...
            'age', age{i-1}, ...
            'sex', sex{i-1} ...
            );
        subdict.add(sub);
    end
    gr.set('sub_dict', subdict);
end

value = gr;

%% ¡methods!
function uigetfile(im)
    % UIGETFILE opens a dialog box to set the XLS/XLSX file from where to load the ST subject group.
    
    [filename, filepath, filterindex] = uigetfile({'*.xlsx';'*.xls'}, 'Select Excel file');
    if filterindex
        file = [filepath filename];
        im.set('FILE', file);
    end
end