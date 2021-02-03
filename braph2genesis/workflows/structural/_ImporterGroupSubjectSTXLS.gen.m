%% ¡header!
ImporterGroupSubjectSTXLS < Importer (im, importer of ST subject group from XLS/XLSX) imports a group of subjects with structural data from an XLS/XLSX file.

%%% ¡description!
ImporterGroupSubjectSTXLS imports a group of subjects with structural data from an XLS/XLSX file.
The XLS/XLSX file consists of 6 columns. It reads as follows: 
Group ID (column 1), Group LABEL (column 2), Group NOTES (column 3) and
BrainRegions (column 4-end; one brainregion value per column).

%%% ¡seealso!
Element, Importer, ExporterGroupSubjectSTXLS.

%% ¡props!

%%% ¡prop!
FILE (data, string) is the XLS/XLSX file from where to load the ST subject group.
%%%% ¡default!
''

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'
%%%% ¡default!
BrainAtlas()

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
if isfile(file)
    [~, ~, raw] = xlsread(file);

    % sets group props
    [~, name, ext] = fileparts(file);
    gr.set( ...
        'ID', [name], ...
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
            'ST', ST ...
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