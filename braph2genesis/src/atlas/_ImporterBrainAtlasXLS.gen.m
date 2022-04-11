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
    if im.get('WAITBAR')
        wb = waitbar(0, 'Reading File ...', 'Name', BRAPH2.NAME);
        set_braph2icon(wb)
    end

    try
        [~, ~, raw] = xlsread(file);
        
        % adds props
        if im.get('WAITBAR')
            waitbar(.15, wb, 'Loading brain atlas file ...');
        end
        
        ba.set( ...
            'ID', raw{1, 1}, ...
            'LABEL', raw{2, 1}, ...
            'NOTES', raw{3, 1} ...
            );
        
        idict = ba.get('BR_DICT');
        
        % adds brain regions
        if im.get('WAITBAR')
            waitbar(.30, wb, 'Extracting brain regions ...')
        end
        
        for i = 5:1:size(raw, 1)
            if im.get('WAITBAR')
                waitbar(.30 + .70 * (i - 4) / (size(raw, 1) - 4), wb, ['Loading brain region ' num2str(i - 4) ' of ' num2str(size(raw, 1) - 4) ' ...'])
            end
            
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
        if im.get('WAITBAR')
            close(wb)
        end
        
        rethrow(e)
    end
    
    if im.get('WAITBAR')
        close(wb)
    end
elseif ~braph2_testing()
    error(BRAPH2.IM_ERR);
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