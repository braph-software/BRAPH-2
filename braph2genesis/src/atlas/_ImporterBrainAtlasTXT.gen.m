%% ¡header!
ImporterBrainAtlasTXT < Importer (im, importer of brain atlas from TXT) imports a brain atlas from a TXT file.

%%% ¡description!
ImporterBrainAtlasTXT imports a brain atlas from a TXT file.
The TXT file consists of 6 columns and many rows.
The first 4 rows: BrainAtlas ID (row 1, column 1), BrainAtlas LABEL 
(row 2, column 1), BrainAtlas NOTES (row 3, column 1), BrainSurface Name 
(row 4, column 1).
And from row 5 to the end, the following columns: BrainRegion ID (column 1),
BrainRegion LABEL (column 2), BrainRegions (column 3 to column 5; 
coordinates x, y, z, one per column), and BrainRegion NOTES (column 6).

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

if isempty(file) && ~braph2_testing()
    error([BRAPH2.STR ':ImporterBrainAtlasTXT:' BRAPH2.CANCEL_IO], ...
        [BRAPH2.STR ':ImporterBrainAtlasTXT:' BRAPH2.CANCEL_IO]);
elseif isfile(file)
	wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading brain atlas file ...');

    try
        raw = textread(file, '%s', 'delimiter', '\t', 'whitespace', '');
        raw = raw(~cellfun('isempty', raw));  % remove empty cells
        
        % adds props
        braph2waitbar(wb, .15, 'Loading brain atlas file ...')
        
        ba.set( ...
            'ID', raw{1, 1}, ...
            'LABEL', raw{2, 1}, ...
            'NOTES', raw{3, 1} ...
            );
        
        idict = ba.get('BR_DICT');
        
        % adds brain regions
        braph2waitbar(wb, .30, 'Extracting brain regions ...')
        
        for i = 4:6:size(raw, 1)
            braph2waitbar(wb, .30 + .70 * i / size(raw, 1), ['Loading brain region ' num2str((i - 4) / 6 + 1) ' of ' num2str((size(raw, 1) - 3) / 6) ' ...'])
            
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
        braph2waitbar(wb, 'close')
        
        rethrow(e)
    end
    
	braph2waitbar(wb, 'close')
elseif ~braph2_testing()
    error([BRAPH2.STR ':ImporterBrainAtlasTXT:' BRAPH2.BUG_IO], ...
        [BRAPH2.STR ':ImporterBrainAtlasTXT:' BRAPH2.BUG_IO]);
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