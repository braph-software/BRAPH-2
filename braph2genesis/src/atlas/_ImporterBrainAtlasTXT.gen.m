%% ¡header!
ImporterBrainAtlasTXT < Importer (im, importer of brain atlas from TXT) imports a brain atlas from a TXT file.

%%% ¡description!
ImporterBrainAtlasTXT imports a brain atlas from a TXT file.
The TXT file consists of 6 columns. It reads as follows: 
BrainAtlas ID (column 1), BrainAtlas LABEL (column 2), 
BrainRegions (column 3-5; coordinates x, y, z, one per column) and 
BrainAtlas NOTES (column 6). Each column is separated by tabs.
It throws an error is problems occur during the import.

%%% ¡seealso!
Element, Importer, ExporterBrainAtlasTXT.

%% ¡props!

%%% ¡prop!
FILE (data, string) is the TXT file from where to load the brain atlas.

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
file = im.get('FILE');
if ~isfile(file) && ~braph2_testing()
    im.uigetfile()
    file = im.memorize('FILE');
end
if isfile(file)
    if im.get('WAITBAR')
        wb = waitbar(0, 'Reading brain atlas file ...', 'Name', BRAPH2.NAME);
        set_braph2icon(wb)
    end

    try
        raw = textread(file, '%s', 'delimiter', '\t', 'whitespace', '');
        raw = raw(~cellfun('isempty', raw));  % remove empty cells
        
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
        
        for i = 4:6:size(raw, 1)
            if im.get('WAITBAR')
                waitbar(.30 + .70 * i / size(raw, 1), wb, ['Loading brain region ' num2str((i - 4) / 6 + 1) ' of ' num2str((size(raw, 1) - 3) / 6) ' ...'])
            end
            
            br = BrainRegion( ...
                'ID', char(raw{i, 1}), ...
                'LABEL', char(raw{i+1, 1}), ...
                'X', str2double(raw{i+2, 1}), ...
                'Y', str2double(raw{i+3, 1}), ...
                'Z', str2double(raw{i+4, 1}), ...
                'NOTES', char(raw{i+5, 1}) ...
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
    error([BRAPH2.STR ':ImporterBrainAtlasTXT: ' BRAPH2.BUG_IO]);
end

value = ba;

%% ¡methods!
function uigetfile(im)
    % UIGETFILE opens a dialog box to get the TXT file from where to load the brain atlas.
    
    [filename, filepath, filterindex] = uigetfile('*.txt', 'Select TXT file');
    if filterindex
        file = [filepath filename];
        im.set('FILE', file);
    end
end