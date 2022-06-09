%% ¡header!
ImporterBrainAtlasXLS < Importer (im, importer of brain atlas from XLS/XLSX) imports a brain atlas from an XLS/XLSX file.

%%% ¡description!
ImporterBrainAtlasXLS imports a brain atlas from an XLS/XLSX file.
The TXT file consists of 6 columns. It reads as follows: 
BrainAtlas ID (column 1), BrainAtlas LABEL (column 2),
BrainRegions (column 3-5; coordinates x, y, z, one per column) and 
BrainAtlas NOTES (column 6).
It will throw an error is problems occur during the import.
It throws an error is problems occur during the import.

%%% ¡seealso!
Element, Importer, ExporterBrainAtlasXLS.

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
if ~isfile(file) && ~braph2_testing()
    im.uigetfile()
    file = im.memorize('FILE');
end

if isfile(file)
    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading File ...');

    try
        [~, ~, raw] = xlsread(file);
        
        % adds props
        braph2waitbar(wb, .15, 'Loading brain atlas file ...');
        
        ba.set( ...
            'ID', raw{1, 1}, ...
            'LABEL', raw{2, 1}, ...
            'NOTES', raw{3, 1} ...
            );
        
        idict = ba.get('BR_DICT');
        
        % adds brain regions
        braph2waitbar(wb, .30, 'Extracting brain regions ...')
        
        for i = 5:1:size(raw, 1)
            braph2waitbar(wb, .30 + .70 * (i - 4) / (size(raw, 1) - 4), ['Loading brain region ' num2str(i - 4) ' of ' num2str(size(raw, 1) - 4) ' ...'])
            
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
    catch e
        braph2waitbar(wb, 'close')

        rethrow(e)
    end
    
    braph2waitbar(wb, 'close')
elseif ~braph2_testing()
    error([BRAPH2.STR ':ImporterBrainAtlasXLS:' BRAPH2.BUG_IO]);
end

value = ba;

%% ¡methods!
function uigetfile(im)
    % UIGETFILE opens a dialog box to get the XLS/XLSX file from where to load the brain atlas.
    
    [filename, filepath, filterindex] = uigetfile({'*.xlsx';'*.xls'}, 'Select Excel file');
    if filterindex
        file = [filepath filename];
        im.set('FILE', file);
    end
end