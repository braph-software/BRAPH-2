%% ¡header!
ImporterBrainAtlasXLS < Importer (im, importer of brain atlas from XLS/XLSX) imports a brain atlas from an XLS/XLSX file.

%%% ¡description!
ImporterBrainAtlasXLS imports a brain atlas from an XLS/XLSX file.

%%% ¡seealso!
Element, Importer, ImporterBrainAtlasTXT.

%% ¡props!

%%% ¡prop!
FILE (data, string) is the XLS/XLSX file from where to load the brain atlas.

%%% ¡prop!
BA (result, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'
%%%% ¡default!
BrainAtlas()
%%%% ¡calculate!
% creates empty BrainAtlas
ba = BrainAtlas();

% analyzes file
file = im.memorize('FILE');
if isfile(file)
    [~, ~, raw] = xlsread(file);

    % adds props
    ba.set( ...
        'ID', raw{1, 1}, ...
        'LABEL', raw{2, 1}, ...
        'NOTES', raw{3, 1} ...
        );
    
     idict = ba.get('BR_DICT');

    % adds brain regions
    for i = 5:1:size(raw, 1)
        br = BrainRegion( ...
            'ID', raw{i, 1}, ...
            'LABEL', raw{i, 2}, ...
            'X', raw{i, 3}, ...
            'Y', raw{i, 4}, ...
            'Z', raw{i, 5}, ...
            'NOTES', raw{i, 6} ...
        );
       idict.add(br);
    end
    ba.set('br_dict', idict);
end

value = ba;

%% ¡methods!
function uigetfile(im)
    % UIGETFILE opens a dialog box to set the XLS/XLSX file where to save the brain atlas.
    
    [filename, filepath, filterindex] = uigetfile({'*.xlsx';'*.xls'}, 'Select Excel file');
    if filterindex
        file = [filepath filename];
        im.set('FILE', file);
    end
end